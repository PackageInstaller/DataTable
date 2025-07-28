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

return _M