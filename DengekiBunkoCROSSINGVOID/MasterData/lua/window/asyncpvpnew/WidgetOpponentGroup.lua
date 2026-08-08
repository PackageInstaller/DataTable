local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local GU = require("Common/GroupUtil")
local m_style = {showAdd = false, showArm = false}

function Awake()
end

function Start()
end

function ResetStyle()
  m_style = {}
  for i = 0, #REF.Empty - 1 do
    WU.SetActive(REF.Empty[i].SpriteAdd, false)
  end
  WU.SetActive(REF.Members, false)
  WU.SetActive(REF.Arm, false)
end

function SetViewStyle(style)
  m_style.showAdd = style.showAdd or m_style.showAdd
  m_style.showArm = style.showArm or m_style.showArm
end

function SetViewByActors(actors, isReversed)
  for index = 1, 6 do
    local actorIndex = index
    if isReversed then
      actorIndex = 7 - index
    end
    local actor = actors[actorIndex]
    local ref = _ENV["$"](REF.Members)["WidgetIconActor" .. index]
    local hasActor = actor and actor.id and actor.id ~= 0
    if hasActor then
      ref["$SetActorCustom"](actor)
      ref["$ShowCustom"]({showArm = false})
    end
    WU.SetActive(ref["$gameObject"], hasActor)
    if m_style.showArm then
      local hasArm = hasActor and actor.uniqueWeaponId and actor.uniqueWeaponId ~= 0
      local armRef = _ENV["$"](REF["Arm" .. index])
      if hasArm then
        local info = PB.get("UniqueWeaponInfo", actor.uniqueWeaponId)
        armRef.SpriteArmS.UISprite.spriteName = "impression_role_" .. info.id .. "_0"
        if info.position == 2 then
          armRef.SpriteSub.UISprite.spriteName = "impression_sub_" .. info.quality - 2
        end
        WU.SetActive(armRef.SpriteSub, info.position == 2)
      end
      WU.SetActive(armRef.SpriteArmS, hasArm)
    end
    WU.SetActive(REF.Arm, m_style.showArm)
    if m_style.showAdd then
      WU.SetActive(_ENV["$"](REF.Empty)["Empty" .. index], true)
    end
  end
  WU.SetActive(REF.Members, true)
end

function SetViewByMembers(members, isReversed)
  for index = 1, 6 do
    local actorIndex = index
    if isReversed then
      actorIndex = 7 - index
    end
    local member = members[actorIndex]
    local actor = member.actor
    local ref = _ENV["$"](REF.Members)["WidgetIconActor" .. index]
    local hasActor = member and member.actorUid ~= 0 and member.actorUid ~= nil
    if hasActor then
      if actor == nil then
        actor = this:GetData("fci/actor/" .. member.actorUid)
      end
      if actor then
        ref["$SetActorCustom"](actor)
        ref["$ShowCustom"]({showArm = false})
      end
    end
    WU.SetActive(ref, actor)
    if m_style.showArm then
      local hasArm = hasActor and actor.uniqueWeaponId and actor.uniqueWeaponId ~= 0
      local armRef = _ENV["$"](REF["Arm" .. index])
      if hasArm then
        local info = PB.get("UniqueWeaponInfo", actor.uniqueWeaponId)
        armRef.SpriteArmS.UISprite.spriteName = "impression_role_" .. info.id .. "_0"
        if info.position == 2 then
          armRef.SpriteSub.UISprite.spriteName = "impression_sub_" .. info.quality - 2
        end
        WU.SetActive(armRef.SpriteSub, info.position == 2)
      end
      WU.SetActive(armRef.SpriteArmS, hasArm)
    end
    WU.SetActive(REF.Arm, m_style.showArm)
    if m_style.showAdd then
      WU.SetActive(_ENV["$"](REF.Empty)["Empty" .. index], true)
    end
  end
  WU.SetActive(REF.Members, true)
end
