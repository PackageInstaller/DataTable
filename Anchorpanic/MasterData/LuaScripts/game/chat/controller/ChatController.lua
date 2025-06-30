module("chat.ChatController", Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    -- 打开聊天面板
    GameDispatcher:addEventListener(EventName.OPEN_CHAT_PANEL, self.onOpenChatPanelHandler, self)
    --打开聊天气泡设置界面
    GameDispatcher:addEventListener(EventName.OPEN_CHATSETTING_PANEL, self.onOpenChatSettingPanelHandler, self)

    -- 请求聊天语音文件上传云桶
    GameDispatcher:addEventListener(EventName.REQ_CHAT_SPEECH_UPLOAD, self.onReqChatSpeechUpLoadHandler, self)
    -- 请求云桶聊天语音文件下载
    GameDispatcher:addEventListener(EventName.REQ_CHAT_SPEECH_DOWNLOAD, self.onReqChatSpeechDownLoadHandler, self)

    -- 请求聊天面板设置信息
    GameDispatcher:addEventListener(EventName.REQ_CHAT_PANEL_DATA, self.__reqChatPanelHandler, self)
    -- 请求发送聊天信息
    GameDispatcher:addEventListener(EventName.REQ_SEND_CHAT, self.__reqSendChatHandler, self)
    -- 请求修改频道房间号
    GameDispatcher:addEventListener(EventName.REQ_CHANGE_CHANNEL_ROOM, self.__reqChangeChannelRoomHandler, self)
    -- 通知后端前端聊天界面已关闭，后端发送的消息频率会降低
    GameDispatcher:addEventListener(EventName.REQ_NOTIFY_SERVER_CHAT_CLOSE, self.__reqNotifyServerChatCloseHandler, self)
    -- 请求表情包解锁列表
    GameDispatcher:addEventListener(EventName.REQ_EMOJI_UNLOCK_LIST, self.__reqGetEmojiUnlockList, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 聊天刷屏禁言时间戳 10048
        SC_CHAT_BAN_TIME = self.__onResChatForbidMsgHandler,
        --- *s2c* 聊天面板设置信息 10055
        SC_PUBLIC_CHAT_SETTING = self.__onResChatPanelMsgHandler,
        --- *s2c* 返回聊天信息 10051
        SC_PUBLIC_CHAT = self.__onResChatMsgHandler,
        --- *s2c* 修改聊天房间号 10053
        SC_CHANGE_CHAT_ROOM = self.__onResChangeChatRoomMsgHandler,
        --- *s2c* 获取表情列表 12030
        SC_GET_EMOJI_LIST = self.__onResGetEmojiListMsgHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 聊天刷屏禁言时间戳
function __onResChatForbidMsgHandler(self, msg)
    chat.ChatManager:setForbidTime(msg.channel, msg.ban_time)
end

-- 返回面板公共列表
function __onResChatPanelMsgHandler(self, msg)
    chat.ChatManager:updatePanelMsg(msg)
end

-- 返回聊天信息
function __onResChatMsgHandler(self, msg)
    chat.ChatManager:addChatMsg(msg)
end

-- 返回修改频道房间结果
function __onResChangeChatRoomMsgHandler(self, msg)
    chat.ChatManager:changeChatRoomMsg(msg)
end

--- *s2c* 获取表情列表 12030
function __onResGetEmojiListMsgHandler(self, msg)
    chat.ChatManager:onResGetEmojiListMsg(msg)
end

---------------------------------------------------------------请求------------------------------------------------------------------
--- *c2s* 公共聊天面板设置 10054
function __reqChatPanelHandler(self, args)
    local channel = args.channel
    SOCKET_SEND(Protocol.CS_PUBLIC_CHAT_SETTING, { channel = channel })
end

--- *c2s* 公共聊天 10050
function __reqSendChatHandler(self, args)
    local contentType = args.contentType
    local content = args.content
    local channel = args.channel
    local room = args.room
    SOCKET_SEND(Protocol.CS_PUBLIC_CHAT, { channel = channel, room = room, content_type = contentType, content = content })
end

--- *c2s* 修改聊天房间号 10052
function __reqChangeChannelRoomHandler(self, args)
    local room = args.room
    local channel = args.channel
    SOCKET_SEND(Protocol.CS_CHANGE_CHAT_ROOM, { channel = channel, room = room })
end

--- 通知后端前端聊天界面已关闭，后端发送的消息频率会降低
function __reqNotifyServerChatCloseHandler(self, args)
    SOCKET_SEND(Protocol.CS_CLOSE_PUBLIC_CHAT, { channel = args.channel })
end

--- *c2s* 获取表情列表 12029
function __reqGetEmojiUnlockList(self)
    SOCKET_SEND(Protocol.CS_GET_EMOJI_LIST)
end

------------------------------------------------------------------界面------------------------------------------
function onOpenChatPanelHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CHAT, true) == false then
        return
    end
    if self.mChatPanel == nil then
        self.mChatPanel = chat.ChatPanel.new()
        self.mChatPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    end
    self.mChatPanel:open(args)
end

-- ui销毁
function onDestroyViewHandler(self)
    self.mChatPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.mChatPanel = nil
end

function onOpenChatSettingPanelHandler(self, args)
    if self.mChatSettingPanel == nil then
        self.mChatSettingPanel = chat.ChatSettingPanel.new()
        self.mChatSettingPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyChatSettingPanelHandler, self)
    end
    self.mChatSettingPanel:open(args)
end

-- ui销毁
function onDestroyChatSettingPanelHandler(self)
    self.mChatSettingPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.mChatSettingPanel = nil
end

------------------------------------------------------------------语音文件处理------------------------------------------
-- 请求聊天语音文件上传云桶
function onReqChatSpeechUpLoadHandler(self, args)
    local voiceContent = args.voiceContent
    local voiceFileName = args.voiceFileName
    local clientFileRPath = sdk.SdkManager:getXunFeiAudioRPath(voiceFileName)
    local clientFileWPath = sdk.SdkManager:getXunFeiAudioWPath(voiceFileName)
    local clientFileRCompressPath = chat.formatCompressSuffix(clientFileRPath)
    local clientFileWCompressPath = chat.formatCompressSuffix(clientFileWPath)
    if (gs.File.Exists(clientFileWPath)) then
        if (self.mChatPanel and self.mChatPanel.isPop) then
            local channel = self.mChatPanel:getCurChannel()
            local room = self.mChatPanel:getCurRoom()
            local serverFilePath = string.format("voice/world_chat/channel_%s/room_%s/%s", channel, room, sdk.SdkManager:getXunFeiAudioName(voiceFileName))
            voiceContent = FilterWordUtil:filter(voiceContent)
            -- if FilterWordUtil:hasFilterWord(voiceContent) then
            --     gs.Message.Show(_TT(513)) --"存在敏感字或非法符号"
            if (voiceContent == "") then
                gs.Message.Show("请说话")
                -- 删除本地录音文件
                gs.File.Delete(clientFileWPath)
            else
                local function upLoadResultCall(result)
                    if (result) then
                        if (self.mChatPanel and self.mChatPanel.isPop) then
                            GameDispatcher:dispatchEvent(EventName.REQ_SEND_CHAT, { contentType = chat.ContentType.VOICE_TEXT, content = chat.getVoiceFormatContent(string.omit(voiceContent, sysParam.SysParamManager:getValue(SysParamType.CHAT_VOICE_CHARACTER_LIMIT)), serverFilePath, clientFileRPath), channel = channel, room = room })
                        else
                            -- 删除本地录音文件
                            gs.File.Delete(clientFileWPath)
                            gs.File.Delete(clientFileWCompressPath)
                            -- 删除云桶录音文件
                            sdk.SdkManager:cosxmlDeleteObject(serverFilePath)
                        end
                    else
                        gs.Message.Show("网络异常，发送失败")
                        -- 删除本地录音文件
                        gs.File.Delete(clientFileWPath)
                        gs.File.Delete(clientFileWCompressPath)
                    end
                end
                gs.FileUtil.CompressFileByGzip(clientFileWPath, clientFileWCompressPath)
                sdk.SdkManager:cosxmlPutObject(serverFilePath, clientFileWCompressPath, nil, upLoadResultCall)
            end
        else
            -- 删除本地录音文件
            gs.File.Delete(clientFileWPath)
        end
    else
        gs.Message.Show("录音异常，发送失败")
        print("不存在文件：", clientFileWPath)
    end
end

-- 请求云桶聊天语音文件下载
function onReqChatSpeechDownLoadHandler(self, args)
    if (self.mChatPanel and self.mChatPanel.isPop) then
        local voiceContent, serverFilePath, voiceLen = chat.parseVoiceFormatContent(args.content)
        local fileNameWithExtensions = string.getFileNameByPath(serverFilePath)
        local fileNameWithoutExtensions = string.split(fileNameWithExtensions, ".")[1]
        local clientFileRPath = sdk.SdkManager:getXunFeiAudioRPath(fileNameWithoutExtensions)
        local clientFileWPath = sdk.SdkManager:getXunFeiAudioWPath(fileNameWithoutExtensions)
        if (gs.File.Exists(clientFileWPath)) then
            gs.AudioManager:StopPcm()
            gs.AudioManager.PcmVolume = 100
            gs.AudioManager:PlayPcm(clientFileRPath, sdk.XunFeiParam.SampleRate, nil)
        else
            local function downLoadResultCall(result)
                gs.FileUtil.DecompressFileByGzip(chat.formatCompressSuffix(clientFileWPath), clientFileWPath)
                if (self.mChatPanel and self.mChatPanel.isPop) then
                    if (result) then
                        -- gs.Message.Show("云桶：下载成功")
                        gs.AudioManager:StopPcm()
                        gs.AudioManager.PcmVolume = 100
                        gs.AudioManager:PlayPcm(clientFileRPath, sdk.XunFeiParam.SampleRate, nil)
                    else
                        -- gs.Message.Show("云桶：下载失败")
                    end
                end
            end
            sdk.SdkManager:cosxmlGetObject(serverFilePath, sdk.SdkManager:getXunFeiAudioWPath(), chat.formatCompressSuffix(fileNameWithExtensions), nil, downLoadResultCall)
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]