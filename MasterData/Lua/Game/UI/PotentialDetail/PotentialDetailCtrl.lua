local PotentialDetailCtrl = class("PotentialDetailCtrl", BaseCtrl)
PotentialDetailCtrl._mapNodeConfig = {
  aniBlur = {sComponentName = "Animator"},
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  animDetail = {sNodeName = "goDetail", sComponentName = "Animator"},
  goDetail = {},
  potentialDetail = {
    sCtrlName = "Game.UI.StarTower.Potential.PotentialCardItemCtrl"
  },
  txtTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Close_Tip"
  },
  btnChangeDesc = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeDesc"
  },
  txtDescChange = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Change_Desc"
  },
  imgSwitchOn = {},
  imgSwitchOff = {}
}
PotentialDetailCtrl._mapEventConfig = {}

function PotentialDetailCtrl:Open()
  self._mapNode.btnChangeDesc.gameObject:SetActive(false)
  self._mapNode.aniBlur.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.btnChangeDesc.gameObject:SetActive(true)
  end
  
  cs_coroutine.start(wait)
  self:PlayInAni()
  self:Refresh()
end

function PotentialDetailCtrl:PlayInAni()
  self._mapNode.goDetail:SetActive(true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function PotentialDetailCtrl:PlayOutAni()
  self._mapNode.animDetail:Play("goCardDetail_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animDetail, {
    "goCardDetail_out"
  })
  self:AddTimer(1, nAnimLen, "Close", true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
end

function PotentialDetailCtrl:Close()
  self._mapNode.goDetail:SetActive(false)
  EventManager.Hit(EventId.ClosePanel, PanelId.PotentialDetail)
end

function PotentialDetailCtrl:Refresh()
  self._mapNode.potentialDetail:SetPotentialItem(self.nId, self.nLevel, nil, self.bSimple, false, self.nAddLv, AllEnum.PotentialCardType.Detial)
  self._mapNode.potentialDetail:ChangeWordRaycast(true)
end

function PotentialDetailCtrl:SetSimpleState()
  self._mapNode.imgSwitchOff.gameObject:SetActive(not self.bSimple)
  self._mapNode.imgSwitchOn.gameObject:SetActive(self.bSimple)
end

function PotentialDetailCtrl:Awake()
  self._mapNode.goDetail:SetActive(false)
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nId = tbParam[1]
    self.nLevel = tbParam[2]
    self.nAddLv = tbParam[3]
  end
  if not self.nLevel then
    self.nLevel = 1
  end
  if not self.nAddLv then
    local mapCfg = ConfigTable.GetData("Potential", self.nId)
    if mapCfg then
      local tbPotentialAddLv = PlayerData.Char:GetCharEnhancedPotential(mapCfg.CharId)
      self.nAddLv = tbPotentialAddLv[self.nId] or 0
    end
  end
end

function PotentialDetailCtrl:OnEnable()
  self.bSimple = PlayerData.StarTower:GetPotentialDescSimple()
  self:SetSimpleState()
  self:Open()
end

function PotentialDetailCtrl:OnDisable()
end

function PotentialDetailCtrl:OnDestroy()
end

function PotentialDetailCtrl:OnBtnClick_Close()
  self:PlayOutAni()
end

function PotentialDetailCtrl:OnBtnClick_ChangeDesc()
  self.bSimple = not self.bSimple
  PlayerData.StarTower:SetPotentialDescSimple(self.bSimple)
  self:SetSimpleState()
  self._mapNode.potentialDetail:ChangeDesc(self.bSimple)
end

return PotentialDetailCtrl
