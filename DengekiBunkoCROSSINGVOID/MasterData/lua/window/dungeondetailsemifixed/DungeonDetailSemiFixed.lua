local BASE = inherit("Window/DungeonPrepareBase/DungeonPrepareBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local LU = require("Common/ListUtil")
local BuffBGHeight = {
  [0] = 177,
  [1] = 310,
  [2] = 445,
  [3] = 580
}
local BuffCnt = 3
local m_dungeonId, m_reward
local m_repeatedContext = {}

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonFight, OnButtonFightClick)
  BASE.BindDrop()
  WU.BindButtonEvent(REF.TouchInfo, function()
    if m_dungeonId then
      REF.PanelBuff.gameObject:SetActive(not REF.PanelBuff.gameObject.activeSelf)
      if REF.PanelBuff.gameObject.activeSelf == true then
        ShowBuff(m_dungeonId)
      end
    end
  end)
  WU.BindButtonEvent(REF.SpriteHelp, function()
    REF.HelpNode.gameObject:SetActive(not REF.HelpNode.gameObject.activeSelf)
    if REF.HelpNode.gameObject.activeSelf == true then
      ShowHelp()
    end
  end)
  WU.BindButtonEvent(REF.Carnival91Pass, function()
    WU.AcquireWindowAsync("Carnival91Pass")
  end)
end

function InitWindow()
  this:Bind("DungeonDetailSemiFixed/DungeonId", OnDungeonId)
  REF.Label1.UIHtmlLabel.text = WU.GetString("WindowTower_Prepare")
  WU.ToggleRendering(REF.LabelCost, false)
  REF.PanelBuff.gameObject:SetActive(false)
  REF.HelpNode.gameObject:SetActive(false)
  local dungeon = PB.get("DungeonMonster", m_dungeonId)
  if dungeon == nil then
    return
  end
  REF.SpriteHelp.gameObject:SetActive(dungeon.isShowHelp)
end

function SaveContext()
  table.insert(m_repeatedContext, {dungeonId = m_dungeonId})
end

function LoadContext()
  if 0 < #m_repeatedContext then
    local context = m_repeatedContext[#m_repeatedContext]
    this:SetData("DungeonDetailSemiFixed/DungeonId", context.dungeonId)
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
end

function OnDungeonId(dungeonId)
  if dungeonId then
    m_dungeonId = dungeonId
    m_reward = PB.get("DungeonReward", m_dungeonId)
    BASE.SetDrop(m_reward, m_reward.dropDisplay)
    BASE.ShowAffixList(m_dungeonId)
    local recordUri = "fci/activity/record/" .. PB.enum.ActivityType.Carnival91 .. "/{SemiFixed/ActivityId}/"
    this:Unbind(recordUri, OnRecords)
    this:BindRemote(DB:GameRequest(recordUri), OnRecords)
  end
end

function OnRecords(result)
  if result == nil then
    return
  end
  local records = result.records
  local _, record = table.find(records, function(_, v)
    return v.dungeonId == m_dungeonId
  end)
  if record then
    BASE.SetDungeonInfo(m_dungeonId, nil, record)
  else
    warning("DungeonDetailSemiFixed", "no record for dungeonId -> " .. tostring(m_dungeonId))
  end
end

function ShowHelp()
  local dunID = m_dungeonId
  if dunID then
    local dungeon = PB.get("DungeonMonster", dunID)
    REF.TipsMethonLabel.UIHtmlLabel.text = WU.GetString(string.format("RecommendDesc_%d", dungeon.recommendDesc))
    for i = 1, 3 do
      local refActor = REF.GameObjectRole[i - 1]
      local actorID = dungeon.recommendID[i]
      if actorID and actorID ~= 0 then
        refActor.root.gameObject:SetActive(true)
        refActor["$$SetData"](actorID)
      else
        refActor.root.gameObject:SetActive(false)
      end
    end
  end
end

function ShowBuff(dungeonId)
  local dungeon = PB.get("DungeonMonster", dungeonId)
  if dungeon == nil then
    error("no DungeonMonster for dungeonId:" .. tostring(dungeonId))
    return
  end
  InitEnemyAttr()
  if table.empty(dungeon.team1Affix) and table.empty(dungeon.team2Affix) then
    SetBuffVisible(0)
    return
  end
  local affixList = _ENV["!"]({})
  affixList:append(dungeon.team1Affix)
  affixList:append(dungeon.team2Affix)
  affixList = affixList:distinct()
  local player = WU.GetString("Window_OurSide")
  local enemy = WU.GetString("Window_EnemySide")
  local affixDescText = ""
  local index = 0
  for _, affix in pairs(affixList) do
    affixDescText = WU.GetString("AffixDesc_" .. affix) .. HU.HtmlSplitLine("Common.Line_dark")
    local desc = WU.GetString("AffixTitle_" .. affix) .. ":"
    local playerDesc = ""
    local playerOwn = false
    if table.has(dungeon.team1Affix, affix) then
      playerDesc = playerDesc .. player
      playerOwn = true
    end
    if table.has(dungeon.team2Affix, affix) then
      if playerOwn then
        playerDesc = playerDesc .. "/"
      end
      playerDesc = playerDesc .. enemy
    end
    local refBuff = _ENV["$"](REF[string.format("NodeBuff%d", index + 1)])
    if index < BuffCnt then
      refBuff.AffixTitleLabel.UIHtmlLabel.text = desc
      refBuff.AffixLabel.UIHtmlLabel.text = playerDesc
      refBuff.root.gameObject:SetActive(true)
      refBuff.AffixDescLabel.UIHtmlLabel.text = affixDescText
    end
    index = index + 1
  end
  SetBuffVisible(index)
end

function InitEnemyAttr()
  local dungeons = PB.get("DungeonMonster", m_dungeonId)
  local mainMonster = {}
  local assistMonster = {}
  local monsterList = {}
  local count = 0
  local hp = 0
  local speed = 0
  local index = 1
  local mainIndex = 1
  local subIndex = 4
  local mainMonsterLv = 0
  for i = 1, 6 do
    local monsterID = 0
    local monsterLv = 0
    local monsterIndex = 0
    count = count + 1
    if (i - 1) % 2 == 0 then
      monsterID = dungeons.monsterId[mainIndex]
      monsterLv = dungeons.level[mainIndex]
      monsterIndex = dungeons.levelUpIndex[mainIndex]
      mainIndex = mainIndex + 1
    else
      monsterID = dungeons.monsterId[subIndex]
      monsterLv = dungeons.level[subIndex]
      monsterIndex = dungeons.levelUpIndex[subIndex]
      subIndex = subIndex + 1
    end
    local ret = WU.GetMonsterAttr(monsterID, monsterLv, monsterIndex)
    if ret and ret[PB.enum.AttrType.Hp] then
      hp = hp + ret[PB.enum.AttrType.Hp].value
    end
    if ret and ret[PB.enum.AttrType.Speed] and ret[PB.enum.AttrType.Speed].value ~= 0 then
      speed = ret[PB.enum.AttrType.Speed].value
      mainMonsterLv = monsterLv
    end
    if count == 2 then
      local refAttr = _ENV["$"](REF[string.format("NodeAttr%d", index)])
      if speed == 0 then
        refAttr["$gameObject"]:SetActive(false)
      else
        refAttr["$gameObject"]:SetActive(true)
        refAttr.SpeedValue.UIHtmlLabel.text = tostring(speed)
        refAttr.LifeValue.UIHtmlLabel.text = tostring(math.floor(mainMonsterLv / 5))
      end
      count = 0
      hp = 0
      speed = 0
      index = index + 1
    end
  end
end

function SetBuffVisible(index)
  REF.SpriteBuffBg.UISprite.height = BuffBGHeight[0]
  for i = 1, 3 do
    local ref = REF[string.format("NodeBuff%d", i)]
    if i <= index then
      ref.gameObject:SetActive(true)
      if i == index then
        REF.SpriteBuffBg.UISprite.height = BuffBGHeight[index]
      end
    else
      ref.gameObject:SetActive(false)
    end
  end
end

function OnButtonFightClick()
  this:SetData("SemiFixedActorGroup/DungeonId", m_dungeonId)
  WU.AcquireWindowAsync("SemiFixedActorGroup")
end

function Focus(on)
  if on then
    WU.SetWindowTitle("DungeonDetailSemiFixed", "DungeonStory")
  end
end
