-- 聊天频道类型，与服务器对应
chat.ChannelType = {
    -- 世界
    WORLD = 1,
    -- 私聊
    PRIVATE = 2,
    -- 联盟
    GUILD = 3,
}

-- 聊天页签类型
chat.ChatTabType = {
    -- 世界
    WORLD = 1,
    -- 联盟
    GUILD = 2,
}

chat.getPageName = function(cusPageType)
    local name = ""
    if (cusPageType == chat.ChatTabType.WORLD) then
        name = _TT(505)--"世界"
    end
    return name
end

chat.getChannelByTab = function(cusPageType)
    local channelType = chat.ChannelType.SYSTEM
    if (cusPageType == chat.ChatTabType.WORLD) then
        channelType = chat.ChannelType.WORLD
    end
    if (cusPageType == chat.ChatTabType.GUILD) then
        channelType = chat.ChannelType.GUILD
    end
    return channelType
end

chat.getTabByChannel = function(cusChannel)
    local tabType = chat.ChatTabType.SYSTEM
    if (cusChannel == chat.ChannelType.WORLD) then
        tabType = chat.ChatTabType.WORLD
    end
    if (cusChannel == chat.ChannelType.GUILD) then
        tabType = chat.ChatTabType.GUILD
    end
    return tabType
end

-- 是否合法字符
chat.isLegal = function(content, isShowTip)
    local isEmpty = true
    local isSensitive = true

    local tempStr = ""
    for i = 1, string.len(content) do
        tempStr = string.sub(content, i, i)
        if (tempStr ~= " ") then
            isEmpty = false
            break
        end
    end
    isSensitive = false

    if (isShowTip) then
        if (isEmpty) then
            gs.Message.Show(_TT(506)) --"内容为空"
        elseif (isSensitive) then
            gs.Message.Show(_TT(507)) --"内容包含敏感词"
        end
    end

    return not isEmpty and not isSensitive
end

-- 用于检索用户输入的文本是否为表情格式，是则强行转成指定格式表情
chat.getEmojiCode = function(content)
    if (string.starts(chatVo.content, RichTextUtil.m_startSign) and string.ends(chatVo.content, RichTextUtil.m_endSign)) then
        self.m_textChatContent.text = _TT(508) --"[表情]"
    else
        self.m_textChatContent.text = playerName .. "：" .. chatVo.content
    end
end

-- 聊天内容类型
chat.ContentType = {
    -- 静态表情
    STATIC_EMOJI = 1,
    -- 动态表情
    DYNAMIC_EMOJI = 2,
    -- 纯文本
    JUST_TEXT = 3,
    -- 超链接
    HERF_LINK = 4,
    -- 语音文本
    VOICE_TEXT = 5,
}

-- 聊天内容类型是否在规定之内
chat.isTypeLegal = function(type)
    if (type <= chat.ContentType.VOICE_TEXT) then
        return true
    end
    return false
end

-- 获取表情路径
chat.getEmojiUrl = function(type, index)
    if (type == chat.ContentType.STATIC_EMOJI) then
        return UrlManager:getStaticEmojiUrl(index)
    elseif (type == chat.ContentType.DYNAMIC_EMOJI) then
        local list = {}
        for subIndex = 1, 6 do
            table.insert(list, UrlManager:getDynamicEmojiUrl(index .. "_" .. subIndex))
        end
        return list
    end
end

-- 获取格式化内容
chat.getFormatContent = function(content)
    return string.gsub(content, "%\n", "% ")
end

-- 获取音频格式化内容
chat.getVoiceFormatContent = function(voiceContent, serverFilePath, clientFilePath)
    if (string.find(serverFilePath, "|") == nil) then
        local volumeLen = gs.WavUtility.GetPcmLenByPcmFile(clientFilePath, 8000)
        cusLog("输出长度" .. volumeLen)
        return voiceContent .. "|" .. serverFilePath .. "&" .. volumeLen
    else
        Debug:log_error("ChatConst", "key不能包含字符：|")
    end
end

-- 补足音频对应的压缩后的后缀
chat.formatCompressSuffix = function(withExtensions)
    return withExtensions .. "b"
end

-- 解析音频格式化内容
chat.parseVoiceFormatContent = function(content)
    local voiceContent = content
    if (voiceContent) then
        local len = string.len(voiceContent)
        if (len >= 3) then
            local lastIndex = string.find(voiceContent, "|", 0, true)
            local voiceContent = string.sub(content, 0, lastIndex - 1)
            local temp = string.sub(content, lastIndex + 1, len)
            local splitList = string.split(temp, "&")
            return voiceContent, splitList[1], splitList[2]
        end
    end
end

-- 获取聊天语音文件名
chat.getVoiceFileName = function()
    return role.RoleManager:getRoleVo().playerId .. "_" .. tostring(web.__getTime())
end

-- 获取聊天语音文件名
chat.getTabIconUrl = function(tab)
    local tabIndex = 18
    if tab == 2 then
        tabIndex = 101
    elseif tab == 3 then
        tabIndex = 201
    end
    return UrlManager:getStaticEmojiUrl(tabIndex)
end

-- 根据消息类型获取显示item
chat.getShowItem = function(type)
    if (type == chat.ContentType.STATIC_EMOJI) then       -- 静态表情
        return chat.ChatItem
    elseif (type == chat.ContentType.DYNAMIC_EMOJI) then  -- 动态表情
        return chat.ChatItem
    elseif (type == chat.ContentType.JUST_TEXT) then      -- 纯文本
        return chat.ChatItem
    elseif (type == chat.ContentType.HERF_LINK) then      -- 超链接
        return chat.ChatItem
    elseif (type == chat.ContentType.VOICE_TEXT) then     -- 语音文本
        return chat.ChatItem
    else
        return chat.ChatItem
    end
end

--[[ 替换语言包自动生成，请勿修改！
]]