local UINTweenUtil = {}
local cs_Tweening = CS.DG.Tweening
local cs_DOTween = cs_Tweening.DOTween

function UINTweenUtil.CreateExpBarSequence(target, expDiffData, onStart, onComplete, onAppendCallBack)
  local oldLevel = expDiffData.oldLevel
  local oldRate = expDiffData.oldRate
  local level = expDiffData.level
  local rate = expDiffData.rate
  local tempLevel = oldLevel
  local lvDiff = level - oldLevel
  target.fillAmount = oldRate
  local Sequence = cs_DOTween.Sequence()
  Sequence:InsertCallback(0, onStart)
  for i = 1, lvDiff do
    Sequence:Append(target:DOFillAmount(1, 0.5 / lvDiff))
    Sequence:AppendCallback(function()
      target.fillAmount = 0
      tempLevel = tempLevel + 1
      if onAppendCallBack ~= nil then
        onAppendCallBack(tempLevel, 0.5 / lvDiff)
      end
    end)
    Sequence:AppendInterval(0.5 / lvDiff)
  end
  Sequence:Append(target:DOFillAmount(rate, 0.5))
  Sequence:OnComplete(onComplete)
  return Sequence
end

return UINTweenUtil
