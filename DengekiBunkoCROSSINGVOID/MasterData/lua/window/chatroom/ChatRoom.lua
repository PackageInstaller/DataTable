local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local HU = require("Common/HtmlUtil")
local CU = require("Common/ChatUtil")
local DBH = require("Manager/DataBindingHandler")
local EU = require("Common/EquipUtil")
local SU = require("Common/SortUtil")
local FU = require("Common/FriendUtil")
local GU = require("Common/GuildUtil")
local CO = require("Common/Coroutine")
local DU = require("Common/DungeonUtil")
local PU = require("Common/PlatformUtil")
local RefreshInterval = 1
local Misc = PB.all("Misc")[1]
local SubChannelLimit = Misc.maxWorldSubChannelCount
local ReuseTable = REF.Container.ReuseTable
local ReuseTableGuild = REF.ContainerGuild.ReuseTable
local MaxChatLen = Misc.maxChatLen or 100
local UpdateDataBinding = {
  [PB.enum.EChatChannel.World] = "ChatRoom/ChatContentWorldUpdate",
  [PB.enum.EChatChannel.Guild] = "ChatRoom/ChatContentGuildUpdate",
  [PB.enum.EChatChannel.Private] = "ChatRoom/ChatContentPrivate",
  [PB.enum.EChatChannel.Group] = "ChatRoom/ChatContentGroupUpdate",
  [PB.enum.EChatChannel.System] = "ChatRoom/ChatContentSystemUpdate",
  [PB.enum.EChatChannel.Event] = "ChatRoom/ChatContentEventUpdate",
  [PB.enum.EChatChannel.GuildRecruit] = "ChatRoom/ChatContentGuildRecruitUpdate"
}
local CacheDataBinding = {
  [PB.enum.EChatChannel.World] = "ChatRoom/ChatContentWorld",
  [PB.enum.EChatChannel.Guild] = "ChatRoom/ChatContentGuild",
  [PB.enum.EChatChannel.Private] = nil,
  [PB.enum.EChatChannel.Group] = "ChatRoom/ChatContentGroup",
  [PB.enum.EChatChannel.System] = "ChatRoom/ChatContentSystem",
  [PB.enum.EChatChannel.Event] = "ChatRoom/ChatContentEvent",
  [PB.enum.EChatChannel.GuildRecruit] = "ChatRoom/ChatContentGuildRecruit"
}
local ChannelREF = {
  _ENV["$"](REF.WorldChannel),
  _ENV["$"](REF.SystemChannel),
  _ENV["$"](REF.PrivateChannel),
  nil,
  _ENV["$"](REF.GuildChannel),
  _ENV["$"](REF.GroupChannel),
  _ENV["$"](REF.EventChannel)
}
local ChannelPBR = {
  PB.enum.EChatChannel.World,
  PB.enum.EChatChannel.Guild,
  PB.enum.EChatChannel.GuildRecruit,
  PB.enum.EChatChannel.Private,
  PB.enum.EChatChannel.Group,
  PB.enum.EChatChannel.System,
  PB.enum.EChatChannel.Event,
  PB.enum.EChatChannel.XYView
}
local m_shareInfo = {}
local m_inputContent = {}
local m_resChatChannel = {}
local m_chatInterval = {}
local m_targetChannelIndex, m_lastChannelIdx, m_imgConsoleShow, m_bubbleCount, m_privateTarId, m_privateTarName, m_privateDropList
local m_recruitInterval = Misc.guildRecruitConfig.getRecruitInterval
local m_curRecruitTime = 12
local m_recruitAble = true
local m_droplistOpen, m_content
local m_contentLenOld = 0
local m_activeTalkTargets, m_blockSystemSwitch
local testId = 1
local testInterval = 0.5
local testFlag = 0

function SetupWindow()
  WU.BindButtonEvent(REF.SwitchOpen, function()
    WU.RecordButtonClick(994024)
    WU.ToggleRendering(REF.ScrollViewNode, true)
    this:SetData("ChatRoom/BlockSystemSwitch", false)
  end)
  WU.BindButtonEvent(REF.SwitchClose, function()
    WU.RecordButtonClick(994025)
    WU.ToggleRendering(REF.ScrollViewNode, false)
    this:SetData("ChatRoom/BlockSystemSwitch", true)
  end)
  WU.BindButtonEvent(REF.TargetMask, function()
    OnPrivateDropList()
    m_droplistOpen = false
  end)
  WU.BindButtonEvent(REF.SpriteSend, OnChatSubmit)
  WU.TraverseChildren(REF.NodeTab, function(go, i)
    go:SetActive(ChannelPBR[i + 1] ~= nil)
    if ChannelPBR[i + 1] == PB.enum.EChatChannel.XYView then
      local accountCache = DB:GetData("accountCache")
      if accountCache.socialPlatform ~= PB.enum.MSDKLoginPlatform.MSDK_QQ and accountCache.socialPlatform ~= PB.enum.MSDKLoginPlatform.MSDK_Wechat then
        go:SetActive(false)
      end
    end
    WU.BindButtonEvent(go, function(go)
      local pb = ChannelPBR[i + 1]
      WU.RecordButtonClick("994Ch" .. pb)
      local playerId = CU.SearchPrivateTalkTarget()
      if m_targetChannelIndex ~= i + 1 or pb == PB.enum.EChatChannel.Private and playerId ~= nil then
        ClearMsgContainer()
        SetChannelVisible(i)
      end
    end)
  end)
  WU.BindButtonEvent(REF.GuildBtn, function()
    if this:GetData("ApplyChatRoomHyperLink") then
      if not WU.WindowIsLocked(PB.enum.UnlockWindow.Guild, PB.enum.UnlockWindow.Guild) then
        this:GameRequest("fci/guild-recommend/"):Post(nil, function(guildRecommend)
          if guildRecommend then
            this:SetData("fci/guild-recommend/", guildRecommend)
            WU.RecycleWindow(this)
            WU.AcquireWindowAsync("GuildPortal")
          end
        end)
      end
    else
      WU.ShowHintText(WU.GetString("ChatRoom_ForbidChatRoomHyperLink"))
    end
  end)
  WU.BindButtonEvent(REF.ImgSprite, function()
    WU.RecordButtonClick("994Fa" .. ChannelPBR[m_targetChannelIndex])
    if m_droplistOpen then
      OnPrivateDropList()
      m_droplistOpen = false
    end
    OnImgNode()
  end)
  REF.WidgetEmoji["$SetCallback"](function()
    m_imgConsoleShow = true
  end, function()
    m_imgConsoleShow = false
  end)
  REF.WidgetEmoji["$BindButtonEvent"](OnImgSubmit, OnFaceTextAdd)
  WU.BindButtonEvent(REF.NodePrivateSprite, function()
    WU.RecordButtonClick("994Ta")
    if m_imgConsoleShow then
      OnImgNode()
    end
    if m_droplistOpen then
      OnPrivateDropList()
      m_droplistOpen = false
    else
      if m_privateDropList ~= nil then
        OnPrivateDropList(m_privateDropList)
      else
        OnPrivateDropList(1)
      end
      m_droplistOpen = true
    end
  end)
  WU.BindButtonEvent(REF.BubbleSprite, function()
    this:SetData("ChatRoom/BubbleCount", 0)
    ReuseTable:ResetPosition()
  end)
  WU.BindButtonEvent(REF.LatestNode, function()
    OnPrivateDropList(1)
    m_droplistOpen = true
  end)
  WU.BindButtonEvent(REF.FriendNode, function()
    OnPrivateDropList(2)
    m_droplistOpen = true
  end)
  WU.BindButtonEvent(REF.InputLevelLimitButton, function()
    local channel = ChannelPBR[m_targetChannelIndex]
    WU.ShowHintText(WU.GetString("Window_ChatChannelUnlockLevel", m_resChatChannel[channel].levelLimit))
  end)
  CS.EventDelegate.Add(REF.RoomChooseNode.UIInput.onSubmit, function()
    local subChannel = REF.RoomChooseNode.UIInput.value
    if subChannel == nil or U.trim(subChannel) == "" then
      REF.RoomChooseNode.UIInput.value = this:GetData("ChatRoom/WorldSubChannel") or 0
      return
    end
    if tonumber(subChannel) > SubChannelLimit or 0 >= tonumber(subChannel) then
      WU.ShowHintText(WU.GetString("Window_SubChannelTooBig", SubChannelLimit))
      REF.RoomChooseNode.UIInput.value = this:GetData("ChatRoom/WorldSubChannel")
      return
    end
    if tonumber(subChannel) == this:GetData("ChatRoom/WorldSubChannel") then
      return
    end
    local postData = {targetChannel = subChannel}
    this:WebSocketSendLua(CS.Restifizer.WebSocketTag.PushService, "CsWorldChatSubChannel", postData)
  end)
  CS.EventDelegate.Add(REF.RoomChooseNode.UIInput.onDeselect, function()
    REF.RoomChooseNode.UIInput.value = this:GetData("ChatRoom/WorldSubChannel") or 0
  end)
  ReuseTable.onInitializeItem = UpdateSlot
  ReuseTable.onGetChildWidget = Trans2BoundsWidget
  ReuseTableGuild.onInitializeItem = UpdateSlotGuild
  ReuseTableGuild.onGetChildWidget = Trans2BoundsWidgetGuild
  LU.Bind(REF.TalkTargetWrap, {
    updateRow = function(rowRef, wrapIndex, realIndex)
      if m_activeTalkTargets ~= nil and realIndex ~= nil and realIndex < #m_activeTalkTargets then
        rowRef["$$SetWidgetTalkTarget"](m_activeTalkTargets[realIndex + 1], m_privateTarId)
      end
    end
  })
  WU.BindButtonEvent(REF.InputChat, function()
    WU.RecordButtonClick("994In" .. ChannelPBR[m_targetChannelIndex])
  end)
  WU.BindButtonEvent(REF.RoomChooseNode, function()
    WU.RecordButtonClick("994Sw")
  end)
end

function DebugMsg()
  local channel = ChannelPBR[m_targetChannelIndex]
  local text = this:RandomChar(128)
  local message = {
    senderId = "000018",
    subChannelId = 1,
    npcRoleId = 0,
    id = testId,
    channel = channel,
    time = CS.GameTime.serverUtc,
    sender = "GUEST12000",
    content = text .. "|||" .. testId .. "|||"
  }
  testId = testId + 1
  if channel == PB.enum.EChatChannel.World then
    CU.HandlerChatMessages(message)
  elseif channel == PB.enum.EChatChannel.Guild then
    CU.HandlerNewMsg(message, 2)
  elseif channel == PB.enum.EChatChannel.Private then
    CU.HandlerNewMsg(message, 1)
  elseif channel == PB.enum.EChatChannel.GuildRecruit then
  end
end

function DebugImg()
  local channel = ChannelPBR[m_targetChannelIndex]
  local message = {
    senderId = "000018",
    subChannelId = 1,
    npcRoleId = 0,
    id = testId,
    channel = channel,
    time = CS.GameTime.serverUtc,
    sender = "GUEST12000",
    content = "<img src=ChatEmoji.Role_1>" .. "|||" .. testId .. "|||"
  }
  testId = testId + 1
  if channel == PB.enum.EChatChannel.World then
    CU.HandlerChatMessages(message)
  elseif channel == PB.enum.EChatChannel.Guild then
    CU.HandlerNewMsg(message, 2)
  elseif channel == PB.enum.EChatChannel.Private then
    CU.HandlerNewMsg(message, 1)
  end
end

function DebugRole()
  local message = {
    senderId = "000018",
    subChannelId = 1,
    npcRoleId = 1,
    id = testId,
    channel = 1,
    time = CS.GameTime.serverUtc,
    sender = "GUEST12000",
    content = "\230\181\139\232\175\149\230\181\139\232\175\149\230\181\139\232\175\149" .. "|||" .. testId .. "|||"
  }
  testId = testId + 1
  CU.HandlerChatMessages(message)
end

function DebugSystem()
  local channel = ChannelPBR[m_targetChannelIndex]
  local message = {
    senderId = "000018",
    subChannelId = 1,
    npcRoleId = 0,
    id = testId,
    channel = channel,
    time = CS.GameTime.serverUtc,
    sender = "GUEST12000",
    content = "\230\129\173\229\150\156<font color=\"#0199e9\">[$({\"player\": {\"id\": \"000012066\", \"name\": \"GUEST12066\"}})]</font>\233\128\154\232\191\135<font color=\"#FFD700\">$({\"gacha\": {\"id\": 1}})</font>\232\142\183\229\190\151\232\167\146\232\137\178$({\"actor\":{\"talentInfo\": [{\"talentId\": 123, \"talentValue\": 1}, {\"talentId\": 105, \"talentValue\": 1}, {\"talentId\": 106, \"talentValue\": 1}, {\"talentId\": 7, \"talentValue\": 1}], \"quality\": 4, \"star\": 1, \"id\": 1014, \"level\": 1}})\239\188\129" .. "|||" .. testId .. "|||"
  }
  testId = testId + 1
  if channel == PB.enum.EChatChannel.Guild then
    message.sender = nil
    CU.HandlerNewMsg(message, 3)
  else
    message.channel = PB.enum.EChatChannel.System
    CU.HandlerChatMessages(message)
  end
end

function DebugChatRoom()
  CO.coroutine_call(function()
    while true do
      if testFlag == 1 then
        DebugMsg()
        DebugSystem()
      end
      CO.yield_return(CS.UnityEngine.WaitForSeconds(testInterval))
    end
  end, this)()
  CO.coroutine_call(function()
    while true do
      if testFlag == 2 then
        DebugMsg()
        DebugImg()
        DebugSystem()
      end
      CO.yield_return(CS.UnityEngine.WaitForSeconds(testInterval))
    end
  end, this)()
  CO.coroutine_call(function()
    while true do
      if testFlag == 3 then
        DebugMsg()
        DebugImg()
        DebugRole()
        DebugSystem()
      end
      CO.yield_return(CS.UnityEngine.WaitForSeconds(testInterval))
    end
  end, this)()
end

function InitWindow()
  m_curRecruitTime = m_recruitInterval + 1
  WU.TraverseChildren(REF.NodeTab, function(go, index)
    local tabRef = _ENV["$"](go)
    tabRef["$UIToggle"].optionCanBeNone = true
    tabRef["$UIToggle"].value = false
    tabRef["$UIToggle"].optionCanBeNone = false
    if ChannelPBR[index + 1] == PB.enum.EChatChannel.GuildRecruit then
      go:SetActive(not WU.WindowIsLocked(PB.enum.UnlockWindow.Guild))
    elseif ChannelPBR[index + 1] == PB.enum.EChatChannel.Group then
      go:SetActive(this:GetData("ChatRoom/ShowChatGroup"))
    elseif ChannelPBR[index + 1] == PB.enum.EChatChannel.Event then
      local locked = WU.WindowIsLocked(PB.enum.UnlockWindow.TriggeredEvent)
      go:SetActive(this:GetData("ChatRoom/ShowTriggeredEvent") and not locked)
    end
  end)
  REF.NodeTab.UIGrid:Reposition()
  InitFromXlsx()
  m_imgConsoleShow = false
  m_bubbleCount = 0
  WU.ToggleRendering(REF.WidgetEmoji, false)
  WU.ToggleRendering(REF.BubbleNode, false)
  REF.InputChat.UIInput.defaultText = WU.GetString("Window_EditBoxTooLong", MaxChatLen)
  REF.InputChat.UIInput.characterLimit = MaxChatLen
  if m_targetChannelIndex == nil then
    m_targetChannelIndex = 1
  end
  this:SetData("ChatRoom/BlockSystemSwitch", WU.GetGameDataCache("ChatRoom/BlockSystemSwitch"))
  this:Bind("ChatRoom/BlockSystemSwitch", OnBlockSystemSwitch)
  if this:GetData("NewPrivateMsg/Display") == true then
    ClearMsgContainer()
    m_privateTarId = nil
    m_targetChannelIndex = 3
  end
  
  local function OnChatContent(content)
    if content ~= nil then
      local len = #content
      local tempReuseTable
      if m_contentLenOld == len and m_lastChannelIdx == m_targetChannelIndex then
        return
      end
      m_content = content
      if ChannelPBR[m_targetChannelIndex] == PB.enum.EChatChannel.GuildRecruit then
        tempReuseTable = ReuseTableGuild
        ReuseTableGuild.gameObject:SetActive(0 < #content)
      else
        tempReuseTable = ReuseTable
      end
      if REF.ScrollView.UIScrollView.contentPivot ~= CS.UIWidget.Pivot.Top and not tempReuseTable.isRepositedBottom then
        if ChannelPBR[m_targetChannelIndex] == PB.enum.EChatChannel.World then
          this:SetData("ChatRoom/BubbleCount", content.unreadCount)
        end
        tempReuseTable:SetDataCount(#content)
      else
        content.unreadCount = 0
        CU.CheckChatContentLimit(content, ChannelPBR[m_targetChannelIndex])
        tempReuseTable:SetDataCount(#content)
        tempReuseTable:ResetPosition()
      end
      m_lastChannelIdx = m_targetChannelIndex
      m_contentLenOld = #content
    end
  end
  
  for k, v in pairs(UpdateDataBinding) do
    this:Bind(v, OnChatContent, false)
  end
  this:Bind("NewGuildMsg/Display", function(val)
    NewSpriteDisplay(val, PB.enum.EChatChannel.Guild, REF.GuildNewSprite)
    if val and not REF.GuildNewSprite.gameObject.activeSelf then
      this:SetData("NewGuildMsg/Display", false)
    end
  end)
  this:Bind("NewWorldMsg/Display", function(val)
    NewSpriteDisplay(val, PB.enum.EChatChannel.World, REF.WorldNewSprite)
    if val and not REF.WorldNewSprite.gameObject.activeSelf then
      this:SetData("NewWorldMsg/Display", false)
    end
  end)
  this:Bind("NewPrivateMsg/Display", function(val)
    NewSpriteDisplay(val, PB.enum.EChatChannel.Private, REF.PrivateNewSprite)
  end)
  this:Bind("NewEventMsg/Display", function(val)
    NewSpriteDisplay(val, PB.enum.EChatChannel.Event, REF.EventNewSprite)
    if val and not REF.EventNewSprite.gameObject.activeSelf then
      this:SetData("NewWorldMsg/Display", false)
    end
  end)
  this:RegisterGameEvent("OnLinkClick", OnLinkClick)
  this:RegisterGameEvent("OnPrivateTalk", OnPrivateTalk)
  this:RegisterGameEvent("NewPrivateMsg", function(senderId, sender)
    OnNewPrivateMsg(senderId)
  end)
  this:RegisterGameEvent("AsyncPvpNewVideoShare", function(jsonData_D)
    info("AsyncPvpNewVideoShare", jsonData_D.dunUid)
    if jsonData_D and jsonData_D.dunUid then
      local function enterReplay()
        DU.PlayReplay(jsonData_D.dunUid, PB.enum.DungeonType.AsyncPvpV2, "ChatRoom")
      end
      
      if not DU.IsWaitingForJob(enterReplay) then
        enterReplay()
      end
    end
  end)
  this:RegisterGameEvent("XYMesssageListener", function(param)
    info("GamePlay", "Message recieived. Param is: " + param)
    PU.ShowXYTips(param)
  end)
  this:RegisterGameEvent("ShowMessageOpened", function()
    for i = 1, #ChannelPBR do
      if ChannelPBR[i] == PB.enum.EChatChannel.XYView then
        if REF.NodeTab[i - 1]["$UIToggle"].value then
          WU.RecycleWindow(this)
        end
        break
      end
    end
  end)
  this:Bind("ChatRoom/WorldSubChannel", function(val)
    REF.RoomChooseNode.UIInput.value = this:GetData("ChatRoom/WorldSubChannel") or 0
    this:SetData("ChatRoom/BubbleCount", 0)
  end)
  this:Bind("ChatRoom/WorldSubChannelLimit", function(val)
    if val ~= nil then
      SubChannelLimit = val
    end
  end)
  this:Bind("GuildSystemMessageRaw", function(messages)
    if messages ~= nil and 0 < #messages then
      CU.SystemFilterByBlacklist(messages, this:GetData("fci/blacklist/"))
      local history = this:GetData("GuildMsg") or {}
      SetGuildMixedMsg(history, messages)
    end
  end)
  this:Bind("GuildMsg", function(messages)
    if messages ~= nil and 0 < #messages then
      CU.ChatContentFilterByBlacklist(messages, this:GetData("fci/blacklist/"))
      local history = this:GetData("GuildSystemMessageRaw") or {}
      SetGuildMixedMsg(history, messages)
    end
  end)
  this:Bind("ChatRoom/BubbleCount", SetBubbleDisplay)
  SetChannelVisible(m_targetChannelIndex - 1)
end

function UninitWindow()
  m_shareInfo = {}
  PU.ShowXYView(false)
end

function UpdateWindow(delta)
  m_curRecruitTime = m_curRecruitTime + delta
  if m_curRecruitTime > m_recruitInterval then
    m_recruitAble = true
  end
  if m_recruitAble and ChannelPBR[m_targetChannelIndex] == PB.enum.EChatChannel.GuildRecruit then
    m_curRecruitTime = 0
    m_recruitAble = false
    this:GameRequest("fci/guild-recruit/"):Get(function(result)
      local message = result.recruitContent
      if message and message.guildLevel > 0 then
        CU.HandlerNewMsg(message, 5)
      end
    end)
  end
  for i, v in ipairs(m_chatInterval) do
    m_chatInterval[i] = v + delta
  end
  if 0 < m_bubbleCount and ChannelPBR[m_targetChannelIndex] == PB.enum.EChatChannel.World and ReuseTable.isRepositedBottom then
    this:SetData("ChatRoom/BubbleCount", 0)
  end
  if m_targetChannelIndex ~= nil then
    UpdateContainer(delta)
  end
end

local m_updateInterval = 0

function UpdateContainer(delta)
  if m_updateInterval < RefreshInterval then
    m_updateInterval = m_updateInterval + delta
  else
    m_updateInterval = 0
    RefreshMsgContainer()
  end
end

function InitFromXlsx()
  local resChatChannel = PB.all("ChatChannel")
  for _, v in pairs(PB.enum.EChatChannel) do
    if resChatChannel[v] ~= nil then
      m_resChatChannel[v] = resChatChannel[v]
      m_chatInterval[v] = resChatChannel[v].interval or 0
    end
  end
end

function OnChatSubmit()
  local channel = ChannelPBR[m_targetChannelIndex]
  WU.RecordButtonClick("994Su" .. channel)
  
  local function SubmitFinished(result)
    m_chatInterval[channel] = 0
    REF.InputChat.UIInput.value = ""
    if result then
      m_shareInfo = {}
    end
  end
  
  if m_chatInterval[channel] > m_resChatChannel[channel].interval then
    local text = U.trim(REF.InputChat.UIInput.value)
    if text == "" then
      WU.ShowHintText(WU.GetString("Window_EmptyTextForUIInput"))
      return
    end
    text = string.gsub(text, "<", "&lt;")
    text = string.gsub(text, ">", "&gt;")
    if channel == PB.enum.EChatChannel.Group then
      this:BroadcastGameEvent("DungeonTeamGroupChatMsg", text, false, true)
      SubmitFinished()
    else
      local postData = {
        content = text,
        channel = channel,
        worldSubChannel = this:GetData("ChatRoom/WorldSubChannel") or 0
      }
      if m_targetChannelIndex == m_shareInfo.channel then
        postData.shareTag = PB.enum.EChatShareTag.Href
        postData.shareParam = m_shareInfo.info
      end
      local success = PostDataAdapter(postData)
      if not success then
        return
      end
      local wireFormatTable = ProtobufT("ApiChat", postData)
      this:GameRequest("fci/chat/"):Post(wireFormatTable, function(result)
        SubmitFinished(true)
        PostDataRespAdapter(postData, result)
      end, function()
        SubmitFinished(false)
      end)
    end
  else
    WU.ShowHintText(WU.GetString("Window_SpeakTooFast"))
  end
end

function OnImgSubmit(go)
  local channel = ChannelPBR[m_targetChannelIndex]
  WU.RecordButtonClick("994Em" .. channel)
  
  local function SubmitFinished()
    m_chatInterval[channel] = 0
  end
  
  if m_chatInterval[channel] > m_resChatChannel[channel].interval then
    local text = "<img src=" .. _ENV["$"](go)["@text"] .. ">"
    if channel == PB.enum.EChatChannel.Group then
      this:BroadcastGameEvent("DungeonTeamGroupChatMsg", text, false, true)
      SubmitFinished()
    else
      local postData = {content = text, channel = channel}
      local success = PostDataAdapter(postData)
      if not success then
        return
      end
      local wireFormatTable = ProtobufT("ApiChat", postData)
      this:GameRequest("fci/chat/"):Post(wireFormatTable, function(result)
        SubmitFinished()
        PostDataRespAdapter(postData, result)
      end, function()
        SubmitFinished()
      end)
    end
  else
    WU.ShowHintText(WU.GetString("Window_SpeakTooFast"))
  end
end

function PostDataAdapter(postData)
  if ChannelPBR[m_targetChannelIndex] == PB.enum.EChatChannel.Private then
    if m_privateTarId == nil then
      WU.ShowHintText(WU.GetString("Window_NoPrivateTalkTarget"))
      return false
    elseif m_privateTarId == this:GetData("playerId") then
      WU.ShowHintText(WU.GetString("Window_TargetIsSelf"))
      return false
    end
    postData.targetId = m_privateTarId
  elseif ChannelPBR[m_targetChannelIndex] == PB.enum.EChatChannel.World then
    local worldSubChannel = this:GetData("ChatRoom/WorldSubChannel")
    if worldSubChannel == nil or worldSubChannel <= 0 then
      WU.ShowHintText(WU.GetString("Window_WorldSubChannelDontExist"))
      return false
    end
    postData.worldSubChannel = worldSubChannel
  end
  return true
end

function PostDataRespAdapter(postData, result)
  if result ~= nil then
    result.shareTag = postData.shareTag
    result.shareParam = postData.shareParam
    if ChannelPBR[m_targetChannelIndex] == PB.enum.EChatChannel.Private then
      local msgCache = this:GetData("ChatRoom/PrivateMsg/" .. m_privateTarId) or _ENV["!"]({})
      local baseinfo = this:GetData("fci/baseinfo")
      local newMsg = {
        content = result.newContent,
        senderId = this:GetData("playerId"),
        sender = this:GetData("fci/displayname/"),
        time = CS.GameTime.serverUtc,
        headPhoto = baseinfo.headPhoto,
        headFrame = baseinfo.headFrame,
        socialPicture = baseinfo.socialPicture,
        shareTag = result.shareTag,
        shareParam = result.shareParam
      }
      msgCache = CU.MergeChatContent(msgCache, {newMsg})
      this:SetData("ChatRoom/PrivateMsg/" .. m_privateTarId, msgCache)
      CU.UpdateLatest(m_privateTarId, m_privateTarName)
    elseif ChannelPBR[m_targetChannelIndex] == PB.enum.EChatChannel.World then
      local msgCache = this:GetData("ChatRoom/ChatContentWorld") or _ENV["!"]({})
      msgCache = CU.MergeChatContent(msgCache, {result})
      this:SetData("ChatRoom/ChatContentWorld", msgCache)
    end
    RefreshMsgContainer()
    ReuseTable:ResetPosition()
  end
end

function AnchorAdjust(pb)
  if pb == PB.enum.EChatChannel.Private then
    REF.ImgSprite.UISprite.leftAnchor.absolute = 315
    REF.ImgSprite.UISprite.rightAnchor.absolute = 407
  elseif pb == PB.enum.EChatChannel.World then
    REF.ImgSprite.UISprite.leftAnchor.absolute = 315
    REF.ImgSprite.UISprite.rightAnchor.absolute = 407
  else
    REF.ImgSprite.UISprite.leftAnchor.absolute = 30
    REF.ImgSprite.UISprite.rightAnchor.absolute = 122
  end
end

function SetChannelVisible(idx)
  PU.ShowXYView(false)
  WU.ToggleRendering(REF.ScrollViewNode, true)
  WU.ToggleRendering(REF.InputPanel, true)
  REF.WidgetEmoji["$Hide"]()
  m_inputContent[m_targetChannelIndex] = REF.InputChat.UIInput.value
  if not REF.NodeTab[idx]["$gameObject"].activeSelf then
    idx = 0
  end
  REF.NodeTab[idx]["$UIToggle"].value = true
  m_targetChannelIndex = idx + 1
  REF.InputChat.UIInput.value = ""
  if m_inputContent[m_targetChannelIndex] ~= nil then
    REF.InputChat.UIInput.value = m_inputContent[m_targetChannelIndex]
  end
  WU.TraverseChildren(REF.NodeChannel, function(go)
    WU.ToggleRendering(go, false)
  end)
  if REF.NodeChannel[idx] ~= nil then
    WU.ToggleRendering(REF.NodeChannel[idx]["$"], true)
  end
  WU.ToggleRendering(REF.NodeInput, idx <= 4)
  local pb = ChannelPBR[idx + 1]
  AnchorAdjust(pb)
  WU.ToggleRendering(REF.PrivateTarget, pb == PB.enum.EChatChannel.Private)
  WU.ToggleRendering(REF.RoomChooseNode, pb == PB.enum.EChatChannel.World)
  WU.ToggleRendering(REF.NodePrivateSprite, pb == PB.enum.EChatChannel.Private)
  if pb == PB.enum.EChatChannel.Private then
    OnPrivateDropList()
    m_droplistOpen = false
    local playerId, playerName, isFriend = CU.SearchPrivateTalkTarget()
    if playerId == nil and m_privateTarId ~= nil then
      OnNewPrivateMsg(m_privateTarId)
    elseif playerId ~= nil then
      if isFriend then
        m_privateDropList = 2
      else
        m_privateDropList = 1
      end
      OnLinkClick("{ \"pmTarget\" : { \"playerId\" : \"" .. playerId .. "\", \"playerName\" : \"" .. playerName .. "\" } }")
    end
  elseif pb == PB.enum.EChatChannel.Guild then
    this:SetData("NewGuildMsg/Display", false)
    local guildPlayer = this:GetData("fci/guild-player/")
    if guildPlayer ~= nil then
      if guildPlayer.guildId ~= 0 then
        WU.ToggleRendering(REF.NoGuildNode, false)
        REF.GuildNewSprite.gameObject:SetActive(false)
      else
        WU.ToggleRendering(REF.NoGuildNode, true)
        WU.ToggleRendering(REF.InputPanel, false)
      end
    end
  elseif pb == PB.enum.EChatChannel.XYView then
    WU.ToggleRendering(REF.InputPanel, false)
    WU.ToggleRendering(REF.ScrollViewNode, false)
    PU.ShowXYView(true)
  elseif pb == PB.enum.EChatChannel.GuildRecruit then
    local data = this:GetData("ChatRoom/ChatContentGuildRecruit")
    WU.ToggleRendering(REF.InputPanel, false)
    ReuseTableGuild.gameObject:SetActive(data and 0 < #data)
  end
  if pb == PB.enum.EChatChannel.World then
    this:SetData("NewWorldMsg/Display", false)
  elseif pb == PB.enum.EChatChannel.System then
    WU.ToggleRendering(REF.ScrollViewNode, not m_blockSystemSwitch)
  elseif pb == PB.enum.EChatChannel.Event then
    this:SetData("NewEventMsg/Display", false)
  end
  RefreshMsgContainer()
  ReuseTable:ResetPosition()
  local playerLevel = this:GetData("fci/baseinfo/").level
  REF.InputLevelLimitButton.gameObject:SetActive(m_resChatChannel[pb] and 0 < m_resChatChannel[pb].levelLimit and playerLevel < m_resChatChannel[pb].levelLimit)
  local normalHeight = 780
  local heightNoInput = 900
  REF.ScrollViewNode.UIWidget.height = fif(pb == PB.enum.EChatChannel.GuildRecruit, heightNoInput, normalHeight)
end

function OnNewPrivateMsg(senderId)
  if senderId == m_privateTarId and ChannelPBR[m_targetChannelIndex] == PB.enum.EChatChannel.Private then
    local content = this:GetData("ChatRoom/PrivateMsg/" .. senderId) or _ENV["!"]({})
    if table.empty(content) then
      CU.AddPrivateTitle(content, m_privateTarName)
    end
    local result = _ENV["!"]({})
    result = CU.MergeChatContent(result, content)
    this:SetData("ChatRoom/PrivateMsg/" .. senderId, result)
    this:SetData("ChatRoom/ChatContentPrivate", result)
    REF.TargetChooseLabel.UILabel.text = m_privateTarName
    ClearNewCount(m_privateTarId)
    local result = CU.SearchPrivateTalkTarget()
    if result == nil then
      this:SetData("NewPrivateMsg/Display", false)
    end
  end
end

function OnPrivateDropList(flag)
  if flag == nil then
    WU.ToggleRendering(REF.DropListNode, false)
    WU.ToggleRendering(REF.TargetMask, false)
  else
    m_privateDropList = flag
    WU.ToggleRendering(REF.DropListNode, true)
    WU.ToggleRendering(REF.TargetMask, true)
    if m_privateDropList == 1 then
      UpdateTalkTargets()
    elseif m_privateDropList == 2 then
      UpdateFriendList()
    end
  end
end

function OnPrivateTalk(playerId, playerName)
  if playerId ~= this:GetData("playerId") then
    if playerId ~= m_privateTarId then
      ClearMsgContainer()
    end
    m_privateTarId = playerId
    m_privateTarName = playerName
    this:SetData("ChatRoom/PrivateTalkTarget", m_privateTarId)
    this:SetData("ChatRoom/PrivateTalkTargetNickName", m_privateTarName)
    local visibleIdx = 0
    for i = 0, #REF.NodeTab - 1 do
      if ChannelPBR[i + 1] == PB.enum.EChatChannel.Private then
        visibleIdx = i
        break
      end
    end
    SetChannelVisible(visibleIdx)
    OnNewPrivateMsg(playerId)
  else
    WU.ShowHintText(WU.GetString("Window_TargetIsSelf"))
  end
end

function OnLinkClick(jsonText)
  local jsonObj = JsonD(jsonText)
  if jsonObj then
    if jsonObj.pmTarget then
      if jsonObj.pmTarget.playerId ~= m_privateTarId then
        ClearMsgContainer()
      end
      m_privateTarId = jsonObj.pmTarget.playerId
      m_privateTarName = jsonObj.pmTarget.playerName
      this:SetData("ChatRoom/PrivateTalkTarget", m_privateTarId)
      this:SetData("ChatRoom/PrivateTalkTargetNickName", m_privateTarName)
      OnPrivateDropList()
      m_droplistOpen = false
      OnNewPrivateMsg(m_privateTarId)
      ReuseTable:ResetPosition()
    else
      CU.HandleObjectHyperLink(jsonObj)
    end
  end
end

function OnFaceTextAdd(go)
  WU.RecordButtonClick("994Km" .. ChannelPBR[m_targetChannelIndex])
  local text = _ENV["$"](go)["@text"]
  local limit = REF.InputChat.UIInput.characterLimit
  if limit > #REF.InputChat.UIInput.value + #text then
    REF.InputChat.UIInput.value = REF.InputChat.UIInput.value .. text
  end
end

function SetBubbleDisplay(count)
  if count ~= nil then
    if 0 < count then
      WU.ToggleRendering(REF.BubbleNode, true)
      REF.BubbleLabel.UILabel.text = count
    else
      WU.ToggleRendering(REF.BubbleNode, false)
      local content = this:GetData("ChatRoom/ChatContentWorld")
      if content ~= nil then
        content.unreadCount = nil
      end
    end
    m_bubbleCount = count
  end
end

function UpdateTalkTargets()
  REF.LatestNode.UIToggle.value = true
  m_activeTalkTargets = this:GetData("LatestChatTargets") or {}
  LU.Set(REF.TalkTargetWrap, #m_activeTalkTargets)
end

function UpdateFriendList()
  REF.FriendNode.UIToggle.value = true
  m_activeTalkTargets = this:GetData("ChatRoom/Friends") or {}
  LU.Set(REF.TalkTargetWrap, #m_activeTalkTargets)
end

function ClearNewCount(playerId)
  local isFriend = false
  local friendList = this:GetData("fci/friendlist/")
  if table.find(friendList, function(_, v)
    return v.playerId == playerId
  end) then
    isFriend = true
  end
  local tb
  if isFriend then
    tb = this:GetData("ChatRoom/Friends") or {}
  else
    tb = this:GetData("LatestChatTargets") or {}
  end
  local idx, val = table.find(tb, function(k, v)
    return v.senderId == playerId
  end)
  if idx ~= nil then
    val.newCount = 0
  end
  if isFriend then
    this:SetData("ChatRoom/Friends", tb)
  else
    this:SetData("LatestChatTargets", tb)
  end
end

function RefreshMsgContainer()
  if m_targetChannelIndex ~= nil then
    local pb = ChannelPBR[m_targetChannelIndex]
    if pb == PB.enum.EChatChannel.Private and m_privateTarId ~= nil then
      local content = this:GetData("ChatRoom/PrivateMsg/" .. m_privateTarId) or _ENV["!"]({})
      this:SetData("ChatRoom/ChatContentPrivate", content)
    elseif pb == PB.enum.EChatChannel.XYView then
      return
    elseif pb ~= PB.enum.EChatChannel.Private then
      this:SetData(UpdateDataBinding[pb], this:GetData(CacheDataBinding[pb]) or {})
    end
  end
end

function ClearMsgContainer()
  m_content = nil
  m_contentLenOld = 0
  ReuseTable:SetDataCount(0)
end

function UpdateSlot(go, wrapIndex, realIndex)
  if m_content ~= nil and realIndex < #m_content then
    local ref = _ENV["$"](go)
    local message = m_content[realIndex + 1]
    if message ~= nil then
      if message.npcRoleId and message.npcRoleId > 0 then
        ref["$$SetNpcContent"](message)
      else
        ref["$$SetChatContent"](message, ChannelPBR[m_targetChannelIndex])
      end
    end
  end
end

function UpdateSlotGuild(go, wrapIndex, realIndex)
  if m_content ~= nil and realIndex < #m_content then
    local ref = _ENV["$"](go)
    local message = m_content[realIndex + 1]
    if message ~= nil then
      ref["$$SetGuildContent"](message)
    end
  end
end

function NewSpriteDisplay(flag, tag, ref)
  if tag == PB.enum.EChatChannel.Private then
    ref.gameObject:SetActive(flag)
    return
  end
  if ChannelPBR[m_targetChannelIndex] == tag then
    ref.gameObject:SetActive(false)
  else
    ref.gameObject:SetActive(flag)
  end
end

function SetGuildMixedMsg(history, messages)
  history = _ENV["!"](history)
  local contents = _ENV["!"]({})
  history:copy(contents)
  contents:append(messages)
  SU.MergeSort(contents, function(a, b)
    return a.time < b.time
  end)
  local result = _ENV["!"]({})
  result = CU.MergeChatContent(result, contents)
  this:SetData("ChatRoom/ChatContentGuild", result)
end

function OnImgNode()
  REF.WidgetEmoji["$AdjustObjects"](_ENV["$"](REF.ScrollViewNode), _ENV["$"](REF.NodeInput))
  REF.WidgetEmoji["$RefreshContent"]()
  if m_imgConsoleShow then
    REF.WidgetEmoji["$Hide"]()
  else
    REF.WidgetEmoji["$Show"]()
  end
end

function Trans2BoundsWidget(trans)
  local ref = _ENV["$"](trans)
  if ref["@type"] == 1 then
    return ref.WidgetHeight.UIWidget
  else
    return ref.NpcTexture.UITexture
  end
end

function Trans2BoundsWidgetGuild(trans)
  return _ENV["$"](trans).ShapeControl.UIWidget
end

function OnBlockSystemSwitch(value)
  m_blockSystemSwitch = value
  REF.SwitchClose.gameObject:SetActive(value ~= true)
  REF.SwitchOpen.gameObject:SetActive(value)
  WU.SetGameDataCache("ChatRoom/BlockSystemSwitch", value)
end

function OnAsyncPvpVideoShare(channel, dunUid)
  local visibleIdx = table.find(ChannelPBR, function(_, v)
    return v == channel
  end)
  local playerId = CU.SearchPrivateTalkTarget()
  ClearMsgContainer()
  SetChannelVisible(visibleIdx - 1)
  m_shareInfo.channel = channel
  m_shareInfo.info = string.format("{\"customEvent\": \"AsyncPvpNewVideoShare\", \"customParam\": {\"dunUid\": %s}, \"hrefContent\": \"%s\"}", dunUid, WU.GetString("NASyncPvp_ClickToWatchVideo"))
  REF.InputChat.UIInput.value = WU.GetString("NAsyncPvp_ShareVideoContent")
end
