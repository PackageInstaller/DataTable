local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local FU = require("Common/FriendUtil")
local CU = require("Common/ChatUtil")
local GuildUtil = require("Common/GuildUtil")
local AU = require("Common/ActorUtil")
local m_playerId, m_playerName, m_guildId, m_isBlocked
local m_hasClickLike = false
local m_playerInfo
local mNormalLikeTextColor = CS.NGUIMath.HexToColor(26864127)
local mEnableLikeTextColor = CS.NGUIMath.HexToColor(4294967295)
local m_baseInfo, m_isMySelfSpace, m_selfPlayerId

function SetupWindow()
  WU.BindButtonEvent(REF.PrivateTalkButton, OnPrivateTalk)
  WU.BindButtonEvent(REF.ReportButton, OnPlayerReport)
  WU.BindButtonEvent(REF.BlacklistButton, OnBlacklist)
  WU.BindButtonEvent(REF.ButtonUnblock, OnBlacklist)
  WU.BindButtonEvent(REF.BtnAddFriend, OnAddFriend)
  WU.BindButtonEvent(REF.PlayerSpace, OnPlayerSpace)
  WU.BindButtonEvent(REF.BtnGuildDetail, OnGuildDetailClick)
  WU.BindButtonEvent(REF.BtnGuildInvite, OnGuildInviteClick)
  WU.BindButtonEvent(REF.BtnViewMedals, OnViewMedalsClick)
  WU.BindButtonEvent(REF.NodeStar, OnClickLike)
end

function InitWindow()
  WU.ToggleRendering(REF.Content, false)
end

function SetByResult(result)
  m_playerId = result.playerId
  m_playerName = result.name
  m_guildId = result.guildId
  m_playerInfo = result
  m_isMySelfSpace = m_playerId == m_selfPlayerId
  REF.PlayerNameLabel.UILabel.text = m_playerName
  REF.PlayerSexSprite.UISprite.spriteName = FU.GetGenderIcon(result.sex, true)
  REF.PlayerLevelLabel.UILabel.text = WU.GetString("Window_Level", result.level)
  local levelName, curTrophy = AU.GetAchievementInfo(result.achievementPoint)
  REF.PlayerAcivimentSprite.UISprite.spriteName = "cup_icon_" .. curTrophy
  if U.trim(result.sign) == "" then
    REF.Sign.UILabel.text = WU.GetString("Window_SpaceSignEmpty")
  else
    REF.Sign.UILabel.text = result.sign
  end
  REF.PlayerOffTimeLabel.UIHtmlLabel.text = FU.LastLogoutTime(result.lastLogoutTime, REF.PlayerOffTimeLabel.UIHtmlLabel.fontSize)
  REF.BtnFriend.gameObject:SetActive(not result.isInRelation)
  REF.BtnAddFriend.gameObject:SetActive(not result.isApplied)
  REF.BtnIsApplied.gameObject:SetActive(result.isApplied)
  m_isBlocked = FU.IsBlock(result.playerId)
  REF.BlacklistButton.gameObject:SetActive(not m_isBlocked)
  REF.ButtonUnblock.gameObject:SetActive(m_isBlocked)
  REF.ButtonNode.UIGrid:Reposition()
  REF.WidgetMedalsGroup["$SetData"](m_playerInfo.allMedals, m_playerInfo.fightMedal)
  local groupActors = {}
  for index = 1, 6 do
    if result.showGroup and result.showGroup.members[index] then
      table.insert(groupActors, result.showGroup.members[index].actor)
    end
  end
  REF.WidgetDungeonGroup["$SetViewByActors"](groupActors)
  REF.WidgetDungeonGroup["$SetSpriteLine"](false)
  this:GameRequest("fci/PageClickLikeView/" .. m_playerId):Get(function(result)
    if result then
      m_hasClickLike = result.isClicked
      UpdateStar()
    end
  end)
  SetAura(m_playerInfo)
  if m_playerId == this:GetData("playerId") then
    this:Bind("Msdk/baseinfo/", function(msdkBaseinfo)
      if msdkBaseinfo ~= nil and result.sex == PB.enum.PlayerSex.None then
        REF.PlayerSexSprite.UISprite.spriteName = FU.GetGenderIcon(msdkBaseinfo.gender)
      end
    end)
  else
    this:Bind("fci/socialfriend/", function(socialFriendList)
      if socialFriendList ~= nil then
        local _, player = table.find(socialFriendList, function(_, v)
          return v.playerInfo.playerId == m_playerId
        end)
        if player ~= nil and player.playerInfo.sex == PB.enum.PlayerSex.None then
          REF.PlayerSexSprite.UISprite.spriteName = FU.GetGenderIcon(player.msdkInfo.gender)
        end
      end
    end)
  end
  REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](result, 1)
  WU.ToggleRendering(REF.Content, true)
  WU.ToggleRendering(REF.BtnGuildDetail, false)
  WU.ToggleRendering(REF.BtnGuildInvite, false)
  WU.ToggleRendering(REF.LabelInvited, false)
  if 0 < m_guildId then
    REF.LabelGuild.UILabel.text = ""
    this:GameRequest("fci/guild/" .. m_guildId):Get(function(guild)
      if guild then
        REF.LabelGuild.UILabel.text = guild.baseInfo.name
        this:SetData("fci/guild/" .. m_guildId, guild.baseInfo)
      end
    end)
    WU.ToggleRendering(REF.BtnGuildDetail, true)
  else
    REF.LabelGuild.UILabel.text = WU.GetString("Window_GuildNotExist")
    local guildPlayer = this:GetData("fci/guild-player/")
    local invitedMembers = this:GetData("fci/guild/invited-members/")
    if guildPlayer.guildId > 0 and invitedMembers then
      if _ENV["!"](invitedMembers):find(function(k, v)
        return v.playerId == m_playerId
      end) then
        WU.ToggleRendering(REF.LabelInvited, true)
      else
        local locked = WU.WindowIsLocked(PB.enum.UnlockWindow.Guild, nil, result.level)
        WU.ToggleRendering(REF.BtnGuildInvite, not locked and GuildUtil.IsGuildManager())
      end
    end
  end
end

function SetPlayerDetail(idOrName, type)
  if idOrName ~= nil then
    local byid = 0
    if type == "id" then
      byid = 1
    end
    this:GameRequest("fci/playersummary/" .. idOrName):Query("byid", byid):Get(function(result)
      SetByResult(result)
    end, function()
      WU.RecycleWindow(this)
    end)
  end
end

function OnAddFriend()
  this:GameRequest("fci/applyfriend/"):Post({targetId = m_playerId}, function(result)
    REF.BtnAddFriend.gameObject:SetActive(false)
    WU.ShowHintText(WU.GetString("Window_SendFriendApply"))
    REF.BtnIsApplied.gameObject:SetActive(true)
  end)
end

function OnPrivateTalk()
  WU.RecycleWindow(this)
  CU.PrivateTalk({playerId = m_playerId, name = m_playerName})
end

function OnPlayerSpace()
  WU.RecycleWindow(this)
  WU.ShowPlayerSpace(m_playerId, nil, "ToggleTeam")
end

function OnPlayerReport()
  WU.AcquireWindowAsync("PlayerReport", function(ui)
    _ENV["$"](ui).root["$SetPlayerId"](m_playerId)
  end)
end

function OnBlacklist()
  if m_isBlocked then
    FU.UnblockPlayer(m_playerId)
    WU.RecycleWindow(this)
  else
    WU.ShowMessageYesNo(WU.GetString("Window_BlacklistHint"), function(result)
      if result == "YES" then
        FU.BlockPlayer(m_playerId)
        WU.RecycleWindow(this)
      end
    end)
  end
end

function OnGuildDetailClick()
  local guild = this:GetData("fci/guild/" .. m_guildId)
  if guild then
    WU.RecycleWindow(this)
    WU.AcquireWindowAsync("GuildDetail", function(ui)
      _ENV["$"](ui)["$$SetData"](guild)
    end)
  end
end

function OnGuildInviteClick()
  if GuildUtil.IsGuildManager() then
    this:GameRequest("fci/guild/{guildId}/invited-members/"):Put({playerId = m_playerId}, function(result)
      local invitedMembers = this:GetData("fci/guild/invited-members")
      table.insert(invitedMembers, result)
      this:SetData("fci/guild/invited-members", invitedMembers)
      WU.ToggleRendering(REF.BtnGuildInvite, false)
      WU.ToggleRendering(REF.LabelInvited, true)
      WU.ShowHintText(WU.GetString("Window_GuildInvitationSent"))
    end)
  end
end

function UpdateStar()
  if m_hasClickLike then
    REF.SpriteStarB02.UISprite.spriteName = "praise_bar_2"
    REF.LikeIconB.UISprite.spriteName = "like_n"
  else
    REF.SpriteStarB02.UISprite.spriteName = "praise_bar_1"
    REF.LikeIconB.UISprite.spriteName = "like_s"
  end
  if m_playerInfo and m_playerInfo.likeNums then
    UpdateLikeNumber(m_playerInfo.likeNums)
  else
    UpdateLikeNumber(0)
  end
end

function OnClickLike()
  if m_playerInfo and not m_hasClickLike then
    REF.NodeStarBG.UIPlayTween:Play(true)
    this:GameRequest("fci/PageClickLikeView/" .. m_playerInfo.playerId):Post(nil, function(result)
      if result then
        if m_playerInfo.likeNums and result.isClicked == true then
          m_playerInfo.likeNums = m_playerInfo.likeNums + 1
        end
        m_hasClickLike = result.isClicked
        UpdateStar()
      end
    end)
  end
end

function UpdateLikeNumber(num)
  if m_hasClickLike then
    REF.LabelStarCntB.UILabel.color = mEnableLikeTextColor
  else
    REF.LabelStarCntB.UILabel.color = mNormalLikeTextColor
  end
  if 9999 < num then
    num = 9999
  end
  REF.LabelStarCnt.UILabel.text = tostring(num)
  REF.LabelStarCntB.UILabel.text = tostring(num)
end

function SetAura(playerInfo)
  local ref = REF.WidgetIconSlotAssist
  if playerInfo.auraActorId ~= nil and playerInfo.auraActorId > 0 then
    WU.ToggleRendering(REF.SpriteSlotBGAura, false)
    WU.ToggleRendering(REF.WidgetIconSlotAssist, true)
    local actorId = playerInfo.auraActorId
    ref["$SetActorCustom"]({
      id = actorId,
      quality = playerInfo.auraActorQuality
    })
  else
    WU.ToggleRendering(REF.SpriteSlotBGAura, not m_isMySelfSpace)
    WU.ToggleRendering(REF.WidgetIconSlotAssist, m_isMySelfSpace)
    ref["$SetEmpty"](1)
  end
  ref["$SetClickCallback"](function()
    if m_isMySelfSpace then
      WU.AcquireWindowAsync("MySpaceAuraEdit")
    else
      WU.AcquireWindowAsync("ItemDetail", function(window)
        _ENV["$"](window)["$$SetAuraActor"](m_playerInfo.auraActorId, m_playerInfo.auraActorQuality)
      end)
    end
  end)
end

function OnViewMedalsClick()
  WU.ShowPlayerSpace(m_playerId, nil, "ToggleMedalList")
  WU.RecycleWindow(this)
end
