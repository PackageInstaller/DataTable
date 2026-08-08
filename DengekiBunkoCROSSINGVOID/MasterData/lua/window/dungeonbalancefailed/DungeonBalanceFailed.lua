local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local DU = require("Common/DungeonUtil")
local GU = require("Common/GroupUtil")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local S = require("Common/Singleton")
local m_configDataManager = S:Get("ConfigDataManager")
local m_balance, m_rewards, m_fightDungeonType
local m_canTowerContinue = false

function InitWindow()
  if REF.NodeRecommend then
    WU.SetActive(REF.NodeRecommend, false)
  end
  m_fightDungeonType = this:GetData("FightDungeonType")
  InitDungeonName()
  InitDungeonFailedText()
  InitAcquirement()
  InitLoseSign()
  SetContinueButtons()
  local info = this:GetData("BalanceInfo/Groups")
  if info then
    local members
    if m_fightDungeonType == PB.enum.DungeonType.SemiFixed then
      members = info.groups.groupInfo.members
    elseif m_fightDungeonType == PB.enum.DungeonType.TowerNew then
      members = info.groups
    else
      REF.WidgetFightAgain["$SetSelectedGroupId"](info.selectedGroupId)
      members = info.groups[tostring(info.selectedGroupId)].members
    end
    ShowRecommendPlan(members, this:GetData("WindowDungeon/DungeonId"))
  end
  if m_fightDungeonType == PB.enum.DungeonType.Tower then
    DB:GameRequest("fci/tower/summary/"):Get(function(result)
      this:SetData("fci/tower/summary/", result)
    end)
    this:SetData("fci/tower/actorgroup-confirm/", nil)
    this:BindRemote(DB:GameRequest("fci/tower/actorgroup-confirm/"), OnActorGroupConfirm)
  end
end

function SetContinueButtons()
  REF.WidgetFightAgain["$SetContinueCall"](OnButtonContinueClick)
  if m_fightDungeonType ~= PB.enum.DungeonType.Normal and m_fightDungeonType ~= PB.enum.DungeonType.WeekActivity then
    REF.WidgetFightAgain["$ShowNodePower"](false)
  end
end

function OnButtonContinueClick()
  this:SetData("Assistant/Aura", nil)
  Leave()
end

function Leave()
  if m_fightDungeonType == PB.enum.DungeonType.Tower and m_canTowerContinue then
    WU.AcquireWindowAsync("TowerActorGroup", function()
      WU.SetNaviationHomeCallback(function()
        DU.LeaveTower(2, "")
      end)
      WU.SetNaviationBackCallback(function()
        DU.LeaveDungeon(2)
      end)
      WU.FindWindow("Messenger").gameObject:SetActive(false)
    end)
  else
    DU.LeaveDungeon(2)
  end
end

function InitDungeonFailedText()
  if m_fightDungeonType ~= PB.enum.DungeonType.AsyncPvp then
    local dungeonId = this:GetData("WindowDungeon/DungeonId")
    if dungeonId then
      local resDungeonMonster = PB.get("DungeonMonster", dungeonId)
      if resDungeonMonster == nil then
        error("Dungeon", "DungeonMonster.xlsx error, Can't find " .. dungeonId)
        return
      end
      for i = 1, 4 do
        local localizationIndex = resDungeonMonster.failedDesc[i]
        if localizationIndex ~= nil and localizationIndex ~= 0 then
          if i <= 3 then
            REF["LabelHint" .. i].gameObject:SetActive(true)
            REF["LabelHint" .. i].UIHtmlLabel.text = WU.GetString("Window_DungeonFailedText" .. localizationIndex)
          elseif REF.LabelRightText then
            REF.LabelRightText.gameObject:SetActive(true)
            REF.LabelRightText.UIHtmlLabel.text = WU.GetString("Window_DungeonFailedText" .. localizationIndex)
          end
        elseif i <= 3 then
          REF["LabelHint" .. i].gameObject:SetActive(false)
        elseif REF.LabelRightText then
          REF.LabelRightText.gameObject:SetActive(false)
        end
      end
    else
      error("Dungeon", " dugneonId = " .. tostring(dungeonId))
    end
  end
end

function InitDungeonName()
  local labelText = ""
  if m_fightDungeonType == PB.enum.DungeonType.Tower then
    local floor = this:GetData("fci/tower/summary/").towerFloor
    if floor == 0 then
      floor = 1
    end
    labelText = WU.GetString("WindowTower_CurrentFloor", floor)
  elseif m_fightDungeonType == PB.enum.DungeonType.BurstLinkPvp or m_fightDungeonType == PB.enum.DungeonType.FriendPvp or m_fightDungeonType == PB.enum.DungeonType.RD then
    return
  else
    local dungeonId = this:GetData("WindowDungeon/DungeonId")
    if dungeonId then
      labelText = WU.GetString("DungeonName_" .. dungeonId)
    end
  end
  REF.DungeonName.UIHtmlLabel.text = labelText
end

function InitAcquirement()
  m_balance = this:GetData("DungeonBalance/result")
  m_rewards = DU.GetDungeonBalanceRewards(m_balance)
  if 0 < #m_rewards then
    LU.Bind(REF.AcquirementContent, {
      updateRow = UpdateSlot
    })
    LU.Set(REF.AcquirementContent, #m_rewards)
    REF.AcquirementContent.UIPlayTween:Play(true)
    local newActors = m_rewards:where(function(k, v)
      return v.actor
    end):select(function(v)
      return v.actor
    end):toarray()
    WU.ShowNewActorGet(newActors)
  end
  if m_fightDungeonType == PB.enum.DungeonType.DungeonType_Maze then
    UpdateMazeInfo(m_balance)
  end
end

function UpdateMazeInfo(balance)
  if balance.autoMove.mazeInfo then
    local mazeActivityId = this:GetData("MazeActivityId")
    local mazeInfo = this:GetData("fci/MazeInfo/")
    if mazeInfo then
      mazeInfo = balance.autoMove.mazeInfo
      this:SetData("fci/MazeInfo/", mazeInfo)
      this:SetData("MazePlayerIndex", mazeInfo.playerCellIndex)
    end
    local mazeCellIndex = this:GetData("MazeSelectIndex")
    local mazeCell
    if mazeCellIndex and mazeCell == nil then
      this:GameRequest("fci/Maze/Summary/" .. mazeActivityId .. "/"):Get(function(res)
        this:SetData("fci/MazeInfo/", res.mazeInfo)
      end)
    end
    DB:GameRequest("fci/Maze/Actor/" .. mazeActivityId .. "/"):Get(function(res)
      AU.OnGetMazeActorPool(res)
    end)
  end
end

function InitLoseSign()
  if m_fightDungeonType == PB.enum.DungeonType.BurstLinkPvp then
    local balance = this:GetData("DungeonBalance/result")
    local maxLoseCount = PB.all("Misc"):first().pvpMaxDieNum
    WU.ToggleRendering(REF.WidgetLoseSignGridL, true)
    REF.WidgetLoseSignGridL["$SetStar"](balance.failNum, maxLoseCount - balance.failNum, true)
  end
end

function UpdateSlot(gameObject, wrapIndex, realIndex)
  if m_rewards and realIndex < #m_rewards then
    local reward = m_rewards[realIndex + 1]
    if reward.baseRes then
      _ENV["$"](gameObject)["$$SetData"](reward.baseRes.type, reward.baseRes.id, reward.baseRes.count)
    elseif reward.actor then
      _ENV["$"](gameObject)["$$SetActor"](reward.actor)
    elseif reward.equip then
      _ENV["$"](gameObject)["$$SetEquip"](reward.equip)
      _ENV["$"](gameObject)["$$SetClickCallback"](function()
        WU.ShowEquipDetailByUid(reward.equip.uid, {
          enhance = false,
          equipped = false,
          share = false
        })
      end)
    end
  end
end

function OnActorGroupConfirm(groups)
  if groups == nil then
    return
  end
  m_canTowerContinue = false
  for i, v in pairs(groups) do
    if not GU.TowerGroupIsDead(v.members) then
      m_canTowerContinue = true
      return
    end
  end
end

function ShowRecommendPlan(members, dungeonId)
  if members == nil then
    return
  end
  local testResult = DU.CultivationReachExpection(members, dungeonId)
  if testResult == nil or testResult.isReach or DB:GetData("IsCultivationPVPMode") then
    return
  end
  WU.SetActive(REF.NodeRecommend, true)
  local actor = testResult.suggest
  local tabName = AU.GetImprovePart(actor)
  local key = string.sub(tabName, string.len("Tab") + 1)
  local actorName = WU.GetString("ActorName_" .. tostring(actor.id))
  local actorConfig = PB.get("ActorConfig", actor.id)
  REF.ActorHead.UITexture.mainTexturePath = "Texture/ActorInfightHead/sub_2/infight_head_" .. actorConfig.animRes
  REF.ActorBg.UISprite.spriteName = "sub_friend_bg_" .. actor.quality
  REF.ActorMask.UISprite.spriteName = "head_mask_" .. actor.quality
  REF.LabelLevel.UILabel.text = "Lv." .. actor.level
  REF.LabelStar.UILabel.text = actor.star
  REF.LabelRecommand.UILabel.text = WU.GetString("ActorRecommend_CultivationTooLow") .. WU.GetString("ActorRecommend_" .. key, actorName)
  WU.BindButtonEvent(REF.BtnGotoRecommend, function()
    local param = {
      gotoAble = true,
      key = key,
      actor = actor
    }
    this:SetData("DungeonBalanceRecommendInfo", param)
    DU.LeaveDungeon(2)
  end)
end
