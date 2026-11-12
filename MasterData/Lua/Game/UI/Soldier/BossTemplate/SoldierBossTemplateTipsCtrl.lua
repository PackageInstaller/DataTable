local SoldierBossTemplateTipsCtrl = class("SoldierBossTemplateTipsCtrl", BaseCtrl)
SoldierBossTemplateTipsCtrl._mapNodeConfig = {
  goBlur = {sNodeName = "blur"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  goContent = {
    sNodeName = "----SafeAreaRoot----"
  },
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BossTemplate_Title"
  },
  goBossTemplateItem = {
    sCtrlName = "Game.UI.Soldier.BossTemplate.SoldierBossTemplateItemCtrl"
  },
  txt_Empty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Stage_Click_Tips"
  }
}
SoldierBossTemplateTipsCtrl._mapEventConfig = {}
SoldierBossTemplateTipsCtrl._mapRedDotConfig = {}

function SoldierBossTemplateTipsCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nTemplateId = param[1]
  end
end

function SoldierBossTemplateTipsCtrl:OnEnable()
  self.animRoot = self.gameObject:GetComponent("Animator")
  self._mapNode.goContent:SetActive(false)
  self._mapNode.goBlur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goContent:SetActive(true)
    self:Refresh()
    self:PlayInAni()
  end
  
  cs_coroutine.start(wait)
end

function SoldierBossTemplateTipsCtrl:OnDisable()
end

function SoldierBossTemplateTipsCtrl:OnDestroy()
end

function SoldierBossTemplateTipsCtrl:Refresh()
  if self.nTemplateId == nil then
    return
  end
  local nUnlock = PlayerData.SoldierData:CheckBossTemplateUnlocked(self.nTemplateId) and 1 or 0
  self._mapNode.goBossTemplateItem:SetItemData({
    nId = self.nTemplateId,
    nUnlock = nUnlock
  })
end

function SoldierBossTemplateTipsCtrl:PlayInAni()
  if self.animRoot ~= nil then
    self.animRoot:Play("SoldierBossTemplateTips_in", 0, 0)
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function SoldierBossTemplateTipsCtrl:PlayOutAni(callback)
  if self.animRoot ~= nil then
    self.animRoot:Play("SoldierBossTemplateTips_out", 0, 0)
  end
  self:AddTimer(1, 0.2, callback, true, true, true)
end

function SoldierBossTemplateTipsCtrl:OnBtnClick_Close()
  local function callback()
    EventManager.Hit(EventId.ClosePanel, PanelId.SoldierBossTemplateTips)
  end
  
  self:PlayOutAni(callback)
end

return SoldierBossTemplateTipsCtrl
