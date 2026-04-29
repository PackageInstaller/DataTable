_class("EffectPlaySystem_Render", Object)
EffectPlaySystem_Render = EffectPlaySystem_Render

function EffectPlaySystem_Render:Constructor(world)
  self.world = world
  self.group = world:GetGroup(world.BW_WEMatchers.EffectController)
end

function EffectPlaySystem_Render:Execute()
  self.group:HandleForeach(self, self.UpdateEffect)
end

function EffectPlaySystem_Render:UpdateEffect(e)
  local timeService = self.world:GetService("Time")
  local effCtrl = e:EffectController()
  effCtrl.CurrentTime = effCtrl.CurrentTime + timeService:GetDeltaTimeMs()
  if effCtrl.Duration > 0 and effCtrl.CurrentTime > effCtrl.Duration then
    local cb = effCtrl:GetDestroyCallback()
    if cb then
      cb()
    end
    if e:HasView() then
      local effObj = e:View():GetGameObject()
      if tostring(effObj) ~= "null" and effObj.transform then
        effObj.transform.parent = nil
      end
    end
    self.world:DestroyEntity(e)
  end
  local effectType = effCtrl:GetEffectType()
  if effectType == EffectType.FollowHead then
    self:_UpdateFollowHeadEffect(e, effCtrl)
  elseif effectType == EffectType.Path then
    self:_UpdatePathEffect(e, effCtrl)
  elseif effectType == EffectType.Bind then
    self:_UpdateBindEffect(e, effCtrl)
  elseif effectType == EffectType.UI then
    self:_UpdateUIEffect(e, effCtrl)
  end
end

function EffectPlaySystem_Render:_UpdateFollowHeadEffect(e, effCtrl)
  local heightOffset = effCtrl:GetHeightOffset()
  local holderEntity = effCtrl:GetBindEntity()
  if holderEntity == nil then
    Log.fatal("EffectPlaySystem_Render effect holder is null")
    return
  end
  local hodlerEntityCmpt = holderEntity:View()
  if hodlerEntityCmpt == nil then
    self.world:DestroyEntity(e)
    return
  end
  e:SetViewVisible(holderEntity:IsViewVisible())
  if not holderEntity:IsViewVisible() then
    return
  end
  local holderObj = holderEntity:View():GetGameObject()
  local effectObj
  local effectViewCmpt = e:View()
  if effectViewCmpt ~= nil then
    effectObj = effectViewCmpt:GetGameObject()
  end
  if holderObj ~= nil and effectObj ~= nil then
    local hpOffset = Vector3(0, heightOffset, 0)
    local hpCmpt = holderEntity:HP()
    if hpCmpt then
      hpOffset = hpCmpt:GetHPOffset()
    end
    hpOffset = hpOffset - Vector3(0, BattleConst.HeadBuffHeightOffset, 0)
    local ownerObj = holderEntity:View().ViewWrapper.GameObject
    local skinnedMeshRender = GameObjectHelper.FindFirstSkinedMeshRender(ownerObj)
    if not skinnedMeshRender then
      return
    end
    local skinnedMeshPosition = skinnedMeshRender.transform.position + hpOffset
    local meshExtents = GameObjectHelper.FindFirstSkinedMeshRenderBoundsExtent(ownerObj)
    local convertExtents = Vector3(0, meshExtents.x * 2, 0)
    local targetPos = skinnedMeshPosition + convertExtents
    local effectTras = e:View().ViewWrapper.GameObject.transform
    effectTras.position = targetPos
  end
end

function EffectPlaySystem_Render:_UpdatePathEffect(e, effCtrl)
  local viewCmpt = e:View()
  if viewCmpt == nil then
    return
  end
  local viewObj = viewCmpt:GetGameObject()
  if viewObj == nil then
    return
  end
  local curRenderPos = viewObj.transform.position
  local boardSvc = self.world:GetService("BoardRender")
  local targetRenderPos = boardSvc:GridPos2RenderPos(e:EffectController():GetTargetGridPos())
  local moveSpeed = effCtrl:GetMoveSpeed()
  local distance = Vector2.Distance(targetRenderPos, curRenderPos)
  local timeService = self._world:GetService("Time")
  local deltaTimeMS = timeService:GetDeltaTimeMs()
  local movement = deltaTimeMS * moveSpeed / 1000
  if distance < movement then
    viewObj.transform.position = targetRenderPos
    return
  else
    local lerpPos = Vector3.Lerp(curRenderPos, targetRenderPos, movement / distance)
    viewObj.transform.position = lerpPos
  end
end

function EffectPlaySystem_Render:_UpdateBindEffect(e, effCtrl)
  local followMove = effCtrl:GetFollowMove()
  local followRotate = effCtrl:GetFollowRotate()
  local followRotateCaster = effCtrl:GetFollowRotateCaster()
  local effView = e:View()
  if not effView then
    return
  end
  local effectObj = effView:GetGameObject()
  if not effectObj or tostring(effectObj) == "null" then
    return
  end
  if not followMove or not followRotate then
    local holderEntity = effCtrl:GetBindEntity()
    if holderEntity == nil then
      Log.notice("特效绑定的Entity为空！")
      return
    end
    local hodlerEntityCmpt = holderEntity:View()
    if hodlerEntityCmpt == nil then
      Log.notice("特效绑定的Entity的View为空！")
      return
    end
    local holderObj = holderEntity:View():GetGameObject()
    if holderObj == nil or tostring(holderObj) == "null" then
      Log.notice("特效绑定的Entity的View的GameObject为空！")
      return
    end
    if followMove then
      effectObj.transform.position = holderObj.transform.position
      local offSet = effCtrl:GetPosOffSet()
      if offSet then
        effectObj.transform.position = effectObj.transform.position + offSet
      end
    end
    if followRotate then
      effectObj.transform.rotation = holderObj.transform.rotation
    elseif followRotateCaster then
      local casterEntityID = effCtrl:GetEffectCasterID()
      local casterEntity = self.world:GetEntityByID(casterEntityID)
      if casterEntity then
        local casterView = casterEntity:View()
        local casterObj = casterView:GetGameObject()
        if casterObj then
          local direction = effectObj.transform.position - casterObj.transform.position
          effectObj.transform.rotation = Quaternion.LookRotation(direction)
        end
      else
        Log.notice("特效配置为旋转至面向施法者，但没有施法者或绑定者信息")
      end
    end
  end
end

function EffectPlaySystem_Render:_UpdateUIEffect(e, effCtrl)
  local effCtrl = e:EffectController()
  local effectType = effCtrl:GetEffectType()
  local mainCameraCmpt = self.world:MainCamera()
  local hudCanvas = mainCameraCmpt:HUDCanvas()
  local trans = e:View().ViewWrapper.GameObject.transform
  local pos = e:EffectController():GetTargetGridPos()
  if pos then
    local renderBattleService = self.world:GetService("RenderBattle")
    local hudWorldPos = renderBattleService:GridPos2HudWorldPos(pos)
    trans.position = hudWorldPos
  end
end
