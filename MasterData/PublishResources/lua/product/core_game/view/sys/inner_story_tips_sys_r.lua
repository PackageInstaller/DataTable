_class("InnerStoryTipsSystem_Render", ReactiveSystem)
InnerStoryTipsSystem_Render = InnerStoryTipsSystem_Render

function InnerStoryTipsSystem_Render:Constructor(world)
  self._world = world
  self._configService = world:GetService("Config")
  self._timeService = world:GetService("Time")
end

function InnerStoryTipsSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.InnerStoryTips)
  local c = Collector:New({group}, {"Added"})
  return c
end

function InnerStoryTipsSystem_Render:Filter(entity)
  return entity:HasInnerStoryTipsComponent()
end

function InnerStoryTipsSystem_Render:ExecuteEntities(entities)
  for i, e in ipairs(entities) do
    if e:HasInnerStoryTipsComponent() then
      GameGlobal.TaskManager():CoreGameStartTask(self._DoStoryTips, self, e)
    end
  end
end

function InnerStoryTipsSystem_Render:_DoStoryTips(TT, tipsEntity)
  local storyTipsComponent = tipsEntity:InnerStoryTipsComponent()
  local speakerEntity = self._world:GetEntityByID(storyTipsComponent:GetEntityID())
  local speakerGridPos = speakerEntity:GridLocation().Position
  local HorizontalOffSet, direction = self:GetTipsHorizontalOffSet(speakerGridPos)
  local offSet = Vector3(0, storyTipsComponent:GetOffset(), 0) + HorizontalOffSet
  local renderOffset = self:_CalcSkinnedMeshPos(speakerEntity:View().ViewWrapper.GameObject, offSet)
  local levelConfigData = self._configService:GetLevelConfigData()
  local tipsList = levelConfigData:GetStoryTipsList(storyTipsComponent:GetTipsID())
  while not tipsEntity:View() do
    YIELD(TT)
    if not GameGlobal:GetInstance():IsCoreGameRunning() then
      return
    end
  end
  local go = tipsEntity:View().ViewWrapper.GameObject
  go.transform.position = renderOffset
  local uiview = go:GetComponent("UIView")
  local bgGO = uiview:GetGameObject("bg")
  local textGO = uiview:GetGameObject("StoryText")
  self:Rotate(TT, bgGO, textGO, direction)
  for _, v in ipairs(tipsList) do
    local beginTime = self._timeService:GetCurrentTimeMs()
    local duration = v:GetDuration()
    go:SetActive(true)
    local text = uiview:GetUIComponent("UILocalizationText", "StoryText")
    text:SetText(v:GetText())
    while beginTime + duration > self._timeService:GetCurrentTimeMs() do
      if speakerEntity and speakerEntity:View() and speakerEntity:View().ViewWrapper.GameObject then
        renderOffset = self:_CalcSkinnedMeshPos(speakerEntity:View().ViewWrapper.GameObject, offSet)
        go.transform.position = renderOffset
      end
      YIELD(TT)
      if not GameGlobal:GetInstance():IsCoreGameRunning() then
        return
      end
    end
    go:SetActive(false)
    YIELD(TT, BattleConst.StoryTipsHideIntervalDuration)
  end
  tipsEntity:RemoveInnerStoryTipsComponent()
  self._world:DestroyEntity(tipsEntity)
end

function InnerStoryTipsSystem_Render:_HasView(e)
  local viewCmpt = e:View()
  if viewCmpt == nil then
    return false
  end
  local gameObj = viewCmpt:GetGameObject()
  if gameObj == nil then
    return false
  end
  return true
end

function InnerStoryTipsSystem_Render:Rotate(TT, bgGO, textGO, direction)
  if direction == "Right" then
    bgGO.transform.localRotation = Quaternion.Euler(0, 180, 0)
    YIELD(TT)
    textGO.transform.localRotation = Quaternion.Euler(0, 180, 0)
  end
end

function InnerStoryTipsSystem_Render:GetTipsHorizontalOffSet(gridPos)
  for _, v in ipairs(BattleConst.StoryTipsLeftGridPosList) do
    if gridPos.x == v[1] and gridPos.y == v[2] then
      return Vector3(BattleConst.StoryTipsLeftOffSet, 0, 0), "Left"
    end
  end
  for _, v in ipairs(BattleConst.StoryTipsRightGridPosList) do
    if gridPos.x == v[1] and gridPos.y == v[2] then
      return Vector3(BattleConst.StoryTipsRightOffSet, 0, 0), "Right"
    end
  end
  return Vector3(0, 0, 0), nil
end

function InnerStoryTipsSystem_Render:_CalcSkinnedMeshPos(ownerObj, buff_offset)
  local owner_entity_render_pos = ownerObj.transform.position
  local skinnedMeshRender = GameObjectHelper.FindFirstSkinedMeshRender(ownerObj)
  if skinnedMeshRender ~= nil then
    local skinnedMeshPosition = skinnedMeshRender.transform.position + Vector3(buff_offset.x, buff_offset.y, 0)
    local meshExtents = GameObjectHelper.FindFirstSkinedMeshRenderBoundsExtent(ownerObj)
    local convertExtents = Vector3(0, meshExtents.x * 2, 0)
    local targetPos = skinnedMeshPosition + convertExtents
    owner_entity_render_pos = self:_CalcGridHUDWorldPos(targetPos)
  else
    Log.fatal("ownerObj", ownerObj.name, "has no skinned mesh")
  end
  return owner_entity_render_pos
end

function InnerStoryTipsSystem_Render:_CalcGridHUDWorldPos(gridRenderPos)
  local camera = self._world:MainCamera():Camera()
  local screenPos = camera:WorldToScreenPoint(gridRenderPos)
  local hudCamera = self._world:MainCamera():HUDCamera()
  local hudWorldPos = hudCamera:ScreenToWorldPoint(screenPos)
  return hudWorldPos
end
