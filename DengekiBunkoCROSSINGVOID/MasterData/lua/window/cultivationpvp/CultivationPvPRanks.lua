local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local m_CurrentTab = 0
local m_CurrentDungeon = 0
local m_TabGrid = REF.TabGrid
local m_RankContent = REF.WrapContent
local m_CurrentActivity
local m_SeasonCount = 0
local m_SeasonsInfo
local m_TopN = 50
local m_CurrentSeason = 1
local m_AllActivityId
local m_goto = false
local m_first = true
local m_RankData, m_PlayerRank, m_PlayerCultivation
local m_HideRanks = 10

function SetupWindow()
  LU.Bind(m_RankContent, {
    updateRow = UpdateRankSlot,
    delta = 0.02
  })
  m_HideRanks = PB.all("Misc"):first().cultivationPVPHideRanks or 10
  for i = 0, #m_TabGrid - 1 do
    local tabref = m_TabGrid[i]
    tabref["@index"] = i
    if i % 2 == 0 then
      CS.EventDelegate.Add(tabref.root.UIToggle.onChange, function()
        if CS.UIToggle.current.value then
          OnChangeSeason(tabref["@index"])
        end
      end)
    else
      for j = 0, #tabref.root - 1 do
        local childtab = tabref.root[j]
        childtab["@index"] = j
        CS.EventDelegate.Add(childtab.root.UIToggle.onChange, function()
          if CS.UIToggle.current.value then
            m_CurrentDungeon = childtab["@index"]
            OnChangeDungeon(childtab["@index"], m_CurrentTab // 2)
          end
        end)
      end
    end
  end
end

function GetExtraInfo()
  local dungeonId = this:GetData("CultivationPVPRanks/GotoDungeon")
  if not dungeonId then
    return
  end
  local dungeonIdInfo = this:GetData("cultivationPVPDungeonIds")
  local seasonTab = 0
  local dungeonTab = 0
  local activities = {}
  local activityId
  for k, v in pairs(dungeonIdInfo) do
    table.insert(activities, k)
    for i = 1, #v do
      if v[i] == dungeonId then
        activityId = k
        break
      end
    end
  end
  if activityId == nil then
    warning("CultivationPvP", "can find activityId with dungeonId")
    return
  end
  table.sort(activities, function(a, b)
    return b < a
  end)
  if activityId and dungeonId and dungeonIdInfo and dungeonIdInfo[activityId] then
    local dungeonIds = dungeonIdInfo[activityId]
    for i = 1, #activities do
      if activities[i] == activityId then
        seasonTab = (i - 1) * 2
        break
      end
    end
    for i = 1, #dungeonIds do
      if dungeonIds[i] == dungeonId then
        dungeonTab = i - 1
        break
      end
    end
    m_CurrentTab = seasonTab
    m_CurrentDungeon = dungeonTab
    m_goto = true
  end
end

function InitWindow()
  for i = 0, 3 do
    this:SetData("Season" .. i, 0)
  end
  GetExtraInfo()
  this:SetData("CultivationPVPRanks/Uninit", false)
  this:Bind("cultivationPVPDungeonIds", OnActivityChanged)
end

function UninitWindow()
  this:SetData("CultivationPVPRanks/Uninit", true)
  for i = 0, 3 do
    this:SetData("Season" .. i, 0)
  end
  ClearToggle(m_CurrentTab, m_CurrentDungeon, false)
  m_CurrentDungeon = 0
  m_CurrentTab = 0
  m_goto = false
  LU.Set(m_RankContent, 0)
  this:SetData("CultivationPVPRanks/GotoDungeon", nil)
end

function DestroyWindow()
  for i = 0, 3 do
    this:SetData("Season" .. i, nil)
  end
end

function ClearToggle(index, index2, flag)
  REF.TabGrid[index].root.UIToggle.optionCanBeNone = true
  REF.TabGrid[index + 1].root[index2].root.UIToggle.optionCanBeNone = true
  REF.TabGrid[index].root.UIToggle.value = flag
  REF.TabGrid[index + 1].root[index2].root.UIToggle.value = flag
  REF.TabGrid[index].root.UIToggle.optionCanBeNone = false
  REF.TabGrid[index + 1].root[index2].root.UIToggle.optionCanBeNone = false
end

function OnActivityChanged(data)
  if data == nil then
    return
  end
  m_SeasonsInfo = data
  m_SeasonCount = table.count(m_SeasonsInfo)
  m_AllActivityId = {}
  for k, v in pairs(m_SeasonsInfo) do
    table.insert(m_AllActivityId, k)
  end
  table.sort(m_AllActivityId, function(a, b)
    return b < a
  end)
  m_CurrentActivity = m_AllActivityId[1]
  m_CurrentSeason = S:Get("ActivityManager").GetActivitySync(PB.enum.ActivityType.CultivationPvP, m_CurrentActivity).season
  UpdateView()
end

function UpdateView()
  if not m_goto then
    this:SetData("Season0", 0)
    m_CurrentTab = 0
    m_CurrentDungeon = 0
  end
  for i = 0, #m_TabGrid - 1 do
    local tabref = m_TabGrid[i]
    tabref["@index"] = i
    if i % 2 == 0 then
      WU.SetActive(tabref.root, m_SeasonCount > i / 2)
      if m_SeasonCount > i / 2 then
        if i == 0 then
          tabref.LabelTitle.UILabel.text = WU.GetString("CultivationPvP_Rank_SeasonDesc", m_CurrentSeason - i / 2)
        else
          tabref.LabelTitle.UILabel.text = WU.GetString("CultivationPvP_Rank_SeasonDesc2", m_CurrentSeason - i / 2)
        end
      end
    else
      WU.SetActive(tabref.root, i == m_CurrentTab + 1)
      for j = 0, #tabref.root - 1 do
        local childtab = tabref.root[j]
        local s = math.floor(i // 2)
        if s < m_SeasonCount then
          local DungeonIds = m_SeasonsInfo[m_AllActivityId[s + 1]]
          local DungeonId = DungeonIds[j + 1]
          childtab.LabelTitle.UILabel.text = WU.GetString("ChallengeName_" .. DungeonId)
        end
      end
    end
  end
  UpdateTabs()
  if m_goto then
    this:SetData("Season" .. m_CurrentTab // 2, m_CurrentDungeon)
    m_goto = false
  end
  if m_TabGrid[m_CurrentTab].root.UIToggle.value then
    OnChangeSeason(m_CurrentTab)
  else
    m_TabGrid[m_CurrentTab].root.UIToggle.value = true
  end
end

function UpdateTabs()
  m_TabGrid.UITable:Reposition()
end

function OnChangeSeason(index)
  local dungeonIndex
  m_CurrentTab = index
  dungeonIndex = this:GetData("Season" .. m_CurrentTab // 2)
  if dungeonIndex == nil then
    return
  end
  UpdateTabs()
  this:DelayInvokeEndOfFrame(function()
    if m_TabGrid[m_CurrentTab + 1].root[dungeonIndex].root.UIToggle.value then
      OnChangeDungeon(dungeonIndex, m_CurrentTab // 2)
    else
      m_TabGrid[m_CurrentTab + 1].root[dungeonIndex].root.UIToggle.value = true
    end
  end)
end

function OnChangeDungeon(index, currentSeason)
  if m_AllActivityId == nil then
    return
  end
  this:SetData("Season" .. m_CurrentTab // 2, index)
  local activityId = m_AllActivityId[currentSeason + 1]
  local dungeonId = m_SeasonsInfo[activityId][index + 1]
  local url = "fci/challenge-mode/season/" .. dungeonId
  local data = this:GetData(url)
  if currentSeason ~= 0 then
    if data == nil then
      DB:GameRequest(url):Get(function(response)
        if DB:GetData("CultivationPVPRanks/Uninit") then
          return
        end
        DB:SetData(url, response)
        UpdateRanks(response.rankList)
      end)
    else
      UpdateRanks(data.rankList, dungeonId)
    end
  else
    DB:GameRequest("fci/challenge-mode-rank/top/" .. m_TopN .. "/dungeon/" .. dungeonId):Get(function(response)
      if DB:GetData("CultivationPVPRanks/Uninit") then
        return
      end
      UpdateRanks(response.rankInfo, dungeonId)
    end)
  end
end

function UpdateRanks(data, dungeonId)
  m_RankData = data
  if m_RankData == nil or m_RankData[1] == nil then
    WU.SetActive(REF.EmptyNode, true)
    WU.SetActive(REF.DragBg, false)
    WU.SetActive(REF.RankInfo, false)
    return
  end
  local inRank = false
  local rank = 0
  local cultivation = 0
  WU.SetActive(REF.DragBg, true)
  WU.SetActive(REF.EmptyNode, false)
  LU.Set(m_RankContent, 0)
  for _, rankinfo in pairs(m_RankData) do
    rank = rank + 1
    if rankinfo.playerId == DB:GetData("playerId") then
      cultivation = -rankinfo.score
      inRank = true
      break
    end
  end
  local recordList = this:GetData("CultivationPvP/scoreRecord")
  if m_CurrentTab == 0 and dungeonId and recordList[tostring(dungeonId)] ~= nil then
    cultivation = recordList[tostring(dungeonId)]
  end
  WU.SetActive(REF.RankInfo, true)
  rank = fif(not inRank, "--", rank)
  cultivation = fif(cultivation == 0, "--", cultivation)
  REF.PlayerRank.UILabel.text = WU.GetString("CultivationPvP_PlayerRank", rank)
  REF.PlayerCultivation.UILabel.text = WU.GetString("CultivationPvP_PlayerCultivation", cultivation)
  LU.Set(m_RankContent, #m_RankData)
end

function UpdateRankSlot(rowRef, wrapIndex, realIndex)
  if m_RankData and realIndex ~= nil and realIndex < #m_RankData then
    local rankInfo = m_RankData[realIndex + 1]
    if rankInfo == nil then
      rowRef["$$ClearSlot"]()
    else
      local info = {}
      info.playerName = rankInfo.playerName
      info.score = rankInfo.score
      info.rank = realIndex + 1
      if info.rank > m_HideRanks or m_CurrentTab ~= 0 then
        info.actorGroup = rankInfo.actorGroup
      end
      rowRef["$$SetView"](info)
    end
  else
    WU.ToggleRendering(rowRef.root, false)
  end
end
