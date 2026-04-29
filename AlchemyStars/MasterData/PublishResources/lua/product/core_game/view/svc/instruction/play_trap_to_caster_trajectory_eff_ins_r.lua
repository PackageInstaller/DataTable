require("base_ins_r")
_class("PlayTrapToCasterTrajectoryEffInstruction", BaseInstruction)
PlayTrapToCasterTrajectoryEffInstruction = PlayTrapToCasterTrajectoryEffInstruction

function PlayTrapToCasterTrajectoryEffInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._flySpeed = tonumber(paramList.flySpeed)
  self._flyTime = tonumber(paramList.flyTime)
  if not self._effectID or not Cfg.cfg_effect[self._effectID] then
    Log.exception(self._className, "effectID无效: ", tostring(self._effectID))
  end
  if not self._flySpeed and not self._flyTime then
    Log.exception(self._className, "flySpeed与flyTime不可同时为空")
  end
  self._trapIDList = {}
  if paramList.trapIDList then
    local ids = string.split(paramList.trapIDList, "|")
    for _, id in ipairs(ids) do
      local nid = tonumber(id)
      table.insert(self._trapIDList, nid)
    end
  end
end

function PlayTrapToCasterTrajectoryEffInstruction:GetCacheResource()
  local t = {}
  if self._effectID then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end

function PlayTrapToCasterTrajectoryEffInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local casterPos = casterEntity:GetPosition()
  local world = casterEntity:GetOwnerWorld()
  local targetGridPos = Vector2(5, 5)
  local trapServiceRender = world:GetService("TrapRender")
  local trapIDList = self._trapIDList
  if trapIDList then
    local trapGroup = world:GetGroup(world.BW_WEMatchers.Trap)
    for _, trapEntity in ipairs(trapGroup:GetEntities()) do
      local trapRenderCmpt = trapEntity:TrapRender()
      if trapRenderCmpt and not trapRenderCmpt:GetHadPlayDestroy() and table.icontains(trapIDList, trapRenderCmpt:GetTrapID()) then
        targetGridPos = trapEntity:GetGridPosition()
        break
      end
    end
  end
  if not targetGridPos then
    Log.exception(self._className, "没有机关位置")
    return
  end
  local rbsvc = world:GetService("BoardRender")
  local targetPos = rbsvc:GridPos2RenderPos(targetGridPos)
  local casterGridPos = rbsvc:BoardRenderPos2GridPos(casterPos)
  local fxsvc = world:GetService("Effect")
  local eFx = fxsvc:CreateCommonGridEffect(self._effectID, targetGridPos, casterGridPos - targetGridPos)
  YIELD(TT)
  if not eFx or not eFx:View() then
    return
  end
  local flyTime = self._flyTime
  if not flyTime then
    local dis = Vector3.Distance(targetPos, casterPos)
    flyTime = dis * self._flySpeed
  end
  local go = eFx:View():GetGameObject()
  local tsfm = go.transform
  local dotween = tsfm:DOMove(casterPos, flyTime * 0.001, false)
  if dotween then
    dotween:SetEase(DG.Tweening.Ease.InOutSine):OnComplete(function()
      go:SetActive(false)
      world:DestroyEntity(eFx)
    end)
  end
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    YIELD(TT, flyTime)
    if not dotween then
      world:DestroyEntity(eFx)
    end
  end)
end
