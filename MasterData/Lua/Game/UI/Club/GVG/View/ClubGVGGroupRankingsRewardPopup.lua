
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
local GVGConstants      = ClubGVGUtils.Constants
local SetActive = CfUtils.SetActive
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupRankingsRewardPopup.prefab > name: OverseaClubGvgGroupRankingsRewardPopup
---@class ClubGVGGroupRankingsRewardPopup
---@field Env                           	ClubGVGGroupRankingsRewardPopup         
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ClickClose                    	UnityEngine.RectTransform               	@ 0    
---@field BtnClose                      	UnityEngine.RectTransform               	@ 1    
---@field Root                          	UnityEngine.RectTransform               	@ 2    
---@field RewardList                    	SuperScrollView.LoopListView2           	@ 3    
---@field PopularityReward              	UnityEngine.RectTransform               	@ 4    
local ClubGVGGroupRankingsRewardPopup = Class('ClubGVGGroupRankingsRewardPopup')


function ClubGVGGroupRankingsRewardPopup:__init()
end


function ClubGVGGroupRankingsRewardPopup:__delete()
    self.controller = nil
end


-- function ClubGVGGroupRankingsRewardPopup:Awake()
-- end


-- function ClubGVGGroupRankingsRewardPopup:OnFocus(focus)

-- end


function ClubGVGGroupRankingsRewardPopup:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
        self:FreshUI()
    end))
    return coWait
end


function ClubGVGGroupRankingsRewardPopup:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end


function ClubGVGGroupRankingsRewardPopup:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function ClubGVGGroupRankingsRewardPopup:OnInit()
    self:InitData()
    self:InitAction()

end

function ClubGVGGroupRankingsRewardPopup:InitData()
    local parameters = self.controller.Argument.parameters
    local labelType  = parameters.labelType
    local ranking    = parameters.ranking
    local mgr        = ClubGVGUtils.GetMgr()
    ---@type ClubGVGHomeDojo
    local dojo       = mgr:GetHomeDojo()
    local group      =   dojo.group

    self._labelType = labelType
    self._ranking    = ranking
    self._dataList, self._popularityReward = ClubGVGUtils.GetRankingRewardDataList(group, labelType, ranking)
end

function ClubGVGGroupRankingsRewardPopup:InitAction()
    SetButtonAction(self.BtnClose, function () 
        CfUtils.DialogBack()
    end)


end

--endregion 


--region logic 

function ClubGVGGroupRankingsRewardPopup:FreshUI()
    self:FreshScrollView()
    self:FreshPopularityReward()
end

function ClubGVGGroupRankingsRewardPopup:FreshScrollView()
    local dataList   = self:GetDataList()
    if dataList == nil then return end
    
    local count      = #dataList
    local ScrollView = self.RewardList
    if not ScrollView.IsListViewInit then
        ScrollView:InitListView(count, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(ScrollView, count)
    end
end


function ClubGVGGroupRankingsRewardPopup:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(GVGConstants.Name.Cell)
    local node = GetLuaBehaviour(cell.gameObject, GVGConstants.LuaPath.ClubGVGGroupRankingsRewardNode)
    
    ---@type ClubGVGGroupRankingsRewardNode
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
        nodeEnv:FreshUI(data)

        if listView.DisplayItemNumber < listView.DisplayItemCount then
            nodeEnv:PlayDelayAnimByShow(listView.DisplayItemNumber)
            listView.DisplayItemNumber = listView.DisplayItemNumber + 1
        else
            nodeEnv:PlayAnimByIdle()
        end

    end

    return cell
end

function ClubGVGGroupRankingsRewardPopup:FreshPopularityReward()
    local data = self:GetPopularityReward()
    ---@type ClubGVGGroupRankingsRewardNode
    local env = CfUtils.GetLuaScr(self.PopularityReward, GVGConstants.LuaPath.ClubGVGGroupRankingsRewardNode)
    if isNotNull(env) then
        env:FreshUI(data)
        env:FreshTextDesc(self._labelType)
    end
end

--endregion 


--region get/set 

function ClubGVGGroupRankingsRewardPopup:GetDataList()
    return self._dataList
end

function ClubGVGGroupRankingsRewardPopup:GetPopularityReward()
    return self._popularityReward
end

---endregion 


--region handler 


---endregion 


return ClubGVGGroupRankingsRewardPopup
