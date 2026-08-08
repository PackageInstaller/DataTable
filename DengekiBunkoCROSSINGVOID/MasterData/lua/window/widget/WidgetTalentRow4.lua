local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local HU = require("Common/HtmlUtil")
local m_hover = false
local m_actorInfo

function Start()
  WU.TraverseChildren(REF["$"], function(go, idx)
    if idx < 4 then
      WU.BindPressEvent(go, function(go)
        SetTalentDescribe(go, idx)
      end)
    end
  end)
end

function DisableAll()
  WU.TraverseChildren(REF["$"], function(go)
    go.gameObject:SetActive(false)
  end)
end

function SetTalentBig(actorInfo)
  DisableAll()
  if actorInfo ~= nil then
    local talents = actorInfo.talentInfo
    for i = 0, #REF["$"] - 1 do
      local talentSlot = REF["$"][i]
      WU.ToggleRendering(talentSlot["$gameObject"], i < #talents)
      if i < #talents then
        local talentId = talents[i + 1].talentId
        local talentValue = talents[i + 1].talentValue
        local data = AU.GetTalentDisplayInfo(talentId, talentValue)
        AU.SetTalentBG(_ENV["$"](talentSlot.SpriteTalentBGNode), data.bgIdx, data.isRatio)
        talentSlot.LabelTitle.UIHtmlLabel.text = data.talentName
        if data.talentIcon ~= nil then
          talentSlot.TextureTalent.UITexture.mainTexturePath = "Texture/ActorTalent/ActorTalent_" .. data.talentIcon
        else
          error("Talent", " missing TalentIcon in Localization_Talent postfix")
        end
      end
    end
    REF["$UIGrid"]:Reposition()
  end
end

function SetTalent(actorInfo, describe, compare, actorInfoComp, leftAlign, offTitle)
  DisableAll()
  if actorInfo ~= nil then
    if leftAlign then
      REF["$UIGrid"].pivot = CS.UIWidget.Pivot.Left
    else
      REF["$UIGrid"].pivot = CS.UIWidget.Pivot.Center
    end
    m_actorInfo = actorInfo
    local talent = actorInfo.talentInfo
    for i = 1, #talent do
      local talentRef = REF["$"][i - 1]
      talentRef["$gameObject"]:SetActive(true)
      local talentId = talent[i].talentId
      local talentValue = talent[i].talentValue
      local data = AU.GetTalentDisplayInfo(talentId, talentValue)
      AU.SetTalentBG(_ENV["$"](talentRef.SpriteTalentBGNode), data.bgIdx, data.isRatio)
      if not offTitle then
        talentRef.LabelTitle.UIHtmlLabel.text = data.talentName
      end
      if data.talentIcon ~= nil then
        talentRef.TextureTalent.UITexture.mainTexturePath = "Texture/ActorTalent/ActorTalent_" .. data.talentIcon
      else
        error("Talent", " missing TalentIcon in Localization_Talent postfix")
      end
      if describe then
        talentRef.LabelTalent.UIHtmlLabel.text = AU.GetActorTalentDesc(talent[i])
      end
    end
  end
end

function SetTalentDescribe(go, idx)
  if m_actorInfo ~= nil then
    if not m_hover then
      local talentId = m_actorInfo.talentInfo[idx + 1].talentId
      local talentValue = m_actorInfo.talentInfo[idx + 1].talentValue
      local data = AU.GetTalentDisplayInfo(talentId, talentValue)
      WU.ShowHoverTips(data.talentName, AU.GetActorTalentDesc(m_actorInfo.talentInfo[idx + 1]))
      m_hover = true
    else
      WU.HideHoverTips()
      m_hover = false
    end
  end
end
