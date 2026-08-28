
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
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
--endregion

--region define
local SetActive        = CfUtils.SetActive
local GVGConstants     = ClubGVGUtils.Constants

local LabelType = GVGConstants.RankingLabelType
local URPCameraController =  CS.Game.Native.URP.URPCameraController.Instance

--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupRankingsDialog.prefab > name: OverseaClubGvgGroupRankingsDialog
---@class ClubGVGGroupRankingsDialog
---@field Env                           	ClubGVGGroupRankingsDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field FontStyleButton               	UnityEngine.RectTransform               	@ 0    
---@field LayoutListAndMySelf           	UnityEngine.RectTransform               	@ 1    
---@field MyRanking                     	UnityEngine.RectTransform               	@ 2    
---@field LoopView                      	SuperScrollView.LoopListView2           	@ 3    
---@field EmptyNode                     	UnityEngine.RectTransform               	@ 4    
---@field CommonTabToggleUp             	UnityEngine.RectTransform               	@ 5    
---@field Text4                         	UnityEngine.RectTransform               	@ 6    
---@field Text5                         	UnityEngine.RectTransform               	@ 7    
local ClubGVGGroupRankingsDialog = Class('ClubGVGGroupRankingsDialog')


function ClubGVGGroupRankingsDialog:__init()
    self._isRequestSuccess = false
    self._labelType = LabelType.Club
end


function ClubGVGGroupRankingsDialog:__delete()
    self.controller = nil
end


function ClubGVGGroupRankingsDialog:Awake()
end


function ClubGVGGroupRankingsDialog:OnFocus(focus)
    self._graphicRaycaster.enabled = focus
    if focus then
        Events.Broadcast(ClubGVGUtils.Constants.EventNames.SetCameraShowState, true)
        URPCameraController:SetMainCameraActive(false)
    end
end


function ClubGVGGroupRankingsDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self._graphicRaycaster = KTool.GetComponent(self.controller.gameObject, typeof(CS.UnityEngine.UI.GraphicRaycaster))
        self:OnInit()
        SetActive(self.FontStyleButton, self._labelType == LabelType.Club)
        self:Request()
        while not self._isRequestSuccess do
            CoYield()
        end
        self:FreshToggleUI()
    end))
    return coWait
end


function ClubGVGGroupRankingsDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end


function ClubGVGGroupRankingsDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:RemoveListeners()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function ClubGVGGroupRankingsDialog:OnInit()
    self:InitData()
    self:InitListeners()
end

function ClubGVGGroupRankingsDialog:InitData()
    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()
    self._mgr = mgr

    local func = function(index)
        local data = self._toggleDataList[index]
        self._labelType = data.labelType
        SetActive(self.FontStyleButton, self._labelType == LabelType.Club)

        -- self:FreshScrollView()
        -- self:FreshMyRanking()
        self:FreshUI()
    end
    self._toggleDataList = {
        {labelType = LabelType.Club,   text = localize("社团"), func = func},
        {labelType = LabelType.Player, text = localize("个人"), func = func},
    }
    -- local parameters = self.controller.Argument.parameters
    -- self._labelType = parameters.LabelType
end

function ClubGVGGroupRankingsDialog:InitListeners()
    self._listeners = CfUtils.EventsDecorated({
        [GVGConstants.EventNames.RequestSuccess] = Bind(self, self.OnRequestSuccess)
    })

    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickBtnRewardAction))
end
function ClubGVGGroupRankingsDialog:RemoveListeners()
    CfUtils.EventsUndecorated(self._listeners)
    self._listeners = nil
end

--endregion 


--region logic 

function ClubGVGGroupRankingsDialog:Request()
    local labelType = self._labelType
    if labelType == LabelType.Club then
        self:RequestRank()
    elseif labelType == LabelType.Player then
        self:RequestPlayerRank()
    end
end

function ClubGVGGroupRankingsDialog:RequestRank()
    self._mgr:RequestRank()
end

function ClubGVGGroupRankingsDialog:RequestPlayerRank()
    self._mgr:RequestPlayerRank()
end

function ClubGVGGroupRankingsDialog:FreshToggleUI()
    ---@type CommonTabToggleUp
    local env = CfUtils.GetLuaScr(self.CommonTabToggleUp.gameObject, GVGConstants.LuaPath.CommonTabToggleUp)
    env:FillToggles(self._toggleDataList, self._labelType)    
end

function ClubGVGGroupRankingsDialog:FreshUI()
    
    self:FreshScrollView()
    self:FreshMyRanking()
    self:FreshView()
end

function ClubGVGGroupRankingsDialog:FreshScrollView()
    local dataList   = self:GetRankDataList()
    if dataList == nil then return end
    
    local count      = #dataList
    local isEmpty    = count == 0
    local ScrollView = self.LoopView
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

function ClubGVGGroupRankingsDialog:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(GVGConstants.Name.Cell)
    local node = GetLuaBehaviour(cell.gameObject, GVGConstants.LuaPath.ClubGVGGroupRankingsNode)
    
    ---@type ClubGVGGroupRankingsNode
    local nodeEnv
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        nodeEnv = node.Env
    else
        nodeEnv = node.Env
    end

    if nodeEnv then
        local dataList = self:GetRankDataList()
        local position = index + 1
        local data = dataList[position]
        nodeEnv:FreshUI(data, self._labelType, self._mgr:GetPlayerId())

        if listView.DisplayItemNumber < listView.DisplayItemCount then
            nodeEnv:PlayDelayAnimByShow(listView.DisplayItemNumber)
            listView.DisplayItemNumber = listView.DisplayItemNumber + 1
        else
            nodeEnv:PlayAnimByIdle()
        end


    end

    return cell
end

function ClubGVGGroupRankingsDialog:FreshMyRanking()
    local rankData = self:GetSelfRankData()
    if rankData == nil then
        return
    end
    self._selfRankData = rankData
    ---@type ClubGVGGroupRankingsNode
    local env = CfUtils.GetLuaScr(self.MyRanking, GVGConstants.LuaPath.ClubGVGGroupRankingsNode)
    if isNotNull(env) then
        env:FreshUI(rankData, self._labelType, self._mgr:GetPlayerId())
        env:FreshExtraState(rankData)

    end
end

function ClubGVGGroupRankingsDialog:FreshView()
    SetActive(self.Text4, self._labelType == LabelType.Club)
    SetActive(self.Text5, self._labelType == LabelType.Club)
end

--endregion 


--region get/set 

function ClubGVGGroupRankingsDialog:GetRankDataList()
    local labelType = self._labelType
    if labelType == LabelType.Club then
        if self._clubRank == nil then
            self:Request()
        end
        return self._clubRank
    elseif labelType == LabelType.Player then
        if self._playerRank == nil then
            self:Request()
        end
        return self._playerRank
    end
end

function ClubGVGGroupRankingsDialog:GetSelfRankData()
    local dataList = self:GetRankDataList()
    if dataList == nil then
        return
    end
    local labelType = self._labelType
    
    local id
    if labelType == LabelType.Club then
        id = self._mgr:GetClubId()
        for key, value in pairs(dataList) do
            if checkNumber(value.clubId) == id then
                return value
            end
        end

        local clubInfo = self._mgr:GetClubInfoById(id)
        ---@type ClubComponent
        local component = ClubUtils.GetClubComp()
        ---@type ClubHomeDojo
        local clubHomeDojo = component:GetHomeDojo()
        local chairmanName
        ---@param value ClubMemberDojo
        for index, value in ipairs(clubHomeDojo.memberList) do
            if value.job == ClubUtils.JobType.CHAIRMAN then
                chairmanName = value.name
                break
            end
        end

        return {
            clubId = id,
            clubName = clubInfo and clubInfo.name or "",
            avatar = clubHomeDojo.avatar,
            chairmanName = chairmanName,
            ranking = 0,
            point = 0,
            buildPoint = 0,
            playerJoinPoint = 0,

        }

    elseif labelType == LabelType.Player then
        id = self._mgr:GetPlayerId()
        -- print(table.toString(dataList))
        for key, value in pairs(dataList) do
            if checkNumber(value.playerId) == id then
                return value
            end
        end

        local clubInfo = self._mgr:GetClubInfoById(self._mgr:GetClubId())
        ---@type PlayerComponent
        local playerComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        ---@type PlayerDojo
        local playerInfo = playerComp:GetPlayerDojo()
        return {
            playerId = id,
            playerName = playerInfo.playerName,
            clubName = clubInfo == nil and "" or clubInfo.name,
            level = playerInfo.level,
            avatar = playerInfo.playerAvatar,
            avatarFrame = playerInfo.playerAvatarFrame,
            ranking = 0,
            point = 0,
            

        }
    end
end

---endregion 


--region handler 

function ClubGVGGroupRankingsDialog:OnRequestSuccess(interface, data)
    if interface == Interfaces.OverseaClubGVGRank then
        self._clubRank = data.clubRank
        self:FreshUI()
        self._isRequestSuccess = true
    elseif interface == Interfaces.OverseaClubGVGPlayerRank then
        self._playerRank = data.playerRank
        self:FreshUI()
        self._isRequestSuccess = true
    end
end

function ClubGVGGroupRankingsDialog:OnClickBtnRewardAction()
    local ranking = self._selfRankData.ranking
    CfUtils.DialogOpen(Constants.UITypeIds.ClubGvgGroupRankingsRewardPopup, {labelType = self._labelType, ranking = ranking})

end

---endregion 


return ClubGVGGroupRankingsDialog
