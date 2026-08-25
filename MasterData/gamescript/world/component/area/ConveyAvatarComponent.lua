local CS = _ENV.CS
local typeof = _ENV.typeof
local Animator = CS.UnityEngine.Animator
local ConveyAvatarComponent, Super = System.NewClass("ConveyAvatarComponent", Component)

function ConveyAvatarComponent:ctor()
  Super.ctor(self)
  self.blockStateCache = nil
end

function ConveyAvatarComponent:Awake()
  Super.Awake(self)
end

function ConveyAvatarComponent:BindAvatar(doorBegin, road, doorEnd)
end

function ConveyAvatarComponent:InitNavMeshObstacle(nodeInfo)
  if not nodeInfo then
    return
  end
  local meshRenderer = self.roadBlockObj:GetComponent(typeof(CS.UnityEngine.MeshRenderer))
  if meshRenderer then
    meshRenderer.enabled = false
  end
  local blockGameObject = self.roadBlockObj.transform:GetChild(0).gameObject
  self.navMeshObstacle = blockGameObject:GetComponent(typeof(CS.UnityEngine.AI.NavMeshObstacle))
  self.boxCollider = blockGameObject:GetComponent(typeof(CS.UnityEngine.BoxCollider))
  if not self.navMeshObstacle then
    Logger.Error("传送路障\"" .. nodeInfo.name("\"没有挂载Nav Mesh Obstacle组件, 传送组配置Id:") .. self.parent.groupId)
    return
  end
  if nodeInfo.hitBoxInfo then
    for _, value in ipairs(nodeInfo.hitBoxInfo) do
      if value.type == "NONE" then
        local vec3 = CS.UnityEngine.Vector3(value.rect[1], value.rect[2], value.rect[3])
        self.roadBlockObj.transform.localScale = vec3
        break
      end
    end
  end
  if nodeInfo.rotation then
    self.roadBlockObj.transform.localRotation = CS.UnityEngine.Quaternion.Euler(nodeInfo.rotation[1], nodeInfo.rotation[2], nodeInfo.rotation[3])
  end
end

function ConveyAvatarComponent:SetIconCourseShow()
  if self.iconCourse then
    self.iconCourse:SetActive(false)
  end
end

function ConveyAvatarComponent:SetBlockState(state)
  if not self.boxCollider or not self.navMeshObstacle then
    self.blockStateCache = state
    return
  end
  self.navMeshObstacle.enabled = state
  self.boxCollider.enabled = state
end

function ConveyAvatarComponent:RegisterAnimCallback()
  if self.doorBeginAnimator then
    local behaviors = self.doorBeginAnimator:GetAnimatorStateBehaviors()
    local enterStateHash = Animator.StringToHash("Base Layer.DoorBegin")
    for i = 0, behaviors.Length - 1 do
      behaviors[i]:onStateEnd("+", function(hash)
        if hash == enterStateHash and self.roadAnimator then
          local enterTrigger = Animator.StringToHash("Enter")
          self.roadAnimator:SetTrigger(enterTrigger)
        end
      end)
    end
  end
  if self.roadAnimator then
    local behaviors = self.roadAnimator:GetAnimatorStateBehaviors()
    local enterStateHash = Animator.StringToHash("Base Layer.DoorBegin")
    local exitStateHash = Animator.StringToHash("Base Layer.DoorEnd")
    for i = 0, behaviors.Length - 1 do
      behaviors[i]:onStateEnter("+", function(hash)
        if hash == enterStateHash then
          if self.playExitAnim then
            return
          end
          self:SetBlockState(false)
        end
      end)
      behaviors[i]:onStateEnd("+", function(hash)
        if hash == exitStateHash then
          self.playExitAnim = false
        end
      end)
    end
  end
end

function ConveyAvatarComponent:PlayEnterDoorAnim(skip)
  if not self.roadAnimator then
    return
  end
  if not self.doorBeginAnimator then
    self:SetDoorBeginActive(false)
    local triggerParam = skip and "SkipToEnter" or "Enter"
    local enterHash = Animator.StringToHash(triggerParam)
    self.roadAnimator:SetTrigger(enterHash)
  end
end

function ConveyAvatarComponent:SetDoorBeginActive(active)
  if self.doorBegin then
    self.doorBegin:SetActive(active)
  end
  if self.doorBeginBlock then
    self.doorBeginBlock.enabled = active
  end
end

function ConveyAvatarComponent:PlayExitDoorAnim(skip)
  self.playExitAnim = true
  if self.roadBlockObj then
    self:SetBlockState(true)
  end
  if self.roadAnimator then
    local triggerParam = skip and "SkipToEnd" or "Exit"
    local exitHash = Animator.StringToHash(triggerParam)
    self.roadAnimator:SetTrigger(exitHash)
  end
end

function ConveyAvatarComponent:RecoverState(state)
  if not state then
    return
  end
  if state == CommonDefine.ConveyGroupState.Triggering then
    self:PlayEnterDoorAnim(true)
  elseif state == CommonDefine.ConveyGroupState.TriggerEnd then
    self:SetDoorBeginActive(false)
  end
end

function ConveyAvatarComponent:DestroyAvatar()
  if self.roadBlockObj then
    self.roadBlockObj = nil
  end
end

function ConveyAvatarComponent:FindGameObject(obj, name)
  do return UIRootMgr.FindChild, obj.transform end
  return UIRootMgr.FindChild, obj.transform, name
end

function ConveyAvatarComponent:OnDestroy()
  Super.OnDestroy(self)
  self:DestroyAvatar()
end

return ConveyAvatarComponent
