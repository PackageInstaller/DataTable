local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_info

function SetupWindow()
  WU.BindButtonEvent(REF.BtnShare, OnShareClick)
  WU.BindButtonEvent(REF.BtnContinue, OnContinueClick)
end

function InitWindow()
  WU.SetActive(REF.SharePanel, false)
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  m_info = this:GetData("AsyncPvpNew/BaseInfo")
  InitResultView()
end

function UninitWindow()
  this:UnregisterGameEvent("UI/WindowUninited", OnWindowUninited)
end

function OnWindowUninited(window)
  if window.name == "Share" then
    BuildShareUI(false)
  end
end

function InitResultView()
  WU.ToggleRendering(REF.Bottom, false)
  local ref = _ENV["$"](REF.Bottom)
  local segInfo = PB.get("AsyncPvpRankReward", m_info.curSeg)
  m_info.segInfo = segInfo
  ref.SpriteRankName.UISprite.spriteName = "illusion_level_" .. segInfo.segRank
  ref.SpriteSubRankName.UISprite.spriteName = "level_" .. segInfo.subSegRank
  local isUp = m_info.oldSeg < m_info.curSeg
  WU.SetActive(REF.EffectContentUp, isUp)
  WU.SetActive(REF.EffectContentNormal, not isUp)
  local effectGo = fif(isUp, REF.EffectContentUp, REF.EffectContentNormal)
  local segTex = WU.AcquireAsset("Texture/IllusionLand/IllusionLand_icon_" .. segInfo.segRank)
  _ENV["$"](effectGo).Icon.MeshRenderer.material:SetTexture("_MainTex", segTex)
  effectGo.EffectGenerator:Play()
  WU.ToggleRendering(REF.Bottom, true)
end

function OnShareClick()
  BuildShareUI(true)
  this:SetData("ShareConfig", {
    shareName = "AsyncPvpNewSegResult",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  WU.AcquireWindowAsync("Share")
end

function BuildShareUI(flag)
  if flag then
    local ref = _ENV["$"](REF.SharePanel)
    local segInfo = m_info.segInfo
    ref.SpriteRankName.UISprite.spriteName = "illusion_level_" .. segInfo.segRank
    ref.SpriteSubRankName.UISprite.spriteName = "level_" .. segInfo.subSegRank
    ref.SpriteMyRank.UISprite.spriteName = "icon_" .. segInfo.segRank
  end
  WU.SetActive(REF.SharePanel, flag)
end

function OnContinueClick()
  WU.RecycleWindow("AsyncPvpNewSegResult")
end
