local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local NU = require("Common/NotepadUtil")
local IU = require("Common/ItemUtil")
local DU = require("Common/DungeonUtil")
local LU = require("Common/ListUtil")
local TPU = require("Common/TopPvpUtil")
local BASE = inherit("Window/DungeonBalance/DungeonBalanceBase", _ENV)
local m_upColor = 1927741439
local m_downColor = 4250162431
local m_balance, m_rewards, m_skipAnim, m_isRecord, m_enemyPlayerId

function SetupWindow()
  WU.ToggleRendering(REF.AnimMask, false)
  WU.ToggleRendering(REF.NodeContinue, false)
  WU.BindButtonEvent(REF.NodeContinue, BASE.OnButtonContinueClick)
  WU.BindButtonEvent(REF.NodeAgainFight, FriendPVPFightAgain)
  WU.BindButtonEvent(REF.AnimMask, function()
    m_skipAnim = true
    WU.ToggleRendering(REF.AnimMask, false)
    OnTweenFinish()
  end)
end

function FriendPVPFightAgain()
  this:SetData("RecordReturnWindow", "RelationPortal,Friend")
  this:SetData("TopPvpFriendBalanceInfo", {playerId = m_enemyPlayerId})
  BASE.OnButtonContinueClick()
end

function InitWindow()
  m_balance = this:GetData("DungeonBalance/result")
  WU.ToggleRendering(REF.AnimMask, true)
  local fightActorInfo = this:GetData("TopPvpFightActorInfo")
  local myInfo, enemyInfo
  for i, v in ipairs(fightActorInfo) do
    if v.playerId == this:GetData("playerId") then
      myInfo = v
    else
      enemyInfo = v
      m_enemyPlayerId = v.playerId
    end
  end
  SetPlayerInfo(_ENV["$"](REF.Player1), myInfo, m_balance.win)
  SetPlayerInfo(_ENV["$"](REF.Player2), enemyInfo, not m_balance.win)
  REF.LabelTitle.UILabel.text = WU.GetString("TopPvpJoin_Tips59")
  OnTweenFinish()
end

function SetResultInfo(ref, data)
end

function SetPlayerInfo(ref, data, isWin)
  ref.LabelName.UILabel.text = data.name
  local score = 0
  if data.score then
    score = data.score
  end
  local segID = TPU.GetCurSegInfo(score).seg
  ref.SpriteSeg.UITexture.mainTexturePath = string.format("Texture/PVP/pvp_stage_%d", segID)
  ref.SpriteWin.gameObject:SetActive(isWin)
  local group = {}
  group.members = {}
  for i = 1, 6 do
    local member = data.members[i]
    if member and member.id and 0 < member.id then
      local temp = {}
      temp.actor = member
      group.members[i] = temp
    else
      local temp = {}
      group.members[i] = temp
    end
  end
  ref.WidgetDungeonGroup["$SetView"](group)
end

function OnTweenFinish()
  WU.ToggleRendering(REF.AnimMask, false)
  WU.ToggleRendering(REF.NodeContinue, true)
end
