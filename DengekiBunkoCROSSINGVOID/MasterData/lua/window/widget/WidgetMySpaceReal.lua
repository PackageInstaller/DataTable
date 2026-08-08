local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local CU = require("Common/ChatUtil")
local U = require("Common/Util")
local FU = require("Common/FriendUtil")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local NU = require("Common/NotepadUtil")
local GuildUtil = require("Common/GuildUtil")
local PU = require("Common/PlatformUtil")
local LU = require("Common/ListUtil")
local DeclareCharacterLimit = 32
local MessagePerPage = 6
local permissionPB = {
  PB.enum.PlayerMessageBoardPermission.Anyone,
  PB.enum.PlayerMessageBoardPermission.OnlyFriends,
  PB.enum.PlayerMessageBoardPermission.OnlySelf
}
local m_repeatedContext = {}
local Msdk = CS.Msdk
local m_hasNext, m_playerInfo, m_isMySelfSpace, m_selectedGroupId, m_selfPlayerId, m_playerId, m_curPageNumber, m_messages, m_messageTo, m_messageSetting, m_allowLeaveMessage
local mNormalLikeTextColor = CS.NGUIMath.HexToColor(26864127)
local mEnableLikeTextColor = CS.NGUIMath.HexToColor(4294967295)
local m_allMedals, m_medalList, m_baseInfo, m_medalListNotFight, m_isLocked, m_unLockLevel, m_resetToggle
local m_collectionsCount = _ENV["!"]({})
local m_collections = _ENV["!"]({})

function Awake()
  REF.NodeGenders.gameObject:SetActive(true)
  REF.NodeTeam.gameObject:SetActive(true)
  REF.NodeFavorite.gameObject:SetActive(true)
  REF.NodeMessageBoard.gameObject:SetActive(true)
  REF.NodeMedalList.gameObject:SetActive(true)
  REF.NodeAchievementMask.gameObject:SetActive(true)
  REF.SpriteMessageRedPoint.gameObject:SetActive(false)
  REF.NodeCollections.gameObject:SetActive(true)
  UpdateLikeNumber(0)
  WU.BindButtonEvent(REF.NodePlayerGender, OnClickPlayerGender)
  WU.BindButtonEvent(REF.NodeAchievement, OnClickAchievement)
  WU.BindButtonEvent(REF.NodePlayerDeclare, OnClickPlayerDeclare)
  WU.BindButtonEvent(REF.NameNode, OnNamePatch)
  WU.BindButtonEvent(REF.ButtonDungeonGroup, OnClickMember)
  WU.BindButtonEvent(REF.ButtonShowMedals, function()
    WU.AcquireWindowAsync("MedalSelection", function(window)
      _ENV["$"](window)["$$SetMode"](1)
    end)
  end)
  WU.BindButtonEvent(REF.Books, OnClickFavBook)
  WU.BindButtonEvent(REF.SpriteSend, OnMessageSubmit)
  WU.BindButtonEvent(REF.GenderMask, function()
    WU.ToggleRendering(REF.NodeGenders, false)
  end)
  WU.BindButtonEvent(REF.SettingMask, function()
    WU.ToggleRendering(REF.SettingDetailNode, false)
  end)
  WU.BindButtonEvent(REF.SpaceSettings, function()
    WU.RecordButtonClick(1001370144)
    WU.ToggleRendering(REF.SettingDetailNode, true)
  end)
  WU.TraverseChildren(REF.GenderGrid, function(go, i)
    WU.BindButtonEvent(go, function()
      local patchTable = {
        sex = i + 1
      }
      local wireFormatTable = ProtobufT("ApiRelationPlayerPageInfo", patchTable)
      this:GameRequest("fci/playerpageinfo/"):Patch(wireFormatTable, function(result)
        this:SetData("Space/SelectedPlayer", result)
        WU.ToggleRendering(REF.NodeGenders, false)
      end)
    end)
  end)
  WU.TraverseChildren(REF.Actors, function(go, i)
    WU.BindButtonEvent(go, OnClickFavActor)
  end)
  WU.TraverseChildren(REF.SettingGrid, function(go, i)
    WU.BindButtonEvent(go, function()
      for i = 1, #REF.SettingGrid do
        REF.SettingGrid[i - 1].CheckBoxSprite.UISprite.spriteName = "checkbox_n"
      end
      i = i + 1
      WU.RecordButtonClick(100137014 .. i)
      _ENV["$"](go).CheckBoxSprite.UISprite.spriteName = "checkbox_s"
      local patchTable = {
        messageBoardPermission = permissionPB[i]
      }
      local wireFormatTable = ProtobufT("ApiRelationPlayerPageInfo", patchTable)
      this:GameRequest("fci/playerpageinfo/"):Patch(wireFormatTable, function(result)
      end)
    end)
  end)
  WU.BindButtonEvent(REF.ToggleMessage, function()
    WU.RecordButtonClick(100137014)
    if m_isLocked then
      ShowUnLockHint()
      return
    end
    REF.SpriteMessageRedPoint.gameObject:SetActive(false)
    WU.SetGameDataCache("MySpaceMessageRed", false)
    WU.ToggleRendering(REF.TryToDeleteMask, false)
    this:BroadcastGameEvent("ResetAllDeleteBtn")
    REF.MsgScrollView.UIScrollView:ResetPosition()
  end)
  WU.BindButtonEvent(REF.ToggleFavorite, function()
    WU.RecordButtonClick(100137012)
    if m_isLocked then
      ShowUnLockHint()
    end
  end)
  WU.BindButtonEvent(REF.ToggleMedalList, function()
    WU.RecordButtonClick(100137013)
    if m_isLocked then
      ShowUnLockHint()
    end
  end)
  WU.BindButtonEvent(REF.ToggleCollections, function()
    if m_isLocked then
      ShowUnLockHint()
    end
  end)
  CS.EventDelegate.Add(REF.MsgScrollView.UIScrollView.onNext, OnNext)
  CS.EventDelegate.Add(REF.MsgScrollView.UIScrollView.onPrev, function()
  end)
  WU.BindButtonEvent(REF.TryToDeleteMask, function()
    WU.ToggleRendering(REF.TryToDeleteMask, false)
    this:BroadcastGameEvent("ResetAllDeleteBtn")
  end)
  WU.BindButtonEvent(REF.ButtonRename, function()
    WU.RecordButtonClick(1001370112)
    REF.ButtonRename["$OnRenameClick"]()
  end)
  WU.BindButtonEvent(REF.ButtonContactCustomerService, OnClickContactCustomerService)
  WU.BindButtonEvent(REF.ButtonLogout, OnLogoutClick)
  WU.BindButtonEvent(REF.BtnGuildDetail, OnGuildDetailClick)
  WU.BindButtonEvent(REF.BtnGuildInvite, OnGuildInviteClick)
  WU.SetActive(REF.BtnFacebookShare, WU.IsShareSwitchOn())
  SetupMedalList()
  SetupCollectionList()
  REF.ContactFacebook.gameObject:SetActive(false)
  local accountCache = this:GetData("accountCache")
  local platform = U.ToEnum(CS.Msdk.ePlatform, accountCache.socialPlatform)
  local url
  if platform == CS.Msdk.ePlatform.ePlatform_Weixin then
    REF.ButtonWechat.gameObject:SetActive(true)
    WU.SetActive(REF.ContactWeChat, false)
    WU.BindButtonEvent(REF.ButtonWechat, OnClickWechat)
    REF.ContactWeibo.transform.localPosition = CS.UnityEngine.Vector3(206, 4, 0)
  elseif platform == CS.Msdk.ePlatform.ePlatform_QQ then
    WU.SetActive(REF.ButtonWechat, false)
    WU.SetActive(REF.ContactWeChat, true)
  end
  REF.ButtonLogout.gameObject:SetActive(true)
  REF.ButtonMemberCenter.gameObject:SetActive(false)
  REF.ButtonContactCustomerService.gameObject:SetActive(false)
  REF.ButtonContactCustomerService.gameObject:SetActive(this:GetData("AccountSwitch").customService)
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  WU.BindButtonEvent(REF.ButtonShare, function()
    WU.RecordButtonClick(901)
    this:SetData("ShareConfig", {
      shareName = "WidgetMySpaceReal",
      fromWindow = WU.TopWindow() and WU.TopWindow().name,
      disableTopRight = true
    })
    local data = {}
    this:SetData("Share/WidgetMySpaceReal", data)
    WU.AcquireWindowAsync("Share")
  end)
end

function UpdateLikeNumber(num)
  REF.LabelStarCntB.UILabel.color = mEnableLikeTextColor
  if 9999 < num then
    num = 9999
  end
  REF.LabelStarCntB.UILabel.text = tostring(num)
end

function OnEnable()
  m_isLocked, m_unLockLevel = WU.WindowIsLocked(PB.enum.UnlockWindow.Friend, nil)
  this:Bind("Space/SelectedPlayer", OnPlayerInfo)
  this:Bind("fci/baseinfo/", OnSetBaseInfo)
  this:RegisterGameEvent("OnLinkClick", function(param)
    if string.find(param, "MessageTo") then
      m_messageTo = U.SplitStr(param, ":")[2]
      REF.InputComment.UIInput.isSelected = true
    end
  end)
  this:RegisterGameEvent("SpaceMessageDeleted", function(msgId)
    local idx = table.find(m_messages, function(k, v)
      return v.id == msgId
    end)
    if idx ~= nil then
      table.remove(m_messages, idx)
    end
    RefreshMessages()
  end)
  this:RegisterGameEvent("TryToDeleteMask", function()
    WU.ToggleRendering(REF.TryToDeleteMask, true)
  end)
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  WU.SetActive(REF.BtnFacebookShare, WU.IsShareSwitchOn())
  this:Bind("fci/resource/ResPlayerExp_0", OnSetExpInfo)
  WU.ToggleRendering(REF.WrapContent, false)
  local accountCache = this:GetData("accountCache")
  WU.ToggleRendering(REF.LabelIsRealNameAccount, accountCache and accountCache.realnameFlag)
  if m_playerInfo then
    OnListChange(m_playerInfo.allMedals, m_playerInfo.fightMedal)
  end
  local baseinfo = DB:GetData("fci/baseinfo")
  WU.SetActive(REF.ButtonShare, baseinfo.level >= 4)
  SetLockWindow()
end

function OnDisable()
  this:Unbind("Space/SelectedPlayer", OnPlayerInfo)
  this:SetData("Space/DisplayInfo", nil)
  m_resetToggle = nil
end

function OnWindowUninited(window)
  if window.name == "Share" and WU.IsShareSwitchOn() then
    WU.SetActive(REF.BtnFacebookShare, true)
  end
end

function Update()
  REF.MsgTable.UITable:Reposition()
end

function UpdateStar()
  REF.SpriteStarB02.UISprite.spriteName = "setting/praise_bar_2"
  REF.LikeIconB.UISprite.spriteName = "like_n"
  if m_playerInfo and m_playerInfo.likeNums then
    UpdateLikeNumber(m_playerInfo.likeNums)
  else
    UpdateLikeNumber(0)
  end
end

function SetPlayerDetail(playerId, resetToggle)
  if playerId ~= nil then
    m_resetToggle = resetToggle
    if not m_isLocked then
      m_playerId = playerId
      this:GameRequest("fci/playerpageinfo/" .. playerId):Get(function(result)
        this:SetData("Space/SelectedPlayer", result)
      end)
    end
    m_curPageNumber = 0
    this:GameRequest("fci/player-message/" .. playerId):Page(m_curPageNumber, MessagePerPage):Get(function(result)
      if #result == MessagePerPage then
        m_hasNext = true
        m_curPageNumber = m_curPageNumber + 1
      else
        m_hasNext = false
      end
      m_messages = result
      RefreshMessages(true)
      WU.ToggleRendering(REF.NodeMessageBoard, true)
      ResetRedPoint(result)
    end)
  end
end

function Reset()
  m_messageTo = nil
  UpdateStar()
  m_selfPlayerId = this:GetData("playerId")
  REF.InputComment.UIInput.defaultText = WU.GetString("Window_DefaultTextForUIInput")
  WU.ToggleRendering(REF.NodeTeam, false)
  WU.ToggleRendering(REF.SettingDetailNode, false)
  WU.ToggleRendering(REF.NodeGenders, false)
  WU.ToggleRendering(REF.BtnGuildDetail, false)
  WU.ToggleRendering(REF.BtnGuildInvite, false)
  WU.ToggleRendering(REF.LabelInvited, false)
  WU.ToggleRendering(REF.NodeMessageBoard, false)
  WU.ToggleRendering(REF.NodeFavorite, false)
  WU.ToggleRendering(REF.Visual, false)
  WU.ToggleRendering(REF.Medals, false)
  WU.ToggleRendering(REF.Aura, false)
  WU.ToggleRendering(REF.NodeMedalList, false)
  WU.ToggleRendering(REF.NodeAchievementMask, false)
  WU.ToggleRendering(REF.NodeCollections, false)
end

function OnPlayerInfo(data)
  Reset()
  local isPrivilegeIgnore = false
  local channel = Msdk.WGPlatform.Instance:WGGetChannelId()
  isPrivilegeIgnore = PU.IsPrivilegeIgnore(channel)
  if data == nil then
    return
  end
  m_playerInfo = data
  m_isMySelfSpace = data.playerId == m_selfPlayerId
  REF.WidgetPersonalPlatform["$SetData"](data, not isPrivilegeIgnore, m_isMySelfSpace)
  REF.LabelPlayerName.UILabel.text = m_playerInfo.name
  REF.LabelPlayerID.UILabel.text = m_playerInfo.playerId
  REF.LabelLevel.UILabel.text = m_playerInfo.level
  local point = this:GetData("fci/resource/ResAchievementPoint_0")
  local levelName, curTrophy = AU.GetAchievementInfo(point)
  REF.PlayerAcivimentSprite.UISprite.spriteName = "cup_icon_" .. curTrophy
  REF.LabelAchievement.UILabel.text = levelName
  if U.trim(m_playerInfo.sign) == "" then
    if m_isMySelfSpace then
      REF.SignLabel.UILabel.text = WU.GetString("Window_SpaceSignEmptySelf", DeclareCharacterLimit)
    else
      REF.SignLabel.UILabel.text = WU.GetString("Window_SpaceSignEmpty")
    end
  else
    REF.SignLabel.UILabel.text = m_playerInfo.sign
  end
  REF.GenderSprite.UISprite.spriteName = FU.GetGenderIcon(m_playerInfo.sex or 0, true)
  UpdateStar()
  if m_isMySelfSpace then
    this:Bind("Msdk/baseinfo/", function(msdkBaseinfo)
      if msdkBaseinfo ~= nil and m_playerInfo.sex == PB.enum.PlayerSex.None then
        REF.GenderSprite.UISprite.spriteName = FU.GetGenderIcon(msdkBaseinfo.gender, true)
      end
    end)
  else
    this:Bind("fci/socialfriend/", function(socialFriendList)
      if socialFriendList ~= nil then
        local _, player = table.find(socialFriendList, function(_, v)
          return v.playerInfo.playerId == m_playerInfo.playerId
        end)
        if player ~= nil and m_playerInfo.sex == PB.enum.PlayerSex.None then
          REF.GenderSprite.UISprite.spriteName = FU.GetGenderIcon(player.msdkInfo.gender, true)
        end
      end
    end)
  end
  REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](data)
  REF.WidgetIconPlayerHeadPhoto["$SetClickCallback"](function()
    if not m_isMySelfSpace then
      return
    end
    WU.AcquireWindowAsync("MySpacePlayerHeadBox")
  end)
  WU.ToggleRendering(REF.Visual, true)
  if m_playerInfo.showGroup == nil then
    local members = {
      {index = 0, actorUid = 0},
      {index = 1, actorUid = 0},
      {index = 2, actorUid = 0},
      {index = 3, actorUid = 0},
      {index = 4, actorUid = 0},
      {index = 5, actorUid = 0}
    }
    m_playerInfo.showGroup = {}
    m_playerInfo.showGroup["1"] = {members = members}
  elseif m_playerInfo.showGroup["1"] == nil then
    local membersTable = m_playerInfo.showGroup
    m_playerInfo.showGroup = {}
    if membersTable == nil or table.count(membersTable.members) ~= 6 then
      membersTable = {
        members = {
          {index = 0, actorUid = 0},
          {index = 1, actorUid = 0},
          {index = 2, actorUid = 0},
          {index = 3, actorUid = 0},
          {index = 4, actorUid = 0},
          {index = 5, actorUid = 0}
        }
      }
    end
    m_playerInfo.showGroup["1"] = membersTable
  end
  local members = m_playerInfo.showGroup["1"].members
  local groupActors = {}
  for index = 1, 6 do
    if members and members[index] then
      table.insert(groupActors, members[index].actor)
    end
  end
  REF.WidgetDungeonGroup["$SetViewByActors"](groupActors)
  REF.WidgetDungeonGroup["$SetNodeAdd"](true)
  REF.WidgetDungeonGroup["$SetSpriteLine"](false)
  WU.ToggleRendering(REF.ButtonDungeonGroup, true)
  REF.Settings.gameObject:SetActive(m_isMySelfSpace)
  if not m_isMySelfSpace then
    REF.InputComment.UISprite.width = 960
  else
    REF.InputComment.UISprite.width = 850
  end
  if 0 < m_playerInfo.guildId then
    if m_isMySelfSpace then
      local guild = this:GetData("fci/guild/")
      if guild then
        REF.LabelGuild.UILabel.text = guild.name
      else
        REF.LabelGuild.UILabel.text = ""
      end
    else
      REF.LabelGuild.UILabel.text = ""
      this:GameRequest("fci/guild/" .. m_playerInfo.guildId):Get(function(guild)
        if guild then
          REF.LabelGuild.UILabel.text = guild.baseInfo.name
          this:SetData("fci/guild/" .. m_playerInfo.guildId, guild.baseInfo)
        end
      end)
    end
    WU.ToggleRendering(REF.BtnGuildDetail, true)
  else
    REF.LabelGuild.UILabel.text = WU.GetString("Window_GuildNotExist")
    if not m_isMySelfSpace then
      local guildPlayer = this:GetData("fci/guild-player/")
      local invitedMembers = this:GetData("fci/guild/invited-members/")
      if 0 < guildPlayer.guildId and invitedMembers then
        if _ENV["!"](invitedMembers):find(function(k, v)
          return v.playerId == m_playerInfo.playerId
        end) then
          WU.ToggleRendering(REF.LabelInvited, true)
        else
          local locked = WU.WindowIsLocked(PB.enum.UnlockWindow.Guild, nil, m_playerInfo.level)
          WU.ToggleRendering(REF.BtnGuildInvite, not locked and GuildUtil.IsGuildManager())
        end
      end
    end
  end
  local bilibiliMedalIndex = table.find(m_playerInfo.showMedals, function(k, v)
    return v == 80005
  end)
  if bilibiliMedalIndex then
    table.remove(m_playerInfo.showMedals, bilibiliMedalIndex)
  end
  if m_playerInfo.fightMedal == 80005 then
    m_playerInfo.fightMedal = nil
  end
  OnListChange(m_playerInfo.allMedals, m_playerInfo.fightMedal)
  SetMedals()
  WU.ToggleRendering(REF.Medals, true)
  WU.ToggleRendering(REF.NodeMedalList, true)
  SetFavorite(m_playerInfo)
  WU.ToggleRendering(REF.NodeFavorite, true)
  SetMessageSetting(m_playerInfo)
  SetAura(m_playerInfo)
  SetCollectionData()
  WU.ToggleRendering(REF.NodeCollections, true)
  WU.ToggleRendering(REF.Aura, true)
  WU.ToggleRendering(REF.NodeTeam, true)
  this:Bind("fci/friendlist/", function(friendlist)
    if friendlist ~= nil and not m_isMySelfSpace then
      local idx = table.find(friendlist, function(k, v)
        return v.playerId == m_playerInfo.playerId
      end)
      if idx == nil and m_messageSetting == PB.enum.PlayerMessageBoardPermission.Anyone then
        WU.ToggleRendering(REF.NodeInput, true)
      elseif idx ~= nil and m_messageSetting ~= PB.enum.PlayerMessageBoardPermission.OnlySelf then
        WU.ToggleRendering(REF.NodeInput, true)
      end
    end
    if m_isMySelfSpace then
      WU.ToggleRendering(REF.NodeInput, true)
    end
  end)
  WU.ToggleRendering(REF.NodeMessageBoard, true)
end

function SetAura(playerInfo)
  local ref = REF.WidgetIconSlotAssist
  if playerInfo.auraActorId ~= nil and playerInfo.auraActorId > 0 then
    local actorId = playerInfo.auraActorId
    ref["$SetActorCustom"]({
      id = actorId,
      quality = playerInfo.auraActorQuality
    })
  else
    ref["$SetEmpty"](3)
  end
  ref["$SetClickCallback"](function()
    if m_isMySelfSpace then
      WU.RecordButtonClick(1001370115)
      WU.AcquireWindowAsync("MySpaceAuraEdit")
    else
      WU.AcquireWindowAsync("ItemDetail", function(window)
        _ENV["$"](window)["$$SetAuraActor"](m_playerInfo.auraActorId, m_playerInfo.auraActorQuality)
      end)
    end
  end)
end

function SetMessageSetting(playerInfo)
  m_messageSetting = playerInfo.messageBoardPermission
  for i = 1, #REF.SettingGrid do
    REF.SettingGrid[i - 1].CheckBoxSprite.UISprite.spriteName = "checkbox_n"
  end
  if 0 < m_messageSetting then
    REF.SettingGrid[m_messageSetting - 1].CheckBoxSprite.UISprite.spriteName = "checkbox_s"
  else
    REF.SettingGrid[0].CheckBoxSprite.UISprite.spriteName = "checkbox_s"
  end
  WU.ToggleRendering(REF.NodeInput, false)
  if m_messageSetting == PB.enum.PlayerMessageBoardPermission.None then
    WU.ToggleRendering(REF.NodeInput, true)
  end
end

function SetMedals()
  SetMedal(REF.WidgetIconSlotFight, m_playerInfo.fightMedal, nil, true)
  for i = 1, #REF.NodeMedalsGrid do
    local medalId
    if m_playerInfo.showMedals[i] then
      medalId = m_playerInfo.showMedals[i]
    end
    SetMedal(REF.NodeMedalsGrid[i - 1].WidgetIconSlotShow, medalId, nil, false)
    REF.NodeMedalsGrid[i - 1].SpriteSlotBG.gameObject:SetActive(true)
  end
end

function SetMedal(medalRef, medalId, pos, isFight)
  local hasMedal = medalId ~= nil and medalId ~= 0
  medalRef.gameObject:SetActive(hasMedal or isFight)
  if hasMedal then
    medalRef["$SetData"](PB.enum.ResourceType.ResMedal, medalId)
    medalRef["$ShowCustom"]({name = false})
  else
    medalRef["$SetEmpty"](3)
  end
  medalRef["$SetClickCallback"](function()
    WU.RecordButtonClick(1001370113)
    if m_isMySelfSpace and isFight then
      this:SetData("SelectedMedal", {id = medalId, pos = pos})
      WU.AcquireWindowAsync("MedalSelection", function(window)
        _ENV["$"](window)["$$SetMode"](2)
      end)
    end
  end)
end

function SetFavorite(playerInfo)
  for i = 1, 5 do
    local role = playerInfo.favorRoles[i]
    local ref = REF.Actors[i - 1]
    if role ~= nil then
      local xlsx = PB.get("Role", role)
      ref.PicSprite.UISprite.enabled = xlsx ~= nil
      if xlsx then
        ref.PicSprite.UISprite.spriteName = "actor_head_" .. xlsx.animRes
      else
        warning("MySpace", "Role.xlsx error, roleId " .. tostring(role))
      end
    else
      ref.PicSprite.UISprite.enabled = false
    end
  end
  for i = 1, 5 do
    local book = playerInfo.favorBooks[i]
    local ref = REF.Books[i - 1]
    if book ~= nil then
      ref.PicSprite.UISprite.spriteName = "book_" .. book
      ref.PicSprite.UISprite.tintAsAdd = false
      ref.PicSprite.UISprite.alpha = 1
    else
      ref.PicSprite.UISprite.spriteName = "book_1"
      ref.PicSprite.UISprite.tintAsAdd = true
      ref.PicSprite.UISprite.alpha = 0.4
    end
  end
end

function OnClickPlayerGender()
  if m_isLocked then
    ShowUnLockHint()
  else
    WU.ToggleRendering(REF.NodeGenders, true)
  end
end

function OnClickPlayerDeclare()
  WU.RecordButtonClick(1001370111)
  if m_isLocked then
    ShowUnLockHint()
    return
  end
  WU.ShowEditBox({
    title = WU.GetString("WindowSpace_EditDeclareTitle"),
    subTitle = WU.GetString("WindowSpace_EditDeclareSubTitle"),
    multiple = true,
    defaultText = m_playerInfo.sign,
    characterLimit = DeclareCharacterLimit,
    allowEmpty = true
  }, function(text)
    local patchTable = {sign = text}
    local wireFormatTable = ProtobufT("ApiRelationPlayerPageInfo", patchTable)
    this:GameRequest("fci/playerpageinfo/"):Patch(wireFormatTable, function(result)
      this:SetData("Space/SelectedPlayer", result)
    end)
    return true
  end)
end

function OnClickMember(go)
  if m_isMySelfSpace then
    WU.RecordButtonClick(1001370116)
    this:SetData("AutoSlotSelection", _ENV["$"](go)["@index"])
    this:SetData("SpaceActorSelect/Mode", "Space")
    WU.AcquireWindowAsync("SpaceActorSelect")
  else
    local actorInfo = _ENV["$"](go)["@actor"]
    local equips = _ENV["$"](go)["@equips"]
    local displayInfo = {actorInfo = actorInfo, equips = equips}
    if actorInfo ~= nil and actorInfo.id > 0 then
      WU.AcquireWindowAsync("ActorMainDisplay", function()
        this:SetData("Space/DisplayInfo", displayInfo)
      end)
    end
  end
end

function OnMedalSwitch()
  if m_isMySelfSpace then
    WU.AcquireWindowAsync("MySpaceEdit", function(window)
      _ENV["$"](window)["$$SetMode"]("Medal")
    end)
  end
end

function OnClickFavBook(go)
  WU.RecordButtonClick(1001370121)
  if m_isMySelfSpace then
    this:SetData("MySpaceEdit/Mode", "FavBook")
    WU.AcquireWindowAsync("MySpaceEdit")
  end
end

function OnClickFavActor(go)
  WU.RecordButtonClick(1001370122)
  if m_isMySelfSpace then
    this:SetData("MySpaceEdit/Mode", "FavActor")
    WU.AcquireWindowAsync("MySpaceEdit")
  end
end

function OnMessageSubmit()
  WU.RecordButtonClick(1001370145)
  local inputText = REF.InputComment.UIInput.value
  if U.trim(inputText) == "" then
    WU.ShowHintText(WU.GetString("Window_SpaceMsgForUIInput"))
    return
  end
  if m_messageTo == m_selfPlayerId then
    m_messageTo = nil
  end
  inputText = string.gsub(inputText, "<", "&lt;")
  inputText = string.gsub(inputText, ">", "&gt;")
  local postData = {content = inputText, to = m_messageTo}
  this:GameRequest("fci/player-message/" .. m_playerInfo.playerId):Post(postData, function(result)
    m_messageTo = nil
    REF.InputComment.UIInput.value = ""
    table.insert(m_messages, 1, result)
    RefreshMessages(true)
  end)
end

function RefreshMessages(goTop)
  local count = #REF.MsgTable
  local tableRef = REF.MsgTable
  if count < #m_messages then
    local widget = REF.WidgetSpaceMsg.gameObject
    for i = count + 1, #m_messages do
      CS.NGUITools.AddChild(REF.MsgTable.gameObject, widget)
    end
  elseif count > #m_messages then
    for i = #m_messages + 1, count do
      tableRef[i - 1]["$gameObject"]:SetActive(false)
    end
  end
  for i = 1, #m_messages do
    local ref = tableRef[i - 1]
    ref["$gameObject"]:SetActive(true)
    ref["$$SetMessage"](m_messages[i], "WidgetMySpaceReal")
  end
  if goTop then
    REF.MsgScrollView.UIScrollView:ResetPosition()
  end
end

function OnNext()
  if m_hasNext then
    this:GameRequest("fci/player-message/" .. m_playerInfo.playerId):Page(m_curPageNumber, MessagePerPage):Get(function(result)
      if #result == MessagePerPage then
        m_curPageNumber = m_curPageNumber + 1
      else
        m_hasNext = false
      end
      for i = 1, #result do
        table.insert(m_messages, result[i])
      end
      RefreshMessages()
    end)
  end
end

function OnGuildDetailClick()
  local guild = this:GetData("fci/guild/" .. fif(m_isMySelfSpace, "", tostring(m_playerInfo.guildId)))
  if guild then
    WU.AcquireWindowAsync("GuildDetail", function(ui)
      _ENV["$"](ui)["$$SetData"](guild)
    end)
  end
end

function OnGuildInviteClick()
  if GuildUtil.IsGuildManager() then
    this:GameRequest("fci/guild/{guildId}/invited-members/"):Put({
      playerId = m_playerInfo.playerId
    }, function(result)
      local invitedMembers = this:GetData("fci/guild/invited-members")
      table.insert(invitedMembers, result)
      this:SetData("fci/guild/invited-members", invitedMembers)
      WU.ToggleRendering(REF.BtnGuildInvite, false)
      WU.ToggleRendering(REF.LabelInvited, true)
      WU.ShowHintText(WU.GetString("Window_GuildInvitationSent"))
    end)
  end
end

function OnNamePatch()
  if m_isMySelfSpace then
    REF.NameNode["$OnRenameClick"]()
  end
end

function HandleShareData(allActors, haveActors, window)
  for i = 1, #haveActors do
    local role = PB.get("ActorConfig", haveActors[i].id).role
    if allActors[role] then
      allActors[role].unlock = true
    end
  end
  local selectNum = 5
  local selectedActors = {}
  local favorRoles = _ENV["!"](this:GetData("Space/SelectedPlayer").favorRoles)
  for i = 1, #favorRoles do
    table.insert(selectedActors, allActors[favorRoles[i]])
  end
  allActors = allActors:toarray()
  _ENV["$"](window)["$$SetEditInfo"](allActors, selectNum, selectedActors, "MySpaceActor")
end

function OnListChange(list, fightMedalId)
  if list == nil then
    return
  end
  WU.ToggleRendering(REF.WrapContent, true)
  m_medalList = {}
  m_medalListNotFight = {}
  local isPreCommit = WU.IsPreCommit()
  for _, m in pairs(m_allMedals) do
    local _, obtainedMedal = table.find(list, function(k, v)
      return v == m.id
    end)
    if obtainedMedal then
      m.obtained = true
      local hideSpecial = false
      hideSpecial = m.id == 80005
      if m.obtained and not hideSpecial then
        if m_medalList == nil then
          m_medalList = {}
          m_medalListNotFight = {}
        end
        if isPreCommit then
          if m.category ~= 4 then
            if m.id ~= fightMedalId then
              m.isFight = false
              table.insert(m_medalListNotFight, m)
            else
              m.isFight = true
              table.insert(m_medalList, m)
            end
          end
        elseif m.id ~= fightMedalId then
          m.isFight = false
          table.insert(m_medalListNotFight, m)
        else
          m.isFight = true
          table.insert(m_medalList, m)
        end
      end
    end
  end
  table.sort(m_medalListNotFight, function(a, b)
    if a.quality ~= b.quality then
      return a.quality > b.quality
    else
      return a.id < b.id
    end
  end)
  for i = 1, #m_medalListNotFight do
    table.insert(m_medalList, m_medalListNotFight[i])
  end
  Show()
end

function UpdateMedalSlot(ref, info)
  if info == nil then
    ref["$$ClearSlot"]()
  else
    ref["$$SetData"](PB.enum.ResourceType.ResMedal, info.id)
    ref["$$ShowCustom"]({
      isNew = info.isNew,
      name = false,
      obtained = info.obtained,
      isFight = info.isFight
    })
    ref["$$SetClickCallback"](function()
      WU.ShowMedalDetail(info.id, not info.isFight, info.expireTime, "MySpace")
    end)
  end
end

function UpdateCollectionsSlot(ref, info)
  if info then
    ref.SpriteTitle.UISprite.spriteName = info.textureTitle
    ref.SpriteIcon.UITexture.mainTexturePath = info.textureIcon
    WU.SetActive(ref.LabelTrophy, info.type == 1)
    WU.SetActive(ref.SpriteTrophy, info.type == 1)
    WU.SetActive(ref.split, info.type ~= 5)
    WU.SetActive(ref.LabelProgressAll, info.type ~= 5)
    if info.all < info.progress then
      info.progress = info.all
    end
    ref.LabelProgress.UILabel.text = info.progress
    ref.LabelProgressAll.UILabel.text = info.all
    ref.Progress.UIProgressBar.value = info.progress / info.all
    ref.LabelTitle.UILabel.text = WU.GetString(info.LabelName)
    if info.type == 1 then
      local levelName, curTrophy = AU.GetAchievementInfo(info.progress)
      ref.LabelTrophy.UILabel.text = levelName
      ref.SpriteTrophy.UISprite.spriteName = "home/cup_icon_big_" .. curTrophy
    end
    WU.ToggleRendering(ref.root, true)
  else
    WU.ToggleRendering(ref.root, false)
  end
end

function Show()
  local noMedal = m_medalList == nil or #m_medalList == 0
  WU.ToggleRendering(REF.DragBG, not noMedal)
  WU.ToggleRendering(REF.NodeEmpty, noMedal)
  if not noMedal then
    LU.Set(REF.WrapContent, math.ceil(#m_medalList / #REF.WrapContent[0].Grid))
  end
end

function SetupMedalList()
  m_allMedals = PB.all("MedalInfo"):select(function(m)
    return {
      id = m.id,
      category = m.category,
      order = m.order,
      hide = m.hide,
      quality = m.quality
    }
  end)
  table.sort(m_allMedals, function(a, b)
    if a.quality ~= b.quality then
      return a.quality > b.quality
    else
      return a.id < b.id
    end
  end)
  LU.Bind(REF.WrapContent, {
    dataSource = function(dataIndex)
      return m_medalList and m_medalList[dataIndex]
    end,
    updateSlot = UpdateMedalSlot,
    delta = 0.01,
    slotsName = "Grid"
  })
end

function SetupCollectionList()
  LU.Bind(REF.CollectionsWrapContent, {
    dataSource = function(dataIndex)
      return m_collections and m_collections[dataIndex]
    end,
    updateSlot = UpdateCollectionsSlot
  })
end

function OnSetExpInfo(exp)
  if exp and m_baseInfo then
    REF.WidgetProgressBar["$AccountExp"](m_baseInfo.level, exp)
  end
end

function OnSetBaseInfo(baseInfo)
  if baseInfo then
    m_baseInfo = baseInfo
    if m_isLocked then
      REF.LabelPlayerName.UILabel.text = m_baseInfo.name
    end
  end
end

function OnClickContactCustomerService()
  local url = WU.GetClientUrlParam(PB.all("MsdkUrl")[1].AccountCS)
  if url == nil then
    warning("need fill url in table")
    return
  end
  WU.OpenUrl(url)
end

function OnButtonForumClick()
  local url
  if url == nil or url == "" then
    warning("need fill url in table")
    return
  end
  WU.OpenUrl(url)
end

function OnClickWechat()
  local url = PB.all("MsdkUrl")[1].OfficialAccountUrl
  if url == nil then
    warning("need fill url in table")
    return
  end
  CS.Msdk.WGPlatform.Instance:WGOpenWeiXinDeeplink(url)
end

function OnLogoutClick()
  WU.ShowMessageYesNo(WU.GetString("WindowAccount_ConfirmLogout"), function(result)
    if result == "YES" then
      _ENV["$"](WU.FindWindow("Account"))["$$OnLogout"]()
    end
  end)
end

function OnClickAchievement()
  if m_isLocked then
    ShowUnLockHint()
    return
  end
  WU.ToggleRendering(REF.NodeAchievementMask, true)
  this:DelayInvokeInSeconds(2, function()
    WU.ToggleRendering(REF.NodeAchievementMask, false)
  end)
end

function ResetRedPoint(data)
  local hasRed = WU.GetGameDataCache("MySpaceMessageRed")
  local lastNewMessageId = WU.GetGameDataCache("MySpaceLastNewMessageId")
  if hasRed then
    REF.SpriteMessageRedPoint.gameObject:SetActive(true)
  elseif data then
    for i = 1, #data do
      if data[i] and data[i].sender ~= tostring(m_selfPlayerId) then
        if data[i].id == lastNewMessageId then
          REF.SpriteMessageRedPoint.gameObject:SetActive(false)
          break
        end
        REF.SpriteMessageRedPoint.gameObject:SetActive(true)
        WU.SetGameDataCache("MySpaceMessageRed", true)
        WU.SetGameDataCache("MySpaceLastNewMessageId", data[i].id)
        break
      end
    end
  end
end

function ShowUnLockHint()
  WU.ShowHintText(WU.GetString("WindowUnlock_Hint", "", m_unLockLevel))
end

function OnDestroy()
  this:SetData("Space/SelectedPlayer", nil)
end

function SetLockWindow()
  if m_isLocked then
    Reset()
    WU.ToggleRendering(REF.WidgetPersonalPlatform, false)
    WU.ToggleRendering(REF.ButtonDungeonGroup, false)
    WU.ToggleRendering(REF.Aura, false)
    WU.ToggleRendering(REF.Medals, false)
    WU.ToggleRendering(REF.NodeSpriteLine, false)
    WU.ToggleRendering(REF.BtnGuildInvite, false)
    WU.ToggleRendering(REF.BtnGuildDetail, false)
    WU.ToggleRendering(REF.NodePlayerDeclare, false)
    WU.ToggleRendering(REF.NodeIsLocked, true)
    WU.ToggleRendering(REF.Visual, true)
    REF.LabelIsLocked.UILabel.text = WU.GetString("WindowSpace_MoreDetail", m_unLockLevel)
    if m_baseInfo then
      REF.LabelPlayerName.UILabel.text = m_baseInfo.name
      REF.LabelPlayerID.UILabel.text = this:GetData("playerId")
      REF.LabelLevel.UILabel.text = m_baseInfo.level
      local point = this:GetData("fci/resource/ResAchievementPoint_0")
      local levelName, curTrophy = AU.GetAchievementInfo(point)
      REF.PlayerAcivimentSprite.UISprite.spriteName = "cup_icon_" .. curTrophy
      REF.LabelAchievement.UILabel.text = levelName
      REF.LabelGuild.UILabel.text = WU.GetString("Window_GuildNotExist")
      REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](m_baseInfo)
      REF.WidgetIconPlayerHeadPhoto["$SetClickCallback"](function()
        ShowUnLockHint()
      end)
    end
    WU.ToggleRendering(REF.NodeTeam, true)
  else
    WU.ToggleRendering(REF.WidgetPersonalPlatform, true)
    WU.ToggleRendering(REF.NodeSpriteLine, true)
    WU.ToggleRendering(REF.NodeIsLocked, false)
    WU.ToggleRendering(REF.NodePlayerDeclare, true)
  end
  this:DelayInvokeInFrames(1, function()
    if m_isLocked then
      REF.ToggleFavorite.UIToggle.enabled = false
      REF.ToggleMessage.UIToggle.enabled = false
      REF.ToggleMedalList.UIToggle.enabled = false
      REF.ToggleCollections.UIToggle.enabled = false
    else
      REF.ToggleFavorite.UIToggle.enabled = true
      REF.ToggleMessage.UIToggle.enabled = true
      REF.ToggleMedalList.UIToggle.enabled = true
      REF.ToggleCollections.UIToggle.enabled = true
    end
    if m_resetToggle then
      REF.ToggleTeam.UIToggle.value = true
    end
  end)
end

function SetCollectionData()
  m_collections = _ENV["!"]({})
  m_collectionsCount = _ENV["!"]({})
  m_collectionsCount[1] = AU.GetMaxAchievementPoint()
  m_collectionsCount[2] = AU.GetAllEquipNum()
  m_collectionsCount[3] = AU.GetAllArmNum()
  m_collectionsCount[4] = AU.GetAllRolesNum()
  m_collectionsCount[5] = AU.GetAllMedalsNum()
  m_collectionsCount[6] = AU.GetAllSkinNum()
  m_collectionsCount[7] = AU.GetAllStoryCartoonNum()
  m_collectionsCount[8] = AU.GetAllEmojiNum()
  local playerCollectionInfo = PB.all("PlayerCollectionInfo")
  table.sort(playerCollectionInfo, function(a, b)
    return a.type < b.type
  end)
  local playerInfo = {}
  local equipsCollections = this:GetData("fci/CollectionsEquip") or {}
  local roles = this:GetData("CollectionsActor/ActorsCollected") or {}
  local skins = this:GetData("fci/unlockedSkins/") or {}
  local cgs = this:GetData("CartoonConfig/UnlockedInfo") or {}
  local emojis = this:GetData("fci/emoji/") or {}
  local weapons = this:GetData("fci/arms") or {}
  local actors = this:GetData("fci/actor") or {}
  local uniqueActors = {}
  local cartoonconfig = PB.all("CartoonConfig")
  local skinCount = 0
  local cgCount = 0
  local actorsCount = 0
  local uniqueCg = {}
  for _, v in pairs(actors) do
    if uniqueActors[v.id] == nil then
      uniqueActors[v.id] = true
      actorsCount = actorsCount + 1
    end
  end
  for _, v in pairs(skins) do
    skinCount = skinCount + 1
  end
  skinCount = skinCount + actorsCount - 1
  for _, v in pairs(cartoonconfig) do
    if cgs[v.id] and uniqueCg[v.dungeonId] == nil then
      uniqueCg[v.dungeonId] = true
      cgCount = cgCount + 1
    end
  end
  if equipsCollections.equips then
    playerInfo.equipNum = #equipsCollections.equips
  else
    playerInfo.equipNum = 0
  end
  playerInfo.roleNum = #roles
  playerInfo.skinNum = skinCount
  playerInfo.cgNum = cgCount
  playerInfo.emojiNum = #emojis
  playerInfo.achievementPoint = this:GetData("fci/resource/ResAchievementPoint_0")
  playerInfo.weaponNum = #weapons
  for i = 1, #playerCollectionInfo do
    if playerCollectionInfo[i].type == 5 and m_medalList then
      playerCollectionInfo[i].progress = #m_medalList
    else
      playerCollectionInfo[i].progress = playerInfo[playerCollectionInfo[i].key] or 0
    end
    playerCollectionInfo[i].all = m_collectionsCount[playerCollectionInfo[i].type]
    table.insert(m_collections, playerCollectionInfo[i])
  end
  LU.Set(REF.CollectionsWrapContent, math.ceil(#m_collections / #REF.MySpaceCollectionRow))
end
