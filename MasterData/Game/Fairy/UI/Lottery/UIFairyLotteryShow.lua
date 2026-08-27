local base = UIBaseWindow
local UIFairyLotteryShow = class("UIFairyLotteryShow", UIBaseWindow)
local cs_Ease = CS.DG.Tweening.Ease
local cs_DoTween = CS.DG.Tweening.DOTween

function UIFairyLotteryShow:OnInit()
  UIUtil.SetTopStatus(self, self.__OnClickClose, nil, nil, nil, true)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_mask, self, self.__Skip)
end

function UIFairyLotteryShow:InitFairyLotteryShow(callback)
  self.callback = callback
  self.ui.fXP_ChouKa_Fairy:Stop()
  self.ui.core.color = Color.New(1, 1, 1, 0.7)
  self.ui.core.gameObject.transform.localScale = Vector2.New(0.8, 0.8)
  self.sequence = cs_DoTween.Sequence()
  self.sequence:Append(self.ui.core.gameObject.transform:DOScale(0, 0.5):From():SetEase(cs_Ease.OutSine))
  self.sequence:Join(self.ui.core:DOFade(0, 0.5):From():SetEase(cs_Ease.OutSine))
  self.sequence:InsertCallback(0.1, function()
    self.ui.fXP_ChouKa_Fairy:Play()
  end)
  self.sequence:AppendInterval(0.8)
  self.sequence:Append(self.ui.core:DOFade(0, 0.4):SetEase(cs_Ease.OutSine))
  self.sequence:AppendInterval(1.4000000000000001)
  self.sequence:AppendCallback(function()
    if callback ~= nil then
      callback()
      self.callback = nil
    end
  end)
  self.sequence:OnComplete(function()
    UIUtil.OnClickBackByUiTab(self)
  end)
  self.sequence:SetAutoKill(true)
  self.sequence:Play()
end

function UIFairyLotteryShow:__Skip()
  UIUtil.OnClickBackByUiTab(self)
end

function UIFairyLotteryShow:__OnClickClose()
  if self.sequence ~= nil and self.sequence:IsPlaying() then
    self.sequence:Complete(true)
    self.sequence = nil
    if self.callback ~= nil then
      self.callback()
      self.callback = nil
    end
  end
  self:Delete()
end

function UIFairyLotteryShow:OnDelete()
  base.OnDelete(self)
end

return UIFairyLotteryShow
