local DormEditorSuitDetailCtrl = class("DormEditorSuitDetailCtrl", BaseCtrl)
local DefaultPath = "Icon/DormFurnitureSet/DormFurnitureSet_1001"
DormEditorSuitDetailCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Suit_DetailTitle"
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
  imgTag = {},
  imgMaskTag = {},
  TMPTagName = {sComponentName = "TMP_Text"},
  txtTitleFurnitureList = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Detail_FurnitureTitle"
  },
  txtTitleFurnitureNum = {sComponentName = "TMP_Text"},
  lsvList = {
    sComponentName = "LoopScrollView"
  },
  btnUnApply = {sComponentName = "UIButton"},
  txtBtnUnApply = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Preset_BtnApplNow"
  },
  btnReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  btnApply = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnApply = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Preset_BtnUse"
  },
  btnGet = {sComponentName = "UIButton"},
  txtBtnGet = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_SuitDetail_BtnGet"
  },
  btnGet2 = {sComponentName = "UIButton"},
  txtBtnGet2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_SuitDetail_BtnGet"
  },
  TMPSuitName = {sComponentName = "TMP_Text"},
  detailDesc = {sComponentName = "TMP_Text"},
  txtTips = {sComponentName = "TMP_Text"},
  Animator = {
    sNodeName = "---PresetDetail---",
    sComponentName = "Animator"
  },
  rtBtns = {}
}
DormEditorSuitDetailCtrl._mapEventConfig = {}
DormEditorSuitDetailCtrl._mapRedDotConfig = {}

function DormEditorSuitDetailCtrl:Awake()
  self.mapFurnitureCtrl = {}
end

function DormEditorSuitDetailCtrl:FadeIn()
end

function DormEditorSuitDetailCtrl:FadeOut()
end

function DormEditorSuitDetailCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  self.nSuitId = tbParam[1]
  self.tbSuitFurniture = tbParam[2]
  self.mapCurCount = tbParam[3]
  self.nRoom = tbParam[4]
  self.mapTotalCount = tbParam[5]
  self.bCur = false
  self.callback = tbParam[7]
  self.nTotalCount = 0
  self.nCurCount = 0
  self.bNotHave = true
  self.mapSuitCfgData = ConfigTable.GetData("DormLayoutReward", self.nSuitId)
  local mapPreset = {}
  for _, mapFurnitur in ipairs(self.tbSuitFurniture) do
    local mapFurnitureCfg = ConfigTable.GetData("DormFurniture", mapFurnitur.FurnitureId)
    if mapFurnitureCfg ~= nil and 1 > mapFurnitureCfg.NotShow then
      if mapPreset[mapFurnitur.FurnitureId] == nil then
        mapPreset[mapFurnitur.FurnitureId] = 0
      end
      self.nTotalCount = self.nTotalCount + 1
      mapPreset[mapFurnitur.FurnitureId] = mapPreset[mapFurnitur.FurnitureId] + 1
    end
  end
  for nFurnitureId, nCount in pairs(self.mapCurCount) do
    local mapFurnitureCfg = ConfigTable.GetData("DormFurniture", nFurnitureId)
    if mapFurnitureCfg ~= nil and 1 > mapFurnitureCfg.NotShow then
      local nNeedCount = mapPreset[nFurnitureId] == nil and 0 or mapPreset[nFurnitureId]
      if PlayerData.PlayerDormData:CheckGetFurnitureById(nFurnitureId) then
        self.bNotHave = false
      end
      self.nCurCount = self.nCurCount + math.min(nNeedCount, nCount)
    end
  end
  self.tbFurniture = {}
  for nFurnitureId, nCount in pairs(mapPreset) do
    local mapFurnitureCfg = ConfigTable.GetData("DormFurniture", nFurnitureId)
    if mapFurnitureCfg ~= nil and mapFurnitureCfg.NotShow == 0 then
      table.insert(self.tbFurniture, {FurnitureId = nFurnitureId, nCount = nCount})
    end
  end
  self:Refresh()
  self._mapNode.Animator:Play("t_window_04_t_in")
end

function DormEditorSuitDetailCtrl:OnDisable()
  for _, mapCtrl in pairs(self.mapFurnitureCtrl) do
    self:UnbindCtrlByNode(mapCtrl)
  end
end

function DormEditorSuitDetailCtrl:OnDestroy()
end

function DormEditorSuitDetailCtrl:OnRelease()
end

function DormEditorSuitDetailCtrl:Refresh()
  local function sort(a, b)
    return a.FurnitureId < b.FurnitureId
  end
  
  table.sort(self.tbFurniture, sort)
  if self.mapSuitCfgData ~= nil then
    self:SetPngSprite(self._mapNode.imgTitleImg, self.mapSuitCfgData.RoomLayoutListIcon .. "_big")
    NovaAPI.SetTMPText(self._mapNode.TMPSuitName, self.mapSuitCfgData.RoomLayoutName)
    NovaAPI.SetTMPText(self._mapNode.detailDesc, self.mapSuitCfgData.RoomLayoutDesc)
    self._mapNode.imgTag:SetActive(self.mapSuitCfgData.RoomLayoutTag ~= "")
    NovaAPI.SetTMPText(self._mapNode.TMPTagName, self.mapSuitCfgData.RoomLayoutTag)
    NovaAPI.SetTMPText(self._mapNode.txtTips, self.mapSuitCfgData.GetWay)
  end
  local bReward = true
  for _, mapFurniture in ipairs(self.tbFurniture) do
    if self.mapTotalCount[mapFurniture.FurnitureId] == nil or self.mapTotalCount[mapFurniture.FurnitureId] < mapFurniture.nCount then
      bReward = false
      break
    end
  end
  bReward = bReward and not PlayerData.PlayerDormData:CheckLayoutReceived(self.nSuitId)
  self._mapNode.btnReward.gameObject:SetActive(bReward)
  NovaAPI.SetTMPText(self._mapNode.txtTitleFurnitureNum, orderedFormat("{0}/{1}", math.min(self.nCurCount, self.nTotalCount), self.nTotalCount))
  self._mapNode.lsvList:Init(#self.tbFurniture, self, self.OnGridRefresh, self.OnGridBtnClick)
  local mapRoomConfig
  local bEnable = false
  if self.nRoom > 0 then
    mapRoomConfig = ConfigTable.GetData("DormRoom", self.nRoom)
    if mapRoomConfig ~= nil then
      bEnable = mapRoomConfig.RoomType == self.mapSuitCfgData.RoomType
    end
  end
  local bAllHave = self.nCurCount >= self.nTotalCount
  self._mapNode.btnGet.gameObject:SetActive(self.mapSuitCfgData.JumpTo ~= 0 and not bAllHave)
  self._mapNode.btnGet2.gameObject:SetActive(self.mapSuitCfgData.JumpTo ~= 0 and self.bNotHave)
  self._mapNode.btnUnApply.gameObject:SetActive(not bEnable and not self.bNotHave)
  self._mapNode.btnApply.gameObject:SetActive(bEnable and not self.bNotHave)
  self._mapNode.txtTips.gameObject:SetActive(self.bNotHave and self.mapSuitCfgData.JumpTo == 0)
  self._mapNode.rtBtns:SetActive(self.nRoom > 0)
  if not bEnable then
    local sHint = orderedFormat(ConfigTable.GetUIText("Dorm_Preset_RoomHIntTitle"), ConfigTable.GetUIText("Dorm_RoomType" .. self.mapSuitCfgData.RoomType))
    NovaAPI.SetTMPText(self._mapNode.txtBtnUnApply, sHint)
  else
    NovaAPI.SetTMPText(self._mapNode.txtBtnUnApply, ConfigTable.GetUIText("Dorm_BtnState_Cur"))
  end
end

function DormEditorSuitDetailCtrl:OnGridRefresh(goGrid, nIdx)
  nIdx = nIdx + 1
  local nFurnitureId = self.tbFurniture[nIdx].FurnitureId
  local nInstanceId = goGrid:GetInstanceID()
  if self.mapFurnitureCtrl[nInstanceId] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.Dorm.DormEditor.TemplateDormFurnitureItem")
    self.mapFurnitureCtrl[nInstanceId] = mapCtrl
  end
  local nCurCount = self.mapCurCount[nFurnitureId] or 0
  self.mapFurnitureCtrl[nInstanceId]:RefreshInSuitPreset(nFurnitureId, nCurCount, self.tbFurniture[nIdx].nCount, self.nRoom)
end

function DormEditorSuitDetailCtrl:OnGridBtnClick(goGrid, nIdx)
  local nInstanceId = goGrid:GetInstanceID()
  self.mapFurnitureCtrl[nInstanceId]:OnBtnClick_Info()
end

function DormEditorSuitDetailCtrl:ClosePanel()
  self._mapNode.Animator:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.DormEditorSuitDetailPanel)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function DormEditorSuitDetailCtrl:OnBtn_ClickClose()
  if self.callback ~= nil and type(self.callback) == "function" then
    self.callback(false)
  end
  self:ClosePanel()
end

function DormEditorSuitDetailCtrl:OnBtnClick_Confirm()
  local function confirmCallback()
    if self.callback ~= nil and type(self.callback) == "function" then
      self.callback(true)
    end
    self:ClosePanel()
  end
  
  local sContent
  if self.nCurCount >= self.nTotalCount then
    sContent = ConfigTable.GetUIText("Dorm_Set_UseHint")
  else
    sContent = ConfigTable.GetUIText("Dorm_Set_UseLackHint")
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

function DormEditorSuitDetailCtrl:OnBtnClick_Reward()
  local function callback(changeInfo, _)
    self._mapNode.btnReward.gameObject:SetActive(false)
    
    UTILS.OpenReceiveByChangeInfo(changeInfo)
  end
  
  PlayerData.PlayerDormData:DormLayoutRewardReceive({
    self.nSuitId
  }, callback)
end

return DormEditorSuitDetailCtrl
