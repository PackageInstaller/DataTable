local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local ActorTypePrefix = {
  "Window_ActorMainPrefix",
  "Window_ActorAssistPrefix"
}
local ActorQualityColors = {
  [0] = 2661925119,
  [1] = 885694207,
  [2] = 531949055,
  [3] = 2976907263,
  [4] = 3938272511
}
local m_actorUid, m_callback

function Start()
  WU.BindButtonEvent(REF.SpriteBarBG, OnClick)
end

function SetClickCallback(callback)
  m_callback = callback
end

function OnActorChange(actor)
  if actor then
    local actorConfig = PB.get("ActorConfig", actor.id)
    REF.SpriteQuality.UISprite.color = CS.NGUIMath.HexToColor(ActorQualityColors[actor.quality])
    REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorSkillHead/actor_skill_head_" .. actorConfig.animRes
    REF.SpriteActorType.UISprite.spriteName = "actor_type_" .. actor.id
    REF.SpriteActorName.UISprite.spriteName = "actor_name_" .. actorConfig.animRes
    local actorDegree
    if actor.isGuild then
      actorDegree = actor.cultivationDegree
    else
      actorDegree = AU.GetActorCultivationDegree(actor)
    end
    REF.LevelCultivationDegree.UIHtmlLabel.text = WU.GetString("Window_ActorCultivationDegree", actorDegree)
    REF.LevelLabel.UILabel.text = WU.GetString("Window_Level", actor.level)
    REF.WidgetStarGridL["$SetStar"](actor.star, 0, true)
    local actorTag = PB.get("ActorTag", actor.id)
    REF.LabelCharactorType.UILabel.text = WU.GetString(ActorTypePrefix[actorConfig.kind]) .. WU.GetString("tag" .. actorTag.tag[1])
  end
end

function OnClick()
  if m_callback then
    m_callback(m_actorUid)
  end
end
