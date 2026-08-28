
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type ClubGVGUtils
local ClubGVGUtils     = import('Game.UI.Club.GVG.ClubGVGUtils')
--endregion

--region define
local GVGConstants     = ClubGVGUtils.Constants
local SetActive                = CfUtils.SetActive
--endregion


--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupDefeatPlayerNode.prefab > name: OverseaClubGvgGroupDefeatPlayerNode
---@class ClubGVGGroupDefeatPlayerNode
---@field Env                           	ClubGVGGroupDefeatPlayerNode            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field OverseaClubGvgGroupHeadNode1  	UnityEngine.RectTransform               	@ 0    
---@field OverseaClubGvgGroupHeadNode2  	UnityEngine.RectTransform               	@ 1    
---@field ArrowNode                     	UnityEngine.RectTransform               	@ 2    
---@field DefeatNode                    	UnityEngine.RectTransform               	@ 3    
---@field TextDesc                      	Game.Native.Common.UISwitchText         	@ 4    
---@field Root                          	UnityEngine.Animation                   	@ 5    
local ClubGVGGroupDefeatPlayerNode = Class('ClubGVGGroupDefeatPlayerNode')

function ClubGVGGroupDefeatPlayerNode:__init()
    self._bannerDataList = {}
end


function ClubGVGGroupDefeatPlayerNode:__delete()

end


-- function ClubGVGGroupDefeatPlayerNode:Awake()
    
-- end


-- function ClubGVGGroupDefeatPlayerNode:Start()
-- end


function ClubGVGGroupDefeatPlayerNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---@param data {playerId:number, loseId:number, times:number}
---@param dataType ClubGVGConstants.BannerType
function ClubGVGGroupDefeatPlayerNode:FreshUI(data, dataType)
    table.insert(self._bannerDataList, 1, {data = data, dataType = dataType})

    if self._co then
        return
    end
    self._co = CoStart(function ()
        while #self._bannerDataList > 0 do
            self:ShowUI(data, dataType)
            while self.Root:IsPlaying(GVGConstants.AniName.OverseaClubGvgGroupDefeatPlayerNode_Entry) do
                CoYield()
            end
            table.remove(self._bannerDataList)
        end
        self._co = nil
    end)
end

function ClubGVGGroupDefeatPlayerNode:ShowUI(data, dataType)
    local mgr = ClubGVGUtils.GetMgr()
    local env = self:GetLeftPlayerHeadNodeEnv(self.OverseaClubGvgGroupHeadNode1)
    if isNotNull(env) then
        local playerInfoData = ClubGVGUtils.GetPlayerInfo(data.playerId)
        env:FreshUI(playerInfoData)
    end

    env = self:GetRightPlayerHeadNodeEnv(self.OverseaClubGvgGroupHeadNode2)
    if isNotNull(env) then
        local playerInfoData = ClubGVGUtils.GetPlayerInfo(data.loseId)
        env:FreshUI(playerInfoData)
    end

    local isAttack = dataType == GVGConstants.BannerType.AttackPlayer
    SetActive(self.ArrowNode, isAttack)
    SetActive(self.DefeatNode, not  isAttack)
    if not isAttack then
        local text
        if dataType == GVGConstants.BannerType.DefeatPlayer then
            self.TextDesc.text = localize("击败") 
        elseif dataType == GVGConstants.BannerType.WinningStreak then
            self.TextDesc.text = localize("_num_连胜", {_num_ = data.times}) 
        elseif dataType == GVGConstants.BannerType.KillWinningStreak then
            self.TextDesc.text = localize("终结") 

        end
    end

    self.Root:Play(GVGConstants.AniName.OverseaClubGvgGroupDefeatPlayerNode_Entry)

    
end

--endregion 


--region get/set 

---@return ClubGVGGroupHeadNode
function ClubGVGGroupDefeatPlayerNode:GetLeftPlayerHeadNodeEnv(node)
    if isNull(self._leftHeadNodeEnv) then
        self._leftHeadNodeEnv = CfUtils.GetLuaScr(node, GVGConstants.LuaPath.ClubGVGGroupHeadNode)
    end
    return self._leftHeadNodeEnv
end

function ClubGVGGroupDefeatPlayerNode:GetRightPlayerHeadNodeEnv(node)
    if isNull(self._rightHeadNodeEnv) then
        self._rightHeadNodeEnv = CfUtils.GetLuaScr(node, GVGConstants.LuaPath.ClubGVGGroupHeadNode)
    end
    return self._rightHeadNodeEnv
end


---endregion 


--region handler 


---endregion 


return ClubGVGGroupDefeatPlayerNode
