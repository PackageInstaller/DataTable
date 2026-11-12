local BaseCtrl = require("GameCore.UI.BaseCtrl")
local CharAdvancePreviewInfoCtrl = class("CharAdvancePreviewInfoCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
CharAdvancePreviewInfoCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Advance_Preview_Title"
  },
  got_fullscreen_blur_blue1 = {
    sNodeName = "t_fullscreen_blur_blue1",
    sComponentName = "GameObject"
  },
  btnsnapshot = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnClosePanel"
  },
  aniadvancePreviewInfo = {
    sNodeName = "advancePreviewInfo",
    sComponentName = "Animator"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnClosePanel"
  },
  loopAdNodeScrollView = {
    sNodeName = "AdNodeScrollView",
    sComponentName = "LoopScrollView"
  },
  txtNeedLv = {sComponentName = "TMP_Text"},
  btnbtnAdReward = {
    sNodeName = "btnAdReward",
    sComponentName = "UIButton",
    callback = "OnBtn_AdvanceReward"
  },
  txtbtnAdReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Btn_EarnReward"
  },
  goadvanceReward = {
    sNodeName = "advanceRewardRoot",
    sComponentName = "GameObject"
  },
  loopAdPre = {
    sNodeName = "AdPre",
    sComponentName = "LoopScrollView"
  },
  txttxtAdRewCoin = {
    sNodeName = "txtAdRewCoin",
    sComponentName = "TMP_Text"
  },
  loopUpgradeMaterial = {
    sNodeName = "PreviewUpgradeMaterial",
    sComponentName = "LoopScrollView"
  },
  loopUpgradeReward = {
    sNodeName = "UpgradeReward",
    sComponentName = "LoopScrollView"
  },
  goadvanceRewardRoot = {
    sNodeName = "advanceRewardRoot",
    sComponentName = "GameObject"
  },
  txtAdvanceMat = {
    sComponentName = "TMP_Text",
    sLanguageId = "Advance_Need_Mat"
  },
  txtAdvanceReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Advance_Preview_Title"
  },
  txtWaitPicked = {sComponentName = "TMP_Text"},
  txtBuffHeight = {sComponentName = "TMP_Text"},
  rtTxtBuffHeight = {
    sNodeName = "txtBuffHeight",
    sComponentName = "RectTransform"
  },
  txtBuffHeightAfter = {sComponentName = "TMP_Text"},
  rtTxtBuffHeightAfter = {
    sNodeName = "txtBuffHeightAfter",
    sComponentName = "RectTransform"
  }
}
CharAdvancePreviewInfoCtrl._mapEventConfig = {
  SelectAdvanceNode = "OnEvent_RefreshAdInfo"
}

function CharAdvancePreviewInfoCtrl:_CalcGridHeight(sContent)
  NovaAPI.SetTMPText(self._mapNode.txtBuffHeight, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTxtBuffHeight)
  local nH = self._mapNode.rtTxtBuffHeight.rect.height + 14
  return nH
end

function CharAdvancePreviewInfoCtrl:_CalcGridHeightAfter(sContent)
  NovaAPI.SetTMPText(self._mapNode.txtBuffHeightAfter, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTxtBuffHeightAfter)
  local nH = self._mapNode.rtTxtBuffHeightAfter.rect.height + 14
  return nH
end

function CharAdvancePreviewInfoCtrl:Awake()
end

function CharAdvancePreviewInfoCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self:ResetData(tbParam[1], tbParam[2], tbParam[3])
  end
end

function CharAdvancePreviewInfoCtrl:OnDisable()
  if self.AdvanceNodeList then
    for k, v in pairs(self.AdvanceNodeList) do
      self:UnbindCtrlByNode(v)
    end
    self.AdvanceNodeList = {}
  end
end

function CharAdvancePreviewInfoCtrl:OnClosePanel()
  self._mapNode.aniadvancePreviewInfo:Play("t_window_04_t_out")
  self._mapNode.got_fullscreen_blur_blue1:SetActive(false)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:AddTimer(1, 0.3, "OnCloseAnimFinish", true, true, true)
end

function CharAdvancePreviewInfoCtrl:OnCloseAnimFinish()
  EventManager.Hit(EventId.ClosePanel, PanelId.CharAdvancePreview)
end

function CharAdvancePreviewInfoCtrl:ResetData(maxAdvance, charId, curGradeLevelArr)
  self.maxAdvance = maxAdvance
  self.charId = charId
  self.curGradeLevelArr = curGradeLevelArr
  self._mapNode.got_fullscreen_blur_blue1:SetActive(true)
  self._mapNode.aniadvancePreviewInfo:Play("t_window_04_t_in")
  if self.charId ~= nil then
    self.playerCharData = PlayerData.Char:GetCharDataByTid(self.charId)
  end
  if self.maxAdvance ~= nil then
    self:RefreshAdvanceNode()
  else
    self:OnClosePanel()
  end
end

function CharAdvancePreviewInfoCtrl:RefreshAdvanceNode()
  local nAdvance = self.playerCharData.nAdvance
  local nCharAdvance = nAdvance
  local canPickReward = PlayerData.State:GetCanPickedAdvanceRewards(self.charId, self.maxAdvance)
  if canPickReward ~= nil and canPickReward ~= 0 then
    nAdvance = canPickReward
  end
  self.bZero = false
  if nAdvance == 0 then
    nAdvance = 1
    self.bZero = true
  end
  self.defaultAdvance = nCharAdvance
  if self.AdvanceNodeList == nil then
    self.AdvanceNodeList = {}
  end
  for k, v in pairs(self.AdvanceNodeList) do
    self:UnbindCtrlByNode(v)
  end
  self.AdvanceNodeList = {}
  self.curSelectAdvance = nAdvance
  self._mapNode.loopAdNodeScrollView:Init(self.maxAdvance, self, self.RefreshAdvanceNodeGridItem)
  local movePos = 0 < nAdvance - 2 and nAdvance - 2 or 0
  self._mapNode.loopAdNodeScrollView:SetScrollGridPos(movePos, 0.05)
  EventManager.Hit("SelectAdvanceNode", nAdvance)
end

function CharAdvancePreviewInfoCtrl:RefreshAdvanceNodeGridItem(go)
  local index = tonumber(go.name) + 1
  if self.AdvanceNodeList[go] ~= nil then
    self:UnbindCtrlByNode(self.AdvanceNodeList[go])
    self.AdvanceNodeList[go] = nil
  end
  local ctrlItem = self:BindCtrlByNode(go, "Game.UI.CharacterInfoEx.CharAdvanceNodeItemCtrl")
  self.AdvanceNodeList[go] = ctrlItem
  ctrlItem:RefreshNode(self.charId, index, self.playerCharData.nAdvance, self.bZero, index == self.curSelectAdvance)
end

function CharAdvancePreviewInfoCtrl:RefreshAdvanceBuffs()
  local buffCount = 0
  self.tbGridHeight = {}
  local mapPreview = PlayerData.Char:GetCharAdvancePreview(self.charId, self.curSelectAdvance)
  self.mapPreviewDesc = {}
  for _, v in ipairs(mapPreview) do
    local AdvanceDescFront, AdvanceDescAfter = "", ""
    if v.nType == AllEnum.CharAdvancePreview.LevelMax then
      AdvanceDescFront = ConfigTable.GetUIText("CharAdvance_Preview_LevelMax")
      AdvanceDescAfter = orderedFormat(ConfigTable.GetUIText("CharAdvance_Preview_Level"), v.nMaxLevel)
    elseif v.nType == AllEnum.CharAdvancePreview.SkillLevelMax then
      AdvanceDescFront = ConfigTable.GetUIText("CharAdvance_Preview_Skill_LevelMax")
      AdvanceDescAfter = orderedFormat(ConfigTable.GetUIText("CharAdvance_Preview_Level"), v.nMaxSkillLevel)
    elseif v.nType == AllEnum.CharAdvancePreview.SkinUnlock then
      AdvanceDescFront = ConfigTable.GetUIText("CharAdvance_Preview_SkinUnlock_1")
      AdvanceDescAfter = ConfigTable.GetUIText("CharAdvance_Preview_SkinUnlock_2")
    end
    if AdvanceDescFront ~= "" or AdvanceDescAfter ~= "" then
      buffCount = buffCount + 1
      local nMaxHeight = math.max(self:_CalcGridHeight(AdvanceDescFront), self:_CalcGridHeightAfter(AdvanceDescAfter))
      table.insert(self.tbGridHeight, nMaxHeight)
      table.insert(self.mapPreviewDesc, {sFront = AdvanceDescFront, sAfter = AdvanceDescAfter})
    end
  end
  if 0 < buffCount then
    self._mapNode.loopAdPre:InitEx(self.tbGridHeight, self, self.RefreshPreAdvanceBuffsGridItem)
  end
  self._mapNode.loopAdPre.gameObject:SetActive(0 < buffCount)
end

function CharAdvancePreviewInfoCtrl:RefreshPreAdvanceBuffsGridItem(go)
  local index = tonumber(go.name) + 1
  if self.mapPreviewDesc[index] ~= nil then
    local txtBuff = go.transform:Find("txtBuff")
    if txtBuff ~= nil then
      NovaAPI.SetTMPText(txtBuff:GetComponent("TMP_Text"), self.mapPreviewDesc[index].sFront)
    end
    local txtBuffContent = go.transform:Find("txtBuffContent")
    if txtBuffContent ~= nil then
      NovaAPI.SetTMPText(txtBuffContent:GetComponent("TMP_Text"), self.mapPreviewDesc[index].sAfter)
    end
  end
  local imageBar = go.transform:Find("Image")
  imageBar.gameObject:SetActive(1 < index)
  local bOpen = self.playerCharData.nAdvance >= self.curSelectAdvance
  local goLock = go.transform:Find("goIconlock")
  if goLock ~= nil then
    goLock.gameObject:SetActive(not bOpen)
  end
  local goUnlock = go.transform:Find("goIconOpen")
  if goUnlock ~= nil then
    goUnlock.gameObject:SetActive(bOpen)
  end
end

function CharAdvancePreviewInfoCtrl:RefreshPreAdvanceMaterials()
  local index = 1
  self.AdvanceMaterialData = {}
  while self.AdvanceUpData["Tid" .. index] ~= nil do
    local tid = self.AdvanceUpData["Tid" .. index]
    if tid ~= 0 then
      local Rarity = AllEnum.FrameColor_New[ConfigTable.GetData_Item(tid).Rarity]
      table.insert(self.AdvanceMaterialData, {
        id = tid,
        count = self.AdvanceUpData["Qty" .. index],
        tid = index,
        nRarity = Rarity
      })
    end
    index = index + 1
  end
  NovaAPI.SetTMPText(self._mapNode.txttxtAdRewCoin, self.AdvanceUpData.GoldQty)
  if #self.AdvanceMaterialData > 0 then
    table.sort(self.AdvanceMaterialData, function(a, b)
      if a.nRarity ~= b.nRarity then
        return a.nRarity < b.nRarity
      else
        return a.tid < b.tid
      end
    end)
    self._mapNode.loopUpgradeMaterial:Init(#self.AdvanceMaterialData, self, self.RefreshPreAdvanceMaterialsGridItem, self.BtnMaterialInfoGridClick)
  end
end

function CharAdvancePreviewInfoCtrl:RefreshPreAdvanceMaterialsGridItem(go)
  local index = tonumber(go.name) + 1
  local itemCtrl = self:BindCtrlByNode(go, "Game.UI.TemplateEx.TemplateItemCtrl")
  local data = self.AdvanceMaterialData[index]
  itemCtrl:SetItem(data.id, nil, data.count, nil, false, nil, nil, true)
end

function CharAdvancePreviewInfoCtrl:BtnMaterialInfoGridClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local data = self.AdvanceMaterialData[nIndex]
  if nil == data then
    return
  end
  local item = goGrid.transform:Find("AnimRoot/item")
  UTILS.ClickItemGridWithTips(data.id, item.transform, true, true, false)
end

function CharAdvancePreviewInfoCtrl:RefreshRewardInfo()
  local CanPickupReward = PlayerData.State:GetCharAdvanceRewards(self.charId, self.curSelectAdvance)
  self._mapNode.btnbtnAdReward.gameObject:SetActive(CanPickupReward)
  local index = 1
  self.AdvanceRewardData = {}
  while self.AdvanceUpData["AwardTid" .. index] ~= nil do
    local awardTid = self.AdvanceUpData["AwardTid" .. index]
    if awardTid ~= 0 then
      table.insert(self.AdvanceRewardData, {
        id = awardTid,
        count = self.AdvanceUpData["AwardQty" .. index],
        tid = index
      })
    end
    index = index + 1
  end
  self._mapNode.goadvanceReward.gameObject:SetActive(#self.AdvanceRewardData > 0)
  if #self.AdvanceRewardData <= 0 then
    return
  end
  self._mapNode.txtWaitPicked.gameObject:SetActive(self.playerCharData.nAdvance < self.curSelectAdvance)
  if self.playerCharData.nAdvance < self.curSelectAdvance then
    NovaAPI.SetTMPText(self._mapNode.txtWaitPicked, orderedFormat(ConfigTable.GetUIText("Advance_Waiting_Picked"), self.curSelectAdvance - self.playerCharData.nAdvance))
  end
  self._mapNode.txtWaitPicked.gameObject:SetActive(self.playerCharData.nAdvance < self.curSelectAdvance)
  if #self.AdvanceRewardData > 0 then
    table.sort(self.AdvanceRewardData, function(a, b)
      if a and b then
        local nRarityA = ConfigTable.GetData_Item(a.id) ~= nil and ConfigTable.GetData_Item(a.id).Rarity or 0
        local nRarityB = ConfigTable.GetData_Item(b.id) ~= nil and ConfigTable.GetData_Item(b.id).Rarity or 0
        if nRarityA == nRarityB then
          return a.tid < b.tid
        end
        return nRarityA < nRarityB
      end
      return true
    end)
    self._mapNode.loopUpgradeReward:Init(#self.AdvanceRewardData, self, self.RefreshRewardInfoGridItem, self.BtnRewardInfoGridClick)
  end
end

function CharAdvancePreviewInfoCtrl:RefreshRewardInfoGridItem(go)
  local index = tonumber(go.name) + 1
  local ctrl = self:BindCtrlByNode(go, "Game.UI.TemplateEx.TemplateItemCtrl")
  local data = self.AdvanceRewardData[index]
  local CanPickupReward = PlayerData.State:GetCharAdvanceRewards(self.charId, self.curSelectAdvance)
  if CanPickupReward or self.playerCharData.nAdvance < self.curSelectAdvance then
    ctrl:SetItem(data.id, nil, data.count, nil, false, nil, nil, true)
  else
    ctrl:SetItem(data.id, nil, data.count, nil, true, nil, nil, true)
  end
end

function CharAdvancePreviewInfoCtrl:BtnRewardInfoGridClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local data = self.AdvanceRewardData[nIndex]
  if nil == data then
    return
  end
  local item = goGrid.transform:Find("AnimRoot/item")
  UTILS.ClickItemGridWithTips(data.id, item.transform, true, true, false)
end

function CharAdvancePreviewInfoCtrl:OnBtn_AdvanceReward(btn)
  local function callback()
    self:RefreshAdvanceNode()
  end
  
  PlayerData.Char:CharAdvanceReward(self.charId, self.curSelectAdvance, callback)
end

function CharAdvancePreviewInfoCtrl:OnEvent_RefreshAdInfo(nSelectAdvance)
  NovaAPI.SetTMPText(self._mapNode.txtNeedLv, orderedFormat(ConfigTable.GetUIText("Advance_Need_Level"), self.curGradeLevelArr[nSelectAdvance]))
  local AdvanceUpId = 100 * self.charId + nSelectAdvance
  self.AdvanceUpData = ConfigTable.GetData("CharacterAdvance", AdvanceUpId)
  if self.AdvanceUpData == nil then
    return
  end
  self.curSelectAdvance = nSelectAdvance
  self:RefreshAdvanceBuffs()
  self:RefreshPreAdvanceMaterials()
  self:RefreshRewardInfo()
end

return CharAdvancePreviewInfoCtrl
