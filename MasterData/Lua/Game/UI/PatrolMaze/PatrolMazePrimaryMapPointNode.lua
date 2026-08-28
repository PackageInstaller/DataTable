-------------------------------------------------------------------------------
-- 夜寻迷宫 - 主地图界面 - 地图点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-27 14:35:29
-------------------------------------------------------------------------------

local ActionUtils     = import('Game.UI.FightReady.UIMainChapter.ActionUtils')
local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

--- from: Assets/BundleResources/Prefabs/Patrol/PatrolPrimaryMapDialog130201.prefab > name: MapPointNode
---@class PatrolMazePrimaryMapPointNode
---@field Env                           	PatrolMazePrimaryMapPointNode           
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field UnlockTimeTxt                 	UnityEngine.RectTransform               @ 区域解锁文本
---@field AreaLockedNode                	UnityEngine.RectTransform               @ 区域锁定节点
---@field CloseNameTxt                  	UnityEngine.RectTransform               @ 区域关闭 名字文本
---@field CloseLockIcon                 	UnityEngine.RectTransform               @ 区域关闭 锁图标
---@field AreaCloseNode                 	UnityEngine.RectTransform               @ 区域关闭 根节点
---@field AreaNewMark                   	UnityEngine.RectTransform               @ 区域new标识
---@field AreaFinishNode                	UnityEngine.RectTransform               @ 区域完成节点
---@field AreaFloorTxt                  	UnityEngine.RectTransform               @ 区域层数文本
---@field AreaProgressNode              	UnityEngine.RectTransform               @ 区域进度节点
---@field AreaRedPoint                  	UnityEngine.RectTransform               @ 区域红点节点
---@field AreaNewImg                    	UnityEngine.RectTransform               @ 区域NEW节点
---@field OpenNameTxt                   	UnityEngine.RectTransform               @ 区域信息 名字文本
---@field AreaIconImg                   	UnityEngine.RectTransform               @ 区域信息 图标图片
---@field AreaFrameEffectImg            	UnityEngine.RectTransform               @ 区域信息 框特效图片
---@field AreaFrameImg                  	UnityEngine.RectTransform               @ 区域信息 框图片
---@field AreaInfoNode                  	UnityEngine.RectTransform               @ 区域信息 节点
---@field AreaOpenNode                  	UnityEngine.RectTransform               @ 区域开放节点
---@field RootNode                      	UnityEngine.RectTransform               @ 根节点
local PatrolMazePrimaryMapPointNode = Class('PatrolMazePrimaryMapPointNode')


function PatrolMazePrimaryMapPointNode:__init()
    ---@type PatrolMazeUtils.AreaState
    self.areaState_ = nil
end


function PatrolMazePrimaryMapPointNode:__delete()
    self.areaState_ = nil
end


function PatrolMazePrimaryMapPointNode:Awake()
end


function PatrolMazePrimaryMapPointNode:Start()
    self.eventAreaUnlockedCb_ = Events.AddListener(Constants.EventNames.PATROL_MAZE_PRIMARY_AREA_UNLOCKED, Bind(self, self.OnAreaUnlockedHandler_))
end


function PatrolMazePrimaryMapPointNode:OnDestroy()
    Events.RemoveListener(Constants.EventNames.PATROL_MAZE_PRIMARY_AREA_UNLOCKED, self.eventAreaUnlockedCb_)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return RegionPrimaryMapVo
function PatrolMazePrimaryMapPointNode:GetMapAreaVo()
    return self.mapAreaVo_
end
function PatrolMazePrimaryMapPointNode:SetMapAreaVo(mapAreaVo)
    self.mapAreaVo_ = mapAreaVo
    self:UpdateNodeBaseInfo_()
end


---@return PatrolMazeAreaDojo
function PatrolMazePrimaryMapPointNode:GetAreaDojo()
    return self.areaDojo_
end
function PatrolMazePrimaryMapPointNode:SetAreaDojo(areaDojo)
    self.areaDojo_ = areaDojo
    self:CheckAreaState()
end


---@return PatrolMazeUtils.AreaState
function PatrolMazePrimaryMapPointNode:GetAreaState()
    return self.areaState_
end


-------------------------------------------------
-- public

function PatrolMazePrimaryMapPointNode:CheckAreaState()
    local areaState = nil

    -- 是否 活动结束
    if patrolMazeComp:GetHomeDojo().isEnded then
        areaState = PatrolMazeUtils.AreaState.MAZE_ENDED
    end
    
    -- 是否 前置区域未解锁
    if areaState == nil then
        local prevAreaId   = self:GetAreaDojo().areaId - 1
        local prevAreaVo   = PatrolMazeUtils.GetAreaInfoVo(prevAreaId)
        local prevAreaDojo = patrolMazeComp:GetHomeDojo():GetAreaDojo(prevAreaId)
        if prevAreaDojo then
            if prevAreaDojo.isTimeUnlocked == false then
                areaState = PatrolMazeUtils.AreaState.PREV_LOCKED
            end
        end
        local prev2AreaId   = self:GetAreaDojo().areaId - 2
        local prev2AreaDojo = patrolMazeComp:GetHomeDojo():GetAreaDojo(prev2AreaId)
        if prev2AreaDojo then
            if prev2AreaDojo.historyFloor < prevAreaVo.prevFloor then
                areaState = PatrolMazeUtils.AreaState.PREV_LOCKED
            end
        end
    end

    -- 是否 时间未到
    if areaState == nil and self:GetAreaDojo().isTimeUnlocked == false then
        areaState = PatrolMazeUtils.AreaState.TIME_LOCKED
    end

    -- 是否 前置区域未通关
    if areaState == nil then
        local prevAreaId   = self:GetAreaDojo().areaId - 1
        local prevAreaDojo = patrolMazeComp:GetHomeDojo():GetAreaDojo(prevAreaId)
        local mazeAreaVo   = PatrolMazeUtils.GetAreaInfoVo(self:GetAreaDojo().areaId)
        if prevAreaDojo and prevAreaDojo.historyFloor < mazeAreaVo.prevFloor then
            areaState = PatrolMazeUtils.AreaState.AREA_LOCKED
        end
    end

    -- 是否 通全关
    if areaState == nil and self:GetAreaDojo():IsPassedAll() then
        areaState = PatrolMazeUtils.AreaState.AREA_PASSED
    end

    -- 默认状态
    if areaState == nil then
        areaState = PatrolMazeUtils.AreaState.CHALLENGING
    end

    -- check state change
    if self.areaState_ ~= areaState then
        self.areaState_ = areaState
        self:UpdateNodeStatus_()
    end

    self:CheckAreaNewMark()
end


function PatrolMazePrimaryMapPointNode:UpdateUnlockTime()
    local remainTime  = self:GetAreaDojo().unlockRemainTime
    local leftTimeTxt = localize('解锁：_time_后', {_time_ = CfUtils.GetTimeHMS10(remainTime)})
    CfUtils.FillText(self.UnlockTimeTxt, leftTimeTxt)
end


function PatrolMazePrimaryMapPointNode:CheckAreaNewMark()
    local isShowNewMark = false
    if self:GetAreaDojo().isTimeUnlocked then
        -- 第一个区域特殊判断
        if self:GetAreaDojo().areaId == 1 then
            -- 是否未进入过
            isShowNewMark = self:GetAreaDojo().isEntered == false
        else
            local prevAreaId   = self:GetAreaDojo().areaId - 1
            local prevAreaDojo = patrolMazeComp:GetHomeDojo():GetAreaDojo(prevAreaId)
            local mazeAreaVo   = PatrolMazeUtils.GetAreaInfoVo(self:GetAreaDojo().areaId)
            -- 是否 达成前置区域通关的解锁条件
            if prevAreaDojo.historyFloor >= mazeAreaVo.prevFloor then
                -- 已解锁的区域，但是并未进入过：才标记new
                isShowNewMark = self:GetAreaDojo().isEntered == false
            end
        end
    end
    CfUtils.SetActive(self.AreaNewMark, isShowNewMark)
end


-------------------------------------------------
-- private

function PatrolMazePrimaryMapPointNode:UpdateNodeBaseInfo_()
    local mapAreaVo = self:GetMapAreaVo()

    local framePath = string.fmt('UIAtlas/ActionAreaMap1/AreaMap_%1_icon_1.png', mapAreaVo.id)
    CfUtils.FillImage(self.AreaFrameImg, framePath)
    CfUtils.FillImage(self.AreaFrameEffectImg, framePath)
    CfUtils.FillImage(self.AreaIconImg, mapAreaVo.mapIcon)

    local areaName = string.fmt('%1.%2', mapAreaVo.id, mapAreaVo.name)
    CfUtils.FillText(self.OpenNameTxt, areaName)
    CfUtils.FillText(self.CloseNameTxt, areaName)
end


function PatrolMazePrimaryMapPointNode:UpdateNodeStatus_()
    local areaState = self:GetAreaState()

    -- 已结束 | 前置区域未通关
    if areaState == PatrolMazeUtils.AreaState.MAZE_ENDED or areaState == PatrolMazeUtils.AreaState.PREV_LOCKED then
        CfUtils.SetActive(self.AreaCloseNode, true)
        CfUtils.SetActive(self.AreaOpenNode, false)
        CfUtils.SetActive(self.CloseLockIcon, true)
        CfUtils.SetActive(self.AreaLockedNode, false)

    -- 时间未到
    elseif areaState == PatrolMazeUtils.AreaState.TIME_LOCKED then
        CfUtils.SetActive(self.AreaCloseNode, true)
        CfUtils.SetActive(self.AreaOpenNode, false)
        CfUtils.SetActive(self.CloseLockIcon, false)
        CfUtils.SetActive(self.AreaLockedNode, true)
        self:UpdateUnlockTime()

    -- 全通关
    elseif areaState == PatrolMazeUtils.AreaState.AREA_PASSED then
        CfUtils.SetActive(self.AreaCloseNode, false)
        CfUtils.SetActive(self.AreaOpenNode, true)
        CfUtils.SetActive(self.AreaFinishNode, true)
        CfUtils.SetActive(self.AreaProgressNode, false)
        CfUtils.SetCanvasGroupAlpha(self.AreaInfoNode, 0.65)

    -- 前置区域未通关
    elseif areaState == PatrolMazeUtils.AreaState.AREA_LOCKED then
        CfUtils.SetActive(self.AreaCloseNode, true)
        CfUtils.SetActive(self.AreaOpenNode, false)
        CfUtils.SetActive(self.CloseLockIcon, false)
        CfUtils.SetActive(self.AreaLockedNode, true)
        local prevAreaId  = self:GetAreaDojo().areaId - 1
        local regionMapVo = ActionUtils.GetRegionPrimaryMapVo(prevAreaId)
        local mazeAreaVo  = PatrolMazeUtils.GetAreaInfoVo(self:GetAreaDojo().areaId)
        local unlockText  = localize('解锁：需通关_name_第_num_层', {_name_ = regionMapVo.name, _num_ = mazeAreaVo.prevFloor})
        CfUtils.FillText(self.UnlockTimeTxt, unlockText)

    -- 挑战中
    elseif areaState == PatrolMazeUtils.AreaState.CHALLENGING then
        CfUtils.SetActive(self.AreaCloseNode, false)
        CfUtils.SetActive(self.AreaOpenNode, true)
        CfUtils.SetActive(self.AreaFinishNode, false)
        CfUtils.SetActive(self.AreaProgressNode, true)
        CfUtils.SetCanvasGroupAlpha(self.AreaInfoNode, 1)

        local floorTxt = string.fmt('%1/%2', self:GetAreaDojo().floorPassed, self:GetAreaDojo().floorLimit)
        CfUtils.FillText(self.AreaFloorTxt, floorTxt)
    end
end


-------------------------------------------------
-- handler

---@param areaId integer
function PatrolMazePrimaryMapPointNode:OnAreaUnlockedHandler_(areaId)
    if self:GetAreaDojo() and areaId == self:GetAreaDojo().areaId then
        self:CheckAreaState()
    end
end


return PatrolMazePrimaryMapPointNode
