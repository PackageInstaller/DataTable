local UIHStarUpInfoNode = class("UIHStarUpInfoNode", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local UINStarUpStarList = require("Game.Hero.NewUI.UpgradeStar.UINStarUpStarList")
local UIHPreviewItem = require("Game.Hero.NewUI.UpgradeStar.UIHPreviewItem")
local cs_MessageCommon = CS.MessageCommon
local eHeroStarUpEnum = require("Game.Hero.NewUI.UpgradeStar.eHeroStarUpEnum")
local previewType = eHeroStarUpEnum.previewType
local previewItemDatas = {
  {
    name = ConfigData:GetTipContent(602),
    preType = previewType.normal
  },
  {
    name = ConfigData:GetTipContent(603),
    preType = previewType.normal
  },
  {
    name = ConfigData:GetTipContent(604),
    preType = previewType.normal
  }
}

function UIHStarUpInfoNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.curStarList = UINStarUpStarList.New()
  self.curStarList:Init(self.ui.obj_CurStarNode)
  self.preStarList = UINStarUpStarList.New()
  self.preStarList:Init(self.ui.obj_NextStarNode)
  self.fragBaseItem = UINBaseItem.New()
  self.fragBaseItem:Init(self.ui.obj_HeroFragBase)
  self.promoteItemPool = UIItemPool.New(UIHPreviewItem, self.ui.obj_PreviewItem)
  self.ui.obj_PreviewItem:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_Last, self, self.__OnClickBtnLast)
  UIUtil.AddButtonListener(self.ui.btn_Next, self, self.__OnClickBtnNext)
  UIUtil.AddButtonListener(self.ui.btn_StarUp, self, self.__OnClickStarUp)
  UIUtil.AddButtonListener(self.ui.btn_currencyCost, self, self.__OnClickCurrencyCost)
  self.__onPreviewItemClick = BindCallback(self, self.__PreviewItemClick)
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Hero)
end

function UIHStarUpInfoNode:RefreshStarUpInfoUI(heroData, preItemAction, btnStarUpAction)
  if heroData == nil then
    return
  end
  self.heroData = heroData
  self.isFullRank = self.heroData:IsFullRank()
  self.curRank = heroData.rank
  self.previewRank = self.isFullRank and heroData.rank or heroData.rank + 1
  self.needfragNum = self.heroData:StarNeedFrag()
  self.preItemAction = preItemAction
  self.btnStarUpAction = btnStarUpAction
  self:__RefreshStarUI(self.curRank, self.curStarList)
  self.ui.obj_NextStarNode:SetActive(not self.isFullRank)
  self.ui.obj_TexPreview:SetActive(not self.isFullRank)
  self.ui.obj_notFullRank:SetActive(not self.isFullRank)
  self.ui.obj_TexFullRank:SetActive(self.isFullRank)
  self:RefreshCostNode()
  self:__RefreshPreviewLevel(self.previewRank)
  self:__PlayAllDOTween()
end

function UIHStarUpInfoNode:RefreshCostNode()
  self.isFullRank = self.heroData:IsFullRank()
  local currencyId, needCurrencyNum = self.heroData:StarNeedCurrencyNum()
  local ableUp, fitFrag, fitCurrency, fitExtr = self.heroData:AbleUpgradeStar()
  self:__SetFragItem()
  self:__SetRefreshCurrency(fitCurrency, currencyId, needCurrencyNum)
  self:__SetStarUpButton(ableUp)
end

function UIHStarUpInfoNode:__SetRefreshCurrency(fitCurrency, currencyId, needCurrencyNum)
  if self.isFullRank or currencyId == nil then
    self.ui.obj_CurrencyCost:SetActive(false)
    return
  else
    self.ui.obj_CurrencyCost:SetActive(true)
  end
  self.ui.obj_CurrencyCost:SetActive(true)
  self.currencyCfg = ConfigData.item[currencyId]
  if self.currencyCfg == nil then
    error("itemCfg read error id=" .. currencyId)
    return
  else
    self.ui.img_CurrencyItem.sprite = CRH:GetSprite(self.currencyCfg.small_icon)
    local index = 0
    if fitCurrency then
      index = 1
    else
      index = 0
    end
    local hasCount = PlayerDataCenter:GetItemCount(self.currencyCfg.id) or 0
    self.ui.tex_CurrencyCost:SetIndex(index, tostring(hasCount), tostring(needCurrencyNum))
  end
end

function UIHStarUpInfoNode:__SetFragItem()
  if self.needfragNum == 0 then
    self.ui.obj_HeroFrag:SetActive(false)
    return
  end
  self.ui.obj_HeroFrag:SetActive(true)
  local itemCfg = ConfigData.item[self.heroData.fragId]
  if itemCfg == nil then
    error("frag itemCfg error id=" .. self.heroData.fragId)
  else
    self.fragBaseItem:InitBaseItem(itemCfg)
  end
  local totalFragNum = self.heroData:GetHeroFragCount()
  if totalFragNum >= self.needfragNum then
    self.ui.tex_HeroFrag:SetIndex(0, tostring(self.needfragNum), tostring(totalFragNum))
  else
    self.ui.tex_HeroFrag:SetIndex(2, tostring(self.needfragNum), tostring(totalFragNum))
  end
end

function UIHStarUpInfoNode:__SetStarUpButton(ableUp)
  if ableUp then
    self.ui.img_BtnStarUp.color = self.ui.col_Orange
  else
    self.ui.img_BtnStarUp.color = self.ui.col_Gray
  end
end

function UIHStarUpInfoNode:__RefreshPreviewLevel(previewRank)
  if not self.isFullRank then
    self:__RefreshStarUI(previewRank, self.preStarList)
  end
  self:__RefreshSwitchBtnUI(previewRank)
  self:__RefreshPreviewItem(previewRank)
  local active = self.isFullRank or previewRank ~= self.curRank + 1
  self.ui.obj_InPreview:SetActive(active)
  self.ui.btn_StarUp.gameObject:SetActive(not active)
end

function UIHStarUpInfoNode:__RefreshStarUI(rank, UINStarUpStarList)
  local rankCfg = ConfigData.hero_rank[rank]
  if rankCfg == nil then
    error("Can't find rankCfg, id = " .. tostring(rank))
  end
  UINStarUpStarList:InitStarList(nil, rankCfg.star)
end

function UIHStarUpInfoNode:__RefreshSwitchBtnUI(previewRank)
  local lastBtnActive = previewRank > self.curRank + 1
  self.ui.btn_Last.gameObject:SetActive(lastBtnActive)
  local nextBtnActive = previewRank < ConfigData.hero_rank.maxRank
  self.ui.btn_Next.gameObject:SetActive(nextBtnActive)
end

function UIHStarUpInfoNode:__IsAthSlotUpgrade(targetRank)
  local oldSlotInfo = self.heroData:GetAthSlotList(false, targetRank - 1)
  local nowSlotInfo = self.heroData:GetAthSlotList(false, targetRank)
  local oldNum, newNum = 0, 0
  for _, value in ipairs(oldSlotInfo) do
    oldNum = oldNum + value
  end
  for _, value in ipairs(nowSlotInfo) do
    newNum = newNum + value
  end
  return oldNum < newNum
end

function UIHStarUpInfoNode:__RefreshPreviewItem(previewRank)
  self.itemDataList = {}
  for index, data in ipairs(previewItemDatas) do
    if index == 3 then
      if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm) and self:__IsAthSlotUpgrade(previewRank) then
        table.insert(self.itemDataList, data)
      end
    else
      table.insert(self.itemDataList, data)
    end
  end
  self:__GenSkillPreviewItemData(previewRank)
  local preRankCfg = self:__GetPreviewRankCfg(previewRank)
  if preRankCfg ~= nil then
    self:__GetSkinPreviewItemData(previewRank, preRankCfg)
    self:__GetRewardPreviewItemData(preRankCfg)
  end
  self.promoteItemPool:HideAll()
  for index, data in ipairs(self.itemDataList) do
    local item = self.promoteItemPool:GetOne()
    item:InitPreviewItem(index, data, self.__onPreviewItemClick)
  end
end

function UIHStarUpInfoNode:__GenSkillPreviewItemData(previewRank)
  local preRankCfg = ConfigData.hero_rank[previewRank]
  
  local function addSkillDataFunc(skillData, tipsId, preUSkilllevel, unlockAdvance, lastStartCdTime, preStartCdTime)
    local name
    if preUSkilllevel then
      name = string.format(ConfigData:GetTipContent(tipsId), skillData:GetName(), tostring(preUSkilllevel))
    elseif preStartCdTime ~= nil and lastStartCdTime ~= nil then
      name = string.format(ConfigData:GetTipContent(tipsId), skillData:GetName(), GetPreciseDecimalStr(lastStartCdTime, 1), GetPreciseDecimalStr(preStartCdTime, 1))
    else
      name = string.format(ConfigData:GetTipContent(tipsId), skillData:GetName())
    end
    local preData = {}
    preData.name = name
    preData.preType = previewType.skill
    preData.preUSkilllevel = preUSkilllevel
    preData.unlockAdvance = unlockAdvance
    preData.data = skillData
    return preData
  end
  
  local preSkillDataActive, preSkillDataPassive, preSkillDataUlt
  for _, skillData in ipairs(self.heroData.skillList) do
    if skillData:IsUniqueSkill() then
      if self.heroData:GetUltimateSkillLevel() < preRankCfg.ultimateskill_level or skillData.skillCfg.open_star == previewRank then
        local tipsId
        if skillData.skillCfg.open_star == previewRank then
          tipsId = 606
        else
          tipsId = 607
        end
        local preUSkilllevel = preRankCfg.ultimateskill_level
        preSkillDataUlt = addSkillDataFunc(skillData, tipsId, preUSkilllevel)
      end
    elseif skillData:IsPassiveSkill() then
      if skillData.skillCfg.open_star == previewRank or skillData.skillCfg.advanced_open_star == previewRank then
        local tipsId, unlockAdvance
        if skillData.skillCfg.open_star == previewRank then
          tipsId = 605
          unlockAdvance = false
        else
          tipsId = 612
          unlockAdvance = true
        end
        preSkillDataPassive = addSkillDataFunc(skillData, tipsId, nil, unlockAdvance)
      end
    elseif skillData:IsNormalSkill() then
      if skillData.skillCfg.advanced_open_star == previewRank then
        local tipsId = 613
        preSkillDataActive = addSkillDataFunc(skillData, tipsId, nil, true)
      end
      local upStartSkillCd = skillData:GetStartSkillCdUp(previewRank)
      local lastStartSkillCd = skillData:GetStartSkillCDTime(previewRank - 1)
      if 0 < upStartSkillCd then
        local tipsId = 614
        preSkillDataActive = addSkillDataFunc(skillData, tipsId, nil, false, lastStartSkillCd, upStartSkillCd)
      end
    end
  end
  if preSkillDataUlt ~= nil then
    table.insert(self.itemDataList, preSkillDataUlt)
  end
  if preSkillDataPassive ~= nil then
    table.insert(self.itemDataList, preSkillDataPassive)
  end
  if preSkillDataActive ~= nil then
    table.insert(self.itemDataList, preSkillDataActive)
  end
end

function UIHStarUpInfoNode:__GetPreviewRankCfg(previewRank)
  local heroId = self.heroData.dataId
  if heroId == nil or ConfigData.hero_star[heroId] == nil or ConfigData.hero_star[heroId][previewRank] == nil then
    error("can't get preRankCfg with heroId:" .. tostring(heroId) .. " rank:" .. tostring(previewRank))
    return
  end
  return ConfigData.hero_star[heroId][previewRank]
end

function UIHStarUpInfoNode:__GetSkinPreviewItemData(previewRank, preRankCfg)
  local skinId
  for index, itemId in ipairs(preRankCfg.rank_itemIds) do
    local itemConfig = ConfigData.item[itemId]
    if itemConfig ~= nil and itemConfig.type == eItemType.Skin then
      skinId = itemId
      break
    end
  end
  if skinId ~= nil and skinId ~= 0 and PlayerDataCenter.skinData:IsSkinUnlocked(skinId) then
    local preData = {}
    preData.name = ConfigData:GetTipContent(611)
    preData.preType = previewType.skin
    preData.newSkinId = skinId
    preData.previewRank = previewRank
    table.insert(self.itemDataList, preData)
  end
end

function UIHStarUpInfoNode:__GetRewardPreviewItemData(preRankCfg)
  for index, itemId in ipairs(preRankCfg.rank_rewardIds) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      warn("itemCfg is null ID:" .. tostring(itemId))
    else
      local preData = {}
      local count = preRankCfg.rank_rewardNums[index]
      preData.name = string.format(ConfigData:GetTipContent(615), LanguageUtil.GetLocaleText(itemCfg.name), tostring(count))
      preData.itemCfg = itemCfg
      preData.preType = previewType.reward
      table.insert(self.itemDataList, preData)
    end
  end
end

function UIHStarUpInfoNode:__PlayAllDOTween()
  for i = 1, #self.ui.infoTweens do
    local tween = self.ui.infoTweens[i]
    tween:DORestart(false)
  end
end

function UIHStarUpInfoNode:__OnClickBtnLast()
  self.previewRank = self.previewRank - 1
  self:__RefreshPreviewLevel(self.previewRank)
end

function UIHStarUpInfoNode:__OnClickBtnNext()
  self.previewRank = self.previewRank + 1
  self:__RefreshPreviewLevel(self.previewRank)
  AudioManager:PlayAudioById(1110)
end

function UIHStarUpInfoNode:__OnClickStarUp()
  if self.btnStarUpAction ~= nil then
    self.btnStarUpAction()
  end
end

function UIHStarUpInfoNode:__PreviewItemClick(index)
  if #self.itemDataList <= 0 then
    return
  end
  local data = self.itemDataList[index]
  if self.preItemAction ~= nil then
    self.preItemAction(data)
  end
end

function UIHStarUpInfoNode:__OnClickCurrencyCost()
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
    window:InitCommonItemDetail(self.currencyCfg)
  end)
end

function UIHStarUpInfoNode:OnDelete()
  for i = 1, #self.ui.infoTweens do
    local tween = self.ui.infoTweens[i]
    tween:DOKill()
  end
  base.OnDelete(self)
end

return UIHStarUpInfoNode
