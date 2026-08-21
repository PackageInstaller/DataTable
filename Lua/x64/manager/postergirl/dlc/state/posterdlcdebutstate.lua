local var_0_0 = require("game.config.HomeSceneViewCfg")
local var_0_1 = class("PosterDlcDebutState", PosterDlcTimelineState)

local function var_0_2(arg_1_0)
	local var_1_0 = HomeSceneSettingData:GetCurScene()
	local var_1_1 = nullable(var_0_0.get_id_list_by_scene_id_view, var_1_0, arg_1_0, 1)

	return nullable(var_0_0, var_1_1, "special_debut")
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	var_0_1.super.Ctor(arg_2_0, arg_2_1)
end

function var_0_1.Enter(arg_3_0)
	var_0_1.super.Enter(arg_3_0)
	arg_3_0.actor:BeforeDebut()
	arg_3_0.actor:SetSelfCamera(-1)

	local var_3_0 = arg_3_0.actor:GetViewDirect()
	local var_3_1 = var_0_2(var_3_0) or "debut"

	arg_3_0:PlayAniWithParams(var_3_1)
end

function var_0_1.Exit(arg_4_0, arg_4_1)
	var_0_1.super.Exit(arg_4_0, arg_4_1)

	local var_4_0 = arg_4_0.actor:GetSkinId()

	HomeSceneSettingData:SetIsPlay(var_4_0)
	manager.notify:CallUpdateFunc(HOME_DEBUT_OVER)
	arg_4_0.actor:SetSelfCamera(0)
	arg_4_0.actor:AfterDebut()
end

return var_0_1
