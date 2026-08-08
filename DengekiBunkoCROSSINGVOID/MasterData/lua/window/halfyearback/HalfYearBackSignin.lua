local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local ACU = require("Common/ActivityUtil")
local DBH = require("Manager/DataBindingHandler")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local m_normalRewardList, m_specialReward, m_allRewardsList, m_lockSignAward
local m_firstJump = true
local m_init, m_selectIndex, m_activityId

function SetupWindow()
  if CS.GameGlobal.DoesDeviceHaveNotch() then
    REF.ScrollView.UIPanel.clipSoftness = CS.UnityEngine.Vector2(CS.UIRoot.LeftNotchWidth, 0)
  end
  WU.BindButtonEvent(REF.ButtonNoSelect, OnClickNoSelect)
  LU.Bind(REF.WrapContent, {
    updateRow = OnSigninItemShow
  })
end

function InitWindow()
  m_init = true
  local activities = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.HalfYearBack)
  m_activityId = activities[1].activityId
  SetupRewardList()
  REF.SpecialSigninList.gameObject:SetActive(false)
  REF.ScrollView.gameObject:SetActive(false)
  if not table.empty(m_normalRewardList) and not table.empty(m_specialReward) then
    this:Bind("fci/half-year-back-activity/", OnActivityInfoChange)
  else
    error("ActivitySigninGift.xlsx is wrong!")
  end
end

function OnSigninItemShow(goRef, wrapIndex, realIndex)
  local rewardInfo = m_allRewardsList[realIndex + 1]
  goRef["$$SetView"](rewardInfo)
end

function SetSigninSelect(resourceRef, resourceType, resourceId, resourceCount)
  local hasResource = resourceType ~= nil
  if hasResource then
    resourceRef.gameObject:SetActive(true)
    REF.ButtonNoSelect.gameObject:SetActive(false)
    resourceRef["$SetData"](resourceType, resourceId, resourceCount)
    resourceRef["$ShowCustom"]({name = false})
  else
    resourceRef.gameObject:SetActive(false)
    REF.ButtonNoSelect.gameObject:SetActive(true)
  end
  resourceRef["$SetClickCallback"](function()
    if m_lockSignAward then
      WU.ShowResourceDetail(resourceType, resourceId, false)
    else
      WU.AcquireWindowAsync("SigninSelect", function(window)
        _ENV["$"](window)["$$SetView"](m_specialReward, m_selectIndex)
      end)
    end
  end)
end

function OnClickNoSelect()
  WU.AcquireWindowAsync("SigninSelect", function(window)
    _ENV["$"](window)["$$SetView"](m_specialReward, m_selectIndex)
  end)
end

function OnActivityInfoChange(activityInfo)
  if activityInfo == nil then
    return
  end
  m_lockSignAward = activityInfo.lockSignAward
  if m_lockSignAward then
    REF.ButtonNoSelect.gameObject:SetActive(false)
  else
    REF.ButtonNoSelect.gameObject:SetActive(true)
  end
  SetRewardsState(activityInfo)
  local index = activityInfo.signAwardId
  m_selectIndex = index
  local count, resourceType, resourceId, resourceCount
  if index == 0 then
    SetSigninSelect(REF.WidgetIconSlotSelect, nil, nil, nil)
  else
    resourceType = m_specialReward[1].reward[index].type
    resourceId = m_specialReward[1].reward[index].id
    resourceCount = m_specialReward[1].reward[index].count * #m_specialReward
    count = m_specialReward[1].reward[index].count
    SetSigninSelect(REF.WidgetIconSlotSelect, resourceType, resourceId, resourceCount)
  end
  ShowRewardsGrid(index, count, resourceType, resourceId)
  REF.SpecialSigninList.gameObject:SetActive(true)
  REF.ScrollView.gameObject:SetActive(true)
  LU.Set(REF.WrapContent, #m_normalRewardList)
  if m_init then
    local jumpIndex
    if activityInfo.signStep > #m_normalRewardList then
      jumpIndex = #m_normalRewardList - 3
    elseif activityInfo.signStep > 3 and activityInfo.signStep <= #m_normalRewardList then
      jumpIndex = activityInfo.signStep - 3
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

function ShowRewardsGrid(index, count, type, id)
  REF.NodeProgressBar.UIProgressBar.value = 0
  if index == 0 then
    for i = 0, #REF.RewardsGrid - 1 do
      local ref = REF.RewardsGrid[i].root
      _ENV["$"](ref).SpriteReward.gameObject:SetActive(false)
      _ENV["$"](ref).LabelCount.gameObject:SetActive(false)
      _ENV["$"](ref).SpriteNull.gameObject:SetActive(true)
      _ENV["$"](ref).LabelSpecialDay.UIHtmlLabel.text = WU.GetString("WindowTenCheckin_WhichDay", m_allRewardsList[i + 1 + #m_normalRewardList].days)
    end
    return
  else
    for i = 0, #REF.RewardsGrid - 1 do
      local ref = REF.RewardsGrid[i].root
      _ENV["$"](ref).SpriteReward.UITexture.mainTexturePath = "Texture/ItemIcon/" .. PB.enum.ResourceType[type] .. "_" .. tostring(id)
      _ENV["$"](ref).LabelCount.UILabel.text = tostring(count)
      _ENV["$"](ref).SpriteReward.gameObject:SetActive(true)
      _ENV["$"](ref).SpriteNull.gameObject:SetActive(false)
      _ENV["$"](ref).LabelCount.gameObject:SetActive(true)
    end
  end
  for i = 0, #REF.RewardsGrid - 1 do
    local ref = REF.RewardsGrid[i].root
    local barPerValue = 1 / (#REF.RewardsGrid - 1)
    _ENV["$"](ref).LabelSpecialDay.UIHtmlLabel.text = WU.GetString("WindowTenCheckin_WhichDay", m_allRewardsList[i + 1 + #m_normalRewardList].days)
    if m_allRewardsList[i + 1 + #m_normalRewardList].hasGet and i == 0 then
      REF.NodeProgressBar.UIProgressBar.value = 0.02
      _ENV["$"](ref).SpriteReward.UITexture.graify = true
    elseif m_allRewardsList[i + 1 + #m_normalRewardList].hasGet then
      REF.NodeProgressBar.UIProgressBar.value = i * barPerValue
      _ENV["$"](ref).SpriteReward.UITexture.graify = true
    else
      _ENV["$"](ref).SpriteReward.UITexture.graify = false
    end
    if m_allRewardsList[i + 1 + #m_normalRewardList].canGet then
      _ENV["$"](ref).SpriteReward.TweenScale.enabled = true
    else
      _ENV["$"](ref).SpriteReward.TweenScale.enabled = false
    end
    WU.ClearButtonEvent(_ENV["$"](ref).ButtonClick)
    WU.BindButtonEvent(_ENV["$"](ref).ButtonClick, function()
      if m_allRewardsList[i + 1 + #m_normalRewardList].hasGet then
        WU.ShowResourceDetail(type, id)
      elseif m_allRewardsList[i + 1 + #m_normalRewardList].canGet then
        this:GameRequest("fci/half-year-back-activity/sign/"):Post({}, function(response)
          DBH.ResChange(response.resChange)
          WU.ShowRewards(response.resChange)
          local activityInfo = this:GetData("fci/half-year-back-activity/")
          activityInfo.signStep = response.signStep
          activityInfo.lastSignTime = response.lastSignTime
          activityInfo.signAwardId = response.signAwardId
          activityInfo.lockSignAward = response.lockSignAward
          this:SetData("fci/half-year-back-activity/", activityInfo)
        end)
      else
        WU.ShowResourceDetail(type, id)
      end
    end)
  end
end

function SetupRewardList()
  m_normalRewardList = PB.all("ActivitySigninGift"):where(function(k, v)
    return v.activityId == m_activityId and v.isSpecialDay ~= 1
  end):toarray()
  table.sort(m_normalRewardList, function(a, b)
    return a.days < b.days
  end)
  m_specialReward = PB.all("ActivitySigninGift"):where(function(k, v)
    return v.activityId == m_activityId and v.isSpecialDay == 1
  end):toarray()
  table.sort(m_specialReward, function(a, b)
    return a.days < b.days
  end)
  m_allRewardsList = PB.all("ActivitySigninGift"):where(function(k, v)
    return v.activityId == m_activityId
  end):toarray()
  table.sort(m_allRewardsList, function(a, b)
    return a.days < b.days
  end)
end

function SetRewardsState(activityInfo)
  if activityInfo.signStep then
    for i = 1, #m_allRewardsList do
      if m_allRewardsList[i].days <= activityInfo.signStep then
        m_allRewardsList[i].hasGet = 1
        m_allRewardsList[i].canGet = nil
        m_allRewardsList[i].cantGet = nil
      elseif m_allRewardsList[i].days - activityInfo.signStep == 1 then
        if not CS.GameTime.IsSameDate(activityInfo.lastSignTime, CS.GameTime.serverUtc) then
          m_allRewardsList[i].hasGet = nil
          m_allRewardsList[i].canGet = 1
          m_allRewardsList[i].cantGet = nil
        else
          m_allRewardsList[i].hasGet = nil
          m_allRewardsList[i].canGet = nil
          m_allRewardsList[i].cantGet = 1
        end
      else
        m_allRewardsList[i].hasGet = nil
        m_allRewardsList[i].canGet = nil
        m_allRewardsList[i].cantGet = 1
      end
    end
  end
end

function JumpIndex(index)
  local scrollView = REF.ScrollView.UIScrollView
  local v3 = CS.UnityEngine.Vector3(-REF.WrapContent.UIWrapContent.itemSize * index, 0, 0)
  scrollView:ResetPosition()
  scrollView:MoveRelative(v3)
  scrollView:RestrictWithinBounds(true)
end

function UninitWindow()
  m_init = false
end
