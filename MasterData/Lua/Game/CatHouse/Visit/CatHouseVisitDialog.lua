---
--- Created by Eric.
--- DateTime: 2022/1/4 17:58
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local KTool = CS.Engine.Lib.KTool
local UIModule     = CS.Engine.UI.UIModule
local CommonTabToggleLeft = "Game.Behaviours.CommonTabToggleLeft"

---@class CatHouseVisitDialog
---@field CommonTabToggleLeft           UnityEngine.RectTransform
---@field FriendList                    SuperScrollView.LoopListView2
---@field VisitorList                   SuperScrollView.LoopListView2
---@field MyPraiseNum                   TMPro.TextMeshProUGUI
---@field ListDescrText                 TMPro.TextMeshProUGUI
---@field FontStyleButton               Game.Native.Common.FontStyleButton
---@field PraiseTipsBtn                 UnityEngine.RectTransform
---@field EmptyNode                 UnityEngine.RectTransform
local CatHouseVisitDialog = Class("CatHouseVisitDialog")
function CatHouseVisitDialog:__init()
    self._selectedIndex = 2
    self._friendListData = nil
    self._openType = {
        friendListTab = 1 ,
        visitListTab = 2
    }
    self._visitList = nil
    self.__visitHandler = nil
    self.isRequestFriend = false
    --self._toggleData      = {}        --页签是数据
end

function CatHouseVisitDialog:__delete()
    self._selectedIndex = nil
    self._friendListData = nil
    self._visitList = nil
    self._openType = nil
    self.isRequestFriend = nil
    Events.RemoveListener(Constants.EventNames.CatHouseVisitEvent,  self.__visitHandler)
    self.__visitHandler = nil
end

function CatHouseVisitDialog:Awake()
    self.__visitHandler =  Bind( self , self.VisitClick)
    Events.AddListener(Constants.EventNames.CatHouseVisitEvent,self.__visitHandler )

end


function CatHouseVisitDialog:OnFocus(focus)

end

function CatHouseVisitDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        xTry(function()
            self:InitView()
        end)
    end))
    return coWait
end

function CatHouseVisitDialog:InitView()
    ---@type CatHouseComponent
    local component  = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatHouseComponent, Constants.CatHouseEntityId)
    ---@return CatHouseHomeDojo
    local catHouseHomeDojo = component:GetCatHouseHomeDojo()
    local popularityNum = tostring(checkNumber(catHouseHomeDojo.popularityNum))
    self._visitList = catHouseHomeDojo.visitList
    self.MyPraiseNum.text = popularityNum
    --初始化左侧Tab 数据
    self:InitToggleData()
    -- 显示左侧Tab 页
    self:FillSelf()
    self:SwithListNode(self._selectedIndex)
    SetButtonAction(self.FontStyleButton, function()
        self:VisitClick()
    end)
    local descriptions =   localize("每次点赞都可增加1点人气值。每个猫屋每人每天只可点赞一次")
    SetButtonAction(self.PraiseTipsBtn, function()
        GameUtils.ShowCommonTipsBoardSecond(self.PraiseTipsBtn, localize("人气值"),{}, nil, nil, nil, {descriptions})
    end)

end

function CatHouseVisitDialog:VisitClick(visitData)
    if isNull(visitData) then
        visitData = {}
    end
    GameUtils.Request(Interfaces.CatHouseVisit,visitData, function(request, response)
        --- 前往玩家猫屋界面
        if checkNumber(response.errCode) ~= 0 then return end
        --TODO 前往玩家猫屋界面
        local data =  response.data
        if isNull(data) then
            return
        end

        if checkInt(data.masterPlayerId) == 0 then
            GameUtils.Toast(localize("没有匹配到玩家"))
            return
        end
        ---@type ECSWorldMgr
        local worldMgr = ECSWorldMgr:GetInstance()
        ---@type ECSWorld
        local world = worldMgr:GetWorld(Constants.GameWorld)
        ---@type ECSEntity
        local entity = world:GetEntity(Constants.PlayerEntityId)
        -- 先删除猫屋其他信息的组建
        entity:RemoveComp(ECSComponentType.Constants.CatHouseOtherPlayerComponent)
        ---@type CatHouseOtherPlayerComponent
        local CatHouseOtherPlayerComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.CatHouseOtherPlayerComponent,Constants.CatHouseEntityId)
        CatHouseOtherPlayerComponent:InitialDojo(data)
        UIModule.CloseDialog(self.controller)
        UIModule.OpenDialog({ id = Constants.UITypeIds.UICatHouseOtherPlayersDialog})
    end)
end

function CatHouseVisitDialog:InitToggleData()
    self._selectedIndex = self._openType.friendListTab
    self._toggleData   = {
        {
           text = localize("好友列表"),
           selectImgPath = "Arts/Icons/HomeLabel/tab_ico_friend.png",
           func = function()
               self._selectedIndex = self._openType.friendListTab
               self:SwithListNode(self._selectedIndex)
           end
        },
        {
            text = localize("最近来访"),
            selectImgPath = "Arts/Icons/HomeLabel/tab_ico_visit.png",
            func = function()
                self._selectedIndex = self._openType.visitListTab
                self:SwithListNode(self._selectedIndex)
            end
        }
    }

end
function CatHouseVisitDialog:FillSelf()
    local scr = CfUtils.GetLuaScr(self.CommonTabToggleLeft.gameObject, CommonTabToggleLeft)
    if isNull(scr) then return end
    scr:FillToggles(self._toggleData, self._selectedIndex)
end
function CatHouseVisitDialog:RefreshFriendList()
    ---@type CatHouseComponent
    local catHouseComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatHouseComponent, Constants.CatHouseEntityId)
    ---@type FriendComponent
    local friendComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.FriendComponent)

    local handlerFriendList = function()
        local friendList = catHouseComp:GetFriendList()
        if isNull(self._friendListData) then
            self._friendListData = self:GetUnlockCatFriendList(friendList)
        end
        if isNull(self._friendListData) or  table.count(self._friendListData) == 0  then
            KTool.SetActive(self.EmptyNode.gameObject,true)
        else
            KTool.SetActive(self.EmptyNode.gameObject,false)

            if self.FriendList.IsListViewInit then
                GameUtils.ReloadData(self.FriendList , table.count(self._friendListData))
            else
                self.FriendList:InitListView(table.count(self._friendListData), Bind(self, self.OnGetFriendCellIndex))
            end
        end
    end

    if not friendComp:HasFriendList() then
        friendComp:SyncFriendList(function()
            --- 同步好友数据（是不是可以不要了？）
            catHouseComp:SetFriendList(friendComp:GetFriendList())
            
            handlerFriendList()
        end)

    else
        handlerFriendList()
    end
end

function CatHouseVisitDialog:GetUnlockCatFriendList(friendList)
    local list = {}
    local moduleId = Constants.SystemToggleIds.Id234
    -----@type FriendComponent
    local friendComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.FriendComponent)

    for i, v in pairs(friendList) do
        if friendComponent:GetUnlockModule(v.unlockModuleIds, moduleId) then
            list[#list+1] = v
        end
    end

    return list
end

function CatHouseVisitDialog:RefreshVisitList()
    ---@type FriendComponent
    local friendComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FriendComponent)
    if friendComponent.requestFriendIds and table.count(friendComponent.requestFriendIds) > 0 then
        if self.VisitorList.IsListViewInit then
            GameUtils.ReloadData(self.VisitorList , table.count(self._visitList))
        else
            self.VisitorList:InitListView(table.count(self._visitList), Bind(self, self.OnGetVisitCellIndex))
        end
    else
        if not self.isRequestFriend then
            GameUtils.Request(Interfaces.FriendRequest,{}, function(request, response)
                if checkNumber(response.errCode) ~= 0 then return end
                self.isRequestFriend = true
                friendComponent.requestFriendIds = response.data.requestFriendIds
                self.VisitorList:InitListView(table.count(self._visitList), Bind(self, self.OnGetVisitCellIndex))
            end)
        else
            GameUtils.ReloadData(self.VisitorList , table.count(self._visitList))
        end
    end

end



---@deprecated 切换访客列表和好友列表
function CatHouseVisitDialog:SwithListNode(index)
    if index == self._openType.friendListTab then
        local text = localize("仅显示已解锁猫屋功能的好友")
        self.ListDescrText.text = text
        self:RefreshFriendList()
        KTool.SetActive(self.FriendList.gameObject, true)
        KTool.SetActive(self.VisitorList.gameObject, false)
    else
        local text = localize("仅显示近期来访前30名的调查官")
        self.ListDescrText.text = text
        KTool.SetActive(self.FriendList.gameObject, false)
        if isNull(self._visitList) or (table.count(self._visitList) == 0) then
            KTool.SetActive(self.EmptyNode.gameObject, true)
            return
        else
            KTool.SetActive(self.EmptyNode.gameObject, false)
        end
        self:RefreshVisitList()
        KTool.SetActive(self.VisitorList.gameObject, true)
    end
end

function CatHouseVisitDialog:OnGetVisitCellIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem("Cell")
    ---@type CatHouseVisitCell
    local _ENV = CfUtils.GetLuaScr(cell,"Game.CatHouse.Visit.CatHouseVisitCell")
    _ENV:PlayDelayShowAnimate()
    _ENV:RefreshVisitNode(self._visitList[index+1])
    return cell
end
function CatHouseVisitDialog:OnGetFriendCellIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem("Cell")
    ---@type CatHouseVisitCell
    local _ENV = CfUtils.GetLuaScr(cell,"Game.CatHouse.Visit.CatHouseVisitCell")
    _ENV:PlayDelayShowAnimate()
    _ENV:RefreshFriendNode(self._friendListData[index+1])
    return cell
end

function CatHouseVisitDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return CatHouseVisitDialog