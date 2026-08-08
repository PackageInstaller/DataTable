local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local HeadAtlas = {
  "ActorHead",
  "ActorHeadSub"
}
local m_actor, m_callback

function SetupWindow()
  REF.Black["$SetCallback"](function()
    WU.RecycleWindow(this)
  end)
end

function UninitWindow()
  if m_callback then
    m_callback()
    m_callback = nil
  end
end

function SetData(actor, callback)
  m_actor = actor
  m_callback = callback
  if m_actor then
    local actorConfig = PB.get("ActorConfig", m_actor.id)
    local refOld = _ENV["$"](REF.NodeOld)
    refOld.SpriteActor.UISprite.atlasPath = HeadAtlas[actorConfig.kind]
    refOld.SpriteActor.UISprite.spriteName = "actor_head_" .. actorConfig.animRes
    refOld.SpriteActorBG.UISprite.spriteName = "role_bg_" .. actor.quality - 1
    local refNew = _ENV["$"](REF.NodeNew)
    refNew.SpriteActor.UISprite.atlasPath = HeadAtlas[actorConfig.kind]
    refNew.SpriteActor.UISprite.spriteName = "actor_head_" .. actorConfig.animRes
    refNew.SpriteActorBG.UISprite.spriteName = "role_bg_" .. actor.quality
  end
end
