local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local AU = require("Common/ActorUtil")
local LU = require("Common/ListUtil")
local RU = require("Common/RedMarkUtil")
local ACU = require("Common/ActivityUtil")
local U = require("Common/Util")
local TU = require("Common/TaskUtil")
local DBH = require("Manager/DataBindingHandler")
local m_activityManager = S:Get("ActivityManager")
local m_activity, m_taskList, m_culPlans, m_curCulPlan, m_actorIdDisplayInCultivation, m_curActor, m_xlsxNextReward, m_refNormalRewardSlot, m_refVipRewardSlot
local m_MaxProgress = 100

function Awake()
  LU.Bind(REF.TaskWrapContent, {
    updateRow = UpdateTaskSlot
  })
  WU.BindButtonEvent(REF.ButtonPreview, OnClickRewardPreview)
  WU.BindButtonEvent(REF.ButtonSelect1, OnClickSelect)
  WU.BindButtonEvent(REF.ButtonSelect2, OnClickSelect)
  WU.BindButtonEvent(REF.ButtonOpen, OnClickOpen)
  WU.BindButtonEvent(REF.ButtonVip, OnClickVip)
  WU.BindButtonEvent(REF.ButtonCGVip, OnClickVip)
  WU.BindButtonEvent(REF.GridRewardsPreview, OnClickRewardPreview)
  WU.BindButtonEvent(REF.SectionStarLevelup, OnClickStar)
  WU.BindButtonEvent(REF.SectionLevelup, OnClickLevel)
  m_refNormalRewardSlot = REF.RewardsGrid[0]
  m_refVipRewardSlot = REF.RewardsGrid[1]
  WU.SetActive(m_refNormalRewardSlot.VipNode, false)
  REF.WidgetCustomActorCultivationCG["$SetClickCallback"](OnClickCG)
end

function OnEnable()
  SetNodeActive(nil)
  this:Bind("CustomActorCultivation/CurActivity", OnActivity, false)
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  local activities = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.CustomActorCultivation)
  local acIndex = this:GetData("CustomActorCultivation/ActivityIndex")
  this:SetData("CustomActorCultivation/CurActivity", activities[acIndex])
  RU.SetRedMark(string.format("Welfare/CustomActorCultivation%s/Login", acIndex), false)
  WU.SetGameDataCache(string.format("CustomActorCultivation/%s/LastSeenTime", acIndex), CS.GameTime.serverUtc)
end

function OnDisable()
  this:Unbind("CustomActorCultivation/CurActivity", OnActivity)
  this:Unbind("fci/customActorCultivationTasks", OnTaskList)
  this:Unbind("fci/custom-actor-cultivation/", OnPlan)
  this:UnregisterGameEvent("UI/WindowUninited", OnWindowUninited)
end

function SetNodeActive(...)
  WU.SetActive(REF.NodeDecorate, false)
  WU.SetActive(REF.NodeStart, false)
  WU.SetActive(REF.NodeSelect, false)
  WU.SetActive(REF.NodeCultivation, false)
  WU.SetActive(REF.NodeCG, false)
  local nodes = {
    ...
  }
  for i = 1, #nodes do
    WU.SetActive(nodes[i], true)
  end
end

function OnActivity(activity)
  m_activity = activity
  if m_activity then
    REF.LabelTime1.UILabel.text = ACU.RenderTimeSlice(m_activity.timestampStart, m_activity.timestampEnd, "CultivationPvP_TimeLimit")
    local xlsxConfig = PB.get("ActivityCustomActorCultivation", PB.enum.ActivityType.CustomActorCultivation, m_activity.activityId)
    REF.TextureBG.UITexture.mainTexturePath = xlsxConfig.bigCgRes
    REF.SpriteActivityTitle1.UISprite.spriteName = xlsxConfig.titleRes
    REF.SpriteActivityTitle1.UISprite:MakePixelPerfect()
  end
  this:Unbind("fci/custom-actor-cultivation/", OnPlan)
  this:BindRemote(this:GameRequest("fci/custom-actor-cultivation/"), OnPlan)
end

function OnPlan(result)
  if result == nil then
    return
  end
  m_culPlans = result.culPlans
  m_curCulPlan = m_culPlans and m_culPlans[this:GetData("CustomActorCultivation/ActivityIndex")]
  if m_curCulPlan == nil or m_curCulPlan.actorId == 0 then
    SetNodeStart()
  end
  if m_curCulPlan and m_curCulPlan.actorId ~= 0 then
    if m_curCulPlan.started then
      if m_curCulPlan.progressReward >= m_MaxProgress then
        SetNodeCG()
      else
        SetNodeCultivation()
      end
    else
      SetNodeSelect()
    end
  end
end

function OnWindowUninited(window)
  if window.name == "ActorInfo" or window.name == "ActorMain" or window.name == "ActorDecompose" or window.name == "ActorTalentInherit" or window.name == "ActorCultivationBuy" then
    UpdateCulActor()
  end
end

function SetNodeStart()
  SetNodeActive(REF.NodeStart, REF.NodeDecorate)
end

function SetNodeSelect()
  SetNodeActive(REF.NodeSelect, REF.NodeDecorate)
  local actorId = m_curCulPlan.actorId
  SetActorEmote(actorId, _ENV["$"](REF.NodeActor1))
  REF.SpriteActorEmblem1.UISprite.spriteName = "actor_type_" .. actorId
  REF.SpriteActorNameSelect.UISprite.spriteName = "actor_name_" .. PB.get("ActorConfig", actorId).animRes
  REF.SpriteActorNameSelect.UISprite:MakePixelPerfect()
  REF.LabelOpenTimeHint.UILabel.text = WU.GetString("CustomActorCultivation_LastOpenTime", WU.RenderTime2(m_activity.timestampEnd, false, false, true))
  local xlsxConfig = PB.get("ActivityCustomActorCultivation", PB.enum.ActivityType.CustomActorCultivation, m_curCulPlan.activityId)
  local chipCount = xlsxConfig.displayChipCount
  local item = PB.get("TalentResetCost", actorId).cost
  REF.GridRewardsPreview[0]["$$SetData"](item.type, item.id)
  for i = 1, #REF.GridRewardsPreview - 1 do
    item = xlsxConfig.displayRewards[i]
    REF.GridRewardsPreview[i]["$$SetData"](item.type, item.id)
  end
end

function SetNodeCultivation()
  SetNodeActive(REF.NodeCultivation)
  REF.LabelTime2.UILabel.text = WU.GetString("ActorCultivation_TimeLimit", ACU.RenderTime2(m_curCulPlan.startTime, false, false), ACU.RenderTime2(m_curCulPlan.endTime, false, false))
  WU.SetActive(REF.SpriteVip, m_curCulPlan.vip)
  WU.SetActive(REF.EffectVip, not m_curCulPlan.vip)
  UpdateCulActor()
  UpdateProgress()
  this:DelayInvokeInFrames(2, CheckAlternative)
  WU.SetActive(REF.TaskList, false)
  this:Unbind("fci/customActorCultivationTasks", OnTaskList)
  this:Bind("fci/customActorCultivationTasks", OnTaskList)
end

function SetNodeCG()
  SetNodeActive(REF.NodeCG)
  WU.SetActive(REF.ButtonCGVip, not m_curCulPlan.vip)
  local xlsxConfig = PB.get("ActivityCustomActorCultivation", PB.enum.ActivityType.CustomActorCultivation, m_curCulPlan.activityId)
  REF.TextureCGBG.UITexture.mainTexturePath = xlsxConfig.bigCgRes
  REF.TextureCGActor.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. PB.get("ActorConfig", m_curCulPlan.actorId).animRes
  WU.ModifyPortrait(REF.TextureCGActor, m_curCulPlan.actorId, 7)
  REF.SpriteActorNameVertical.UISprite.spriteName = "actor_name_" .. PB.get("ActorConfig", m_curCulPlan.actorId).animRes
  REF.SpriteActorNameVertical.UISprite:MakePixelPerfect()
  REF.SpriteActorEmblem2.UISprite.spriteName = "actor_type_" .. m_curCulPlan.actorId
  REF.SpriteActivityTitle2.UISprite.spriteName = xlsxConfig.titleRes
  REF.SpriteActivityTitle2.UISprite:MakePixelPerfect()
end

function OnTaskList(taskList)
  if m_curCulPlan and m_curCulPlan.started and taskList then
    m_taskList = _ENV["!"](taskList):where(function(_, v)
      return v.actorCultivationActivityId == m_curCulPlan.activityId
    end):toarray()
    if m_taskList == nil or #m_taskList == 0 then
      LU.Set(REF.TaskWrapContent, 0)
      WU.SetActive(REF.TaskWrapContent, false)
      WU.SetActive(REF.NodeEmpty, true)
      return
    end
    if m_curCulPlan.progress >= m_MaxProgress then
      LU.Set(REF.TaskWrapContent, 0)
      WU.SetActive(REF.TaskWrapContent, false)
      WU.SetActive(REF.NodeEmpty, false)
      return
    end
    WU.SetActive(REF.TaskWrapContent, true)
    WU.SetActive(REF.NodeEmpty, false)
    WU.SetActive(REF.TaskList, true)
    LU.Set(REF.TaskWrapContent, #m_taskList)
  end
end

function UpdateTaskSlot(slotRef, wrapIndex, realIndex)
  if m_taskList and realIndex and realIndex < #m_taskList then
    local taskInfo = m_taskList[realIndex + 1]
    slotRef["$$SetView"](taskInfo)
    slotRef["$$SetRewardClick"](OnclickTaskReward)
  end
end

function UpdateProgress()
  m_xlsxNextReward = GetNextXlsxReward()
  WU.SetActive(REF.NodeProgressDone, m_curCulPlan.progress == m_MaxProgress)
  WU.SetActive(REF.ProgressBar, m_curCulPlan.progress ~= m_MaxProgress)
  REF.LabelMaxProgress.UILabel.text = m_MaxProgress .. "%"
  REF.LabelCurrentProgress.UILabel.text = m_curCulPlan.progress .. "%"
  REF.LabelNextProgress.UILabel.text = m_xlsxNextReward.progress .. "%"
  WU.SetActive(REF.NodeReward, m_xlsxNextReward ~= nil)
  if m_xlsxNextReward then
    WU.SetActive(REF.CGRewardSlot, m_xlsxNextReward.progress == m_MaxProgress)
    WU.SetActive(_ENV["$"](REF.CGRewardSlot).NodeEffect, m_curCulPlan.progress == m_MaxProgress)
    WU.SetActive(REF.RewardsGrid, m_xlsxNextReward.progress ~= m_MaxProgress)
    if m_xlsxNextReward.progress == m_MaxProgress then
      REF.WidgetCustomActorCultivationCG["$SetData"](m_curCulPlan.activityId, m_curCulPlan.actorId)
    else
      SetRewardSlot(m_refNormalRewardSlot, false)
      SetRewardSlot(m_refVipRewardSlot, true)
    end
  end
end

function SetRewardSlot(refReward, isVip)
  local rewardConfig = fif(isVip, m_xlsxNextReward.rewardVip[1], m_xlsxNextReward.reward[1])
  local item = {}
  if rewardConfig.chipCount > 0 then
    table.copy(PB.get("TalentResetCost", m_curCulPlan.actorId).cost, item)
    item.count = rewardConfig.chipCount
  else
    item = rewardConfig.item
  end
  refReward.WidgetIconSlot["$SetData"](item.type, item.id, item.count)
  local canReward = m_curCulPlan.progress >= m_xlsxNextReward.progress
  local received = fif(isVip, m_curCulPlan.progressRewardVip, m_curCulPlan.progressReward) >= m_xlsxNextReward.progress
  if isVip then
  end
  WU.SetActive(refReward.EffectCanReward, isVip and m_curCulPlan.vip and canReward and not received)
  refReward.WidgetIconSlot["$SetTips"](fif(received, "received", nil))
  refReward.WidgetIconSlot["$SetClickCallback"](function()
    OnClickProgressReward(isVip)
  end)
end

function UpdateCulActor()
  local uid = AU.GetHighestLevelActor(m_curCulPlan.actorId)
  m_curActor = this:GetData("fci/actor/" .. uid)
  if m_actorIdDisplayInCultivation ~= m_curActor.id then
    SetActorEmote(m_curActor.id, _ENV["$"](REF.NodeActor2))
    m_actorIdDisplayInCultivation = m_curActor.id
  end
  REF.SpriteQuality.UISprite.spriteName = string.lower(AU.ActorQuality2Tag[m_curActor.quality])
  REF.LabelActorLevel.UILabel.text = WU.GetString("Window_Level", m_curActor.level)
  local reachMaxLevel = m_curActor.level >= AU.GetActorMaxLevel()
  local maxStar = PB.all("Misc"):first().maxStarLevel
  REF.WidgetStarGridL["$SetStar"](m_curActor.star, maxStar - m_curActor.star, true, 2)
  local isMaxStar = maxStar <= m_curActor.star
  if not reachMaxLevel then
    local levelupExp = PB.get("ActorLevelup", m_curActor.level + 1)
    local currentExp = m_curActor.curExp
    REF.NodeExpProgressBar.UIProgressBar.value = currentExp / levelupExp.exp
  else
    REF.NodeExpProgressBar.UIProgressBar.value = 1
  end
end

function CheckAlternative()
  local dontShow = WU.GetGameDataCache("ActorCultivationInheirtBOX")
  if dontShow then
    return
  end
  local actorList = AU.GetActorListById(m_curCulPlan.actorId)
  local _, altActor = table.find(actorList, function(k, v)
    return v.quality > m_curActor.quality
  end)
  if altActor then
    WU.ShowMessageYesNo(WU.GetString("CustomActorCultivation_QualityHint"), function(action, toggleSelect)
      WU.SetGameDataCache("ActorCultivationInheirtBOX", toggleSelect)
      if action == "YES" then
        this:SetData("ActorTalentInherit/Mode", 1)
        this:SetData("Actor/SelectedUid", m_curActor.uid)
        WU.AcquireWindowAsync("ActorTalentInherit")
      end
    end, WU.GetString("ActorCultivation_GoToInherit"), nil, nil, nil, nil, WU.GetString("ActorCultivation_NeverShowAgain"))
  end
end

function GetNextXlsxReward()
  local xlsxNormalReward, xlsxVipReward
  for i = m_curCulPlan.progressReward + 1, m_MaxProgress do
    local xlsxConfig = PB.get("CustomActorCultivationProgressReward", i)
    if xlsxConfig then
      xlsxNormalReward = xlsxConfig
      break
    end
  end
  if m_curCulPlan.vip then
    for i = m_curCulPlan.progressRewardVip + 1, m_MaxProgress do
      local xlsxConfig = PB.get("CustomActorCultivationProgressReward", i)
      if xlsxConfig then
        xlsxVipReward = xlsxConfig
        break
      end
    end
  end
  if xlsxNormalReward and xlsxVipReward then
    return fif(xlsxNormalReward.progress < xlsxVipReward.progress, xlsxNormalReward, xlsxVipReward)
  elseif xlsxNormalReward then
    return xlsxNormalReward
  else
    return xlsxVipReward
  end
end

function SetActorEmote(actorId, ref)
  local actor = PB.get("ActorConfig", actorId)
  local roleId = actor.role
  local signboard = PB.all("Signboard")
  local array = _ENV["!"](signboard):where(function(k, v)
    return v.roleId == roleId and v.type == PB.enum.SignboardType.Emote
  end):toarray()
  table.sort(array, function(a, b)
    return a.BoardOfEmote < b.BoardOfEmote
  end)
  local emote = array[1]
  WU.SetActive(ref.WidgetBoardActor, true)
  WU.SetActive(ref.TextureActor, false)
  this:DelayInvokeInFrames(1, function()
    if ref.WidgetBoardActor.gameObject.activeInHierarchy then
      if emote then
        ref.WidgetBoardActor["$PlayByActorID"](emote.BoardOfEmote, "Gacha")
      else
        ref.TextureActor.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. actor.animRes
        WU.SetActive(ref.TextureActor, true)
        WU.SetActive(ref.WidgetBoardActor, false)
      end
    end
  end)
  local portrait = PB.get("ActorPortrait", actorId, 0)
  if portrait and portrait.position[9] then
    local position = portrait.position[9]
    if position.scale and position.scale ~= 0 then
      ref.ActorHolder.transform.localScale = CS.UnityEngine.Vector3.one * position.scale
    end
    ref.ActorHolder.transform.localPosition = CS.UnityEngine.Vector3(position.Xoffset, position.Yoffset, 0)
  end
end

function PlayAnimExp()
  REF.EffectRewardGot.EffectGenerator:Play()
  REF.EffectFly.EffectGenerator:Play()
  REF.EffectFly.TweenPosition:ResetToBeginning()
  REF.EffectFly.TweenPosition:PlayForward()
end

function RequestProgressReward(isVip)
  local progress = m_xlsxNextReward.progress
  this:GameRequest("fci/custom-actor-cultivation/progress-reward/"):Post({
    activityId = m_curCulPlan.activityId,
    vip = isVip,
    progress = progress
  }, function(resp)
    DBH.ResChange(resp.resChange)
    local data = this:GetData("fci/custom-actor-cultivation/")
    DBH.DBUpdate(data.culPlans, "activityId", resp.info)
    this:SetData("fci/custom-actor-cultivation/", data)
    local numExpItemGot = 0
    local numExpItemUse = 0
    for _, res in ipairs(resp.resChange) do
      if res.baseRes and res.baseRes.type == PB.enum.ResourceType.ResItem then
        local itemConfig = PB.get("ItemInfo", res.baseRes.id)
        if itemConfig and itemConfig.funcType == PB.enum.ItemFuncType.ActorExp then
          if 0 < res.baseRes.countDelta then
            numExpItemGot = numExpItemGot + res.baseRes.countDelta
          end
          if 0 > res.baseRes.countDelta then
            numExpItemUse = numExpItemUse - res.baseRes.countDelta
          end
        end
      end
    end
    if progress < m_MaxProgress then
      if 0 < numExpItemUse then
        this:DelayInvokeInFrames(1, PlayAnimExp)
      elseif 0 < numExpItemGot then
        WU.ShowHintText(WU.GetString("ActorCultivation_ExpOverflow"))
      elseif not table.empty(resp.resChange) then
        WU.ShowRewards(resp.resChange)
      end
    else
      local timeSpan = CS.System.TimeSpan(0, 0, CS.GameTime.serverUtc - m_curCulPlan.startTime)
      WU.AcquireWindowAsync("CustomActorCultivationComplete", function(w)
        _ENV["$"](w)["$$SetView"](m_curCulPlan.activityId, m_curCulPlan.actorId, timeSpan, true)
      end)
    end
  end)
end

function OnclickTaskReward(refGo)
  refGo.EffectReward.EffectGenerator:Play()
  WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, true)
  this:DelayInvokeInScaledSeconds(refGo.EffectReward.EffectGenerator.Duration, function()
    WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, false)
  end)
  local taskInfo = refGo["@taskInfo"]
  this:GameRequest("fci/custom-actor-cultivation/task-reward/" .. taskInfo.id):Post({}, function(resp)
    local taskList = this:GetData("fci/customActorCultivationTasks")
    local index, task = _ENV["!"](taskList):find(function(k, v)
      return v.id == taskInfo.id
    end)
    if task ~= nil then
      task.rewardGot = true
      table.remove(taskList, index)
      table.sort(taskList, TU.Sort)
    end
    local data = this:GetData("fci/custom-actor-cultivation/")
    DBH.DBUpdate(data.culPlans, "activityId", resp.result)
    this:SetData("fci/custom-actor-cultivation/", data)
    this:SetData("fci/customActorCultivationTasks", taskList)
  end)
end

function OnClickOpen()
  WU.AcquireWindowAsync("CustomActorCultivationMessageBox", function(w)
    local uid = AU.GetHighestLevelActor(m_curCulPlan.actorId)
    _ENV["$"](w)["$$SetActor"](uid, PB.enum.ActivityType.CustomActorCultivation)
  end)
end

function OnClickRewardPreview()
  WU.AcquireWindowAsync("CustomActorCultivationRewardPreview", function(w)
    _ENV["$"](w)["$$SetData"](m_curCulPlan.actorId, m_curCulPlan.activityId)
  end)
end

function OnClickProgressReward(isVip)
  local canReward = m_curCulPlan.progress >= m_xlsxNextReward.progress
  local received = fif(isVip, m_curCulPlan.progressRewardVip, m_curCulPlan.progressReward) >= m_xlsxNextReward.progress
  if canReward then
    if not received then
      RequestProgressReward(isVip)
    end
  else
    WU.ShowHintText(WU.GetString("CustomActorCultivation_RewardProgressLimit"))
  end
end

function OnClickVip()
  WU.AcquireWindowAsync("ActorCultivationBuy", function(w)
    local xlsxConfig = PB.get("ActivityCustomActorCultivation", PB.enum.ActivityType.CustomActorCultivation, m_curCulPlan.activityId)
    _ENV["$"](w)["$$SetData"]({
      isVip = m_curCulPlan.vip,
      cost = xlsxConfig.activeVipCost,
      activityId = m_curCulPlan.activityId,
      activityType = PB.enum.ActivityType.CustomActorCultivation
    })
  end)
end

function OnClickCG()
  RequestProgressReward(false)
end

function OnClickSelect()
  WU.AcquireWindowAsync("CustomActorCultivationSelect", function(ui)
    _ENV["$"](ui)["$$SetType"](PB.enum.ActivityType.CustomActorCultivation)
  end)
end

function OnClickStar()
  this:SetData("Actor/SelectedUid", m_curActor.uid)
  WU.AcquireWindowAsync("ActorInfo", function(window)
    _ENV["$"](window)["$$SetSelectedTab"]("TabStar")
    _ENV["$"](window)["$$ShowSwitch"]()
  end)
end

function OnClickLevel()
  this:SetData("Actor/SelectedUid", m_curActor.uid)
  WU.AcquireWindowAsync("ActorInfo", function(window)
    _ENV["$"](window)["$$SetSelectedTab"]("TabCultivation")
    _ENV["$"](window)["$$ShowSwitch"]()
  end)
end
