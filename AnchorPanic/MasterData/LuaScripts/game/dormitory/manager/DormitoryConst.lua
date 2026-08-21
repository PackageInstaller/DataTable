--[[
-----------------------------------------------------
@filename       : DormitoryConst
@Description    : 宿舍常量
@date           : 2021-07-22 15:52:14
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
DormitoryCost = {}

------------------------------------基础定义----------------------------------
-- 格子大小
DormitoryCost.TITE_SIZE = 0.2
-- 总列数
DormitoryCost.COL_COUNT = 50
-- 总行数
DormitoryCost.ROW_COUNT = 50
-- 高行数
DormitoryCost.HIGHT_COUNT = 15

------------------------------------类型定义----------------------------------
-- 地板
DormitoryCost.SITE_FLOOR = 1
-- 天花板
DormitoryCost.SITE_TOP = 2
-- 墙面1 前面 地面为40行
DormitoryCost.SITE_WALL_FRONT = 3
-- 墙面2 左边 地面为1列
DormitoryCost.SITE_WALL_LEFT = 4
-- 墙面3 背面 地面为1行
DormitoryCost.SITE_WALL_BACK = 5
-- 墙面4 右边 地面为40列
DormitoryCost.SITE_WALL_RIGHT = 6

DormitoryCost.SITE_WALL_LIST = {DormitoryCost.SITE_WALL_FRONT, DormitoryCost.SITE_WALL_LEFT, DormitoryCost.SITE_WALL_BACK, DormitoryCost.SITE_WALL_RIGHT}

-- 地板样式子类型
DormitoryCost.FLOOR_SUBTYPE = 7
-- 天花板样式子类型
DormitoryCost.TOP_SUBTYPE = 8
-- 墙面样式子类型
DormitoryCost.WALL_SUBTYPE = 9
-- 挂饰道具子类型
DormitoryCost.MURAL_SUBTYPE = 10

-- 默认地板道具tid
DormitoryCost.DEFAULT_FLOOR_TID = sysParam.SysParamManager:getValue(961)
-- 默认天花板道具tid
DormitoryCost.DEFAULT_TOP_TID = sysParam.SysParamManager:getValue(960)
-- 默认墙壁道具tid
DormitoryCost.DEFAULT_WALL_TID = sysParam.SysParamManager:getValue(959)

-- 给门一个客户端用的id
DormitoryCost.DOOR_CLIENT_ID = 99999

------------------------------------资源相关----------------------------------
-- 网格名列表
DormitoryCost.TILE_NAME_LIST = {"dormitory_101_tile_01_floor", "dormitory_101_tile_01_top", "dormitory_101_tile_02_front", "dormitory_101_tile_02_left", "dormitory_101_tile_02_back", "dormitory_101_tile_02_right"}
-- 家私挂点名列表
DormitoryCost.SITE_ROOT_LIST = {"floor_high", "top_high", "frontwall_high", "leftwall_high", "backwall_high", "rightwall_high"}
-- 单片网格列表
DormitoryCost.TILE_ITEM_LIST = {"dormitory_101_tile_03_floor", "dormitory_101_tile_03_top", "dormitory_101_tile_03_front", "dormitory_101_tile_03_left", "dormitory_101_tile_03_back", "dormitory_101_tile_03_right"}
-- 墙面网格片挂点列表
DormitoryCost.WALL_TILE_ROOT_LIST = {"frontwall_low", "leftwall_low", "backwall_low", "rightwall_low"}
--地面网格片挂点
DormitoryCost.FLOOR_TILE_ROOT = "floor_low"

-- 网格射线layer层名
DormitoryCost.TILE_LAYER_NAME = "Drag_floor"

-- 地板预制体挂点
DormitoryCost.ROOT_WALL_FLOOR = "wall_floor"
-- 天花板预制体挂点
DormitoryCost.ROOT_WALL_TOP = "wall_top"
-- 正面墙预制体挂点
DormitoryCost.ROOT_WALL_FRONT = "wall_front_a"
-- 背面墙预制体挂点
DormitoryCost.ROOT_WALL_BACK = "wall_back_b"
-- 左面墙预制体挂点
DormitoryCost.ROOT_WALL_LEFT = "wall_left_c"
-- 右面墙预制体挂点
DormitoryCost.ROOT_WALL_RIGHT = "wall_right_d"

DormitoryCost.ROOT_WALL_LIST = {DormitoryCost.ROOT_WALL_FRONT, DormitoryCost.ROOT_WALL_LEFT, DormitoryCost.ROOT_WALL_BACK, DormitoryCost.ROOT_WALL_RIGHT}

-- 基础地板资源预制体名
DormitoryCost.BASE_WALL_FLOOR = "dormitory_101_11_base_floor"
-- 基础天花板资源预制体名
DormitoryCost.BASE_WALL_TOP = "dormitory_101_04_base_top"
-- 基础墙面资源预制体名前缀（四面墙分别加_abcd）
DormitoryCost.BASE_WALL_WALL = "dormitory_101_03_base_wall"

-- 前方墙的门挂点
DormitoryCost.ROOT_FRONT_WALL_DOOR = "frontwall_door"
-- 后方墙的门挂点
DormitoryCost.ROOT_BACK_WALL_DOOR = "backwall_door"
-- 左方墙的门挂点
DormitoryCost.ROOT_LEFT_WALL_DOOR = "leftwall_door"
-- 右方墙的门挂点
DormitoryCost.ROOT_RIGHT_WALL_DOOR = "rightwall_door"

------------------------------------Q版人物动作----------------------------------
DormitoryCost.QWALK = "Qwalk"
DormitoryCost.QSTAND = "Qstand"
DormitoryCost.QTAB = "Qtab"
DormitoryCost.QBEDWARD_R_ING = "Qbedward_R_ing"
DormitoryCost.QBEDWARD_L_ING = "Qbedward_L_ing"
DormitoryCost.QCHAIR_ING = "Qchair_ing"
DormitoryCost.QIDLE = "Qidle"

DormitoryCost.ACT_SHOW_IDLE = gs.Animator.StringToHash("Qidle")
DormitoryCost.ACT_SHOW_STAND = gs.Animator.StringToHash("Qstand")
DormitoryCost.ACT_SHOW_NO = gs.Animator.StringToHash("Qno")
DormitoryCost.ACT_SHOW_DOWN = gs.Animator.StringToHash("Qdown")
DormitoryCost.ACT_SHOW_TAB = gs.Animator.StringToHash("Qtab")
DormitoryCost.ACT_SHOW_WALK = gs.Animator.StringToHash("Qwalk")

DormitoryCost.ACT_BEDWARD_R_DOWN = gs.Animator.StringToHash("Qbedward_R_down")
DormitoryCost.ACT_BEDWARD_R_ING = gs.Animator.StringToHash("Qbedward_R_ing")
DormitoryCost.ACT_BEDWARD_R_UP = gs.Animator.StringToHash("Qbedward_R_up")
DormitoryCost.ACT_BEDWARD_R_FELL = gs.Animator.StringToHash("Qbedward_R_fell")

DormitoryCost.ACT_BEDWARD_L_DOWN = gs.Animator.StringToHash("Qbedward_L_down")
DormitoryCost.ACT_BEDWARD_L_ING = gs.Animator.StringToHash("Qbedward_L_ing")
DormitoryCost.ACT_BEDWARD_L_UP = gs.Animator.StringToHash("Qbedward_L_up")
DormitoryCost.ACT_BEDWARD_L_FELL = gs.Animator.StringToHash("Qbedward_L_fell")

DormitoryCost.ACT_CHAIR_DOWN = gs.Animator.StringToHash("Qchair_down")
DormitoryCost.ACT_CHAIR_ING = gs.Animator.StringToHash("Qchair_ing")
DormitoryCost.ACT_CHAIR_UP = gs.Animator.StringToHash("Qchair_up")
DormitoryCost.ACT_CHAIR_FELL = gs.Animator.StringToHash("Qchair_fell")

-- 拧起来
DormitoryCost.ACT_SHOW_SHIFT = gs.Animator.StringToHash("Qshift")

--待机随机动作列表
DormitoryCost.ACT_SHOW_LIST = {DormitoryCost.ACT_SHOW_IDLE}
--所有的Q版动作
DormitoryCost.ACT_LIST =
{
    DormitoryCost.ACT_SHOW_IDLE,
    DormitoryCost.ACT_SHOW_STAND,
    DormitoryCost.ACT_SHOW_NO,
    DormitoryCost.ACT_SHOW_DOWN,
    DormitoryCost.ACT_SHOW_TAB,
    DormitoryCost.ACT_SHOW_WALK,
    DormitoryCost.ACT_CHAIR_DOWN,
    DormitoryCost.ACT_CHAIR_ING,
    DormitoryCost.ACT_CHAIR_UP,
    DormitoryCost.ACT_CHAIR_FELL,
    DormitoryCost.ACT_BEDWARD_R_DOWN,
    DormitoryCost.ACT_BEDWARD_R_ING,
    DormitoryCost.ACT_BEDWARD_R_UP,
    DormitoryCost.ACT_BEDWARD_R_FELL,
    DormitoryCost.ACT_BEDWARD_L_DOWN,
    DormitoryCost.ACT_BEDWARD_L_ING,
    DormitoryCost.ACT_BEDWARD_L_UP,
    DormitoryCost.ACT_BEDWARD_L_FELL,
    -- 拧起来
    DormitoryCost.ACT_SHOW_SHIFT,
}

--动作触发过渡条件定义
DormitoryCost.CONDITION_TO_WALK = gs.Animator.StringToHash("TO_WALK")
DormitoryCost.CONDITION_TO_STAND = gs.Animator.StringToHash("TO_STAND")
DormitoryCost.CONDITION_TO_IDLE = gs.Animator.StringToHash("TO_IDLE")

---Q版AI状态
DormitoryCost.LIVESTATE_OTHER = 1 --休闲
DormitoryCost.LIVESTATE_RUN = 2 --寻路
DormitoryCost.LIVESTATE_STAND = 3 -- 待机
DormitoryCost.LIVESTATE_INTERACT = 4 -- 交互(躺床上)
DormitoryCost.LIVESTATE_CLICK = 5 --点击动作

--AI状态
DormitoryCost.AI_WALK = 1 --散步
DormitoryCost.AI_INTERACT = 2 --跟家具互动
DormitoryCost.AI_STAND = 3 --站立发呆

--家具互动阶段
DormitoryCost.JUMP = 1 --一阶段起手  跳
DormitoryCost.LIE = 2 -- 二阶段 准备躺下
DormitoryCost.INTERACTING = 3 --三阶段(睡觉) 交互中
DormitoryCost.INTERACTEND = 4 --四阶段（下床） 交互结束

--需要加气泡的动作
DormitoryCost.NEED_BUBBLE_HASH_ARRAY =
{
    DormitoryCost.QWALK,
    DormitoryCost.QSTAND,
    DormitoryCost.QTAB,
    DormitoryCost.QBEDWARD_R_ING,
    DormitoryCost.QBEDWARD_L_ING,
    DormitoryCost.QCHAIR_ING,
    DormitoryCost.QIDLE,
}

local lateIndex = 0
-- 获取随机脚步声
DormitoryCost.getRandomFSSount = function()
    local list = {"ui_dor_FS_01.prefab", "ui_dor_FS_02.prefab", "ui_dor_FS_03.prefab", "ui_dor_FS_04.prefab"}

    local function getRandom()
        local index = math.random(1, #list)
        if lateIndex == index then
            index = getRandom()
        else
            lateIndex = index
        end
        return index
    end
    local random = getRandom()
    return list[random]
end

--全部收纳
DormitoryCost.all_Storage = function (notClear)
    local list = dormitory.DormitoryManager:getMoveInfoList()
    for i, v in ipairs(list) do
        dormitory.DormitorySceneController:storageFuniture(v.id, v.tid)
    end

    local list = dormitory.DormitoryManager:getFurnitureListByDormitory()
    if not list then
        return
    end
    for i, furnitureVo in ipairs(list) do
        local propsVo = props.PropsVo:poolGet()
        propsVo:setTid(furnitureVo.tid)
        propsVo.id = furnitureVo.id
        -- if propsVo.subType ~= DormitoryCost.FLOOR_SUBTYPE or propsVo.subType ~= DormitoryCost.TOP_SUBTYPE or propsVo.subType ~= DormitoryCost.WALL_SUBTYPE then
        -- 排除默认墙、地板、天花板
        dormitory.DormitorySceneController:storageFuniture(furnitureVo.id, furnitureVo.tid)
        -- end
    end

    dormitory.DormitoryManager:clearAllFurniture(notClear) --暂时先去除
    GameDispatcher:dispatchEvent(EventName.DORMITORY_ALL_STORAGE)
end

--[[ 替换语言包自动生成，请勿修改！
]]
