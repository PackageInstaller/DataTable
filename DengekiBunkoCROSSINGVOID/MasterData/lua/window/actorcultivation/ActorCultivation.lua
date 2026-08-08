local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local ACU = require("Common/ActivityUtil")
local GotoUtil = require("Common/GotoUtil")
local S = require("Common/Singleton")
local LU = require("Common/ListUtil")
local m_activityManager = S:Get("ActivityManager")
local TU = require("Common/TaskUtil")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local m_TaskListAll, m_TaskListCur, m_CurrentActivity, m_CurrentActor, m_CurrentActorUid, m_ActorCultivationInfo
local m_IsVip = false
local m_showRewardEffect = false
local m_Transform, m_CurEffectNode
local m_isPlaying = false
local m_isExpPlaying = false
local m_ExpItem = {
  10001,
  10002,
  10003,
  10004
}
local m_EffectName = {
  kirito = "UI_RoleNurturance_K",
  Kuroyuki = "UI_RoleNurturance_H"
}

function Start()
  LU.Bind(REF.TaskWrapContent, {
    updateRow = UpdateTaskSlot,
    delta = 0.05
  })
  WU.BindButtonEvent(REF.ButtonVip, OnClickButtonVip)
  WU.BindButtonEvent(REF.SectionLevelup, OnClickLevelUp)
  WU.BindButtonEvent(REF.SectionStarLevelup, OnClickStarLevelUp)
  WU.BindButtonEvent(REF.CGRewardSlot, OnClickSpecialReward)
  WU.BindButtonEvent(REF.ButtonPreview, OnClickPreview)
  WU.BindButtonEvent(REF.Vip, OnClickButtonVip)
  m_Transform = REF.LabelActorLevel.transform.position
end

function OnEnable()
  WU.SetActive(REF.TextureActor, false)
  WU.SetActive(REF.EmoteActor, false)
  WU.SetActive(REF.Container, false)
  WU.ToggleRendering(REF.TaskWrapContent, false)
  this:DelayInvokeInFrames(1, function()
    InitData()
  end)
  this:RegisterGameEvent("UI/WindowUninited", RefreshActor)
end

function InitData()
  WU.SetActive(REF.Container, true)
  this:Bind("ActorCultivation", OnActorCultivationChange)
  this:Bind("ActorCultivation/CurrentInfo", SetData)
  this:Bind("fci/actorCultivationTasks", UpdateTasks, false)
end

function RefreshActor(window)
  if window.name == "ActorInfo" or window.name == "ActorMain" or window.name == "ActorDecompose" or window.name == "ActorTalentInherit" or window.name == "ActorCultivationBuy" then
    OnChangeActorUid()
  end
end

function OnDisable()
  this:Unbind("ActorCultivation/CurrentInfo", SetData)
  this:Unbind("fci/actorCultivationTasks", UpdateTasks)
  this:Unbind("ActorCultivation", OnActorCultivationChange)
  this:UnregisterGameEvent("UI/WindowUninited", RefreshActor)
  this:SetData("ActorCultivation/CurrentInfo", nil)
  this:SetData("ActorCultivation/PlayTween", false)
end

function OnActorCultivationChange(info)
  local CurrentInfo = this:GetData("ActorCultivation/CurrentInfo")
  if CurrentInfo == nil or info == nil then
    return
  end
  m_CurrentActor = CurrentInfo.actorId
  m_CurrentActivity = CurrentInfo.activity
  for _, v in pairs(info) do
    if v.activityId == CurrentInfo.activity then
      m_ActorCultivationInfo = _ENV["!"](v):duplicate()
    end
  end
  if not m_IsVip and m_ActorCultivationInfo.vip and m_ActorCultivationInfo.progress ~= 100 then
    this:SetData("fci/actorCultivationTasks", this:GetData("fci/actorCultivationTasks"))
  end
  m_IsVip = m_ActorCultivationInfo.vip
  REF.ButtonVip.UISprite.alpha = fif(m_IsVip, 1, 0.1)
  WU.SetActive(REF.VipEffect, not m_IsVip)
  if m_ActorCultivationInfo.endTime ~= 0 then
    _ENV["$"](REF.NodeCG).BG.UITexture.mainTexturePath = "Texture/Background/ActorCultivation_" .. m_CurrentActor .. "a"
    _ENV["$"](REF.NodeCG).Decor.UISprite.spriteName = "ActorCultivation/ActorCultivation_share_name3_" .. m_CurrentActor .. "a"
    _ENV["$"](REF.NodeCG).Decor.UISprite:SnapWithoutScale()
    _ENV["$"](REF.NodeCG).DecorName.UISprite.spriteName = "ActorCultivation/ActorCultivation_share_name1_" .. m_CurrentActor .. "a"
    WU.SetActive(REF.Vip, not m_IsVip)
    WU.SetActive(REF.NodeCG, true)
    WU.SetActive(REF.Container, false)
    return
  end
  UpdateProgressReward()
end

function SetData()
  WU.SetActive(REF.NodeCG, false)
  WU.SetActive(REF.Container, true)
  local CurrentInfo = this:GetData("ActorCultivation/CurrentInfo")
  local info = this:GetData("ActorCultivation")
  if info and m_isExpPlaying then
    m_isExpPlaying = false
    this:SetData("ActorCultivation", info)
  end
  if CurrentInfo == nil then
    return
  end
  m_CurrentActivity = CurrentInfo.activity
  m_CurrentActor = CurrentInfo.actorId
  this:SetData("CollectionsActorSelected", m_CurrentActor)
  OnActorCultivationChange(info)
  if m_CurrentActivity == nil or m_CurrentActor == nil or m_ActorCultivationInfo == nil then
    error("ActorCultivation", "CurrentInfo not complete ---- actorId:" .. m_CurrentActor .. "----activity" .. m_CurrentActivity)
    return
  end
  if m_ActorCultivationInfo.endTime ~= 0 then
    _ENV["$"](REF.NodeCG).BG.UITexture.mainTexturePath = "Texture/Background/ActorCultivation_" .. m_CurrentActor .. "a"
    WU.SetActive(REF.NodeCG, true)
    WU.SetActive(REF.Container, false)
    return
  end
  if m_isPlaying then
    m_isPlaying = false
    local tasks = this:GetData("fci/actorCultivationTasks")
    UpdateTasks(tasks)
  end
  OnChangeActorUid()
  local boardActorConfig = PB.get("BoardActorConfig", m_CurrentActor)
  if boardActorConfig then
    WU.SetActive(REF.TextureActor, false)
    WU.SetActive(REF.EmoteActor, true)
    local portrait = PB.get("ActorCultivationEmote", m_CurrentActor)
    if portrait then
      if portrait.scale and portrait.scale ~= 0 then
        REF.WidgetBoardActor.transform.localScale = CS.UnityEngine.Vector3.one * portrait.scale
      end
      REF.WidgetBoardActor.transform.localPosition = CS.UnityEngine.Vector3(portrait.Xoffset, portrait.Yoffset, 0)
    end
    this:DelayInvokeInFrames(1, function()
      REF.WidgetBoardActor["$PlayByActorID"](m_CurrentActor)
    end)
  else
    WU.SetActive(REF.TextureActor, true)
    WU.SetActive(REF.EmoteActor, false)
    local config = PB.get("ActorConfig", m_CurrentActor)
    if config then
      local portrait = PB.get("ActorPortrait", m_CurrentActor, 0)
      if portrait and portrait.position[4] then
        local position = portrait.position[4]
        if position.scale and position.scale ~= 0 then
          REF.TextureActor.transform.localScale = CS.UnityEngine.Vector3.one * position.scale
        end
        REF.TextureActor.transform.localPosition = CS.UnityEngine.Vector3(position.Xoffset, position.Yoffset, 0)
      end
      REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorPortraitFull/actor_portrait_full_" .. config.animRes
    else
      warning("ActorCultivation", "no actor with id " .. m_CurrentActor)
    end
  end
  local SpriteDesc = "ActorCultivation/ActorCultivation_title_" .. m_CurrentActor .. "a"
  REF.SpriteDesc.UISprite.spriteName = SpriteDesc
  local acList = this:GetData("ActivityList")
  local startTime, endTime
  for _, ac in pairs(acList) do
    if ac.activityId == m_CurrentActivity then
      startTime = ac.timestampStart
      endTime = ac.timestampEnd
      break
    end
  end
  local startDate = ACU.RenderTime2(startTime)
  local endDate = ACU.RenderTime2(endTime, true)
  REF.LabelTime.UILabel.text = WU.GetString("ActorCultivation_TimeLimit", startDate, endDate)
  local tasks = this:GetData("fci/actorCultivationTasks")
  UpdateTasks(tasks)
  CheckAlternative()
  UpdateProgressReward()
end

function CheckAlternative()
  local DoNotShow = WU.GetGameDataCache("ActorCultivationInheirtBOX")
  if DoNotShow then
    return
  end
  local acList = AU.GetActorListById(m_CurrentActor)
  local quality = this:GetData("fci/actor/" .. m_CurrentActorUid).quality
  local alternativeUid = m_CurrentActorUid
  for _, actor in pairs(acList) do
    if quality < actor.quality then
      alternativeUid = actor.uid
      quality = actor.quality
    end
  end
  if m_CurrentActorUid ~= alternativeUid then
    WU.ShowMessageYesNo(WU.GetString("ActorCultivation_QualityHint"), function(action, toggleSelect)
      WU.SetGameDataCache("ActorCultivationInheirtBOX", toggleSelect)
      if action == "YES" then
        this:SetData("ActorTalentInherit/Mode", 1)
        this:SetData("Actor/SelectedUid", m_CurrentActorUid)
        WU.AcquireWindowAsync("ActorTalentInherit")
      end
    end, WU.GetString("ActorCultivation_GoToInherit"), nil, nil, nil, nil, WU.GetString("ActorCultivation_NeverShowAgain"))
  end
end

function UpdateTasks(taskList)
  if taskList == nil or m_CurrentActivity == nil or m_CurrentActor == nil then
    LU.Set(REF.TaskWrapContent, 0)
    WU.ToggleRendering(REF.TaskWrapContent, false)
    WU.ToggleRendering(REF.NoMoreTask, false)
    return
  end
  if m_ActorCultivationInfo and m_ActorCultivationInfo.progress == 100 then
    WU.ToggleRendering(REF.TaskWrapContent, false)
    WU.ToggleRendering(REF.NoMoreTask, false)
    return
  end
  m_TaskListAll = taskList
  m_TaskListCur = TU.GetTaskListByActivityId(taskList, m_CurrentActivity)
  if not m_isPlaying then
    if m_TaskListCur == nil or #m_TaskListCur == 0 then
      WU.ToggleRendering(REF.TaskWrapContent, false)
      WU.ToggleRendering(REF.NoMoreTask, true)
    else
      WU.ToggleRendering(REF.TaskWrapContent, true)
      WU.ToggleRendering(REF.NoMoreTask, false)
      LU.Set(REF.TaskWrapContent, #m_TaskListCur)
    end
  end
end

function UpdateTaskSlot(slotRef, wrapIndex, realIndex)
  if m_TaskListCur and realIndex and realIndex < #m_TaskListCur then
    local taskInfo = m_TaskListCur[realIndex + 1]
    WU.ToggleRendering(slotRef, true)
    slotRef["$$SetView"](taskInfo, 3)
    slotRef["$$ToggleRemainTime"](false)
    slotRef["$$SetRewardClick"](OnclickTaskReward)
    slotRef["@index"] = wrapIndex
    _ENV["$"](slotRef.BtnGetReward)["@index"] = wrapIndex
  end
end

function OnclickTaskReward(go)
  local ref = _ENV["$"](go)
  local taskInfo = ref["@taskInfo"]
  this:GameRequest("fci/task/" .. taskInfo.id .. "/reward-actor-cultivation/"):Post({}, function(result)
    local index, task = _ENV["!"](m_TaskListAll):find(function(k, v)
      return v.id == taskInfo.id
    end)
    if task ~= nil then
      task.rewardGot = true
      table.remove(m_TaskListAll, index)
      table.sort(m_TaskListAll, TU.Sort)
    end
    local info = this:GetData("ActorCultivation")
    for _, v in pairs(info) do
      if v.activityId == m_CurrentActivity then
        v.progress = result.progress
        break
      end
    end
    if ref["@index"] then
      m_isPlaying = true
      WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, true)
      this:SetData("ActorCultivation/PlayTween", true)
      this:SetData("fci/actorCultivationTasks", m_TaskListAll)
      this:SetData("ActorCultivation", info)
      REF.TaskWrapContent[ref["@index"]].Bg.EffectGenerator:Play(function()
        WU.ToggleRendering(REF.TaskWrapContent[ref["@index"]].root, false)
        this:DelayInvokeInSeconds(0.4, function()
          WU.ToggleRendering(REF.TaskWrapContent[ref["@index"]].root, false)
          if result.progress == 100 then
            this:SetData("fci/actorCultivationTasks", this:GetData("fci/actorCultivationTasks"))
          else
            m_TaskListCur = TU.GetTaskListByActivityId(m_TaskListAll, m_CurrentActivity)
            if m_TaskListCur == nil or #m_TaskListCur == 0 then
              WU.ToggleRendering(REF.TaskWrapContent, false)
              WU.ToggleRendering(REF.NoMoreTask, true)
            else
              WU.ToggleRendering(REF.TaskWrapContent, true)
              WU.ToggleRendering(REF.NoMoreTask, false)
              LU.Set(REF.TaskWrapContent, #m_TaskListCur)
            end
          end
          m_isPlaying = false
          WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, false)
        end)
      end)
    end
  end)
end

function OnChangeActorUid(lazy)
  local uid = AU.GetHighestLevelActor(m_CurrentActor)
  if uid == nil then
    error("Fatal error, no actors with id", m_CurrentActor)
    return
  end
  m_CurrentActorUid = uid
  this:SetData("Actor/SelectedUid", m_CurrentActorUid)
  if lazy then
    return
  end
  local maxStar = PB.all("Misc"):first().maxStarLevel
  local maxActorLevel = AU.GetActorMaxLevel()
  local actor = this:GetData("fci/actor/" .. m_CurrentActorUid)
  REF.SpriteQuality.UISprite.spriteName = string.lower(AU.ActorQuality2Tag[actor.quality])
  local reachMaxLevel = maxActorLevel <= actor.level
  REF.LabelActorLevel.UILabel.text = WU.GetString("Window_Level", actor.level)
  REF.WidgetStarGridL["$SetStar"](actor.star, maxStar - actor.star, true, 2)
  local isMaxStar = maxStar <= actor.star
  if not reachMaxLevel then
    local levelupExp = PB.get("ActorLevelup", actor.level + 1)
    local currentExp = actor.curExp
    REF.NodeExpProgressBar.UIProgressBar.value = currentExp / levelupExp.exp
  else
    REF.NodeExpProgressBar.UIProgressBar.value = 1
  end
end

function OnClickGridRewardSlot(go)
  local ref = _ENV["$"](go)
  if ref["@canReward"] then
    this:GameRequest("/fci/actor-cultivation/progress-reward/"):Post({
      progress = ref["@progress"],
      activityId = m_CurrentActivity,
      vip = ref["@vip"]
    }, function(result)
      DBH.ResChange(result.resChange)
      local _, change = table.find(result.resChange, function(_, change)
        return change.actor
      end)
      local info = this:GetData("ActorCultivation")
      for _, v in pairs(info) do
        if v.activityId == m_CurrentActivity then
          if ref["@vip"] then
            v.progressRewardVip = result.info.progressRewardVip
            break
          end
          v.progressReward = result.info.progressReward
          break
        end
      end
      local getExpItem = 0
      local useExpItem = 0
      local isExpItem = false
      for _, res in pairs(result.resChange) do
        if res.baseRes and res.baseRes.countDelta then
          if 0 < res.baseRes.countDelta then
            for i = 1, #m_ExpItem do
              if m_ExpItem[i] == res.baseRes.id then
                getExpItem = res.baseRes.countDelta + getExpItem
                isExpItem = true
              end
            end
          elseif 0 > res.baseRes.countDelta then
            for i = 1, #m_ExpItem do
              if m_ExpItem[i] == res.baseRes.id then
                useExpItem = -res.baseRes.countDelta + useExpItem
              end
            end
          end
        end
      end
      if ref.EffectExp and isExpItem then
        m_CurEffectNode = ref.EffectExp
        WU.SetActive(REF.EffectExp, true)
        m_showRewardEffect = true
        m_isExpPlaying = true
        WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, true)
        this:DelayInvokeInSeconds(0.5, function()
          WU.SetActive(REF.EffectExp, false)
          ref.EffectExp.transform.localPosition = CS.UnityEngine.Vector3.zero
          m_showRewardEffect = false
          OnChangeActorUid()
          if getExpItem > useExpItem then
            WU.ShowHintText(WU.GetString("ActorCultivation_ExpOverflow"))
          end
          m_isExpPlaying = false
          this:SetData("ActorCultivation", info)
          WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, false)
        end)
      else
        WU.ShowRewards(result.resChange)
        this:SetData("ActorCultivation", info)
      end
    end)
  elseif ref["@rewardGot"] then
    WU.ShowHintText(WU.GetString("ActorCultivation_RewardGot"))
  elseif ref["@vip"] and not m_IsVip then
    WU.ShowHintText(WU.GetString("ActorCultivation_VipReward"))
  elseif ref["@rewardToGet"] then
    WU.ShowHintText(WU.GetString("ActorCultivation_ProgressNotEnough", ref["@rewardToGet"]))
  end
end

function OnClickPreview()
  if m_CurrentActivity == nil then
    return
  end
  WU.AcquireWindowAsync("ActorCultivationRewardPreview", function(window)
    _ENV["$"](window)["$$SetData"](m_CurrentActivity)
  end)
end

function OnClickLevelUp()
  if m_CurrentActorUid then
    WU.AcquireWindowAsync("ActorInfo", function(window)
      _ENV["$"](window)["$$SetSelectedTab"]("TabCultivation")
      _ENV["$"](window)["$$ShowSwitch"]()
    end)
  end
end

function OnClickStarLevelUp()
  WU.AcquireWindowAsync("ActorInfo", function(window)
    _ENV["$"](window)["$$SetSelectedTab"]("TabStar")
    _ENV["$"](window)["$$ShowSwitch"]()
  end)
end

function OnClickSpecialReward()
  local effectName
  if m_CurrentActor == 1502 then
    effectName = m_EffectName.kirito
  elseif m_CurrentActor == 1514 then
    effectName = m_EffectName.Kuroyuki
  else
    warning("\229\136\134\228\186\171\231\137\185\230\149\136\228\184\141\229\173\152\229\156\168,actorId:", m_CurrentActor)
  end
  local SpriteFrame = "ActorCultivation/ActorCultivation_share_name2_bg_" .. m_CurrentActor .. "a"
  if m_ActorCultivationInfo.progress < 100 then
    WU.ShowHintText(WU.GetString("ActorCultivation_ProgressNotEnough", 100))
    return
  end
  if m_ActorCultivationInfo.endTime == 0 then
    DB:GameRequest("fci/actor-cultivation/progress-reward"):Post({
      activityId = m_CurrentActivity,
      progress = 100,
      vip = false
    }, function(result)
      local info = this:GetData("ActorCultivation")
      local changeInfo = result.info
      for _, v in pairs(info) do
        if v.activityId == m_CurrentActivity then
          v.endTime = changeInfo.endTime
          v.progressReward = changeInfo.progressReward
          v.progressRewardVip = changeInfo.progressRewardVip
          break
        end
      end
      this:SetData("ActorCultivation", info)
      local timeSpan = CS.System.TimeSpan(0, 0, changeInfo.endTime - m_ActorCultivationInfo.startTime)
      local time = timeSpan.Days
      WU.AcquireWindowAsync("ActorCultivationComplete", function(win)
        _ENV["$"](win)["$$SetView"]({
          time = time,
          effectName = effectName,
          SpriteFrame = SpriteFrame
        })
      end)
    end)
  else
    local time = WU.RenderTimeSpan(result.endTime - m_ActorCultivationInfo.startTime)
    WU.AcquireWindowAsync("ActorCultivationComplete", function(win)
      _ENV["$"](win)["$$SetView"]({
        time = time,
        effectName = effectName,
        SpriteFrame = SpriteFrame
      })
    end)
  end
end

function OnClickButtonVip()
  WU.AcquireWindowAsync("ActorCultivationBuy", function(win)
    local costs = PB.get("ActorCultivation", m_CurrentActivity).resActiveVip
    _ENV["$"](win)["$$SetData"]({
      isVip = m_IsVip,
      cost = costs,
      activityId = m_CurrentActivity
    })
  end)
end

function UpdateProgressReward()
  local progress = m_ActorCultivationInfo.progress
  local normalRewardProgress = m_ActorCultivationInfo.progressReward
  local vipRewardProgress = m_ActorCultivationInfo.progressRewardVip
  m_IsVip = m_ActorCultivationInfo.vip
  WU.SetActive(REF.VipEffect, not m_IsVip)
  REF.ButtonVip.UISprite.alpha = fif(m_IsVip, 1, 0.1)
  local rewardProgress
  if m_IsVip then
    if normalRewardProgress == 100 then
      rewardProgress = 100
    else
      rewardProgress = fif(normalRewardProgress < vipRewardProgress, normalRewardProgress, vipRewardProgress)
    end
  else
    rewardProgress = normalRewardProgress
  end
  WU.ToggleRendering(REF.CGRewardSlot, false)
  WU.ToggleRendering(REF.RewardsGrid, rewardProgress < 99)
  WU.SetActive(REF.RewardsGrid[0].EffectCanReward, false)
  WU.SetActive(REF.RewardsGrid[1].EffectCanReward, false)
  if progress == 100 then
    WU.SetActive(REF.ProgressBar, false)
    WU.SetActive(REF.NodeProgressDone, rewardProgress ~= 100)
    WU.SetActive(_ENV["$"](REF.CGRewardSlot).NodeEffect, rewardProgress == 99)
    WU.SetActive(REF.NodeCG, rewardProgress == 100)
    WU.ToggleRendering(REF.TaskWrapContent, false)
  else
    WU.SetActive(REF.ProgressBar, true)
    WU.SetActive(REF.NodeProgressDone, false)
    REF.CurrentProgress.UILabel.text = progress .. "%"
    local progressInfo = PB.all("ActorCultivationProgressReward")
    local nextProgress = 100
    for _, v in pairs(progressInfo) do
      if v.activityId == m_CurrentActivity and progress < v.progress then
        nextProgress = v.progress
        break
      end
    end
    REF.NextProgress.UILabel.text = nextProgress .. "%"
  end
  if rewardProgress ~= 100 then
    local rewardsToGet
    if normalRewardProgress ~= vipRewardProgress and m_IsVip then
      local nextProgress = fif(normalRewardProgress > vipRewardProgress, normalRewardProgress, vipRewardProgress)
      rewardsToGet = PB.get("ActorCultivationProgressReward", m_CurrentActivity, nextProgress)
    else
      local progressRewards = PB.all("ActorCultivationProgressReward")
      for _, v in pairs(progressRewards) do
        if v.activityId == m_CurrentActivity and rewardProgress < v.progress then
          rewardsToGet = v
          break
        end
      end
    end
    if rewardsToGet then
      if rewardsToGet.progress == 100 then
        REF.CGRewardSlot.UITexture.mainTexturePath = "Texture/Welfare/ActorCultivation_small_" .. m_CurrentActor .. "a"
        WU.ToggleRendering(REF.CGRewardSlot, true)
        WU.ToggleRendering(REF.RewardsGrid, false)
      else
        WU.ToggleRendering(REF.CGRewardSlot, false)
        WU.ToggleRendering(REF.RewardsGrid, true)
        local reward = rewardsToGet.reward[1]
        local vipReward = rewardsToGet.rewardVip[1]
        REF.RewardsGrid[0]["$$SetData"](reward.type, reward.id, reward.count)
        REF.RewardsGrid[0]["$$SetClickCallback"](OnClickGridRewardSlot)
        REF.RewardsGrid[1]["$$SetData"](vipReward.type, vipReward.id, vipReward.count)
        REF.RewardsGrid[1]["$$SetClickCallback"](OnClickGridRewardSlot)
        REF.RewardsGrid[0]["@vip"] = false
        REF.RewardsGrid[1]["@vip"] = true
        REF.RewardsGrid[0]["@rewardToGet"] = rewardsToGet.progress
        REF.RewardsGrid[1]["@rewardToGet"] = rewardsToGet.progress
        if progress >= rewardsToGet.progress then
          if rewardsToGet.progress == normalRewardProgress then
            REF.RewardsGrid[0]["@canReward"] = false
            REF.RewardsGrid[0]["@rewardGot"] = true
          elseif normalRewardProgress < rewardsToGet.progress then
            REF.RewardsGrid[0]["@canReward"] = true
            REF.RewardsGrid[0]["@progress"] = rewardsToGet.progress
            WU.SetActive(REF.RewardsGrid[0].EffectCanReward, true)
          end
          if m_IsVip then
            if rewardsToGet.progress == vipRewardProgress then
              REF.RewardsGrid[1]["@canReward"] = false
              REF.RewardsGrid[1]["@rewardGot"] = true
            elseif vipRewardProgress < rewardsToGet.progress then
              REF.RewardsGrid[1]["@canReward"] = true
              REF.RewardsGrid[1]["@progress"] = rewardsToGet.progress
              WU.SetActive(REF.RewardsGrid[1].EffectCanReward, true)
            end
          else
            REF.RewardsGrid[1]["@canReward"] = false
          end
        else
          REF.RewardsGrid[0]["@canReward"] = false
          REF.RewardsGrid[1]["@canReward"] = false
          REF.RewardsGrid[0]["@rewardGot"] = false
          REF.RewardsGrid[1]["@rewardGot"] = false
        end
      end
    end
  end
end

function Update()
  if m_showRewardEffect then
    local step = CS.GameTime.deltaTime * 10
    m_CurEffectNode.transform.position = CS.UnityEngine.Vector3.MoveTowards(m_CurEffectNode.transform.position, m_Transform, step)
  end
end
