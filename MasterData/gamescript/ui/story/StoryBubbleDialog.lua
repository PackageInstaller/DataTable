local StoryBubbleDialog, Super = System.NewComponent("StoryBubbleDialog")

function StoryBubbleDialog:ctor(uiNode, plotTid, nodeTid, nexCallback)
  Super.ctor(self)
  self.ui = Function_BubbleDialogResource(uiNode)
  self.panelPath = Urls.StoryBubbleDialog
  self.plotTid = plotTid
  self.nodeTid = nodeTid
  for k, v in pairs(StoryBaseDialog) do
    if not self[k] then
      self[k] = v
    end
  end
  if self.plotTid and nodeTid then
    self:__InitStory(plotTid, nodeTid, nexCallback)
  end
end

function StoryBubbleDialog:OnBind(binder)
  self.binder = binder
  if self.plotTid and self.nodeTid then
    self.binder:SetText(self.ui.GameobjTextDesc, self:GetConfigDlgText())
  end
  self.ui.uiNode.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 0)
end

function StoryBubbleDialog:SetContent(text)
  self.binder:SetText(self.ui.GameobjTextDesc, text)
end

function StoryBubbleDialog:SetLocalPostion(x, y, z)
  local newX = x + 150
  local newY = y - 100
  local newZ = z
  local srcWorldPos = CS.UnityEngine.Vector3(newX, newY, newZ)
  self.ui.uiNode.transform.localPosition = srcWorldPos
end

function StoryBubbleDialog:OnTimer(curTime)
  if self:IsTimer(curTime) then
    self:TheClose()
    return true
  end
end

return StoryBubbleDialog
