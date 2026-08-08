local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local TU = require("Common/TaskUtil")
local S = require("Common/Singleton")
local AM = S:Get("ActivityManager")
local DBH = require("Manager/DataBindingHandler")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local m_misc = PB.index("Misc", 1)
local m_TaskCategoryCount = TU.TaskCategoryCount
local m_taskLists, m_mode
local m_init = true
local m_activeLevel, m_skilfulRewardsList
local m_firstJump = true
local m_lastIndex, m_showBuffId, m_numChange, m_oldNum, m_newNum, m_nowNum, m_numChangeAtOnce, m_activityId
local EnumStage = {
  SC_HASGET = 1,
  SC_CANGET = 2,
  SC_CANTGET = 3
}

function SetupWindow()
  if CS.GameGlobal.DoesDeviceHaveNotch() then
    REF.ScrollView.UIPanel.clipSoftness = CS.UnityEngine.Vector2(CS.UIRoot.LeftNotchWidth, 0)
  end
  LU.Bind(REF.WrapContent, {
    updateRow = OnTaskItemShow
  })
  LU.Bind(REF.SkilfulRewardsWrapContent, {
    updateRow = OnSkilfulRewardsShow
  })
end

function InitWindow()
  m_init = true
  m_activeLevel = nil
  m_skilfulRewardsList = nil
  m_numChange = false
  m_numChangeAtOnce = true
  REF.EffectPanel.gameObject:SetActive(false)
  REF.ScrollView.gameObject:SetActive(false)
  REF.SkilfulRewardsScrollView.gameObject:SetActive(false)
  local activities = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.HalfYearBack)
  m_activityId = activities[1].activityId
  this:Bind("fci/half-year-back-activity/", OnActivityInfoChange)
  this:Bind("fci/playerBackTasks", OnTaskChange)
  this:Bind("halfyearbackcando", function(result)
    if not result then
      RU.SetRedMark("Welfare/HalfYearBack/Task/" .. m_mode .. "/Reward", false)
      REF.ScrollView.gameObject:SetActive(false)
      REF.TaskEmpty.gameObject:SetActive(true)
    end
  end)
end

function OnTaskChange(list)
  m_taskLists = list
  m_mode = PB.enum.TaskCategory.PlayerBack
  local canReward = TU.TaskCanReward(list)
  RU.SetRedMark("Welfare/HalfYearBack/Task/" .. m_mode .. "/Reward", canReward)
  SetListView()
end

function SetListView()
  if m_mode == nil then
    return
  end
  REF.ScrollView.gameObject:SetActive(true)
  local list = m_taskLists
  if list == nil then
    list = {}
  end
  LU.Set(REF.WrapContent, #list)
  REF.TaskEmpty.gameObject:SetActive(#list == 0)
end

function OnTaskItemShow(goRef, wrapIndex, realIndex)
  local taskList = m_taskLists
  if taskList and realIndex < #taskList then
    local taskInfo = taskList[realIndex + 1]
    goRef["$$SetView"](taskInfo)
    goRef.LabelActivePointHalfYear.UIHtmlLabel.text = taskInfo.res.halfYearBackPoint
    goRef.Test.gameObject:SetActive(false)
    goRef["$$SetRewardClick"](onTaskRewardClick)
  end
end

function OnSkilfulRewardsShow(goRef, wrapIndex, realIndex)
  if m_skilfulRewardsList and realIndex < #m_skilfulRewardsList then
    local rewardInfo = m_skilfulRewardsList[realIndex + 1].reward
    local rewardStage = m_skilfulRewardsList[realIndex + 1].stage
    local progressLabel = m_skilfulRewardsList[realIndex + 1].progress
    local isBuff = m_skilfulRewardsList[realIndex + 1].isBuff
    goRef.IconHasClaimed.gameObject:SetActive(rewardStage == EnumStage.SC_HASGET)
    goRef.GLOW.gameObject:SetActive(rewardStage == EnumStage.SC_CANGET)
    goRef.SpriteProgress.gameObject:SetActive(true)
    goRef.LabelProgress.UILabel.text = progressLabel
    if isBuff == 1 then
      goRef["$$SetData"](rewardInfo[1].type, rewardInfo[1].id)
    else
      goRef["$$SetData"](rewardInfo[1].type, rewardInfo[1].id, rewardInfo[1].count)
    end
    goRef["$$SetClickCallback"](function()
      if rewardStage == EnumStage.SC_HASGET or rewardStage == EnumStage.SC_CANTGET then
        WU.ShowResourceDetail(rewardInfo[1].type, rewardInfo[1].id)
      else
        this:GameRequest("fci/half-year-back-activity/progress"):Post({}, function(response)
          DBH.ResChange(response.resChange)
          local activityInfo = this:GetData("fci/half-year-back-activity/")
          activityInfo.completProgress = response.completProgress
          activityInfo.reciveProgress = response.reciveProgress
          local profitIdOld = activityInfo.profitId
          WU.ShowRewards(response.resChange, function()
            if profitIdOld ~= response.profitId then
              m_showBuffId = response.profitId
              this:DelayInvokeInSeconds(0.5, function()
                REF.EffectPanel.gameObject:SetActive(true)
                playBuffEffect()
              end)
            end
          end)
          activityInfo.profitId = response.profitId
          this:SetData("fci/half-year-back-activity/", activityInfo)
        end)
      end
    end)
  end
end

function OnActivityInfoChange(activityInfo)
  if activityInfo == nil then
    return
  end
  m_activeLevel = activityInfo.activeLevel
  m_skilfulRewardsList = PB.all("PlayerBackProcess"):where(function(k, v)
    return v.activityId == m_activityId and v.levelMax >= m_activeLevel and v.levelMin <= m_activeLevel
  end):toarray()
  if table.empty(m_skilfulRewardsList) then
    error(string.format("PlayerBackProcess.xlsx has no id = %s and level %s", m_activityId, m_activeLevel))
    return
  end
  table.sort(m_skilfulRewardsList, function(a, b)
    return a.progress < b.progress
  end)
  if m_numChangeAtOnce then
    REF.LabelPointCount.UILabel.text = activityInfo.completProgress
  end
  m_numChangeAtOnce = true
  SetAllBuff(activityInfo.profitId)
  SetSkilfulRewardsStage(activityInfo)
  REF.SkilfulRewardsScrollView.gameObject:SetActive(true)
  LU.Set(REF.SkilfulRewardsWrapContent, #m_skilfulRewardsList)
  for i = 1, #m_skilfulRewardsList do
    if m_skilfulRewardsList[i].stage == EnumStage.SC_CANTGET or m_skilfulRewardsList[i].stage == EnumStage.SC_CANGET then
      m_lastIndex = i
      break
    end
  end
  if m_lastIndex == nil then
    m_lastIndex = #m_skilfulRewardsList
  end
  if m_init then
    local jumpIndex
    if 8 < m_lastIndex and m_lastIndex <= #m_skilfulRewardsList then
      jumpIndex = m_lastIndex - 4
    else
      jumpIndex = 0
    end
    if m_firstJump then
      m_firstJump = false
      this:DelayInvokeInSeconds(0.1, function()
        JumpIndex(jumpIndex)
      end)
    else
      JumpIndex(jumpIndex)
    end
  end
end

function SetSkilfulRewardsStage(activityInfo)
  for i = 1, #m_skilfulRewardsList do
    if m_skilfulRewardsList[i].progress <= activityInfo.reciveProgress then
      m_skilfulRewardsList[i].stage = EnumStage.SC_HASGET
    elseif m_skilfulRewardsList[i].progress > activityInfo.reciveProgress and m_skilfulRewardsList[i].progress <= activityInfo.completProgress then
      m_skilfulRewardsList[i].stage = EnumStage.SC_CANGET
    else
      m_skilfulRewardsList[i].stage = EnumStage.SC_CANTGET
    end
  end
end

function onTaskRewardClick(go)
  local ref = _ENV["$"](go)
  local taskInfo = ref["@taskInfo"]
  this:GameRequest("fci/task/" .. taskInfo.id .. "/half-year-back-activity/"):Post({}, function(result)
    if result then
      DBH.ResChange(result.resChange)
      WU.ShowRewards(result.resChange, function()
        m_numChange = true
      end)
      local index, task = _ENV["!"](m_taskLists):find(function(k, v)
        return v.id == taskInfo.id
      end)
      if task ~= nil then
        task.rewardGot = true
        table.sort(m_taskLists, TU.Sort)
        this:SetData("fci/playerBackTasks", m_taskLists)
      end
      local activityInfo = this:GetData("fci/half-year-back-activity/")
      m_oldNum = activityInfo.completProgress
      m_newNum = result.completProgress
      m_nowNum = m_oldNum
      activityInfo.completProgress = result.completProgress
      activityInfo.reciveProgress = result.reciveProgress
      m_numChangeAtOnce = false
      this:SetData("fci/half-year-back-activity/", activityInfo)
    end
  end)
end

function SetAllBuff(id)
  if id == nil then
    error("has no this profitid " .. id)
    return
  end
  local goRef = _ENV["$"](REF.WidgetIconSlotHalfYearTaskShow)
  goRef.IconHasClaimed.gameObject:SetActive(false)
  goRef.SpriteProgress.gameObject:SetActive(false)
  goRef.GLOW.gameObject:SetActive(false)
  if id == 0 then
    local rewardInfo = m_skilfulRewardsList[1].reward
    goRef["$$SetData"](rewardInfo[1].type, rewardInfo[1].id)
    goRef["$$SetClickCallback"](function()
      WU.ShowResourceDetail(rewardInfo[1].type, rewardInfo[1].id)
    end)
    return
  end
  for i = 1, #m_skilfulRewardsList do
    local rewardInfo = m_skilfulRewardsList[i].reward
    if WU.GetBuffNumByItemid(rewardInfo[1].id) == GetBuffNumById(id) then
      goRef["$$SetData"](rewardInfo[1].type, rewardInfo[1].id)
      goRef["$$SetClickCallback"](function()
        WU.ShowResourceDetail(rewardInfo[1].type, rewardInfo[1].id)
      end)
      return
    end
  end
end

function GetBuffNumById(id)
  if id then
    local buffNum = PB.get("ProfitDetail", id)
    if buffNum then
      return buffNum.add
    else
      error("has no this profitid " .. id)
      return
    end
  end
end

function GetItemidByBuffid(id)
  if id then
    local list = PB.all("ItemInfo"):where(function(k, v)
      return v.quality == 99
    end):toarray()
    for i = 1, #list do
      local param = list[i].param
      if id == param[1] then
        return list[i].id
      end
    end
  end
  error("iteminfo has no item that buffid = " .. id)
  return
end

function JumpIndex(index)
  local scrollView = REF.SkilfulRewardsScrollView.UIScrollView
  local v3 = CS.UnityEngine.Vector3(-REF.SkilfulRewardsWrapContent.UIWrapContent.itemSize * index, 0, 0)
  scrollView:ResetPosition()
  scrollView:MoveRelative(v3)
  scrollView:RestrictWithinBounds(true)
end

function UninitWindow()
  m_init = false
end

function UpdateWindow()
  if m_numChange then
    local inNum = math.ceil((m_newNum - m_oldNum) / 15)
    m_nowNum = m_nowNum + inNum
    if m_nowNum < m_newNum then
      REF.LabelPointCount.UILabel.text = m_nowNum
    else
      REF.LabelPointCount.UILabel.text = m_newNum
      m_numChange = false
    end
  end
end

function playBuffEffect()
  this:DelayInvokeInSeconds(0.5, function()
    local itemId = GetItemidByBuffid(m_showBuffId)
    local tex = WU.AcquireAsset("Texture/ItemIcon/ResItem_" .. itemId)
    REF.ICON.MeshRenderer.material:SetTexture("_MainTex", tex)
    local effect = REF.EffectProfit
    effect.EffectGenerator:Play(function()
      playFlyEffect()
    end)
  end)
end

function playFlyEffect()
  local effect = REF.StarEffect
  effect.transform.localPosition = CS.UnityEngine.Vector3.zero
  local tween = effect.TweenPosition
  tween.from = effect.transform.localPosition
  tween.to = REF.NodeShowBuff.transform.localPosition + REF.WidgetIconSlotHalfYearTaskShow.transform.localPosition
  tween:ResetToBeginning()
  tween:PlayForward()
  effect.EffectGenerator:Play()
end
