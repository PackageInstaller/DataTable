_class("HPPosSystem_Render", Object)
HPPosSystem_Render = HPPosSystem_Render

function HPPosSystem_Render:Constructor(world)
  self._world = world
  self._hpGroup = world:GetGroup(world.BW_WEMatchers.HP)
  self._timeService = self._world:GetService("Time")
end

function HPPosSystem_Render:Execute()
  self:ExecuteEntities(self._hpGroup:GetEntities())
end

function HPPosSystem_Render:ExecuteEntities(entities)
  if GameGlobal.GetModule(SkillPerfModule):IsPerfCoreGame() then
    return
  end
  for i, e in ipairs(entities) do
    local refresh = self:_ShouldRefreshHPBarPos(e)
    if refresh then
      self:_UpdateHPPos(e)
    end
    local hpCmpt = e:HP()
    local isDirty = hpCmpt:IsHPPosDirty()
    if isDirty then
      hpCmpt:SetHPPosDirty(false)
    end
  end
end

function HPPosSystem_Render:_ShouldRefreshHPBarPos(e)
  local mainCameraCmpt = self._world:MainCamera()
  if mainCameraCmpt then
    local isNormalState = mainCameraCmpt:IsNormalState()
    if not isNormalState then
      return true
    end
  end
  local hpCmpt = e:HP()
  local isPosLocked = hpCmpt:IsPosLocked()
  if isPosLocked then
    Log.warn("HPPosSystem: HP bar position locked due to component data and may controlled by another logic. entity id: ", e:GetID())
    return false
  end
  local uiHpBuffInfoWidget = hpCmpt:GetUIHpBuffInfoWidget()
  if uiHpBuffInfoWidget then
    local uiHPBuffInfo = uiHpBuffInfoWidget:GetAllSpawnList()[1]
    if uiHPBuffInfo then
      local deltaTime = self._timeService:GetDeltaTime()
      uiHPBuffInfo:OnRefreshBuffTime(deltaTime)
      uiHPBuffInfo:OnCheckBuffAnimation()
    end
  end
  local isDirty = hpCmpt:IsHPPosDirty()
  return isDirty
end

function HPPosSystem_Render:_UpdateHPPetPos(petEntity)
  if not petEntity:PetPstID() then
    return
  end
  if not self:_HasView(petEntity) then
    return
  end
  local petPstIDComponent = petEntity:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  local petData = self._world:GetPetData(petPstID)
  local hpOffset = petData:GetHPOffset()
  local hpOffSetV = Vector3(0, hpOffset, 0)
  local teamEntity = self._world:Player():GetPreviewTeamEntity()
  local slider_entity_id = teamEntity:HP():GetHPSliderEntityID()
  local slider_entity = self._world:GetEntityByID(slider_entity_id)
  local isInScreen = self:IsInScreen(petEntity)
  local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
  local IsVisible = self:IsVisible(teamEntity)
  local hp = petEntity:HP()
  local viewEntity = petEntity
  if hp:IsUseTeamView() then
    local hpCmpt = teamLeaderEntity:HP()
    local hp_offset = hpCmpt:GetHPOffset()
    hpOffSetV = hp_offset
    viewEntity = teamLeaderEntity
  end
  hp:ResetUseTeamViewState()
  self:__UpdateHPPos(slider_entity, IsVisible, isInScreen, hpOffSetV, viewEntity)
end

function HPPosSystem_Render:IsInScreen(e)
  local mainCamera = self._world:MainCamera():Camera()
  local isInScreen = true
  local v3RenderPos = e:GetPosition()
  if v3RenderPos then
    local viewpoint = mainCamera:WorldToViewportPoint(v3RenderPos)
    isInScreen = viewpoint.x > 0 and viewpoint.x < 1 and 0 < viewpoint.y and 1 > viewpoint.y
  end
  return isInScreen
end

function HPPosSystem_Render:IsVisible(e)
  local hpCmpt = e:HP()
  local isVisible = hpCmpt:IsShowHPSlider() and not hpCmpt:IsHPBarTempHide()
  return isVisible
end

function HPPosSystem_Render:_UpdateHPPos_Other(e)
  local slider_entity_id = e:HP():GetHPSliderEntityID()
  local slider_entity = self._world:GetEntityByID(slider_entity_id)
  if not slider_entity then
    return
  end
  local isInScreen = self:IsInScreen(e)
  local isVisible = self:IsVisible(e)
  local hpCmpt = e:HP()
  local hp_offset = hpCmpt:GetHPOffset()
  self:__UpdateHPPos(slider_entity, isVisible, isInScreen, hp_offset, e)
end

function HPPosSystem_Render:__UpdateHPPos(slider_entity, isVisible, isInScreen, hp_offset, e)
  if not slider_entity then
    return
  end
  if isVisible and isInScreen then
    local hasView = self:_HasView(e)
    if hasView then
      self:_RefreshGameObject(e, slider_entity, hp_offset)
    end
    slider_entity:View().ViewWrapper.GameObject:SetActive(isVisible)
  else
    slider_entity:View().ViewWrapper.GameObject:SetActive(false)
  end
end

function HPPosSystem_Render:_UpdateHPPos(e)
  if e:HasPetPstID() then
    self:_UpdateHPPetPos(e)
  else
    self:_UpdateHPPos_Other(e)
  end
end

function HPPosSystem_Render:_RefreshGameObject(entity, slider_entity, hp_offset)
  local hasView = self:_HasView(entity)
  if hasView then
    local renderBattleService = self._world:GetService("RenderBattle")
    local owner_entity_render_pos = renderBattleService:CalcHPBarPos(entity:View().ViewWrapper, hp_offset)
    local canvasTrans = slider_entity:View().ViewWrapper:FindChild("Root")
    canvasTrans.position = owner_entity_render_pos
  else
  end
end

function HPPosSystem_Render:_HasView(e)
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

function HPPosSystem_Render:_CalcSkinnedMeshPos(viewWrapper, hp_offset)
  local ownerObj = viewWrapper.GameObject
  local rootObj
  local rootTransform = viewWrapper:FindChild("Root")
  if rootTransform then
    rootObj = rootTransform.gameObject
  else
    rootObj = viewWrapper.GameObject
  end
  local owner_entity_render_pos = rootObj.transform.position
  local renderBattleService = self._world:GetService("RenderBattle")
  local skinnedMeshRender, meshExtents = renderBattleService:FindFirstSkinedMeshRender(rootObj)
  if skinnedMeshRender ~= nil then
    local skinnedMeshPosition = skinnedMeshRender.transform.position + hp_offset
    local convertExtents = Vector3(0, meshExtents.x * 2, 0)
    local targetPos = skinnedMeshPosition + convertExtents
    owner_entity_render_pos = renderBattleService:CalcGridHUDWorldPos(targetPos)
  else
    local meshRenderer = renderBattleService:GetMeshRendererInChildren(ownerObj)
    if meshRenderer then
      local meshPosition = owner_entity_render_pos + hp_offset
      owner_entity_render_pos = renderBattleService:CalcGridHUDWorldPos(meshPosition)
    else
      Log.fatal("ownerObj", ownerObj.name, "has no skinned mesh and mesh")
    end
  end
  return owner_entity_render_pos
end
