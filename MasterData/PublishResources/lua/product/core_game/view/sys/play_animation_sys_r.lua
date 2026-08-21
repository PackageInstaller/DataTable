_class("PlayAnimationSystem_Render", ReactiveSystem)
PlayAnimationSystem_Render = PlayAnimationSystem_Render

function PlayAnimationSystem_Render:Constructor(world)
  self._world = world
end

function PlayAnimationSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.LegacyAnimation)
  local c = Collector:New({group}, {"Added"})
  return c
end

function PlayAnimationSystem_Render:Filter(entity)
  return entity:HasLegacyAnimation() and entity:HasView() and not entity:HasPiece()
end

function PlayAnimationSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    local e = entities[i]
    self:HandleEntity(e)
  end
end

function PlayAnimationSystem_Render:HandleEntity(e)
  local animCtrl = e:LegacyAnimation()
  local gridGameObj = e:View().ViewWrapper.GameObject
  local u3dAnimCmpt = gridGameObj:GetComponentInChildren(typeof(UnityEngine.Animation))
  if not u3dAnimCmpt then
    Log.fatal("Can not find animation component")
    return
  end
  local clipCount = u3dAnimCmpt:GetClipCount()
  if clipCount <= 0 then
    return
  end
  local animList = animCtrl:GetLegacyAnimationList()
  if animList == nil then
    return
  end
  if #animList <= 0 then
    return
  end
  if 1 < #animList then
    for _, v in ipairs(animList) do
      u3dAnimCmpt:PlayQueued(v, UnityEngine.QueueMode.CompleteOthers)
      self:_LogGridAnim(e, v)
    end
  else
    local curAnim = animList[1]
    u3dAnimCmpt:Play(curAnim)
    self:_LogGridAnim(e, curAnim)
  end
end

function PlayAnimationSystem_Render:_LogGridAnim(e, anim)
  if EDITOR then
    local gridGameObj = e:View().ViewWrapper.GameObject
    local gridPos = e:GridLocation().Position
    if gridGameObj.transform.position.y == BattleConst.CacheHeight then
      Log.fatal("PlayAnimationSystem_Render:", anim, ";高度:" .. gridGameObj.transform.position.y, Log.traceback())
    end
  end
end

function PlayAnimationSystem_Render:_CacheAnimObj()
end
