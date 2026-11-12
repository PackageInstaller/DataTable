local BaseCtrl = require("Game.UI.CommonTipsEx.CommonTipsBaseCtrl")
local TowerDefTipsCtrl = class("TowerDefTipsCtrl", BaseCtrl)
TowerDefTipsCtrl._mapNodeConfig = {
  btnCloseTips = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClosePanel"
  },
  rtContent = {
    sComponentName = "RectTransform"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  txtName = {sComponentName = "TMP_Text"},
  txtDesc = {sComponentName = "TMP_Text"},
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_ClosePanel"
  }
}
TowerDefTipsCtrl._mapEventConfig = {}

function TowerDefTipsCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.rtTarget = tbParam[1]
    self.name = tbParam[2]
    self.des = tbParam[3]
  end
end

function TowerDefTipsCtrl:FadeIn()
end

function TowerDefTipsCtrl:FadeOut()
end

function TowerDefTipsCtrl:OnEnable()
  self:EnableGamepadUI(self._mapNode.btnShortcutClose)
  self.sortingOrder = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
  NovaAPI.SetComponentEnableByName(self.rtTarget.gameObject, "TopGridCanvas", true)
  NovaAPI.SetTopGridCanvasSorting(self.rtTarget.gameObject, self.sortingOrder)
  NovaAPI.SetTMPText(self._mapNode.txtName, self.name)
  NovaAPI.SetTMPText(self._mapNode.txtDesc, self.des)
  self._mapNode.rtContent.gameObject:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self:SetTipsPosition(self.rtTarget, self._mapNode.rtContent, self._mapNode.safeAreaRoot)
    self._mapNode.rtContent.gameObject:SetActive(true)
  end
  
  cs_coroutine.start(wait)
end

function TowerDefTipsCtrl:OnDisable()
  self:DisableGamepadUI()
end

function TowerDefTipsCtrl:OnDestroy()
end

function TowerDefTipsCtrl:OnRelease()
end

function TowerDefTipsCtrl:OnBtnClick_ClosePanel(btn)
  if self.rtTarget and not self.rtTarget:IsNull() then
    NovaAPI.SetComponentEnableByName(self.rtTarget.gameObject, "TopGridCanvas", false)
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.TowerDefenseTipsPanel)
end

return TowerDefTipsCtrl
