--[[ 	
-----------------------------------------------------
@filename       : FilterWordUtil
@Description    : 屏蔽词管理
@date           : 2020-09-11 18:04:42
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('FilterWordUtil', Class.impl())

-- 过滤关键词，替换**
function filter(self, t)
    return gs.FilterWordMgr:Filter(t)
end

-- 是否存在非法符号
function hasIllegalWord(self, t)
    return gs.FilterWordMgr:HasIllegalWord(t)
end

-- 是否存在屏蔽字和非法符号
function hasFilterWord(self, t)
    return gs.FilterWordMgr:HasFilterWord(t)
end

-- 命名屏蔽规则（只允许汉字字母数字）
function HasReNameFilterWord(self, t)
    return gs.FilterWordMgr:HasReNameFilterWord(t)
end

-- 额外屏蔽词，用于快速屏蔽违禁词，仅客户端显示时使用 替换**
function filterTemp(self, t)
    local content = string.lower(t)
    local baseData = RefMgr:getData("filter_word_temp")
    for key, data in pairs(baseData) do
        local machStr = string.lower(data.language)
        local machLen = string.getStringCharCount(machStr)
        local machIndex = string.find(content, machStr)
        if machIndex ~= nil then
            local replaceStr = ""
            for i = 1, machLen do
                replaceStr = replaceStr .. "*"
            end
            content = string.gsub(content, machStr, replaceStr)
        end
    end
    return content
end

return _M