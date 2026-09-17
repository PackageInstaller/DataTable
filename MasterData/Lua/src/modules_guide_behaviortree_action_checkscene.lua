local this = L_BevTree:registClass("guide.checkScene", L_BevTree.action)

function this:param()
  self.sceneIds = ""
  self.isReverse = 0
  self.isQuickCheck = 0
end

function this:parse()
  local sceneIds = self:getParam("sceneIds")
  local sceneIdsTb = string.split(sceneIds, "|")
  self.sceneIds = {}
  for _, id in ipairs(sceneIdsTb) do
    if not string.isEmpty(id) then
      table.insert(self.sceneIds, tonumber(id))
    end
  end
  local isReverse = self:getParam("isReverse", true) or 0
  self.isReverse = isReverse ~= 0
  local isQuickCheck = self:getParam("isQuickCheck", true) or 0
  self.isQuickCheck = isQuickCheck ~= 0
end

function this:execute()
  if not L_CommonUtil.isValid(AzurWorldInstance) or AzurWorld.proxyCenter == nil then
    return L_BevTree.taskResult.Running
  end
  local currentSceneId = AzurWorldInstance.CurWorldId
  if currentSceneId == nil then
    return L_BevTree.taskResult.Running
  end
  if not self.isReverse and table.containsValue(self.sceneIds, currentSceneId) then
    return L_BevTree.taskResult.Success
  end
  if self.isReverse and not table.containsValue(self.sceneIds, currentSceneId) then
    return L_BevTree.taskResult.Success
  end
  if self.isQuickCheck then
    return L_BevTree.taskResult.Failure
  end
  return L_BevTree.taskResult.Running
end

return this
