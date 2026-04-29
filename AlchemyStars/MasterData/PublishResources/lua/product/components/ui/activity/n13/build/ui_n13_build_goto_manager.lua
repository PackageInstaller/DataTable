_class("UIN13BuildGotoManager", Object)
UIN13BuildGotoManager = UIN13BuildGotoManager

function UIN13BuildGotoManager:Constructor(buildManager, petManager, gotoRoot, gotoBtns, points, content, btnCallback)
  self._buildManager = buildManager
  self._petManager = petManager
  self._gotoRoot = gotoRoot
  self._gotoBtns = gotoBtns
  self._points = points
  self._lines = self:_InitLines(points)
  self._content = content
  self._btnCallback = btnCallback
end

function UIN13BuildGotoManager:_InitLines(points)
  local tb = {
    {
      points[1],
      points[2]
    },
    {
      points[3],
      points[4]
    },
    {
      points[5],
      points[6]
    },
    {
      points[7],
      points[8]
    }
  }
  return tb
end

function UIN13BuildGotoManager:Refresh(type)
  self.type = type
  self:_SetData(1, self:_GetShow_Name())
  self:_SetData(2, self:_GetShow_Pet())
end

function UIN13BuildGotoManager:_SetData(type, id)
  local gotoBtn = self._gotoBtns[type]
  if not id or id == 0 then
    gotoBtn:GetGameObject():SetActive(false)
    return
  end
  local target = Vector2.zero
  if type == 1 then
    target = self._buildManager:GetWidgetPos(id) + self._buildManager:GetWidgetDesPos(id)
  elseif type == 2 then
    local nodeId = self._petManager:_PetObj_GetPos(id)
    target = self._petManager._nodeData:GetNodePos(nodeId)
    target.y = target.y + 100
  end
  local pos = self:_CheckShowPos(self:_ConvertPos(target))
  if not pos then
    gotoBtn:GetGameObject():SetActive(false)
    return
  end
  gotoBtn:GetGameObject():SetActive(true)
  gotoBtn:GetGameObject().transform.anchoredPosition = pos
  local manager = type == 1 and self._buildManager or self._petManager
  gotoBtn:SetData(type, manager, id, function()
    gotoBtn:GetGameObject():SetActive(false)
    if self._btnCallback then
      self._btnCallback(target)
    end
  end, self.type)
end

function UIN13BuildGotoManager:_CheckShowPos(target)
  if UIActivityMath.IsInRect(target, self._gotoRoot.transform.rect) then
    return
  end
  for _, v in ipairs(self._lines) do
    if UIActivityMath.IsIntersection_V2(v[1], v[2], target, Vector2.zero) then
      return UIActivityMath.Inter(v[1], v[2], target, Vector2.zero)
    end
  end
  local dis = {}
  for i, v in ipairs(self._points) do
    dis[i] = Vector2.Distance(target, v)
  end
  local val, idx = table.min(dis)
  return self._points[idx]
end

function UIN13BuildGotoManager:_GetShow_Name()
  local buildItemIdList = self._buildManager:GetBuildItemIdList()
  for _, buildItemId in ipairs(buildItemIdList) do
    local isShow = self._buildManager:IsShow(buildItemId)
    local isNotComplete = not self._buildManager:IsAllStatusComplete(buildItemId)
    local isNextUnlock = isNotComplete and self._buildManager:IsNextStatusUnlock(buildItemId)
    if isShow and isNotComplete and isNextUnlock then
      return buildItemId
    end
  end
end

function UIN13BuildGotoManager:_GetShow_Pet()
  local haveStory = self._buildManager:CheckPicnicHaveStory()
  local seq = self._buildManager:GetPicnicCurSeq()
  local petId = self._buildManager:GetPicnicPet(seq)
  if haveStory then
    return petId
  end
end

function UIN13BuildGotoManager:_ConvertPos(point)
  local p = self._content.transform:TransformPoint(point)
  return self._gotoRoot.transform:InverseTransformPoint(p)
end
