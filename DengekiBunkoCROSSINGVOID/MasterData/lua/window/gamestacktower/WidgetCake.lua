local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local Vector3 = CS.UnityEngine.Vector3
local m_cakes = {
  [1] = {
    name = "minigame_cake_1",
    width = 262,
    height = 126,
    kind = 1
  },
  [2] = {
    name = "minigame_cake_2",
    width = 344,
    height = 106,
    kind = 2
  },
  [3] = {
    name = "minigame_cake_3",
    width = 396,
    height = 198,
    kind = 3
  }
}
local m_dropBeginY
local m_isDrop = false
local m_tweenPlay, m_helpPoints, m_color, m_isBusy, m_dropInfo, m_cakeInfo

function Awake()
  m_tweenPlay = REF.Content.UIPlayTween
end

function InitCake(type, cakeInfo)
  if type == "Create" then
    m_cakeInfo = nil
  else
    m_cakeInfo = cakeInfo
  end
  WU.SetActive(REF.LabelPerfect, false)
  WU.SetActive(REF.SpriteProtect, false)
  REF.NodeCake.transform.localEulerAngles = CS.UnityEngine.Vector3.zero
  REF.NodeCake.transform.localPosition = CS.UnityEngine.Vector3.zero
  if m_cakeInfo == nil then
    local kind = math.floor(math.random(1, 3))
    while kind == cakeInfo do
      kind = math.floor(math.random(1, 3))
    end
    m_cakeInfo = m_cakes[kind]
  end
  REF.SpriteCake.UISprite.spriteName = m_cakeInfo.name
  REF.SpriteCake.UISprite.width = m_cakeInfo.width
  REF.SpriteCake.UISprite.height = m_cakeInfo.height
  WU.SetActive(REF.SpriteCake, true)
  WU.SetActive(REF.Effect, false)
  REF.Effect.EffectGenerator.m_EffectName = "MaidCafeGame_cake_0" .. m_cakeInfo.kind
  REF.Effect.EffectGenerator:Reset()
  local x = m_cakeInfo.width * 0.5
  local y = m_cakeInfo.height * 0.5
  m_helpPoints = {
    [1] = Vector3(-x, -y, 0),
    [2] = Vector3(-x, y, 0),
    [3] = Vector3(x, y, 0),
    [4] = Vector3(x, -y, 0)
  }
  m_isBusy = true
  return m_cakeInfo
end

function AppearEffect()
  m_tweenPlay.tweenGroup = 1
  m_tweenPlay:Play(true)
end

function CollideEffect(pos)
  if pos ~= nil then
    REF.Effect.transform.localPosition = pos
  end
  WU.SetActive(REF.Effect, true)
  WU.SetActive(REF.SpriteCake, false)
end

function GetCornerPoints()
  return m_helpPoints
end

function GetCakeInfo()
  return m_cakeInfo
end

function SetDropInfo(info)
  m_dropInfo = info
end

function GetDropInfo()
  return m_dropInfo
end

function SetEmpty()
  m_isBusy = false
  m_dropInfo = nil
end

function IsBusy()
  return m_isBusy
end
