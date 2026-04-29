_class("PieceAnimationData", Object)
PieceAnimationData = PieceAnimationData

function PieceAnimationData:Constructor()
  self._animationName = {}
  self._animationName.OffScreenNormal = "gezi_offscreen_normal"
  self._animationName.Normal = "gezi_normal"
  self._animationName.Down = "gezi_down"
  self._animationName.Up = "gezi_up"
  self._animationName.Dark = "gezi_dark"
  self._animationName.Birth = "gezi_birth"
  self._animationName.LinkIn = "gezi_linkin"
  self._animationName.LinkOut = "gezi_linkout"
  self._animationName.LinkDone = "gezi_linkdone"
  self._animationName.MoveDone = "gezi_movedown"
  self._animationName.AtkColor = "ult_preview_atk+coloring"
  self._animationName.Black = "gezi_ult_black"
  self._animationName.Color = "gezi_ult_color"
  self._animationName.Gray = "gezi_ult_gray"
  self._animationName.Invalid = "gezi_ult_invalid"
  self._animationName.Sliver = "gezi_ult_sliver"
  self._animationName.Add = "gezi_ult_add"
  self._animationName.Reflash = "gezi_ult_reflash"
end

function PieceAnimationData:GetAnimationName(state)
  return self._animationName[state]
end

function PieceAnimationData:GetAnimationNameByResName(resName)
  for animName, animResName in pairs(self._animationName) do
    if animResName == resName then
      return animName
    end
  end
end

function PieceAnimationData:GetAnimationNameList()
  return self._animationName
end

_class("PrismPieceAnimationData", PieceAnimationData)
PrismPieceAnimationData = PrismPieceAnimationData

function PrismPieceAnimationData:Constructor()
  self._animationName.Normal = "gezi_prism"
  self._animationName.Down = "gezi_prism_down"
  self._animationName.Up = "gezi_prism_up"
  self._animationName.Dark = "gezi_prism_dark"
  self._animationName.Invalid = "gezi_prism_none"
  self._animationName.LinkOut = "gezi_prism"
end
