local DormEditorPresetDetailCtrl = class("DormEditorPresetDetailCtrl", BaseCtrl)
local DefaultPath = "Icon/DormFurnitureSet/DormFurnitureSet_1001"
DormEditorPresetDetailCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Preset_DetailTitle"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickClose"
  },
  btnScreenClose = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickClose"
  },
  txtTitlePreview = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Detail_CoverTitle"
  },
  imgTitleImg = {sComponentName = "Image"},
  TMPRoomHint = {sComponentName = "TMP_Text"},
  txtTitleFurnitureList = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Detail_FurnitureTitle"
  },
  lsvList = {
    sComponentName = "LoopScrollView"
  },
  btnUnable = {sComponentName = "UIButton"},
  txtBtnUnable = {sComponentName = "TMP_Text"},
  btnApplyNow = {sComponentName = "UIButton"},
  txtBtnApplNow = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Preset_BtnApplNow"
  },
  btnApply = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnApply = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Preset_BtnUse"
  },
  txtPresetName = {sComponentName = "TMP_Text"},
  btnPresetName = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Rename"
  },
  Animator = {
    sNodeName = "---PresetDetail---",
    sComponentName = "Animator"
  }
}
DormEditorPresetDetailCtrl._mapEventConfig = {
  DormUpdatePresetNameSuc = "OnEvent_DormUpdatePresetNameSuc"
}
DormEditorPresetDetailCtrl._mapRedDotConfig = {}

function DormEditorPresetDetailCtrl:Awake()
  self.mapFurnitureCtrl = {}
end

function DormEditorPresetDetailCtrl:FadeIn()
end

function DormEditorPresetDetailCtrl:FadeOut()
end

function DormEditorPresetDetailCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  self.mapPreset = tbParam[1]
  self.bEnable = tbParam[2]
  self.bCur = false
  self.nRoom = tbParam[4]
  self.mapCurEnlabeCount = tbParam[5]
  self.callback = tbParam[6]
  local coverSprite = tbParam[7]
  self.bAllHave = true
  if coverSprite ~= nil then
    NovaAPI.SetImageSpriteAsset(self._mapNode.imgTitleImg, coverSprite)
  else
    self:SetPngSprite(self._mapNode.img_icon, DefaultPath)
  end
  local mapPreset = {}
  for _, mapFurnitur in ipairs(self.mapPreset.FurnitureList) do
    if mapPreset[mapFurnitur.FurnitureId] == nil then
      mapPreset[mapFurnitur.FurnitureId] = 0
    end
    mapPreset[mapFurnitur.FurnitureId] = mapPreset[mapFurnitur.FurnitureId] + 1
  end
  self.tbFurniture = {}
  for nFurnitureId, nCount in pairs(mapPreset) do
    local mapFurnitrueCfg = ConfigTable.GetData("DormFurniture", nFurnitureId)
    if mapFurnitrueCfg ~= nil and 1 > mapFurnitrueCfg.NotShow then
      table.insert(self.tbFurniture, {FurnitureId = nFurnitureId, nCount = nCount})
      if self.mapCurEnlabeCount[nFurnitureId] == nil or self.mapCurEnlabeCount[nFurnitureId] == 0 then
        self.bAllHave = false
      end
    end
  end
  self:Refresh()
  self._mapNode.Animator:Play("t_window_04_t_in")
end

function DormEditorPresetDetailCtrl:OnDisable()
  for _, mapCtrl in pairs(self.mapFurnitureCtrl) do
    self:UnbindCtrlByNode(mapCtrl)
  end
end

function DormEditorPresetDetailCtrl:OnDestroy()
end

function DormEditorPresetDetailCtrl:OnRelease()
end

function DormEditorPresetDetailCtrl:Refresh()
  local function sort(a, b)
    return a.FurnitureId < b.FurnitureId
  end
  
  table.sort(self.tbFurniture, sort)
  local sName = self.mapPreset.BuildName == "" and orderedFormat(ConfigTable.GetUIText("Dorm_PresetDefaultName"), self.mapPreset.BuildId) or self.mapPreset.BuildName
  NovaAPI.SetTMPText(self._mapNode.txtPresetName, sName)
  local sHint = orderedFormat(ConfigTable.GetUIText("Dorm_Preset_RoomHIntTitle"), ConfigTable.GetUIText("Dorm_RoomType" .. self.mapPreset.DormType))
  NovaAPI.SetTMPText(self._mapNode.TMPRoomHint, sHint)
  self._mapNode.lsvList:Init(#self.tbFurniture, self, self.OnGridRefresh, self.OnGriBtnClick)
  local nReason = self.mapPreset.DormType == 0 and 2 or 1
  NovaAPI.SetTMPText(self._mapNode.txtBtnUnable, ConfigTable.GetUIText("Dorm_SuitHint_RoomType" .. nReason))
  self._mapNode.btnApplyNow.gameObject:SetActive(self.bCur)
  self._mapNode.btnUnable.gameObject:SetActive(not self.bEnable)
  self._mapNode.btnApply.gameObject:SetActive(not self.bCur and self.bEnable)
end

function DormEditorPresetDetailCtrl:ClosePanel()
  self._mapNode.Animator:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.DormEditorPresetDetailPanel)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function DormEditorPresetDetailCtrl:OnGridRefresh(goGrid, nIdx)
  nIdx = nIdx + 1
  local nFurnitureId = self.tbFurniture[nIdx].FurnitureId
  local nInstanceId = goGrid:GetInstanceID()
  if self.mapFurnitureCtrl[nInstanceId] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.Dorm.DormEditor.TemplateDormFurnitureItem")
    self.mapFurnitureCtrl[nInstanceId] = mapCtrl
  end
  self.mapFurnitureCtrl[nInstanceId]:RefreshInSuitPreset(nFurnitureId, self.mapCurEnlabeCount[nFurnitureId] or 0, self.tbFurniture[nIdx].nCount, self.nRoom)
end

function DormEditorPresetDetailCtrl:OnGriBtnClick(goGrid, nIdx)
  local nInstanceId = goGrid:GetInstanceID()
  self.mapFurnitureCtrl[nInstanceId]:OnBtnClick_Info()
end

function DormEditorPresetDetailCtrl:OnBtnClick_Rename()
  local sName = self.mapPreset.BuildName == "" and orderedFormat(ConfigTable.GetUIText("Dorm_PresetDefaultName"), self.mapPreset.BuildId) or self.mapPreset.BuildName
  EventManager.Hit(EventId.OpenPanel, PanelId.DormPresetRenamePanel, self.mapPreset.BuildId, sName)
end

function DormEditorPresetDetailCtrl:OnBtn_ClickClose()
  if self.callback ~= nil and type(self.callback) == "function" then
    self.callback(false)
  end
  self:ClosePanel()
end

function DormEditorPresetDetailCtrl:OnBtnClick_Confirm()
  local function confirmCallback()
    if self.callback ~= nil and type(self.callback) == "function" then
      self.callback(true)
    end
    self:ClosePanel()
  end
  
  local sContent
  if self.bAllHave then
    sContent = ConfigTable.GetUIText("Dorm_PresetUseHint")
  else
    sContent = ConfigTable.GetUIText("Dorm_PresetUseLackHint")
  end
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sContent,
    callbackConfirmAfterClose = confirmCallback,
    bDisableSnap = false,
    bCloseNoHandler = true
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function DormEditorPresetDetailCtrl:OnEvent_DormUpdatePresetNameSuc(nBuildId, sName)
  if nBuildId == self.mapPreset.BuildId then
    self.mapPreset.BuildName = sName
    NovaAPI.SetTMPText(self._mapNode.txtPresetName, sName)
  end
end

return DormEditorPresetDetailCtrl
