_class("UIWeChatScroll", Object)
UIWeChatScroll = UIWeChatScroll

function UIWeChatScroll:Constructor(owner)
  self.owner = owner
  self.cells = {}
  self.heights = {}
  self.defaultHeight = 875
  self:OnShow()
end

function UIWeChatScroll:InitScrollParam()
  self.cells = {}
  self.heights = {}
  self.defaultHeight = 875
end

function UIWeChatScroll:OnShow()
  self.scrollView = self.owner:GetUIComponent("ScrollRect", "chatscrollview")
  self.sop = self.owner:GetUIComponent("UISelectObjectPath", "Content")
  self.contentRect = self.owner:GetUIComponent("RectTransform", "Content")
  self.layout = self.owner:GetUIComponent("VerticalLayoutGroup", "Content")
end

function UIWeChatScroll:InitItems(talks, weChatRole)
  self.cells = {}
  self.heights = {}
  self.sop:SpawnObjects("UIWeChatCell", #talks)
  self.cells = self.sop:GetAllSpawnList()
  for index, cell in ipairs(self.cells) do
    local talk = talks[index]
    if talk then
      cell:Enable(true)
      local height = cell:SetData(talk, weChatRole)
      table.insert(self.heights, height)
    else
      cell:Enable(false)
    end
  end
  self:UpdateContentHeight()
end

function UIWeChatScroll:AddItem(talk, weChatRole)
  local cell = self.sop:SpawnObject("UIWeChatCell")
  local height = cell:SetData(talk, weChatRole)
  self.heights[#self.cells] = height
  table.insert(self.cells, cell)
  self:UpdateContentHeight()
end

function UIWeChatScroll:GetItem(talk)
  for index, cell in ipairs(self.cells) do
    if cell.talk.talkId == talk.talkId then
      return cell, index
    end
  end
  return nil
end

function UIWeChatScroll:UpdateItem(talk)
  local cell, index = self:GetItem(talk)
  if cell then
    local height = cell:SetData(talk)
    self.heights[index] = height
    self:UpdateContentHeight()
  end
end

function UIWeChatScroll:UpdateContentHeight()
  local contentHeight = 0
  for index, height in ipairs(self.heights) do
    contentHeight = contentHeight + height
  end
  if contentHeight < self.defaultHeight then
    contentHeight = self.defaultHeight
    self.layout.childAlignment = UnityEngine.TextAnchor.UpperLeft
    self.scrollView.enabled = false
  else
    self.layout.childAlignment = UnityEngine.TextAnchor.LowerLeft
    self.scrollView.enabled = true
  end
  self.contentRect.sizeDelta = Vector2(1227, contentHeight)
end
