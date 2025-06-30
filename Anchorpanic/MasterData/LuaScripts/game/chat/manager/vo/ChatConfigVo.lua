module("chat.ChatConfigVo", Class.impl())

function ctor(self)
end

-- 解析消息
function parseData(self, channel, cusData)
    -- 聊天频道类型
    self.channel = channel
    -- 发言间隔
    self.chatInterval = cusData.chat_interval
    -- 最大文字数
    self.maxWords = cusData.max_words
    -- 最大显示消息条数
    self.maxShowCount = cusData.max_keep
    -- 历史消息保存数
    self.historyCount = cusData.history_num
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
