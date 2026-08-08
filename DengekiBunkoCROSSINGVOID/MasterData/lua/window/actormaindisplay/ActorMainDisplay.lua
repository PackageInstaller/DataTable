local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local SE = require("Common/SkillEffect")
local BGName = {
  "role_bg",
  "role_bg_sub"
}
local ActorTypePrefix = {
  "Window_ActorMainPrefix",
  "Window_ActorAssistPrefix"
}
local m_repeatedContext = {}
local m_actorUid = 0
local m_actor, m_HasSkillUpgrade, m_HasStarUpgrade, m_compActorInfo, m_displayInfo

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonEquip, function(go)
    WU.AcquireWindowAsync("ActorInfoDisplay", function(window)
      _ENV["$"](window)["$$SetSelectedTab"]("TabEquipDisplay")
    end)
  end)
  WU.BindButtonEvent(REF.ButtonTalent, function(go)
    WU.AcquireWindowAsync("ActorInfoDisplay", function(window)
      _ENV["$"](window)["$$SetSelectedTab"]("TabTalent")
    end)
  end)
  WU.BindButtonEvent(REF.ButtonRelation, function(go)
    WU.AcquireWindowAsync("ActorInfoDisplay", function(window)
      _ENV["$"](window)["$$SetSelectedTab"]("TabRelation")
    end)
  end)
  WU.BindButtonEvent(REF.ButtonSkill, function(go)
    WU.AcquireWindowAsync("ActorInfoDisplay", function(window)
      _ENV["$"](window)["$$SetSelectedTab"]("TabSkill")
    end)
  end)
end

function SaveContext(context)
  table.insert(m_repeatedContext, m_displayInfo)
end

function LoadContext(context)
  if 0 < #m_repeatedContext then
    local displayInfo = m_repeatedContext[#m_repeatedContext]
    table.remove(m_repeatedContext, #m_repeatedContext)
    this:SetData("Space/DisplayInfo", displayInfo)
  end
end

function Focus(on)
  if on then
    REF["$Animator"]:Play("Open", -1, 0)
  end
end

function InitWindow()
  this:Bind("Space/DisplayInfo", function(displayInfo)
    if displayInfo ~= nil then
      m_displayInfo = displayInfo
      local actor = displayInfo.actorInfo
      local equips = displayInfo.equips
      REF.WidgetActorRoller["$SetAllowRoller"](false)
      REF.WidgetActorRoller["$SetRollerActor"](actor)
      OnActorChange(actor)
      OnEquipChange(equips)
    end
  end)
end

function UpdateActorCompare(actor, actorComp)
  local levelSumComp
  if actorComp ~= nil then
    levelSumComp = SE.GetSkillCount(actorComp)
  end
  local curLevelSum = SE.GetSkillCount(m_actor)
  _ENV["$"](REF.ButtonSkill).LabelNumber.UILabel.text = curLevelSum
  local levelComp
  if actorComp ~= nil then
    levelComp = actorComp.level
  end
  local maxActorLevel = AU.GetActorMaxLevel()
  local reachMaxLevel = maxActorLevel <= actor.level
  REF.LabelActorLevel.UILabel.text = WU.GetString("Window_Level", actor.level)
end

function SetActor(actor)
  m_actor = actor
  UpdateActorCompare(actor, m_compActorInfo)
  REF.WidgetActorCardS["$SetActorCustom"](actor)
  REF.WidgetActorCardS["$ShowCustom"]({showActorInfo = false})
  REF.WidgetStarGridL["$SetStar"](actor.star, 0, true)
  local maxStar = PB.all("Misc"):first().maxStarLevel
  local isMaxStar = maxStar <= actor.star
  REF.LabelExp.gameObject:SetActive(not isMaxStar)
  REF.SpriteExpProgress.UISprite.spriteName = fif(isMaxStar, "levelup_bar_01", "levelup_bar_02")
  local actorConfig = PB.get("ActorConfig", actor.id)
  REF.TextureBG.UITexture.mainTexturePath = "Texture/Background/" .. BGName[actorConfig.kind]
  local actorTag = PB.get("ActorTag", actor.id)
  REF.LabelCharactorType.UILabel.text = WU.GetString(ActorTypePrefix[actorConfig.kind]) .. WU.GetString("tag" .. actorTag.tag[1])
  REF.SpriteSub.gameObject:SetActive(actorConfig.kind == PB.enum.ActorType.Sub)
  REF.SpriteSub.UISprite.spriteName = "rolelist_sub_s_" .. actor.quality
  REF.SpriteActorType.UISprite.spriteName = "actor_type_" .. actor.id
  REF.SpriteActorName.UISprite.spriteName = "actor_name_" .. actorConfig.animRes
  REF.LabelCV.UILabel.text = WU.GetString("ActorCV_" .. actor.id)
  REF.SpriteQualityBG.UISprite.spriteName = "quality_" .. actor.quality
end

function OnActorChange(actor)
  if actor ~= nil and actor.id ~= 0 then
    local totalScore = AU.ActorTalentScore(actor)
    _ENV["$"](REF.ButtonTalent).LabelNumber.UILabel.text = totalScore
    SetActor(actor)
    local maxActorLevel = AU.GetActorMaxLevel()
    local reachMaxLevel = maxActorLevel <= actor.level
    if not reachMaxLevel then
      local actorLevelup = PB.get("ActorLevelup", actor.level + 1)
      REF.LabelExp.UILabel.text = actor.curExp .. "/" .. actorLevelup.exp
      REF.NodeExpProgressBar.UIProgressBar.value = actor.curExp / actorLevelup.exp
    else
      REF.NodeExpProgressBar.UIProgressBar.value = 1
    end
  end
end

function OnEquipChange(equips)
  if equips then
    local equipScore = 0
    for _, equip in pairs(equips) do
      equipScore = equipScore + equip.level
    end
    _ENV["$"](REF.ButtonEquip).LabelNumber.UILabel.text = equipScore
    _ENV["$"](REF.ButtonEquip).Layout.UITable:Reposition()
  end
end
