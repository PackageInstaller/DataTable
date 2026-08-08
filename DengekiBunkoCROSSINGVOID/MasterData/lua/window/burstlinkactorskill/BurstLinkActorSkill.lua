local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local LU = require("Common/ListUtil")
local SE = require("Common/SkillEffect")
local m_actor, m_actors
local m_linkInfo = {}
local ActorTypePrefix = {
  "Window_ActorMainPrefix",
  "Window_ActorAssistPrefix"
}

function SetupWindow()
  LU.Bind(REF.RelationContent, {
    updateRow = UpdateSlot
  })
end

function InitWindow()
  m_actor = nil
  m_actors = nil
  m_linkInfo = {}
end

function SetActor(actor)
  m_actor = actor
  SetActorSkills()
  SetRelationSkills()
end

function SetActorSkills()
  if m_actor then
    local actorConfig = PB.get("ActorConfig", m_actor.id)
    if actorConfig then
      SetActorHeadline(actorConfig)
      REF.MainActorSkills.gameObject:SetActive(actorConfig.kind == PB.enum.ActorType.Main)
      REF.SubActorSkills.gameObject:SetActive(actorConfig.kind == PB.enum.ActorType.Sub)
      local skills = SE.GetActorSkills(m_actor.id)
      local skillLevel = 1
      if actorConfig.kind == PB.enum.ActorType.Main then
        for i = 1, #REF.Grid do
          if skills and i <= #skills then
            skillLevel = SE.GetSkillLevel(m_actor, skills[i].skillId)
            WU.ToggleRendering(REF.Grid[i - 1]["$gameObject"], true)
            REF.Grid[i - 1]["$$SetData"](m_actor, skills[i], skillLevel)
          else
            WU.ToggleRendering(REF.Grid[i - 1]["$gameObject"], false)
          end
        end
        REF.Grid.UIGrid:Reposition()
      elseif skills and 1 <= #skills then
        skillLevel = SE.GetSkillLevel(m_actor, skills[1].skillId)
        SetSubActorSkill(skills[1], skillLevel)
      end
    end
  end
end

function SetSubActorSkill(actorSkill, skillLevel)
  local skillData = SE.GetSkillDescBySkillLevel(m_actor, actorSkill, skillLevel, "#72e6ff")
  if skillData then
    local actorCombo = SE.GetActorSkillCombo(actorSkill.skillId)
    local skillCost = SE.GetActorSkillCost(actorSkill.skillId)
    REF.TextureSubSkill.UITexture.mainTexturePath = skillData.mainTexturePath
    REF.LabelSubSkillLevel.UILabel.text = WU.GetString("Window_Level", skillLevel)
    REF.LabelSubSkillName.UILabel.text = skillData.skillName
    local nodeRef = _ENV["$"](REF.SubActorSkills)
    nodeRef.WidgetTagSkillCost["$SetSkillCost"](skillCost.costSp, skillCost.costMp)
    nodeRef.WidgetTagSkillKind["$SetKind"](actorCombo.kindIcon)
    REF.LabelSubSkillDesc.UIHtmlLabel.text = skillData.describe or ""
  end
end

function SetRelationSkills()
  if m_actor then
    m_linkInfo = AU.GetActorLinkInfo(m_actor.id)
    REF.NodeEmptyRelation.gameObject:SetActive(#m_linkInfo <= 0)
    REF.RelationList.gameObject:SetActive(0 < #m_linkInfo)
    LU.Set(REF.RelationContent, #m_linkInfo)
  end
end

function SetActorForShow(actor)
  m_actor = actor
  SetActorSkills()
  SetRelationSkills()
end

function SetActorHeadline(actorConfig, actor)
  REF.SpriteQuality.UISprite.color = CS.NGUIMath.HexToColor(2661925119)
  _ENV["$"](REF.Top).TextureActor.UITexture.mainTexturePath = "Texture/ActorSkillHead/actor_skill_head_" .. actorConfig.animRes
  _ENV["$"](REF.Top).TextureActorADD.UITexture.mainTexturePath = "Texture/ActorSkillHead/actor_skill_head_" .. actorConfig.animRes
  REF.SpriteActorType.UISprite.spriteName = "actor_type_" .. m_actor.id
  REF.SpriteActorName.UISprite.spriteName = "actor_name_" .. actorConfig.animRes
  local actorTag = PB.get("ActorTag", m_actor.id)
  REF.LabelCharactorType.UILabel.text = WU.GetString(ActorTypePrefix[actorConfig.kind]) .. WU.GetString("tag" .. actorTag.tag[1])
end

function UpdateSlot(rowRef, wrapIndex, realIndex)
  local itemIndex = realIndex + 1
  if m_linkInfo and itemIndex <= #m_linkInfo then
    local slotRef = rowRef["$"][0]
    slotRef["$$SetData"](m_linkInfo[itemIndex], m_actor)
  end
end
