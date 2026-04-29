_class("EffectAttachSystem_Render", ReactiveSystem)
EffectAttachSystem_Render = EffectAttachSystem_Render

function EffectAttachSystem_Render:Constructor(world)
  self.world = world
end

function EffectAttachSystem_Render:GetTrigger(world)
  local eGroup = world:GetGroup(world.BW_WEMatchers.EffectController)
  local vGroup = world:GetGroup(world.BW_WEMatchers.View)
  local c = Collector:New({eGroup, vGroup}, {"Added", "Added"})
  return c
end

function EffectAttachSystem_Render:Filter(entity)
  return entity:HasEffectController() and entity:HasView()
end

function EffectAttachSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    local e = entities[i]
    self:HandleEntity(e)
  end
end

function EffectAttachSystem_Render:HandleEntity(e)
  local effCtrl = e:EffectController()
  local effectType = effCtrl:GetEffectType()
  if effectType == EffectType.UI then
    local mainCameraCmpt = self.world:MainCamera()
    local hudCanvas = mainCameraCmpt:HUDCanvas()
    local trans = e:View().ViewWrapper.GameObject.transform
    local pos = e:EffectController():GetTargetGridPos()
    trans:SetParent(hudCanvas.transform)
    trans.localScale = Vector3.one
    if pos then
      local renderBattleService = self.world:GetService("RenderBattle")
      local hudWorldPos = renderBattleService:GridPos2HudWorldPos(pos)
      trans.position = hudWorldPos
    else
      trans.localPosition = Vector3(0, 0, 0)
    end
    return
  end
  if effectType == EffectType.ScreenEffPoint then
    local cMainCamera = self.world:MainCamera()
    local screenEffPointGo = cMainCamera:ScreenEffPointGo()
    local effTf = e:View().ViewWrapper.Transform
    effTf:SetParent(screenEffPointGo.transform)
    effTf.localPosition = Vector3.zero
    effTf.localRotation = Quaternion.identity
    effTf.localScale = Vector3.one
    return
  end
  local holder = effCtrl.BindEntity
  if not holder then
    return
  end
  if not holder:isEnabled() or not holder:HasView() then
    return
  end
  if effectType == EffectType.FollowHead then
    local effectOffset = Vector3(0, 0, 0)
    local ownerObj = holder:View().ViewWrapper.GameObject
    local skinnedMeshRender = GameObjectHelper.FindFirstSkinedMeshRender(ownerObj)
    if skinnedMeshRender == nil then
      if ownerObj ~= nil then
        Log.fatal("no skinned mesh render ", ownerObj.name)
      else
        Log.fatal("no skinned mesh render ")
      end
      return
    end
    local skinnedMeshPosition = skinnedMeshRender.transform.position + effectOffset
    local meshExtents = GameObjectHelper.FindFirstSkinedMeshRenderBoundsExtent(ownerObj)
    local convertExtents = Vector3(0, meshExtents.x * 2, 0)
    local targetPos = skinnedMeshPosition + convertExtents
    e:View().ViewWrapper.GameObject.transform.position = targetPos
    e:View().ViewWrapper:SetVisible(true)
  elseif effectType == EffectType.VirtualBind then
    local holderTf = holder:View().ViewWrapper.Transform
    local bindTf = self:TryFindBindPos(holder, e)
    if bindTf then
      local effTf = e:View().ViewWrapper.Transform
      if effCtrl:IsOnlyUserBindPosHigh() then
        local pos = effCtrl:GetGridRenderPos()
        effTf.position = Vector3(pos.x, bindTf.position.y, pos.z)
      elseif effCtrl:GetPosOffSet() then
        local offSet = effCtrl:GetPosOffSet()
        effTf.position = bindTf.position + offSet
      else
        effTf.position = bindTf.position
      end
      effTf.localScale = Vector3.one
      local casterEntityID = effCtrl:GetEffectCasterID()
      local casterEntity = self.world:GetEntityByID(casterEntityID)
      if casterEntity ~= nil then
        local casterViewCmpt = casterEntity:View()
        if casterViewCmpt ~= nil then
          effTf.rotation = casterViewCmpt:GetGameObject().transform.rotation
        end
      else
        effTf.rotation = holderTf.rotation
      end
    end
  elseif effectType == EffectType.Hit then
    local holderTf = holder:View().ViewWrapper.Transform
    local bindTf = self:TryFindBindPos(holder, e)
    if bindTf then
      local effTf = e:View().ViewWrapper.Transform
      if effCtrl:IsOnlyUserBindPosHigh() then
        local pos = effCtrl:GetGridRenderPos()
        effTf.position = Vector3(pos.x, bindTf.position.y, pos.z)
      elseif effCtrl:GetPosOffSet() then
        local offSet = effCtrl:GetPosOffSet()
        effTf.position = bindTf.position + offSet
      else
        effTf.position = bindTf.position
      end
      effTf.localScale = Vector3.one
    end
  else
    local bindTf = self:TryFindBindPos(holder, e)
    if not bindTf then
      return
    end
    if bindTf.name == "Hit" and bindTf.localScale ~= Vector3.one then
      bindTf.localScale = Vector3.one
    end
    local effTf = e:View().ViewWrapper.Transform
    local followMove = effCtrl:GetFollowMove()
    local followRotate = effCtrl:GetFollowRotate()
    local followRotateCaster = effCtrl:GetFollowRotateCaster()
    if followMove and followRotate or effectType ~= EffectType.Bind then
      effTf:SetParent(bindTf)
      effTf.localPosition = Vector3(0, 0, 0)
      effTf.localEulerAngles = Vector3(0, 0, 0)
    else
      if effCtrl:IsOnlyUserBindPosHigh() then
        local pos = effCtrl:GetGridRenderPos()
        effTf.position = Vector3(pos.x, bindTf.position.y, pos.z)
      elseif effCtrl:GetPosOffSet() then
        local offSet = effCtrl:GetPosOffSet()
        effTf.position = bindTf.position + offSet
      else
        effTf.position = bindTf.position
      end
      if followRotate then
        effTf.rotation = bindTf.rotation
      elseif followRotateCaster then
        local casterEntityID = effCtrl:GetEffectCasterID()
        local casterEntity = self.world:GetEntityByID(casterEntityID)
        if casterEntity then
          local casterView = casterEntity:View()
          local casterObj = casterView:GetGameObject()
          if casterObj then
            local direction = effTf.position - casterObj.transform.position
            effTf.rotation = Quaternion.LookRotation(direction)
          end
        end
      elseif not effCtrl:IsNoResetRotationOnCreated() then
        effTf.rotation = Quaternion.identity
      end
    end
    effTf.localScale = Vector3.one
  end
  local layer = effCtrl:GetBindLayer()
  if 0 < layer then
    GameObjectHelper.SetGameObjectLayer(holder:View().ViewWrapper.GameObject, layer)
    GameObjectHelper.SetGameObjectLayer(e:View().ViewWrapper.GameObject, layer)
    effCtrl:SetDestroyCallback(function()
      GameObjectHelper.SetGameObjectLayer(holder:View().ViewWrapper.GameObject, 0)
    end)
  end
end

function EffectAttachSystem_Render:TryFindBindPos(holder, e)
  local holderTf = holder:View().ViewWrapper.Transform
  local cEffectController = e:EffectController()
  local bindTf = GameObjectHelper.FindChild(holderTf, cEffectController.BindPos)
  if not bindTf then
    local binderName = ""
    local viewWrapper = holder:View().ViewWrapper
    if viewWrapper and viewWrapper.GameObject then
      binderName = viewWrapper.GameObject.name
    end
    local resPath = e:Asset().AssetDetail:GetResPath()
    if cEffectController.BindPos ~= nil then
      Log.fatal(string.format("未找到特效[%s]的绑点[%s] [%s]", resPath, cEffectController.BindPos, binderName))
    else
      Log.fatal(string.format("特效[%s]没有配置绑点", resPath, binderName))
    end
    e:SetPosition(Vector3.New(0, 1000, 0))
    return
  end
  return bindTf
end
