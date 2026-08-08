local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local NU = require("Common/NotepadUtil")
local IU = require("Common/ItemUtil")
local DU = require("Common/DungeonUtil")
local LU = require("Common/ListUtil")
local BASE = inherit("Window/DungeonBalance/DungeonBalanceBase", _ENV)
local m_upColor = 1927741439
local m_downColor = 4250162431
local m_balance, m_rewards, m_skipAnim, m_isRecord

function SetupWindow()
  WU.ToggleRendering(REF.AnimMask, false)
  WU.ToggleRendering(REF.NodeContinue, false)
  WU.BindButtonEvent(REF.NodeContinue, function()
    local leave = fif(m_balance.isWin, 1, 2)
    DU.LeaveDungeon(leave, "Activity, RandomCallJoin")
  end)
  WU.BindButtonEvent(REF.AnimMask, function()
    m_skipAnim = true
    WU.ToggleRendering(REF.AnimMask, false)
    OnTweenFinish()
  end)
end

function InitWindow()
  m_balance = this:GetData("DungeonBalance/result")
  WU.ToggleRendering(REF.AnimMask, true)
  local fightActorInfo = this:GetData("TopPvpFightActorInfo")
  local matchInfo = this:GetData("RandomCall/MatchInfo")
  local myAc = this:GetData("RandomCall/Actors")
  local opn = this:GetData("RandomCall/OpnPool")
  SetPlayerInfo(_ENV["$"](REF.Player1), myAc, m_balance.isWin)
  SetPlayerInfo(_ENV["$"](REF.Player2), opn, not m_balance.isWin)
  REF.LabelTitle.UILabel.text = WU.GetString("TopPvpJoin_Tips59")
  OnTweenFinish()
end

function SetResultInfo(ref, data)
end

function SetPlayerInfo(ref, data, isWin)
  ref.LabelName.UILabel.text = data.name
  ref.SpriteWin.gameObject:SetActive(isWin)
  local group = {}
  group.members = {}
  for i = 1, 6 do
    local member = data[i]
    if member and member.id and member.id > 0 then
      group.members[i] = {actor = member}
    else
      group.members[i] = {}
    end
  end
  ref.WidgetDungeonGroup["$SetView"](group)
end

function OnTweenFinish()
  WU.ToggleRendering(REF.AnimMask, false)
  WU.ToggleRendering(REF.NodeContinue, true)
end
