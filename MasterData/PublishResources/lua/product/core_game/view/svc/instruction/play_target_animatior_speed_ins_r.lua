require("base_ins_r")
_class("PlayTargetAnimatiorSpeedInstruction", BaseInstruction)
PlayTargetAnimatiorSpeedInstruction = PlayTargetAnimatiorSpeedInstruction

function PlayTargetAnimatiorSpeedInstruction:Constructor(paramList)
  self._speed = tonumber(paramList.speed) or 1
end

function PlayTargetAnimatiorSpeedInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  if targetEntityID == nil or targetEntityID < 0 then
    return
  end
  local targetEntity = world:GetEntityByID(targetEntityID)
  local viewCmpt = targetEntity:View()
  if not viewCmpt then
    Log.fatal("view cmpt has been removed")
    return
  end
  local entityObj = viewCmpt:GetGameObject()
  local root = entityObj.transform:Find("Root")
  if not root then
    return
  end
  local animator = root:GetComponent(typeof(UnityEngine.Animator))
  if not animator then
    return
  end
  animator.speed = self._speed
end
