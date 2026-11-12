local BaseCtrl = require("GameCore.UI.BaseCtrl")
local CharEquipmentCtrl = class("CharEquipmentCtrl", BaseCtrl)
CharEquipmentCtrl._mapNodeConfig = {
  animRoot = {
    sNodeName = "----FunctionPanel----",
    sComponentName = "Animator"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "GameObject"
  },
  EquipmentSlot = {},
  goEquipmentSlotItem = {
    nCount = 3,
    sCtrlName = "Game.UI.Equipment.EquipmentSlotItemCtrl"
  },
  btnEquipmentSlot = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_EquipmentSlot"
  },
  ctrlDropdown = {
    sNodeName = "tc_dropdown_01",
    sCtrlName = "Game.UI.TemplateEx.TemplateDropdownCtrl"
  },
  btnRename = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Rename"
  },
  btnPreview = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Preview"
  },
  txtBtnPreview = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Btn_TotalAttrPreview"
  },
  txtName = {sComponentName = "TMP_Text"},
  imgRareName = {sComponentName = "Image"},
  imgCharColor = {sComponentName = "Image"},
  imgTag = {nCount = 3},
  txtTag = {nCount = 3, sComponentName = "TMP_Text"},
  txtElement = {sComponentName = "TMP_Text"},
  imgElementIcon = {sComponentName = "Image"}
}
CharEquipmentCtrl._mapEventConfig = {
  [EventId.CharRelatePanelAdvance] = "OnEvent_PanelAdvance",
  [EventId.CharRelatePanelBack] = "OnEvent_PanelBack",
  [EventId.CharBgRefresh] = "OnEvent_RefreshPanel",
  SelectTemplateDD = "OnEvent_PresetSelect",
  EquipmentSlotChanged = "RefreshPresetSlot"
}

function CharEquipmentCtrl:OnRefreshPanel()
  self.nCharId = self._panel.nCharId
  self:RefreshCharInfo()
  self:RefreshPresetSlot()
  self:RefreshPresetDD()
end

function CharEquipmentCtrl:RefreshCharInfo()
  local mapCfg = ConfigTable.GetData_Character(self.nCharId)
  if not mapCfg then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
  self:SetSprite_FrameColor(self._mapNode.imgRareName, mapCfg.Grade, AllEnum.FrameType_New.Text)
  NovaAPI.SetImageNativeSize(self._mapNode.imgRareName)
  local mapCharDescCfg = ConfigTable.GetData("CharacterDes", self.nCharId)
  local sColor, tbTag
  if mapCharDescCfg ~= nil then
    sColor = mapCharDescCfg.CharColor
    tbTag = mapCharDescCfg.Tag
  else
    sColor = ""
    tbTag = {}
  end
  local _, colorChar = ColorUtility.TryParseHtmlString(sColor)
  NovaAPI.SetImageColor(self._mapNode.imgCharColor, colorChar)
  for i = 1, 3 do
    local nTag = tbTag[i]
    if nTag then
      self._mapNode.imgTag[i]:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtTag[i], ConfigTable.GetData("CharacterTag", nTag).Title)
    else
      self._mapNode.imgTag[i]:SetActive(false)
    end
  end
  local sName = AllEnum.ElementIconType.Icon .. mapCfg.EET
  self:SetAtlasSprite(self._mapNode.imgElementIcon, "12_rare", sName)
  NovaAPI.SetTMPText(self._mapNode.txtElement, ConfigTable.GetUIText("T_Element_Attr_" .. mapCfg.EET))
  NovaAPI.SetTMPColor(self._mapNode.txtElement, AllEnum.ElementColor[mapCfg.EET])
end

function CharEquipmentCtrl:RefreshPresetDD()
  local nSelect = PlayerData.Equipment:GetSelectPreset(self.nCharId)
  self.tbName = PlayerData.Equipment:GetAllPresetName(self.nCharId)
  self._mapNode.ctrlDropdown:SetList(self.tbName, nSelect - 1, true)
end

function CharEquipmentCtrl:RefreshPresetSlot()
  local nSelect = PlayerData.Equipment:GetSelectPreset(self.nCharId)
  self.tbSlot = PlayerData.Equipment:GetSlotWithIndex(self.nCharId, nSelect)
  for k, v in ipairs(self._mapNode.goEquipmentSlotItem) do
    v:Init(self.tbSlot[k], self.nCharId)
  end
  if self._mapNode.goEquipmentSlotItem[self.nLastIndex] then
    self._mapNode.goEquipmentSlotItem[self.nLastIndex]:SetChooseState(true)
  end
end

function CharEquipmentCtrl:PlaySwitchAnim(nClosePanelId, nOpenPanelId)
  if nClosePanelId == PanelId.CharEquipment then
    self._mapNode.safeAreaRoot.gameObject:SetActive(false)
  end
  if nOpenPanelId == PanelId.CharEquipment then
    self._mapNode.safeAreaRoot.gameObject:SetActive(true)
    CS.WwiseAudioManager.Instance:PostEvent("ui_charInfo_equipment_open")
    self:OnRefreshPanel()
  end
end

function CharEquipmentCtrl:OnEnable()
  local bHasLastIndex = false
  if self._panel.nPanelId ~= PanelId.CharEquipment then
    self._mapNode.safeAreaRoot.gameObject:SetActive(false)
  else
    self._mapNode.safeAreaRoot.gameObject:SetActive(true)
    CS.WwiseAudioManager.Instance:PostEvent("ui_charInfo_equipment_open")
    self:OnRefreshPanel()
    if self.nLastIndex and self.tbSlot and self.nLastIndex > 0 and self.tbSlot[self.nLastIndex].bUnlock and not PlayerData.Guide:CheckInGuideGroup(50) then
      local mapSelect = PlayerData.Equipment:GetEquipmentSelect()
      local mapUpgrade = PlayerData.Equipment:GetEquipmentUpgrade()
      if mapSelect and mapSelect.nCharId == self.nCharId then
        if self._mapNode.goEquipmentSlotItem[self.nLastIndex] then
          self._mapNode.goEquipmentSlotItem[self.nLastIndex]:SetChooseState(false)
        end
        bHasLastIndex = true
        local nEquipIndex = 0
        for k, v in ipairs(self.tbSlot) do
          if v.nSlotId == mapSelect.nSlotId then
            nEquipIndex = v.nGemIndex
            self.nLastIndex = k
            break
          end
        end
        if self._mapNode.goEquipmentSlotItem[self.nLastIndex] then
          self._mapNode.goEquipmentSlotItem[self.nLastIndex]:SetChooseState(true)
        end
        local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
          "CharEquipmentPanel_in"
        })
        
        local function ani()
          EventManager.Hit(EventId.OpenPanel, PanelId.EquipmentInfo, self.nCharId, mapSelect.nSlotId, nEquipIndex, mapSelect.nGemIndex)
        end
        
        self:AddTimer(1, nAnimTime, ani, true, true, true)
        EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
      elseif mapUpgrade and mapUpgrade.nCharId == self.nCharId then
        if self._mapNode.goEquipmentSlotItem[self.nLastIndex] then
          self._mapNode.goEquipmentSlotItem[self.nLastIndex]:SetChooseState(false)
        end
        bHasLastIndex = true
        for k, v in ipairs(self.tbSlot) do
          if v.nSlotId == mapUpgrade.nSlotId then
            self.nLastIndex = k
            break
          end
        end
        if self._mapNode.goEquipmentSlotItem[self.nLastIndex] then
          self._mapNode.goEquipmentSlotItem[self.nLastIndex]:SetChooseState(true)
        end
        do
          local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
            "CharEquipmentPanel_in"
          })
          
          local function ani()
            EventManager.Hit(EventId.OpenPanel, PanelId.EquipmentUpgrade, self.nCharId, mapUpgrade.nSlotId, mapUpgrade.nGemIndex, mapUpgrade.nSelectUpgradeIndex)
          end
          
          self:AddTimer(1, nAnimTime, ani, true, true, true)
          EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
        end
      end
    end
  end
  if not bHasLastIndex then
    self.nLastIndex = 0
  end
end

function CharEquipmentCtrl:OnDestroy()
  PlayerData.Equipment:ClearEquipmentSelect()
  PlayerData.Equipment:ClearEquipmentUpgrade()
  self.nLastIndex = 0
end

function CharEquipmentCtrl:OnBtnClick_EquipmentSlot(_, nIndex)
  if self.tbSlot[nIndex].bUnlock then
    EventManager.Hit(EventId.OpenPanel, PanelId.EquipmentInfo, self.nCharId, self.tbSlot[nIndex].nSlotId, self.tbSlot[nIndex].nGemIndex)
  else
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("Equipment_SlotLock"), self.tbSlot[nIndex].nLevel))
  end
  if nIndex == self.nLastIndex then
    return
  end
  if nil ~= self._mapNode.goEquipmentSlotItem[nIndex] then
    self._mapNode.goEquipmentSlotItem[nIndex]:SetChooseState(true)
  end
  if 0 ~= self.nLastIndex and nil ~= self._mapNode.goEquipmentSlotItem[self.nLastIndex] then
    self._mapNode.goEquipmentSlotItem[self.nLastIndex]:SetChooseState(false)
  end
  self.nLastIndex = nIndex
end

function CharEquipmentCtrl:OnBtnClick_Rename()
  local nSelect = PlayerData.Equipment:GetSelectPreset(self.nCharId)
  
  local function callback()
    self:RefreshPresetDD()
  end
  
  EventManager.Hit(EventId.OpenPanel, PanelId.EquipmentRename, self.nCharId, self.tbName[nSelect], callback)
end

function CharEquipmentCtrl:OnBtnClick_Preview()
  local tbEquipment = PlayerData.Equipment:GetEquipedGem(self.nCharId)
  if next(tbEquipment) == nil then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_CharEquipNone"))
  else
    EventManager.Hit(EventId.OpenPanel, PanelId.EquipmentAttrPreview, self.nCharId)
  end
end

function CharEquipmentCtrl:OnEvent_PresetSelect(nValue)
  local nIndex = nValue + 1
  local nSelect = PlayerData.Equipment:GetSelectPreset(self.nCharId)
  if nSelect == nIndex then
    return
  end
  if NovaAPI.IsEditorPlatform() and PlayerData.Equipment.isTestPresetTeam then
    PlayerData.Equipment.tbCharSelectPreset[self.nCharId] = nIndex
    self:RefreshPresetSlot()
    if self.nLastIndex and self.nLastIndex > 0 and nil ~= self._mapNode.goEquipmentSlotItem[self.nLastIndex] then
      self._mapNode.goEquipmentSlotItem[self.nLastIndex]:SetChooseState(true)
    end
    return
  end
  
  local function callback()
    self:RefreshPresetSlot()
    if self.nLastIndex and self.nLastIndex > 0 and nil ~= self._mapNode.goEquipmentSlotItem[self.nLastIndex] then
      self._mapNode.goEquipmentSlotItem[self.nLastIndex]:SetChooseState(true)
    end
  end
  
  PlayerData.Equipment:SendCharGemUsePresetReq(self.nCharId, nIndex, callback)
end

function CharEquipmentCtrl:OnEvent_PanelAdvance(nClosePanelId, nOpenPanelId)
  self:PlaySwitchAnim(nClosePanelId, nOpenPanelId)
end

function CharEquipmentCtrl:OnEvent_PanelBack(nClosePanelId, nOpenPanelId)
  self:PlaySwitchAnim(nClosePanelId, nOpenPanelId)
end

function CharEquipmentCtrl:OnEvent_RefreshPanel()
  if self._panel.nPanelId ~= PanelId.CharEquipment then
    return
  end
  self.nLastIndex = 0
  self:OnRefreshPanel()
end

return CharEquipmentCtrl
