local this = class("uiHeroEntity", require(L_EcsConst.aliveType.default))

function this:initialize(data)
  this.super.initialize(self, data)
  local playableAnimator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), self.gameObject)
  playableAnimator.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
  playableAnimator.updateMode = C_PlayableAnimator.UpdateMode.LateUpdate
  self.playableAnimator = playableAnimator
end

function this:onDestroy()
  if self.csEntity and self.csEntity.entity.data then
    C_EntityManager.RemoveEntityWithEntityId(self.csEntity.entity.data.entityId)
    self.csEntity = nil
  end
  this.super.onDestroy(self)
end

function this:setActive(active)
  if self.csEntity then
    self.csEntity.entity:SetUIHeroActive(active)
  end
end

return this
