local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local NU = require("Common/NotepadUtil")
local m_clickCallback, m_actor
local m_index = 1

function Start()
  m_clickCallback = nil
  m_actor = nil
  m_index = 1
  WU.BindButtonEvent(REF.ButtonSlot, function(go)
    if m_clickCallback then
      m_clickCallback(REF["$gameObject"])
    else
      local selectActorType = this:GetData("BurstLink/ActorSelect/SelectActorType/")
      if m_actor then
        this:GameRequest("fci/BurstLinkPVPRandActorInfo/" .. tostring(selectActorType) .. "/"):Put({
          actorUid = m_actor.uid
        }, function(response)
          if response then
            local curMainActorCount = #response.curMainActor
            local curSubActorCount = #response.curAssistantActor
            this:BroadcastGameEvent("SelectActorChanged", curMainActorCount, curSubActorCount, response.selectActor)
          end
        end)
      end
    end
  end)
  WU.BindButtonEvent(REF.ButtonActorSkill, OnButtonActorSkillClick)
  WU.ToggleRendering(REF.EffectRelation, false)
end

function SetActorData(actor, index)
  if index and type(index) == "number" then
    REF.SpriteBG.UISprite.spriteName = "BurstLink_RoleBG" .. tostring(index)
    REF.SpriteADD.UISprite.spriteName = "BurstLink_RoleBG" .. tostring(index)
    m_index = index
  end
  if actor then
    m_actor = actor
    local actorConfig = PB.get("ActorConfig", actor.id)
    if actorConfig then
      REF.TextureActorPortrait.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. actorConfig.animRes
      REF.SpriteActorType.UISprite.spriteName = "actor_type_" .. actor.id
      REF.SpriteActorName.UISprite.spriteName = "actor_name_" .. actorConfig.animRes
      local spriteData = REF.SpriteActorName.UISprite:GetAtlasSprite()
      if spriteData then
        REF.WidgetForAdjust.UIWidget.width = spriteData.width
      end
      REF.SpriteSubActor.gameObject:SetActive(actorConfig.kind == PB.enum.ActorType.Sub)
    end
  end
end

function SetClickCallback(callback)
  m_clickCallback = callback
end

function OnButtonActorSkillClick(go)
  if m_actor then
    NU.OpenNotepadForActor(m_actor)
  end
end

function ShowRelationEffect(showEffect)
  WU.ToggleRendering(REF.EffectRelation, showEffect)
end
