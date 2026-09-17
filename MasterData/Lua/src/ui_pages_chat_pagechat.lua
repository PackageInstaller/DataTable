local this = class("pageChat", G_UIPageBase)
local COLOR_GREY = C_LuaUtility.ParseHtmlStringColor("#8b8c8f")
local COLOR_BLUE = C_LuaUtility.ParseHtmlStringColor("#4ccbff")
local _, CLOLOR_BGPage = C_ColorUtility.TryParseHtmlString("#FFFFFFEE")
local _chatListTpl = L_GameTpl:getChatListTpl()
local _moduleName = {
  channelChat = "channelChat",
  privateList = "privateList",
  friendList = "friendList"
}
local MenuType = {
  channelChat = 1,
  privateList = 2,
  friendList = 3
}
local moduleNameWithType = {
  [MenuType.channelChat] = "channelChat",
  [MenuType.privateList] = "privateList",
  [MenuType.friendList] = "friendList"
}
local TYPE_ICON = {
  [MenuType.channelChat] = "Atlas/Chat/tex_chat_icon_01.png",
  [MenuType.privateList] = "Atlas/Chat/tex_chat_icon_02.png",
  [MenuType.friendList] = "Atlas/Chat/tex_chat_icon_03.png"
}

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    selectPlayerUid = nil,
    selectMeetingChat = false,
    textLimitTimer = nil,
    unreadMsgNum = 0,
    playerDetailInfoUid = 0
  }
end

function this.bind()
  return {
    module_menu = {
      moduleName = "modulePages/moduleChatMenu"
    },
    moduleName_modulePlayerList = "",
    module_playerList = {
      type = "toggleModule",
      friendList = {
        assetName = "UI/Pages/Chat/moduleChatFriendList",
        moduleName = "pages/chat/moduleChatFriendList"
      },
      privateList = {
        assetName = "UI/Pages/Chat/modulePrivateChat",
        moduleName = "pages/chat/modulePrivateChat"
      },
      channelChat = {
        assetName = "UI/Pages/Chat/moduleChannelChat",
        moduleName = "pages/chat/moduleChannelChat"
      }
    },
    module_changeDelayTime = 0.15,
    moduleName_modulePlayerDetailInfo = "",
    module_playerDetailInfo = {
      type = "toggleModule",
      playerDetailInfo = {
        assetName = "UI/Pages/Chat/modulePlayerDetailInfo",
        moduleName = "pages/chat/modulePlayerDetailInfo"
      }
    },
    color_Bg = CLOLOR_BGPage,
    module_playerTabLst = {
      moduleName = "pages/chat/modulePlayerTabLst"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      self:ModulePlayerDetailInfo(false)
      L_UI:close(self.pageName)
    end,
    onClick_mask = function(self)
      local closeDetail = self:ModulePlayerDetailInfo(false)
      if not closeDetail then
        self:ModulePlayerDetailInfo(false)
        L_UI:close(self.pageName)
      end
    end,
    onClick_menu = function(self)
      local data = {
        txtContent = L_WordsTpl:getValue("notice_chat_2"),
        confirmCallback = function()
          L_ChatStore:req_deleteChatConversation(self.data.selectPlayerUid)
        end
      }
      L_GameUtil.showCommonTip(data)
    end,
    module_playerList = {
      friendList = {
        onClick_head = function(self, uid, callback)
          self:showModulePlayerDetailInfo(uid, callback)
        end,
        onClick_close = function(self)
          self:ModulePlayerDetailInfo(false)
        end
      },
      privateList = {
        onClick_head = function(self, uid, callback)
          self:showModulePlayerDetailInfo(uid, callback)
        end,
        onClick_close = function(self)
          self:ModulePlayerDetailInfo(false)
        end,
        onSetActive = function(self, isShow)
          self.modules.module_playerTabLst:setActiveNone(isShow)
        end
      },
      channelChat = {
        onClick_head = function(self, uid, callback)
          self:showModulePlayerDetailInfo(uid, callback)
        end,
        onClick_close = function(self)
          self:ModulePlayerDetailInfo(false)
        end
      }
    },
    module_playerDetailInfo = {
      playerDetailInfo = {
        onClick_close = function(self)
          self:ModulePlayerDetailInfo(false)
        end
      }
    },
    module_playerTabLst = {
      onSelect_Tab = function(self, tabID)
        if self.data.selectMenuType == MenuType.channelChat then
          if self.modules.module_playerList.channelChat ~= nil then
            self.modules.module_playerList.channelChat:onSetSelectTabId(tabID)
          end
        elseif self.data.selectMenuType == MenuType.privateList then
          if self.modules.module_playerList.privateList ~= nil then
            self.modules.module_playerList.privateList:onSetSelectTabId(tabID)
          end
          self:ModulePlayerDetailInfo(false)
        elseif self.data.selectMenuType == MenuType.friendList then
          if self.modules.module_playerList.friendList ~= nil then
            self.modules.module_playerList.friendList:onSetSelectTabId(tabID)
          end
          self:ModulePlayerDetailInfo(false)
        end
      end,
      onCellUse = function(self, id)
        if self.data.selectMenuType == MenuType.channelChat then
          if self.modules.module_playerList.channelChat ~= nil then
            self.modules.module_playerList.channelChat:refreshActorCell(id)
          end
        elseif self.data.selectMenuType == MenuType.privateList then
          if self.modules.module_playerList.privateList ~= nil then
            self.modules.module_playerList.privateList:refreshActorCell(id)
          end
          self:ModulePlayerDetailInfo(false)
        elseif self.data.selectMenuType == MenuType.friendList then
          if self.modules.module_playerList.friendList ~= nil then
            self.modules.module_playerList.friendList:refreshActorCell(id)
          end
          self:ModulePlayerDetailInfo(false)
        end
      end,
      onPlayCloseAnim = function(self)
        if self.data.selectMenuType == MenuType.privateList then
          if self.modules.module_playerList.privateList ~= nil then
            self.modules.module_playerList.privateList:playCloseAnim()
          end
        elseif self.data.selectMenuType == MenuType.friendList and self.modules.module_playerList.friendList ~= nil then
          self.modules.module_playerList.friendList:playCloseAnim()
        end
      end,
      onClick_head = function(self, uid, callback)
        self:showModulePlayerDetailInfo(uid, callback)
      end
    }
  }
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.chat)
  callback(result)
end

function this:preOpen(options)
  if L_UI:checkPageOpen("pageMultiTeam") then
    self.bindComponents.blur.enabled = true
  else
    self.bindComponents.blur.enabled = false
  end
  self:initChatMenuList()
  local type = 1
  if options then
    self.sub_type = options.sub_type
    type = options.type
  else
    type = self:getDefaultOption()
  end
  this.super.preOpen(self, options)
  self:initPage(type)
  self:initBgShow()
  L_AudioUtil.playSound("Play_SFX_System_UI_Chat_Open")
end

function this:close(options)
  this.super.close(self, options)
  if L_UI:checkPageOpen("pageChatEmotion") then
    L_UI:close("pageChatEmotion")
  end
  L_CommonUtil.setLocalValue("ChatTab1", tostring(self.data.selectMenuType or 1))
  local module = self.modules.module_playerList[moduleNameWithType[self.data.selectMenuType]]
  L_CommonUtil.setLocalValue("ChatTab2", tostring(module.data.tabId))
end

function this:show()
end

function this:refreshPageView(options)
  if options then
    this.super.refreshPageView(self, options)
    self:initPage(options.type)
  else
    local type = self:getDefaultOption()
    self:initPage(type)
  end
end

function this:getDefaultOption()
  local chatData = L_ChatStore:getChannelData(L_Const.chatType.map)
  if chatData:getChannelActive() and L_ChatStore.data.partyFirstEnterChannel ~= chatData:getCurrentChannelId() then
    L_ChatStore.data.partyFirstEnterChannel = L_ChatStore:getCurrentChannelId()
    self.sub_type = 4
    return 1
  end
  local tabId1 = L_CommonUtil.getLocalValue("ChatTab1")
  if tabId1 then
    local type = tonumber(tabId1)
    local tabId2 = L_CommonUtil.getLocalValue("ChatTab2")
    if tabId2 then
      local tabId = tonumber(tabId2)
      if -1 < tabId then
        if type == 1 then
          if tabId == 2 and not L_ChatStore:getChannelActive(L_Const.chatType.city) then
            tabId = 1
          elseif tabId == 4 and not L_ChatStore:getChannelActive(L_Const.chatType.map) then
            tabId = 1
          end
        end
        self.sub_type = tabId
      end
    end
    return type
  end
  local selectType = 1
  for i, v in ipairs(self.menuList) do
    if i == 1 then
      selectType = v.type
    elseif v.type == MenuType.channelChat then
      selectType = v.type
    elseif v.type == MenuType.friendList and selectType ~= MenuType.channelChat then
      selectType = v.type
    end
  end
  return selectType
end

function this:initPage(type)
  self:initSelectedPage(type)
end

function this:initSelectedPage(type)
  self:updateSelectPage(type, true)
  self:initChatMenu()
end

function this:initChatMenuList()
  local typeList = {
    MenuType.channelChat,
    MenuType.privateList,
    MenuType.friendList
  }
  local menuList = {}
  for i, v in pairs(typeList) do
    local tpl = _chatListTpl:getTplById(v)
    local name = _chatListTpl:getName(tpl)
    local data = {
      type = v,
      icon = TYPE_ICON[v],
      label = name
    }
    if v == MenuType.friendList then
      data.reddotKey = L_ReddotManager.DotDef.Friend
    elseif v == MenuType.privateList then
      data.reddotKey = L_ReddotManager.DotDef.FriendPrivateChat
    elseif v == MenuType.channelChat then
      data.reddotKey = L_ReddotManager.DotDef.FriendChannelChat
    end
    table.insert(menuList, data)
  end
  self.menuList = menuList
end

function this:initChatMenu()
  local function func(selectType)
    self:updateSelectPage(selectType)
  end
  
  self.modules.module_menu:initModule(self.menuList, self.data.selectMenuType, func)
end

function this:SwitchPage(selectType)
  self:updateSelectPage(selectType)
  self.modules.module_menu:setType(selectType)
  self.modules.module_menu:setTypeListActive()
end

function this:updateSelectPage(newSelect, isInit)
  if self.data.selectMenuType == newSelect then
    return
  end
  self:changeModulePlayerTab(newSelect)
  self:ModulePlayerDetailInfo(false)
  L_TimerManager:newOrResetTimer(self, "changeModuleTimer", function()
    if newSelect == MenuType.channelChat then
      self.bind.moduleName_modulePlayerList = _moduleName.channelChat
      self.modules.module_playerList.channelChat:initModule(self.sub_type)
    elseif newSelect == MenuType.privateList then
      self.bind.moduleName_modulePlayerList = _moduleName.privateList
      self.modules.module_playerList.privateList:initModule(self.sub_type)
    elseif newSelect == MenuType.friendList then
      self.bind.moduleName_modulePlayerList = _moduleName.friendList
      self.modules.module_playerList.friendList:initModule(self.sub_type)
    end
    if isInit then
      self.modules.module_playerList[moduleNameWithType[newSelect]]:playOpenAnim()
    else
      self.modules.module_playerList[moduleNameWithType[newSelect]]:playSwitchAnim(true)
      self.modules.module_playerTabLst:playSwitchAnim(true)
    end
    self.sub_type = nil
  end, 0.15)
  if self.data.selectMenuType then
    if isInit then
      self.modules.module_playerList[moduleNameWithType[self.data.selectMenuType]]:playCloseAnim()
      self.modules.module_playerTabLst:playSwitchAnim(true)
    else
      self.modules.module_playerList[moduleNameWithType[self.data.selectMenuType]]:playSwitchAnim(false)
      self.modules.module_playerTabLst:playSwitchAnim(false)
    end
  end
  self.data.selectMenuType = newSelect
end

function this:ModulePlayerDetailInfo(isShowOrHide)
  if not isShowOrHide and self.data.playerDetailInfoUid == 0 then
    return false
  end
  if self.modules.module_playerDetailInfo.playerDetailInfo then
    if not isShowOrHide then
      self.data.playerDetailInfoUid = 0
      L_TimerManager:newOrResetTimer(self, "isHide", function()
        self.Complete = false
      end, 1.067)
    end
    if isShowOrHide then
      L_AudioUtil.playSound("Play_SFX_System_UI_Friends_ClickAvatar")
    end
    self.modules.module_playerDetailInfo.playerDetailInfo:SetActive(isShowOrHide)
    return true
  end
  return false
end

function this:showModulePlayerDetailInfo(uid, callback)
  if self.data.playerDetailInfoUid == uid then
    return
  end
  
  local function onClick_callback()
    if callback then
      callback()
    end
    self.Complete = true
    if string.isEmpty(self.bind.moduleName_modulePlayerDetailInfo) then
      self.bind.moduleName_modulePlayerDetailInfo = "playerDetailInfo"
      self.data.playerDetailInfoUid = uid
    elseif self.data.playerDetailInfoUid ~= uid then
      self:ModulePlayerDetailInfo(true)
      self.data.playerDetailInfoUid = uid
    end
    self.modules.module_playerDetailInfo.playerDetailInfo:initModule({
      uid = uid,
      list = nil,
      hasBg = nil
    })
  end
  
  L_FriendManager:ViewPlayerInfo(uid, onClick_callback, nil, nil, nil, true)
end

function this:escHandle()
  L_UI:close(self.pageName)
end

function this:initBgShow()
  local pages = C_UIMgr.GetAllPages(0)
  for k, pretop in pairs(pages) do
    if pretop and pretop.config and (pretop.config.displayMode == CS.Azur.Gameplay.EUIDisplay.Normal or pretop.config.displayMode == CS.Azur.Gameplay.EUIDisplay.SceneUI) then
      self.bindComponents.imgBgMaterial.material = nil
      self.bindComponents.imgBgMaterial.enabled = false
      self.bind.color_Bg = CLOLOR_BGPage
      return
    end
  end
end

function this:changeModulePlayerTab(selectType)
  if self.data.selectMenuType == selectType then
    return
  end
  local options = {
    tabId = self.sub_type,
    type = selectType
  }
  self.modules.module_playerTabLst:refreshModule(options)
end

function this:checkShowVirtualCamera()
  local pages = C_UIMgr.GetAllPages(0)
  for k, pretop in pairs(pages) do
    if pretop and pretop.config and (pretop.config.displayMode == CS.Azur.Gameplay.EUIDisplay.Normal or pretop.config.displayMode == CS.Azur.Gameplay.EUIDisplay.SceneUI) then
      return
    end
  end
  if self.data.selectMenuType == MenuType.channelChat then
    self:showVirtualCamera(true)
  elseif self.data.selectMenuType == MenuType.privateList then
    local conversationList = L_ChatStore:getConversationList()
    self:showVirtualCamera(0 < table.count(conversationList))
  elseif self.data.selectMenuType == MenuType.friendList then
    local player = L_FriendStore:getFriendList()
    self:showVirtualCamera(0 < table.count(player))
  end
end

function this:initVirtualCamera()
  local cameraGO = self.bindComponents.pre_chatVirtualCamera.gameObject
  self.cameraGO = cameraGO
  self.cameraTactics = C_CameraManager.CreateCommonTactics(cameraGO, C_CinemachineBlendType.Cut, true)
  cameraGO.transform.position = C_CameraManager.mainCamera.transform.position
  cameraGO.transform.rotation = C_CameraManager.mainCamera.transform.rotation
  cameraGO.transform:Rotate(0, -30, 0)
  self.virtualCamera = self.cameraTactics:GetVirtualCamera()
end

function this:showVirtualCamera(show)
  if show and not self.cameraTactics then
    self:initVirtualCamera()
  end
  if self.virtualCamera then
    self.virtualCamera.enabled = show
  end
end

function this:exitVirtualCamera()
  if self.cameraTactics and L_CommonUtil.isValid(self.cameraTactics) then
    C_CameraManager.ExitAndCompleteCamera(self.cameraTactics)
    self.cameraTactics:Dispose()
    C_CameraManager.RemoveTactics(self.cameraTactics)
    self.cameraTactics = nil
  end
  if self.cameraGO then
    self.virtualCamera.enabled = false
    local cameraGO = self.cameraGO
    self.cameraGO = nil
    L_TimerManager:newOrResetTimer(self, "chatVirtual", function()
      C_ExternalManager.Destroy(cameraGO)
    end, 2.0)
  end
end

return this
