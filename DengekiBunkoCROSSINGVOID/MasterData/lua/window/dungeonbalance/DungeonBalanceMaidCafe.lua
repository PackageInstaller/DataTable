local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local SDU = require("Common/SoundUtil")
local DBH = require("Manager/DataBindingHandler")
local BASE = inherit("Window/DungeonBalance/DungeonBalanceBase", _ENV)
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local ACU = require("Common/ActivityUtil")
local m_balance, m_rewards, m_rankModeInfoAll, m_highestScore, m_rankType, m_selectedGroupId, m_ticketCost, m_record

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonContinue, OnClickContinue)
  WU.BindButtonEvent(REF.ButtonFightAgain, OnClickFightAgain)
  WU.BindButtonEvent(REF.ButtonShare, OnClickButtonShare)
  WU.BindButtonEvent(_ENV["$"](REF.Ticket).LabelCost, OnClickTickets)
end

function InitWindow()
  m_balance = this:GetData("DungeonBalanceMaidCafe/result")
  m_rankModeInfoAll = this:GetData("fci/maidcafe/rank-mode")
  m_rankType = this:GetData("WindowDungeon/MaidRankType")
  m_record = this:GetData("MaidCafe/DungeonInfo")
  BASE.SetActorTextureEffect(this:GetData("FightWinActor"))
  local maidcafeBalance = m_balance.dungeonExBalanceResult.maidcafe
  local score = maidcafeBalance.newRankModeValue
  local unlock = maidcafeBalance.unlockRankModeType
  local rankModeType = maidcafeBalance.rankModeType
  local rankModeInfo = this:GetData("fci/maidcafe/rank-mode")
  if rankModeInfo then
    rankModeInfo.rankModeInfo[rankModeType].rankModeValue = score
  end
  if rankModeInfo and rankModeType ~= PB.enum.MaidCafeRankModeType.Legend then
    if unlock ~= 0 then
      rankModeInfo.rankModeInfo[unlock].unlocked = true
    end
    for _, v in pairs(rankModeInfo.rankModeRewardInfo) do
      if v.rankModeType == rankModeType and score >= v.rankModeValue then
        v.got = true
      end
    end
  end
  this:SetData("fci/maidcafe/rank-mode", rankModeInfo)
  if rankModeType ~= PB.enum.MaidCafeRankModeType.Free then
    local passRewardInfo = this:GetData("fci/maidcafe/rank-mode/pass-reward")
    if passRewardInfo then
      passRewardInfo.currentPassCount = passRewardInfo.currentPassCount + 1
      this:SetData("fci/maidcafe/rank-mode/pass-reward", passRewardInfo)
    else
      DB:SyncRemote(DB:GameRequest("fci/maidcafe/rank-mode/pass-reward"))
    end
  end
  m_highestScore = m_rankModeInfoAll.rankModeInfo[m_rankType].rankModeValue
  local rankRewards = m_rankModeInfoAll.rankModeRewardInfo
  local dungeonId = m_rankModeInfoAll.rankModeInfo[m_rankType].dungeonId
  local balanceDungeonId = DU.GetBalanceDungeon(dungeonId)
  local price1 = DU.GetDungeonPrice(dungeonId)
  local price2 = DU.GetDungeonPrice(balanceDungeonId)
  if price2.count == 0 then
    m_ticketCost = {
      type = PB.enum.ResourceType.ResNone,
      count = 0
    }
  else
    m_ticketCost = {
      type = price2.type,
      id = price2.id,
      count = price2.count + price1.count
    }
  end
  WU.SetActive(REF.LabelCost, 0 < m_ticketCost.count)
  if 0 < m_ticketCost.count then
    REF.LabelCost.ResourcePrinter:SetResource(m_ticketCost.type, m_ticketCost.id, m_ticketCost.count)
  end
  local unLockScore = 0
  local selected_rankRewards = _ENV["!"]({})
  local unlockNew = m_balance.dungeonExBalanceResult.maidcafe.unlockRankModeType
  if unlockNew and unlockNew ~= 0 then
    REF.LabelUnlockHint.UIHtmlLabel.text = WU.GetString("MaidCafe_RankMode_UnlockType" .. unlockNew)
    this:SetData("MaidCafe/NewUnlocked", unlockNew)
  else
    for _, v in pairs(rankRewards) do
      if v.rankModeType == m_rankType then
        table.insert(selected_rankRewards, v)
      end
    end
    for k, v in pairs(selected_rankRewards) do
      if unLockScore < v.rankModeValue then
        unLockScore = v.rankModeValue
      end
    end
    WU.SetActive(REF.LabelUnlockHint, m_rankType ~= PB.enum.MaidCafeRankModeType.Legend and unLockScore > m_highestScore)
    if REF.LabelUnlockHint.gameObject.activeSelf then
      REF.LabelUnlockHint.UIHtmlLabel.text = WU.GetString("MaidCafe_RankMode_NextRankTypeHint" .. m_rankType, unLockScore)
    end
  end
  m_rewards = DU.GetDungeonBalanceRewards(m_balance.dungeonExBalanceResult.common.balanceInfo)
  WU.ToggleRendering(REF.AcquirementList, 0 < #m_rewards)
  WU.SetActive(REF.NodeRewards, 0 < #m_rewards)
  BASE.InitAcquirement(m_balance.dungeonExBalanceResult.common.balanceInfo)
  if #BASE.m_rewards < 7 then
    REF.AcquirementScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.TopRight
    REF.AcquirementScrollView.UIScrollView:ResetPosition()
  end
  if #m_rewards > #REF.AcquirementContent - 2 then
    REF.AcquirementList.BoxCollider2D.enabled = true
    WU.TraverseChildren(REF.AcquirementContent, function(go)
      go:GetComponentInChildren(typeof(CS.UIDragScrollView)).enabled = true
    end)
  end
  REF.LabelRankScore.UILabel.text = m_balance.dungeonExBalanceResult.maidcafe.currentRankModeValue
end

function OnClickContinue()
  DU.LeaveDungeon(1)
end

function OnClickFightAgain()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.MaidCafe_RankMode, function(acList)
    if acList then
      for _, activity in pairs(acList) do
        local status = ACU.GetStatus(activity)
        if status == PB.enum.ActivityStatus.Started then
          FightAgain()
          return
        end
      end
    end
    WU.ShowHintText(WU.GetString("WindowActivity_IsNotOpen"))
  end)
end

function OnClickButtonShare()
  WU.RecordButtonClick(901)
  this:SetData("ShareConfig", {
    shareName = "MaidCafeRecruitMent",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  local groups = DB:GetData("fci/ActorGroup/")
  local allActors = DB:GetData("fci/actor/")
  m_selectedGroupId = this:GetData("fci/SelectedGroupId/activity-dun/").selectActorGroupId
  local members = groups[tostring(m_selectedGroupId)].members
  local actorIds = {}
  for i = 1, #members do
    local _, actor = table.find(allActors, function(k, actor)
      return actor.uid == members[i].actorUid
    end)
    if actor then
      local index = 1
      if i <= 3 then
        index = 6 - (i - 1) * 2
      else
        index = 5 - (i - 4) * 2
      end
      actorIds[index] = actor.id
    end
  end
  local highScore = DB:GetData("MaidCafe/HighScore")
  local socre = m_balance.dungeonExBalanceResult.maidcafe.currentRankModeValue
  if highScore < socre then
    highScore = socre
    DB:SetData("MaidCafe/HighScore", highScore)
  end
  local data = {
    highScore = highScore,
    score = socre,
    theme = DB:GetData("MaidCafe/Theme"),
    coffeeLevel = DB:GetData("MaidCafe/RankType"),
    actorIds = actorIds
  }
  this:SetData("Share/MaidCafeRecruitMent", data)
  WU.AcquireWindowAsync("Share")
end

function FightAgain()
  m_selectedGroupId = this:GetData("fci/SelectedGroupId/activity-dun/").selectActorGroupId
  local param = this:GetData("WindowDungeon/EnterParam")
  param = param or {
    dungeonExCreateParam = {
      common = {
        dungeonId = m_record.dungeonId,
        selectActorGroupId = m_selectedGroupId,
        multiPower = 1,
        price = m_ticketCost,
        wheelMode = true,
        wheelModeBalanceDungeonId = DU.GetBalanceDungeon(m_record.dungeonId)
      },
      maidcafe = {rankModeType = m_rankType}
    }
  }
  param = ProtobufT("ApiDungeonEx", param)
  if m_ticketCost.type == 0 then
    this:GameRequest("fci/dungeon-ex/"):Post(param, function(response)
      local exResponse = response.dungeonExCreateResult
      DBH.ResChange(exResponse.common.resChange)
      WU.EnterGameLevel(exResponse.common.dungeonUid, exResponse.common.baseInfo, m_record.dungeonId, PB.enum.DungeonType.MaidCafe, 1, false)
    end)
  else
    WU.TryToPay(m_ticketCost.type, m_ticketCost.id, m_ticketCost.count, function()
      this:GameRequest("fci/dungeon-ex/"):Post(param, function(response)
        local exResponse = response.dungeonExCreateResult
        DBH.ResChange(exResponse.common.resChange)
        WU.EnterGameLevel(exResponse.common.dungeonUid, exResponse.common.baseInfo, m_record.dungeonId, PB.enum.DungeonType.MaidCafe, 1, false)
      end)
    end, function()
      WU.ShowHintText(WU.GetString("MaidCafe_RankMode_NotEnoughTickets"))
    end)
  end
end

function OnClickTickets()
  if m_ticketCost.type == PB.enum.ResourceType.ResItem then
    WU.ShowItemDetail(m_ticketCost.id)
  else
    WU.ShowHintText(WU.GetString("ResourceTypeName_" .. m_ticketCost.type))
  end
end
