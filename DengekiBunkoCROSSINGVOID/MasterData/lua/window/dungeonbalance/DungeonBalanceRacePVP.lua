local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local SDU = require("Common/SoundUtil")
local DBH = require("Manager/DataBindingHandler")
local BASE = inherit("Window/DungeonBalance/DungeonBalanceBase", _ENV)
local m_cost, m_dungeonId

function SetupWindow()
  WU.ToggleRendering(REF.BottomButtons, false)
  WU.BindButtonEvent(REF.ButtonContinue, OnBackClick)
  WU.BindButtonEvent(REF.ButtonFightAgain, OnButtonAgainClick)
  WU.BindButtonEvent(REF.ButtonShare, function()
    WU.RecordButtonClick(901)
    this:SetData("ShareConfig", {
      shareName = "RacePVP",
      fromWindow = WU.TopWindow() and WU.TopWindow().name
    })
    local groups = DB:GetData("fci/ActorGroup/")
    if groups then
      local allActors = DB:GetData("fci/actor/")
      local selectActorGroupId = DB:GetData("fci/SelectedGroupId/racePVP").selectActorGroupId
      local members = groups[tostring(selectActorGroupId)].members
      local balance = this:GetData("DungeonBalance/result")
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
      local racePvpInfo = this:GetData("fci/RacePVPInfo")
      local data = {
        actorIds = actorIds,
        highScore = balance.highBattleScore,
        seg = racePvpInfo.grade.seg,
        subSeg = racePvpInfo.grade.subSeg
      }
      this:SetData("Share/RacePVP", data)
      WU.AcquireWindowAsync("Share")
    end
  end)
end

function InitWindow()
  m_dungeonId = this:GetData("WindowDungeon/DungeonId")
  local dungeonReward = PB.get("DungeonReward", m_dungeonId)
  if dungeonReward then
    m_cost = dungeonReward.cost[1]
    if m_cost ~= nil then
      REF.LabelCost.ResourcePrinter:SetResource(m_cost.type, m_cost.id, m_cost.count)
    end
  else
    warning("DungeonReward not found", m_dungeonId)
  end
  local balance = this:GetData("DungeonBalance/result")
  REF.LabelCurRecord.UILabel.text = balance.curBattleScore
  REF.LabelTopRecord.UILabel.text = balance.highBattleScore
  local displayActorID
  local fightData = this:GetData("FightAgainInfo")
  local actorList = {}
  for i, v in pairs(fightData[1].actors) do
    if v.id ~= 0 then
      displayActorID = v.id
      break
    end
  end
  BASE.SetActorTextureEffect(displayActorID)
  WU.SetActive(REF.ButtonShare, balance.curBattleScore == balance.highBattleScore)
end

function OnDestroy()
  BASE.OnDestroy()
end

function OnBackClick()
  DU.LeaveDungeon(1)
end

function OnButtonAgainClick()
  WU.TryToPay(m_cost.type, m_cost.id, m_cost.count, EnterDungeon)
end

function EnterDungeon()
  this:SetData("FightActorInfo", this:GetData("FightAgainInfo"))
  local param = {
    dungeonId = m_dungeonId,
    selectActorGroupId = this:GetData(this:GetData("ActorGroup/SelectedGroupIdUri")).selectActorGroupId
  }
  this:GameRequest("fci/racepvp-dungeon/"):Post(param, function(response)
    DBH.ResChange(response.resChange)
    this:BroadcastGameEvent("MedalAttrAppend")
    WU.EnterGameLevel(response.dungeonUid, response.baseInfo, m_dungeonId, PB.enum.DungeonType.RacePVP, 1, false)
  end)
end
