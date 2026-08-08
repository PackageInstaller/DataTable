local WU, DB, REF = require("Common/WindowUtil")(this)
local m_response
local m_is_main_loaded = false
local m_renderImageUrl

function SetupWindow()
  WU.BindButtonEvent(REF.BtnYes, OnUIYes)
  WU.BindButtonEvent(REF.BtnNo, OnUINo)
  this:RegisterGameEvent("OnWWWTextureSuccess", OnTextureLoad)
  this:RegisterGameEvent("OnWWWTextureFailure", OnTextureFailure)
  ShowLoadingProgress()
end

function RenderImage(imageUrl)
  m_is_main_loaded = false
  m_renderImageUrl = imageUrl
  DB:SetWWWTexture(imageUrl)
end

function SetNoticeData(resp)
  m_response = resp
  RenderImage(resp.preview_url)
end

function OnClick(message)
  REF.Black.gameObject:SetActive(false)
  REF.Black.gameObject:SetActive(true)
  WU.RecycleWindow(this)
  if REF.PreviewImage.UITexture.mainTexture and m_is_main_loaded then
    CS.UnityEngine.GameObject.DestroyImmediate(REF.PreviewImage.UITexture.mainTexture)
  end
  this:BroadcastGameEvent("PatchNotice/OnClose")
end

function ShowLoadingProgress()
  local sign = REF.Sign2
  sign.UISpriteAnimation.enabled = true
  local tween = sign.TweenAlpha
  tween.duration = 1 - sign.UISprite.alpha
  tween.from = sign.UISprite.alpha
  tween.to = 1
  WU.RestartTween(tween)
end

function OnTextureLoad(url, tex2d)
  if m_renderImageUrl and url == m_renderImageUrl then
    REF.Sign2.gameObject:SetActive(false)
    REF.PreviewImage.UITexture.mainTexture = tex2d
    m_is_main_loaded = true
  end
end

function OnTextureFailure(url)
  warning("Patch", "PatchNotice failed while fetching url:" .. url)
end

function OnUIYes()
  if m_response and m_response.app_url then
    WU.OpenUrlExternal(m_response.app_url)
  end
  OnClick("YES")
end

function OnUINo()
  OnClick("NO")
end
