local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_dragDelta, m_textureSet
local TextureSet = {
  ChapterNormal = {
    [1] = "Texture/ChapterBackground/story_notebook_bg_1",
    [2] = "Texture/ChapterBackground/story_notebook_bg_2",
    [3] = "Texture/ChapterBackground/story_notebook_bg_3",
    [4] = "Texture/ChapterBackground/story_notebook_bg_4",
    [5] = "Texture/ChapterBackground/story_notebook_bg_5",
    [6] = "Texture/ChapterBackground/story_notebook_bg_6",
    [7] = "Texture/ChapterBackground/story_notebook_bg_7",
    [8] = "Texture/ChapterBackground/story_notebook_bg_8",
    cover = "Texture/ChapterBackground/story_notebook_bg_0"
  },
  RoleNotepad = {
    [1] = "Texture/ChapterBackground/account_notebook_bg_1",
    [2] = "Texture/ChapterBackground/account_notebook_bg_1",
    [3] = "Texture/ChapterBackground/account_notebook_bg_1",
    cover = "Texture/ChapterBackground/account_notebook_bg_2"
  }
}

function Start()
end

function OnDraging(go, delta)
  m_dragDelta = m_dragDelta + delta
end

function OnPress(go, press)
  if press then
    m_dragDelta = CS.UnityEngine.Vector2.zero
  else
    local luaWindow = REF["$transform"]:GetComponentInParent(typeof(CS.UILuaWindow))
    if _ENV["$"](luaWindow)["$$NavigateRelative"] == nil then
      error("WidgetBookRoller", "NavigateRelative function not found")
      return
    end
  end
end

function Mode(mode)
  m_textureSet = TextureSet[mode]
end

function BookCover(toIndex, callback)
  if m_textureSet == nil then
    error("WidgetBookRoller", "Texture Set nil?!")
    return
  end
  REF.PageIndicator[toIndex]["$UIToggle"].value = true
  local bookRef = _ENV["$"](REF.EffectBookA)
  toIndex = (toIndex or 0) % #m_textureSet
  local cover = WU.AcquireAsset(m_textureSet.cover, this)
  local textureTo = WU.AcquireAsset(m_textureSet[toIndex + 1], this)
  bookRef.A1.MeshRenderer.material:SetTexture("_MainTex", cover)
  bookRef.A2.SkinnedMeshRenderer.material:SetTexture("_MainTex", cover)
  bookRef.B1.SkinnedMeshRenderer.material:SetTexture("_MainTex", textureTo)
  bookRef.B2.MeshRenderer.material:SetTexture("_MainTex", textureTo)
  this:DelayInvokeInSeconds(0.2, function()
    if callback ~= nil then
      callback()
    end
  end)
  bookRef["$EffectGenerator"]:Play()
  WU.ToggleRendering(REF.EffectBookB, false)
  WU.ToggleRendering(REF.EffectBookA, true)
end

function Page(fromIndex, toIndex, callback, chapterFromID, chapterToID)
  if fromIndex ~= toIndex then
    REF.PageIndicator[toIndex]["$UIToggle"].value = true
    local bookRef = fif(toIndex < fromIndex, _ENV["$"](REF.EffectBookB), _ENV["$"](REF.EffectBookA))
    this:DelayInvokeInSeconds(0.2, function()
      local fromTex = fromIndex % #m_textureSet
      local toTex = toIndex % #m_textureSet
      local textureFrom, textureTo
      textureFrom = WU.AcquireAsset(m_textureSet[fromTex + 1], this)
      textureTo = WU.AcquireAsset(m_textureSet[toTex + 1], this)
      if fromIndex > toIndex then
        textureFrom, textureTo = textureTo, textureFrom
      end
      bookRef.A1.MeshRenderer.material:SetTexture("_MainTex", textureFrom)
      bookRef.A2.SkinnedMeshRenderer.material:SetTexture("_MainTex", textureFrom)
      bookRef.B1.SkinnedMeshRenderer.material:SetTexture("_MainTex", textureTo)
      bookRef.B2.MeshRenderer.material:SetTexture("_MainTex", textureTo)
      if callback ~= nil then
        callback()
      end
      bookRef["$EffectGenerator"]:Play()
      WU.ToggleRendering(REF.EffectBookA, fromIndex < toIndex)
      WU.ToggleRendering(REF.EffectBookB, fromIndex > toIndex)
    end)
  end
end

function ReservePageIndicators(count, onClick)
  local dotPrefab = REF.PageIndicator[0]["$gameObject"]
  if dotPrefab then
    if #REF.PageIndicator == 1 then
      WU.BindButtonEvent(REF.PageIndicator[0].root, function()
        onClick(0)
      end)
    end
    while count > #REF.PageIndicator do
      local dot = CS.UnityEngine.GameObject.Instantiate(dotPrefab, REF.PageIndicator.transform)
      WU.BindButtonEvent(_ENV["$"](dot).root, function()
        onClick(dot.transform:GetSiblingIndex())
      end)
    end
    for i = 0, #REF.PageIndicator - 1 do
      REF.PageIndicator[i]["$gameObject"]:SetActive(count > i)
    end
  end
  REF.PageIndicator.UIGrid:Reposition()
end
