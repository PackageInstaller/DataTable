local HomeSceneViewCfg = require("game.config.HomeSceneViewCfg")
local PosterDlcDebutState = class("PosterDlcDebutState", PosterDlcTimelineState)

local function var_0_2(arg_1_0)
	return nullable(HomeSceneViewCfg, nullable(HomeSceneViewCfg.get_id_list_by_scene_id_view, HomeSceneSettingData:GetCurScene(), arg_1_0, 1), "special_debut")
end

function PosterDlcDebutState:Ctor(arg_2_1)
	PosterDlcDebutState.super.Ctor(self, arg_2_1)
end

function PosterDlcDebutState:Enter()
	PosterDlcDebutState.super.Enter(self)
	self.actor:BeforeDebut()
	self.actor:SetSelfCamera(-1)
	self:PlayAniWithParams(var_0_2((self.actor:GetViewDirect())) or "debut")
end

function PosterDlcDebutState:Exit(arg_4_1)
	PosterDlcDebutState.super.Exit(self, arg_4_1)
	HomeSceneSettingData:SetIsPlay((self.actor:GetSkinId()))
	manager.notify:CallUpdateFunc(HOME_DEBUT_OVER)
	self.actor:SetSelfCamera(0)
	self.actor:AfterDebut()
end

return PosterDlcDebutState
