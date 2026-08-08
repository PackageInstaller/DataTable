local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local m_rankList, m_myPlayerId, m_setGuildValidate

function Focus(on)
  if m_setGuildValidate then
    local guildId = this:GetData("guildId")
    DungeonGuild_ValidateRestrictions(guildId)
  end
end

function SetRankList(titleName, rankList)
  m_setGuildValidate = false
  REF.LabelTitle.UILabel.text = titleName
  m_rankList = rankList
  m_myPlayerId = this:GetData("playerId")
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateRankSlot
  })
  LU.Set(REF.WrapContent, #m_rankList)
  UpdateSelfUI()
end

function SetGuildValidate()
  m_setGuildValidate = true
  this:Bind("guildId", DungeonGuild_ValidateRestrictions)
end

function UpdateRankSlot(slotRef, wrapIndex, realIndex)
  local index = realIndex + 1
  if m_rankList == nil or index > #m_rankList then
    return
  end
  local member = m_rankList[index]
  slotRef.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](member.baseInfo)
  slotRef.LabelName.UIHtmlLabel.text = member.baseInfo.name
  slotRef.LabelScore.UIHtmlLabel.text = member.playerContribution.contributionDegree
  slotRef.LabelNum.UILabel.text = index
end

function UpdateSelfUI()
  local index, myRank = table.find(m_rankList, function(k, v)
    return v.baseInfo.playerId == m_myPlayerId
  end)
  local slotRef = _ENV["$"](REF.NodeSelf)
  local indexText = fif(index ~= nil, index, "\226\128\148\226\128\148")
  local score = 0
  if myRank then
    score = myRank.playerContribution and myRank.playerContribution.contributionDegree or 0
  end
  slotRef.LabelMyRank.UIHtmlLabel.text = indexText
  slotRef.LabelMyScore.UIHtmlLabel.text = "<img src='ResIcon_s.guild_coin_2'/>&nbsp;" .. score
end

function UninitWindow()
  m_rankList = nil
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
