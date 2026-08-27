local UINHeroSkillUpgradeInfo = class("UINHeroSkillUpgradeInfo", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local HeroSkillData = require("Game.PlayerData.Skill.HeroSkillData")
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
local UINHeroSkillUpgradeCostItem = require("Game.Hero.NewUI.UpgradeSkill.UINHeroSkillUpgradeCostItem")
local UINSkillAllLevelDes = require("Game.Hero.NewUI.UpgradeSkill.UINSkillAllLevelDes")

function UINHeroSkillUpgradeInfo:OnInit()
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.OnClickCancel)
  UIUtil.AddButtonListener(self.ui.btn_ultCancel, self, self.OnClickCancel)
  UIUtil.AddButtonListener(self.ui.btn_CheckAll, self, self.ShowAllLevelInfo)
  UIUtil.AddButtonListener(self.ui.btn_jump2StartUp, self, self.__OnJump2StarUp)
  self.CostItemPool = UIItemPool.New(UINHeroSkillUpgradeCostItem, self.ui.obj_extrItem)
  self.ui.obj_extrItem:SetActive(false)
  self.nowSkillItem = UINBaseSkillItem.New()
  self.nowSkillItem:Init(self.ui.now_uINSkillItem)
  self.nextSkillItem = UINBaseSkillItem.New()
  self.nextSkillItem:Init(self.ui.next_uINSkillItem)
  self.AllLevelDes = UINSkillAllLevelDes.New()
  self.AllLevelDes:Init(self.ui.obj_viewAllSkillNode)
  self.__HeroRefresh = BindCallback(self, self.HeroRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__HeroRefresh)
  self.__ItemRefresh = BindCallback(self, self.ItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__ItemRefresh)
  self.StarList = {}
  table.insert(self.StarList, self.ui.obj_star)
end

function UINHeroSkillUpgradeInfo:InitInfoNode(skillData, resloader, closeInfoNodeCallback)
  self.skillData = skillData
  self.resloader = resloader
  self.closeInfoNodeCallback = closeInfoNodeCallback
  UIUtil.RefreshTopResId({1003})
  self:Refresh(false)
  self.isUniqueSkill = false
  if self.skillData ~= nil then
    self.isUniqueSkill = self.skillData:IsUniqueSkill()
  end
  self.ui.bottomNode:SetActive(not self.isUniqueSkill)
  self.ui.ultimateNode:SetActive(self.isUniqueSkill)
  self.ui.btn_jump2StartUp.gameObject:SetActive(self.isUniqueSkill)
end

function UINHeroSkillUpgradeInfo:HeroRefresh()
end

function UINHeroSkillUpgradeInfo:ItemRefresh()
  self:Refresh()
end

function UINHeroSkillUpgradeInfo:Refresh(isUpgrade)
  if self.skillData == nil then
    return
  end
  if self.skillData:IsFullLevel() then
    self.closeInfoNodeCallback()
    return
  end
  local bool, rare, star, isHaveEnoughItem, notLimit = self.skillData:CanUpgrade()
  local isSkillUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SkillUp)
  self.ui.obj_lockedNode:SetActive(false)
  self.ui.obj_limitNode:SetActive(false)
  self.ui.btn_Confirm.gameObject:SetActive(true)
  if bool and isSkillUpUnlock then
    self.ui.img_btn_Confirm.color = self.ui.color_Orange
  else
    self.ui.img_btn_Confirm.color = self.ui.color_Gray
    if not isSkillUpUnlock then
      self.ui.obj_limitNode:SetActive(true)
      self.ui.btn_Confirm.gameObject:SetActive(false)
      self.ui.tex_LimitTips:SetIndex(1, FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_SkillUp))
    elseif not star then
      self.ui.obj_lockedNode:SetActive(true)
      self.ui.btn_Confirm.gameObject:SetActive(false)
      local starUnm = self.skillData:GetNextLevelRankCfg().star
      self:RefreshUnlockStar(starUnm)
    elseif not notLimit then
      self.ui.obj_limitNode:SetActive(true)
      self.ui.btn_Confirm.gameObject:SetActive(false)
      local limitLevel = self.skillData:GetLimitLevel()
      self.ui.tex_LimitTips:SetIndex(0, tostring(limitLevel))
    end
  end
  self:RefreshLevelInfo(isUpgrade)
  self:RefreshAllMaterial()
end

function UINHeroSkillUpgradeInfo:RefreshAllMaterial()
  local skillLevelCfg = self.skillData:GetSkillLevelCfg()
  local currencyId, currencyNum
  self.CostItemPool:HideAll()
  for index, itemId in ipairs(skillLevelCfg.itemIdList) do
    if index == 1 then
      currencyId = skillLevelCfg.itemIdList[1]
      currencyNum = skillLevelCfg.countList[1] or 0
    else
      local num = skillLevelCfg.countList[index]
      local item = self.CostItemPool:GetOne(true)
      item:InitCostItem(itemId, num)
    end
  end
  local itemCfg = ConfigData.item[currencyId]
  if itemCfg ~= nil then
    self.ui.img_Item.sprite = CRH:GetSprite(itemCfg.small_icon)
  else
    error("can't read itemCfg with id:" .. tostring(currencyId))
  end
  local totalCurrencyNum = PlayerDataCenter:GetItemCount(currencyId)
  if currencyNum > totalCurrencyNum then
    self.ui.tex_Cost:SetIndex(1, tostring(currencyNum))
  else
    self.ui.tex_Cost:SetIndex(0, tostring(currencyNum))
  end
end

function UINHeroSkillUpgradeInfo:RefreshLevelInfo(isUpgrade)
  if self.skillData.level <= 9 then
    self.ui.tex_curLv.text = "0" .. tostring(self.skillData.level)
  else
    self.ui.tex_curLv.text = tostring(self.skillData.level)
  end
  local nextLevel = self.skillData.level + 1
  if nextLevel <= 9 then
    self.ui.tex_NextLv.text = "0" .. tostring(nextLevel)
  else
    self.ui.tex_NextLv.text = tostring(nextLevel)
  end
  if nextLevel > self.skillData:GetMaxLevel() then
    error("skill is full level id:" .. tostring(self.skillData.dataId) .. " level:" .. tostring(self.skillData.level))
    return
  end
  self.ui.now_tex_Lv.text = "LV" .. tostring(self.skillData.level)
  self.ui.now_tex_Name.text = self.skillData:GetName()
  self.ui.now_tex_Descr.text = self.skillData:Get2NewLevelDes(self.skillData.level, nextLevel)
  self.nowSkillItem:InitBaseSkillItem(self.skillData, self.resloader)
  if isUpgrade then
    self.ui.tex_curLv:StartScrambleTypeWriter()
    self.ui.now_tex_Lv:StartScrambleTypeWriter()
  end
end

function UINHeroSkillUpgradeInfo:RefreshUnlockStar(starNum)
  for _, starGo in ipairs(self.StarList) do
    starGo.gameObject:SetActive(false)
  end
  local count = math.ceil(starNum / 2)
  local isHalf = starNum % 2 == 1
  for i = 1, count do
    if self.StarList[i] ~= nil then
      self.StarList[i].gameObject:SetActive(true)
      self.StarList[i]:SetIndex(0)
    else
      local imgItemInfo = self.ui.obj_star:Instantiate():GetComponent(typeof(CS.UiImageItemInfo))
      table.insert(self.StarList, imgItemInfo)
      imgItemInfo.gameObject:SetActive(true)
    end
  end
  if isHalf then
    self.StarList[count]:SetIndex(1)
  end
end

function UINHeroSkillUpgradeInfo:ShowAllLevelInfo()
  self.AllLevelDes:Show()
  self.AllLevelDes:InitAllDes(self.skillData)
end

function UINHeroSkillUpgradeInfo:__OnJump2StarUp()
  local isStarUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank)
  if not isStarUpUnlock then
    local des = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank, true)
    cs_MessageCommon.ShowMessageTipsWithErrorSound(des)
    return
  end
  local window = UIManager:GetWindow(UIWindowTypeID.HeroSkillUpgrade)
  if window == nil or not window.active then
    return
  end
  UIUtil.OnClickBackByWinId(UIWindowTypeID.HeroSkillUpgrade)
  window = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if window == nil or not window.active then
    return
  end
  window:OnClickStarUP()
end

function UINHeroSkillUpgradeInfo:OnClickConfirm()
  local isSkillUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SkillUp)
  if not isSkillUpUnlock then
    local unlockDes = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_SkillUp)
    cs_MessageCommon.ShowMessageTipsWithErrorSound(unlockDes)
    return
  end
  local bool, rare, star, isHaveEnoughItem, _, needItemIds = self.skillData:CanUpgrade()
  if bool then
    if self.__refreshFunc == nil then
      self.__refreshFunc = BindCallback(self, self.Refresh, true)
    end
    self.networkCtrl:SendHeroSkillUp(self.skillData.heroData.dataId, self.skillData.dataId, self.__refreshFunc)
    self.couldConfirm = false
  end
  if not isHaveEnoughItem then
    if self.skillData:IsFullLevel() then
      return
    end
    local moneyId = ConfigData.game_config.epMoneyConvert
    local needMoney = needItemIds[moneyId] ~= nil
    if needMoney then
      self:HSUIShowItemDetail(moneyId)
    else
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.hero_Skill_materialInsufficient))
    end
  end
end

function UINHeroSkillUpgradeInfo:SetBtnCancelAction(Action)
  self.onCancelClickAction = Action
end

function UINHeroSkillUpgradeInfo:OnClickCancel()
  if self.onCancelClickAction ~= nil then
    self.onCancelClickAction()
  end
end

function UINHeroSkillUpgradeInfo:HSUIShowItemDetail(itemId)
  local cfg = ConfigData.item[itemId]
  if cfg == nil then
    error("HSUIShowItemDetail the cfg is nil")
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
    window:InitCommonItemDetail(cfg)
  end)
end

function UINHeroSkillUpgradeInfo:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__HeroRefresh)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__ItemRefresh)
  base.OnDelete(self)
end

return UINHeroSkillUpgradeInfo
