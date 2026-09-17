local this = L_BevTree:registClass("guide.worldFilterAction", L_BevTree.action)

function this:param()
  self.areaId = ""
  self.targetParam = ""
end

function this:parse()
  self.areaId = self:getParam("areaId", true) or 0
  self.targetParam = self:getParam("targetParam")
end

function this:onEnter()
  self.result = L_BevTree.taskResult.Running
end

function this:execute()
  if self.waitAni then
    return self.result
  end
  if not math.isEmpty(self.areaId) and not self.waitAni then
    if not L_GuideManager:checkPageOpen("pageWorldAreaMap") then
      self.result = L_BevTree.taskResult.Failure
      return L_BevTree.taskResult.Failure
    end
    self.waitAni = true
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.RefreshWorldArea, {
      areaId = self.areaId,
      callback = function()
        self.result = L_BevTree.taskResult.Success
        self.waitAni = false
      end
    })
  end
  if not string.isEmpty(self.targetParam) and not self.waitAni then
    if not L_GuideManager:checkPageOpen("pageBigMap") then
      self.result = L_BevTree.taskResult.Failure
      return L_BevTree.taskResult.Failure
    end
    local data = {}
    local targetParamSplit = string.split(self.targetParam, "|")
    for _, v in ipairs(targetParamSplit) do
      if not string.isEmpty(v) then
        table.insert(data, tonumber(v))
      end
    end
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.RefreshWorldMarkFilter, {targetParam = data})
    self.result = L_BevTree.taskResult.Success
  end
  return self.result
end

return this
