local WU, DB, REF = require("Common/WindowUtil")(this)
local AU = require("Common/ActorUtil")
local U = require("Common/Util")
local m_startFly
local m_target = "Welfare"
local m_window, m_shareWindow, m_activityId, m_relateActivityId, m_name

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonFinish, function()
    REF["$Animator"]:Play("Close")
    this:DelayInvokeInSeconds(0.16, function()
      REF.Black.gameObject:SetActive(false)
      m_startFly = true
      this:DelayInvokeInSeconds(0.2, function()
        local pos = REF.root.transform:InverseTransformPoint(_ENV["$"](m_window)[m_target].gameObject.transform.position)
        if m_name == "CoverJumpAsyncPvpNew" then
          pos = pos + CS.UnityEngine.Vector3(-20, 5, 0)
        end
        if REF.Effect then
          U.Translate(REF.Effect.transform, pos.x, pos.y, 0)
          REF.Effect.EffectGenerator:Play()
        end
        REF.ButtonFinish.gameObject:SetActive(false)
        this:DelayInvokeInSeconds(0.8, function()
          WU.RecycleWindow(this)
        end)
      end)
    end)
  end)
  if REF.ButtonShare then
    WU.BindButtonEvent(REF.ButtonShare, OnClickButtonShare)
  end
end

function InitWindow()
  m_startFly = false
  m_window = WU.FindWindow("City")
  REF["$Animator"]:Play("Open")
  m_name = this.name
  if this.name == "CoverJumpAsyncPvpNew" then
    m_target = "ButtonChallenge"
  elseif this.name == "CoverJumpNewbieGift" then
    m_target = "SpriteNewbie"
  end
end

function SetData(data)
  m_activityId = data.activityId
  m_relateActivityId = data.relateActivityId
  m_shareWindow = data.shareWindow
end

function UpdateWindow()
  if m_startFly == true then
    local pos = REF.root.transform:InverseTransformPoint(_ENV["$"](m_window)[m_target].gameObject.transform.position)
    U.Translate(REF.StarADD.transform, pos.x / 6, pos.y / 6, 0)
  end
end

function OnClickButtonShare()
  WU.RecordButtonClick(901)
  if m_shareWindow then
    error("CoverJumpMaidCafe")
    this:SetData("ShareConfig", {
      shareName = m_shareWindow,
      fromWindow = WU.TopWindow() and WU.TopWindow().name
    })
    WU.AcquireWindowAsync("Share")
  end
end
