_class("TrapRoundInfoSystem_Render", Object)
TrapRoundInfoSystem_Render = TrapRoundInfoSystem_Render

function TrapRoundInfoSystem_Render:Constructor(world)
  self._world = world
  self._renderEntityService = self._world:GetService("RenderEntity")
  self._group = world:GetGroup(world.BW_WEMatchers.TrapRoundInfoRender)
end

function TrapRoundInfoSystem_Render:Execute()
  self:ExecuteEntities(self._group:GetEntities())
end

function TrapRoundInfoSystem_Render:ExecuteEntities(entities)
  local needRefresh = self:IsNeedRefresh()
  for i, e in ipairs(entities) do
    local refresh = needRefresh
    if e:HasGridMove() then
      refresh = true
    end
    if refresh then
      self:_Refresh(e)
    end
  end
end

function TrapRoundInfoSystem_Render:_Refresh(e)
  local render = e:TrapRoundInfoRender()
  local round_entity_id = render:GetRoundInfoEntityID()
  local round_entity = self._world:GetEntityByID(round_entity_id)
  if round_entity then
    if render:GetIsShow() then
      round_entity:SetViewVisible(true)
      if render:GetHeadShowType() == TrapHeadShowType.HeadShowRound then
        self:_RefreshRound(e, round_entity, render)
      end
    else
      round_entity:SetViewVisible(false)
    end
  end
end

function TrapRoundInfoSystem_Render:IsNeedRefresh()
  local mainCameraCmpt = self._world:MainCamera()
  if mainCameraCmpt then
    local isNormalState = mainCameraCmpt:IsNormalState()
    return not isNormalState
  end
end

function TrapRoundInfoSystem_Render:_RefreshRound(e, round_entity, trapRound)
  if not round_entity then
    return
  end
  self._renderEntityService:SetHudPosition(e, round_entity, trapRound:GetOffset())
end
