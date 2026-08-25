local MapRoleManager, Super = System.NewClass("MapRoleManager", Manager)

function MapRoleManager:ctor()
  Super.ctor(self)
  self.role = nil
  self.clickTips = {}
end

function MapRoleManager:Awake(binder)
  Super.Awake(self)
  self.rootNode = CS.UnityEngine.GameObject.Find("mapRoot/roleRoot")
  self.rootTransform = self.rootNode.transform
  binder:BindToRaw(function(_, new, old)
    if old and new then
      local hp = new - old
      if hp < 0 then
        local str = string.format(LT.Text("ExploreStressMaxReduceMaxHP"), hp)
        self.role:PlayTopAnim(str)
      end
    end
  end, function()
    local stageData = WorldStageManager.Instance:GetCurStageData()
    if stageData then
      return stageData.role.max_hp
    end
  end)
end

function MapRoleManager:OnInit()
  self.guideManager = self:GetComponent(MapGuideManager)
  self:CreateRole()
end

function MapRoleManager:CreateRole()
  local role = MapRole(self)
  self.role = role
  self.role:InitPrePos(self.parent.mapData.lastPos)
  role:LoadPrefab("MUnit/MUnit_02/Role/MUnit_Role_001/MUnit_Role_001.prefab")
  role:SetParent(self.rootTransform)
end

function MapRoleManager:SetRolePos(x, y)
  local role = self:GetRole()
  if role then
    local worldPosX, worldPosY = self.parent:GetWorldPosByGridPos(x, y)
    role:SetPosition(worldPosX, worldPosY)
    role:SetGridPos(x, y)
    self.parent:SetRolePos(x, y)
    local moveMgr = self:GetComponent(MapMoveManager)
    if moveMgr then
      moveMgr:SyncPos(x, y)
    end
  else
    Logger.Warn(">>>>SetRolePose", x, y)
  end
end

function MapRoleManager:OnShow()
  local role = self:GetRole()
  if role and role.tmpName then
    role.tmpName.text = ""
  end
end

function MapRoleManager:GetRole()
  return self.role
end

function MapRoleManager:Move(destPosX, destPosY, callBack)
  EventMgr.Instance.GearRoleMove:Dispatch(destPosX, destPosY, callBack)
  return true
end

function MapRoleManager:IsMoving()
  local moveMgr = self:GetComponent(MapMoveManager)
  if moveMgr then
    do return moveMgr.IsMoving end
    return moveMgr.IsMoving, moveMgr
  end
  return false
end

function MapRoleManager:SetMist(posX, posY, lv)
  local mistComp = self:GetComponent(MapMistManager)
  mistComp:OpenMist(posX, posY, lv, true)
end

function MapRoleManager:UpdateRoleMist()
  self.role:UpdateMist()
end

function MapRoleManager:OnDestroy()
  Super.OnDestroy(self)
  ResLoadMgr.UnloadAssetByTarget(self)
  self.guideManager = nil
  if self.role then
    self.role:Dispose()
    self.role = nil
  end
end

return MapRoleManager
