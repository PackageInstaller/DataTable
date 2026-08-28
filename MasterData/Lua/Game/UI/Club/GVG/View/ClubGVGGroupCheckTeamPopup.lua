
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
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupEditTeamPopup.prefab > name: OverseaClubGvgGroupCheckTeamPopup
---@class ClubGVGGroupCheckTeamPopup
---@field Env                           	ClubGVGGroupCheckTeamPopup              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ClickArea                     	UnityEngine.RectTransform               	@ 0    
---@field Team                          	UnityEngine.RectTransform               	@ 1    
---@field FontStyleButton               	UnityEngine.RectTransform               	@ 2    
---@field BtnClose                      	UnityEngine.RectTransform               	@ 3    
local ClubGVGGroupCheckTeamPopup = Class('ClubGVGGroupCheckTeamPopup')


function ClubGVGGroupCheckTeamPopup:__init()
end


function ClubGVGGroupCheckTeamPopup:__delete()
    self.controller = nil
end


-- function ClubGVGGroupCheckTeamPopup:Awake()
-- end


function ClubGVGGroupCheckTeamPopup:OnFocus(focus)

end


function ClubGVGGroupCheckTeamPopup:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
        self:FreshUI()
    end))
    return coWait
end


-- function ClubGVGGroupCheckTeamPopup:OnShow()
--     ---@type Engine.Lib.CoWait
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

--     end))
--     return coWait
-- end


function ClubGVGGroupCheckTeamPopup:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function ClubGVGGroupCheckTeamPopup:OnInit()
    self:InitData()
    self:InitAction()
end

function ClubGVGGroupCheckTeamPopup:InitData()
    local parameters  = self.controller.Argument.parameters
    local playerId    = parameters.playerId

    ---@type ClubGVGMgr
    local mgr         = ClubGVGUtils.GetMgr()
    self._questId     = mgr:GetQuestId()

    self._teamMembers = ClubGVGUtils.GetPlayerTeamMembersById(playerId)
end

function ClubGVGGroupCheckTeamPopup:InitAction()
    SetButtonAction(self.BtnClose, Bind(self, self.OnClickBtnCloseAction))
    SetButtonAction(self.ClickArea, Bind(self, self.OnClickBtnCloseAction))
end

--endregion 



--region logic 

function ClubGVGGroupCheckTeamPopup:FreshUI()
    ---@type ClubGVGTeamGroup
    local env = self:GetTeamGroupEnv()
    if isNotNull(env) then
        env:FreshUI(self._teamMembers, false, self._questId)

    end

end

--endregion 


--region get/set 

---@return ClubGVGTeamGroup
function ClubGVGGroupCheckTeamPopup:GetTeamGroupEnv()
    if isNull(self._teamGroupEnv) then
        local env = CfUtils.GetLuaScr(self.Team, GVGConstants.LuaPath.ClubGVGTeamGroup)
        self._teamGroupEnv = env
    end
    return self._teamGroupEnv
end

---endregion 


--region handler 

function ClubGVGGroupCheckTeamPopup:OnClickBtnCloseAction()
    CfUtils.DialogBack()
end

---endregion 


return ClubGVGGroupCheckTeamPopup
