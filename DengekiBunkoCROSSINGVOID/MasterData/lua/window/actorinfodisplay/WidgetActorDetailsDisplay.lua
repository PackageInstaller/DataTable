local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("Common/HtmlUtil")
local m_actor, m_roleId, m_collectionsActor
local m_attrIndices = {
  25,
  0,
  1,
  3,
  5,
  14,
  6,
  13
}

function Start()
end

function OnEnable()
  this:Bind("ActorInfo/CurrentActor", OnCurrentActorChange)
  this:Bind("ActorInfo/CurrentActorDisplay", OnCurrentActorChange)
  REF["$Animator"]:Play("Open", -1, 0)
end

function OnDisable()
  this:Unbind("ActorInfo/CurrentActor", OnCurrentActorChange)
  this:Unbind("ActorInfo/CurrentActorDisplay", OnCurrentActorChange)
  if m_roleId then
    m_roleId = nil
  end
end

function OnCurrentActorChange(actor)
  if m_roleId then
    m_roleId = nil
  end
  m_actor = actor
  if m_actor then
    UpdateAttributes()
    UpdateAura()
    UpdateTags()
    m_roleId = PB.get("ActorConfig", m_actor.id).role
  end
end

function OnCollectionsActorChange(collectionsActor)
  m_collectionsActor = collectionsActor
  UpdateScore()
end

function UpdateAttributes()
  REF.LabelAttributes.UIHtmlLabel.text = RenderAttrList(AU.NormalizeAttrs(m_actor.attrs), AU.NormalizeAttrs(m_actor.equipAttrs))
end

function RenderAttrList(actorAttrs, equipAttrs)
  local result = "<l width=100% valign=center>"
  local column = 0
  for i = 1, #m_attrIndices do
    if 1 < column then
      result = result .. "</l>" .. HU.HtmlSplitLine("Common.Line_dark") .. "<l width=100% valign=center>"
      column = 0
    end
    if column == 1 then
      result = result .. "<c width=12%></c>"
    end
    local attrType = m_attrIndices[i]
    if 0 < attrType then
      local attrName = WU.GetString("Window_ActorAttrName_" .. attrType)
      local actorAttr = actorAttrs[attrType]
      local equipAttr = equipAttrs[attrType]
      local actorAttrValue = U.FormatAttrValue({
        type = actorAttr.type,
        isRatio = actorAttr.isRatio,
        value = actorAttr.value - equipAttr.value
      })
      local equipAttrValue = U.FormatAttrValue(equipAttr)
      local icon = "<img src='ActorUI.attr_type_" .. attrType .. "'/>&nbsp;&nbsp;"
      local attrString = "<c width=20% align=left>" .. icon .. attrName .. "</c>"
      attrString = attrString .. "<c width=10% align=right>" .. actorAttrValue .. "</c>"
      attrString = attrString .. "<font color=#0199E9><c width=4% align=right>+</c>"
      attrString = attrString .. "<c width=10% align=right><i>" .. equipAttrValue .. "</i></c></font>"
      result = result .. attrString
    end
    column = column + 1
  end
  result = result .. "</l>"
  return result
end

function UpdateAura()
  local actorQualityInfo = PB.get("ActorQualityInfo", m_actor.id, m_actor.quality)
  REF.LabelAura.UIHtmlLabel.text = AU.RenderAuraOrMedalAttr(actorQualityInfo, true)
end

function UpdateScore()
  if m_roleId and m_collectionsActor then
    local score = AU.CalculateRoleScore(m_collectionsActor.actors)
    local roleScoreAttrs = PB.all("RoleScoreAttr"):where(function(k, v)
      return v.id == m_roleId and v.score <= score
    end):toarray()
    table.sort(roleScoreAttrs, function(a, b)
      return a.score > b.score
    end)
    REF.LabelScore.UILabel.text = tostring(score)
    local scoreAttrAdditionText = ""
    if 0 < #roleScoreAttrs then
      scoreAttrAdditionText = WU.GetString("Window_BaseAttrAddition", U.FormatAttrValue(roleScoreAttrs[1].attrs[1]))
    end
    REF.LabelScoreAddition.UIHtmlLabel.text = scoreAttrAdditionText
  end
end

function UpdateTags()
  local actorTag = PB.get("ActorTag", m_actor.id)
  local j = 1
  local i = 1
  while i <= #REF.NodeTags do
    local tag = actorTag.tag[j]
    local tagRef = REF.NodeTags[i - 1]
    tagRef["$gameObject"]:SetActive(false)
    if tag then
      local actorTagInfo = PB.get("ActorTagInfo", tag)
      if actorTagInfo.displayTag then
        tagRef["$gameObject"]:SetActive(true)
        tagRef.TagType.UISprite.spriteName = "actor_type_tag_" .. tag
        tagRef.TagSprite.UISprite.spriteName = "actor_tag_1"
        if actorTagInfo and actorTagInfo.displayTag then
          tagRef.TagSprite.UISprite.spriteName = "actor_tag_" .. actorTagInfo.color
        else
          warning("ActorTagInfo.xlsx", "tag not found : " .. tostring(tag))
        end
        tagRef.TagLabel.UILabel.text = WU.GetString("tag" .. tag)
        i = i + 1
      end
      j = j + 1
    else
      i = i + 1
    end
  end
end
