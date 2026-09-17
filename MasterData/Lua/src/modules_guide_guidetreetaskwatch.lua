local manager = class("guide.guideTreeTaskWatch")
local logTag = "引导卡点监听"

local function logInfo(msg)
  C_MJLog.LogDebug(string.format("[%s] %s", logTag, msg), C_ELogModule.Guide)
end

local function getGuideId(tree)
  return tree and tree.param and tree.param.guideId
end

local function shouldWatchTask(task)
  if task == nil or task.taskType ~= L_BevTree.taskType.action then
    return false
  end
  return true
end

local function buildRunningWatchedLeafKey(bevTree)
  local ids = {}
  for _, task in ipairs(bevTree.tasks or {}) do
    if shouldWatchTask(task) and task.lastResult == L_BevTree.taskResult.Running then
      table.insert(ids, task.id)
    end
  end
  if #ids == 0 then
    return ""
  end
  table.sort(ids, function(a, b)
    return a < b
  end)
  local parts = {}
  for _, id in ipairs(ids) do
    table.insert(parts, tostring(id))
  end
  return table.concat(parts, ",")
end

local function formatLeafKeyForLog(bevTree, key)
  if key == nil or key == "" then
    return "无"
  end
  local out = {}
  for sid in string.gmatch(key, "[^,]+") do
    local id = tonumber(sid)
    local task = id and bevTree:getTask(id)
    if task then
      table.insert(out, string.format("%s:%s", sid, tostring(task.className)))
    else
      table.insert(out, sid)
    end
  end
  return table.concat(out, "；")
end

local function hideSkipIfNeeded(tree, state, reason)
  if not state or not state.skipShown then
    return
  end
  local gid = getGuideId(tree)
  if gid then
    C_MJLog.LogInfo(string.format("[GuideSkip] source=guideTreeTaskWatch.hideSkipIfNeeded guideId=%s isShow=false skipNotSave=nil reason=%s leafKey=%s", tostring(gid), tostring(reason), tostring(state.lastRunningLeafKey)), C_ELogModule.Guide)
    L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.ShowSkipGuide, {guideId = gid, isShow = false})
    logInfo(string.format("引导ID=%s，已隐藏跳过入口（原因：%s）", tostring(gid), tostring(reason)))
  else
    logInfo(string.format("已隐藏跳过入口（原因：%s，无引导ID）", tostring(reason)))
  end
  state.skipShown = false
end

function manager.setupForTree(bevTree)
  if bevTree == nil then
    return
  end
  local sec = L_GameTpl:getGameConstTpl():getData("GUIDE_SKIP_BUTTON_DISPLAY_TIME", L_Const.GameTplType.int)
  local threshold = tonumber(sec) or 0
  bevTree._guideSkipWatch = {
    lastRunningLeafKey = nil,
    stuckStartTime = nil,
    skipShown = false,
    defaultThreshold = threshold,
    threshold = threshold
  }
  bevTree.onTaskUpdateHandler = nil
  local gid = getGuideId(bevTree)
  logInfo(string.format("已挂载监听：引导ID=%s，卡点阈值=%.2f秒（配置原始值=%s），行为树=%s；按每帧 Running 叶子集合对比计时", tostring(gid), threshold, tostring(sec), tostring(bevTree.jsonPath)))
end

function manager.teardownForTree(bevTree)
  if bevTree == nil then
    return
  end
  local gid = getGuideId(bevTree)
  local state = bevTree._guideSkipWatch
  local hadSkip = state and state.skipShown
  local lastKey = state and state.lastRunningLeafKey
  hideSkipIfNeeded(bevTree, state, "引导结束，卸载监听")
  bevTree.onTaskUpdateHandler = nil
  bevTree._guideSkipWatch = nil
  logInfo(string.format("已卸载监听：引导ID=%s，卸载时跳过按钮是否曾显示=%s，上一帧叶子签名=%s", tostring(gid), hadSkip and "是" or "否", tostring(lastKey)))
end

function manager.setSkipThresholdOverride(bevTree, seconds)
  local state = bevTree and bevTree._guideSkipWatch
  if state == nil then
    return
  end
  state.threshold = tonumber(seconds) or 0
  state.stuckStartTime = nil
  state.skipShown = false
  if state.threshold > 0 then
    state._loggedDisabled = nil
  end
  hideSkipIfNeeded(bevTree, state, "卡点阈值被覆盖，重新计时")
  local gid = getGuideId(bevTree)
  logInfo(string.format("引导ID=%s，卡点阈值已设为覆盖值 %.2f 秒（默认 %.2f 秒）", tostring(gid), state.threshold, state.defaultThreshold))
end

function manager.clearSkipThresholdOverride(bevTree)
  local state = bevTree and bevTree._guideSkipWatch
  if state == nil then
    return
  end
  state.threshold = state.defaultThreshold
  state.stuckStartTime = nil
  state.skipShown = false
  if state.threshold > 0 then
    state._loggedDisabled = nil
  end
  hideSkipIfNeeded(bevTree, state, "卡点阈值已恢复默认，重新计时")
  local gid = getGuideId(bevTree)
  logInfo(string.format("引导ID=%s，卡点阈值已恢复为默认 %.2f 秒", tostring(gid), state.threshold))
end

function manager.afterGuideTreeTick(bevTree)
  local state = bevTree._guideSkipWatch
  if state == nil then
    return
  end
  local gid = getGuideId(bevTree)
  if gid == nil then
    return
  end
  if state.threshold <= 0 then
    if not state._loggedDisabled then
      state._loggedDisabled = true
      logInfo(string.format("引导ID=%s：卡点阈值为0或未配置，本次引导不启用卡点跳过监听", tostring(gid)))
    end
    return
  end
  local key = buildRunningWatchedLeafKey(bevTree)
  if key == "" then
    if state.lastRunningLeafKey ~= nil and state.lastRunningLeafKey ~= "" then
      logInfo(string.format("引导ID=%s，本帧无 Running 的监听叶子（上一帧为「%s」），清空卡点计时", tostring(gid), formatLeafKeyForLog(bevTree, state.lastRunningLeafKey)))
    end
    hideSkipIfNeeded(bevTree, state, "当前无 Running 监听叶子")
    state.lastRunningLeafKey = ""
    state.stuckStartTime = nil
    state.skipShown = false
    return
  end
  if state.lastRunningLeafKey == key then
    if state.stuckStartTime == nil then
      state.stuckStartTime = C_Time.time
    end
    if not state.skipShown and C_Time.time - state.stuckStartTime >= state.threshold then
      C_MJLog.LogInfo(string.format("[GuideSkip] source=guideTreeTaskWatch.afterGuideTreeTick guideId=%s isShow=true skipNotSave=0 elapsed=%s threshold=%s leaf=%s", tostring(gid), tostring(C_Time.time - state.stuckStartTime), tostring(state.threshold), tostring(formatLeafKeyForLog(bevTree, key))), C_ELogModule.Guide)
      L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.ShowSkipGuide, {
        guideId = gid,
        isShow = true,
        skipNotSave = 0
      })
      state.skipShown = true
      logInfo(string.format("引导ID=%s，已达卡点时长：已显示跳过入口；连续 %.2f 秒叶子集未变，当前叶子=%s", tostring(gid), C_Time.time - state.stuckStartTime, formatLeafKeyForLog(bevTree, key)))
    end
    return
  end
  hideSkipIfNeeded(bevTree, state, "Running 叶子集合与上一帧不同，重新计时")
  local prevKey = state.lastRunningLeafKey
  state.lastRunningLeafKey = key
  state.stuckStartTime = C_Time.time
  state.skipShown = false
  logInfo(string.format("引导ID=%s，Running 叶子集变化：上一帧「%s」→ 本帧「%s」，已重新计时（阈值 %.2f 秒）", tostring(gid), prevKey == nil and "（首帧）" or formatLeafKeyForLog(bevTree, prevKey == "" and "" or prevKey), formatLeafKeyForLog(bevTree, key), state.threshold))
end

return manager
