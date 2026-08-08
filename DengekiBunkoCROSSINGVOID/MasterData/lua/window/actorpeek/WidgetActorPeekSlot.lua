local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local SE = require("Common/SkillEffect")
local AU = require("Common/ActorUtil")
local m_actor, m_data, m_skillDetail
local m_shadowIndex = 1

function Start()
  WU.BindButtonEvent(REF.ButtonPrev, function()
    OnNavigateShadow(-1)
  end)
  WU.BindButtonEvent(REF.ButtonNext, function()
    OnNavigateShadow(1)
  end)
end

function OnNavigateShadow(deltaIndex)
  if m_data and 0 < #m_data then
    local index = m_shadowIndex - 1
    index = index + deltaIndex
    if index < 0 then
      index = index + #m_data
    else
      index = index % #m_data
    end
    m_shadowIndex = index + 1
    UpdateSkill()
  end
end

function SetData(actor, data)
  m_actor = actor
  m_data = data
  if m_actor and m_data then
    local isSkill = 0 < #m_data
    WU.SetActive(REF.NodeSkill, isSkill)
    WU.SetActive(REF.NodeLink, not isSkill)
    if isSkill then
      m_shadowIndex = 1
      m_skillDetail = SE.GetSkillDetail(m_actor, m_data, "#1bb4fc")
      WU.SetActive(REF.NodeShadow, 1 < #m_data)
      UpdateSkill()
    else
      UpdateLink()
    end
  end
end

function UpdateSkill()
  local skill = m_data[m_shadowIndex]
  local skillCost = SE.GetActorSkillCost(skill.skillId)
  local bgName = "skill_normal"
  if SE.IsSuperSkill(skill) then
    bgName = "skill_strong"
  end
  REF.SpriteSkillBG.UISprite.spriteName = bgName
  REF.TextureSkill.UITexture.mainTexturePath = m_skillDetail.mainTexturePaths[m_shadowIndex]
  REF.LabelSkillCost.UIHtmlLabel.text = fif(skillCost.costSp > 0, WU.GetString("Window_SkillCostSp", skillCost.costSp), WU.GetString("Window_SkillCostMp", skillCost.costMp))
  REF.SpriteSkillType.UISprite.spriteName = "skill/" .. m_skillDetail.kindIcons[m_shadowIndex]
  REF.LabelSkillLevel.UILabel.text = WU.GetString("Window_Level", m_skillDetail.skillLevel)
  REF.LabelSkillDesc.UIHtmlLabel.text = m_skillDetail.describes[m_shadowIndex]
end

function UpdateLink()
  for _, link in pairs(m_data.link) do
    local actorConfig = PB.get("ActorConfig", link.actorID)
    REF["TextureHead" .. actorConfig.kind].UITexture.mainTexturePath = "Texture/ActorHeadBig/actor_head_big_" .. actorConfig.animRes
  end
  REF.SpriteLinkBG.UISprite.spriteName = fif(m_data.costSp > 0, "skill_strong", "skill_normal")
  REF.TextureLink.UITexture.mainTexturePath = "Texture/ActorRelationSkill/actor_relation_" .. m_data.linkID
  REF.LabelLinkCost.UIHtmlLabel.text = fif(m_data.costSp > 0, WU.GetString("Window_SkillCostSp", m_data.costSp), WU.GetString("Window_SkillCostMp", m_data.costMp))
  REF.SpriteLinkType.UISprite.spriteName = "skill/" .. m_data.kindIcon
  REF.LabelLinkDesc.UIHtmlLabel.text = AU.GetActorLinkDesc(m_data.linkID, nil, "#1bb4fc")
end
