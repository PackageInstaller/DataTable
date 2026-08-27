local AvgImgTweenUntil = {}
local eAvgImgPosType = require("Game.Avg.Enum.eAvgImgPosType")
local eAvgImgType = require("Game.Avg.Enum.eAvgImgType")
local CS_DOTween = CS.DG.Tweening.DOTween
local CS_RotateMode = CS.DG.Tweening.RotateMode

function AvgImgTweenUntil.Tween(imgItem, tweenCfg)
  local transform = imgItem.transform
  local rawImg = imgItem.ui.rawImg
  local imgType = imgItem:GetAvgImgType()
  local sequence = imgItem:GetAvgImgSequence()
  if sequence == nil then
    sequence = CS_DOTween.Sequence()
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
    if avgCtrl ~= nil then
      sequence:SetUpdate(avgCtrl:AvgIgnoreTimeScale())
    end
  end
  local delay = tweenCfg.delay or 0
  local duration = tweenCfg.duration or 0
  local picPosData, pos
  if tweenCfg.posId ~= nil then
    if imgType == eAvgImgType.Character then
      if picPosData == nil then
        picPosData = imgItem:GetAvgHeroPicResetData(tweenCfg.posId)
      end
      if picPosData ~= nil then
        pos = picPosData.pos
      end
    else
      pos = eAvgImgPosType[tweenCfg.posId]
    end
  elseif tweenCfg.pos ~= nil then
    pos = Vector3.New(tweenCfg.pos[1], tweenCfg.pos[2], tweenCfg.pos[3])
  end
  if pos ~= nil then
    local tween = transform:DOLocalMove(pos, duration)
    sequence:Insert(delay, tween)
  end
  if tweenCfg.rot ~= nil then
    local rot = Vector3.New(tweenCfg.rot[1], tweenCfg.rot[2], tweenCfg.rot[3])
    local tween = transform:DOLocalRotate(rot, duration, CS_RotateMode.FastBeyond360)
    sequence:Insert(delay, tween)
  end
  local scale
  if tweenCfg.posId ~= nil and imgType == eAvgImgType.Character then
    if picPosData == nil then
      picPosData = imgItem:GetAvgHeroPicResetData(tweenCfg.posId)
    end
    if picPosData ~= nil then
      scale = picPosData.scale
    end
  elseif tweenCfg.scale ~= nil then
    scale = Vector3.New(tweenCfg.scale[1], tweenCfg.scale[2], tweenCfg.scale[3])
  end
  if scale ~= nil then
    local tween = transform:DOScale(scale, duration)
    sequence:Insert(delay, tween)
  end
  local color
  if tweenCfg.posId ~= nil and imgType == eAvgImgType.Character then
    if picPosData == nil then
      picPosData = imgItem:GetAvgHeroPicResetData(tweenCfg.posId)
    end
    if picPosData ~= nil then
      color = rawImg.color
      color.a = picPosData.alpha
    end
  end
  if tweenCfg.alpha ~= nil then
    if color == nil then
      color = rawImg.color
    end
    color.a = tweenCfg.alpha
  end
  if tweenCfg.isDark ~= nil then
    local value = tweenCfg.isDark and 0.5 or 1
    if color == nil then
      color = rawImg.color
    end
    color.r = value
    color.g = value
    color.b = value
  end
  if color ~= nil then
    local tween = rawImg:DOColor(color, duration)
    sequence:Insert(delay, tween)
  end
  if tweenCfg.shake ~= nil then
    local shakeIntensity = tweenCfg.shakeIntensity or 1
    local tween = transform:DOShakePosition(duration, Vector3.New(10, 10, 0) * shakeIntensity, 20 * shakeIntensity)
    sequence:Insert(delay, tween)
  end
  if tweenCfg.dissolve ~= nil and imgItem.AvgHeroDissolveTween ~= nil then
    local tween = imgItem:AvgHeroDissolveTween(duration)
    if tween ~= nil then
      sequence:Insert(delay, tween)
    end
  end
  imgItem:SetAvgImgSequence(sequence)
end

return AvgImgTweenUntil
