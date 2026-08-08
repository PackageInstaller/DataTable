local WU, DB, REF = require("Common/WindowUtil")(this)
local m_shareOn = false
local m_effect

function SetupWindow()
  WU.BindButtonEvent(REF.Black, OnClickBack)
end

function InitWindow()
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  m_shareOn = WU.IsShareSwitchOn()
  WU.SetActive(REF.ExtraInfo, false)
end

function OnWindowUninited(window)
  if window.name == "Share" then
    WU.SetActive(REF.ButtonShare, true)
    WU.SetActive(REF.LabelContinue, true)
    WU.SetActive(REF.LabelExtra, true)
  end
end

function SetView(data, hideExtra)
  if not hideExtra then
    WU.RemoveAllChild(REF.ExtraInfo)
    local prefabName = "ExtraInfo_" .. data.atcorID
    local goContent = WU.InstantiateWindowPrefabAttached(REF.ExtraInfo, "ActorCultivationComplete/" .. prefabName, prefabName)
    WU.HandleGameObjectAttached(goContent)
    REF = reRef(REF.root)
    WU.BindButtonEvent(REF.ButtonShare, OnClickShare)
    if data.effectName then
      WU.SetActive(REF.TextureBg, false)
      WU.SetActive(REF.Effect, true)
      ShowEffect(data.effectName)
      this:DelayInvokeInSeconds(0.5, function()
        SetExtra(data, hideExtra)
      end)
    else
      WU.SetActive(REF.TextureBg, true)
      WU.SetActive(REF.Effect, false)
      SetExtra(data, hideExtra)
    end
  else
    WU.SetActive(REF.Effect, false)
    WU.SetActive(REF.TextureBg, true)
    SetExtra(data, hideExtra)
  end
end

function SetExtra(data, hideExtra)
  WU.SetActive(REF.ExtraInfo, not hideExtra)
  if data.time then
    REF.LabelCompleteTime.UIHtmlLabel.text = WU.GetString("ActorCultivation_CompleteTime_" .. data.atcorID, data.time)
    WU.SetActive(REF.LabelCompleteTime, true)
  end
  REF.TextureBg.UITexture.mainTexturePath = data.TextureBg
  WU.SetActive(REF.ButtonShare, m_shareOn)
end

function OnClickBack()
  WU.RecycleWindow("ActorCultivationComplete")
end

function ShowEffect(effectName)
  REF.Effect.EffectGenerator.m_EffectName = effectName
  REF.Effect.EffectGenerator:Reset()
end

function OnClickShare()
  WU.RecordButtonClick(901)
  this:SetData("ShareConfig", {
    shareName = "ActorCultivationComplete",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  WU.SetActive(REF.ButtonShare, false)
  WU.SetActive(REF.LabelContinue, false)
  error("Debug", "Debug LabelContinue")
  WU.SetActive(REF.LabelExtra, false)
  WU.AcquireWindowAsync("Share")
end
