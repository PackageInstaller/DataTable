require("base_ins_r")
_class("PlayCasterBoneSRTInstruction", BaseInstruction)
PlayCasterBoneSRTInstruction = PlayCasterBoneSRTInstruction

function PlayCasterBoneSRTInstruction:Constructor(paramList)
  self._bone = paramList.bone
  self._SRT = paramList.SRT
  self._changeValueFlag = 0
  
  local function SetSRT(arr)
    if self._SRT == "S" then
      self._scale = Vector3(tonumber(arr[1]), tonumber(arr[2]), tonumber(arr[3]))
    elseif self._SRT == "R" then
      local count = table.count(arr)
      if count == 3 then
        self._rotation = Quaternion.Euler(tonumber(arr[1]), tonumber(arr[2]), tonumber(arr[3]))
      elseif count == 4 then
        self._rotation = Quaternion(tonumber(arr[1]), tonumber(arr[2]), tonumber(arr[3]), tonumber(arr[4]))
      else
        Log.fatal("### SetSRT")
      end
    elseif self._SRT == "T" then
      self._translation = Vector3(tonumber(arr[1]), tonumber(arr[2]), tonumber(arr[3]))
    end
  end
  
  local strParamDelta = paramList.delta
  if strParamDelta then
    local arrDelta = string.split(strParamDelta, "|")
    SetSRT(arrDelta)
    self._changeValueFlag = 0
  end
  local strParamTo = paramList.to
  if strParamTo then
    local arrTo = string.split(strParamTo, "|")
    SetSRT(arrTo)
    self._changeValueFlag = 1
  end
  local strDuration = paramList.duration
  self._duration = strDuration and tonumber(strDuration) or 0
end

function PlayCasterBoneSRTInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local tfBone = self:GetTransform(casterEntity)
  if not tfBone then
    Log.fatal("### PlayCasterBoneSRTInstruction cant find bone", self._bone)
  end
  local tweener
  if self._SRT == "T" then
    local to
    if self._changeValueFlag == 0 then
      to = tfBone.localPosition + self._translation
    else
      to = self._translation
    end
    tweener = tfBone:DOLocalMove(to, self._duration * 0.001)
    tweener:SetEase(DG.Tweening.Ease.OutBack)
  elseif self._SRT == "R" then
    self:DORotate(TT, casterEntity, world)
  else
    Log.fatal("### PlayCasterBoneSRTInstruction expand by yourself.")
  end
end

function PlayCasterBoneSRTInstruction:GetTransform(e)
  local cView = e:View()
  local tran = cView.ViewWrapper.Transform
  local tfBone = GameObjectHelper.FindChild(tran, self._bone)
  return tfBone
end

function PlayCasterBoneSRTInstruction:DORotate(TT, e, world)
  local skillEffectResultContainer = e:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Rotate)
  local endRotation = Quaternion.identity
  if resultArray then
    for i, result in ipairs(resultArray) do
      local eId = result:GetTargetID()
      local targetEntity = world:GetEntityByID(eId)
      local dirOld = result:GetDirOld()
      local dirNew = result:GetDirNew()
      if dirNew.x == dirOld.y and dirNew.y == -dirOld.x then
        endRotation = Quaternion.Euler(0, 0, 90)
      elseif dirNew.x == -dirOld.y and dirNew.y == dirOld.x then
        endRotation = Quaternion.Euler(0, 0, -90)
      else
        Log.fatal("### not rotate", targetEntity:GridLocation().Position, dirOld, dirNew)
      end
      local tfBone = self:GetTransform(targetEntity)
      local tweener = tfBone:DOLocalRotateQuaternion(endRotation, self._duration * 0.001)
      tweener:OnComplete(function()
        tfBone.localRotation = Quaternion.identity
        targetEntity:SetDirection(dirNew)
      end)
    end
  else
    local tfBone = self:GetTransform(e)
    endRotation = self._rotation * tfBone.localRotation
    tfBone:DOLocalRotateQuaternion(endRotation, self._duration * 0.001)
    if 0 < self._duration then
      YIELD(TT, self._duration)
    end
  end
end
