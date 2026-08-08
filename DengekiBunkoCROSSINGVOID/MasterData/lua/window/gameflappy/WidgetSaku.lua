local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local g_upForce = 400
local g_gravity = 37
local m_fly = false
local m_dead = false
local m_isStop
local m_vy = 0
local m_addA = 0
local m_gravity = 0
local m_oriPos

function Awake()
end

function FixedUpdate(delta)
  if m_fly then
    local pos = REF.root.transform.localPosition
    local a = (m_addA - m_gravity) * 50
    m_addA = 0
    local posY = pos.y + m_vy * delta + 0.5 * a * delta * delta
    m_vy = m_vy + a * delta
    REF.root.transform.localPosition = CS.UnityEngine.Vector3(pos.x, posY, pos.z)
  end
end

function OnEnable()
  m_oriPos = REF.root.transform.localPosition
end

function OnDisable()
  REF.root.transform.localPosition = m_oriPos
end

function Reset()
  m_dead = false
  m_isStop = false
  m_vy = 0
  m_gravity = 0
  m_addA = 0
  if m_oriPos then
    REF.root.transform.localPosition = m_oriPos
  end
  WU.SetActive(REF.EffectFly, true)
  WU.SetActive(REF.EffectCollision, false)
  WU.SetActive(REF.EffectDrop, false)
  WU.SetActive(REF.EffectDie, false)
end

function GetSaku()
  return REF.SpriteSaku
end

function FlyStart()
  m_fly = true
  m_gravity = g_gravity
end

function FlyUp()
  if m_dead then
    return
  end
  m_vy = 0
  m_addA = g_upForce
end

function Die(isGround)
  m_dead = true
  m_vy = 0
  this:DelayInvokeInFrames(2, function()
    WU.SetActive(REF.EffectFly, false)
    if isGround then
      StopDrop()
    else
      WU.SetActive(REF.EffectCollision, true)
      this:DelayInvokeInFrames(10, function()
        if m_isStop then
          return
        end
        WU.SetActive(REF.EffectCollision, false)
        WU.SetActive(REF.EffectDrop, true)
      end)
    end
  end)
end

function StopDrop()
  m_isStop = true
  m_fly = false
  WU.SetActive(REF.EffectCollision, false)
  WU.SetActive(REF.EffectDrop, false)
  WU.SetActive(REF.EffectDie, true)
end

function IsStop()
  return m_isStop
end

function SetConfig(f, g)
  if f then
    g_upForce = f
  end
  if g then
    g_gravity = g
  end
end
