---
--- 社团大厅，第三人称摄像机
--- Author: dawanfan
--- Date: 2024-4-25 10:55:36
---


--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubPlayerController.prefab > name: 3rdPersonCamera
---@class OverseaClub3rdPersonVCam
---@field Env                           	OverseaClub3rdPersonVCam                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ViewRotateController          	UnityEngine.Transform                   	@ 0    
---@field VCamController                	UnityEngine.Transform                   	@ 1    
local OverseaClub3rdPersonVCam = Class("OverseaClub3rdPersonVCam")

function OverseaClub3rdPersonVCam:__init()
    ---@type OverseaClubViewRotateController
    self.rotateControllerScr = nil
    ---@type OverseaClubVCam3rdPersonFollowController
    self.vCamControllerScr = nil
end

function OverseaClub3rdPersonVCam:__delete()
    
end

function OverseaClub3rdPersonVCam:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
end

function OverseaClub3rdPersonVCam:Init(playerParams, follow, isUseManualViwRotateInPCMode)
    self.rotateControllerScr = CfUtils.GetLuaScr(self.ViewRotateController, "Game.UI.Club.Controller.OverseaClubViewRotateController")
    self.vCamControllerScr = CfUtils.GetLuaScr(self.VCamController, "Game.UI.Club.Controller.OverseaClubVCam3rdPersonFollowController")


    self.rotateControllerScr:Init(isUseManualViwRotateInPCMode)
    self.vCamControllerScr:Init(playerParams, follow)
end

function OverseaClub3rdPersonVCam:SetFollowTarget(target)
    self.vCamControllerScr:SetFollow(target)
end


return OverseaClub3rdPersonVCam
