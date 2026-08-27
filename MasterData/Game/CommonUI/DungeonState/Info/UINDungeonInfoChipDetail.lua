local UINDungeonInfoChipDetail = class("UINDungeonInfoChipDetail", UIBaseNode)
local base = UIBaseNode
local UINChipDetailSuitItem = require("Game.CommonUI.Chip.UINChipDetailSuitItem")
local UINChipLevel = require("Game.CommonUI.Chip.UINChipLevel")
local DynChipSuit = require("Game.Exploration.Data.ChipSuit.DynChipSuit")
local UINEpChipSuitDescItem = require("Game.Exploration.UI.ChipSuit.UINEpChipSuitDescItem")
local UINPlayerConsumeSkillItem = require("Game.Battle.UI.SkillModule.PlayerSkill.UINPlayerConsumeSkillItem")
local UINRichIntroButtom = require("Game.CommonUI.RichIntro.UINRichIntroButtom")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local cs_Edge = CS.UnityEngine.RectTransform.Edge
local cs_MessageCommon = CS.MessageCommon

function UINDungeonInfoChipDetail:ctor(dungeonInfoDetailRoot)
  self.dungeonInfoDetailRoot = dungeonInfoDetailRoot
end

function UINDungeonInfoChipDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_SellOut, self, self.__OnClickSellOut)
  self.nowChipIndex = 1
  self.chipDataList = {}
  self.epNetWork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self._OnSellCompleteFunc = BindCallback(self, self._OnSellComplete)
  self.suitItemPool = UIItemPool.New(UINChipDetailSuitItem, self.ui.suitItem)
  self.ui.suitItem:SetActive(false)
  self.chipLevelNode = UINChipLevel.New()
  self.chipLevelNode:Init(self.ui.level)
  self.suitDescItemPool = UIItemPool.New(UINEpChipSuitDescItem, self.ui.suitDescItem)
  self.ui.suitDescItem:SetActive(false)
  self.ui.suitNode:SetActive(false)
  self.consumeSkillItem = UINPlayerConsumeSkillItem.New()
  self.consumeSkillItem:Init(self.ui.uIBattleSkillItem)
  self.consumeSkillItem:Hide()
  self.btnRichIntro = UINRichIntroButtom.New()
  self.btnRichIntro:Init(self.ui.obj_RichIntro)
  self.btnRichIntro:InitRichIntroButtom(BindCallback(self, self.__ShowSkillIntro))
end

function UINDungeonInfoChipDetail:OnShow()
  AudioManager:PlayAudioById(1066)
end

function UINDungeonInfoChipDetail:InitChipInfo(chipDataList, index, isGainActiveAlg)
  self.chipDataList = chipDataList
  self:RefreshData(index, isGainActiveAlg)
end

function UINDungeonInfoChipDetail:RefreshData(index, isGainActiveAlg)
  self.nowChipIndex = index
  local chipData = self.chipDataList[index]
  local chipCfg = chipData.chipCfg
  if chipData:GetChipType() == ChipEnum.eChipType.Rain then
    self.ui.img_Light.gameObject:SetActive(false)
    self.ui.img_QualityColor.color = self.ui.color_rainQuality
    self.ui.obj_rainBg:SetActive(true)
    self.ui.obj_rainNode:SetActive(true)
  else
    self.ui.img_Light.gameObject:SetActive(true)
    self.ui.obj_rainBg:SetActive(false)
    self.ui.obj_rainNode:SetActive(false)
    local chipDetailColor = ChipDetailColor[chipData:GetQuality()]
    self.ui.img_QualityColor.color = chipDetailColor.normal
    self.ui.img_Light.color = chipDetailColor.light
  end
  self.ui.img_Corner.sprite = CRH:GetSprite(chipData:GetChipMarkIcon(), CommonAtlasType.ExplorationIcon)
  self.ui.tex_ChipName.text = chipData:GetName()
  self.chipLevelNode:InitChipLevel(chipData, nil, true, true)
  local isConsumeChip = chipData:IsConsumeSkillChip()
  self.ui.img_Icon.gameObject:SetActive(not isConsumeChip)
  if isConsumeChip then
    self.consumeSkillItem:Show()
    self.consumeSkillItem:InitPlayerConsumeSkillJustShow(chipData:GetSkillCfg())
  else
    self.consumeSkillItem:Hide()
    local iconSprite = CRH:GetSprite(chipData:GetIcon())
    self.ui.img_Icon.sprite = iconSprite
    self.ui.img_IconSD.sprite = iconSprite
  end
  self.ui.tempSkillType:SetActive(isConsumeChip)
  local unlockChipSuit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TagSuit)
  local tagId = chipData:GetChipFuncTag()
  if unlockChipSuit and tagId ~= 0 and not isConsumeChip then
    self.suitItemPool:HideAll()
    local dynPlayer = BattleUtil.GetCurDynPlayer()
    local showFuncCount = dynPlayer ~= nil and dynPlayer:GetChipTagIdCount(tagId) or 0
    local item = self.suitItemPool:GetOne()
    if dynPlayer == nil then
      item:InitChipDetailSuit(tagId)
    else
      local haveCount, maxCount = dynPlayer:GetChipTagIdCount(tagId)
      item:InitChipDetailSuitAndCount(tagId, haveCount, maxCount, dynPlayer, true, false)
    end
    local isShowDetail = CommonUtil.GetDetailDescribeSetting(eGameSetDescType.chip)
    self.ui.suitNode:SetActive(true)
    local chipSuit = DynChipSuit.New(tagId, showFuncCount)
    self.ui.img_suitIcon.sprite = chipSuit:GetChipSuitIconSprite()
    self.ui.tex_SuitName.text = chipSuit:GetChipSuitName()
    self.suitDescItemPool:HideAll()
    for _, tag_suit in ipairs(chipSuit.tagSuitCfg) do
      local item = self.suitDescItemPool:GetOne()
      item:InitSuitDescItem(tag_suit.number, showFuncCount >= tag_suit.number, ConfigData:GetChipDescriptionById(tag_suit.chip_id, 1, isShowDetail), self.ui.color_suitActive, self.ui.color_suitlock)
    end
  else
    self.suitItemPool:HideAll()
    self.ui.suitNode:SetActive(false)
  end
  self.btnRichIntro:SetIntroBtnActive(false)
  local isShowDetail = CommonUtil.GetDetailDescribeSetting(eGameSetDescType.chip)
  self.ui.tex_Description.text = chipData:GetChipDescription(isShowDetail)
  if 0 < #chipCfg.skill_list then
    local num = chipData:GetCount()
    local skillId = chipCfg.skill_list[1]
    local tab = {}
    local btnActive = false
    local skillLabeIdList
    local labelDic = ConfigData.battle_skill.skill_label_Dic[skillId]
    if labelDic ~= nil then
      for id, unlockLevel in pairs(labelDic) do
        if unlockLevel <= num then
          btnActive = true
          table.insert(tab, id)
        end
      end
    end
    if btnActive then
      self.uiIntroData = {}
      self.uiIntroData.skillLabeIdList = tab
      self.btnRichIntro:SetIntroBtnActive(btnActive)
    end
  end
  local showSellBtn = false
  local hasStore = ExplorationManager.epCtrl ~= nil and ExplorationManager.epCtrl.residentStoreCtrl:HasEpResidentStore()
  if hasStore then
    if ExplorationManager:IsInExplorationTD() then
      showSellBtn = false
    else
      local isBattle = not ExplorationManager.epCtrl.sceneCtrl:InBattleScene()
      local isConsumeSkill = chipData:IsConsumeSkillChip()
      local isWeekly = ExplorationManager:GetIsInWeeklyChallenge()
      if isWeekly then
        showSellBtn = isConsumeSkill and isGainActiveAlg
      else
        showSellBtn = not isBattle
      end
    end
    if showSellBtn then
      local epTypeCfg = ExplorationManager:GetEpTypeCfg()
      local buyPrice = chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId(), true)
      local sellPrice = ConfigData:CalculateEpChipSalePrice(epTypeCfg.store_pool, chipData:GetCount(), buyPrice, ExplorationManager:GetDynPlayer())
      self.ui.tex_SellOut.text = tostring(sellPrice)
    end
  end
  self.ui.btn_SellOut.gameObject:SetActive(showSellBtn)
end

function UINDungeonInfoChipDetail:SwitchChip(bool)
  local nextIndex = self.nowChipIndex
  local listCount = #self.chipDataList
  if bool then
    if listCount < nextIndex + 1 then
      nextIndex = 1
    else
      nextIndex = nextIndex + 1
    end
  elseif nextIndex - 1 <= 0 then
    nextIndex = listCount
  else
    nextIndex = nextIndex - 1
  end
  self:RefreshData(nextIndex)
  return nextIndex
end

function UINDungeonInfoChipDetail:__ShowSkillIntro()
  if self.uiIntroData == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    if win ~= nil then
      local modifier
      local infowin = UIManager:GetWindow(UIWindowTypeID.DungeonInfoDetail)
      if infowin ~= nil then
        modifier = infowin.ui.modifier
      end
      win:SetRichIntroList(self.ui.introHolder, self.uiIntroData, modifier)
      win:SetIntroListPosition(cs_Edge.Left)
    end
  end)
end

function UINDungeonInfoChipDetail:__OnClickSellOut()
  local chipData = self.chipDataList[self.nowChipIndex]
  self._sellChipName = chipData:GetName()
  local epTypeCfg = ExplorationManager:GetEpTypeCfg()
  local buyPrice = chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId(), true)
  local sellPrice = ConfigData:CalculateEpChipSalePrice(epTypeCfg.store_pool, chipData:GetCount(), buyPrice, ExplorationManager:GetDynPlayer())
  local msg = string.format(ConfigData:GetTipContent(288), self._sellChipName, tostring(sellPrice))
  cs_MessageCommon.ShowMessageBox(msg, function()
    self.epNetWork:CS_EXPLORATION_Alg_Sold(chipData.dataId, self._OnSellCompleteFunc)
  end, nil)
end

function UINDungeonInfoChipDetail:_OnSellComplete()
  cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.exploration_Store_SellSuc, self._sellChipName))
  self._sellChipName = nil
  self.dungeonInfoDetailRoot:OnClickRetreat()
end

function UINDungeonInfoChipDetail:OnDelete()
  self.suitItemPool:DeleteAll()
  self.btnRichIntro:Delete()
  base.OnDelete(self)
end

return UINDungeonInfoChipDetail
