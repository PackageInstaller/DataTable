local RoleManager, Super = System.NewClass("RoleManager", Manager, IUpdater)

function RoleManager:ctor()
  Super.ctor(self)
  self.roleList = {}
  self.updateCount = 0
  self.rolePosList = {}
end

function RoleManager:Update()
  for _, value in pairs(self.roleList) do
    value:Update()
  end
  self:SyncPosition()
end

function RoleManager:SyncPosition()
  self.syncPositionTime = (self.syncPositionTime or 0) + 1
  if self.syncPositionTime > 60 then
    self.syncPositionTime = 1
    local uid = DataCenter.playerData.DRole.uid
    local role = RoleManager.Instance:GetRole(uid)
    if not role then
      return
    end
    local pos = role:GetPosition()
    local lastPos = self.rolePosList[uid]
    if lastPos and lastPos.x == lastPos.x and lastPos.y == pos.y and lastPos.z == pos.z then
      return
    elseif not lastPos then
      self.rolePosList[uid] = pos
    else
      lastPos.x = pos.x
      lastPos.y = pos.y
      lastPos.z = pos.z
    end
    local sceneType = SceneMgr.Instance:GetSceneType()
    ProtoManager.Instance.GameRequest:OnMove(pos.x or 0, pos.y or 0, pos.z or 0, sceneType)
  end
end

function RoleManager:CreateRole(uid, tid, type)
  local role = require("GameScript.World.Role." .. type)(uid, tid)
  role:Awake()
  role.type = type
  self.roleList[uid] = role
  Logger.Debug("#CreateRole: uid = %s, tid = %s", uid, tid)
  if uid == DataCenter.playerData.DRole.uid then
    self.playerRole = role
  end
  return role
end

function RoleManager:RemoveRole(uid)
  assert(self.roleList[uid], "No Role uid == " .. uid)
  if not self.roleList[uid]:isDestroyed() then
    self.roleList[uid]:Destroy()
  end
  self.roleList[uid] = nil
  if uid == DataCenter.playerData.DRole.uid then
    self.playerRole = nil
  end
  Logger.Debug("#RemoveRole: uid = %s, tid = %s", uid)
end

function RoleManager:GetRole(uid)
  return self.roleList[uid]
end

function RoleManager:GetPlayerRole()
  return self.playerRole or self:GetRole(DataCenter.playerData.DRole.uid)
end

function RoleManager:GetRoleUidFromTid(tid, type)
  local uid = 0
  for _, value in pairs(self.roleList) do
    if value.type == type and value.tid == tid then
      uid = value.uid
      break
    end
  end
  return uid
end

function RoleManager:OnDestroy()
  for _, value in pairs(self.roleList) do
    value:Destroy()
  end
  self.roleList = {}
  Super.OnDestroy(self)
end

return RoleManager
