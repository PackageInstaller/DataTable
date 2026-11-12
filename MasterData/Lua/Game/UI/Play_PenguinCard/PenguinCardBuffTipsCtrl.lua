local PenguinCardBuffTipsCtrl = class("PenguinCardBuffTipsCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
PenguinCardBuffTipsCtrl._mapNodeConfig = {
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  imgIcon = {sComponentName = "Image"},
  txtName = {sComponentName = "TMP_Text"},
  txtDesc = {sComponentName = "TMP_Text"}
}
PenguinCardBuffTipsCtrl._mapEventConfig = {PenguinCard_OpenBuffTips = "Open"}

function PenguinCardBuffTipsCtrl:Open(mapBuff, callback)
  self._panel.mapLevel:Pause()
  self.callback = callback
  self:Refresh(mapBuff)
  self:PlayInAni()
end

function PenguinCardBuffTipsCtrl:Refresh(mapBuff)
  local sSuffix = ""
  if mapBuff.nDurationType == GameEnum.PenguinCardBuffDuration.Count then
    sSuffix = orderedFormat(ConfigTable.GetUIText("PenguinCard_BuffDescSuffix_Count"), mapBuff.nDurationParam - mapBuff.nDurationCount)
  elseif mapBuff.nDurationType == GameEnum.PenguinCardBuffDuration.Turn then
    sSuffix = orderedFormat(ConfigTable.GetUIText("PenguinCard_BuffDescSuffix_Turn"), mapBuff.nDurationParam - mapBuff.nDurationCount)
  elseif mapBuff.nDurationType == GameEnum.PenguinCardBuffDuration.Round then
    sSuffix = orderedFormat(ConfigTable.GetUIText("PenguinCard_BuffDescSuffix_Round"), mapBuff.nDurationParam - mapBuff.nDurationCount)
  end
  NovaAPI.SetTMPText(self._mapNode.txtDesc, mapBuff:GetDesc() .. sSuffix)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapBuff.sName)
  self:SetSprite(self._mapNode.imgIcon, "UI/Play_PenguinCard/SpriteAtlas/Sprite/" .. mapBuff.sIcon)
end

function PenguinCardBuffTipsCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function PenguinCardBuffTipsCtrl:Close()
  if self.callback then
    self.callback()
  end
  self.animator:Play("PengUinCard_BuffTips_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.333)
  self:AddTimer(1, 0.333, function()
    self.gameObject:SetActive(false)
    self._panel.mapLevel:Resume()
  end, true, true, true)
end

function PenguinCardBuffTipsCtrl:Awake()
  self.animator = self.gameObject:GetComponent("Animator")
end

function PenguinCardBuffTipsCtrl:OnEnable()
end

function PenguinCardBuffTipsCtrl:OnDisable()
end

function PenguinCardBuffTipsCtrl:OnBtnClick_Close()
  self:Close()
end

return PenguinCardBuffTipsCtrl
