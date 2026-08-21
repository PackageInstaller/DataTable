_class("UIN20AVGGraphLine", UICustomWidget)
UIN20AVGGraphLine = UIN20AVGGraphLine

function UIN20AVGGraphLine:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
end

function UIN20AVGGraphLine:OnShow()
  self.go = self:GetGameObject()
  self.root = self:GetGameObject("root")
  self.s = self:GetUIComponent("RectTransform", "s")
  self.e = self:GetUIComponent("RectTransform", "e")
  self.poolStraight = self:GetUIComponent("UISelectObjectPath", "straight")
  self.poolCurve = self:GetUIComponent("UISelectObjectPath", "curve")
end

function UIN20AVGGraphLine:OnHide()
end

function UIN20AVGGraphLine:Flush(line)
  self.line = line
  local sNodeId = line.sNodeId
  local eNodeId = line.eNodeId
  local nodeS = self.data:GetNodeById(sNodeId)
  local nodeE = self.data:GetNodeById(eNodeId)
  if IsUnityEditor() then
    self.go.name = nodeS.id .. "." .. nodeS.title .. "_" .. nodeE.id .. "." .. nodeE.title
  end
  local stateS = nodeS:State()
  local stateE = nodeE:State()
  if nodeS:IsHide() then
    if stateS == AVGStoryNodeState.Complete then
      self.root:SetActive(true)
    else
      self.root:SetActive(false)
    end
  elseif stateS == AVGStoryNodeState.Complete and stateE then
    self.root:SetActive(true)
  else
    self.root:SetActive(false)
  end
  self:FlushLine()
  if sNodeId == 10 and eNodeId == 11 then
    self.e.transform.localRotation = Quaternion.Euler(0, 0, 90)
  end
end

function UIN20AVGGraphLine:FlushLine()
  local eNodeId = self.line.eNodeId
  local nodeE = self.data:GetNodeById(eNodeId)
  local stateE = nodeE:State()
  self.s.anchoredPosition = self.line.posS
  self.e.anchoredPosition = self.line.posE
  local isDot = stateE == AVGStoryNodeState.CantPlay
  self:FlushStraight(isDot)
  self:FlushCurve(isDot)
end

function UIN20AVGGraphLine:FlushStraight(isDot)
  local posLs = self:GetAllPos()
  local len = table.count(posLs) - 1
  self.poolStraight:SpawnObjects("UIN20AVGGraphLineStraight", len)
  local uis = self.poolStraight:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local index = i + 1
    local s = posLs[index - 1]
    local e = posLs[index]
    ui:Flush(s, e, isDot)
  end
end

function UIN20AVGGraphLine:FlushCurve(isDot)
  if not self.line.posLs then
    return
  end
  if table.count(self.line.posLs) < 1 then
    return
  end
  local posLs = self:GetAllPos()
  local count = table.count(posLs)
  local len = count - 2
  self.poolCurve:SpawnObjects("UIN20AVGGraphLineCurve", len)
  local uis = self.poolCurve:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local index = i + 1
    ui:Flush(posLs[index - 1], posLs[index], posLs[index + 1], isDot)
  end
end

function UIN20AVGGraphLine:GetAllPos()
  local posLs = {}
  table.insert(posLs, self.line.posS)
  if self.line.posLs then
    for i, pos in ipairs(self.line.posLs) do
      table.insert(posLs, pos)
    end
  end
  table.insert(posLs, self.line.posE)
  return posLs
end
