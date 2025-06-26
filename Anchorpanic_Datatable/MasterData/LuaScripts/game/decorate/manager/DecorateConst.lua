-- 模块类型（和服务器保持一致）
decorate.ModuleType = {
    -- 头像
    HEAD = 0,
    -- 头像框
    HEAD_FRAME = 1,
    -- 称号
    TITLE = 2,
    --背景
    BACKGROUND = 3,
    --聊天气泡
    CHATBUBLLE = 4,
}

-- 切卡类型
decorate.TabType = {
    -- 头像
    HEAD = 0,
    -- 头像框
    HEAD_FRAME = 1,
    -- 称号
    TITLE = 2,
    --背景
    BACKGROUND = 3,
    --聊天气泡
    CHATBUBLLE = 4,
}

decorate.getNameByTabType = function(tabType)
    if (tabType == decorate.TabType.HEAD) then
        return _TT(25200)
    elseif (tabType == decorate.TabType.HEAD_FRAME) then
        return _TT(25201)
    elseif (tabType == decorate.TabType.TITLE) then
        return _TT(25202)
    elseif (tabType == decorate.TabType.BACKGROUND) then
        return _TT(25203)
    end
end

decorate.getModuleTypeByTabType = function(tabType)
    if (tabType == decorate.TabType.HEAD) then
        return decorate.ModuleType.HEAD
    elseif (tabType == decorate.TabType.HEAD_FRAME) then
        return decorate.ModuleType.HEAD_FRAME
    elseif (tabType == decorate.TabType.TITLE) then
        return decorate.ModuleType.TITLE
    elseif (tabType == decorate.TabType.BACKGROUND) then
        return decorate.ModuleType.BACKGROUND
    end
end

decorate.getReadTypeByModuleType = function(moduleType)
    if (moduleType == decorate.ModuleType.HEAD) then
        return ReadConst.NEW_HEAD
    elseif (moduleType == decorate.ModuleType.HEAD_FRAME) then
        return ReadConst.NEW_HEAD_FRAME
    elseif (moduleType == decorate.ModuleType.TITLE) then
        return ReadConst.NEW_TITLE
    elseif (moduleType == decorate.ModuleType.BACKGROUND) then
        return ReadConst.NEW_TITLE
    end
end

-- 头像解锁类型
decorate.HeadUnlockType = {
    -- 默认解锁
    DEFAULT_UNLICK = 0,
    -- 获得道具自动解锁
    PROPS_UNLOCK = 1,
    -- 激活战员解锁
    HERO_UNLOCK = 2,
    -- 激活时装解锁
    HERO_FASHION_UNLOCK = 3,
}

-- 头像框解锁类型
decorate.HeadFrameUnlockType = {
    -- 默认解锁
    DEFAULT_UNLICK = 0,
    -- 获得道具自动解锁
    PROPS_UNLOCK = 1,
    -- 激活战员解锁
    HERO_UNLOCK = 2,
}

-- 称号解锁类型
decorate.TitleUnlockType = {
    -- 默认解锁
    DEFAULT_UNLICK = 0,
    -- 获得道具自动解锁
    PROPS_UNLOCK = 1,
    -- 激活战员解锁
    HERO_UNLOCK = 2,
}

-- 称号解锁类型
decorate.BackGroudUnlockType = {
    -- 默认解锁
    DEFAULT_UNLICK = 0,
    -- 获得道具自动解锁
    PROPS_UNLOCK = 1,
    -- 激活战员解锁
    HERO_UNLOCK = 2,
}

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(25203):	"背景"
	语言包: _TT(25202):	"称号"
	语言包: _TT(25201):	"头像框"
	语言包: _TT(25200):	"头像"
]]