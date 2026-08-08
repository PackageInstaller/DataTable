local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local U = require("Common/Util")
local GotoUtil = require("Common/GotoUtil")
local DBH = require("Manager/DataBindingHandler")
local IU = require("Common/ItemUtil")
local NU = require("Common/NotepadUtil")
local m_task, m_styleType, m_rewardClickCall, m_showRemainTime, m_curCultivation

function Awake()
end

function Start()
  WU.BindButtonEvent(REF.BtnGo, function()
    WU.RecordButtonClick(1001330 .. m_task.res.category .. 2)
    local g = PB.get("Goto", m_task.res.gotoId)
    if g == nil then
      error("Task", "Goto id " .. m_task.res.gotoId .. " doesn't exist")
      return
    end
    if g.id == 208 then
      local actorId = this:GetData("CollectionsActorSelected")
      if actorId then
        NU.GetCollectionsActor(function(actors)
          local actor = {}
          local index, actor = table.find(actors, function(k, v)
            return v.id == actorId
          end)
          if actor then
            WU.AcquireWindowAsync("CollectionsActorDetail", function(w)
              _ENV["$"](w)["$$SetActor"](actor)
            end)
          end
        end)
      end
    elseif g.id == 209 then
      local selectedUid = this:GetData("Actor/SelectedUid")
      if selectedUid then
        this:SetData("Actor/SelectedUid", nil)
        WU.AcquireWindowAsync("ActorMain", function()
          this:SetData("Actor/SelectedUid", selectedUid)
        end)
      end
    elseif g.id == 300 then
      local isLocked, unlockLevel = WU.WindowIsLocked(PB.enum.UnlockWindow.Journey, PB.enum.UnlockWindow.Journey)
      if not isLocked then
        WU.AcquireWindowAsync("Portal", function(win)
          _ENV["$"](win)["$$OnBookClick"]()
        end)
      end
    elseif m_task.res.category == PB.enum.TaskCategory.Repeat then
      GotoUtil.Goto(g.windowName, m_task.res.taskParam)
    else
      GotoUtil.Goto(g.windowName, g.params)
    end
  end)
  WU.BindButtonEvent(REF.BtnGetReward, OnGetRewardClick)
  if REF.BtnActivate then
    WU.BindButtonEvent(REF.BtnActivate, OnClickActivate)
  end
  if REF.ButtonPlatform then
    WU.BindButtonEvent(REF.ButtonPlatform, function()
      WU.AcquireWindowAsync("PlatformStartPage", function(ui)
        _ENV["$"](ui)["$$SetData"]()
      end)
    end)
  end
end

function Update()
  if m_task == nil or m_task.endTime == 0 then
    return
  end
  if REF.NodeRemainTime and m_showRemainTime ~= false then
    local remain = m_task.endTime - CS.GameTime.serverUtc
    if 0 <= remain then
      if not REF.NodeRemainTime.gameObject.activeSelf then
        REF.NodeRemainTime.gameObject:SetActive(true)
      end
      REF.LabelRemainTime.UIHtmlLabel.text = WU.RenderCountDownTime(remain, REF.LabelRemainTime.UIHtmlLabel.fontSize)
    else
      REF.NodeRemainTime.gameObject:SetActive(false)
    end
  end
end

function SetView(taskInfo, viewType, config)
  local fake = taskInfo.id < 0
  if REF.WeekFakeInfo then
    WU.ToggleRendering(REF.WeekFakeInfo, fake)
  end
  if REF.Rewards then
    WU.ToggleRendering(REF.Rewards, not fake)
  end
  if REF.TaskInfo then
    WU.ToggleRendering(REF.TaskInfo, not fake)
  end
  if REF.Test then
    WU.SetActive(REF.Test, false)
  end
  if not fake then
    local play = this:GetData("ActorCultivation/PlayTween")
    m_styleType = viewType or 1
    m_task = taskInfo
    _ENV["$"](REF.BtnGetReward)["@taskInfo"] = taskInfo
    if taskInfo and REF.Daily then
      WU.SetActive(REF.Daily, taskInfo.dailyRefresh)
    end
    local isCustom = taskInfo.res.refreshType == 1
    local hasActivePoint = taskInfo.res.activePoint ~= 0 or taskInfo.res.extraActivePoint ~= 0 or config and config.activePoint and config.activePoint ~= 0
    if REF.NodeRemainTime then
      REF.NodeRemainTime.gameObject:SetActive(false)
    end
    if REF.BtnActivate then
      WU.ToggleRendering(REF.BtnActivate, false)
    end
    if REF.TaskVip then
      WU.ToggleRendering(REF.TaskVip, false)
    end
    if REF.ActivePoint then
      REF.ActivePoint.gameObject:SetActive(hasActivePoint)
    end
    if REF.SpriteActivePoint_BG then
      REF.SpriteActivePoint_BG.gameObject:SetActive(hasActivePoint)
    end
    if REF.LabelActivePoint and hasActivePoint then
      REF.LabelActivePoint.UIHtmlLabel.text = fif(taskInfo.res.activePoint ~= 0, taskInfo.res.activePoint, fif(taskInfo.res.extraActivePoint ~= 0, taskInfo.res.extraActivePoint, config and config.activePoint))
    end
    if REF.SpriteQuality then
      local showQuality = taskInfo.res.category == PB.enum.TaskCategory.Week
      WU.ToggleRendering(REF.SpriteQuality, showQuality)
      if showQuality then
        REF.SpriteQuality.UISprite.spriteName = "mission/mission_level_" .. taskInfo.res.taskQuality
      end
    end
    local rewardList
    local rewardCount = #taskInfo.res.reward
    if m_styleType == 1 then
      for i = 0, #REF.Rewards - 1 do
        REF.Rewards[i].root.gameObject:SetActive(i == rewardCount - 1)
        if i == rewardCount - 1 then
          rewardList = REF.Rewards[i]
        end
      end
    elseif m_styleType == 2 then
      rewardList = _ENV["$"](REF.RewardList)
    end
    if rewardList ~= nil then
      for i = 0, #rewardList.root - 1 do
        if rewardCount < i + 1 then
          rewardList.root[i].WidgetIconSlotTask.gameObject:SetActive(false)
        else
          local data = taskInfo.res.reward[i + 1]
          rewardList.root[i].WidgetIconSlotTask["$SetData"](data.type, data.id, data.count)
          rewardList.root[i].WidgetIconSlotTask.gameObject:SetActive(true)
        end
      end
    end
    if m_styleType == 3 then
      REF.RewardProgressPoint.UISprite.spriteName = "ActorCultivation/ActorCultivation_bar_icon_" .. taskInfo.actorCultivationRewardProgress
    end
    if m_styleType == 1 then
      REF.ProgressBar.UIProgressBar.value = taskInfo.progress / taskInfo.res.maxProgress
      if taskInfo.progress >= taskInfo.res.maxProgress then
        REF.SpriteProgress.UISprite.spriteName = "levelup_bar_02"
      else
        REF.SpriteProgress.UISprite.spriteName = "levelup_bar_01"
      end
    end
    if REF.LabelProgress then
      REF.LabelProgress.UIHtmlLabel.text = taskInfo.progress .. "/" .. taskInfo.res.maxProgress
    end
    if REF.LabelTextProgress then
      REF.LabelTextProgress.UIHtmlLabel.text = WU.GetString("Window_Progress", taskInfo.progress, taskInfo.res.maxProgress)
    end
    local text = WU.GetString("TaskName_" .. taskInfo.id)
    REF.LabelTaskName.UIHtmlLabel.text = text
    REF.LabelTaskDesc.UIHtmlLabel.text = WU.GetString("TaskDesc_" .. taskInfo.id, HU.ApplyFontColor(taskInfo.res.maxProgress, "#0199E9"), GetParam())
    if m_styleType == 1 then
      REF.ButtonPlatform.gameObject:SetActive(false)
      if taskInfo.res.goalType == PB.enum.TaskType.GameCenterLoginMTimes then
        REF.SpriteDoing.gameObject:SetActive(false)
        REF.ButtonPlatform.gameObject:SetActive(taskInfo.res.gotoId == 0 and not taskInfo.isDone and not taskInfo.timeout)
      else
        REF.SpriteDoing.gameObject:SetActive(taskInfo.res.gotoId == 0 and not taskInfo.isDone and not taskInfo.timeout)
        REF.ButtonPlatform.gameObject:SetActive(false)
      end
    elseif m_styleType == 2 then
      REF.SpriteDoing.gameObject:SetActive(taskInfo.res.gotoId == 0 and not taskInfo.isDone and not taskInfo.timeout)
    elseif m_styleType == 3 then
      local isVipTask = taskInfo.actorCultivationVipOnly
      if isVipTask then
        WU.ToggleRendering(REF.TaskVip, true)
      end
      local infos = this:GetData("ActorCultivation")
      local vip = false
      if infos then
        for _, cultivation in pairs(infos) do
          if taskInfo.actorCultivationActivityId == cultivation.activityId then
            m_curCultivation = cultivation
            break
          end
        end
        if m_curCultivation ~= nil then
          WU.ToggleRendering(REF.BtnActivate, not m_curCultivation.vip and isVipTask)
          WU.ToggleRendering(REF.StateNode, m_curCultivation.vip or not isVipTask)
        end
      end
      REF.SpriteDoing.gameObject:SetActive(taskInfo.res.gotoId == 0 and not taskInfo.isDone and not taskInfo.timeout)
    end
    REF.BtnGo.gameObject:SetActive(taskInfo.res.gotoId ~= 0 and not taskInfo.isDone)
    REF.SpriteCompleted.gameObject:SetActive(taskInfo.rewardGot)
    if REF.SpriteTimeout then
      REF.SpriteTimeout.gameObject:SetActive(not taskInfo.rewardGot and taskInfo.timeout)
    end
    REF.BtnGetReward.gameObject:SetActive(taskInfo.isDone and not taskInfo.rewardGot and not taskInfo.timeout)
    if taskInfo.rewardGot or taskInfo.timeout then
      REF.Container.UIWidget.alpha = 0.6
    else
      REF.Container.UIWidget.alpha = 1
    end
    if REF.ActorCultivationVisual and play then
      REF.ActorCultivationVisual.UIPlayTween:Play(true)
    end
    if REF.SpriteRefreshType then
      WU.SetActive(REF.SpriteRefreshType, m_task.isNew and m_task.res.category == PB.enum.TaskCategory.Week)
    end
    if REF.FinalTask then
      WU.SetActive(REF.FinalTask, m_task.res.goalType == 43 and m_task.res.category == PB.enum.TaskCategory.Main)
    end
  end
end

function OnGetRewardClick(go)
  WU.RecordButtonClick(1001330 .. m_task.res.category .. 1)
  if m_rewardClickCall then
    m_rewardClickCall(go)
    return
  end
  this:GameRequest("fci/task/" .. m_task.id .. "/reward/"):Post(nil, function(result)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange)
    local all = this:GetData("fci/task/")
    for category, taskList in pairs(all) do
      local index, task = _ENV["!"](taskList):find(function(k, v)
        return v.id == m_task.id
      end)
      if task ~= nil then
        task.rewardGot = true
        table.remove(taskList, index)
        if m_task.res.category ~= PB.enum.TaskCategory.Favour and m_task.res.category ~= PB.enum.TaskCategory.Deadline and m_task.res.category ~= PB.enum.TaskCategory.Main then
          table.insert(taskList, task)
        end
        this:SetData("fci/task/", all)
        break
      end
    end
    local points = this:GetData("fci/task/activepoint/")
    points.activePoint = result.activePoint
    this:SetData("fci/task/activepoint/", points)
    if m_task.res.category == PB.enum.TaskCategory.Week then
      local weekInfo = this:GetData("task/taskWeekInfo")
      weekInfo.taskDoneCount = weekInfo.taskDoneCount + 1
      this:SetData("task/taskWeekInfo", weekInfo)
    end
  end)
end

function GetParam()
  local param = m_task.res.taskParam
  if param[1] ~= nil and (m_task.res.goalType == PB.enum.TaskType.BalanceP0DungeonMTimes or m_task.res.goalType == PB.enum.TaskType.BalanceP0DungeonMTimesP1Star or m_task.res.goalType == PB.enum.TaskType.BalanceP0DungeonMTimesActorPN or m_task.res.goalType == PB.enum.TaskType.BalanceP0GoldMTimes) then
    if param[1] == 0 then
      return WU.GetString("Task_AnyDugeon")
    else
      return WU.GetString("DungeonName_" .. param[1])
    end
  end
  return ColorParam(param)
end

function ColorParam(param)
  local p = {}
  for i = 1, #param do
    table.insert(p, HU.ApplyFontColor(param[i], "#0199E9"))
  end
  return table.unpack(p)
end

function SetRewardClick(call)
  m_rewardClickCall = call
end

function SetActivePointIcon(spriteName, atlasName)
  REF.SpriteActivePoint.UISprite.spriteName = spriteName
  if atlasName then
    REF.SpriteActivePoint.UISprite.atlasPath = atlasName
  else
    REF.SpriteActivePoint.UISprite.atlasPath = "Welfare"
  end
end

function ToggleRemainTime(isShow)
  REF.NodeRemainTime.gameObject:SetActive(isShow)
  m_showRemainTime = isShow
end

function OnClickActivate()
  if m_curCultivation then
    WU.AcquireWindowAsync("ActorCultivationBuy", function(win)
      local costs = PB.get("ActorCultivation", m_curCultivation.activityId).resActiveVip
      _ENV["$"](win)["$$SetData"]({
        isVip = m_curCultivation.vip,
        cost = costs,
        activityId = m_curCultivation.activityId,
        activityType = PB.enum.ActivityType.ActorCultivation
      })
    end)
  end
end
