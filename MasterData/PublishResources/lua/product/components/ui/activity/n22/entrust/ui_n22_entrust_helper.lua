_class("UIN22EntrustHelper", Object)
UIN22EntrustHelper = UIN22EntrustHelper

function UIN22EntrustHelper.GetLevelIndex(component, entrustid)
  local tb = component:GetAllLevelId()
  local rtb = table.reverse(tb)
  return rtb[entrustid]
end

function UIN22EntrustHelper.CalcNodeInfo(showEnterAnim, component, levelId)
  local startId = component:FindEventStart(levelId)
  local all = component:GetAllOpenEvents(levelId)
  local tb_out = {}
  for _, nodeId in ipairs(all) do
    local time = 267
    local isPlay, delay
    if showEnterAnim then
      isPlay, delay = UIN22EntrustHelper._CalcNodeInfo_EnterAnim(component, nodeId, startId)
    else
      isPlay, delay = UIN22EntrustHelper._CalcNodeInfo_NewNode(component, nodeId, startId)
    end
    tb_out[nodeId] = {
      isPlay = isPlay,
      delay = delay,
      time = time
    }
  end
  return tb_out
end

function UIN22EntrustHelper._CalcNodeInfo_EnterAnim(component, nodeId, startId)
  local speed = 5
  local posStart = component:GetEventPointPos(startId)
  local pos = component:GetEventPointPos(nodeId)
  local dis = Vector2.Distance(pos, posStart)
  local delay = dis / speed
  return true, delay
end

function UIN22EntrustHelper._CalcNodeInfo_NewNode(component, nodeId, startId)
  local playTime = 300
  local key = component:GetEntrustEventNewKey(nodeId)
  local isPlay = nodeId ~= startId and LocalDB.GetInt(key, 0) == 0
  LocalDB.SetInt(key, 1)
  local delay = isPlay and 1 * playTime or 0
  return isPlay, delay
end

function UIN22EntrustHelper.CalcLineInfo(showEnterAnim, component, levelId, tb_node)
  local viLine = {}
  local tb_out = {}
  local openLines = component:GetOpenEventLine(levelId)
  for _, lineid in ipairs(openLines) do
    if not viLine[lineid] then
      viLine[lineid] = true
      UIN22EntrustHelper._CalcLineInfo(showEnterAnim, component, lineid, tb_node, tb_out)
    end
  end
  return tb_out
end

function UIN22EntrustHelper._CalcLineInfo(showEnterAnim, component, lineid, tb_node, tb_out)
  local leftEventId, rightEventId = component:GetLineConecctEvents(lineid)
  local leftNode, rightNode = tb_node[leftEventId], tb_node[rightEventId]
  if not leftNode or not rightNode then
    Log.exception("UIN22EntrustHelper.CalcLineInfo() line[", lineid, "] can't find node")
  end
  local dir = not rightNode.isPlay and leftNode.isPlay or rightNode.delay < leftNode.delay
  local posList = component:GetLinePosWithDirection(lineid, dir)
  local sumTime
  if showEnterAnim then
    sumTime = math.abs(leftNode.delay - rightNode.delay)
  else
    sumTime = 333
  end
  local isPlay = leftNode.isPlay or rightNode.isPlay
  local startTime = math.min(leftNode.delay, rightNode.delay) + leftNode.time / 2
  local oneTime = math.floor(sumTime / #posList)
  for i, pos in ipairs(posList) do
    local delay = startTime + (i - 1) * oneTime
    table.insert(tb_out, {
      id = lineid,
      from = pos[1],
      to = pos[2],
      isPlay = isPlay,
      delay = delay,
      time = oneTime
    })
  end
end

function UIN22EntrustHelper.CalcPlayerInfo(isMove, showEnterAnim, node)
  local isPlay, anim, delay
  if isMove then
    isPlay = true
    anim = "uieff_UIN22EntrustLevel_Player_in01"
    delay = 0
  elseif showEnterAnim then
    isPlay = true
    anim = "uieff_UIN22EntrustLevel_Player_in"
    delay = node.delay + node.time
  else
    isPlay = false
    anim = "uieff_UIN22EntrustLevel_Player_in01"
    delay = 0
  end
  local time = 333
  local tb_out = {
    isPlay = isPlay,
    anim = anim,
    delay = delay,
    time = time
  }
  return tb_out
end
