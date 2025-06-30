-- 事影循回步骤
CYCLE_STEP = {
    -- 选择难度
    SELECT_DIFFICULT = 0,

    -- 选择BUFF
    SELECT_BUFF = 1,
    -- 选择招募组合
    SELECT_COMBO = 2,
    -- 招募卷选择
    SELECT_TICKET = 3,
    -- 招募战员
    SELECT_RECRUIT = 4,
    -- 全部完成
    FINISH = 5,

    -- 正式进入了地图
    ENTER_MAP = 6
}

-- 事件类型
EVENT_TYPE = {
    -- 战斗                         {副本id,权重}
    FIGHT = 1,

    -- 恢复x点理智
    GET_REASON = 4,
    -- 获取x点玩法币
    GET_COIN = 5,
    -- 获得x点希望
    GET_HOPE = 6,
    -- 获得x点理智上限
    GET_REASON_MAX = 7,

    -- 随机获得x个收藏品
    DANDOM_COLLAGE = 8,

    -- 什么也没有获得
    NONE = 9,

    -- 退出选项 并额外增加或减少x点理智  ±理智值
    EXIT = 10,

    -- 随机一个招募卷                {招募卷1,权重}，{招募卷2,权重}
    RANDOM_RECRUIT = 12,

    -- 转化                            事件id
    COVENANT = 13,

    -- 获得一个x分类收藏品               分类id（1.攻击，2.防御，3.特殊）
    GET_TYPE_COLLAGE = 14,

    -- 返回之前的事件                    事件id
    RETURN = 50,

    -- 获得x点玩法币 返回之前的事件        获得玩法币，返回的事件id
    GET_COIN_RETURN = 52,
    -- 获得x点理智 返回之前的事件          恢复的理智，返回的事件id
    GET_HOPE_RETURN = 53,

    -- 获得一个特定收藏品            收藏品id
    GET_COLLAGE = 100,
    -- 消耗x玩法币 获得x类型收藏品       玩法币，buff类型id（1.正向，2.负面）
    CON_COIN_GET_COLLAGE = 101,

    -- 消耗x玩法币 随机获得一个战员    玩法币，{招募卷1,权重}，{招募卷2,权重}...
    CON_COIN_GET_RECRUIT = 102,

    -- 随机获得一个x分类的收藏品         {分类id,权重}，{分类id,权重}
    RANDOM_TYPE_COLLAGE = 103,

    -- 获得一个任意的收藏品              buff类型id（1.正向，2.负面）
    GET_ANY_COLLAGE = 104,

    -- 获得一个任意的收藏品 返回之前的事件 buff类型id（1.正向，2.负面）,返回的事件id
    RANDOM_ANY_COLLAGE_RETURN = 105,

    -----------===========================================特殊处理的===========================================-----------
    -- 商店
    SHOP = 1003,
    -- 分支事件1  选项1事件id，选项2事件id...    
    OPTION = 10001,
    -- 分支事件2  事件数，{事件1，权重}，{事件2，权重}…
    OPTIONS = 10002,

    -- 赌场（消耗x个玩法币随机抽取其中一个事件）  所需玩法币，{事件1，权重}，{事件2，权重}…
    CASINO = 100001,
    -- 赌徒（从左往右依次触发的事件              事件1,事件2
    GAMBLER = 100002,
    -- 赌徒子事件
    GAMBLER_CHILD = 100003
}

-- 战后类型
POSTWAR_TYPE = {
    QUIT = 0, -- 离开

    RECUIT = 1, -- 招募

    COLLAGE = 2, -- 收藏品

    CON = 3 -- 货币

}

-- 招募类型
RECUIT_TYPE = {
    STEP = 0, -- 初始战员选择

    POSTWAR = 1, -- 战后选择 

    EVENT = 2, -- 事件选择

    SHOP = 3 -- 商店
}

COLLECTION_TYPE = {
    ALL = 0, -- 全部
    -- NONE = 0, -- 不分类
    -- ATTACK = 1, -- 攻击
    -- DEFENSE = 2, -- 生存
    -- SPECIAL = 3 -- 特殊
    POSSESS = 1, --已拥有的
    LACK = 2  --不用有的
}

GOODS_TYPE = {
    BUFF = 1, -- 收藏品,
    TICKET = 2, -- 招募战员

    INVEST = 3 -- 投资商店
}

cycle.getCollectionTypeName = function(type)
    local string
    if type == COLLECTION_TYPE.NONE then
        string = _TT(27601)
    elseif type == COLLECTION_TYPE.ALL then
        string = _TT(27602)
    elseif type == COLLECTION_TYPE.POSSESS then
        string = _TT(27603)
        --string = _TT(56074)
    elseif type == COLLECTION_TYPE.LACK then
        string = _TT(27604)
        -- string = _TT(56075)
        -- elseif type == COLLECTION_TYPE.SPECIAL then
        --     string = _TT(56077)
    end
    return string
end

cycle.getCollectionTypeList = function()
    local tab = {}
    tab[COLLECTION_TYPE.ALL] = { page = COLLECTION_TYPE.ALL, nomalLan = _TT(56073), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_46.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_46.png") }
    tab[COLLECTION_TYPE.POSSESS] = { page = COLLECTION_TYPE.POSSESS, nomalLan = _TT(27603), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_47.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_47.png") }
    tab[COLLECTION_TYPE.LACK] = { page = COLLECTION_TYPE.LACK, nomalLan = _TT(27604), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_45.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_45.png") }
    return tab
end

COST_TYPE = {
    NO_COIN = -1, -- 没有货币
    NO_TIMER = -2, -- 没有次数
    NO_REASON = -3, -- 理智值不够

    NO_REASON_LIMIT = -4, --理智值上限不够
}


OPEN_DEF_TYPE = {
    SHOP = 1, --商店
    INVESTALL = 2, --投资商店
}

cycle.getEventTypeName = function(eventId)
    local name = ""
    if eventId == EVENT_TYPE.FIGHT then
        name = _TT(27501)
    elseif eventId == EVENT_TYPE.GET_COLLAGE then
        name = _TT(27502)
    elseif eventId == EVENT_TYPE.RANDOM_RECRUIT then
        name = _TT(27503)
    elseif eventId == EVENT_TYPE.GET_REASON then
        name = "恢复x点理智"
    elseif eventId == EVENT_TYPE.GET_COIN then
        name = "获取x点玩法币"
    elseif eventId == EVENT_TYPE.GET_HOPE then
        name = "获得x点希望"
    elseif eventId == EVENT_TYPE.GET_REASON_MAX then
        name = "获得x点理智上限"
    elseif eventId == EVENT_TYPE.DANDOM_COLLAGE then
        name = "随机获得x个收藏品"
    elseif eventId == EVENT_TYPE.NONE then
        name = _TT(27509)
    elseif eventId == EVENT_TYPE.EXIT then
        name = _TT(27510)
    elseif eventId == EVENT_TYPE.CON_COIN_GET_COLLAGE then
        name = "消耗x玩法币 获得x类型收藏品"
    elseif eventId == EVENT_TYPE.CON_COIN_GET_RECRUIT then
        name = "消耗x玩法币 随机获得一个战员"
    elseif eventId == EVENT_TYPE.COVENANT then
        name = _TT(27513)
    elseif eventId == EVENT_TYPE.GET_TYPE_COLLAGE then
        name = "获得一个x分类收藏品"
    elseif eventId == EVENT_TYPE.RANDOM_TYPE_COLLAGE then
        name = "随机获得一个x分类的收藏品 "
    elseif eventId == EVENT_TYPE.GET_ANY_COLLAGE then
        name = _TT(27516)
    elseif eventId == EVENT_TYPE.RETURN then
        name = _TT(27517)
    elseif eventId == EVENT_TYPE.RANDOM_ANY_COLLAGE_RETURN then
        name =        _TT(27518)
    elseif eventId == EVENT_TYPE.GET_COIN_RETURN then
        name = "获得x点玩法币 返回之前的事件"
    elseif eventId == EVENT_TYPE.GET_HOPE_RETURN then
        name = "获得x点理智 返回之前的事件 "
    elseif eventId == EVENT_TYPE.CASINO then
        name = _TT(27521)
    elseif eventId == EVENT_TYPE.GAMBLER then
        name = _TT(27522)
    elseif eventId == EVENT_TYPE.SHOP then
        name = _TT(27523)
    elseif eventId == EVENT_TYPE.OPTION then
        name = _TT(27524)
    elseif eventId == EVENT_TYPE.OPTIONS then
        name = _TT(27525)
    end
    return name
end

cycleEvent = {
    ON_EVENT_ITEM_CLICKED = "ON_EVENT_ITEM_CLICKED"
}

TOP_SHOW_TYPE = {
    LV = 1,--等级 
    REASON = 2,--理智 

    COIN = 3,--玩法币
    HOPE = 4,--希望值 

    BUFFLIST = 11,--收藏品 
    FORMATION = 12,--阵型

    CANCLE_RECRUIT = 21,--取消招募

    RET_MAIN = 31,--退出按钮

    TOPBAR = 41,--顶部
    BOTBAR = 42,--下部
}
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27604):	"未收集"
	语言包: _TT(27603):	"已收集"
	语言包: _TT(27604):	"未收集"
	语言包: _TT(27603):	"已收集"
	语言包: _TT(27602):	"全部"
	语言包: _TT(27601):	"无"
	语言包: _TT(27525):	"分支事件2"
	语言包: _TT(27524):	"分支事件1"
	语言包: _TT(27523):	"商店"
	语言包: _TT(27522):	"赌徒（从左往右依次触发的事件)"
	语言包: _TT(27521):	"赌场（消耗x个玩法币随机抽取其中一个事件）"
	语言包: _TT(27518):	"获得一个任意的收藏品 返回之前的事件 buff类型id（1.正向，2.负面）,返回的事件id"
	语言包: _TT(27517):	"返回之前的事件"
	语言包: _TT(27516):	"获得一个任意的收藏品"
	语言包: _TT(27513):	"转化"
	语言包: _TT(27510):	"退出选项 并额外增加或减少x点理智  ±理智值"
	语言包: _TT(27509):	"什么也没有获得"
	语言包: _TT(27503):	"随机一个招募卷"
	语言包: _TT(27502):	"获得一个特定收藏品"
	语言包: _TT(27501):	"战斗"
]]
