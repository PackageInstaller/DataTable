local ReengagementPopUpCtrl = class("ReengagementPopUpCtrl", BaseCtrl)
local sPrefabFolder = "UI_Activity/%s.prefab"
ReengagementPopUpCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  goContent = {
    sNodeName = "---Content---"
  },
  PopUpRoot = {
    sNodeName = "---PopUpRoot---",
    sComponentName = "RectTransform"
  }
}
ReengagementPopUpCtrl._mapEventConfig = {}
ReengagementPopUpCtrl._mapRedDotConfig = {}

function ReengagementPopUpCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    local mapData = tbParam[1]
    if type(mapData) == "table" then
      self.nActId = mapData.nActId or mapData[1]
    else
      self.nActId = mapData
    end
    self.callback = tbParam[2]
  end
end

function ReengagementPopUpCtrl:OnEnable()
  self._mapNode.goContent.gameObject:SetActive(false)
  self._mapNode.PopUpRoot.gameObject:SetActive(false)
  self._mapNode.imgBlurredBg.gameObject:SetActive(true)
  self:ShowPopUp()
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.PopUpRoot.gameObject:SetActive(self.curPopUpCtrl ~= nil)
  end
  
  cs_coroutine.start(wait)
end

function ReengagementPopUpCtrl:OnDisable()
  self:ResetContent()
end

function ReengagementPopUpCtrl:OnDestroy()
end

function ReengagementPopUpCtrl:ResetContent()
  if self.curPopUpCtrl ~= nil then
    destroy(self.curPopUpCtrl.gameObject)
    self:UnbindCtrlByNode(self.curPopUpCtrl)
  end
  self.curPopUpCtrl = nil
end

function ReengagementPopUpCtrl:ShowPopUp()
  if self.nActId == nil then
    self:ClosePopUp()
    return
  end
  local mapPopUpCfg = ConfigTable.GetData("ActivityReturneeLoginRewardControl", self.nActId)
  if mapPopUpCfg == nil or mapPopUpCfg.UIAssets == nil or mapPopUpCfg.UIAssets == "" or mapPopUpCfg.CtrlName == nil or mapPopUpCfg.CtrlName == "" then
    self:ClosePopUp()
    return
  end
  self:ResetContent()
  local sPrefabPath = string.format(sPrefabFolder, mapPopUpCfg.UIAssets)
  local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.PopUpRoot)
  local sCtrlPath = string.format("Game.UI.Activity.%s", mapPopUpCfg.CtrlName)
  self.curPopUpCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
  
  local function callback(funcCall, bPauseQueue)
    self:ClosePopUp(funcCall, bPauseQueue)
  end
  
  self.curPopUpCtrl:ShowPopUp(self.nActId, callback, 1)
end

function ReengagementPopUpCtrl:ClosePopUp(funcCall, bPauseQueue)
  self:ResetContent()
  EventManager.Hit(EventId.ClosePanel, PanelId.ReengagementPopUpPanel)
  if bPauseQueue then
    if funcCall ~= nil then
      funcCall()
    end
    return
  end
  if self.callback ~= nil then
    self.callback(funcCall)
  elseif funcCall ~= nil then
    funcCall()
  end
end

return ReengagementPopUpCtrl
