local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_shareOn = false

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonShare, OnClickShare)
  WU.BindButtonEvent(REF.Black, OnClickBack)
end

function InitWindow()
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  m_shareOn = WU.IsShareSwitchOn()
end

function OnWindowUninited(window)
  if window.name == "Share" then
    WU.SetActive(REF.ButtonShare, true)
    WU.SetActive(REF.LabelContinue, true)
    WU.SetActive(REF.LabelExtra, true)
  end
end

function OnClickShare()
  WU.RecordButtonClick(901)
  this:SetData("ShareConfig", {
    shareName = "CustomActorCultivationComplete",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  WU.SetActive(REF.ButtonShare, false)
  WU.SetActive(REF.LabelContinue, false)
  WU.SetActive(REF.LabelExtra, false)
  WU.AcquireWindowAsync("Share")
end

function SetView(activityId, actorId, timeSpan, showExtra)
  WU.SetActive(REF.NodeExtraInfo, showExtra)
  WU.SetActive(REF.TextureActivityTitle, showExtra)
  WU.SetActive(REF.TextureActivityTitle2, not showExtra)
  local xlsxConfigActivity = PB.get("ActivityCustomActorCultivation", PB.enum.ActivityType.CustomActorCultivation, activityId)
  local xlsxConfigActor = PB.get("ActorConfig", actorId)
  REF.TextureBG.UITexture.mainTexturePath = xlsxConfigActivity.bigCgRes
  REF.EffectBG.EffectGenerator.m_EffectName = xlsxConfigActivity.effectRes
  REF.EffectBG.EffectGenerator:Reset()
  REF.TextureActivityTitle.UITexture.mainTexturePath = xlsxConfigActivity.titleRes
  REF.TextureActivityTitle2.UITexture.mainTexturePath = xlsxConfigActivity.titleRes
  REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. xlsxConfigActor.animRes
  WU.ModifyPortrait(REF.TextureActor, actorId, 8)
  WU.SetActive(REF.LabelCompleteTime, timeSpan)
  if timeSpan then
    REF.LabelCompleteTime.UIHtmlLabel.text = WU.GetString("ActorCultivation_CompleteTime", timeSpan.Days)
  end
  REF.SpriteActorName.UISprite.spriteName = "actor_name_" .. xlsxConfigActor.animRes
  REF.SpriteActorName.UISprite:MakePixelPerfect()
  REF.SpriteActorEmblem.UISprite.spriteName = "actor_type_" .. actorId
end

function OnClickBack()
  WU.RecycleWindow(this)
end
