module("game.RogueLikeConst", Class.impl())

-- 当前地图行走状态
rogueLike.CurrentMapState = { Walked = 1, -- 行走过了
UnWalk = 2 -- 未行走
}

-- 预测地图行走状态
rogueLike.ForecastMapState = { CanWalk = 1, -- 可行走
NoWalk = 2 -- 不可行走
}

rogueLike.EventType = { Fight = 1, -- 战斗模块 不包含kv
BuffSelect = 2, -- buff选择 只有key

Boss = 3, --目前前端自行控制 3 类型为boss
Recover = 6, -- 恢复事件 只有key 3-4-5 value去读表
Shop = 7, -- 7 商店 kv都有
Special = 8 -- 8 特殊事件 是否是结果页面
}

rogueLike.ChildEventType = { ChildFight = 6, -- 子事件 战斗
ChildShop = 9 -- 子事件 商店
}

rogueLike.LineState = { Pass = 1, -- 已经通过的格子
NoPass = 2, -- 未通过
Last = 3 -- 最后连接
}

rogueLike.CollectionType = { All = 0, -- 全部
Attack = 1, -- 攻击
Defense = 2, -- 防御
Treet = 3, -- 治疗
Special = 4, -- 特殊
Adverse = 5 -- 负面
}

function getBuffTypeName(self, type)
    local string
    if type == rogueLike.CollectionType.Attack then
        string = _TT(56074)
    elseif type == rogueLike.CollectionType.Defense then
        string = _TT(56075)
    elseif type == rogueLike.CollectionType.Treet then
        string = _TT(56076)
    elseif type == rogueLike.CollectionType.Special then
        string = _TT(56077)
    elseif type == rogueLike.CollectionType.Adverse then
        string = _TT(56078)
    end
    return string
end
rogueLike.CollectionTypeName = { _TT(56074), _TT(56075), _TT(56076), _TT(56077), _TT(56078) }

-- 物资品质
rogueLike.BuffLevel = { All = 0, -- 全部
Green = 1, -- 绿
Blue = 2, -- 蓝
Purple = 3, -- 紫
Orange = 4 -- 橙
}

rogueLike.TaskType = { Week = 1, -- 每周
First = 2, -- 首通奖励
Challenge = 3 -- 挑战
}

function getEventColor(self, type)
    local color
    if type == 1 then
        color = "737a7dff"
    elseif type == 2 then
        color = "41bb62ff"
    elseif type == 3 then
        color = "4c8ee7ff"
    elseif type == 4 then
        color = "d53529ff"
    elseif type == 5 then
        color = "bf5bbaff"
    elseif type == 6 then
        color = "ee9034ff"
    end
    return color
end


function getCollectionList(self)
    local tab = {}
    tab[rogueLike.CollectionType.All] = { page = rogueLike.CollectionType.All, nomalLan = _TT(56073), nomalLanEn = "" }
    tab[rogueLike.CollectionType.Attack] = { page = rogueLike.CollectionType.Attack, nomalLan = _TT(56074), nomalLanEn = "" }
    tab[rogueLike.CollectionType.Defense] = { page = rogueLike.CollectionType.Defense, nomalLan = _TT(56075), nomalLanEn = "" }
    tab[rogueLike.CollectionType.Treet] = { page = rogueLike.CollectionType.Treet, nomalLan = _TT(56076), nomalLanEn = "" }
    tab[rogueLike.CollectionType.Special] = { page = rogueLike.CollectionType.Special, nomalLan = _TT(56077), nomalLanEn = "" }
    --tab[rogueLike.CollectionType.Adverse] = { page = rogueLike.CollectionType.Adverse, nomalLan = _TT(56078), nomalLanEn = "" }
    return tab
end

function getTaskList(self)
    local tab = {}
    tab[rogueLike.TaskType.Week] = { page = rogueLike.TaskType.Week, nomalLan = "每周任务", nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_31.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_31.png") }
    tab[rogueLike.TaskType.First] = { page = rogueLike.TaskType.First, nomalLan = _TT(49005), nomalLanEn = "", nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_32.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_32.png") }
    --tab[rogueLike.TaskType.Challenge] = {page = rogueLike.TaskType.Challenge, nomalLan = "挑战任务", nomalLanEn = ""}
    return tab
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(49005):	"首通奖励"
	语言包: _TT(35):	"防御"
	语言包: _TT(34):	"攻击"
	语言包: _TT(71315):	"特殊"
	语言包: _TT(35):	"防御"
	语言包: _TT(34):	"攻击"
	语言包: _TT(71315):	"特殊"
	语言包: _TT(35):	"防御"
	语言包: _TT(34):	"攻击"
]]