
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
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupFightMessageDialog.prefab > name: OverseaClubGvgGroupFightMessageDialog
---@class ClubGVGGroupFightMessageDialog
---@field Env                           	ClubGVGGroupFightMessageDialog          
---@field controller                    	Engine.UI.UILuaDialog                   
---@field Fuzzy                         	UnityEngine.RectTransform               
---@field EmptyNode                     	UnityEngine.RectTransform               
---@field ListView                      	SuperScrollView.LoopListView2           
local ClubGVGGroupFightMessageDialog = Class('ClubGVGGroupFightMessageDialog')


function ClubGVGGroupFightMessageDialog:__init()
    self._isRequestSuccess = false
end


function ClubGVGGroupFightMessageDialog:__delete()
    self.controller = nil
end


-- function ClubGVGGroupFightMessageDialog:Awake()
-- end


function ClubGVGGroupFightMessageDialog:OnFocus(focus)
    self._graphicRaycaster.enabled = focus
end


function ClubGVGGroupFightMessageDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self._graphicRaycaster = KTool.GetComponent(self.controller.gameObject, typeof(CS.UnityEngine.UI.GraphicRaycaster))
        self:OnInit()
        self:RequestClubRecruit()
        while not self._isRequestSuccess do
            CoYield()
        end
    end))
    return coWait
end


-- function ClubGVGGroupFightMessageDialog:OnShow()
--     ---@type Engine.Lib.CoWait
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

--     end))
--     return coWait
-- end


function ClubGVGGroupFightMessageDialog:OnFinalize()
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

function ClubGVGGroupFightMessageDialog:OnInit()
    -- self:InitData()
    self:InitListeners()
end

-- function ClubGVGGroupFightMessageDialog:InitData()
    
    
-- end

function ClubGVGGroupFightMessageDialog:InitListeners()
    self._listeners = CfUtils.EventsDecorated({
        [GVGConstants.EventNames.RequestSuccess] = Bind(self, self.OnRequestSuccess)
    })
end
function ClubGVGGroupFightMessageDialog:RemoveListeners()
    CfUtils.EventsUndecorated(self._listeners)
    self._listeners = nil
end

--endregion 


--region logic 

function ClubGVGGroupFightMessageDialog:RequestClubRecruit()
    local parameters = self.controller.Argument.parameters
    local clubRecruit = parameters.clubRecruit
    local isInClubView = clubRecruit ~= nil
    self._isInClubView = isInClubView
    
    if isInClubView then
        self:HandleClubRecruit(clubRecruit)
    else
        ---@type ClubGVGMgr
        local mgr = ClubGVGUtils.GetMgr()
        mgr:RequestClubRecruit()
    end
end

function ClubGVGGroupFightMessageDialog:InitClubRecruit(clubRecruit)
    if next(clubRecruit) then
        local checkNumber = checkNumber
        table.sort(clubRecruit, function (a, b)
            return checkNumber(a.point) > checkNumber(b.point) 
        end)
    end
    self._clubRecruit = clubRecruit
end

function ClubGVGGroupFightMessageDialog:FreshUI()
    self:FreshScrollView()
end

function ClubGVGGroupFightMessageDialog:FreshScrollView()
    local dataList   = self._clubRecruit
    local count      = #dataList
    local isEmpty    = count == 0
    local ScrollView = self.ListView
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

function ClubGVGGroupFightMessageDialog:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(GVGConstants.Name.Cell)
    local node = GetLuaBehaviour(cell.gameObject, GVGConstants.LuaPath.ClubGVGGroupFightMessageCell)
    
    ---@type ClubGVGGroupFightMessageCell
    local nodeEnv
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        nodeEnv = node.Env
    else
        nodeEnv = node.Env
    end

    if nodeEnv then
        local dataList = self._clubRecruit
        local position = index + 1
        local data = dataList[position]
        nodeEnv:FreshUI(data, self._isInClubView)

        if listView.DisplayItemNumber < listView.DisplayItemCount then
            nodeEnv:PlayDelayAnimByShow(listView.DisplayItemNumber)
            listView.DisplayItemNumber = listView.DisplayItemNumber + 1
        else
            nodeEnv:PlayAnimByIdle()
        end

    end

    return cell
end

--endregion 


--region get/set 


---endregion 


--region handler 

function ClubGVGGroupFightMessageDialog:OnRequestSuccess(interface, data)
    if interface == Interfaces.OverseaClubGVGClubRecruit then
        self:HandleClubRecruit(data.clubRecruit)
    end
end

function ClubGVGGroupFightMessageDialog:HandleClubRecruit(clubRecruit)
    self:InitClubRecruit(clubRecruit)
        
    self:FreshUI()
    self._isRequestSuccess = true

end

---endregion 


return ClubGVGGroupFightMessageDialog
