--------------------------------------------- 地图布局类型定义 ---------------------------------------------
maze.LAYOUT_VERTICAL = "VERTICAL" -- ⬡⬢
maze.LAYOUT_HORIZONTAL = "HORIZONTAL" -- ⎔⬣

--------------------------------------------- 层级定义 ---------------------------------------------
-- 根节点层
maze.LAYER_ROOT = "LAYER_ROOT"
-- ray检测层通用
maze.LAYER_RAY_NORMAL = "LAYER_RAY_NORMAL"
-- ray检测层拖拽专用
maze.LAYER_RAY_DRAG = "LAYER_RAY_DRAG"
-- 相机层
maze.LAYER_CAMERA = "LAYER_CAMERA"
-- 动态缩放层
maze.LAYER_DYNAMIC_SCALE = "LAYER_DYNAMIC_SCALE"
-- 静态缩放层
maze.LAYER_STATIC_SCLAE = "LAYER_STATIC_SCLAE"
-- 格子层
maze.LAYER_TILE = "LAYER_TILE"
-- 选中层
maze.LAYER_SELECTION = "LAYER_SELECTION"
-- 物件层
maze.LAYER_THING = "LAYER_THING"
-- 玩家角色层
maze.LAYER_PLAYER = "LAYER_PLAYER"
-- 迷雾灯光层
maze.LAYER_FOG_LIGHT = "LAYER_FOG_LIGHT"

maze.getPrefabUrl = function(prefabUrl)
    -- return string.format("arts/sceneModule/maze/prefab/%s", prefabUrl)
    return prefabUrl
end

maze.getEffectUrl = function(prefabUrl)
    return string.format("arts/fx/3d/sceneModule/maze/%s", prefabUrl)
end

--------------------------------------------- 物体类型定义 ---------------------------------------------
maze.THING_TYPE_TILE = "THING_TYPE_TILE"
maze.THING_TYPE_EVENT = "THING_TYPE_EVENT"
maze.THING_TYPE_PLAYER = "THING_TYPE_PLAYER"

--------------------------------------------- 事件类型定义 ---------------------------------------------
-- 地板
maze.EVENT_TYPE_FLOOR = 1
-- 对话地板
maze.EVENT_TYPE_FLOOR_TALK = 101
-- 塌陷地板
maze.EVENT_TYPE_FLOOR_TALK_DEL = 102
-- 镜像地板
maze.EVENT_TYPE_FLOOR_TALK_ADD = 103
-- 怪物地板
maze.EVENT_TYPE_FLOOR_MONSTER_ADD = 104

-- 障碍物
maze.THING_TYPE_OBSTACLE = 1001
-- 钢铁障碍物（不可被大炮摧毁）
maze.THING_TYPE_OBSTACLE_STEEL = 1002
-- 篝火障碍物
maze.THING_TYPE_OBSTACLE_BONFIRE = 1501
-- 坚冰障碍物
maze.THING_TYPE_OBSTACLE_ICE = 1502
-- 高温障碍物
maze.THING_TYPE_OBSTACLE_FIRE = 1503
-- 木桶障碍物
maze.THING_TYPE_OBSTACLE_BARREL = 1504

-- 普通怪物
maze.THING_TYPE_NORMAL_DUP = 2001
-- 首领怪物
maze.THING_TYPE_BOSS_DUP = 2002

-- 雇佣兵
maze.THING_TYPE_ADD_SOLDIER = 3001
-- 传送门
maze.THING_TYPE_SEND_DOOR = 3002
-- 历史文献
maze.THING_TYPE_HISTORY_BOOK = 3003
-- 障碍物消除机关
maze.THING_TYPE_REMOVE_OBSTACLE = 3004
-- 营地
maze.THING_TYPE_CAMP = 3005
-- 急救所
maze.THING_TYPE_HOSPITAL = 3006
-- 物资箱子
maze.THING_TYPE_GOODS_BOX = 3007
-- 陷阱：职业 扣血 百分比
maze.THING_TYPE_TRAP_DEL_HP = 3008
-- 陷阱移除
maze.THING_TYPE_TRAP_REMOVE = 3010

-- 特殊障碍物
maze.THING_TYPE_OBSTACLE_SPECIAL = 3011
-- （开）障碍物
maze.THING_TYPE_OBSTACLE_OPEN = 3012
-- （关）障碍物
maze.THING_TYPE_OBSTACLE_CLOSE = 3013
-- 开关状态障碍物的触发机关
maze.THING_TYPE_OBSTACLE_SWITCHER = 3014
-- NPC
maze.THING_TYPE_NPC = 3015
-- 能量传输台
maze.THING_TYPE_ENERGY = 3016
-- 机关地板
maze.THING_TYPE_SWITCHER_FLOOR = 3017
-- 对话奖励
maze.THING_TYPE_TALK_AWARD = 3018
-- 火焰装置
maze.THING_TYPE_DEVICE_FIRE = 3019
-- 灭火装置
maze.THING_TYPE_DEVICE_OUTFIRE = 3020
-- 友军工程师
maze.THING_TYPE_FRIENDLY = 3021

-- 寒冰炸弹
maze.THING_TYPE_BOMB_ICE = 3022
-- 火焰炸弹
maze.THING_TYPE_BOMB_FIRE = 3023

-- 跃迁器
maze.THING_TYPE_DEVICE_JUMP = 3024
-- 跃迁器生成配置
maze.THING_TYPE_DEVICE_JUMP_CREATE = 3025
-- 大炮
maze.THING_TYPE_CANNON = 3026
-- 大炮（未激活）
maze.THING_TYPE_CANNON_UNABLE = 3027
-- 传输装置
maze.THING_TYPE_DEVICE_TRANSMIT = 3028

-- 旋转阀门
maze.THING_TYPE_ROTARY_SWITCH = 3029
-- 电路终点
maze.THING_TYPE_FINISH_POINT = 3030
-- 旋转一线电缆
maze.THING_TYPE_ROTARY_CABLE_ONE = 3031
-- 旋转二线电缆
maze.THING_TYPE_ROTARY_CABLE_TWO = 3032
-- 旋转三线电缆
maze.THING_TYPE_ROTARY_CABLE_THREE = 3033
-- 不可旋转一线电缆
maze.THING_TYPE_NOT_ROTARY_CABLE_ONE = 3034
-- 不可旋转二线电缆
maze.THING_TYPE_NOT_ROTARY_CABLE_TWO = 3035
-- 不可旋转三线电缆
maze.THING_TYPE_NOT_ROTARY_CABLE_THREE = 3036

--冰面事件
maze.EVENT_TYPE_ICE = 3037

--一笔画事件地板
maze.EVENT_TYPE_ONECALL_TILE = 3038
--一笔画目标机关
maze.EVENT_TYPE_ONECALL_DOOR = 3039
--特殊传送门事件(用于特殊传送位置)
maze.EVENT_TYPE_SEND_DOOR = 3040
--一笔画冰面事件
maze.EVENT_TYPE_ICE_AND_ONECALL = 3041
--一笔画传送门
maze.EVENT_TYPE_SEND_DOOR_ONECALL = 3042
--旋转一笔画门事件
maze.EVENT_TYPE_ROTARY_SEND_DOOR_ONECALL = 3043
--矢量方向传送门
maze.EVENT_TYPE_SEND_DOOR_DIR = 3044


-- 普通物资箱子
maze.THING_TYPE_NORMAL_BOX = 4001
-- 华丽物资箱子
maze.THING_TYPE_GORGEOUS_BOX = 4002
-- 散落的金币
maze.THING_TYPE_DROP_GOIN = 4003

maze.getEventName = function(eventType)
    if(eventType == maze.EVENT_TYPE_FLOOR)then
        return "地板"
    elseif(eventType == maze.EVENT_TYPE_FLOOR_TALK)then
        return "对话地板"
    elseif(eventType == maze.EVENT_TYPE_FLOOR_TALK_DEL)then
        return "塌陷地板"
    elseif(eventType == maze.EVENT_TYPE_FLOOR_TALK_ADD)then
        return "镜像地板"
    elseif(eventType == maze.EVENT_TYPE_FLOOR_MONSTER_ADD)then
        return "怪物地板"
    elseif(eventType == maze.THING_TYPE_OBSTACLE)then
        return "障碍物"
    elseif(eventType == maze.THING_TYPE_OBSTACLE_STEEL)then
        return "钢铁障碍物"
    elseif(eventType == maze.THING_TYPE_OBSTACLE_ICE)then
        return "坚冰障碍物"
    elseif(eventType == maze.THING_TYPE_OBSTACLE_FIRE)then
        return "高温障碍物"
    elseif(eventType == maze.THING_TYPE_OBSTACLE_BARREL)then
        return "木桶障碍物"
    elseif(eventType == maze.THING_TYPE_NORMAL_DUP)then
        return _TT(46001)
    elseif(eventType == maze.THING_TYPE_BOSS_DUP)then
        return _TT(46002)
    elseif(eventType == maze.THING_TYPE_ADD_SOLDIER)then
        return "雇佣兵"
    elseif(eventType == maze.THING_TYPE_SEND_DOOR)then
        return "传送门"
    elseif(eventType == maze.THING_TYPE_HISTORY_BOOK)then
        return _TT(46004)
    elseif(eventType == maze.THING_TYPE_REMOVE_OBSTACLE)then
        return _TT(46005)
    elseif(eventType == maze.THING_TYPE_CAMP)then
        return "营地"
    elseif(eventType == maze.THING_TYPE_HOSPITAL)then
        return _TT(46007)
    elseif(eventType == maze.THING_TYPE_GOODS_BOX)then
        return _TT(46008)
    elseif(eventType == maze.THING_TYPE_TRAP_DEL_HP)then
        return "陷阱：职业 扣血 百分比"
    elseif(eventType == maze.THING_TYPE_TRAP_REMOVE)then
        return "陷阱移除"
    elseif(eventType == maze.THING_TYPE_OBSTACLE_SPECIAL)then
        return "特殊障碍物"
    elseif(eventType == maze.THING_TYPE_OBSTACLE_OPEN)then
        return "（开）障碍物"
    elseif(eventType == maze.THING_TYPE_OBSTACLE_CLOSE)then
        return "（关）障碍物"
    elseif(eventType == maze.THING_TYPE_OBSTACLE_SWITCHER)then
        return "开关状态障碍物的触发机关"
    elseif(eventType == maze.THING_TYPE_NPC)then
        return "NPC"
    elseif(eventType == maze.THING_TYPE_ENERGY)then
        return _TT(46016)
    elseif(eventType == maze.THING_TYPE_SWITCHER_FLOOR)then
        return "机关地板"
    elseif(eventType == maze.THING_TYPE_TALK_AWARD)then
        return "对话事件"
    elseif(eventType == maze.THING_TYPE_DEVICE_FIRE)then
        return "火焰装置"
    elseif(eventType == maze.THING_TYPE_DEVICE_OUTFIRE)then
        return _TT(46018)
    elseif(eventType == maze.THING_TYPE_FRIENDLY)then
        return "友军工程师"
    elseif(eventType == maze.THING_TYPE_BOMB_ICE)then
        return _TT(46020)
    elseif(eventType == maze.THING_TYPE_BOMB_FIRE)then
        return _TT(46021)
    elseif(eventType == maze.THING_TYPE_DEVICE_JUMP)then
        return "跃迁器"
    elseif(eventType == maze.THING_TYPE_DEVICE_JUMP_CREATE)then
        return "跃迁器生成配置"
    elseif(eventType == maze.THING_TYPE_CANNON)then
        return _TT(46023)
    elseif(eventType == maze.THING_TYPE_CANNON_UNABLE)then
        return "大炮（未激活）"
    elseif(eventType == maze.THING_TYPE_DEVICE_TRANSMIT)then
        return "传输装置"
    elseif(eventType == maze.THING_TYPE_ROTARY_SWITCH)then
        return "旋转阀门"
    elseif(eventType == maze.THING_TYPE_FINISH_POINT)then
        return "电路终点"
    elseif(eventType == maze.THING_TYPE_ROTARY_CABLE_ONE)then
        return "旋转一线电缆"
    elseif(eventType == maze.THING_TYPE_ROTARY_CABLE_TWO)then
        return "旋转二线电缆"
    elseif(eventType == maze.THING_TYPE_ROTARY_CABLE_THREE)then
        return "旋转三线电缆"
    elseif(eventType == maze.THING_TYPE_NOT_ROTARY_CABLE_ONE)then
        return "不可旋转一线电缆"
    elseif(eventType == maze.THING_TYPE_NOT_ROTARY_CABLE_TWO)then
        return "不可旋转二线电缆"
    elseif(eventType == maze.THING_TYPE_NOT_ROTARY_CABLE_THREE)then
        return "不可旋转三线电缆"
    elseif(eventType == maze.THING_TYPE_NORMAL_BOX)then
        return "普通宝箱"
    elseif(eventType == maze.THING_TYPE_GORGEOUS_BOX)then
        return "华丽宝箱"
    elseif(eventType == maze.THING_TYPE_DROP_GOIN)then
        return "散落金币"
    elseif(eventType == maze.EVENT_TYPE_ICE)then
        return "冰面事件"
    elseif(eventType == maze.EVENT_TYPE_ONECALL_TILE)then
        return "一笔画地板事件"
    elseif(eventType == maze.EVENT_TYPE_ONECALL_DOOR)then
        return "一笔画机关事件"
    elseif(eventType == maze.EVENT_TYPE_SEND_DOOR)then
        return "特殊传送门"
    elseif(eventType == maze.EVENT_TYPE_ICE_AND_ONECALL)then
        return "一笔画冰面事件"
    elseif(eventType == maze.EVENT_TYPE_SEND_DOOR_ONECALL)then
        return "一笔画传送门事件"
    elseif(eventType == maze.EVENT_TYPE_ROTARY_SEND_DOOR_ONECALL)then
        return "旋转一笔画门事件"
    elseif(eventType == maze.EVENT_TYPE_SEND_DOOR_DIR)then
        return "矢量方向传送门"
    else
        return "未定义"
    end
end

--------------------------------------------- 物件模型动作 ---------------------------------------------
maze.ACT_STR_TRIGGER_BEFORE = "before"
maze.ACT_STR_TRIGGER_AFTER = "after"
maze.ACT_STR_TRIGGER_1 = "trigger01"
maze.ACT_STR_TRIGGER_2 = "trigger02"
maze.ACT_STR_TRIGGER_3 = "trigger03"
maze.ACT_STR_TRIGGER_4 = "trigger04"
maze.ACT_TRIGGER_BEFORE = gs.Animator.StringToHash(maze.ACT_STR_TRIGGER_BEFORE)
maze.ACT_TRIGGER_AFTER = gs.Animator.StringToHash(maze.ACT_STR_TRIGGER_AFTER)
maze.ACT_TRIGGER_1 = gs.Animator.StringToHash(maze.ACT_STR_TRIGGER_1)
maze.ACT_TRIGGER_2 = gs.Animator.StringToHash(maze.ACT_STR_TRIGGER_2)
maze.ACT_TRIGGER_3 = gs.Animator.StringToHash(maze.ACT_STR_TRIGGER_3)
maze.ACT_TRIGGER_4 = gs.Animator.StringToHash(maze.ACT_STR_TRIGGER_4)
maze.ACT_TRIGGER_LIST = { maze.ACT_TRIGGER_BEFORE, maze.ACT_TRIGGER_AFTER, maze.ACT_TRIGGER_1, maze.ACT_TRIGGER_2, maze.ACT_TRIGGER_3, maze.ACT_TRIGGER_4 }
--------------------------------------------- 物体动画状态类型（和配置表定义一致，后端发来） ---------------------------------------------
--- 触发之前的动画状态类型
maze.ACT_TYPE_TRIGGER_BEFORE = 0
--- 触发后的动画状态类型
maze.ACT_TYPE_TRIGGER_AFTER = 1
--- 触发1的动画状态类型
maze.ACT_TYPE_TRIGGER_1 = 2
--- 触发2的动画状态类型
maze.ACT_TYPE_TRIGGER_2 = 3
--------------------------------------------- 根据物体动画状态类型获取动作 ---------------------------------------------
maze.getActHashByState = function(state)
    local actHash = maze.ACT_TRIGGER_BEFORE
    if (state == maze.ACT_TYPE_TRIGGER_BEFORE) then
        actHash = maze.ACT_TRIGGER_BEFORE
    elseif (state == maze.ACT_TYPE_TRIGGER_AFTER) then
        actHash = maze.ACT_TRIGGER_AFTER
    elseif (state == maze.ACT_TYPE_TRIGGER_1) then
        actHash = maze.ACT_TRIGGER_1
    elseif (state == maze.ACT_TYPE_TRIGGER_2) then
        actHash = maze.ACT_TRIGGER_2
    elseif (state == maze.ACT_TYPE_TRIGGER_3) then
        actHash = maze.ACT_TRIGGER_3
    elseif (state == maze.ACT_TYPE_TRIGGER_4) then
        actHash = maze.ACT_TRIGGER_4
    end
    return actHash
end

--------------------------------------------- 根据类型获取对象 ---------------------------------------------
maze.getEventThingVo = function(type)
    if (not maze.IS_INIT_THINGVO) then
        maze.IS_INIT_THINGVO = true
        maze.MazeBaseEventThingVo = require("game/maze/manager/vo/thingVo/MazeBaseEventThingVo")
        maze.MazeTileThingVo = require("game/maze/manager/vo/thingVo/MazeTileThingVo")
        maze.MazeEventThingVo = require("game/maze/manager/vo/thingVo/MazeEventThingVo")
        maze.MazePlayerThingVo = require("game/maze/manager/vo/thingVo/MazePlayerThingVo")
    end
    local thingVo = nil
    if (type == maze.THING_TYPE_TILE) then
        thingVo = maze.MazeTileThingVo
    elseif (type == maze.THING_TYPE_EVENT) then
        thingVo = maze.MazeEventThingVo
    elseif (type == maze.THING_TYPE_PLAYER) then
        thingVo = maze.MazePlayerThingVo
    end
    return LuaPoolMgr:poolGet(thingVo)
end

maze.getEventThing = function(type)
    if (not maze.IS_INIT_THING) then
        maze.IS_INIT_THING = true
        maze.MazeBaseEventThing = require("game/maze/view/thing/MazeBaseEventThing")
        maze.MazeTileThing = require("game/maze/view/thing/MazeTileThing")
        maze.MazeEventThing = require("game/maze/view/thing/MazeEventThing")
        maze.MazePlayerThing = require("game/maze/view/thing/MazePlayerThing")
    end
    local thing = nil
    if (type == maze.THING_TYPE_TILE) then
        thing = maze.MazeTileThing
    elseif (type == maze.THING_TYPE_EVENT) then
        thing = maze.MazeEventThing
    elseif (type == maze.THING_TYPE_PLAYER) then
        thing = maze.MazePlayerThing
    end
    return LuaPoolMgr:poolGet(thing)
end

-- 迷宫英雄来源类型（和后端一致）
maze.HERO_SOURCE_TYPE = {
    -- 玩家自己的英雄
    OWN = 1,
    -- 外援英雄
    SUPPORT = 2,
    -- 敌人
    ENEMY = 3
}

-- 获取迷宫玩家的当前英雄
maze.getPlayerHeroTid = function()
    return sysParam.SysParamManager:getValue(SysParamType.MAZE_MODEL_TID)
end

-- 根据要移动的格子数获取迷宫玩家的当前英雄速度
maze.getPlayerHeroRate = function(pathCount)
    local speed = 1
    if(pathCount <= 3)then
        speed = sysParam.SysParamManager:getValue(SysParamType.MAZE_PLAYER_SPEED_RATE_3, 1)
    elseif(pathCount <= 7)then
        speed = sysParam.SysParamManager:getValue(SysParamType.MAZE_PLAYER_SPEED_RATE_7, 1)
    else
        speed = sysParam.SysParamManager:getValue(SysParamType.MAZE_PLAYER_SPEED_RATE_8, 1)
    end
    return speed / 100
end

-- 触发状态
maze.TriggerState = {
    -- 无
    NONE = 0,
    -- UI显示
    UI_VISIBLE_ENABLE = 1,
}

-- ⎔⬣
-- ⬡⬢
--   6  1
-- 5      2
--   4  3
-- 根据方向列表获取角度列表
maze.getRotationByDirection = function(dir)
    return 60 * (dir - 1) + 30
end

-- 根据标准的 0度的方向列表 和 n度的方向列表，获取n度
maze.getRotationByDirectionList = function(eventId, zeroAngleDirList, nAngleDirList)
    if(zeroAngleDirList and nAngleDirList)then
        local zeroDirCount = #zeroAngleDirList
        local nDirCount = #nAngleDirList
        if(zeroDirCount ~= nDirCount)then
            Debug:log_error("MazeConst", "0度的方向列表 和 n度的方向列表 的长度不一致，有问题")
            return 0
        else
            if(zeroDirCount == 0)then
                return 0
            else
                local firstZeroAngleDir = zeroAngleDirList[1]
                local firstNAngleDir = nAngleDirList[1]
                return (firstNAngleDir - firstZeroAngleDir) * 60
            end
        end
    else
        return 0
    end
end

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(46023):	"大炮"
	语言包: _TT(46021):	"火焰炸弹"
	语言包: _TT(46020):	"寒冰炸弹"
	语言包: _TT(46018):	"灭火装置"
	语言包: _TT(46016):	"能量传输台"
	语言包: _TT(46008):	"物资箱"
	语言包: _TT(46007):	"急救所"
	语言包: _TT(46005):	"障碍物消除机关"
	语言包: _TT(46004):	"历史文献"
	语言包: _TT(46002):	"首领怪物"
	语言包: _TT(46001):	"普通怪物"
]]
