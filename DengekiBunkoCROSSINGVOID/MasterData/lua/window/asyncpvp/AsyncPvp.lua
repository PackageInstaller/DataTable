local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local IU = require("Common/ItemUtil")
local DBH = require("Manager/DataBindingHandler")
local NU = require("Common/NotepadUtil")
local m_staticTournamentInfo, m_tournamentInfo, m_activityId, m_activityType, m_targetActors
local m_playActorAnimation = false
local m_tournamentInfoGot = false
local m_tournamentSummaryGot = false

function InitWindow()
  m_tournamentInfoGot = false
  m_tournamentSummaryGot = false
  m_playActorAnimation = true
  this:Bind("fci/asyncpvprecord/", OnAsyncPvpRecordChanged)
  this:RegisterGameEvent("ActivityStatusChanged", OnActivityStatusChanged)
  this:RegisterGameEvent("AsyncPvpDailyRefresh", OnAsyncPvpDailyRefresh)
  this:Bind("AsyncPvpOpponentRefreshed", OnAsyncPvpOpponentRefreshed, false)
  local all = PB.all("RefreshPrice")
  local _, info = all:find(function(k, v)
    return v.type == PB.enum.RefreshPriceType.AsyncPvpRefreshTarget
  end)
  if info then
    if info.cost.type == PB.enum.ResourceType.ResItem then
      this:Bind("fci/item/" .. info.cost.id, OnRefreshItemChanged)
    else
      this:Bind("fci/resource/" .. PB.enum.ResourceType.__keys[info.cost.type] .. "_" .. info.cost.id, OnRefreshItemChanged)
    end
  end
  m_activityId = this:GetData("fci/tournament/curId")
  this:SetData("AsyncPvpActivityId", m_activityId)
  m_activityType = this:GetData("fci/tournament/curActivityType")
  REF.NodePrepare.gameObject:SetActive(false)
  REF.NodeAsyncPvp.gameObject:SetActive(false)
  this:BindRemote(DB:GameRequest("fci/tournament/info/" .. m_activityType .. "/" .. m_activityId), function(tournamentInfo)
    if tournamentInfo then
      m_tournamentInfoGot = true
      m_staticTournamentInfo = ACU.GetCurStaticTournamentInfo()
      if this:GetData("fci/tournament/summary/") and m_staticTournamentInfo and m_tournamentInfoGot and m_tournamentSummaryGot then
        SetContent()
        m_tournamentInfoGot = false
        m_tournamentSummaryGot = false
      end
    end
  end)
  this:BindRemote(DB:GameRequest("fci/tournament/summary/"), function(tournamentSummary)
    if tournamentSummary then
      m_tournamentSummaryGot = true
      m_staticTournamentInfo = ACU.GetCurStaticTournamentInfo()
      if this:GetData("fci/tournament/summary/") and m_staticTournamentInfo and m_tournamentInfoGot and m_tournamentSummaryGot then
        SetContent()
        m_tournamentInfoGot = false
        m_tournamentSummaryGot = false
      end
    end
  end)
  this:RegisterGameEvent("OnNavigation", function(type)
    if type == "City" then
      OnNavigateToCity()
    end
  end)
end

function OnActivityStatusChanged(category, activityId, status)
  if category == PB.enum.ActivityCategory.Tournament and m_activityId == activityId and (status == PB.enum.ActivityStatus.Finished or status == PB.enum.ActivityStatus.Close) then
    WU.RecycleWindow(this)
  end
end

function FilterReward(allConfigRewards, targetNum)
  local reward = {}
  if targetNum == 3 then
    for i = 1, #allConfigRewards do
      if 3 >= allConfigRewards[i].winNum then
        table.insert(reward, allConfigRewards[i])
      end
    end
  elseif targetNum == 5 then
    for i = 1, #allConfigRewards do
      if allConfigRewards[i].winNum % 2 == 1 then
        table.insert(reward, allConfigRewards[i])
      end
    end
  else
    reward = allConfigRewards
  end
  return reward
end

function RequestEnterInfo()
  this:GameRequest("fci/tournament/enter/" .. m_activityType .. "/" .. m_activityId):Get(function(response)
    if response ~= nil then
      if #response.asyncPvpTargetInfo > 0 then
        REF.NodeAsyncPvp.gameObject:SetActive(true)
        this:SetData("fci/asyncpvprecord/", response.asyncPvpRecord)
        m_tournamentInfo = response
        local isFinished = m_tournamentInfo.winNum >= #response.asyncPvpTargetInfo and 0 >= #response.asyncPvpRecord.leftRewardsWinNum
        WU.ToggleRendering(REF.SpriteFinished, isFinished)
        SetOpponent(response.asyncPvpTargetInfo)
        if m_staticTournamentInfo then
          local reward = FilterReward(m_staticTournamentInfo.reward, #m_targetActors)
          REF.WidgetItemProgress["$SetData"](reward, m_tournamentInfo.winNum)
        end
      else
        WU.ShowHintText(WU.GetString("Tournament_AsyncEnterInfoGetFailed"))
        WU.RecycleWindow(this)
      end
    end
  end)
end

function OnAsyncPvpRecordChanged(pvpRecord)
  if pvpRecord and m_tournamentInfo and m_staticTournamentInfo then
    local reward = FilterReward(m_staticTournamentInfo.reward, #m_targetActors)
    REF.WidgetItemProgress["$SetData"](reward, pvpRecord.todayMaxWinNum)
    local isFinished = m_tournamentInfo.winNum >= #m_targetActors and #pvpRecord.leftRewardsWinNum <= 0
    WU.ToggleRendering(REF.SpriteFinished, isFinished)
  end
end

function OnAsyncPvpDailyRefresh()
  m_tournamentInfoGot = false
  DB:SyncRemote(DB:GameRequest("fci/tournament/info/" .. m_activityType .. "/" .. m_activityId):SyncInput(false))
  m_tournamentSummaryGot = false
  DB:SyncRemote(DB:GameRequest("fci/tournament/summary/"):SyncInput(false))
end

function SetOpponent(targetActors)
  local playTargetPlayersAnimation = m_playActorAnimation or m_targetActors == nil
  m_playActorAnimation = false
  m_targetActors = targetActors
  local gridPlayers = REF.GridPlayers
  local count = gridPlayers.transform.childCount
  for i = 0, count - 1 do
    local hasActor = i + 1 <= #m_targetActors
    if hasActor then
      local actorInfo = m_targetActors[i + 1]
      gridPlayers[i]["$$SetData"](actorInfo)
      gridPlayers[i]["$$SetClickCallback"](function()
        if m_tournamentInfo ~= nil then
          WU.AcquireWindowAsync("PlayerLineup", function(ui)
            _ENV["$"](ui)["$$SetData"](m_targetActors, i)
          end)
        end
      end)
    end
    WU.SetActive(gridPlayers[i]["$"], hasActor)
  end
  if playTargetPlayersAnimation then
    REF.GridPlayers.UIGrid:Reposition()
    REF.GridPlayers.UIPlayTween:Play(true)
  end
end

function OnAsyncPvpOpponentRefreshed(targetInfo)
  if targetInfo then
    m_targetActors[targetInfo.index + 1] = targetInfo.targetActor
    REF.GridPlayers[targetInfo.index]["$$SetData"](targetInfo.targetActor)
  end
end

function OnNavigateToCity()
  local condition = NU.CheckBoardSpeech(PB.enum.SpeechType.AsyncPvp, function(params)
    local pWinNum = tonumber(params[1])
    local pLoseNum = tonumber(params[2])
    local winNum = 0
    if m_tournamentInfo then
      winNum = m_tournamentInfo.winNum or 0
    end
    return pWinNum and pWinNum <= winNum
  end)
  if condition ~= nil then
    this:BroadcastGameEvent("BoardActorSpeech", condition.id)
  end
end

function SetContent()
  local status = ACU.GetTournamentStatus(m_activityId)
  if status == PB.enum.TournamentStatus.NoParticipation then
    SetNodePrepare()
  elseif status == PB.enum.TournamentStatus.Participation then
    SetNodeAsyncPvp()
  end
end

function SetNodeAsyncPvp()
  REF.NodePrepare.gameObject:SetActive(false)
  REF.NodeAsyncPvp.gameObject:SetActive(false)
  RequestEnterInfo()
end

function SetNodePrepare()
  REF.NodePrepare.gameObject:SetActive(true)
  REF.NodeAsyncPvp.gameObject:SetActive(false)
  this:DelayInvokeInSeconds(0.8, function()
    m_playActorAnimation = true
    OnRequestEnter()
  end)
end

function OnRequestEnter()
  this:GameRequest("fci/tournament/enter/"):Post({tournamentId = m_activityId, activityType = m_activityType}, function(result)
    if result then
      DBH.ResChange(result.resChange)
      if result.enterResult then
        m_tournamentInfoGot = false
        DB:SyncRemote(DB:GameRequest("fci/tournament/info/" .. m_activityType .. "/" .. m_activityId):SyncInput(false))
        m_tournamentSummaryGot = false
        DB:SyncRemote(DB:GameRequest("fci/tournament/summary/"):SyncInput(false))
      else
        WU.ShowHintText(WU.GetString("Tournament_EnterFailed"))
        WU.RecycleWindow(this)
      end
    else
      WU.RecycleWindow(this)
    end
  end)
end

function OnRefreshItemChanged(item)
  local all = PB.all("RefreshPrice")
  local _, info = all:find(function(k, v)
    return v.type == PB.enum.RefreshPriceType.AsyncPvpRefreshTarget
  end)
  if info then
    local resIconHtml = "<img src='ResIcon_s." .. PB.enum.ResourceType.__keys[info.cost.type] .. "_" .. info.cost.id .. "' />"
    local hasRes = 0
    if info.cost.type == PB.enum.ResourceType.ResItem then
      hasRes = item.count
    else
      hasRes = item
    end
    local _, dailyRefresh = PB.all("DailyRefresh"):find(function(k, v)
      return v.refreshRes.id == info.cost.id
    end)
    if dailyRefresh ~= nil then
      if 0 < hasRes then
        REF.LabelRefresh.UIHtmlLabel.text = WU.GetString("Tournament_AsyncPvpRefreshItemInfo", resIconHtml, hasRes)
      else
        hasRes = "<font color=#fd5454>" .. hasRes .. "</font>"
        REF.LabelRefresh.UIHtmlLabel.text = WU.GetString("Tournament_AsyncPvpRefreshItemInfo", resIconHtml, hasRes)
      end
      WU.ClearButtonEvent(REF.LabelRefresh)
      WU.BindButtonEvent(REF.LabelRefresh, function()
        OnShowTicketMessage(info.cost)
      end)
    else
      error("GamePlay", "cannot find entry in DailyRefresh by refreshRes.id:" .. info.cost.id)
    end
  end
end

function OnShowTicketMessage(cost)
  if cost.type == PB.enum.ResourceType.ResItem then
    WU.ShowItemDetail(cost.id)
  else
    WU.ShowHintText(WU.GetString("ResourceTypeName_" .. cost.type))
  end
end
