local Manager = System.NewClass("Manager", Component)
local ManagerNameList = {}

function Manager:ctor()
  Component.ctor(self)
  if getmetatable(self).Instance ~= nil then
    Logger.Error("重复创建管理器:%s : %s", self:GetType():GetTypeFullName(), debug.traceback())
  end
  getmetatable(self).Instance = self
end

function Manager:Awake()
  ManagerNameList[getmetatable(self)] = self:GetType():GetTypeFullName()
end

function Manager:OnDestroy()
  ManagerNameList[getmetatable(self)] = nil
  getmetatable(self).Instance = nil
  local fullName = self:GetType():GetTypeFullName()
  Logger.Debug("Destroy Manager:%s", fullName)
end

function Manager.Print()
  local str = ""
  for _, value in pairs(ManagerNameList) do
    str = str .. "," .. value
  end
  Logger.Debug("All Manager:", str)
end

return Manager
