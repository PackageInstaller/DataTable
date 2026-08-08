local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local TriggeredType = {
  "None",
  "Normal",
  "Bomb"
}
local LerpInterval = 0.05
local m_triggeredEvent, m_receiver, m_lerpVal, m_dropItem, m_elapseTime, m_isDropping, m_positionFrom, m_speed

local function FoodLogic()
  REF.ItemTexture.gameObject:SetActive(true)
  if m_dropItem.type == PB.enum.ResourceType.ResItem then
    REF.ItemTexture.UITexture.mainTexturePath = "Texture/Welfare/new_year/minigame_" .. m_dropItem.typeId
  else
    REF.ItemTexture.UITexture.mainTexturePath = "Texture/Welfare/new_year/minigame_8"
  end
  
  function m_triggeredEvent()
    this:BroadcastGameEvent("ScoreChange", {
      {
        type = m_dropItem.type,
        id = m_dropItem.typeId,
        count = 1
      }
    })
  end
end

local function BombLogic()
  WU.SetActive(REF.EffectBomb, true)
  REF.EffectBomb.EffectGenerator:Play()
  
  function m_triggeredEvent()
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Get_Bomb", 1.0)
    this:BroadcastGameEvent("Bomb")
  end
end

local function TimeIncreaseLogic()
  WU.SetActive(REF.EffectTime, true)
  REF.EffectTime.EffectGenerator:Play()
  
  function m_triggeredEvent()
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Get_Time", 1.0)
    WU.SetActive(REF.EffectTime, false)
    this:BroadcastGameEvent("TimeChange")
  end
end

local function TimeBounsLogic()
  WU.SetActive(REF.EffectBounsTime, true)
  REF.EffectBounsTime.EffectGenerator:Play()
  
  function m_triggeredEvent()
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Get_Special", 1.0)
    WU.SetActive(REF.EffectBounsTime, false)
    this:BroadcastGameEvent("BounsTimeChange")
  end
end

local function MagnetLogic()
  WU.SetActive(REF.EffectMagnet, true)
  REF.EffectMagnet.EffectGenerator:Play()
  
  function m_triggeredEvent()
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Get_magnet", 1.0)
    this:BroadcastGameEvent("Magnet")
  end
end

local Type2Function = {
  Food = FoodLogic,
  Bomb = BombLogic,
  TimeIncrease = TimeIncreaseLogic,
  TimeBouns = TimeBounsLogic,
  Magnet = MagnetLogic
}

function OnDropStart(minSpeed, maxSpeed)
  if maxSpeed < minSpeed then
    return
  end
  m_elapseTime = 0
  REF["@dropState"] = 3
  m_isDropping = true
  local speed = math.random(minSpeed, maxSpeed)
  REF["@speed"] = speed
  m_positionFrom = REF["$transform"].localPosition.y
  m_speed = speed
  return true
end

function OnDropEnd(triggeredType, parent)
  REF["@dropState"] = 1
  m_isDropping = false
  if m_receiver then
    m_triggeredEvent = nil
  end
  m_receiver = nil
  REF["@speed"] = 0
  m_speed = 0
  local type = TriggeredType[triggeredType]
  if type == "Normal" then
    if m_triggeredEvent then
      m_triggeredEvent()
    end
    this:DelayInvokeEndOfFrame(function()
      REF["$transform"].parent = parent
      REF["$transform"].localPosition = CS.UnityEngine.Vector3.zero
    end)
  elseif type == "Bomb" then
    REF.ItemTexture.gameObject:SetActive(false)
    WU.TraverseChildren(REF.Effects, function(go)
      go:SetActive(false)
    end)
    REF.EffectBombTriggered.gameObject:SetActive(true)
    REF.EffectBombTriggered.EffectGenerator:Play(function()
      REF["$transform"].parent = parent
      REF["$transform"].localPosition = CS.UnityEngine.Vector3.zero
    end)
  end
end

function SetData(dropItem)
  m_dropItem = dropItem
  REF["@typeName"] = dropItem.typeName
  REF["@type"] = dropItem.type
  REF["@typeId"] = dropItem.typeId
  REF["@dropState"] = 2
  m_isDropping = false
  m_elapseTime = nil
  REF.ItemTexture.gameObject:SetActive(false)
  WU.TraverseChildren(REF.Effects, function(go)
    go:SetActive(false)
  end)
  Type2Function[dropItem.typeName]()
end

function Update(delta)
  if m_isDropping then
    m_elapseTime = m_elapseTime + delta
    REF["@dropTime"] = m_elapseTime
    if m_receiver then
      m_lerpVal = m_lerpVal + LerpInterval
      local receiverPos = m_receiver.position
      local foodPos = REF["$transform"].position
      local x = CS.UnityEngine.Mathf.Lerp(foodPos.x, receiverPos.x, m_lerpVal)
      local y = CS.UnityEngine.Mathf.Lerp(foodPos.y, receiverPos.y, m_lerpVal)
      local to = CS.UnityEngine.Vector3(x, y, 0)
      REF["$transform"].position = to
    else
      local now = REF["$transform"].localPosition
      REF["$transform"].localPosition = CS.UnityEngine.Vector3(now.x, m_positionFrom - m_elapseTime * m_speed, now.z)
    end
  end
end

function MagnetMovement(transform)
  REF["@speed"] = 0
  m_speed = 0
  m_lerpVal = 0
  m_receiver = transform
end
