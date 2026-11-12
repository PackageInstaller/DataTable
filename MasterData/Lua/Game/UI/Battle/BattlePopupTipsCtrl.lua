local BattlePopupTipsCtrl = class("BattlePopupTipsCtrl", BaseCtrl)
BattlePopupTipsCtrl._mapNodeConfig = {
  goTips = {sComponentName = "GameObject"},
  txtTips = {sComponentName = "TMP_Text"},
  imgBg = {
    sComponentName = "CanvasGroup"
  }
}
BattlePopupTipsCtrl._mapEventConfig = {BattlePopupTips = "PopupTips"}

function BattlePopupTipsCtrl:PopupTips(sLanguageId, nTime, bOpen)
  if self.timer1 ~= nil then
    self.timer1:Cancel(false)
    self.timer1 = nil
  end
  if self.timer2 ~= nil then
    self.timer2:Cancel(false)
    self.timer2 = nil
  end
  if bOpen == false then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.imgBg, 0)
    return
  end
  if not nTime or nTime == 0 then
    nTime = 0.5
  end
  self._mapNode.imgBg.alpha = 0
  NovaAPI.SetTMPText(self._mapNode.txtTips, ConfigTable.GetUIText(sLanguageId))
  self._mapNode.imgBg:DOFade(1, 0.2):SetUpdate(true)
  
  local function countdown()
    self.timer2 = self:AddTimer(1, nTime, function()
      self._mapNode.imgBg:DOFade(0, 0.2):SetUpdate(true)
    end, true, true, true)
  end
  
  self.timer1 = self:AddTimer(1, 0.2, countdown, true, true, true)
end

function BattlePopupTipsCtrl:Awake()
  self._mapNode.imgBg.alpha = 0
end

function BattlePopupTipsCtrl:OnEnable()
end

function BattlePopupTipsCtrl:OnDisable()
end

function BattlePopupTipsCtrl:OnDestroy()
end

return BattlePopupTipsCtrl
