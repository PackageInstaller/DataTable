
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type ClubGVGUtils
local ClubGVGUtils     = import('Game.UI.Club.GVG.ClubGVGUtils')
--endregion

--region define
local GVGConstants = ClubGVGUtils.Constants
local SetActive    = CfUtils.SetActive
local Name = "OverseaClubGvgGroupBaseDetailsPopupCell"
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupBaseDetailsPopup.prefab > name: BattleTeam
---@class ClubGVGGroupBuildingDetailsBattleTeam
---@field Env                           	ClubGVGGroupBuildingDetailsBattleTeam   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Empty                         	UnityEngine.RectTransform               	@ 0    
---@field PlayerHeadGroup               	SuperScrollView.LoopListView2           	@ 1    
---@field Area                          	UnityEngine.RectTransform               	@ 2    
local ClubGVGGroupBuildingDetailsBattleTeam = Class('ClubGVGGroupBuildingDetailsBattleTeam')

function ClubGVGGroupBuildingDetailsBattleTeam:__init()

end


function ClubGVGGroupBuildingDetailsBattleTeam:__delete()

end


-- function ClubGVGGroupBuildingDetailsBattleTeam:Awake()
-- end


function ClubGVGGroupBuildingDetailsBattleTeam:Start()
    SetButtonAction(self.Area, Bind(self, self.OnClickAreaAction))
end


function ClubGVGGroupBuildingDetailsBattleTeam:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function ClubGVGGroupBuildingDetailsBattleTeam:FreshUI(buildingFightingInfo, buildingType, labelType)
    self._labelType = labelType
    self._buildingFightingInfo = buildingFightingInfo
    local isEmpty = next(buildingFightingInfo) == nil
    self._buildingType = buildingType
    SetActive(self.Empty,   isEmpty)
    SetActive(self.PlayerHeadGroup, not isEmpty)
    if not isEmpty then
        local count = #buildingFightingInfo
        local ScrollView = self.PlayerHeadGroup
        if not ScrollView.IsListViewInit then
            ScrollView:InitListView(count, Bind(self, self.OnGetItemByIndex))
        else
            GameUtils.ReloadData(ScrollView, count)
        end

    end

end


function ClubGVGGroupBuildingDetailsBattleTeam:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(Name)
    local node = GetLuaBehaviour(cell.gameObject, GVGConstants.LuaPath.ClubGVGGroupBuildingDetailsBattleTeamCell)
    
    local nodeEnv = nil
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        ---@type ClubGVGGroupBuildingDetailsBattleTeamCell
        nodeEnv = node.Env
    else
        ---@type ClubGVGGroupBuildingDetailsBattleTeamCell
        nodeEnv = node.Env
    end

    if nodeEnv then
        local dataList = self._buildingFightingInfo
        local position = index + 1
        local data = dataList[position]
        nodeEnv:FreshUI(data, self._buildingType)
    end

    return cell
end


function ClubGVGGroupBuildingDetailsBattleTeam:UpdateCountDown(curSeconds)
    self.PlayerHeadGroup:DoActionForEachShownItem(function(cell) 
        self:UpdateCellCountDown(cell, curSeconds)
    end, nil)

end

function ClubGVGGroupBuildingDetailsBattleTeam:UpdateCellCountDown(cell, curSeconds)
    ---@type ClubGVGGroupBuildingDetailsBattleTeamCell
    local env = CfUtils.GetLuaScr(cell, GVGConstants.LuaPath.ClubGVGGroupBuildingDetailsBattleTeamCell)
    if isNull(env) then
        return
    end
    env:FreshCountdown(curSeconds)
end

--endregion 


--region get/set 

function ClubGVGGroupBuildingDetailsBattleTeam:SetCallback(callback)
    self._callback = callback
end

---endregion 


--region handler 

function ClubGVGGroupBuildingDetailsBattleTeam:OnClickAreaAction()
    print("OnClickAreaAction1")
    if self._callback then
        print("OnClickAreaAction2")
        self._callback(self._labelType)
    end
end

---endregion 


return ClubGVGGroupBuildingDetailsBattleTeam
