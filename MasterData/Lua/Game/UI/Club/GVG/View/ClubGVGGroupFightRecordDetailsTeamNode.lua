
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import

--endregion

--region define
local SetActive = CfUtils.SetActive

local UITeamMembersNodeLuaPath = "Game.UI.FightTeam.UITeamMembersNode.UITeamMembersNode"

local BattleResult = {
    None = 0,       -- 默认状态
    Win = 1,        -- 胜利
    Lose = 2,       -- 失败
    Skip = 3,       -- 未进行
}
--endregion

--- from: Assets/BundleResources/Prefabs/LadderSrtruggle/LadderStruggleRecordPopup.prefab > name: TeamNode1
---@class ClubGVGGroupFightRecordDetailsTeamNode
---@field Env                           	ClubGVGGroupFightRecordDetailsTeamNode  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BtnVideo                      	UnityEngine.UI.Button                   	@ 0    
---@field NotStruggle                   	UnityEngine.RectTransform               	@ 1    
---@field TextDesc                      	Game.Native.Common.UISwitchText         	@ 2    
---@field UITeamMembersNode2            	UnityEngine.RectTransform               	@ 3    
---@field UITeamMembersNode             	UnityEngine.RectTransform               	@ 4    
---@field ImgResult                     	Game.Native.Common.UISwitchImage        	@ 5    
local ClubGVGGroupFightRecordDetailsTeamNode = Class('ClubGVGGroupFightRecordDetailsTeamNode')

function ClubGVGGroupFightRecordDetailsTeamNode:__init()

end


function ClubGVGGroupFightRecordDetailsTeamNode:__delete()

end


function ClubGVGGroupFightRecordDetailsTeamNode:Awake()
    SetActive(self.BtnVideo, false)

end


function ClubGVGGroupFightRecordDetailsTeamNode:Start()
    SetButtonAction(self.BtnVideo, Bind(self, self.ReplayBattle))
end


function ClubGVGGroupFightRecordDetailsTeamNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function ClubGVGGroupFightRecordDetailsTeamNode:FreshUI(waveData, totalSessionCount, luaIndex, isEnabledVideo, playerId)
    self._waveData = waveData
    self._isEnabledVideo = isEnabledVideo == true
    local initData = waveData.initData
    self:FreshTeamNodes(initData, playerId)
    self:FreshTeamBattleResult(waveData, totalSessionCount, luaIndex, playerId)

end

function ClubGVGGroupFightRecordDetailsTeamNode:FreshTeamNodes(initData, playerId)
    local playerTeam, enemyTeam = initData.playerTeam, initData.enemyTeam
    local isPlayer = checkNumber(initData.selfId) == playerId
    local playerTeam1 = isPlayer and playerTeam or enemyTeam
    local enemyTeam1  = isPlayer and enemyTeam or playerTeam
    self:FreshTeamNode(self:GetTeamNodeEnv1(), self:GenerateTeamData(playerTeam1[1]))
    self:FreshTeamNode(self:GetTeamNodeEnv2(), self:GenerateTeamData(enemyTeam1[1]))

end

---@param env UITeamMembersNode
function ClubGVGGroupFightRecordDetailsTeamNode:FreshTeamNode(env, data)
    if isNull(env) then
        return
    end
    -- print("data", table.toString(data))
    env:RefreshCardCustom(data, 1)

end

function ClubGVGGroupFightRecordDetailsTeamNode:GenerateTeamData(teamInfo)
    local teamData = {}
    local team     = teamInfo or {}
    for i, cardInfo in ipairs(team) do
        local cardData = {
            cardId       = cardInfo.cardId,
            advanceLevel = cardInfo.advanceLevel,
            star         = cardInfo.star,
            cardLevel    = cardInfo.level,
        }
        table.insert(teamData, cardData)
    end
    return teamData
end

function ClubGVGGroupFightRecordDetailsTeamNode:FreshTeamBattleResult(waveData, totalSessionCount, luaIndex, myId)
    if luaIndex > totalSessionCount then
        self:FreshStateUI(BattleResult.Skip)
    else
         -- 作为防守方时，initData中的selfId是对方的id，战报中的aliveData和winState要翻转
         local isMyL = checkNumber(waveData.initData.selfId) == myId
         if not isNull(waveData.aliveData) then
             if isMyL then
                 self:FreshCardAliveState(waveData.aliveData.L, waveData.aliveData.R)
             else
                 self:FreshCardAliveState(waveData.aliveData.R, waveData.aliveData.L)
             end
         end
         local winState = waveData.win == true and 1 or 2
         if isMyL then
             self:FreshStateUI( winState)
         else
             self:FreshStateUI( 3 - winState)
         end
         
    end
end

--- 设置对决状态
---@param state number
function ClubGVGGroupFightRecordDetailsTeamNode:FreshStateUI(state)
    SetActive(self.TextDesc, false)
    SetActive(self.NotStruggle, false)
    if state == BattleResult.Win then
        SetActive(self.TextDesc, true)
        SetActive(self.ImgResult, true)
        self.TextDesc.Status = 1
        self.ImgResult.Status = 1
        SetActive(self.BtnVideo, self._isEnabledVideo)
    elseif state == BattleResult.Lose then
        SetActive(self.ImgResult, true)
        SetActive(self.TextDesc, true)
        self.TextDesc.Status = 2
        self.ImgResult.Status = 2
        SetActive(self.BtnVideo, self._isEnabledVideo)
    elseif state == BattleResult.Skip then
        SetActive(self.NotStruggle, true)
        SetActive(self.ImgResult, false)
        -- self.ImgResult.Status = 2
        SetActive(self.BtnVideo, false)
        
    end
end

function ClubGVGGroupFightRecordDetailsTeamNode:FreshCardAliveState(aliveDataL, aliveDataR)
    local env = self:GetTeamNodeEnv1()
    if isNotNull(env) then
        env:FillCardAliveState(aliveDataL)
    end
    env = self:GetTeamNodeEnv2()
    if isNotNull(env) then
        env:FillCardAliveState(aliveDataR)
    end
end

--endregion 


--region get/set 

---@return UITeamMembersNode
function ClubGVGGroupFightRecordDetailsTeamNode:GetTeamNodeEnv1()
    if isNull(self._teamNodeEnv1) then
        self._teamNodeEnv1 = CfUtils.GetLuaScr(self.UITeamMembersNode, UITeamMembersNodeLuaPath)
    end
    return self._teamNodeEnv1
end

---@return UITeamMembersNode
function ClubGVGGroupFightRecordDetailsTeamNode:GetTeamNodeEnv2()
    if isNull(self._teamNodeEnv2) then
        self._teamNodeEnv2 = CfUtils.GetLuaScr(self.UITeamMembersNode2, UITeamMembersNodeLuaPath)
    end
    return self._teamNodeEnv2
end

---endregion 


--region handler 
--- 播放录像
function ClubGVGGroupFightRecordDetailsTeamNode:ReplayBattle()
    FightPreWarMgr:GetInstance():FightReplay(table.serialize(self._waveData))
end

---endregion 


return ClubGVGGroupFightRecordDetailsTeamNode
