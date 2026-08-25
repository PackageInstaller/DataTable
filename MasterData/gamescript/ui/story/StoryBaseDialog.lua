local StoryBaseDialog = System.NewComponent("StoryBaseDialog", UIBasePanel)

function StoryBaseDialog:__InitStory(plotTid, nodeTid, nextCallback)
  self.plotTid = plotTid
  self.nodeTid = nodeTid
  self.handleNextNodeCallback = nextCallback
  self.nodeConfig = self:GetNodeConfig()
  self.nodeAttr = self.nodeConfig and self.nodeConfig.NodeAttr or {}
  self.createTime = CS.Framework.TimeUtil.GetMillisecondTimestamp()
end

function StoryBaseDialog:GetNodeConfig()
  if not self.plotTid or not self.nodeTid then
    return
  end
  local d = DT["Story.Story_" .. self.plotTid]
  if d and d.NodeList then
    return d.NodeList[self.nodeTid]
  end
end

function StoryBaseDialog:TheClose()
  self:Close()
end

function StoryBaseDialog:GetConfigIcon()
  return self.nodeAttr.PlayerIcon
end

function StoryBaseDialog:GetConfigDlgTime()
  do return StoryFactory.GetDialogTime end
  return StoryFactory.GetDialogTime, self.nodeConfig
end

function StoryBaseDialog:GetConfigDlgText()
  local text = self.nodeAttr.Content
  return text or ""
end

function StoryBaseDialog:GetConfigNextNodeId()
  if self.nodeConfig then
    return self.nodeConfig.NextNodeId or 0
  end
  return 0
end

function StoryBaseDialog:GetBrandConfig()
  if not self.nodeConfig.NodeAttr.childsTable then
    return
  end
  for _, v in ipairs(self.nodeConfig.NodeAttr.childsTable) do
    local childConfig = StoryDataUtils.GetNodeData(self.plotTid, v)
    if childConfig.NodeName == "Option" then
      return childConfig
    end
  end
end

function StoryBaseDialog:GetCgImge()
  local storyData = StoryDataUtils.GetStoryData(self.plotTid)
  if not storyData then
    return
  end
  local firstNodeConfig = StoryDataUtils.GetNodeData(self.plotTid, storyData.FirstNode)
  local nodeAttr = firstNodeConfig.NodeAttr or {}
  local childsTable = nodeAttr.childsTable or {}
  for _, v in ipairs(childsTable) do
    local childConfig = StoryDataUtils.GetNodeData(self.plotTid, v)
    if childConfig.NodeName == "PlayCG" then
      local nodeAttr = childConfig.NodeAttr
      return nodeAttr and nodeAttr.CGPath
    end
  end
end

function StoryBaseDialog:GetFirstContent()
  local storyData = StoryDataUtils.GetStoryData(self.plotTid)
  if not storyData then
    return
  end
  local firstNodeConfig = StoryDataUtils.GetNodeData(self.plotTid, storyData.FirstNode)
  local nodeAttr = firstNodeConfig.NodeAttr or {}
  return nodeAttr.Content or ""
end

function StoryBaseDialog:IsTimer(currentTime)
  if not self.dialogTime then
    self.dialogTime = self:GetConfigDlgTime()
  end
  local dialogTime = self.dialogTime or 0
  if dialogTime <= 0 then
    return
  end
  currentTime = currentTime or CS.Framework.TimeUtil.GetMillisecondTimestamp()
  if currentTime - self.createTime >= dialogTime * 1000 then
    return true
  end
end

function StoryBaseDialog:SendEvent(eventName, ...)
  if EventMgr.Instance[eventName] then
    EventMgr.Instance[eventName]:Dispatch(self.plotTid, ...)
  else
    Logger.Info("not find event=", eventName)
  end
end

function StoryBaseDialog:GetImgByItemId(itemId)
end

return StoryBaseDialog
