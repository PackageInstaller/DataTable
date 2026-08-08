local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local SE = require("Common/SkillEffect")

function SetData(actorLink, hostActor)
  REF.LabelName.UILabel.text = WU.GetString("Window_ActorLinkName_" .. actorLink.linkID)
  local slogonText = WU.GetString("Window_ActorLinkSlogon_" .. actorLink.linkID)
  if slogonText ~= "" then
    slogonText = slogonText .. "\n"
  end
  REF.LabelSlogon.UILabel.text = slogonText
  REF.LabelDesc.UIHtmlLabel.text = AU.GetActorLinkDesc(actorLink.linkID, nil, "#72e6ff", nil, nil, true)
  REF.WidgetTagSkillCost["$SetSkillCost"](actorLink.costSp, actorLink.costMp)
  REF.WidgetTagSkillKind["$SetKind"](actorLink.kindIcon)
  REF.SpriteLinkBG.UISprite.spriteName = fif(actorLink.costSp > 0, "skill_strong", "skill_normal")
  for _, link in pairs(actorLink.link) do
    local actorConfig = PB.get("ActorConfig", link.actorID)
    REF["TextureHead" .. actorConfig.kind].UITexture.mainTexturePath = "Texture/ActorHeadBig/actor_head_big_" .. actorConfig.animRes
  end
  REF.TextureLink.UITexture.mainTexturePath = "Texture/ActorRelationSkill/actor_relation_" .. actorLink.linkID
  REF.NodeGuest.gameObject:SetActive(0 < #actorLink.guestActorIds)
  if 0 < #actorLink.guestActorIds then
    for i = 0, #REF.GuestGrid - 1 do
      local slotRef = REF.GuestGrid[i]
      local guestActorId = actorLink.guestActorIds[i + 1]
      slotRef["$gameObject"]:SetActive(guestActorId and 0 < guestActorId)
      if guestActorId and 0 < guestActorId then
        local actorConfig = PB.get("ActorConfig", guestActorId)
        slotRef["$UISprite"].spriteName = "role_bg_0"
        slotRef.SpriteActor.UISprite.spriteName = "actor_head_" .. actorConfig.animRes
      end
    end
  end
end

function ShowCustomRelationSlot(data)
  REF.SpriteDecoration.gameObject:SetActive(data.showBg ~= nil and data.showBg)
end
