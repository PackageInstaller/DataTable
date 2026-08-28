---@class ParkourGameUtil
local ParkourGameUtil = {}
-- 外部访问时
-- local ParkourGameUtil = import("Game.Activity.ParkourGame.ParkourGameUtil")



--- lua:
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程


local Object = CS.UnityEngine.Object
local GameObject = CS.UnityEngine.GameObject
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local SphereCollider = CS.UnityEngine.SphereCollider
local CapsuleCollider = CS.UnityEngine.CapsuleCollider
local KTool = CS.Engine.Lib.KTool
local Physics = CS.UnityEngine.Physics
local LayerMask = CS.UnityEngine.LayerMask

local URPCameraController = CS.Game.Native.URP.URPCameraController
local CinemachineBrain = CS.Cinemachine.CinemachineBrain
local CinemachineBlendDefinition = CS.Cinemachine.CinemachineBlendDefinition
local Camera = CS.UnityEngine.Camera
local Random = CS.UnityEngine.Random

-- =============================================

-- 加载时, 等待多少帧就停止等待:
ParkourGameUtil.loadWaitFrames = 5000


ParkourGameUtil.InteractionTrackWidth = 16



ParkourGameUtil.SuspendDialogMode = 
{
    SuspendPanel = 1, -- 三按钮     面板
    PCTipsPanel  = 2, -- pc按键提示 面板
    GamePlayDesc = 3, -- 玩法说明   面板
}



ParkourGameUtil.ShieldState = 
{
    Closed = -1, -- 彻底关闭
    Closing = 0, -- 正在关闭, 但还没关闭
    Open = 1,    -- 开启
}


---@alias ParkourGameUtil.GameType integer @ 游戏类型
ParkourGameUtil.GameType = 
{
    Normal   = 1, -- 普通模式玩法
    Infinite = 2, -- 无尽模式玩法
}


---@alias ParkourGameUtil.LevelType integer @ 每一关的类型
ParkourGameUtil.LevelType = 
{
    Parkour = 0,-- 跑酷
    Story = 1,   -- 纯剧情
    Battle = 2, -- 纯战斗, 战斗+剧情
    -- todo: 战斗+剧情 也许要被拆分
}


---@alias ParkourGameUtil.BossShowState integer @ 怪物 展示状态
ParkourGameUtil.BossShowState = 
{
    NotStart = 0,   -- 未开始
    CountDown = 1,  -- 倒计时
    Show = 2        -- 出现
}


---@alias ParkourGameUtil.BossState integer @ 怪物状态
ParkourGameUtil.BossState = 
{
    Hide = 1,
    Idle = 2,
    Skill1 = 3,
    Skill2 = 4,
    OnHit = 5,
    Death = 6, -- todo: 要不要这个状态 ?
}


---@alias ParkourGameUtil.TrackItemType integer @ 轨迹道具类型
ParkourGameUtil.TrackItemType = {
    Default = 0,
    Ground = 1,
    SpikeTrap = 2,
    MovingTrap = 3,
    BulletRock = 4,
    BulletFeather = 5,
    --大于100的是道具,方便分类处理
    Coin = 101, 
    ShieldItem = 102,
    MagnetItem = 103,
    InvincibleDashItem = 104,
    Watch = 105,
    InvisibleSpot = 106, -- 隐身孢子
    Mirror = 107, 
}


---@alias ParkourGameUtil.BuffType integer @ buff类型
ParkourGameUtil.BuffType = {
    Shield = 1,
    Invincible = 2,
    --DoubleCoin = 3,
}


---@alias ParkourGameUtil.PlayerState integer @ 玩家状态
ParkourGameUtil.PlayerState = {
    Idle = 0,
    Run = 1,
    Jump = 2,
    Jump2 = 3,
    Falling = 4,
    Slide = 5,
    InvincibleDash = 6,
    OnHit = 7,   -- !!! 不该放这里...
    Win = 8,
    Dead = 9,
}







--有的数据来源于配置表,有的是编辑器.  策划需求一直在变.   这里统一转接一下
ParkourGameUtil.Params = {
    InvincibleDashTime = 2,
    InvincibleDashSpeedRatio = 2,
    BossCountDownDelayTime = 3, --吃到增加boss时间的道具后,增加多少boss倒计时
    MagnetRange = 6,
    MagnetTime = 6,
    CatData = {
        NormalLevelHp = 4,
        FreeLevelHp = 5,
    },
    BossData = {
        Hp = 2,
        FirstAttckType = 1,--入场攻击类型
        AttackCD = 5,
        AppearCD = 10,
    }
}


---@alias ParkourGameUtil.Events string @ 事件名字
ParkourGameUtil.Events = {
    RoleDead = "PartourGame_RoleDead",
    GameStart = "PartourGame_GameStart",
    PlayerOnHit = "PartourGame_PlayerOnHit",
    PlayerTakeDamage = "PartourGame_PlayerTakeDamage",
    BossTakeDamage = "PartourGame_BossTakeDamage",
    BossCountDownStart = "PartourGame_BossCountDownStart",
    BossCountDownPause = "PartourGame_BossCountDownPause",
    BossCome = "PartourGame_BossCome",
    BossLeave = "PartourGame_BossLeave",
    GameSuccessShowPanel = "PartourGame_GameSuccessShowPanel", -- 游戏胜利的一瞬间, 要先显示 "抵挡终点" 面板
    GameSuccess = "PartourGame_GameSuccess",
    AddSkillEnergy = "PartourGame_AddSkillEnergy",
    UseSkill = "PartourGame_UseSkill",
    
    SelectLevelDraging = "PartourGame_SelectLevelDraging" , -- 选关界面, 左右拖动屏幕

    SelectUIInitDone = "SelectUIInitDone", -- 选关UI界面 OverseaParkourMainlineDialog:OnInitialize() 执行完毕
    --MainGameUIInitDone = "MainGameUIInitDone", -- 主游戏UI界面 


}

-- !!! 未来提前加载:
--TODO 临时特效
ParkourGameUtil.VfxPath = {
    LevelUp = "Effect/prefab/Fx_MainMenu_TransToCat_down.prefab",
    PhaseUp = "Effect/prefab/Fx_MainMenu_TransToCat_up.prefab",
    SpeedLine = "Effect/prefab/fx_screen_uv_plane.prefab"
}


function ParkourGameUtil.GetTrackItemPath()
    return {
        [ParkourGameUtil.TrackItemType.Ground] = "Arts/Textures/OverseaClubLeisure/catcar_bg_1_a.png",
        [ParkourGameUtil.TrackItemType.Obstacle] = "Arts/Textures/OverseaClubLeisure/catcar_bg_1_a.png",
        [ParkourGameUtil.TrackItemType.Coin] = "Arts/Textures/OverseaClubLeisure/catcar_bg_1_a.png",
    }
end

ParkourGameUtil.VoParamsId = {
    RecoverTime = 1,                            --恢复活动体力所需秒数
    RecoverValue = 2,                           --活动体力每次恢复X点
    RecoverLimit = 3,                           --活动体力恢复上限
    ExchangeItemId = 4,                         --兑换体力用道具id
    ExchangeItemCost = 5,                       --消耗道具的数量
    ExchangeItemValue = 6,                      --消耗道具可兑换的体力数量
    ExchangeLimit = 7,                          --每日活动体力最多可兑换次数
    MainLevelCatHp = 8,                         --主线跑酷关卡：猫咪生命数量
    CrowHp = 9,                              --八哥的生命数量
    FreeLevelCatHp = 10,                        --自由探索跑酷关卡：猫咪生命数量

    InvisibleGoodsId = 11,                       -- 释放隐身技能所需增益道具id
    InvisibleGoodsCostNum = 12,                 -- 释放隐身技能所需增益道具数量 
    --- 
    --InfiniteMode_DailyPlayTimes = 13,            -- 自由探索跑酷关卡：每日可进入次数（该次数每日固定时间点刷新） -- !!! 废弃了 20241112-程菲
    --InfiniteMode_MoveStep = 14,                 -- !! 弃用
    InfiniteMode_MoveMultiplier = 15,           -- 自由探索跑酷关卡：猫咪每前进1米，可获得X点分数。此处配置分数
    InfiniteMode_InvisibleScore = 16,           -- 自由探索跑酷关卡：每次触发隐身技能增加分数
    InfiniteMode_UnlockStarNums = 17,            -- 自由探索功能解锁所需跑酷星数
    BossId  = 18,                               -- 当期八哥对应的id
    InfiniteMode_TrapIds = 19,          -- 自由探索展示用，陷阱id; ';'分割
    InfiniteMode_GainBuffIds = 20,      -- 自由探索展示用，增益id; ';'分割
}


-- =================================== vo =======================================



-- 微缩世界主线关卡表
---@param id_ integer @ 跑酷关卡id
---@return table
function ParkourGameUtil.GetMiniWorldMainLevelVo( id_ )
    ---@type ParkourGameMgr
    local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()
    ---
    if type(id_) ~= "number" or checkNumber(id_) == 0 then
        printError("参数异常, id: " .. tostring(id_))
        return nil
    end
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6457, "MiniWorldMainLevelVo", id_)
    ---
    if checkInt(vo.activityId) ~= Mgr.activityId then 
        printError("activityId 不一致, 请检查配表, vo:" .. tostring(vo.activityId) .. ", mgr:" .. tostring(Mgr.activityId) )
    end 
    return vo
end



-- 微缩世界主线跑酷关卡表
---@param id_ integer @ 跑酷关卡id
---@return table
function ParkourGameUtil.GetMiniWorldParkourLevelVo( id_ )
    ---@type ParkourGameMgr
    local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()
    ---
    if type(id_) ~= "number" or checkNumber(id_) == 0 then
        printError("参数异常, id: " .. tostring(id_))
        return nil
    end
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6607, "MiniWorldParkourLevelVo", id_)
    ---
    if checkInt(vo.activityId) ~= Mgr.activityId then 
        printError("activityId 不一致, 请检查配表, vo:" .. tostring(vo.activityId) .. ", mgr:" .. tostring(Mgr.activityId) )
    end 
    return vo
end



---@param vo_ table @ MiniWorldMainLevelVo 单个元素
---@return ParkourGameUtil.LevelType
function ParkourGameUtil.GetMiniWorldMainLevelVoLevelType( vo_ )
    if vo_.ifParkour == 1 then 
        return ParkourGameUtil.LevelType.Parkour
    else 
        if vo_.type == 1 then -- 纯剧情 
            return ParkourGameUtil.LevelType.Story
        else -- 战斗, 战斗+剧情
            return ParkourGameUtil.LevelType.Battle
        end 
    end 
end



-- 微缩世界三星条件表
---@param id_ integer @ 首列 id
---@return table
function ParkourGameUtil.GetMiniWorldThreeStarsConditionVO( id_ )
    if type(id_) ~= "number" or checkNumber(id_) == 0 then
        printError("参数异常, id: " .. tostring(id_))
        return nil
    end
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6462, "MiniWorldThreeStarsConditionVO", id_)
    return vo
end


-- 微缩世界三星条件表; 找出所有与 levelId_ 相关的条目
---@return table[]
function ParkourGameUtil.GetNeededMiniWorldThreeStarsConditionVOs( levelId_ )
    ---@type ParkourGameMgr
    local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()
    ---
    if type(levelId_) ~= "number" or checkNumber(levelId_) == 0 then
        printError("参数异常, levelId_: " .. tostring(levelId_))
        return nil
    end
    ---
    local vos = CfUtils.GetCf(AutoIds.IdSetting6462, "MiniWorldThreeStarsConditionVO", true)
    local rets = {}
    for k,vo in pairs(vos) do 
        if isNotNull(vo) and checkInt(vo.activityId) == Mgr.activityId and checkInt(vo.levelId) == levelId_ then 
            table.insert( rets, vo )
        end
    end
    return rets
end



-- 微缩世界活动参数表
function ParkourGameUtil.GetVoParamValue(paramId,type)
    local result
    if type == nil then
        type = Constants.DataType.Int
    end
    local row = CfUtils.GetCfLine(AutoIds.IdSetting6441, paramId) -- 微缩世界活动参数表
    if row then
        result = CfUtils.GetCfDataByLine(row, "num",type)
    else
        printError("微缩世界参数表中没有找到对应的参数id：%s", paramId)
    end
    return result
end



-- 微缩世界陷阱表
---@param id_ integer @ 陷阱id
---@return table
function ParkourGameUtil.GetMiniWorldTrapVo( id_ )
    if type(id_) ~= "number" or checkNumber(id_) == 0 then
        printError("参数异常, id: " .. tostring(id_))
        return nil
    end
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6443, "MiniWorldTrapVo", id_)
    return vo
end


-- 微缩世界增益道具表
---@param id_ integer @ 道具id
---@return table
function ParkourGameUtil.GetMiniWorldBuffItemVo( id_ )
    if type(id_) ~= "number" or checkNumber(id_) == 0 then
        printError("参数异常, id: " .. tostring(id_))
        return nil
    end
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6442, "MiniWorldBuffItemVo", id_)
    --printError(" 增益 id: "..tostring(id_).."; icon:"..tostring(vo.icon))
    return vo
end


-- 微缩世界主线剧情表
---@param id_ integer @ 道具id
---@return table
function ParkourGameUtil.GetMiniWorldMainChapterVo( id_ )
    if type(id_) ~= "number" or checkNumber(id_) == 0 then
        printError("参数异常, id: " .. tostring(id_))
        return nil
    end
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6458, "MiniWorldMainChapterVo", id_)
    return vo
end


--  用不到了...
-- 微缩世界主线奖励表
---@param id_ integer @ 关卡id
---@return table
function ParkourGameUtil.GetMiniWorldMainRewardVo( id_ )
    if type(id_) ~= "number" or checkNumber(id_) == 0 then
        printError("参数异常, id: " .. tostring(id_))
        return nil
    end
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6459, "MiniWorldMainRewardVo", id_)
    return vo
end




-- 微缩世界自由探索地图表 在符合 activityId 的列中, 找出随机某个 groupId 的全部 列vo;
---@return table[]  @ vo[]
function ParkourGameUtil.GetRandomInfiniteMapList()
    ---@type ParkourGameMgr
    local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()

    local vos = CfUtils.GetCf(AutoIds.IdSetting6604, "MiniWorldInfiniteMapVo", true)

    -- 收集出符合 activityId 的所有列;
    local rets = {}
    for k,vo in pairs(vos) do 
        if isNotNull(vo) and checkInt(vo.activityId) == Mgr.activityId then 
            local groupId = checkInt(vo.groupId)
            if isNull(rets[groupId]) then 
                rets[groupId] = {}
            end
            table.insert( rets[groupId], vo )
        end
    end

    ---
    local groupIds = {}
    for gId,list in pairs(rets) do 
        if isNotNull(list) then 
            table.insert(groupIds, gId)
        end 
    end 
    local tgtGroupId = groupIds[math.random(1, #groupIds)] 
    printError("tgtGroupId = " .. tostring(tgtGroupId))

    assert( isNotNull(rets[tgtGroupId]) )
    return rets[tgtGroupId]
end




-- =================================== 活动货币 =======================================


ParkourGameUtil.activityGoodsId = 9000051 -- 20241206 改用 好梦百合

function ParkourGameUtil.GetActivityGoodsVO()
    local vo = ParkourGameUtil.GetMiniWorldBuffItemVo( ParkourGameUtil.activityGoodsId )
    assert( isNotNull(vo) )
    return vo
end 




-- ==========================================================================

-- 单机一次按钮后, 管理对应特效go 的显示隐藏
---@param fxGO_ UnityEngine.GameObject 
---@param duration_ number
---@return UnityEngine.Coroutine
function ParkourGameUtil.HandleBtnUIFXClick( fxGO_, duration_ )
    duration_ = Mathf.Max( checkNumber(duration_), 0.3 )
    local co = CoStart(function()
        CfUtils.SetActive( fxGO_, false ) -- 先强关
        coroutine.yield(Yielders.EndOfFrame)
        CfUtils.SetActive( fxGO_, true ) -- 等一帧后先强关
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds( duration_ ))
        CfUtils.SetActive( fxGO_, false ) -- 播放完了强关
    end) 
    return co
end



function ParkourGameUtil.SetUIParent( sonTF_, parentTF_ )
    sonTF_:SetParent(parentTF_)
    sonTF_.anchorMin = Vector2.zero
    sonTF_.anchorMax = Vector2.one 
    sonTF_.offsetMin = Vector2.zero  
    sonTF_.offsetMax = Vector2.zero
    sonTF_.localScale = Vector3.one
    local localPosition = sonTF_.localPosition 
    localPosition.z = 0
    sonTF_.localPosition = localPosition
end



-- !! 目前单纯修改这个 会导致 猫被挤到 地板下面去...
ParkourGameUtil.roleNormalColliderHeight = 0.7 * 2
ParkourGameUtil.roleSlideColliderHeight = 0.4 * 2

ParkourGameUtil.roleHitColliderRadius = 0.31

function ParkourGameUtil.SetRoleCollider( go_, height_ )
    local collider = CfUtils.GetOrAddComponent(go_, typeof(CapsuleCollider))
    collider.direction = 1 -- 0:x, 1:y, 2:z
    collider.radius = ParkourGameUtil.roleSlideColliderHeight * 0.5

    collider.center = Vector3( 0, height_ * 0.5, 0)
    collider.height = height_
    ----- 
end



function ParkourGameUtil.AddRoleHitCollider( go_, radius_ )
    local Unity_Export_Grp = go_.transform:Find("Unity_Export_Grp")
    local sCollider = CfUtils.GetOrAddComponent(Unity_Export_Grp.gameObject, typeof(SphereCollider))
    sCollider.center = Vector3( 0, 0.5*radius_, 0 )
    sCollider.radius = checkNumber(radius_)
    sCollider.isTrigger = true
    local idComp = CfUtils.GetOrAddComponent(Unity_Export_Grp.gameObject, typeof(CS.Game.Native.Common.ID))
    idComp.stringId = "hitCollider"
end


-- ===================================== UI =============================================

-- 绘制 OverseaParkourEvaluateStoryStarLevelDescNode 系列节点:
function ParkourGameUtil.DawTaskLine( taskNode_, isFinish_, taskTitle_ )
    local ImgStar = taskNode_:Find("ImgStar")
    local TextDesc = taskNode_:Find("TextDesc")
    CfUtils.SetUISwitchImage( ImgStar.gameObject, isFinish_ and 2 or 1 )
    --- 
    CfUtils.FillText( TextDesc.gameObject, taskTitle_ )
end


-- 绘制 OverseaParkourEvaluateStoryStarLevelDescNode 系列节点:
function ParkourGameUtil.DawTaskLine2( taskNode_, isFinish_, taskTitle_, goodsId_, num_ )
    local LuaStub = CS.Engine.Modules.LuaStub

    local ImgStar = taskNode_:Find("ImgStar")
    local TextDesc = taskNode_:Find("TextDesc")
    CfUtils.SetUISwitchImage( ImgStar.gameObject, isFinish_ and 2 or 1 )
    CfUtils.SetUISwitchImage( TextDesc.gameObject, isFinish_ and 2 or 1 )
    CfUtils.FillText( TextDesc.gameObject, taskTitle_ )

    -- ===
    local goodNodeTF = taskNode_:Find("GoodNode")
    ---@type GoodNodeMB
    local goodNodeMB = CfUtils.GetLuaScr(goodNodeTF, "Game.Behaviours.GoodNodeMB")

    goodNodeMB:Reload({ isShowNo = true , goodsId = goodsId_, num = num_, text = "x"..num_})
    goodNodeMB:SetSanXingGainShow( isFinish_ ) -- 标注已领取的
    goodNodeMB:SetClickCallback(function()
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId_)
        if isTable(vo) then
            GameUtils.ShowCommonTipsBoard(goodNodeTF, vo.name, vo.desc, vo.quality, vo.id)
        end
    end)
end



-- ===============================

function ParkourGameUtil.IsLevelPassed( levelId_ )
    ---@type ParkourGameMgr
    local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()
    local mainQuestId = Mgr.homeDojo.mainQuestId -- 已经打穿的最新的一关
    local isPass = checkInt(levelId_) <= checkInt(mainQuestId)
    return isPass
end





-- 协程
---@param activityUuid_ number 
---@param retTable_ table @ .responseData 是返回值
function ParkourGameUtil.CallHome( activityUuid_, retTable_ )
    ---@type ParkourGameMgr
    local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()

    local responseData = nil 
    GameUtils.Request("activityTinyWorld/home", { activityUuid = activityUuid_ }, function(request, response)
        if checkNumber(response.errCode) == 0 then
            responseData = checkTable(response.data)
            Mgr.enterTime = os.time()
            -- 检查 dojo 数据: 
            local mainQuestMap = responseData.mainQuestMap
            if isNull(mainQuestMap) or table.count(mainQuestMap) == 0 then 
                printError("后端数据异常: mainQuestMap 内没元素")
            end 
        end
    end)
    ---
    while responseData == nil do
        coroutine.yield(Yielders.EndOfFrame)
    end
    retTable_.responseData = responseData
end




-- 协程
---@param activityUuid_ number 
---@param retTable_ table @ .responseData 是返回值
function ParkourGameUtil.CallParkourHome( activityUuid_, retTable_ )
    ---@type ParkourGameMgr
    local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()

    local responseData = nil 
    GameUtils.Request("activityTinyWorld/parkourHome", { activityUuid = activityUuid_ }, function(request, response)
        if checkNumber(response.errCode) == 0 then
            responseData = checkTable(response.data)
            Mgr.enterTime = os.time()
            -- 检查 dojo 数据: 
            local parkourQuestMap = responseData.parkourQuestMap
            if isNull(parkourQuestMap) or table.count(parkourQuestMap) == 0 then 
                printError("后端数据异常: parkourQuestMap 内没元素")
            end 
        end
    end)
    ---
    while responseData == nil do
        coroutine.yield(Yielders.EndOfFrame)
    end
    retTable_.responseData = responseData
end






---@return boolean @ isCachedLayerIgnore_
function ParkourGameUtil.SetLayerCollision( layer1_, layer2_, isNeedCollide_ )
    local isCachedLayerIgnore_ = Physics.GetIgnoreLayerCollision(layer1_, layer2_)
    Physics.IgnoreLayerCollision(layer1_, layer2_, not isNeedCollide_ )
    return isCachedLayerIgnore_
end



---@param x_ number | nil
---@param y_ number | nil
---@param z_ number | nil
function ParkourGameUtil._SetLocalPos( tf_, x_, y_, z_ )
    tf_.localPosition = Vector3(
        type(x_)=="number" and x_ or tf_.localPosition.x,
        type(y_)=="number" and y_ or tf_.localPosition.y,
        type(z_)=="number" and z_ or tf_.localPosition.z
    )
end



function ParkourGameUtil.IsHaveEnoughGoods( goodsId_, costNum_ )
    local GameUtils = import('Game.Utils.GameUtils')
    local goodsId = checkInt(goodsId_)
    local costNum = checkInt(costNum_) -- 道具 需要消耗数
    local hadNum = GoodsUtils.GetThingNo(goodsId) -- 道具 实际拥有数
    printInfo( "需消耗道具: " .. tostring(goodsId) .. ", 需要:" .. tostring(costNum) .. "; 拥有:" .. tostring(hadNum) )
    if hadNum < costNum then 
        local goodsName = GoodsConfMgr:GetInstance():GetGoodsNameById(goodsId)
        local msg = localize("需要_num_个_goodsName_",{_num_=costNum,_goodsName_=goodsName})
        GameUtils.Toast(msg) -- 飘字
        return false
    end 
    return true
end


-- ====================================================



---@return UnityEngine.Camera
function ParkourGameUtil.GetMainCamera()
    if isNotNull(URPCameraController.Instance) and isNotNull(URPCameraController.Instance.mainCamera) then 
        if URPCameraController.Instance.mainCamera.isActiveAndEnabled == false then 
            KTool.SetActive(URPCameraController.Instance.mainCamera, true)
        end 
        return URPCameraController.Instance.mainCamera
    end 
    printError("没找到 URPCameraController mainCamera ")
    return Camera.main
end


---@return Cinemachine.CinemachineBrain | nil
function ParkourGameUtil.GetCameraBrain()
    local mCamera = ParkourGameUtil.GetMainCamera()
    if isNotNull(mCamera) then 
        return KTool.GetComponent(mCamera.gameObject, typeof(CinemachineBrain))
    end
    return nil
end


function ParkourGameUtil.SetVCamBlendMode( style_, time_ )
    -- 不要在 Awake 阶段调用:
    local mainCameraBrain = ParkourGameUtil.GetCameraBrain()
    local _DefaultBlend = mainCameraBrain.m_DefaultBlend
    _DefaultBlend.m_Style = style_ -- 如: CinemachineBlendDefinition.Style.Cut
    _DefaultBlend.m_Time = time_
    mainCameraBrain.m_DefaultBlend = _DefaultBlend
end




function ParkourGameUtil.DestroyAllChildren(transform, eliminateNameList_)  

    local map = {}
    for _,name in pairs(eliminateNameList_) do 
        map[name] = 1
    end 

    -- 遍历当前 Transform 下的所有子物体  
    for i = transform.childCount - 1, 0, -1 do  
        local child = transform:GetChild(i)  

        if map[child.name] == nil then 
            -- 销毁子物体  
            Object.Destroy(child.gameObject) 
        end          
    end  
end





return ParkourGameUtil