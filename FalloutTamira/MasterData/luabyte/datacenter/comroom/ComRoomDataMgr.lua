local ComRoomDataMgr = BaseClass("ComRoomDataMgr", Singleton)
local M = ComRoomDataMgr
local MessageId = Proto.MessageId
local tInsert = table.insert
local tIsNullOrEmpty = table.isNullOrEmpty

function M:__init(obj)
    self._responseEnterStory = NetPack:RegistResponse(MessageId.ResponseEnterHeroStory,
        Bind(self,self.OnResponseEnterHeroStory))
    self._responseDrawStoryGift = NetPack:RegistResponse(MessageId.ResponseDrawStoryGift,
        Bind(self, self.OnResponseDrawStoryGift))
    self.OnNotifyUnlockStoryHandler = NetPack:RegistResponse(MessageId.NotifyUnlockStory,
        Bind(self,self.OnNotifyUnlockStory))
    self._heroStoryCfgs = ConfigHelper.GetCfgsByLua("heroStory")
    self._readDict = nil
    self._unreadDict = nil
    self._capResIndexDict = nil
    self._tabList = nil
    self._curChatName = nil
    self._typingTime = nil
    self.serverDatas = {}
    self._chatInterval = ConfigHelper.GetSystemParam(225)
    self.isGetAllServerData = false
end

function M:Dispose()
    NetPack:UnRegistResponse(MessageId.ResponseEnterHeroStory, self._responseEnterStory)
    NetPack:UnRegistResponse(MessageId.ResponseDrawStoryGift, self._responseDrawStoryGift)
    NetPack:UnRegistResponse(MessageId.NotifyUnlockStory, self.OnNotifyUnlockStoryHandler)
    self._responseEnterStory = nil
    self._responseDrawStoryGift = nil

    self._heroStoryCfgs = nil
    self._readDict = nil
    self._unreadDict = nil
    self._capResIndexDict = nil
    self._tabList = nil
    self._curChatName = nil
    self._typingTime = nil
    self._chatInterval = nil
    self.isGetAllServerData = false
    self.serverDatas = {}
end

---------------------初始化数据Begin----------------------

function M:_InitData(data, isOpen)
    if tIsNullOrEmpty(data) and isOpen then
        GameHelper.TipsById(923)
    else
        local serverData = self:_ParseServerData(data)
        local hasLocalData = self:_HasLocalReadList()
        self:_InitChatDict(serverData, hasLocalData)
        self:_InitTabList(serverData)
        self:_InitTabEnd()
        if isOpen then
            UIContextMgr:GetInstance():Show("ComUI")
        end
    end
end

--初始化服务端数据
function M:_ParseServerData(data)
    table.sort(data, function(a, b) return a.UnlockTick < b.UnlockTick end)
    local serverData = {}
    for i = 1, #data do
        local heroStory = data[i]
        local story = heroStory.Id
        local groups = {}
        local indexes = {}

        if #heroStory.Rec > 0 then
            for j = 1, #heroStory.Rec do
                local values = SecurityHelper.SperateInt(heroStory.Rec[j])
                if values then
                    tInsert(groups, values[0])
                    tInsert(indexes, values[1])
                end
            end
        end
        local tempData = {
            story = story, 
            length = #heroStory.Rec,
            groups = groups, 
            indexes = indexes
        }
        tInsert(serverData, tempData)
    end
    return serverData
end

function M:_InitChatDict(serverData, hasLocalData)
    self._unreadDict = {}
    if not hasLocalData then
        self._readDict = {}
    end

    for i = 1, #serverData do
        local chatName = self:_GetChatName(serverData[i].story)
        --服务器有已读对话数据
        if serverData[i].length > 0 then
            if not hasLocalData then
                local readHeroStoryCfgs = self:_GetReadHeroStoryCfgs(serverData[i])

                if readHeroStoryCfgs and chatName then
                    if not self._readDict[chatName] then
                        self._readDict[chatName] = {}
                    end
                    for j = 1, #readHeroStoryCfgs do
                        tInsert(self._readDict[chatName], readHeroStoryCfgs[j])
                        self:_InitCaptionSelectIndexes(readHeroStoryCfgs[j], serverData[i])
                    end
                    self:_SetLineData(chatName, readHeroStoryCfgs[1].story)
                end
            end
        --服务器没有已读对话数据
        else
            local groupCfgs = self:_GetGroupCfgs(serverData[i].story)
            if groupCfgs and chatName then
                if not self._unreadDict[chatName] then
                    self._unreadDict[chatName] = {}
                end
                for j = 1, #groupCfgs do
                    tInsert(self._unreadDict[chatName], groupCfgs[j])
                end
            end
        end
    end
end

function M:_InitTabList(serverData)
    local tabList = {}
    for i = 1, #serverData do
        local heroStoryCfg = self:_GetHeroStoryCfg(serverData[i].story)
        local hasChatName = false
        if heroStoryCfg then
            for j = 1, #tabList do
                if heroStoryCfg.chatName == tabList[j].chatName then
                    hasChatName = true
                    break
                end
            end
            if not hasChatName then
                heroStoryCfg.select = false
                tInsert(tabList, heroStoryCfg)
            end
        end
    end
    self:_SortTabList(tabList)
end

function M:_SortTabList(tabList)
    local unreadList = {}
    local readingList = {}
    local readList = {}
    local curChatName = nil
    local time = nil

    for i = 1, #tabList do
        curChatName = tabList[i].chatName
        if self._unreadDict[curChatName] and #self._unreadDict[curChatName] > 0 then
            time = PlayerPrefabHelper.GetInt(ComConst.ComTime .. curChatName)
            if time and time > 0 then
                tabList[i].time = time
                tInsert(readingList, tabList[i])
            else
                tInsert(unreadList, tabList[i])
            end
        else
            tInsert(readList, tabList[i])
        end
    end

    if #readingList > 0 then
        table.sort(readingList, function(a, b) return a.time > b.time end)
    end

    self._tabList = {}

    if #unreadList > 0 then
        for i = 1, #unreadList do
            tInsert(self._tabList, unreadList[i])
        end
    end
    
    if #readingList > 0 then
        for i = 1, #readingList do
            tInsert(self._tabList, readingList[i])
        end
    end

    if #readList > 0 then
        for i = 1, #readList do
            tInsert(self._tabList, readList[i])
        end
    end

    if self._tabList[1] then
        self._tabList[1].select = true
        self._curChatName = self._tabList[1].chatName
    end

end

function M:_InitTabEnd()
    for i = 1, #self._tabList do
        local chatName = self._tabList[i].chatName
        self._tabList[i].isEnd = self._readDict[chatName] and not self._unreadDict[chatName]
    end
end

function M:_InitCaptionSelectIndexes(heroStoryCfg, serverData)
    if heroStoryCfg and serverData then
        if heroStoryCfg.speaker == ComConst.Speaker.Caption and #heroStoryCfg.words > 0 then
            for i = 1, #serverData.indexes do
                if heroStoryCfg.group == serverData.groups[i] then
                    local wordsIndex = serverData.indexes[i] + 1
                    self:_SetCaptionSelectIndex(heroStoryCfg.id, wordsIndex)
                end
            end
        end
    end
end

---------------------初始化数据End----------------------

---------------------网络消息Begin----------------------

--用于在登录的时候初始化相关数据
function M:LoadData()
    self._isloading = true
    self._dataLoaded = false
    self._errorCode = 0
    self:GetHeroStoryData()
end

function M:IsLoading()
    return self._isloading
end

function M:IsReady()
    return self._dataLoaded
end

function M:ErrorCode()
    return self._isloading
end

function M:Cleanup()
end

--获得通讯对话数据
function M:RequestEnterHeroStory(callback)
    self.isGetAllServerData = true
    self.getHeroStoryCallback = callback
    NetPack:SendMessage(MessageId.RequestEnterHeroStory, {})
end

function M:OnResponseEnterHeroStory(messageId, result, msg)
    self._isSending = false
    self._dataLoaded = true
    self._isloading = false
    if result ~= 0 then
        return 
    end
    self.serverDatas = msg.HeroStories
    if self.getHeroStoryCallback then
        self.getHeroStoryCallback()
    end
end

--发送当前对话已读数据
function M:RequestDrawStoryGift(id, choices)
    local request = {}
    request.StoryId = id
    request.Choices = choices
    NetPack:SendMessage(MessageId.RequestDrawStoryGift, request)
end

function M:OnResponseDrawStoryGift(messageId, result, msg)
    if result ~= 0 then
        return
    end
    self:UpdateServerData(msg.HeroStory)
    --更新未阅读列表
    self:UpdateUnread(self.saveChatName, self.saveStory)
end

function M:OnNotifyUnlockStory(messageId, result, msg)
    if result ~= 0 then
        return
    end
    tInsert(self.serverDatas, msg.HeroStory)
    self:_InitData(self.serverDatas, false)
    --刷新红点
    IRedPointMgr:ForceCheck(RedPointConst.AddressBookRedPointChecker)
end

---------------------网络消息End----------------------

---------------------设置数据Begin--------------------

function M:UpdateServerData(data)
    for key, value in pairs(self.serverDatas) do
        if value.Id == data.Id then
            value.Rec = data.Rec
            return
        end
    end
end

function M:GetHeroStoryData(isOpen)
    if # self.serverDatas > 0 and self.isGetAllServerData then
        self:_InitData(self.serverDatas, isOpen)
    else
        self:RequestEnterHeroStory(function ()
            self:_InitData(self.serverDatas, isOpen)
        end)
    end
end

function M:SetCaptionSelectData(index)
    local nextStory = self:GetCaptionSelectStory()
    self:_SetCaptionSelectIndex(nextStory.id, index)
    self:_SetTypedData(nextStory)
end

function M:_SetCaptionSelectIndex(id, index)
    if not self._capResIndexDict then
        self._capResIndexDict = {}
    end
    if not self._capResIndexDict[id] then
        self._capResIndexDict[id] = {}
    end
    self._capResIndexDict[id] = index
end

function M:UpdateTabListSelect(chatName)
    if not tIsNullOrEmpty(self._tabList) then
        for i = 1, #self._tabList do
            if self._tabList[i].chatName == chatName then
                self._tabList[i].select = true
                self._curChatName = chatName
            else
                self._tabList[i].select = false
            end
        end
    end
end

function M:_SetLineData(chatName, story)
    local length = #self._readDict[chatName]
    if self._readDict[chatName][length].type == ComConst.Type.Line then
        return
    end
    local lineData = {}
    lineData.chatType = ComConst.ChatType.Private
    lineData.type = ComConst.Type.Line
    lineData.speaker = ComConst.Speaker.Role
    lineData.story = story
    tInsert(self._readDict[chatName], lineData)
    self._typingTime = self._chatInterval
end

function M:_SetTypedData(story)
    if story then
        if not self._readDict[self._curChatName] then
            self._readDict[self._curChatName] = {}
        end
        tInsert(self._readDict[self._curChatName], story)
        self._typingTime = self._chatInterval
    end
end

function M:_SetTypingData()
    local nextStory = nil
    if not self._readDict[self._curChatName] then
        self._readDict[self._curChatName] = {}
        nextStory = self._unreadDict[self._curChatName][1]
    else
        local preStory = self:_GetPreviousStory()
        if not preStory then
            nextStory = self._unreadDict[self._curChatName][1]
        else
            nextStory = self:_GetNextStory(preStory)
            if not nextStory then
                nextStory = self:_GetNextGroupStory(preStory)
            end
        end
    end

    local typingData = {}
    typingData.id = 999999
    typingData.chatType = nextStory.chatType
    typingData.chatName = nextStory.chatName
    typingData.hero = nextStory.hero
    typingData.heroName = nextStory.heroName
    typingData.type = nextStory.type
    typingData.speaker = nextStory.speaker
    self._typingTime = nextStory.times / 1000

    tInsert(self._readDict[self._curChatName], typingData)
end

function M:_SetCaptionTypedData(nextStory)
    self._typingTime = self._chatInterval
    EventMgr:Broadcast(UIMessageNames.COM_SHOW_CAPTION_SELECT, nextStory.words)
end

function M:_RemoveTypingData()
    if not tIsNullOrEmpty(self._readDict[self._curChatName]) then
        local length = #self._readDict[self._curChatName]
        if self._readDict[self._curChatName][length].id == 999999 then
            table.remove(self._readDict[self._curChatName], length)
        end
    end
end

function M:_SetStoryEnd()
    for i = 1, #self._tabList do
        if self._tabList[i].chatName == self._curChatName then
            self._tabList[i].isEnd = true
        end
    end
end

function M:SetSelectNextChatData()
    local chatType = self:_GetSelectNextChatType()
    if chatType then
        if chatType == ComConst.ChatType.Offical then
            self._readDict[self._curChatName] = self._unreadDict[self._curChatName]
            self._unreadDict[self._curChatName] = nil
            self:_SetStoryEnd()
        elseif chatType == ComConst.ChatType.Private or chatType == ComConst.ChatType.Group then
            --没有英雄已读数据
            if tIsNullOrEmpty(self._readDict[self._curChatName]) then
                local nextStory = self._unreadDict[self._curChatName][1]
                if nextStory.speaker == ComConst.Speaker.Role then
                    self:_SetTypingData()
                else
                    self:_SetCaptionTypedData(nextStory)    
                end
            --有英雄已读数据
            else
                --此处preStory必存在，不可能为空，故省去一次if判断
                local preStory = self:_GetPreviousStory()
                --上一条是正在阅读中
                if preStory.id == 999999 then
                    --移除allList上一条阅读中的数据
                    self:_RemoveTypingData()
                    preStory = self:_GetPreviousStory()
                    --allList上一条数据存在
                    if preStory then
                        local nextStory = self:_GetNextStory(preStory)
                        --当前章节，下一条数据存在
                        if nextStory then
                            if nextStory.speaker == ComConst.Speaker.Caption then
                                self:_SetCaptionTypedData(nextStory)
                            elseif nextStory.type == ComConst.Type.Line then
                                self:_SetLineData(self._curChatName, nextStory.story)
                                self:_SendSaveDataMsg(preStory.story)
                            else
                                self:_SetTypedData(nextStory)
                            end
                        --当前章节，最后一条数据
                        else 
                            nextStory = self:_GetNextGroupStory(preStory)
                            --下一章节章节，下一条数据存在
                            if nextStory then
                                if nextStory.speaker == ComConst.Speaker.Caption then
                                    self:_SetCaptionTypedData(nextStory)
                                else
                                    self:_SetTypedData(nextStory)
                                end
                            --下一章节章节，下一条数据不存在
                            else
                                self:_SetStoryEnd()
                                Logger.Log(self._curChatName .. "对话剧情结束")
                            end
                        end
                    --allList上一条数据不存在
                    else
                        local nextStory = self._unreadDict[self._curChatName][1]
                        if nextStory.speaker == ComConst.Speaker.Role then
                            self:_SetTypedData(nextStory)
                        else
                            self:_SetCaptionTypedData(nextStory)
                        end
                    end
                --上一条不是正在阅读中
                else
                    local nextStory = self:_GetNextStory(preStory)
                    --当前章节，下一条数据存在
                    if nextStory then
                        if nextStory.speaker == ComConst.Speaker.Caption then
                            self:_SetCaptionTypedData(nextStory)
                        elseif nextStory.type == ComConst.Type.Line then
                            self:_SetLineData(self._curChatName, nextStory.story)
                            self:_SendSaveDataMsg(preStory.story)
                        else
                            self:_SetTypingData()
                        end
                    --当前章节，最后一条数据
                    else
                        nextStory = self:_GetNextGroupStory(preStory)
                        --下一章节，下一条数据存在
                        if nextStory then
                            if nextStory.speaker == ComConst.Speaker.Caption  then
                                self:_SetCaptionTypedData(nextStory)
                            else
                                self:_SetTypingData()
                            end
                        --下一章节，下一条数据不存在
                        else
                            self:_SetStoryEnd()
                            Logger.Log(self._curChatName .. "对话剧情结束")
                        end
                    end
                end
            end
        end
    end
end

function M:_SendSaveDataMsg(story)
    local groupCfgs = self:_GetGroupCfgsFromReadList(story)
    local recList = {}

    if not tIsNullOrEmpty(groupCfgs) then
        for i = 1, #groupCfgs do
            local group = groupCfgs[i].group
            local index = 0

            if groupCfgs[i].speaker == ComConst.Speaker.Caption and #groupCfgs[i].words > 0 then
                index = self:GetCaptionSelectIndex(groupCfgs[i].id)
                index = index - 1
            end

            local rec = SecurityHelper.CombineShort(group, index)
            tInsert(recList, rec)
        end

        self.saveStory = groupCfgs[1].story
        self.saveChatName = groupCfgs[1].chatName
        self:RequestDrawStoryGift(self.saveStory, recList)
    end
end

---------------------设置数据End----------------------

---------------------获取数据Begin--------------------

function M:_GetGroupCfgs(story)
    local list = nil
    if self._heroStoryCfgs then
        for _, heroStoryCfg in pairs(self._heroStoryCfgs) do
            if heroStoryCfg.story == story then
                if not list then
                    list = {}
                end
                tInsert(list, heroStoryCfg);
            end
        end
    end
    return list
end

function M:_GetGroupCfgsFromReadList(story)
    local list = nil
    if not tIsNullOrEmpty(self._readDict[self._curChatName]) then
        for _, cfg in pairs(self._readDict[self._curChatName]) do
            if cfg.story == story and cfg.type ~= ComConst.Type.Line then
                if not list then
                    list = {}
                end
                tInsert(list, cfg);
            end
        end
    end
    return list
end

function M:_GetHeroStoryCfg(story)
    if self._heroStoryCfgs then
        for _, heroStoryCfg in pairs(self._heroStoryCfgs) do
            if heroStoryCfg.story == story then
                return heroStoryCfg
            end
        end
    end
    return nil
end

function M:GetTabList()
    return self._tabList
end

function M:GetSelectReadList()
    if self._readDict and self._readDict[self._curChatName] then
        return self._readDict[self._curChatName]
    end
    return nil
end

function M:GetSelectUnreadList()
    if self._unreadDict and self._unreadDict[self._curChatName] then
        return self._unreadDict[self._curChatName]
    end
    return nil
end

function M:_GetSelectNextChatType()
    if not tIsNullOrEmpty(self._unreadDict[self._curChatName]) then
        return self._unreadDict[self._curChatName][1].chatType
    end
    return nil
end

function M:_GetPreviousStory()
    if not tIsNullOrEmpty(self._readDict[self._curChatName]) then
        local length = #self._readDict[self._curChatName]
        local preStory = self._readDict[self._curChatName][length]
        return preStory
    end
    return nil
end

function M:_GetNextStory(preStory)
    if not tIsNullOrEmpty(preStory.nextGroup) then
        if not tIsNullOrEmpty(self._unreadDict[self._curChatName]) then
            local index = 1
            if preStory.speaker == ComConst.Speaker.Caption then
                index = self:GetCaptionSelectIndex(preStory.id)
            end

            for i = 1, #self._unreadDict[self._curChatName] do
                local nextStory = self._unreadDict[self._curChatName][i]
                if 
                    nextStory.story == preStory.story and 
                    nextStory.group == preStory.nextGroup[index] 
                then
                    return nextStory
                end
            end
        end
    end
end

function M:GetCaptionSelectIndex(id)
    if self._capResIndexDict[id] then
        return self._capResIndexDict[id]
    end
    return nil
end

function M:_GetNextGroupStory(preStory)
    local index = 1
    for i = 1, #self._unreadDict[self._curChatName] do
        if self._unreadDict[self._curChatName][i].story == preStory.story then
            index = i
            break
        end
    end

    for i = index, #self._unreadDict[self._curChatName] do
        if self._unreadDict[self._curChatName][i].story ~= preStory.story then
            return self._unreadDict[self._curChatName][i]
        end
    end
    return nil
end

--获取聊天名称
function M:_GetChatName(story)
    if self._heroStoryCfgs then
        for _, heroStoryCfg in pairs(self._heroStoryCfgs) do
            if heroStoryCfg.story == story then
                return heroStoryCfg.chatName
            end
        end
    end
    return nil
end

--获取聊天内容
function M:_GetReadHeroStoryCfgs(serverData)
    local readHeroStoryCfgs = nil
    if self._heroStoryCfgs then
        for _, heroStoryCfg in pairs(self._heroStoryCfgs) do
            if(heroStoryCfg.story == serverData.story) then
                for i = 1, #serverData.groups do
                    if(serverData.groups[i] == heroStoryCfg.group) then
                        if not readHeroStoryCfgs then
                            readHeroStoryCfgs = {}
                        end
                        tInsert(readHeroStoryCfgs, heroStoryCfg)
                    end
                end
            end
        end
    end
    return readHeroStoryCfgs
end

--根据聊天类型获取聊天数据
function M:GetChatTypeData(chatType)
    local data = nil
    if not tIsNullOrEmpty(self._tabList) then
        if chatType == ComConst.ChatType.Private then
            data = self:_GetPrivateTabData()
        elseif chatType == ComConst.ChatType.Group then
            data = self:_GetGroupTabData()
        elseif chatType == ComConst.ChatType.Offical then
            data = self:_GetOfficalTabData()
        elseif chatType == ComConst.ChatType.All then
            data = self._tabList
        end
        if not tIsNullOrEmpty(data) then
            data[1].select = true
            self._curChatName = data[1].chatName
        end
    end
    return data
end

function M:GetChatType()
    for i = 1, #self._tabList do
        if self._tabList[i].chatName == self._curChatName then
            return self._tabList[i].chatType
        end
    end
end

--获取私聊列表
function M:_GetPrivateTabData()
    local data = nil
    for i = 1, #self._tabList do
        if self._tabList[i].chatType == ComConst.ChatType.Private then
            if not data then
                data = {}
            end
            tInsert(data, self._tabList[i])
        end
    end
    return data
end

--获取群聊列表
function M:_GetGroupTabData()
    local data = nil
    for i = 1, #self._tabList do
        if self._tabList[i].chatType == ComConst.ChatType.Group then
            if not data then
                data = {}
            end
            tInsert(data, self._tabList[i])
        end
    end
    return data
end

--获取公众号列表
function M:_GetOfficalTabData()
    local data = nil
    for i = 1, #self._tabList do
        if self._tabList[i].chatType == ComConst.ChatType.Offical then
            if not data then
                data = {}
            end
            tInsert(data, self._tabList[i])
        end
    end
    return data
end

function M:GetTypingTime()
    return self._typingTime
end

function M:GetCaptionSelectStory()
    local preStory = self:_GetPreviousStory()
    local nextStory = nil
    if not preStory then
        nextStory = self._unreadDict[self._curChatName][1]
    else
        nextStory = self:_GetNextStory(preStory)
        if not nextStory then
            nextStory = self:_GetNextGroupStory(preStory)
        end
    end
    return nextStory
end

function M:GetUnreadCount(chatName)
    if chatName ~= 0 then
        if self._unreadDict and self._unreadDict[chatName] then
            return 1
        else
            return 0
        end
    else
        if self._unreadDict and table.count(self._unreadDict) > 0 then
            return 1
        end
        return 0
    end
end

function M:UpdateUnread(chatName, story)
    local unreadList = self._unreadDict[chatName]
    local choose = table.choose(unreadList, function (k,v)
        return v.story ~= story
    end)
    if #choose > 0 then
        self._unreadDict[chatName] = choose
    else
        self._unreadDict[chatName] = nil
    end
    self.saveStory = nil
    self.saveChatName = nil
    --刷新红点
    IRedPointMgr:ForceCheck(RedPointConst.AddressBookRedPointChecker)
end

function M:GetCurrentId()
    if self._readDict and self._readDict[self._curChatName] then
        local length = #self._readDict[self._curChatName]
        return self._readDict[self._curChatName][length].id
    end
    return nil
end

---------------------获取数据End----------------------

---------------------数据判断Begin--------------------

--是否有本地已读数据
function M:_HasLocalReadList()
    if self._readDict then
        return true
    end
    return false
end

--
function M:IsStoryEnd()
    for i = 1, #self._tabList do
        if self._tabList[i].chatName == self._curChatName then
            return self._tabList[i].isEnd
        end
    end
    return false
end

---------------------数据判断End----------------------

return ComRoomDataMgr
