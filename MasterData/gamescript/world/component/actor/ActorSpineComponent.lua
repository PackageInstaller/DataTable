local MeshRenderer = CS.UnityEngine.MeshRenderer
local ActorSpineComponent, Super = System.NewClass("ActorSpineComponent", Component)

function ActorSpineComponent:ctor()
  Super.ctor(self)
end

function ActorSpineComponent:Awake()
  Super.Awake(self)
  self:InitAnim()
end

function ActorSpineComponent:InitAnim()
end

function ActorSpineComponent:PlayAnim(animName, isLoop, completeCallback)
  if self.skAnimComp then
    local spineAnimationState = self.skAnimComp.AnimationState
    spineAnimationState:SetAnimation(0, animName, isLoop)
  end
  if self.skAnimComp2 then
    local spineAnimationState2 = self.skAnimComp2.AnimationState
    spineAnimationState2:SetAnimation(0, animName, isLoop)
  end
end

function ActorSpineComponent:GetSpinePostion()
  if self.spineNode then
    return self.spineNode.transform.position
  end
  return nil
end

function ActorSpineComponent:OnDestroy()
  Super.OnDestroy(self)
  if self.spineNode then
    UIRootMgr.DestroyGameObject(self.spineNode)
    self.spineNode = nil
  end
  if self.spineNode2 then
    UIRootMgr.DestroyGameObject(self.spineNode2)
    self.spineNode2 = nil
  end
  self.isLoadEnd = false
end

function ActorSpineComponent:AddFootStepEventListener()
  if self.skAnimComp.AnimationState then
    self.skAnimComp.AnimationState:Event("+", function(trackEntry, event)
      if event.Data.Name == "footdown" and self.avatarCp then
        self.avatarCp:PlayFootstepSound()
      end
    end)
  end
end

return ActorSpineComponent
