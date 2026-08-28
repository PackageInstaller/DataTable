
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

--- from: Assets/BundleResources/Prefabs/LadderSrtruggle/LadderStruggleRecordPopup.prefab > name: OverseaClubGvgGroupFightRecordDetailsPopup
---@class ClubGVGGroupFightRecordDetailsPopup
---@field Env                           	ClubGVGGroupFightRecordDetailsPopup     
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ClickClose                    	UnityEngine.RectTransform               	@ 0    
---@field TextName2                     	UnityEngine.UI.Text                     	@ 1    
---@field TextName1                     	UnityEngine.UI.Text                     	@ 2    
---@field LayoutTeam                    	UnityEngine.RectTransform               	@ 3    
local ClubGVGGroupFightRecordDetailsPopup = Class('ClubGVGGroupFightRecordDetailsPopup')


function ClubGVGGroupFightRecordDetailsPopup:__init()
end


function ClubGVGGroupFightRecordDetailsPopup:__delete()
    self.controller = nil
end


function ClubGVGGroupFightRecordDetailsPopup:Awake()
end


function ClubGVGGroupFightRecordDetailsPopup:OnFocus(focus)

end


function ClubGVGGroupFightRecordDetailsPopup:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
        self:RequestReport()
        while not self._isRequestSuccess do
            CoYield()
        end
    end))
    return coWait
end


function ClubGVGGroupFightRecordDetailsPopup:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end


function ClubGVGGroupFightRecordDetailsPopup:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self._ladderStruggleMgr:Clear()

        self:RemoveListeners()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function ClubGVGGroupFightRecordDetailsPopup:OnInit()
    self:InitData()
    self:InitAction()
    self:InitListeners()
end

function ClubGVGGroupFightRecordDetailsPopup:InitData()
    local parameters     = self.controller.Argument.parameters
    self._recordId       = parameters.recordId
    self._playerName     = parameters.playerName
    self._playerId       = parameters.playerId
    self._atPlayerName   = parameters.atPlayerName
    self._atPlayerId     = parameters.atPlayerId  
    self._isInClubView   = parameters.isInClubView  

    self._ladderStruggleMgr = import('Game.UI.UIBattling.LadderStruggle.LadderStruggleMgr')
    self._ladderStruggleMgr:Init()

    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()
    self._mgr = mgr

    self._teamNum = mgr:GetTeamNum()

end

function ClubGVGGroupFightRecordDetailsPopup:InitAction()

end

function ClubGVGGroupFightRecordDetailsPopup:InitListeners()
    self._listeners = CfUtils.EventsDecorated({
        [GVGConstants.EventNames.RequestSuccess] = Bind(self, self.OnRequestSuccess)
    })
end
function ClubGVGGroupFightRecordDetailsPopup:RemoveListeners()
    CfUtils.EventsUndecorated(self._listeners)
    self._listeners = nil
end


--endregion 


--region logic 

function ClubGVGGroupFightRecordDetailsPopup:RequestReport()
    if self._isInClubView then
        self._mgr:RequestReport2({id = self._recordId})
    else
        self._mgr:RequestReport({id = self._recordId})
    end
end

function ClubGVGGroupFightRecordDetailsPopup:FreshUI()
    self:FreshPlayerName()
    self:FreshTeamGroup()
end

function ClubGVGGroupFightRecordDetailsPopup:FreshPlayerName()
    self.TextName1.text = self._playerName
    self.TextName2.text = self._atPlayerName
    
end

function ClubGVGGroupFightRecordDetailsPopup:FreshTeamGroup()
    
    
    GameUtils.ResizeContent(self.LayoutTeam, self.LayoutTeam:GetChild(0), self._teamNum, function(luaIndex, childNode) 
        ---@type ClubGVGGroupFightRecordDetailsTeamNode
        local env = CfUtils.GetLuaScr(childNode, GVGConstants.LuaPath.ClubGVGGroupFightRecordDetailsTeamNode)
        if isNotNull(env) then
            local waveData = self._processedData[luaIndex]
            env:FreshUI(waveData, self._totalSessionCount, luaIndex, false,  self._playerId)
        end

    end)
end




--endregion 


--region get/set 

function ClubGVGGroupFightRecordDetailsPopup:GenerateTeam()
    -- local processedData = self._processedData
    -- for i, waveData in ipairs(processedData) do
    --     local playerTeamData, enemyTeamData = waveData.initData.playerTeam, waveData.initData.enemyTeam

    -- end

end

---endregion 


--region handler 
function ClubGVGGroupFightRecordDetailsPopup:OnRequestSuccess(interface, data)
    if interface == Interfaces.OverseaClubGVGReport or interface == Interfaces.OverseaClubGVGReport2 then
        self._questBattleData = data.questBattleData[1].recordData

        local ladderStruggleMgr = self._ladderStruggleMgr
        ladderStruggleMgr:SetLadderStruggleData(self._questBattleData, nil)
        ladderStruggleMgr:Preprocessing()

        self._processedData     = ladderStruggleMgr.struggleData
        self._totalSessionCount = ladderStruggleMgr.totalSessionCount
        
        self:FreshUI()
        self._isRequestSuccess = true
        
    end
end

---endregion 


return ClubGVGGroupFightRecordDetailsPopup
