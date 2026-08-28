
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
local GVGConstants     = ClubGVGUtils.Constants
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupEditTeamPopup.prefab > name: OverseaClubGvgGroupEditTeamPopup
---@class ClubGVGGroupEditTeamPopup
---@field Env                           	ClubGVGGroupEditTeamPopup               
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BlockArea                     	UnityEngine.RectTransform               	@ 0    
---@field Team                          	UnityEngine.RectTransform               	@ 1    
---@field FontStyleButton               	UnityEngine.RectTransform               	@ 2    
local ClubGVGGroupEditTeamPopup = Class('ClubGVGGroupEditTeamPopup')


function ClubGVGGroupEditTeamPopup:__init()
end


function ClubGVGGroupEditTeamPopup:__delete()
    self.controller = nil
end


function ClubGVGGroupEditTeamPopup:Awake()
end


function ClubGVGGroupEditTeamPopup:OnFocus(focus)
    if focus then
        URPCameraController:SetMainCameraActive(false)
        Events.Broadcast(GVGConstants.EventNames.ControlBuildingEff, true)
    end
end


function ClubGVGGroupEditTeamPopup:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
        self:FreshUI()
    end))
    return coWait
end


-- function ClubGVGGroupEditTeamPopup:OnShow()
--     ---@type Engine.Lib.CoWait
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
--         GameUtils.HidePreviousDialogs(self.controller)
--     end))
--     return coWait
-- end

-- function ClubGVGGroupEditTeamPopup:OnHide()
--     ---@type Engine.Lib.CoWait
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
--         GameUtils.ShowPreviousDialogs()
--     end))
--     return coWait
-- end


function ClubGVGGroupEditTeamPopup:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function ClubGVGGroupEditTeamPopup:OnInit()
    self:InitData()
    self:InitAction()
end

function ClubGVGGroupEditTeamPopup:InitData()
    ---@type ClubGVGMgr
    local mgr         = ClubGVGUtils.GetMgr()
    self._questId     = mgr:GetQuestId()
    self._teamMembers = mgr:GetPlayerTeamMembers()
    -- print("self._teamMembers", table.toString(self._teamMembers))
end

function ClubGVGGroupEditTeamPopup:InitAction()
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickSaveTeamBtnAction))
end

--endregion 


--region logic 

function ClubGVGGroupEditTeamPopup:FreshUI()
    ---@type ClubGVGTeamGroup
    local env = self:GetTeamGroupEnv()
    if isNotNull(env) then
        env:FreshUI(self._teamMembers, true, self._questId)

    end

end

--endregion 


--region get/set 

---@return ClubGVGTeamGroup
function ClubGVGGroupEditTeamPopup:GetTeamGroupEnv()
    if isNull(self._teamGroupEnv) then
        local env = CfUtils.GetLuaScr(self.Team, GVGConstants.LuaPath.ClubGVGTeamGroup)
        self._teamGroupEnv = env
    end
    return self._teamGroupEnv
end

---endregion 


--region handler 

function ClubGVGGroupEditTeamPopup:OnClickSaveTeamBtnAction()
    ---@type ClubGVGMgr
    local mgr         = ClubGVGUtils.GetMgr()
    mgr:RequestSaveTeam()

    CfUtils.DialogBack()

end

---endregion 


return ClubGVGGroupEditTeamPopup
