-------------------------------------------------------------------------------
-- 夜寻迷宫 - 主地图界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-21 20:18:47
-------------------------------------------------------------------------------

local Camera          = CS.UnityEngine.Camera
local QuickTap        = CS.HedgehogTeam.EasyTouch.QuickTap
local regionQuestMgr  = import('Game.UI.FightReady.UIMainChapter.RegionQuestMgr'):GetInstance()
local ActionUtils     = import('Game.UI.FightReady.UIMainChapter.ActionUtils')
local ActivityUtils   = import('Game.Activity.ActivityUtils')
local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

local MapPointLuaPath = 'Game.UI.PatrolMaze.PatrolMazePrimaryMapPointNode'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Patrol/PatrolPrimaryMapDialog130201.prefab > name: PatrolPrimaryMapDialog130201
---@class PatrolMazePrimaryMapDialog
---@field Env                           	PatrolMazePrimaryMapDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field MazeDescrText                 	UnityEngine.RectTransform               	@ 0    迷宫描述文本
---@field LeftTimeText                  	UnityEngine.RectTransform               	@ 1    剩余时间文本
---@field MazeInfoNode                  	UnityEngine.RectTransform               	@ 2    迷宫信息节点
---@field MapPointNode                  	UnityEngine.RectTransform               	@ 3    地图节点
---@field MapNodeRoot                   	UnityEngine.RectTransform               	@ 4    地图根节点
---@field UIRootNode                    	UnityEngine.RectTransform               	@ 5    UI信息根节点
---@field BgGroup                       	UnityEngine.RectTransform               	@ 6    背景根节点
---@field Root                          	UnityEngine.RectTransform               	@ 7    根节点
---@field RewardsBtn                    	UnityEngine.RectTransform               	@ 8    奖励按钮
---@field RewardsRed                    	UnityEngine.RectTransform               	@ 9    奖励红点
---@field RewardsUIFX                   	UnityEngine.RectTransform               	@ 10   奖励特效
---@field ReceiveTipsNode               	UnityEngine.RectTransform               	@ 11   领取提示节点
---@field ReceiveTipsTxt                	UnityEngine.RectTransform               	@ 12   领取提示文本
local PatrolMazePrimaryMapDialog = Class('PatrolMazePrimaryMapDialog')


function PatrolMazePrimaryMapDialog:__init()
    ---@type UnityEngine.GameObject @ 一级地图go
    self.primaryMapGo_ = nil

    ---@type ActivityDojo @ 活动dojo
    self.activityDojo_ = nil

    ---@type table<integer, PatrolMazePrimaryMapPointNode> @ 地图节点字典（key：区域id，value：地图点lua）
    self.mapNodeEnvMap_ = {}
end


function PatrolMazePrimaryMapDialog:__delete()
    self.primaryMapGo_  = nil
    self.activityDojo_  = nil
    self.mapNodeEnvMap_ = nil
end


function PatrolMazePrimaryMapDialog:Awake()
    SetButtonAction(self.RewardsBtn, Bind(self, self.OnClickRewardsButtonHandler_))
    self.eventsDecorated_ = CfUtils.EventsDecorated({
        [Constants.EventNames.PATROL_MAZE_REMAIN_TIME_CHANGE] = Bind(self, self.OnRemainTimeChangeHandler_),
        [PatrolMazeUtils.EventsName.ENTER_TEAM_ENTER]         = Bind(self, self.OnEnterTeamEnterHandler_),
    })
end


function PatrolMazePrimaryMapDialog:OnFocus(isFocus)
    if isFocus then
        CfUtils.SetUICameraProjection(false, 26)
    end
end


function PatrolMazePrimaryMapDialog:OnInitialize()
    return CoWaitDo(function()
        -- init vars
        local initParams   = CfUtils.DialogSafeParameters(self.controller)
        self.activityDojo_ = initParams.activityDojo

        -- init scene status
        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusGrowSceneEventName, false)
        CoYield() -- wait event invoke

        -- init views
        self.primaryMapGo_ = regionQuestMgr:GetPrimaryMapGo('AreaMap_99')
    end)
end


function PatrolMazePrimaryMapDialog:OnShow()
    return CoWaitDo(function()
        -- 初始化地图点一定要放在 onShow 里面做，不然 WorldPosition2UIPosition 会获取有错误
        self:InitPrimaryMap_()
        self:UpdateActivityInfo_()

        -- switch bgm
        local bgmName = PatrolMazeUtils.GetParamDescr(PatrolMazeUtils.ParamsId.MAZE_BGM_NAME)
        GameUtils.GetCriWareUtils().PlayMusicById(bgmName)

        -- request data
        patrolMazeComp:SyncMazeHomeData(function()
            self:UpdateTaskRedPoint_()
            self:UpdateActivityTime_()
            self:UpdatePrimaryMap_()
        end)
    end)
end


function PatrolMazePrimaryMapDialog:OnFinalize()
    return CoWaitDo(function()
        CfUtils.EventsUndecorated(self.eventsDecorated_)
        CfUtils.SetUICameraProjection(true)
        regionQuestMgr:DelPrimaryMapGo()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- private

function PatrolMazePrimaryMapDialog:InitPrimaryMap_()
    -- 显示地图上的云雾特效
    CfUtils.SetActive(self.primaryMapGo_.transform:Find('ParticleSystem'), true)

    ---@type UnityEngine.Camera
    local mapGoCamera   = CfUtils.GetOrAddComponent(self.primaryMapGo_.transform:Find('AreaMap_01_Camera'), Camera)
    local mapAreaVoList = ActionUtils.GetAllRegionPrimaryMapVo()

    -- 生成地图区域位置点
    ---@param luaIndex integer
    ---@param childNode UnityEngine.RectTransform
    GameUtils.ResizeContent(self.MapNodeRoot, self.MapPointNode, #mapAreaVoList, function(luaIndex, childNode)
        local mapAreaVo  = mapAreaVoList[luaIndex]
        local mapAreaTf  = self.primaryMapGo_.transform:Find(mapAreaVo.id)
        local clickTf    = self.primaryMapGo_.transform:Find('AreaMap_01_plane/AreaMap_' .. mapAreaVo.id)
        local quickTap   = CfUtils.GetOrAddComponent(clickTf, QuickTap)
        local mapAreaPos = CfUtils.WorldPosition2UIPosition(mapAreaTf.position, self.UIRootNode)

        -- update nodeGo
        childNode.name = 'MapPointNode' .. tostring(mapAreaVo.id)
        childNode.anchoredPosition = mapAreaPos
        quickTap.onTap:AddListener(Bind(self, self.OnClickPrimaryMapAreaHandler_, mapAreaVo.id))
        
        ---@type PatrolMazePrimaryMapPointNode
        local mapPointNodeEnv = CfUtils.GetLuaScr(childNode, MapPointLuaPath)
        mapPointNodeEnv:SetMapAreaVo(mapAreaVo)
        self.mapNodeEnvMap_[checkInt(mapAreaVo.id)] = mapPointNodeEnv
        CfUtils.SetActive(childNode, false)
    end)
end


function PatrolMazePrimaryMapDialog:UpdatePrimaryMap_()
    for areaId, mapPointNodeEnv in pairs(self.mapNodeEnvMap_) do
        local areaDojo = patrolMazeComp:GetHomeDojo():GetAreaDojo(areaId)
        if areaDojo then
            mapPointNodeEnv:SetAreaDojo(areaDojo)
            CfUtils.SetActive(mapPointNodeEnv.controller.gameObject, true)
        end
    end
end


function PatrolMazePrimaryMapDialog:UpdateActivityTime_()
    local remainTime  = patrolMazeComp:GetHomeDojo().remainTime
    local leftTimeTxt = remainTime > 0 and CfUtils.GetTimeHMS10(remainTime) or localize('活动已结束')
    CfUtils.FillText(self.LeftTimeText, leftTimeTxt)
end


function PatrolMazePrimaryMapDialog:UpdateActivityInfo_()
    local primaryMapDescr = PatrolMazeUtils.GetParamDescr(PatrolMazeUtils.ParamsId.PRIMARY_MAP_DESCR)
    CfUtils.FillText(self.MazeDescrText, primaryMapDescr)
end


function PatrolMazePrimaryMapDialog:UpdateTaskRedPoint_()
    local hasRewards = false
    for _, taskDojo in ipairs(patrolMazeComp:GetHomeDojo().taskDojoList) do
        if taskDojo:CanDraw() then
            hasRewards = true
            break
        end
    end
    CfUtils.SetActive(self.RewardsRed, hasRewards)
    CfUtils.SetActive(self.RewardsUIFX, hasRewards)
    CfUtils.SetUISwitchText(self.ReceiveTipsTxt, hasRewards and 2 or 1)
end


function PatrolMazePrimaryMapDialog:DoEnterMazeArea_(mapAreaId)
    local clickTf = self.primaryMapGo_.transform:Find('AreaMap_01_plane/AreaMap_' .. mapAreaId)
    CfUtils.SetActive(self.controller.gameObject, false)
    CfUtils.SetActive(clickTf:Find('click'), true)
    CfUtils.StartCoroutineWithBlocker(function()
        local aniName  = 'AreaMap_01_plane_Out_0' .. mapAreaId
        local aniObjTf = self.primaryMapGo_.transform:Find('AreaMap_01_plane')
        CfUtils.PlayAnimation(aniObjTf, aniName)
        CoYield(0.2)
        CfUtils.DialogOpen(Constants.UITypeIds.UIPatrolMazeMainDialog, {mapAreaId = mapAreaId}, CfUtils.DialogGetAllArgs())
    end)
end


-------------------------------------------------
-- handler

function PatrolMazePrimaryMapDialog:OnRemainTimeChangeHandler_()
    -- update activityTime
    self:UpdateActivityTime_()

    -- update areas unlockTime
    for areaId, mapPointNodeEnv in pairs(self.mapNodeEnvMap_) do
        if mapPointNodeEnv:GetAreaDojo() and not mapPointNodeEnv:GetAreaDojo().isTimeUnlocked then
            mapPointNodeEnv:UpdateUnlockTime()
        end
    end
end


function PatrolMazePrimaryMapDialog:OnClickRewardsButtonHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.UIPatrolPrimaryMapAreaTaskDialog, {drawRewardsCb = function()
        self:UpdateTaskRedPoint_()
    end})
end


function PatrolMazePrimaryMapDialog:OnEnterTeamEnterHandler_(mapAreaId)
    self:DoEnterMazeArea_(mapAreaId)
end


---@param mapAreaId integer
function PatrolMazePrimaryMapDialog:OnClickPrimaryMapAreaHandler_(mapAreaId)
    local mapPointNodeEnv = self.mapNodeEnvMap_[checkInt(mapAreaId)]
    if not mapPointNodeEnv then return end
    
    local areaState = mapPointNodeEnv:GetAreaState()

    -- 已结束
    if areaState == PatrolMazeUtils.AreaState.MAZE_ENDED then
        GameUtils.Toast(localize('活动已结束'))

    -- 时间未到
    elseif areaState == PatrolMazeUtils.AreaState.TIME_LOCKED then
        GameUtils.Toast(localize('未到开启时间'))

    -- 前置区域层数未达到
    elseif areaState == PatrolMazeUtils.AreaState.AREA_LOCKED then
        GameUtils.Toast(localize('前置区域未达到指定通关层数'))

    -- 前置区域未通关
    elseif areaState == PatrolMazeUtils.AreaState.PREV_LOCKED then
        GameUtils.Toast(localize('前置区域未解锁'))

    -- 挑战中 | 全通关
    elseif areaState == PatrolMazeUtils.AreaState.CHALLENGING or 
        areaState == PatrolMazeUtils.AreaState.AREA_PASSED then
        -- 是否设置过出战队伍
        local areaDojo = patrolMazeComp:GetHomeDojo():GetAreaDojo(mapAreaId)
        if areaDojo.hasAreaTeam then
            self:DoEnterMazeArea_(mapAreaId)
        else
            CfUtils.DialogOpen(Constants.UITypeIds.UIPatrolMazeEnterTeamPopup, {mapAreaId = mapAreaId})
        end
    end
end


return PatrolMazePrimaryMapDialog
