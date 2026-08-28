
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
--endregion

--region define
local GVGConstants = ClubGVGUtils.Constants
local SetActive    = CfUtils.SetActive
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupFightRecordsPopup.prefab > name: OverseaClubGvgGroupFightRecordsPopup
---@class ClubGVGGroupFightRecordsPopup
---@field Env                           	ClubGVGGroupFightRecordsPopup           
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ClickClose                    	UnityEngine.RectTransform               	@ 0    
---@field BtnClose                      	UnityEngine.RectTransform               	@ 1    
---@field EmptyNode                     	UnityEngine.RectTransform               	@ 2    
---@field ScrollView                    	SuperScrollView.LoopListView2           	@ 3    
local ClubGVGGroupFightRecordsPopup = Class('ClubGVGGroupFightRecordsPopup')


function ClubGVGGroupFightRecordsPopup:__init()
end


function ClubGVGGroupFightRecordsPopup:__delete()
    self.controller = nil
end


function ClubGVGGroupFightRecordsPopup:Awake()
end


function ClubGVGGroupFightRecordsPopup:OnFocus(focus)

end


function ClubGVGGroupFightRecordsPopup:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
        self:RequestPlayerRecruit()
        while not self._isRequestSuccess do
            CoYield()
        end
    end))
    return coWait
end


function ClubGVGGroupFightRecordsPopup:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end


function ClubGVGGroupFightRecordsPopup:OnFinalize()
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

function ClubGVGGroupFightRecordsPopup:OnInit()
    self:InitData()
    self:InitAction()
    self:InitListeners()
end

function ClubGVGGroupFightRecordsPopup:InitData()
    local parameters = self.controller.Argument.parameters
    self._playerId   = parameters.playerId
    self._isInClubView   = parameters.isInClubView

    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()
    self._mgr = mgr

end

function ClubGVGGroupFightRecordsPopup:InitAction()
    SetButtonAction(self.BtnClose, function() 
        CfUtils.DialogBack()
    end)
    SetButtonAction(self.ClickClose, function() 
        CfUtils.DialogBack()
    end)
end

function ClubGVGGroupFightRecordsPopup:InitListeners()
    self._listeners = CfUtils.EventsDecorated({
        [GVGConstants.EventNames.RequestSuccess] = Bind(self, self.OnRequestSuccess)
    })
end
function ClubGVGGroupFightRecordsPopup:RemoveListeners()
    CfUtils.EventsUndecorated(self._listeners)
    self._listeners = nil
end


--endregion 


--region logic 

function ClubGVGGroupFightRecordsPopup:RequestPlayerRecruit()
    if self._isInClubView then
        self._mgr:RequestPlayerRecruit2({id = self._playerId})
    else
        self._mgr:RequestPlayerRecruit({id = self._playerId})
    end
end

function ClubGVGGroupFightRecordsPopup:FreshUI()
    self:FreshScrollView()
end

function ClubGVGGroupFightRecordsPopup:FreshScrollView()
    local dataList   = self._recruit
    local count      = #dataList
    local isEmpty    = count == 0
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


function ClubGVGGroupFightRecordsPopup:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(GVGConstants.Name.Cell)
    local node = GetLuaBehaviour(cell.gameObject, GVGConstants.LuaPath.ClubGVGGroupFightRecordsCell)
    
    ---@type ClubGVGGroupFightRecordsCell
    local nodeEnv
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        nodeEnv = node.Env
    else
        nodeEnv = node.Env
    end

    if nodeEnv then
        local dataList = self._recruit
        local position = index + 1
        local data = dataList[position]
        nodeEnv:FreshUI(data, self._isInClubView, self._playerId)

    end

    return cell
end


--endregion 


--region get/set 


---endregion 


--region handler 
function ClubGVGGroupFightRecordsPopup:OnRequestSuccess(interface, data)
    if interface == Interfaces.OverseaClubGVGPlayerRecruit or interface == Interfaces.OverseaClubGVGPlayerRecruit2 then
        self._recruit = data.recruit
        self:FreshUI()
        self._isRequestSuccess = true
    end
end

---endregion 


return ClubGVGGroupFightRecordsPopup
