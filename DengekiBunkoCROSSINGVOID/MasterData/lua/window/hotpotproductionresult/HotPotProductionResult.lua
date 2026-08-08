local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local ACU = require("Common/ActivityUtil")
local m_cuisine

function SetupWindow()
  WU.BindButtonEvent(REF.BtnContinue, OnBtnContinueClick)
end

function InitWindow()
  WU.SetLockFlag(WU.LockInputFlag.UITransition, true)
  WU.SetActive(REF.TweenContent, false)
  WU.SetActive(REF.BtnContinue, false)
  m_cuisine = this:GetData("HotPot/ProductionResult")
  UpdateView()
end

function UpdateView()
  REF.Rewards[0]["$$SetItem"]({
    id = m_cuisine.item.id,
    type = m_cuisine.item.type,
    count = m_cuisine.count
  })
  local enterSoundTime = CS.SoundManager.Instance:GetEmoteVolume("Sound/system/s_System_Whisk01") / 1.5
  local leaveSoundTime = CS.SoundManager.Instance:GetEmoteVolume("Sound/system/s_System_Whisk03") / 1.5
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Whisk01")
  WU.SetActive(REF.TextureTool, false)
  WU.SetActive(REF.EffectTool, true)
  WU.SetActive(REF.LabelState, true)
  REF.EffectTool.EffectGenerator:Play()
  this:DelayInvokeInSeconds(enterSoundTime - 0.1, function()
    CS.SoundManager.Instance:PlayStateSound(1, "Sound/system/s_System_Whisk02")
  end)
  this:DelayInvokeInSeconds(1, function()
    WU.SetActive(REF.EffectTool, false)
    WU.SetActive(REF.TextureTool, true)
    WU.SetActive(REF.LabelState, false)
  end)
  this:DelayInvokeInSeconds(1.5, function()
    CS.SoundManager.Instance:StopStateSound(1)
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Whisk03")
  end)
  this:DelayInvokeInSeconds(1.6, function()
    WU.SetActive(REF.Rewards, false)
    WU.SetActive(REF.TweenContent, true)
    REF.TweenContent.UIPlayTween:Play(true)
  end)
  this:DelayInvokeInSeconds(2, function()
    WU.SetActive(REF.Rewards, true)
    REF.Rewards.UIPlayTween:Play(true)
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_GachaRrsult")
    WU.SetActive(REF.BtnContinue, true)
    WU.SetLockFlag(WU.LockInputFlag.UITransition, false)
  end)
end

function OnBtnContinueClick()
  WU.RecycleWindow("HotPotProductionResult")
  WU.RecycleWindow("HotPotCuisineDetail")
end
