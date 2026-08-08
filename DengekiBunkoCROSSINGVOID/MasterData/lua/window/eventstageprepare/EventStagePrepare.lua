local PB = require("Common/PbHelper")
local WU, DB, REF = require("Common/WindowUtil")(this)
local HU = require("Common/HtmlUtil")
local LU = require("Common/ListUtil")
local GU = require("Common/GroupUtil")
local ACU = require("Common/ActivityUtil")
local ATU = require("Common/AutumnUtil")
local S = require("Common/Singleton")
local AM = S:Get("ActivityManager")
local DU = require("Common/DungeonUtil")
local m_buffBgheight = {
  310,
  445,
  580
}
m_buffBgheight[0] = 177
local m_buffCnt = 3
local m_affixDescText
local m_dungeonId = 0
local m_dungeonReward = {}
local m_showFirstReward = true
local m_displayTable = {}
local m_dungeonRecord, m_dungeonType
local BuffCnt = 3
local m_balanceDungeon
local m_wheelMode = false
local m_dungeonIdChain = {}
local m_price = 0

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonFight, OnButtonFightClick)
  WU.BindButtonEvent(REF.TouchInfo, function()
    if m_dungeonId and not m_wheelMode then
      REF.PanelBuff.gameObject:SetActive(not REF.PanelBuff.gameObject.activeSelf)
      if REF.PanelBuff.gameObject.activeSelf == true then
        ShowBuff(m_dungeonId)
      end
    end
  end)
  LU.Bind(REF.DropContent, {
    updateRow = UpdateEventDropSlot
  })
end

function UninitWindow()
  this:SetData("WindowDungeon/WheelMode", false)
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

function InitWindow()
  REF.PanelBuff.gameObject:SetActive(false)
  REF.ScrollView.UIScrollView:ResetPosition()
  m_dungeonIdChain = {}
  local dungeonId = this:GetData("WindowDungeon/DungeonId")
  m_wheelMode = this:GetData("WindowDungeon/WheelMode")
  m_dungeonId = dungeonId
  m_dungeonIdChain[1] = dungeonId
  local i = 1
  while m_dungeonIdChain[i] do
    local dun = PB.get("DungeonMonster", m_dungeonIdChain[i])
    if dun and dun.nextDungeonId and dun.nextDungeonId ~= 0 and dun.nextDungeonId ~= -1 then
      m_dungeonIdChain[i + 1] = dun.nextDungeonId
    end
    i = i + 1
  end
  m_balanceDungeon = fif(m_wheelMode, m_dungeonIdChain[#m_dungeonIdChain], m_dungeonId)
  m_dungeonRecord = nil
  m_dungeonReward = nil
  m_affixDescText = ""
  OnDungeonIdChanged(dungeonId)
  SetTargets()
  local dungeonMonster = PB.get("DungeonMonster", m_dungeonId)
  REF.LabelDungeonTitle.UIHtmlLabel.text = WU.GetString("DungeonName_" .. m_dungeonId)
  REF.TextureStage.UITexture.mainTexturePath = "Texture/StageThumb/" .. dungeonMonster.stageID
  WU.SetActive(REF.StarCondition, not m_wheelMode)
  WU.SetActive(REF.WheelModeCondition, m_wheelMode)
  if not m_wheelMode then
    local winTypeResult = DU.GetDungeonWinTypeText(dungeonMonster.winParam)
    REF.LabelWinTitle.UIHtmlLabel.text = WU.GetString("WinType_Title") .. tostring(winTypeResult[1])
  else
    REF.LabelWinTitle.UIHtmlLabel.text = WU.GetString("WinType_Title_WheelMode", #m_dungeonIdChain)
    for i = 0, #REF.WheelModeCondition - 1 do
      WU.SetActive(REF.WheelModeCondition[i].root, i < #m_dungeonIdChain)
      if i < #m_dungeonIdChain then
        dungeonMonster = PB.get("DungeonMonster", m_dungeonIdChain[i + 1])
        local winTypeResult = DU.GetDungeonWinTypeText(dungeonMonster.winParam)
        REF.WheelModeCondition[i].root.UILabel.text = WU.GetString("WinTypeWheelMode", i + 1, tostring(winTypeResult[1]))
      end
    end
  end
end

function OnDungeonIdChanged(dungeonId)
  if dungeonId then
    m_dungeonId = dungeonId
    this:SetData("WindowDungeon/DungeonId", m_dungeonId)
    for i = 0, #REF.GroupGrid - 1 do
      WU.SetActive(REF.GroupGrid[i].root, i < #m_dungeonIdChain)
      if i < #m_dungeonIdChain then
        local actorList = {}
        local monsterList = {}
        local showTypeList = {}
        local showDescList = {}
        local dungeons = PB.get("DungeonMonster", m_dungeonIdChain[i + 1])
        for j = 1, #dungeons.monsterId do
          monsterList[j] = dungeons.monsterId[j]
        end
        for j = 1, #dungeons.showType do
          showTypeList[j] = dungeons.showType[j]
        end
        ShowStoryDungeonActorList(REF.GroupGrid[i], monsterList, showTypeList)
      end
    end
    if not m_wheelMode then
      REF.AffixWidget["$ShowAffixWidget"](m_dungeonId)
      if REF.LabelTeam then
        REF.LabelTeam.UIHtmlLabel.text = WU.GetString("WindowDungeonInfo_StoryTeamName")
      end
    end
  end
  m_dungeonReward = PB.get("DungeonReward", m_balanceDungeon)
  local initDungeonReward = PB.get("DungeonReward", m_dungeonId)
  local hasCost, cost, costWin
  if m_wheelMode then
    hasCost = 0 < #initDungeonReward.cost
    if hasCost then
      cost = initDungeonReward.cost[1]
      costWin = m_dungeonReward.costWin[1] or {count = 0}
    end
  else
    hasCost = 0 < #m_dungeonReward.cost
    if hasCost then
      cost = m_dungeonReward.cost[1]
      costWin = m_dungeonReward.costWin[1] or {count = 0}
    end
  end
  if hasCost then
    REF.LabelCost.ResourcePrinter:SetResource(cost.type, cost.id, cost.count + costWin.count)
    m_price = {
      type = cost.type,
      id = cost.id,
      count = cost.count + costWin.count
    }
  else
    m_price = 0
  end
  WU.ToggleRendering(REF.LabelCost, hasCost)
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
  m_affixDescText = ""
  local index = 0
  for _, affix in pairs(affixList) do
    m_affixDescText = WU.GetString("AffixDesc_" .. affix) .. HU.HtmlSplitLine("Common.Line_dark")
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
      refBuff.AffixDescLabel.UIHtmlLabel.text = m_affixDescText
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
      refAttr.SpeedValue.UIHtmlLabel.text = tostring(speed)
      refAttr.LifeValue.UIHtmlLabel.text = tostring(math.floor(mainMonsterLv / 5))
      count = 0
      hp = 0
      speed = 0
      index = index + 1
    end
  end
end

function SetBuffVisible(index)
  REF.SpriteBuffBg.UISprite.height = m_buffBgheight[0]
  for i = 1, 3 do
    local ref = REF[string.format("NodeBuff%d", i)]
    if i <= index then
      ref.gameObject:SetActive(true)
      if i == index then
        REF.SpriteBuffBg.UISprite.height = m_buffBgheight[index]
      end
    else
      ref.gameObject:SetActive(false)
    end
  end
end

function SetTargets()
  local doneTaskMap = {}
  local records
  local ac = this:GetData("EventActivity/CurrentActivity")
  if ATU.UsedForAutumn(ac.type) then
    records = this:GetData("fci/event-dungeon/record/")
  else
    records = this:GetData(string.format("fci/activity/record/%s/%s", ac.type, ac.activityId))
    if records ~= nil then
      records = records.records
    else
      records = {}
    end
  end
  if records == nil and ac.type == PB.enum.ActivityType.Carnival91 then
    REF.LabelTitle.UILabel.text = WU.GetString("WindowDungeon_FirstGet")
    return
  end
  local _, dungeonRecord = _ENV["!"](records):find(function(k, v)
    return v.dungeonId == m_balanceDungeon
  end)
  m_displayTable = {}
  if dungeonRecord and dungeonRecord.finished then
    for i = 1, #dungeonRecord.targetsDone do
      doneTaskMap[dungeonRecord.targetsDone[i]] = true
    end
    REF.LabelTitle.UILabel.text = WU.GetString("WindowDungeon_MaybeGet")
    for k, v in pairs(m_dungeonReward.dropDisplay) do
      m_displayTable[k] = v
    end
    AM.GetTimeLimitExtraReward({type = 3, dungeonId = m_dungeonId}, function(extra)
      for i = 1, #extra do
        table.insert(m_displayTable, extra[i])
      end
      LU.Set(REF.DropContent, #m_displayTable)
    end)
  else
    REF.LabelTitle.UILabel.text = WU.GetString("WindowDungeon_FirstGet")
    REF.NodeDrops.gameObject:SetActive(true)
    REF.NodeTeam.transform.localPosition = {
      x = REF.NodeTeam.transform.localPosition.x,
      y = -411,
      z = 0
    }
    m_displayTable = m_dungeonReward.dropDisplayFirst
    LU.Set(REF.DropContent, #m_displayTable)
  end
  for i = 1, #m_dungeonReward.target do
    local target = m_dungeonReward.target[i]
    local targetText = WU.GetDungeonTargetText(target)
    if doneTaskMap[target.id] then
      targetText = HU.ApplyFontColor(targetText, "white")
    end
    REF["LabelTarget" .. target.id].UIHtmlLabel.text = targetText
    REF["SpriteStar" .. target.id].UISprite.graify = not doneTaskMap[target.id]
  end
end

function OnButtonFightClick(obj)
  WU.AcquireWindowAsync("ActivityActorGroup", function(ui)
    local ac = this:GetData("EventActivity/CurrentActivity")
    this:SetData("Event/ActivityId", ac.activityId)
    this:SetData("ActivityActorGroup/DungeonInfo", {
      dungeonId = m_dungeonId,
      activityId = ac.activityId,
      activityType = ac.type,
      mode = "EventActivity",
      wheelMode = m_wheelMode,
      balanceDungeonId = m_balanceDungeon
    })
  end)
end

function UpdateEventDropSlot(ref, wrapIndex, realIndex)
  if m_displayTable then
    if realIndex < 0 or realIndex >= #m_displayTable then
      return
    end
    local widgetIconSlot = ref.root
    local item = m_displayTable[realIndex + 1]
    if item.type == 11 then
      widgetIconSlot["$SetData"](item.type, item.id)
    else
      widgetIconSlot["$SetData"](item.type, item.id, item.count)
    end
    widgetIconSlot["$SetClickCallback"](function()
      WU.ShowResourceDetail(item.type, item.id)
    end)
  end
end

function ShowStoryDungeonActorList(ref, monsterIds, showTypeList)
  local actors = GU.MonsterGroup(monsterIds)
  ref.root["$SetTips"](showTypeList, true)
  ref.root["$SetViewByActors"](actors, true, true)
end
