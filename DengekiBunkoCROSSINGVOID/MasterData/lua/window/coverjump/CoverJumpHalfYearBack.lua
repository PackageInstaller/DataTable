local WU, DB, REF = require("Common/WindowUtil")(this)
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local m_misc = PB.index("Misc", 1)
local m_startFly
local m_target = "Welfare"
local m_window, m_rewardsList, m_activeLevel

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonGetRewards, function()
    this:GameRequest("fci/half-year-back-activity/sign/"):Post({}, function(response)
      DBH.ResChange(response.resChange)
      WU.ShowRewards(response.resChange)
      local activityInfo = this:GetData("fci/half-year-back-activity/")
      activityInfo.signStep = response.signStep
      activityInfo.lastSignTime = response.lastSignTime
      activityInfo.signAwardId = response.signAwardId
      SetGrid(true)
      this:SetData("fci/half-year-back-activity/", activityInfo)
    end)
  end)
  WU.BindButtonEvent(REF.ButtonFinish, function()
    REF["$Animator"]:Play("Close")
    REF.RewardsGrid.gameObject:SetActive(false)
    REF.LabelLeftDays.gameObject:SetActive(false)
    REF.LabelCoverJump.gameObject:SetActive(false)
    REF.ButtonFinish.gameObject:SetActive(false)
    REF.BGTop.gameObject:SetActive(false)
    this:DelayInvokeInSeconds(0.16, function()
      REF.Black.gameObject:SetActive(false)
      m_startFly = true
      this:DelayInvokeInSeconds(0.2, function()
        local pos = REF.root.transform:InverseTransformPoint(_ENV["$"](m_window)[m_target].gameObject.transform.position)
        U.Translate(REF.Effect.transform, pos.x, pos.y, 0)
        REF.Effect.EffectGenerator:Play()
        REF.ButtonFinish.gameObject:SetActive(false)
        this:DelayInvokeInSeconds(0.8, function()
          WU.RecycleWindow(this)
        end)
      end)
    end)
  end)
end

function InitWindow()
  m_startFly = false
  m_window = WU.FindWindow("City")
  REF["$Animator"]:Play("Open")
  SetGrid(false)
  this:GameRequest("fci/half-year-back-activity/progress"):Post({}, function(response)
    if response then
      local activityInfo = this:GetData("fci/half-year-back-activity/")
      activityInfo.completProgress = response.completProgress
      activityInfo.reciveProgress = response.reciveProgress
      activityInfo.profitId = response.profitId
      this:SetData("fci/half-year-back-activity/", activityInfo)
    end
  end)
end

function UpdateWindow()
  if m_startFly == true and m_window ~= nil then
    local pos = REF.root.transform:InverseTransformPoint(_ENV["$"](m_window).Welfare.gameObject.transform.position)
    U.Translate(REF.StarADD.transform, pos.x / 6, pos.y / 6, 0)
  end
end

function SetGrid(hasGet)
  m_activityManager.GetActivityByType(PB.enum.ActivityType.HalfYearBack, function(acList)
    local activityId = acList[1].activityId
    local signinRewardsList = {}
    local buffRewardsList = {}
    local allList = {}
    signinRewardsList = PB.all("ActivitySigninGift"):where(function(k, v)
      return v.activityId == activityId and v.days == 1
    end):toarray()
    if table.empty(signinRewardsList) then
      error(string.format("ActivitySigninGift.xlsx has no id = %s and days = 1", activityId))
      return
    end
    allList = signinRewardsList[1].reward
    for i = 0, #REF.RewardsGrid - 1 do
      WU.SetActive(REF.RewardsGrid[i].root, false)
    end
    for i = 1, #allList do
      local goRef = REF.RewardsGrid[i - 1]
      WU.SetActive(goRef.root, true)
      SetIconView(goRef, allList[i], hasGet)
    end
    REF.LabelLeftDays.UIHtmlLabel.text = WU.GetString("Welfare_LeftActivityDays", m_misc.halfYearBackDuration)
  end)
end

function SetIconView(goRef, list, hasGet)
  goRef.IconHasClaimed.gameObject:SetActive(hasGet)
  goRef.GLOW.gameObject:SetActive(not hasGet)
  goRef.GLOW.transform.localPosition = CS.UnityEngine.Vector3(-2, 6, 0)
  goRef.GLOW.UISprite.color = CS.NGUIMath.HexToColor(4293919487)
  goRef.SpriteProgress.gameObject:SetActive(false)
  if list.isBuff == 1 then
    goRef["$$SetData"](list.type, list.id)
  else
    goRef["$$SetData"](list.type, list.id, list.count)
  end
end
