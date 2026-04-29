_class("HUDAddViewSystem_Render", ReactiveSystem)
HUDAddViewSystem_Render = HUDAddViewSystem_Render

function HUDAddViewSystem_Render:Constructor(world)
  self._world = world
end

function HUDAddViewSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.HUD)
  local c = Collector:New({group}, {"Added"})
  return c
end

function HUDAddViewSystem_Render:Filter(entity)
  return entity:HasView()
end

function HUDAddViewSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:OnHUDViewAdded(entities[i])
  end
end

function HUDAddViewSystem_Render:OnHUDViewAdded(hudEntity)
  local viewCmpt = hudEntity:View()
  if viewCmpt == nil then
    return
  end
  local viewObj = viewCmpt:GetGameObject()
  if viewObj == nil then
    return
  end
  if hudEntity:HasLinkageInfo() then
    local linkageInfoCmpt = hudEntity:LinkageInfo()
    linkageInfoCmpt:SetRenderObject(viewObj)
  end
  local mainCameraCmpt = self._world:MainCamera()
  local hudCanvas = mainCameraCmpt:HUDCanvas()
  if not hudCanvas then
    return
  end
  local parentTrans = hudCanvas.transform
  local entityTypeCmpt = hudEntity:EntityType()
  if entityTypeCmpt.Value == EntityType.HPSlider then
    local hpGroup = GameObjectHelper.FindChild(hudCanvas.transform, "HPGroup")
    if hpGroup ~= nil then
      parentTrans = hpGroup
    end
  end
  viewObj.transform:SetParent(parentTrans)
  viewObj.transform.localScale = Vector3(1, 1, 1)
  viewObj.transform:SetAsLastSibling()
end
