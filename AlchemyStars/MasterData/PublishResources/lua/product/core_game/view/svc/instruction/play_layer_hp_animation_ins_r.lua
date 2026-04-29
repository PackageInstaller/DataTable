require("base_ins_r")
_class("PlayLayerHPAnimationInstruction", BaseInstruction)
PlayLayerHPAnimationInstruction = PlayLayerHPAnimationInstruction

function PlayLayerHPAnimationInstruction:Constructor(paramList)
  local tKvp = string.split(paramList.animClipNameMap, "|")
  assert(#tKvp % 2 == 0)
  self._animClipNameMap = {}
  for i = 1, #tKvp, 2 do
    self._animClipNameMap[tonumber(tKvp[i])] = tKvp[i + 1]
  end
end

function PlayLayerHPAnimationInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local cView = casterEntity:View()
  local udGo = cView:GetGameObject()
  if not udGo then
    return
  end
  local monoAnimation = udGo:GetComponent(typeof(UnityEngine.Animation))
  if not monoAnimation then
    return
  end
  monoAnimation:Stop()
  YIELD(TT)
  local cHP = casterEntity:HP()
  local hp = cHP:GetRedHP()
  if not self._animClipNameMap[hp] then
    return
  end
  local animClipName = self._animClipNameMap[hp]
  monoAnimation:Play(animClipName)
end
