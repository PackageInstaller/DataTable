local WU, DB, REF = require("Common/WindowUtil")(this)
local TU = require("Common/TextUtil")
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local HU = require("Common/HtmlUtil")
local SE = require("Common/SkillEffect")
local m_actor, m_displayIndex, m_skills, m_skillDetail
local m_shadowIndex = 1
local m_materials = {}
local m_materialsEnough = {}

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonLevelup, OnLevelup)
  WU.BindButtonEvent(REF.BtnLeft, function()
    WU.RecordButtonClick(105054)
    OnNavigateSkill(-1)
  end)
  WU.BindButtonEvent(REF.BtnRight, function()
    WU.RecordButtonClick(105055)
    OnNavigateSkill(1)
  end)
  for i = 0, #REF.SkillBadgeGrid - 1 do
    CS.EventDelegate.Add(REF.SkillBadgeGrid[i]["$UIToggle"].onChange, function()
      if CS.UIToggle.current.value then
        m_shadowIndex = CS.UIToggle.current.transform:GetSiblingIndex() + 1
        UpdateDisplay()
      end
    end)
  end
end

function InitWindow()
  this:Bind("Skill/DisplayIndex", OnDisplayIndexChange)
  this:Bind("ActorInfo/CurrentActor", OnCurrentActorChange)
end

function UninitWindow()
  m_actor = nil
  m_displayIndex = nil
  m_skills = nil
  m_skillDetail = nil
  m_materials = {}
  m_materialsEnough = {}
end

function OnNavigateSkill(deltaIndex)
  local index = m_displayIndex - 1
  index = index + deltaIndex
  if index < 0 then
    index = index + #m_skills
  else
    index = index % #m_skills
  end
  this:SetData("Skill/DisplayIndex", index + 1)
end

function OnDisplayIndexChange(displayIndex)
  m_displayIndex = displayIndex or 1
  m_shadowIndex = 1
  UpdateSkillDetail()
end

function OnCurrentActorChange(actor)
  local resetShadowIndex = m_actor and actor and m_actor.uid ~= actor.uid
  m_actor = actor
  if m_actor then
    m_skills = SE.GetActorSkills(m_actor.id)
    if resetShadowIndex then
      m_shadowIndex = 1
    end
    UpdateSkillDetail()
  end
end

function UpdateSkillDetail()
  if m_skills and m_displayIndex then
    local skillGroup = m_skills[m_displayIndex]
    m_skillDetail = SE.GetSkillDetail(m_actor, skillGroup, "#72e6ff")
    local shadowSkillCount = #skillGroup
    WU.SetActive(REF.NodeShadowSkillList, 1 < shadowSkillCount)
    if 1 < shadowSkillCount then
      for i = 0, #REF.SkillBadgeGrid - 1 do
        WU.SetActive(REF.SkillBadgeGrid[i]["$"], i < shadowSkillCount)
      end
      REF.SpriteLine.UISprite.width = REF.SkillBadgeGrid.UIGrid.cellWidth * (shadowSkillCount - 1)
      REF.SkillBadgeGrid.UIGrid:Reposition()
    end
    UpdateDisplay()
  end
end

function UpdateDisplay()
  if m_skills then
    local skillGroup = m_skills[m_displayIndex]
    local skill = skillGroup[m_shadowIndex]
    if 1 < #skillGroup and not REF.SkillBadgeGrid[m_shadowIndex - 1]["$UIToggle"].value then
      REF.SkillBadgeGrid[m_shadowIndex - 1]["$UIToggle"].value = true
    end
    local actorConfig = PB.get("ActorConfig", m_actor.id)
    REF.SpriteBG.UISprite.spriteName = fif(skill.isPassive, "skill_passive", "skill_normal")
    if SE.IsSuperSkill(skill) then
      REF.SpriteBG.UISprite.spriteName = "skill_strong"
    end
    local unlocked, unlockStarCount = SE.IsSkillUnlocked(m_actor, skill)
    if unlocked then
      REF.LabelLevel.UILabel.text = WU.GetString("Window_Level", m_skillDetail.skillLevel)
    else
      REF.LabelLevel.UILabel.text = ""
      REF.WidgetStarGridMUnlock["$SetStar"](unlockStarCount, nil, true)
    end
    WU.SetActive(REF.NodeLockMask, not unlocked)
    REF.LabelSkillName.UILabel.text = m_skillDetail.skillNames[m_shadowIndex]
    REF.TextureSkill.UITexture.mainTexturePath = m_skillDetail.mainTexturePaths[m_shadowIndex]
    REF.LabelCurrentDesc.UIHtmlLabel.text = m_skillDetail.describes[m_shadowIndex] or ""
    if skill.isPassive then
      REF.WidgetTagSkillKind["$SetPassive"]()
    else
      REF.WidgetTagSkillKind["$SetSkillKind"](skill.skillId)
    end
    REF.NodeUpgrade.gameObject:SetActive(not m_skillDetail.isMax and unlocked)
    REF.NodeLocked.gameObject:SetActive(not unlocked)
    REF.NodeMax.gameObject:SetActive(unlocked and m_skillDetail.isMax)
    if not m_skillDetail.isMax and unlocked then
      REF.LabelNextDesc.UIHtmlLabel.text = m_skillDetail.nextDescribes[m_shadowIndex] or ""
      REF.LabelCost.ResourcePrinter:SetResource(m_skillDetail.levelupCosts[1].type, 0, m_skillDetail.levelupCosts[1].count)
      REF.WidgetStarGridMLevelup["$SetStar"](m_skillDetail.nextLevelStar, nil, true)
      REF.LabelLimitTitle.UILabel.color = CS.NGUIMath.HexToColor(fif(m_actor.star >= m_skillDetail.nextLevelStar, 4294967295, 4250162431))
      local materials = {}
      for i = 2, #m_skillDetail.levelupCosts do
        table.insert(materials, m_skillDetail.levelupCosts[i])
      end
      UpdateMaterialList(materials)
    end
    REF.WidgetTagSkillCost.gameObject:SetActive(not skill.isPassive)
    if not skill.isPassive then
      local skillCost = SE.GetActorSkillCost(skill.skillId)
      REF.WidgetTagSkillCost["$SetSkillCost"](skillCost.costSp, skillCost.costMp)
    end
  end
end

function UpdateMaterialList(materials)
  for i = 1, #REF.MaterialList do
    local materialtSlotRef = REF.MaterialList[i - 1]
    local widgetRef = _ENV["$"](materialtSlotRef.WidgetIconSlot)
    materialtSlotRef["$gameObject"]:SetActive(i <= #materials)
    m_materialsEnough[i] = nil
    if m_materials[i] ~= materials[i] then
      if m_materials[i] then
        widgetRef["@id"] = nil
        this:Unbind("fci/item/" .. m_materials[i].id, UpdateMaterialSlot)
      end
      m_materials[i] = materials[i]
      if m_materials[i] then
        widgetRef["@id"] = m_materials[i].id
        widgetRef["$$SetData"](PB.enum.ResourceType.ResItem, m_materials[i].id)
        widgetRef["$$SetClickCallback"](function(go)
          WU.RecordButtonClick(105053)
          WU.ShowItemDetail(_ENV["$"](go)["@id"])
        end)
        this:Bind("fci/item/" .. m_materials[i].id, UpdateMaterialSlot)
      end
    end
  end
  REF.LabelCostTitle2.gameObject:SetActive(0 < #m_materials)
  REF.MaterialList.UIGrid:Reposition()
end

function UpdateMaterialSlot(item)
  if item then
    local index, material = table.find(m_materials, function(k, v)
      return v.id == item.id
    end)
    if material then
      local stockString = tostring(item.count)
      local costString = tostring(material.count)
      if item.count < material.count then
        stockString = HU.ApplyFontColor(stockString, HU.ColorDefines.Error)
      end
      m_materialsEnough[index] = item.count >= material.count
      REF.MaterialList[index - 1].StackLabel.UIHtmlLabel.text = stockString .. "/" .. costString
    end
  end
end

function OnLevelup()
  WU.RecordButtonClick(105052)
  if m_skillDetail and not m_skillDetail.isMax then
    if m_skillDetail.isLevelLimit then
      WU.ShowMessageYesNo(WU.GetString("Window_LevelupError_StarLevelLimit"), function(result)
        if result == "YES" then
          WU.RecycleWindow(this)
          this:BroadcastGameEvent("EventSwitchTab", "TabStar")
        end
      end)
    else
      local materialNotEnough = table.find(m_materialsEnough, function(k, v)
        return v == false
      end)
      if materialNotEnough then
        WU.ShowHintText(WU.GetString("Window_LevelupMaterialInsufficient"))
      else
        WU.TryToPay(m_skillDetail.levelupCosts[1].type, 0, m_skillDetail.levelupCosts[1].count, LevelupRequest)
      end
    end
  end
end

function LevelupRequest()
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_SkillLevelUp")
  this:GameRequest("/fci/actor/" .. m_actor.uid .. "/skilllearnning/"):Post({
    skillId = m_skillDetail.skillIds[1]
  }, function(result)
    REF.EffectSuccess.EffectGenerator:Play()
    REF.EffectSuccessBG.EffectGenerator:Play()
    DBH.ResChange(result.resChange)
  end)
end

function Focus()
  WU.RecordWindowFocus(100105, true)
end
