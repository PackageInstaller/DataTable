local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local IU = require("Common/ItemUtil")
local DBH = require("Manager/DataBindingHandler")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local TU = require("Common/TaskUtil")
local NU = require("Common/NotepadUtil")
local GotoUtil = require("Common/GotoUtil")
local BoxId = PB.all("Misc"):first().taskPresentRewardBoxId
local m_task
local ActorTypePrefix = {
  "WindowActorList_Actor",
  "WindowActorList_Assist"
}
local m_totalTaskList, m_outstandingTaskList, m_progressRatioMap
local m_mode = 0

function Awake()
  WU.BindButtonEvent(REF.TextureActor, OnClickChangeActor)
  WU.BindButtonEvent(REF.LINE01, OnClickChangeActor)
  WU.BindButtonEvent(REF.ButtonRule, function()
    WU.AcquireWindowAsync("RuleCommon", function(ui)
      _ENV["$"](ui)["$$SetLabel"](WU.GetString("Help_TaskPresent"))
    end)
  end)
  WU.BindButtonEvent(REF.ButtonGoto, OnClickGoto)
  WU.BindButtonEvent(REF.ButtonCollectionsActor, EnterCollectionsActor)
  WU.BindButtonEvent(REF.ButtonGet, OnClickBtnGetOrGo)
  local presentTasks = table.sort(this:GetData("fci/presentTasks"), function(a, b)
    return a.res.priority > b.res.priority
  end)
  local temp = {}
  for _, v in ipairs(presentTasks) do
    table.insert(temp, v.res)
  end
  m_totalTaskList = temp
  if 1 < #m_totalTaskList then
    local oldtask = table.find(m_totalTaskList, function(k, v)
      return v.id < 3030
    end)
    if oldtask then
      m_totalTaskList = PB.all("TaskInfo"):where(function(k, v)
        return v.category == PB.enum.TaskCategory.Present and v.id < 3030
      end):toarray():sort(function(a, b)
        return a.priority > b.priority
      end)
    else
      m_mode = 1
    end
  else
    m_totalTaskList = PB.all("TaskInfo"):where(function(k, v)
      return v.category == PB.enum.TaskCategory.Present and v.id < 3030
    end):toarray():sort(function(a, b)
      return a.priority > b.priority
    end)
  end
  m_outstandingTaskList = _ENV["!"](m_totalTaskList):where(function(k, v)
    return v.outstanding
  end):toarray():sort(function(a, b)
    return a.priority > b.priority
  end)
  MakeProgressRatioMap()
  BindClickEvent()
end

function OnEnable()
  this:Bind("fci/currentPresentTask", OnCurrentPresentTaskChanged)
  this:Bind("taskPresentTargetActor", OnTargetActorChanged)
end

function OnDisable()
  this:Unbind("fci/currentPresentTask", OnCurrentPresentTaskChanged)
  this:Unbind("taskPresentTargetActor", OnTargetActorChanged)
end

function OnCurrentPresentTaskChanged(task)
  if task then
    m_task = task
    REF.LabelTitle.UILabel.text = WU.GetString("TaskName_" .. m_task.id)
    ShowProgress(false)
    REF.LabelDesc.UIHtmlLabel.text = WU.GetString("TaskDesc_" .. m_task.id, m_task.res.maxProgress, TU.GetParamLocalizationText(m_task.res.taskParam, m_task.res.goalType)) .. string.format(" (%s/%s)", m_task.progress, m_task.res.maxProgress)
    local resRewards = m_task.res.reward
    for i = 0, #REF.GridRewards - 1 do
      local r = resRewards[i + 1]
      if r then
        WU.SetActive(REF.GridRewards[i].root, true)
        REF.GridRewards[i]["$$SetData"](r.type, r.id, r.count)
      else
        WU.SetActive(REF.GridRewards[i].root, false)
      end
    end
    REF.GridRewards.UIGrid:Reposition()
    WU.ToggleRendering(REF.ButtonGet, m_task.isDone and not m_task.rewardGot)
    REF.LabelGet.UILabel.text = WU.GetString(fif(m_totalTaskList:last().id == m_task.id, "Window_GetActorReward", "Window_GetReward"))
    REF.ButtonGoto.gameObject:SetActive(m_task.res.gotoId and m_task.res.gotoId ~= 0 and not m_task.isDone)
  elseif 0 < this:GetData("fci/item/" .. BoxId).count then
    local lastTaskRes = m_totalTaskList:last()
    REF.LabelTitle.UILabel.text = WU.GetString("TaskName_" .. lastTaskRes.id)
    ShowProgress(true)
    REF.LabelDesc.UIHtmlLabel.text = WU.GetString("TaskDesc_" .. lastTaskRes.id, lastTaskRes.maxProgress, TU.GetParamLocalizationText(lastTaskRes.taskParam, lastTaskRes.goalType)) .. string.format(" (%s/%s)", lastTaskRes.maxProgress, lastTaskRes.maxProgress)
    local resRewards = lastTaskRes.reward
    for i = 0, #REF.GridRewards - 1 do
      local r = resRewards[i + 1]
      if r then
        WU.SetActive(REF.GridRewards[i].root, true)
        REF.GridRewards[i]["$$SetData"](r.type, r.id, r.count)
      else
        WU.SetActive(REF.GridRewards[i].root, false)
      end
    end
    REF.GridRewards.UIGrid:Reposition()
    WU.ToggleRendering(REF.ButtonGet, true)
    REF.LabelGet.UILabel.text = WU.GetString("Window_GetActorReward")
  end
end

function OnTargetActorChanged(actorId)
  local active = actorId ~= nil and actorId ~= 0
  WU.SetActive(REF.ButtonEmpty, not active)
  WU.SetActive(REF.TextureActor, active)
  if active then
    local resConfig = PB.get("ActorConfig", actorId)
    REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. resConfig.animRes
    local textCV = WU.GetString("ActorCV_" .. actorId)
    textCV = string.replace(textCV, "CV\239\188\154", "")
  end
end

function ShowProgress(finished)
  if finished then
    _ENV["$"](REF.NodeProgressBar).SpriteFg.UISprite.fillAmount = 1
    for i = 0, #REF.NodeRewardFlags - 2 do
      WU.SetActive(REF.NodeRewardFlags[i].SpriteGot, true)
    end
    WU.SetActive(REF.NodeRewardFlags[#REF.NodeRewardFlags - 1].SpriteGot, false)
  elseif m_mode == 0 then
    _ENV["$"](REF.NodeProgressBar).SpriteFg.UISprite.fillAmount = m_progressRatioMap[m_task.id]
    local index = table.find(m_totalTaskList, function(k, v)
      return v.id == m_task.id
    end)
    for i = 0, #REF.NodeRewardFlags - 1 do
      local outstandingIndex = table.find(m_totalTaskList, function(k, v)
        return REF.NodeRewardFlags[i]["@taskId"] == v.id
      end)
      WU.SetActive(REF.NodeRewardFlags[i].SpriteGot, outstandingIndex and index > outstandingIndex)
    end
  elseif m_mode == 1 then
    _ENV["$"](REF.NodeProgressBar).SpriteFg.UISprite.fillAmount = m_progressRatioMap[m_task.id]
    local index = table.find(m_totalTaskList, function(k, v)
      return v.id == m_task.id
    end)
    for i = 0, #REF.NodeRewardFlags - 1 do
      local outstandingIndex = table.find(m_totalTaskList, function(k, v)
        return REF.NodeRewardFlags[i]["@taskId"] == v.id
      end)
      if outstandingIndex ~= nil then
        WU.SetActive(REF.NodeRewardFlags[i].SpriteGot, index > outstandingIndex)
      end
    end
  end
end

function OnClickChangeActor()
  WU.AcquireWindowAsync("ManualBoxActor", function(ui)
    _ENV["$"](ui)["$$SetBoxIdTaskPresentChoose"](BoxId)
  end)
end

function OnClickBtnGetOrGo()
  if this:GetData("fci/item/" .. BoxId).count > 0 then
    EnterItemUse()
    return
  end
  this:GameRequest("fci/task/" .. m_task.id .. "/reward/"):Post(nil, function(result)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange, ManualBoxActorCallback)
    local tasks = this:GetData("fci/presentTasks")
    local _, task = table.find(tasks, function(k, v)
      return v.res.id == m_task.id
    end)
    task.rewardGot = true
    DB:BroadcastGameEvent("SetViewInfo", tasks[1].id, nil)
    this:SetData("fci/presentTasks", tasks)
  end)
end

function EnterItemUse()
  WU.AcquireWindowAsync("ManualBoxActor", function(ui)
    _ENV["$"](ui)["$$SetBoxIdTaskPresent"](BoxId, ManualBoxActorCallback)
  end)
end

function ManualBoxActorCallback(flag)
  if flag then
    WU.RecycleWindow(this)
  end
end

function EnterCollectionsActor()
  local isLocked, unlockLevel = WU.WindowIsLocked(PB.enum.UnlockWindow.Journey, PB.enum.UnlockWindow.Journey)
  if not isLocked then
    NU.GetCollectionsActor(function()
      WU.AcquireWindowAsync("CollectionsActor", function(w)
        _ENV["$"](w)["$$Goto"](this:GetData("taskPresentTargetActor"))
      end)
    end)
  end
end

function OnClickGoto()
  local g = PB.get("Goto", m_task.res.gotoId)
  if g == nil then
    error("Task", "Goto id " .. m_task.res.gotoId .. " doesn't exist")
    return
  end
  local fromWindowName = this:GetData("NewerPlan/FromWindow")
  if fromWindowName and fromWindowName == g.windowName and fromWindowName ~= "City" then
    WU.RecycleWindow("ProgressTask")
  else
    GotoUtil.Goto(g.windowName, g.params)
  end
end

function OnClickPreview(taskId)
  local taskRes = PB.get("TaskInfo", taskId)
  local index = table.find(m_totalTaskList, function(k, v)
    return v.id == taskId
  end)
  WU.AcquireWindowAsync("RewardPreview", function(ui)
    _ENV["$"](ui)["$$SetView"](taskRes.reward, WU.GetString("Achievements_RewardsPreview"), WU.GetString("Window_RewardOnStep", index), false, WU.GetString("Window_GotIt"))
  end)
end

function MakeProgressRatioMap()
  m_progressRatioMap = {}
  local totalCount = m_totalTaskList:count()
  local totalOutstandingCount = m_outstandingTaskList:count()
  local segRatio = 1 / (m_outstandingTaskList:count() - 1)
  local lastRatio, lastIndex
  for i = 1, #m_totalTaskList do
    local taskRes = m_totalTaskList[i]
    if taskRes.outstanding then
      local index = table.find(m_outstandingTaskList, function(k, v)
        return v.id == taskRes.id
      end)
      lastIndex = i
      lastRatio = (index - 1) / (totalOutstandingCount - 1)
      m_progressRatioMap[taskRes.id] = lastRatio
    else
      do
        local nextOutstandingIndex = table.find(m_totalTaskList, function(k, v)
          return v.outstanding and k > i
        end) or totalCount
        m_progressRatioMap[taskRes.id] = lastRatio + segRatio * ((i - lastIndex) / (nextOutstandingIndex - lastIndex))
      end
    end
  end
end

function BindClickEvent()
  WU.TraverseChildren(REF.NodeRewardFlags, function(go, i)
    local ref = _ENV["$"](go)
    WU.SetActive(ref.WidgetIconSlot, false)
    WU.SetActive(ref.SpriteReward, false)
    if m_outstandingTaskList[i + 1] ~= nil then
      local taskId = m_outstandingTaskList[i + 1].id
      ref["@taskId"] = taskId
    else
      WU.SetActive(ref["$"], false)
    end
  end)
  local length = REF.SpriteFg.UISprite.width
  local count = #m_outstandingTaskList
  local peerLen = length / (count - 1)
  WU.TraverseChildren(REF.NodeRewardFlags, function(go, i)
    local ref = _ENV["$"](go)
    if i >= count then
      return
    end
    ref.root.transform.localPosition = CS.UnityEngine.Vector3(peerLen * i - 20, 0, 0)
    WU.SetActive(ref.WidgetIconSlot, ref["@taskId"] ~= nil)
    if ref["@taskId"] ~= nil then
      local taskRes = PB.get("TaskInfo", ref["@taskId"])
      local reward = taskRes.reward[1]
      ref.WidgetIconSlot["$SetData"](reward.type, reward.id, reward.count)
      ref.WidgetIconSlot.transform.localScale = {
        x = 0.4,
        y = 0.4,
        z = 1
      }
      WU.SetActive(_ENV["$"](ref.WidgetIconSlot).LabelBottomRight, false)
      WU.SetActive(ref.NodeBG, false)
      ref.WidgetIconSlot["$SetClickCallback"](function()
        OnClickPreview(ref["@taskId"])
      end)
    end
  end)
end
