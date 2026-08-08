local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local m_record
local m_lotteryIds = {
  1,
  2,
  3
}
local m_taskType = {
  1,
  2,
  3
}

function Start()
  WU.BindButtonEvent(REF.BtnReward, function()
    WU.AcquireWindowAsync("PrizePreview", function(window)
      _ENV["$"](window)["$$SetPrizePreview"]("GameLottery")
    end)
  end)
  WU.TraverseChildren(REF.NodeCanisters, function(go, i)
    WU.BindButtonEvent(_ENV["$"](go).root, OnCanisterClick)
  end)
end

function OnEnable()
  this:RegisterGameEvent("ActivityLotteryANewDay", OnANewDay)
  UpdateStaticUI()
  this:RegisterGameEvent("EvenLotterySuccess", OnLotterySuccess)
  local info = this:GetData("Welfare/Lottery")
  if info == nil then
    RequireData()
  else
    m_record = info
    UpdateUI()
  end
end

function UpdateStaticUI()
  WU.SetActive(REF.NodeDivinations, false)
  WU.SetActive(REF.NodeTasks, false)
  WU.SetActive(REF.LabelRemainTimes, false)
  local activities = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.Lottery) or _ENV["!"]({})
  local activity = activities[1]
  local startTime = ACU.RenderTime2(activity.timestampStart, true)
  local endTime = ACU.RenderTime2(activity.timestampClose, true)
  REF.LabelIntroduction.UILabel.text = WU.GetString("Lottery_Introduction", startTime, endTime)
  for i = 0, #REF.NodeCanisters - 1 do
    local ref = REF.NodeCanisters[i]
    local id = m_lotteryIds[i + 1]
    ref["@id"] = id
    ref.TextureName.UITexture.mainTexturePath = "Texture/lucky_draw/lucky_draw_" .. id
  end
  for i = 0, #REF.NodeTasks - 1 do
    local ref = REF.NodeTasks[i]
    local type = m_taskType[i + 1]
    ref.LabelTask.UILabel.text = WU.GetString("Lottery_Task_" .. type)
  end
end

function RequireData()
  this:GameRequest("fci/lottery"):Get(function(res)
    m_record = res.lotteryInfo
    table.sort(m_record.dailyLotteryHistory, function(a, b)
      return a.lotteryTime < b.lotteryTime
    end)
    local mergeHistory = _ENV["!"]({})
    for i = 1, #m_record.dailyLotteryHistory do
      local history = m_record.dailyLotteryHistory[i]
      local _, v = table.find(mergeHistory, function(k1, v1)
        return v1.lotteryId == history.lotteryId
      end)
      if v == nil then
        table.insert(mergeHistory, history)
      else
        v.lotteryLevel = math.max(v.lotteryLevel, history.lotteryLevel)
      end
    end
    m_record.mergeHistory = mergeHistory
    this:SetData("Welfare/Lottery", m_record)
    UpdateUI()
    local nextUpdateTime = CS.GameTime.serverNow:AddDays(1)
    this:SetData("Time/Welfare/Lottery", {nextUpdateTime = nextUpdateTime})
  end)
end

function UpdateUI()
  local resultCount = #m_record.mergeHistory
  for i = 0, #REF.NodeDivinations - 1 do
    local ref = REF.NodeDivinations[i]
    local isShow = resultCount >= i + 1
    WU.SetActive(ref.root, isShow)
    if isShow then
      local history = m_record.mergeHistory[i + 1]
      ref.LabelType.UILabel.text = WU.GetString("Lottery_Id_" .. history.lotteryId)
      ref.LabelResult.UILabel.text = WU.GetString("Lottery_Luck_" .. history.lotteryLevel)
    end
  end
  for i = 0, #REF.NodeTasks - 1 do
    local ref = REF.NodeTasks[i]
    local type = m_taskType[i + 1]
    local task = m_record.dailyTaskProgress[type]
    if task == nil then
      task = {progress = 0}
      m_record.dailyTaskProgress[type] = task
    end
    if task.target == nil then
      task.target = PB.get("LotteryTaskConfig", type).taskProgress
    end
    if task.progress >= task.target then
      task.hasDone = true
    end
    WU.SetActive(ref.SpriteGot, task.hasDone)
    WU.SetActive(ref.LabelProgress, not task.hasDone)
    ref.LabelProgress.UILabel.text = tostring(task.progress) .. "/" .. tostring(task.target)
  end
  REF.LabelRemainTimes.UILabel.text = m_record.lotteryTimes
  WU.SetActive(REF.NodeDivinations, true)
  WU.SetActive(REF.NodeTasks, true)
  WU.SetActive(REF.LabelRemainTimes, true)
  if 0 < m_record.lotteryTimes then
    for i = 0, #REF.NodeCanisters - 1 do
      this:DelayInvokeInSeconds(i * 1, function()
        local ref = REF.NodeCanisters[i]
        local id = m_lotteryIds[i + 1]
        local tex = WU.AcquireAsset("Texture/lucky_draw/lucky_draw_" .. id)
        ref.Text.MeshRenderer.material:SetTexture("_MainTex", tex)
        WU.SetActive(ref.EffectCanister, true)
        ref.EffectCanister.EffectGenerator:Play()
      end)
    end
  end
end

function OnDisable()
  this:UnregisterGameEvent("EvenLotterySuccess", OnLotterySuccess)
  this:UnregisterGameEvent("ActivityLotteryANewDay", OnANewDay)
  if m_record == nil then
    return
  end
  local hasAllDone = true
  for i, v in pairs(m_record.dailyTaskProgress) do
    if v.progress < v.target then
      hasAllDone = false
      break
    end
  end
  if not hasAllDone then
    this:SetData("Welfare/Lottery", nil)
  end
end

function OnCanisterClick(go)
  if m_record.lotteryTimes <= 0 then
    WU.ShowHintText(WU.GetString("Lottery_LackStick"))
    return
  end
  local id = _ENV["$"](go)["@id"]
  this:SetData("Welfare/Lottery/Id", id)
  WU.AcquireWindowAsync("GameLottery")
end

function OnLotterySuccess(level)
  local curLotteryId = this:GetData("Welfare/Lottery/Id")
  local index, v = table.find(m_record.mergeHistory, function(k1, v1)
    return v1.lotteryId == curLotteryId
  end)
  if v == nil then
    table.insert(m_record.mergeHistory, {lotteryId = curLotteryId, lotteryLevel = level})
    local count = #m_record.mergeHistory
    local ref = REF.NodeDivinations[count - 1]
    ref.LabelType.UILabel.text = WU.GetString("Lottery_Id_" .. curLotteryId)
    ref.LabelResult.UILabel.text = WU.GetString("Lottery_Luck_" .. level)
    WU.SetActive(ref.root, true)
  else
    v.lotteryLevel = math.max(level, v.lotteryLevel)
    REF.NodeDivinations[index - 1].LabelResult.UILabel.text = WU.GetString("Lottery_Luck_" .. v.lotteryLevel)
  end
  m_record.lotteryTimes = m_record.lotteryTimes - 1
  RU.SetRedMark("Welfare/Lottery", m_record.lotteryTimes > 0)
  if m_record.lotteryTimes <= 0 then
    for i = 0, #REF.NodeCanisters - 1 do
      local ref = REF.NodeCanisters[i]
      WU.SetActive(ref.EffectCanister, false)
    end
  end
  REF.LabelRemainTimes.UILabel.text = m_record.lotteryTimes
end

function OnANewDay()
  RequireData()
end
