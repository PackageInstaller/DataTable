local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local EU = require("Common/EquipUtil")
local HU = require("Common/HtmlUtil")
local AU = require("Common/ActorUtil")
local LU = require("Common/ListUtil")
local m_actorInfo
local m_canClose = false

function SetupWindow()
  WU.BindButtonEvent(REF.Black, function()
    if not m_canClose then
      return
    end
    WU.RecycleWindow(this)
  end)
end

function InitWindow()
  REF.ConenteBGEffect.gameObject:SetActive(false)
end

function UninitWindow()
  local window = WU.FindWindow("ActorMain")
  if window and m_actorInfo then
    window = _ENV["$"](window)
    window.TextureBG.UITexture.mainTexturePath = "Texture/Background/" .. m_actorInfo.actorBgPath
    _ENV["$"](window.WidgetActorRoller).Effect.EffectGenerator:Play()
  end
end

function SetActor(actor)
  if actor == nil then
    return
  end
  local info = PB.get("ActorUnlockEffect", actor.id)
  if info == nil then
    m_canClose = true
    warning("Debug", "ActorUnlockEffect no actor:" .. actor.id)
    return
  end
  m_actorInfo = info
  REF.TextureRoleEffect.UITexture.mainTexturePath = "Texture/Welfare/" .. info.actorPath
  REF.PanelDetail.gameObject:SetActive(false)
  m_canClose = false
  REF.LabelName.UILabel.text = WU.GetString("UnlockActorBgName_" .. actor.id)
  this:DelayInvokeInSeconds(1.5, function()
    REF.PanelDetail.gameObject:SetActive(true)
  end)
  REF.EffectTitle.EffectGenerator:Play(function()
    REF.ConenteBGEffect.gameObject:SetActive(true)
    REF.ConenteBGEffect.EffectGenerator:Play()
  end)
  this:DelayInvokeInSeconds(2.5, function()
    m_canClose = true
  end)
end
