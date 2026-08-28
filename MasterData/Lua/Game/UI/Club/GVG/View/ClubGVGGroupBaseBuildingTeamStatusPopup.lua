
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type ClubGVGUtils
local ClubGVGUtils     = import('Game.UI.Club.GVG.ClubGVGUtils')
local URPCameraController =  CS.Game.Native.URP.URPCameraController.Instance
--endregion

--region define

local SetActive        = CfUtils.SetActive
local GetTimeHMS2      = CfUtils.GetTimeHMS2
local GVGConstants     = ClubGVGUtils.Constants
local LabelType        = GVGConstants.BuildingStatusLabelType

--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupBaseTeamStatusPopup.prefab > name: OverseaClubGvgGroupBaseTeamStatusPopup
---@class ClubGVGGroupBaseBuildingTeamStatusPopup
---@field Env                           	ClubGVGGroupBaseBuildingTeamStatusPopup 
---@field controller                    	Engine.UI.UILuaDialog                   
---@field CommonTabToggleUp             	UnityEngine.RectTransform               	@ 0    
---@field EmptyNode                     	UnityEngine.RectTransform               	@ 1    
---@field ScrollView                    	SuperScrollView.LoopListView2           	@ 2    
---@field BtnClose                      	UnityEngine.RectTransform               	@ 3    
local ClubGVGGroupBaseBuildingTeamStatusPopup = Class('ClubGVGGroupBaseBuildingTeamStatusPopup')


function ClubGVGGroupBaseBuildingTeamStatusPopup:__init()
end


function ClubGVGGroupBaseBuildingTeamStatusPopup:__delete()
    self.controller = nil
end


-- function ClubGVGGroupBaseBuildingTeamStatusPopup:Awake()
-- end


function ClubGVGGroupBaseBuildingTeamStatusPopup:OnFocus(focus)
    if focus then
        URPCameraController:SetMainCameraActive(false)
    end
end


function ClubGVGGroupBaseBuildingTeamStatusPopup:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
        self:FreshUI()
    end))
    return coWait
end


-- function ClubGVGGroupBaseBuildingTeamStatusPopup:OnShow()
--     ---@type Engine.Lib.CoWait
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        
--     end))
--     return coWait
-- end


function ClubGVGGroupBaseBuildingTeamStatusPopup:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if LadderStruggleMgr then
            LadderStruggleMgr:Clear()
            LadderStruggleMgr = nil
        end
        self:RemoveListeners()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function ClubGVGGroupBaseBuildingTeamStatusPopup:OnInit()
    self:InitData()
    self:InitListeners()
end

function ClubGVGGroupBaseBuildingTeamStatusPopup:InitData()
    local parameters = self.controller.Argument.parameters
    self._labelType  = parameters.labelType
    local buildingId = parameters.buildingId
    self._buildingId = buildingId

    self:InitToggleDataList()
    self:InitBuildingTeamStateData(buildingId)
end

function ClubGVGGroupBaseBuildingTeamStatusPopup:InitToggleDataList()
    local func = function(index)
        local data = self._toggleDataList[index]
        self._labelType = data.labelType
        self:FreshScrollView()
    end
    self._toggleDataList = {
        {labelType = LabelType.Attack,   showNormalBg = true, text = localize("进攻列"), func = func},
        {labelType = LabelType.Defense,  showNormalBg = true, text = localize("防守列"), func = func},
        {labelType = LabelType.Battling, showNormalBg = true, text = localize("战斗列"), func = func},
    }
end

function ClubGVGGroupBaseBuildingTeamStatusPopup:InitBuildingTeamStateData(buildingId)
    local buildingTeamStateData = {}
    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()
    local buildingInfo = mgr:GetBuildInfo(buildingId)
    -- print("buildingInfo", table.toString(buildingInfo))
    local fightingInfo  = buildingInfo.fightingInfo
    local buildingFightingInfo, battingPlayerIdMap = ClubGVGUtils.GetBuildingFightingInfo(fightingInfo)
    buildingTeamStateData[LabelType.Battling] = buildingFightingInfo

    local attackPlayerIds     = buildingInfo.attackPlayerIds
    local playerInfos = ClubGVGUtils.GetPlayerInfosByIds(attackPlayerIds, battingPlayerIdMap)
    buildingTeamStateData[LabelType.Attack] = playerInfos

    local defendPlayerInfo = buildingInfo.defensePlayerIds
    playerInfos = ClubGVGUtils.GetPlayerInfosByIds(defendPlayerInfo, battingPlayerIdMap)
    buildingTeamStateData[LabelType.Defense] = playerInfos

    self._buildingTeamStateData = buildingTeamStateData

    local clubId   = buildingInfo.clubId
    local buildingId = checkNumber(buildingInfo.buildingId)
    local info     = mgr:GetClubInfoById(clubId)
    local clubName = info ~= nil and info.name or ""
    local buildingType = buildingInfo.type
    ---@type ClubGVGBuildingVo
    local vo = ClubGVGUtils.GetBuildingVoById(buildingType)
    self._buildingInfo = {
        icon = vo.icon,
        name = ClubGVGUtils.GetBuildingName(vo, buildingId),
        clubName = clubName,
    }

    self._isInCurrentBuilding = buildingId == mgr:GetHomeDojo().playerPlace
end

function ClubGVGGroupBaseBuildingTeamStatusPopup:InitListeners()
    SetButtonAction(self.BtnClose, function ()
        self.controller:Close()
    end)

    local EventNames = GVGConstants.EventNames
    self._listeners = CfUtils.EventsDecorated({
        [EventNames.ChangeCountDown] = Bind(self, self.OnEventChangeCountDown),
        [EventNames.ReceiveRecord] = Bind(self, self.OnEventReceiveRecord),
        [EventNames.DataUpdate] = Bind(self, self.OnEventDataUpdate),
        [EventNames.RequestSuccess] = Bind(self, self.OnEventRequestSuccess),
    })
end

function ClubGVGGroupBaseBuildingTeamStatusPopup:RemoveListeners()
    CfUtils.EventsUndecorated(self._listeners)
    self._listeners = nil
end

--endregion 


--region logic 

function ClubGVGGroupBaseBuildingTeamStatusPopup:FreshUI()
    self:FreshToggleList()
    self:FreshScrollView()
    self._isInitListComplete = true
end

function ClubGVGGroupBaseBuildingTeamStatusPopup:FreshToggleList()
    ---@type CommonTabToggleUp
    local env = CfUtils.GetLuaScr(self.CommonTabToggleUp.gameObject, GVGConstants.LuaPath.CommonTabToggleUp)
    env:FillToggles(self._toggleDataList, self._labelType)    
end

function ClubGVGGroupBaseBuildingTeamStatusPopup:FreshScrollView()
    local dataList = self:GetDataList()
    local count    = #dataList
    local isEmpty  = count == 0
    local ScrollView = self.ScrollView
    SetActive(ScrollView, not isEmpty)
    SetActive(self.EmptyNode, isEmpty)
    if not isEmpty then
        if not ScrollView.IsListViewInit then
            ScrollView:InitListView(count, Bind(self, self.OnGetItemByIndex))
        else
            GameUtils.ReloadData(ScrollView, count)
        end
    end
end

function ClubGVGGroupBaseBuildingTeamStatusPopup:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(GVGConstants.Name.Cell)
    local node = GetLuaBehaviour(cell.gameObject, GVGConstants.LuaPath.ClubGVGGroupBaseTeamCell)
    
    ---@type ClubGVGGroupBaseTeamCell
    local nodeEnv
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        nodeEnv = node.Env
    else
        nodeEnv = node.Env
    end

    if nodeEnv then
        local dataList = self:GetDataList()
        local position = index + 1
        local data = dataList[position]
        nodeEnv:FreshUI(data, self._buildingInfo, position, self._labelType, self._isInCurrentBuilding)

    end

    return cell
end


function ClubGVGGroupBaseBuildingTeamStatusPopup:FreshCellCountDown(cell, currentSeconds)
    ---@type ClubGVGGroupBaseTeamCell
    local env = CfUtils.GetLuaScr(cell, GVGConstants.LuaPath.ClubGVGGroupBaseTeamCell)
    if isNull(env) then
        return
    end
    return env:FreshCountdown(currentSeconds)
    
end

function ClubGVGGroupBaseBuildingTeamStatusPopup:ReloadUI()
    self:InitBuildingTeamStateData(self._buildingId)
    self:FreshScrollView()
end


--endregion 


--region get/set 

function ClubGVGGroupBaseBuildingTeamStatusPopup:GetDataList()
    return self._buildingTeamStateData[self._labelType]
end

---endregion 


--region handler 


function ClubGVGGroupBaseBuildingTeamStatusPopup:OnEventChangeCountDown(currentSeconds)
    if self._labelType ~= LabelType.Battling or not self._isInitListComplete or 0 == #self:GetDataList() then
        return
    end

    local isEnd = false
    self.ScrollView:DoActionForEachShownItem(function(cell) 
        isEnd = isEnd or not self:FreshCellCountDown(cell, currentSeconds)
    end, nil)
    if isEnd then
        self:ReloadUI()
    end
end

function ClubGVGGroupBaseBuildingTeamStatusPopup:OnEventReceiveRecord(dataType, data)
    local isCurrentBuilding = data ~= nil and checkNumber(data.bid) == self._buildingId
    if isCurrentBuilding then
        self:ReloadUI()
    end

end

function ClubGVGGroupBaseBuildingTeamStatusPopup:OnEventDataUpdate(triggerType, data)
    local isCurrentBuilding = data ~= nil and checkNumber(data.bid) == self._buildingId
    if isCurrentBuilding then
        self:ReloadUI()
    end

end

function ClubGVGGroupBaseBuildingTeamStatusPopup:OnEventRequestSuccess(interfaces, data)
    if interfaces == Interfaces.OverseaClubGVGAt then
        local atEndTime  = checkNumber(data.atEndTime)
        local leftSeconds = atEndTime - GameUtils.GetServerTime()
        if leftSeconds > 1 then
            local recordData = checkTable(data.battleData or data.questBattleData)
            local statistics = checkTable(data.statistics)
            
            -- recordData       = checkTable(recordData)
            
            if LadderStruggleMgr == nil then
                ---@type LadderStruggleMgr
                LadderStruggleMgr = import('Game.UI.UIBattling.LadderStruggle.LadderStruggleMgr')
            end
            LadderStruggleMgr:Init()
            LadderStruggleMgr:SetLadderStruggleData(recordData, statistics)
            LadderStruggleMgr:Preprocessing()
            CfUtils.DialogOpen(Constants.UITypeIds.LadderStruggleBattleAbstractDialog, {
                order = 100,
                directShowBattleEnd = false, 
                noSwapAnimation     = true,
                noStatistic         = true,
                showBattleDuration  = leftSeconds,
                exitBtnText         = localize("关闭")
            })
            
        end
        
    end

end

---endregion 


return ClubGVGGroupBaseBuildingTeamStatusPopup
