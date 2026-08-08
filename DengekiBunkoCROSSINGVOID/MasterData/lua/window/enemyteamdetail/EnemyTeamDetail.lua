local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GroupUtil")
local HU = require("Common/HtmlUtil")
local m_dungeonId, m_dungeonMonster, m_setGuildValidate

function InitWindow()
  m_setGuildValidate = false
  for i = 0, #REF.ListEffect - 1 do
    REF.ListEffect[i]["$gameObject"]:SetActive(false)
  end
  m_dungeonId = this:GetData("WindowDungeon/DungeonId")
  m_dungeonMonster = PB.get("DungeonMonster", m_dungeonId)
  UpdateUI()
end

function Focus(on)
  if m_setGuildValidate then
    local guildId = this:GetData("guildId")
    DungeonGuild_ValidateRestrictions(guildId)
  end
end

function SetGuildValidate()
  m_setGuildValidate = true
  this:Bind("guildId", DungeonGuild_ValidateRestrictions)
end

function UpdateUI()
  if m_dungeonMonster == nil then
    error("no dungeonId " .. m_dungeonId .. " in DungeonMonster! ")
  else
    SetTeamEffect()
    SetActor()
  end
end

function SetTeamEffect()
  local affixList = _ENV["!"]({})
  affixList:append(m_dungeonMonster.team1Affix)
  affixList:append(m_dungeonMonster.team2Affix)
  affixList = affixList:distinct()
  local affixCount = #affixList
  REF.NodeEmpty.gameObject:SetActive(affixCount == 0)
  REF.ListEffect.gameObject:SetActive(affixCount ~= 0)
  if affixCount == 0 then
    return
  end
  local textPlayer = WU.GetString("Window_OurSide")
  local textEnemy = WU.GetString("Window_EnemySide")
  local index = 0
  for _, affix in pairs(affixList) do
    local affixName = WU.GetString("AffixTitle_" .. affix)
    local affixDesc = WU.GetString("AffixDesc_" .. affix)
    local bAimedAtSelf = false
    local affixAim = ""
    if table.has(m_dungeonMonster.team1Affix, affix) then
      affixAim = affixAim .. textPlayer
      bAimedAtSelf = true
    end
    if table.has(m_dungeonMonster.team2Affix, affix) then
      if bAimedAtSelf then
        affixAim = affixAim .. "/"
      end
      affixAim = affixAim .. textEnemy
    end
    if index < 3 then
      REF.ListEffect[index]["$UIHtmlLabel"].text = WU.GetString("Window_BuffDescribeFormat", affixDesc, affixAim)
      REF.ListEffect[index]["$gameObject"]:SetActive(true)
    end
    index = index + 1
  end
end

function SetActor()
  local actors = GU.MonsterGroup(m_dungeonMonster.monsterId)
  local showTypeList = m_dungeonMonster.showType or {}
  local refCount = #REF.ListEnemy
  for i = 0, refCount - 1 do
    local ref = REF.ListEnemy[i]
    local mainIndex = refCount - i
    local subIndex = 2 * refCount - i
    local mainActor = actors[mainIndex]
    local subActor = actors[subIndex]
    local hasMainActor = mainActor and mainActor.id and 0 < mainActor.id
    if hasMainActor then
      local actorConfig = PB.get("ActorConfig", mainActor.id)
      _ENV["$"](ref.MainActor).SpriteActor.UISprite.spriteName = "actor_head_" .. actorConfig.animRes
      _ENV["$"](ref.MainActor).SpriteQuality.UISprite.spriteName = "role_bg_0"
      _ENV["$"](ref.MainActor).SpriteQuality.UISprite.alpha = 1
      _ENV["$"](ref.MainActor).SpriteDanger.gameObject:SetActive(showTypeList[mainIndex] and showTypeList[mainIndex] ~= 0)
    else
      _ENV["$"](ref.MainActor).SpriteActor.UISprite.spriteName = ""
      _ENV["$"](ref.MainActor).SpriteQuality.UISprite.spriteName = "icon_bg_blank"
      _ENV["$"](ref.MainActor).SpriteQuality.UISprite.alpha = 0.3
      _ENV["$"](ref.MainActor).SpriteDanger.gameObject:SetActive(false)
    end
    local hasSubActor = subActor and subActor.id and 0 < subActor.id
    if hasSubActor then
      local actorConfig = PB.get("ActorConfig", subActor.id)
      _ENV["$"](ref.SubActor).SpriteActor.UISprite.spriteName = "actor_head_" .. actorConfig.animRes
      _ENV["$"](ref.SubActor).SpriteQuality.UISprite.spriteName = "role_bg_0"
      _ENV["$"](ref.SubActor).SpriteQuality.UISprite.alpha = 1
      _ENV["$"](ref.SubActor).SpriteDanger.gameObject:SetActive(showTypeList[subIndex] and showTypeList[subIndex] ~= 0)
    else
      _ENV["$"](ref.SubActor).SpriteActor.UISprite.spriteName = ""
      _ENV["$"](ref.SubActor).SpriteQuality.UISprite.spriteName = "icon_bg_blank"
      _ENV["$"](ref.SubActor).SpriteQuality.UISprite.alpha = 0.3
      _ENV["$"](ref.SubActor).SpriteDanger.gameObject:SetActive(false)
    end
    _ENV["$"](ref.SubActor).SpriteIsSub.gameObject:SetActive(hasSubActor)
    local mainLevel = m_dungeonMonster.level[mainIndex] or 0
    local mainId = m_dungeonMonster.monsterId[mainIndex] or 0
    local mainIndex = m_dungeonMonster.levelUpIndex[mainIndex] or 0
    local mainbRet = WU.GetMonsterAttr(mainId, mainLevel, mainIndex)
    local speed = 0
    if mainbRet and mainbRet[PB.enum.AttrType.Speed] and mainbRet[PB.enum.AttrType.Speed].value ~= 0 then
      speed = mainbRet[PB.enum.AttrType.Speed].value
    end
    ref.NodeLevel.gameObject:SetActive(mainLevel ~= 0)
    ref.NodeSpeed.gameObject:SetActive(mainLevel ~= 0)
    if mainLevel ~= 0 then
      ref.LabelLevel.UILabel.text = "Lv." .. tostring(math.floor(mainLevel / 5))
      ref.LabelSpeed.UILabel.text = speed
    end
  end
end

function DungeonGuild_ValidateRestrictions(guildId)
  local top = WU.TopWindow()
  if top and top.name == this.name and guildId == 0 then
    if not this:GetData("GuildQuitNotified") then
      this:SetData("GuildQuitNotified", true)
      WU.ShowMessageOK(WU.GetString("Window_JustQuitGuild"), function(result)
        local top = WU.TopWindow()
        if top and top.name == this.name then
          WU.RecycleWindow(this)
        end
      end)
    else
      WU.RecycleWindow(this)
    end
  end
end
