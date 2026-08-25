local UIScrollEdgeFade = {}
local GameObject = CS.UnityEngine.GameObject
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local Rect = CS.UnityEngine.Rect
local Color = CS.UnityEngine.Color
local Texture2D = CS.UnityEngine.Texture2D
local TextureFormat = CS.UnityEngine.TextureFormat
local Sprite = CS.UnityEngine.Sprite
local SpriteMeshType = CS.UnityEngine.SpriteMeshType
local Mathf = CS.UnityEngine.Mathf
local RenderTexture = CS.UnityEngine.RenderTexture
local Graphics = CS.UnityEngine.Graphics
local Material = CS.UnityEngine.Material
local RenderTextureFormat = CS.UnityEngine.RenderTextureFormat
local RenderTextureReadWrite = CS.UnityEngine.RenderTextureReadWrite
local T_Image = typeof(CS.UnityEngine.UI.Image)
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local T_RectTransform = typeof(CS.UnityEngine.RectTransform)
local GRAD_HEIGHT = 32
local GRAD_WIDTH = 64
local DEFAULT_FADE_H = 15
local DEFAULT_R = 0.145
local DEFAULT_G = 0.165
local DEFAULT_B = 0.212
local VEC2_ZERO = Vector2(0, 0)
local VEC2_HALF = Vector2(0.5, 0.5)
local VEC3_ONE = Vector3(1, 1, 1)
local _topSprite, _bottomSprite, _leftSprite, _rightSprite
local _gradSpriteCache = {}

local function EnsureSprites()
  if _topSprite and not IsNil(_topSprite) and _bottomSprite and not IsNil(_bottomSprite) then
    return
  end
  local topTex = Texture2D(1, GRAD_HEIGHT, TextureFormat.RGBA32, false)
  topTex.name = "UIScrollEdgeFade_GradientTex_Top"
  for i = 0, GRAD_HEIGHT - 1 do
    local t = i / (GRAD_HEIGHT - 1)
    local alpha = math.sqrt(t)
    topTex:SetPixel(0, i, Color(1, 1, 1, alpha))
  end
  topTex:Apply()
  local texRect = Rect(0, 0, 1, GRAD_HEIGHT)
  _topSprite = Sprite.Create(topTex, texRect, VEC2_HALF, 100, 0, SpriteMeshType.FullRect)
  _topSprite.name = "UIScrollEdgeFade_Sprite_Top"
  local botTex = Texture2D(1, GRAD_HEIGHT, TextureFormat.RGBA32, false)
  botTex.name = "UIScrollEdgeFade_GradientTex_Bottom"
  for i = 0, GRAD_HEIGHT - 1 do
    local t = 1 - i / (GRAD_HEIGHT - 1)
    local alpha = math.sqrt(t)
    botTex:SetPixel(0, i, Color(1, 1, 1, alpha))
  end
  botTex:Apply()
  _bottomSprite = Sprite.Create(botTex, texRect, VEC2_HALF, 100, 0, SpriteMeshType.FullRect)
  _bottomSprite.name = "UIScrollEdgeFade_Sprite_Bottom"
end

local function EnsureHorizSprites()
  if _leftSprite and not IsNil(_leftSprite) and _rightSprite and not IsNil(_rightSprite) then
    return
  end
  local leftTex = Texture2D(GRAD_HEIGHT, 1, TextureFormat.RGBA32, false)
  leftTex.name = "UIScrollEdgeFade_GradientTex_Left"
  for i = 0, GRAD_HEIGHT - 1 do
    local t = 1 - i / (GRAD_HEIGHT - 1)
    local alpha = math.sqrt(t)
    leftTex:SetPixel(i, 0, Color(1, 1, 1, alpha))
  end
  leftTex:Apply()
  local leftRect = Rect(0, 0, GRAD_HEIGHT, 1)
  _leftSprite = Sprite.Create(leftTex, leftRect, VEC2_HALF, 100, 0, SpriteMeshType.FullRect)
  _leftSprite.name = "UIScrollEdgeFade_Sprite_Left"
  local rightTex = Texture2D(GRAD_HEIGHT, 1, TextureFormat.RGBA32, false)
  rightTex.name = "UIScrollEdgeFade_GradientTex_Right"
  for i = 0, GRAD_HEIGHT - 1 do
    local t = i / (GRAD_HEIGHT - 1)
    local alpha = math.sqrt(t)
    rightTex:SetPixel(i, 0, Color(1, 1, 1, alpha))
  end
  rightTex:Apply()
  _rightSprite = Sprite.Create(rightTex, leftRect, VEC2_HALF, 100, 0, SpriteMeshType.FullRect)
  _rightSprite.name = "UIScrollEdgeFade_Sprite_Right"
end

local function ParseHexColor(hex)
  local r = tonumber(hex:sub(2, 3), 16) / 255
  local g = tonumber(hex:sub(4, 5), 16) / 255
  local b = tonumber(hex:sub(6, 7), 16) / 255
  return r, g, b
end

local function CreateHorizGradientSprite(lR, lG, lB, rR, rG, rB)
  local key = string.format("%.2f_%.2f_%.2f_%.2f_%.2f_%.2f", lR, lG, lB, rR, rG, rB)
  local cached = _gradSpriteCache[key]
  if cached and not IsNil(cached) then
    return cached
  end
  local tex = Texture2D(GRAD_WIDTH, GRAD_HEIGHT, TextureFormat.RGBA32, false)
  tex.name = "UIScrollEdgeFade_GradBot_" .. key
  for y = 0, GRAD_HEIGHT - 1 do
    local t = 1 - y / (GRAD_HEIGHT - 1)
    local alpha = math.sqrt(t)
    for x = 0, GRAD_WIDTH - 1 do
      local xt = x / (GRAD_WIDTH - 1)
      local r = lR + (rR - lR) * xt
      local g = lG + (rG - lG) * xt
      local b = lB + (rB - lB) * xt
      tex:SetPixel(x, y, Color(r, g, b, alpha))
    end
  end
  tex:Apply()
  local texRect = Rect(0, 0, GRAD_WIDTH, GRAD_HEIGHT)
  local spr = Sprite.Create(tex, texRect, VEC2_HALF, 100, 0, SpriteMeshType.FullRect)
  spr.name = "UIScrollEdgeFade_Sprite_GradBot_" .. key
  _gradSpriteCache[key] = spr
  return spr
end

local _contexts = {}

local function DetectBgColor(transform)
  local t = transform
  while t do
    local img = t:GetComponent(T_Image)
    if img and not IsNil(img) and img.color.a >= 0.99 then
      return img.color
    end
    t = t.parent
  end
  do return Color, DEFAULT_R, DEFAULT_G, DEFAULT_B end
  return Color, DEFAULT_R, DEFAULT_G, DEFAULT_B, 1
end

local function CaptureBgFadeSprite(transform, fadeHeight, isTop)
  local bgImage
  local t = transform
  while t do
    local img = t:GetComponent(T_Image)
    if img and not IsNil(img) and img.sprite and not IsNil(img.sprite) and img.color.a >= 0.99 then
      bgImage = img
      break
    end
    t = t.parent
  end
  if not bgImage then
    return nil, nil
  end
  local spr = bgImage.sprite
  local tex = spr.texture
  if not tex or IsNil(tex) or not tex.isReadable then
    return nil, nil
  end
  local ok, srcPixels = pcall(function()
    local rect = spr.rect
    local x = math.floor(rect.x)
    local y = math.floor(rect.y)
    local w = math.floor(rect.width)
    local h = math.floor(rect.height)
    local fh = math.min(fadeHeight, h)
    local srcY = isTop and y + h - fh or y
    do return tex.GetPixels, tex, x, srcY, w end
    return tex.GetPixels, tex, x, srcY, w, fh
  end)
  if not ok or not srcPixels then
    return nil, nil
  end
  local rect = spr.rect
  local w = math.floor(rect.width)
  local h = math.min(fadeHeight, math.floor(rect.height))
  local newTex = Texture2D(w, h, TextureFormat.RGBA32, false)
  newTex.name = string.format("ScrollEdgeFade_Cap_%s_%s", transform.name, isTop and "T" or "B")
  local rSum, gSum, bSum, cnt = 0, 0, 0, 0
  for py = 0, h - 1 do
    local tFade = isTop and 1 - py / (h - 1) or py / (h - 1)
    local alpha = math.sqrt(tFade)
    for px = 0, w - 1 do
      local c = srcPixels[py * w + px]
      newTex:SetPixel(px, py, Color(c.r, c.g, c.b, alpha))
      rSum = rSum + c.r
      gSum = gSum + c.g
      bSum = bSum + c.b
      cnt = cnt + 1
    end
  end
  newTex:Apply()
  local avgColor = cnt > 0 and Color(rSum / cnt, gSum / cnt, bSum / cnt, 1) or Color(DEFAULT_R, DEFAULT_G, DEFAULT_B, 1)
  local texRect = Rect(0, 0, w, h)
  local newSpr = Sprite.Create(newTex, texRect, VEC2_HALF, 100, 0, SpriteMeshType.FullRect)
  newSpr.name = newTex.name .. "_Sprite"
  return newSpr, avgColor
end

local function OnScrollChanged(pos, ctx)
  if not ctx.scrollRect or IsNil(ctx.scrollRect) then
    return
  end
  local content = ctx.scrollRect.content
  if not content then
    return
  end
  local topAlpha, botAlpha
  local fadeRange = (ctx.fadeHeight or DEFAULT_FADE_H) * 0.5
  if ctx.isHorizontal then
    local contentW = content.rect.width
    local viewportW = ctx.viewport.rect.width
    local scrollableW = contentW - viewportW
    if scrollableW <= 0.01 then
      topAlpha = 0
      botAlpha = 0
    else
      local normX = ctx.scrollRect.horizontalNormalizedPosition
      local leftOverflow = normX * scrollableW
      local rightOverflow = (1 - normX) * scrollableW
      topAlpha = ctx.topEnabled and Mathf.Clamp01(leftOverflow / fadeRange) or 0
      botAlpha = ctx.botEnabled and Mathf.Clamp01(rightOverflow / fadeRange) or 0
    end
  else
    local contentH = content.rect.height
    local viewportH = ctx.viewport.rect.height
    local scrollableH = contentH - viewportH
    if scrollableH <= 0.01 then
      topAlpha = 0
      botAlpha = 0
    else
      local normY = ctx.scrollRect.verticalNormalizedPosition
      local topOverflow = (1 - normY) * scrollableH
      local botOverflow = normY * scrollableH
      topAlpha = ctx.topEnabled and Mathf.Clamp01(topOverflow / fadeRange) or 0
      botAlpha = ctx.botEnabled and Mathf.Clamp01(botOverflow / fadeRange) or 0
    end
  end
  if ctx.topImage and math.abs(topAlpha - (ctx._lastTopAlpha or -1)) > 0.005 then
    ctx._lastTopAlpha = topAlpha
    if ctx.captured or ctx.topCaptured then
      ctx.topImage.color = Color(1, 1, 1, topAlpha)
    else
      ctx.topImage.color = Color(ctx.topR, ctx.topG, ctx.topB, topAlpha)
    end
  end
  if ctx.bottomImage and math.abs(botAlpha - (ctx._lastBotAlpha or -1)) > 0.005 then
    ctx._lastBotAlpha = botAlpha
    if ctx.botGradient or ctx.captured or ctx.botCaptured then
      ctx.bottomImage.color = Color(1, 1, 1, botAlpha)
    else
      ctx.bottomImage.color = Color(ctx.botR, ctx.botG, ctx.botB, botAlpha)
    end
  end
end

local function ForceRefresh(ctx)
  ctx._lastTopAlpha = nil
  ctx._lastBotAlpha = nil
  OnScrollChanged(VEC2_ZERO, ctx)
end

local function CreateFadeGO(viewport, goName, isStart, sprite, fadeHeight, bgColor, isCaptured, isHorizontal)
  local go = GameObject(goName)
  go.transform:SetParent(viewport, false)
  local rt = go:AddComponent(T_RectTransform)
  if isHorizontal then
    if isStart then
      rt.anchorMin = Vector2(0, 0)
      rt.anchorMax = Vector2(0, 1)
      rt.pivot = Vector2(0, 0.5)
    else
      rt.anchorMin = Vector2(1, 0)
      rt.anchorMax = Vector2(1, 1)
      rt.pivot = Vector2(1, 0.5)
    end
    rt.anchoredPosition = VEC2_ZERO
    rt.sizeDelta = Vector2(fadeHeight, 0)
  else
    if isStart then
      rt.anchorMin = Vector2(0, 1)
      rt.anchorMax = Vector2(1, 1)
      rt.pivot = Vector2(0.5, 1)
    else
      rt.anchorMin = Vector2(0, 0)
      rt.anchorMax = Vector2(1, 0)
      rt.pivot = Vector2(0.5, 0)
    end
    rt.anchoredPosition = VEC2_ZERO
    rt.sizeDelta = Vector2(0, fadeHeight)
  end
  rt.localScale = VEC3_ONE
  local img = go:AddComponent(T_Image)
  img.sprite = sprite
  img.color = isCaptured and Color(1, 1, 1, 1) or Color(bgColor.r, bgColor.g, bgColor.b, 1)
  img.raycastTarget = false
  return img
end

function UIScrollEdgeFade.Apply(scrollGo, fadeHeight, tryCapture)
  if not scrollGo or IsNil(scrollGo) then
    return
  end
  fadeHeight = fadeHeight or DEFAULT_FADE_H
  local goId = scrollGo:GetInstanceID()
  local ctx = _contexts[goId]
  if ctx and ctx.topImage and not IsNil(ctx.topImage) then
    return
  end
  if ctx then
    UIScrollEdgeFade.Remove(scrollGo)
  end
  local scrollRect = scrollGo:GetComponent(T_ScrollRect)
  if not scrollRect or IsNil(scrollRect) then
    return
  end
  local viewport = scrollRect.viewport
  if not viewport then
    return
  end
  local bgColor = DetectBgColor(scrollGo.transform)
  local isHorizontal = scrollRect.horizontal and not scrollRect.vertical
  local topCapSpr, botCapSpr, captured, topCapAvg, botCapAvg
  if tryCapture and not isHorizontal then
    topCapSpr, topCapAvg = CaptureBgFadeSprite(scrollGo.transform, fadeHeight, true)
    botCapSpr, botCapAvg = CaptureBgFadeSprite(scrollGo.transform, fadeHeight, false)
    captured = nil ~= topCapSpr and nil ~= botCapSpr
  end
  if not captured then
    if isHorizontal then
      EnsureHorizSprites()
    else
      EnsureSprites()
    end
  end
  local topSprite, bottomSprite, startName, endName
  if isHorizontal then
    topSprite = _leftSprite
    bottomSprite = _rightSprite
    startName = "ScrollEdgeFade_Left"
    endName = "ScrollEdgeFade_Right"
  else
    topSprite = captured and topCapSpr or _topSprite
    bottomSprite = captured and botCapSpr or _bottomSprite
    startName = "ScrollEdgeFade_Top"
    endName = "ScrollEdgeFade_Bottom"
  end
  local topImage = CreateFadeGO(viewport, startName, true, topSprite, fadeHeight, bgColor, captured, isHorizontal)
  local bottomImage = CreateFadeGO(viewport, endName, false, bottomSprite, fadeHeight, bgColor, captured, isHorizontal)
  ctx = {
    scrollRect = scrollRect,
    viewport = viewport,
    topImage = topImage,
    bottomImage = bottomImage,
    fadeHeight = fadeHeight,
    isHorizontal = isHorizontal,
    topR = bgColor.r,
    topG = bgColor.g,
    topB = bgColor.b,
    botR = bgColor.r,
    botG = bgColor.g,
    botB = bgColor.b,
    topEnabled = true,
    botEnabled = true,
    botGradient = false,
    captured = captured or false
  }
  
  local function callback(pos)
    OnScrollChanged(pos, ctx)
  end
  
  ctx.callback = callback
  scrollRect.onValueChanged:AddListener(callback)
  if captured then
    if topCapAvg then
      ctx.topR, ctx.topG, ctx.topB = topCapAvg.r, topCapAvg.g, topCapAvg.b
    end
    if botCapAvg then
      ctx.botR, ctx.botG, ctx.botB = botCapAvg.r, botCapAvg.g, botCapAvg.b
    end
  end
  _contexts[goId] = ctx
  Logger.Info("[UIScrollEdgeFade] Apply to: %s, h=%s, bg=(%.3f,%.3f,%.3f), capture=%s", scrollGo.name, tostring(fadeHeight), bgColor.r, bgColor.g, bgColor.b, tostring(captured or false))
  ForceRefresh(ctx)
end

function UIScrollEdgeFade.Remove(scrollGo)
  if not scrollGo or IsNil(scrollGo) then
    return
  end
  local goId = scrollGo:GetInstanceID()
  local ctx = _contexts[goId]
  if not ctx then
    return
  end
  if ctx.scrollRect and not IsNil(ctx.scrollRect) and ctx.callback then
    ctx.scrollRect.onValueChanged:RemoveListener(ctx.callback)
  end
  if ctx.topImage and not IsNil(ctx.topImage) then
    GameObject.Destroy(ctx.topImage.gameObject)
  end
  if ctx.bottomImage and not IsNil(ctx.bottomImage) then
    GameObject.Destroy(ctx.bottomImage.gameObject)
  end
  if ctx.customSprites then
    for _, spr in ipairs(ctx.customSprites) do
      if spr and not IsNil(spr) then
        GameObject.Destroy(spr)
      end
    end
    ResLoadMgr.UnloadAssetByTarget(ctx)
  end
  if ctx.customTextures then
    for _, tex in ipairs(ctx.customTextures) do
      if tex and not IsNil(tex) then
        GameObject.Destroy(tex)
      end
    end
  end
  _contexts[goId] = nil
end

function UIScrollEdgeFade.SetFadeHeight(scrollGo, height)
  if not scrollGo or IsNil(scrollGo) then
    return
  end
  local ctx = _contexts[scrollGo:GetInstanceID()]
  if not ctx then
    return
  end
  ctx.fadeHeight = height
  local sizeDelta = ctx.isHorizontal and Vector2(height, 0) or Vector2(0, height)
  if ctx.topImage and not IsNil(ctx.topImage) then
    ctx.topImage.rectTransform.sizeDelta = sizeDelta
  end
  if ctx.bottomImage and not IsNil(ctx.bottomImage) then
    ctx.bottomImage.rectTransform.sizeDelta = sizeDelta
  end
end

function UIScrollEdgeFade.SetSideEnabled(scrollGo, top, bottom)
  if not scrollGo or IsNil(scrollGo) then
    return
  end
  local ctx = _contexts[scrollGo:GetInstanceID()]
  if not ctx then
    return
  end
  if nil ~= top then
    ctx.topEnabled = top
  end
  if nil ~= bottom then
    ctx.botEnabled = bottom
  end
  ForceRefresh(ctx)
end

function UIScrollEdgeFade.SetFadeColor(scrollGo, arg1, arg2, arg3, ...)
  if not scrollGo or IsNil(scrollGo) then
    return
  end
  local ctx = _contexts[scrollGo:GetInstanceID()]
  if not ctx then
    return
  end
  local topR, topG, topB, botR, botG, botB
  if type(arg1) == "string" then
    topR, topG, topB = ParseHexColor(arg1)
    if type(arg2) == "string" then
      botR, botG, botB = ParseHexColor(arg2)
    else
      botR, botG, botB = topR, topG, topB
    end
  else
    topR, topG, topB = arg1, arg2, arg3
    local extra = {
      ...
    }
    if #extra >= 3 then
      botR, botG, botB = extra[1], extra[2], extra[3]
    else
      botR, botG, botB = topR, topG, topB
    end
  end
  ctx.topR = topR
  ctx.topG = topG
  ctx.topB = topB
  ctx.botR = botR
  ctx.botG = botG
  ctx.botB = botB
  if ctx.botGradient then
    ctx.botGradient = false
    if ctx.bottomImage and not IsNil(ctx.bottomImage) then
      EnsureSprites()
      ctx.bottomImage.sprite = _bottomSprite
    end
  end
  if ctx.captured then
    ctx.captured = false
    EnsureSprites()
    if ctx.topImage and not IsNil(ctx.topImage) then
      ctx.topImage.sprite = _topSprite
    end
    if ctx.bottomImage and not IsNil(ctx.bottomImage) then
      ctx.bottomImage.sprite = _bottomSprite
    end
  end
end

function UIScrollEdgeFade.SetBottomGradient(scrollGo, leftOrLR, rightOrLG, ...)
  if not scrollGo or IsNil(scrollGo) then
    return
  end
  local ctx = _contexts[scrollGo:GetInstanceID()]
  if not ctx then
    return
  end
  local lR, lG, lB, rR, rG, rB
  if type(leftOrLR) == "string" then
    lR, lG, lB = ParseHexColor(leftOrLR)
    rR, rG, rB = ParseHexColor(rightOrLG)
  else
    local extra = {
      ...
    }
    lR, lG, lB = leftOrLR, rightOrLG, extra[1]
    rR, rG, rB = extra[2], extra[3], extra[4]
  end
  local spr = CreateHorizGradientSprite(lR, lG, lB, rR, rG, rB)
  ctx.botGradient = true
  if ctx.bottomImage and not IsNil(ctx.bottomImage) then
    ctx.bottomImage.sprite = spr
    ForceRefresh(ctx)
  end
end

function UIScrollEdgeFade.SetFadeSprite(scrollGo, assetPath, side)
  if not scrollGo or IsNil(scrollGo) then
    return
  end
  local ctx = _contexts[scrollGo:GetInstanceID()]
  if not ctx then
    return
  end
  local asset = ResLoadMgr.LoadAsset(assetPath, ctx)
  if not asset then
    Logger.Warn("[UIScrollEdgeFade] SetFadeSprite failed to load: %s", assetPath)
    return
  end
  local tex
  local T_Sprite = typeof(CS.UnityEngine.Sprite)
  if asset:GetType() == T_Sprite then
    tex = asset.texture
  else
    tex = asset
  end
  if not tex then
    return
  end
  local spr = Sprite.Create(tex, Rect(0, 0, tex.width, tex.height), VEC2_HALF, 100, 0, SpriteMeshType.FullRect)
  ctx.customSprites = ctx.customSprites or {}
  table.insert(ctx.customSprites, spr)
  if "top" == side and ctx.topImage and not IsNil(ctx.topImage) then
    ctx.topImage.sprite = spr
    ctx.topCaptured = true
  elseif ctx.bottomImage and not IsNil(ctx.bottomImage) then
    ctx.bottomImage.sprite = spr
    ctx.botCaptured = true
  end
  ForceRefresh(ctx)
end

function UIScrollEdgeFade.ApplyBgImage(scrollGo, bgImageGo)
  if not scrollGo or IsNil(scrollGo) then
    return
  end
  UIScrollEdgeFade.Apply(scrollGo)
  local ctx = _contexts[scrollGo:GetInstanceID()]
  if not ctx then
    return
  end
  if not bgImageGo or IsNil(bgImageGo) then
    Logger.Warn("[UIScrollEdgeFade] ApplyBgImage: bgImageGo is nil")
    return
  end
  local bgImage = bgImageGo:GetComponent(T_Image)
  if not (bgImage and not IsNil(bgImage) and bgImage.sprite) or IsNil(bgImage.sprite) then
    Logger.Warn("[UIScrollEdgeFade] ApplyBgImage: no valid Image on %s", bgImageGo.name)
    return
  end
  local bgSprite = bgImage.sprite
  local srcTex = bgSprite.texture
  if not srcTex or IsNil(srcTex) then
    Logger.Warn("[UIScrollEdgeFade] ApplyBgImage: bg sprite has no texture")
    return
  end
  local fadeH = ctx.fadeHeight or DEFAULT_FADE_H
  local texRect = bgSprite.textureRect
  local sprW = texRect.width
  local sprH = texRect.height
  local sprUVXMin = texRect.x / srcTex.width
  local sprUVXMax = (texRect.x + sprW) / srcTex.width
  local sprUVYMin = texRect.y / srcTex.height
  local sprUVYMax = (texRect.y + sprH) / srcTex.height
  local bgRT = bgImage.rectTransform
  local vpRT = ctx.viewport
  if vpRT.rect.width < 1 or vpRT.rect.height < 1 then
    FrameWaiter.OnNextFrame(function()
      UIScrollEdgeFade.ApplyBgImage(scrollGo, bgImageGo)
    end)
    return
  end
  local vpMin = vpRT:TransformPoint(Vector3(vpRT.rect.xMin, vpRT.rect.yMin, 0))
  local vpMax = vpRT:TransformPoint(Vector3(vpRT.rect.xMax, vpRT.rect.yMax, 0))
  local bgLocalMin = bgRT:InverseTransformPoint(vpMin)
  local bgLocalMax = bgRT:InverseTransformPoint(vpMax)
  local bgRect = bgRT.rect
  local normXMin = Mathf.Clamp01((bgLocalMin.x - bgRect.xMin) / bgRect.width)
  local normXMax = Mathf.Clamp01((bgLocalMax.x - bgRect.xMin) / bgRect.width)
  local normYMin = Mathf.Clamp01((bgLocalMin.y - bgRect.yMin) / bgRect.height)
  local normYMax = Mathf.Clamp01((bgLocalMax.y - bgRect.yMin) / bgRect.height)
  local uvXMin = sprUVXMin + normXMin * (sprUVXMax - sprUVXMin)
  local uvXMax = sprUVXMin + normXMax * (sprUVXMax - sprUVXMin)
  local uvYMin = sprUVYMin + normYMin * (sprUVYMax - sprUVYMin)
  local uvYMax = sprUVYMin + normYMax * (sprUVYMax - sprUVYMin)
  local shader = CS.ShaderCache.Find("Hidden/UIScrollEdgeFade/Gradient")
  if not shader or IsNil(shader) then
    Logger.Warn("[UIScrollEdgeFade] ApplyBgImage: shader not found")
    return
  end
  ctx.customSprites = ctx.customSprites or {}
  ctx.customTextures = ctx.customTextures or {}
  local isHoriz = ctx.isHorizontal
  
  local function generateSide(fadeDir, sideUVXMin, sideUVXMax, sideUVYMin, sideUVYMax, rtW, rtH)
    local mat = Material(shader)
    mat:SetFloat("_FadeDir", fadeDir)
    mat:SetFloat("_FadeAxis", isHoriz and 1 or 0)
    mat:SetFloat("_UVXMin", sideUVXMin)
    mat:SetFloat("_UVXMax", sideUVXMax)
    mat:SetFloat("_UVYMin", sideUVYMin)
    mat:SetFloat("_UVYMax", sideUVYMax)
    mat:SetFloat("_TexSize", isHoriz and rtW or rtH)
    local rt = RenderTexture(rtW, rtH, 0, RenderTextureFormat.ARGB32, RenderTextureReadWrite.Linear)
    rt:Create()
    Graphics.Blit(srcTex, rt, mat)
    RenderTexture.active = rt
    local resultTex = Texture2D(rtW, rtH, TextureFormat.RGBA32, false, true)
    resultTex:ReadPixels(Rect(0, 0, rtW, rtH), 0, 0)
    resultTex:Apply()
    RenderTexture.active = nil
    rt:Release()
    GameObject.Destroy(rt)
    GameObject.Destroy(mat)
    local spr = Sprite.Create(resultTex, Rect(0, 0, rtW, rtH), VEC2_HALF, 100, 0, SpriteMeshType.FullRect)
    table.insert(ctx.customSprites, spr)
    table.insert(ctx.customTextures, resultTex)
    return spr
  end
  
  if isHoriz then
    local vpW = vpRT.rect.width
    local vpH = vpRT.rect.height
    local rtW = fadeH
    local rtH = math.ceil(vpH)
    local leftUVXMax = uvXMin + fadeH / vpW * (uvXMax - uvXMin)
    local leftSpr = generateSide(0, uvXMin, leftUVXMax, uvYMin, uvYMax, rtW, rtH)
    if ctx.topImage and not IsNil(ctx.topImage) then
      ctx.topImage.sprite = leftSpr
      ctx.topCaptured = true
    end
    local rightUVXMin = uvXMax - fadeH / vpW * (uvXMax - uvXMin)
    local rightSpr = generateSide(1, rightUVXMin, uvXMax, uvYMin, uvYMax, rtW, rtH)
    if ctx.bottomImage and not IsNil(ctx.bottomImage) then
      ctx.bottomImage.sprite = rightSpr
      ctx.botCaptured = true
    end
  else
    local vpW = vpRT.rect.width
    local vpH = vpRT.rect.height
    local rtW = math.ceil(vpW)
    local rtH = fadeH
    local topUVYMin = uvYMax - fadeH / vpH * (uvYMax - uvYMin)
    local topSpr = generateSide(1, uvXMin, uvXMax, topUVYMin, uvYMax, rtW, rtH)
    if ctx.topImage and not IsNil(ctx.topImage) then
      ctx.topImage.sprite = topSpr
      ctx.topCaptured = true
    end
    local botUVYMax = uvYMin + fadeH / vpH * (uvYMax - uvYMin)
    local botSpr = generateSide(0, uvXMin, uvXMax, uvYMin, botUVYMax, rtW, rtH)
    if ctx.bottomImage and not IsNil(ctx.bottomImage) then
      ctx.bottomImage.sprite = botSpr
      ctx.botCaptured = true
    end
  end
  Logger.Info("[UIScrollEdgeFade] ApplyBgImage: %s bg=%s horiz=%s", scrollGo.name, bgImage.gameObject.name, tostring(isHoriz))
  ForceRefresh(ctx)
end

function UIScrollEdgeFade.AutoDetect(scrollGo)
  if not scrollGo or IsNil(scrollGo) then
    return
  end
  local ctx = _contexts[scrollGo:GetInstanceID()]
  if not ctx then
    return
  end
  local bgColor = DetectBgColor(scrollGo.transform)
  ctx.topR = bgColor.r
  ctx.topG = bgColor.g
  ctx.topB = bgColor.b
  ctx.botR = bgColor.r
  ctx.botG = bgColor.g
  ctx.botB = bgColor.b
  Logger.Info("[UIScrollEdgeFade] AutoDetect: %s bg=(%.3f,%.3f,%.3f)", scrollGo.name, bgColor.r, bgColor.g, bgColor.b)
  ForceRefresh(ctx)
end

return UIScrollEdgeFade
