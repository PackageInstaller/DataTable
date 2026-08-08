local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local U = require("Common/Util")
local GotoUtil = require("Common/GotoUtil")
local DBH = require("Manager/DataBindingHandler")
local TU = require("Common/TaskUtil")
local AU = require("Common/ActorUtil")
local m_task, m_rewardClickCall, m_curCulPlan

function Start()
  WU.BindButtonEvent(REF.BtnGo, OnClickGo)
  WU.BindButtonEvent(REF.BtnGetReward, OnGetRewardClick)
  WU.BindButtonEvent(REF.BtnActivate, OnClickActivate)
end

function SetView(taskInfo)
  m_task = taskInfo
  REF["@taskInfo"] = m_task
  WU.ToggleRendering(REF.BtnActivate, false)
  WU.ToggleRendering(REF.TaskVip, false)
  REF.LabelProgress.UIHtmlLabel.text = m_task.progress .. "/" .. m_task.res.maxProgress
  local text = WU.GetString("TaskName_" .. m_task.id)
  REF.LabelTaskName.UIHtmlLabel.text = text
  local params = {}
  table.copy(m_task.dynamicParams, params)
  for i, v in ipairs(m_task.res.paramsReplace) do
    local paramIndex = v.paramIndex + 1
    if v.replaceMethod == 1 then
      params[paramIndex] = WU.GetString("ActorName_" .. params[paramIndex])
    elseif v.replaceMethod == 2 then
      params[paramIndex] = WU.GetString("RoleName_" .. params[paramIndex])
    end
  end
  text = WU.GetString("TaskDesc_" .. m_task.id, m_task.res.maxProgress, TU.GetParamLocalizationText(params, m_task.res.goalType))
  REF.LabelTaskDesc.UIHtmlLabel.text = text
  WU.ToggleRendering(REF.SpriteDoing, m_task.res.gotoId == 0 and not m_task.isDone and not m_task.timeout)
  WU.ToggleRendering(REF.Daily, m_task.dailyRefresh)
  local isVipTask = m_task.actorCultivationVipOnly
  WU.ToggleRendering(REF.TaskVip, isVipTask)
  m_curCulPlan = this:GetData("fci/custom-actor-cultivation/").culPlans[this:GetData("CustomActorCultivation/ActivityIndex")]
  local vip = m_curCulPlan.vip
  WU.ToggleRendering(REF.BtnActivate, not vip and isVipTask)
  WU.ToggleRendering(REF.StateNode, vip or not isVipTask)
  WU.ToggleRendering(REF.BtnGo, m_task.res.gotoId ~= 0 and not m_task.isDone)
  WU.ToggleRendering(REF.SpriteCompleted, m_task.rewardGot)
  if REF.SpriteTimeout then
    WU.ToggleRendering(REF.SpriteTimeout, not m_task.rewardGot and m_task.timeout)
  end
  WU.ToggleRendering(REF.BtnGetReward, m_task.isDone and not m_task.rewardGot and not m_task.timeout)
  REF.RewardProgressPoint.UISprite.spriteName = "ActorCultivation/ActorCultivation_bar_icon_" .. m_task.actorCultivationRewardProgress
end

function SetRewardClick(call)
  m_rewardClickCall = call
end

function OnGetRewardClick()
  if m_rewardClickCall then
    m_rewardClickCall(REF)
  end
end

function OnClickActivate()
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

function OnClickGo()
  local gotoId = m_task.res.gotoId
  if gotoId == 208 then
    GotoUtil.Goto("CollectionsActor", {
      m_curCulPlan.actorId
    })
    return
  end
  if gotoId == 209 then
    local uid = AU.GetHighestLevelActor(m_curCulPlan.actorId)
    if uid then
      GotoUtil.Goto("ActorMain", {uid})
    end
    return
  end
  local g = PB.get("Goto", gotoId)
  if g == nil then
    error("Task", "Goto id " .. gotoId .. " doesn't exist")
    return
  end
  GotoUtil.Goto(g.windowName, g.params)
end
