local DatingLandmarkCtrl = class("DatingLandmarkCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
DatingLandmarkCtrl._mapNodeConfig = {
  goBlur = {},
  canvasBlur = {sNodeName = "goBlur", sComponentName = "Canvas"},
  trRoot = {
    sNodeName = "----Actor2D_L2DInUI----",
    sComponentName = "Transform"
  },
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  SlipInOutAnim = {sComponentName = "Animator"},
  goContent = {
    sNodeName = "----SafeAreaRoot----"
  },
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Select_Landmark_Title"
  },
  goLandMarkItem = {nCount = 3},
  btnGoto = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Goto"
  },
  txtBtnGoto = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "Dating_Select_Landmark_Btn"
  },
  btnBack = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Back"
  }
}
DatingLandmarkCtrl._mapEventConfig = {
  [EventId.TransAnimInClear] = "OnEvent_TransAnimInClear",
  RefreshLandMark = "OnEvent_RefreshLandMark"
}

function DatingLandmarkCtrl:SetLandmarkList()
  self.tbLandmark = PlayerData.Dating:GetRandomLandmark(self.nCharId)
  for k, v in ipairs(self._mapNode.goLandMarkItem) do
    v.gameObject:SetActive(self.tbLandmark[k] ~= nil)
    if self.tbLandmark[k] ~= nil then
      self:SetLandmarkItem(self.tbLandmark[k], v)
    end
  end
end

function DatingLandmarkCtrl:SetLandmarkItem(mapCfg, objItem)
  local imgLandmark = objItem.transform:Find("mask/imgLandmark"):GetComponent("Image")
  local txtName = objItem.transform:Find("txtName"):GetComponent("TMP_Text")
  local txtDesc = objItem.transform:Find("txtDesc"):GetComponent("TMP_Text")
  local imgTag = objItem.transform:Find("imgTag")
  local txtTag = objItem.transform:Find("imgTag/txtTag"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtTag, ConfigTable.GetUIText("Phone_Dating_Special_Event_Title"))
  NovaAPI.SetTMPText(txtName, mapCfg.Name)
  NovaAPI.SetTMPText(txtDesc, mapCfg.Desc)
  self:SetPngSprite(imgLandmark, mapCfg.Icon)
  local bHasNew = PlayerData.Dating:CheckHasNewEvent(self.nCharId, mapCfg.Id)
  imgTag.gameObject:SetActive(bHasNew)
end

function DatingLandmarkCtrl:Awake()
end

function DatingLandmarkCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nCharId = tbParam[1]
  end
  self._mapNode.goContent.gameObject:SetActive(false)
  self._mapNode.goBlur.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goContent.gameObject:SetActive(true)
    local bL2d = LocalSettingData.mapData.UseLive2D
    self._mapNode.trRoot.gameObject:SetActive(bL2d)
    self._mapNode.trActor2D_PNG.gameObject:SetActive(not bL2d)
    if bL2d then
      Actor2DManager.SetActor2DInUI(self:GetPanelId(), self._mapNode.trRoot, self.nCharId, nil, true)
    else
      Actor2DManager.SetActor2D_PNG(self._mapNode.trActor2D_PNG, self:GetPanelId(), self.nCharId, nil)
    end
    self:SetLandmarkList()
    EventManager.Hit("RefreshSortingOrder", -100)
    NovaAPI.SetCanvasSortingName(self._mapNode.canvasBlur, self._panel._sSortingLayerName)
  end
  
  cs_coroutine.start(wait)
end

function DatingLandmarkCtrl:OnDisable()
end

function DatingLandmarkCtrl:OnDestroy()
end

function DatingLandmarkCtrl:OnBtnClick_Goto(btn, nIndex)
  self.curAffinityInfo = PlayerData.Char:GetCharAffinityData(self.nCharId)
  
  local function callback(msgData)
    self.datingData = msgData
    EventManager.Hit(EventId.SetTransition, 11)
  end
  
  self.nLandmarkId = self.tbLandmark[nIndex].Id
  PlayerData.Dating:SendDatingLandmarkSelectMsg(self.nCharId, self.nLandmarkId, callback)
  for k, v in pairs(self._mapNode.btnGoto) do
    v.interactable = false
  end
end

function DatingLandmarkCtrl:OnBtnClick_Back()
  EventManager.Hit(EventId.ClosePanel, PanelId.DatingLandmark)
  EventManager.Hit("RefreshSortingOrder")
end

function DatingLandmarkCtrl:OnEvent_TransAnimInClear()
  EventManager.Hit(EventId.ClosePanel, PanelId.DatingLandmark)
  EventManager.Hit("RefreshSortingOrder")
  EventManager.Hit(EventId.OpenPanel, PanelId.Dating, self.nLandmarkId, self.nCharId, self.datingData.BeforeBranchId, self.curAffinityInfo, self.datingData.BranchAOptionIds, self.datingData.Change)
end

function DatingLandmarkCtrl:OnEvent_RefreshLandMark()
  self:SetLandmarkList()
  EventManager.Hit("RefreshSortingOrder", -100)
  NovaAPI.SetCanvasSortingName(self._mapNode.canvasBlur, self._panel._sSortingLayerName)
end

return DatingLandmarkCtrl
