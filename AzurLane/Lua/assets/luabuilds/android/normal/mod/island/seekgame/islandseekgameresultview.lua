class = var_0_10000

local var_0_0 = "IslandSeekGameResultView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.Core.View.IslandASynLoadSubView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.uiName = arg_1_2

	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.GetUIName(arg_2_0)
	return arg_2_0.uiName
end

function var_0_1.FirstFlush(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.GetComponent

	typeof = var_1_10003
	Animation = var_1_10004
	arg_3_0.animation = var_3_1(var_3_0, var_1_10003(var_1_10004))

	local var_3_2 = arg_3_0._tf
	local var_3_3 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004

	local var_3_4 = var_3_3(var_3_2, var_3(var_1_10004))

	setText = var_3_2

	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_3.Find(var_3_5, "Text")

	i18n = var_3_5

	var_3_2(var_3_6, var_3_5("island_seek_game_tip"))

	onButton = var_3_2

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0._tf

	local function var_3_9()
		if arg_3_0.clickableTime then
			local var_4_0 = arg_3_0.clickableTime

			pg = var_2_10001

			local var_4_1 = var_2_10001.TimeMgr.GetInstance()

			if var_4_0 > var_1.GetServerTime(var_4_1) then
				return
			end
		end

		if arg_3_0.playAnimation then
			return
		end

		arg_3_0.playAnimation = true

		local var_4_2 = arg_3_0
		local var_4_3 = var_0.GetView(var_4_2)

		var_0.RestartGame(var_4_3)

		local var_4_4 = arg_3_0.animation

		var_0.Play(var_4_4, "anim_IslandSeekGameUI_out")

		return
	end

	SFX_PANEL = var_1_10006

	var_3_2(var_3_7, var_3_8, var_3_9, var_1_10006)
	var_3_4:SetEndEvent(function(arg_5_0)
		local var_5_0 = arg_3_0

		var_1.Hide(var_5_0)

		arg_3_0.playAnimation = false

		return
	end)

	arg_3_0.aniDft = var_3_4

	return
end

function var_0_1.Flush(arg_6_0)
	local var_6_0 = arg_6_0.animation

	var_1.Play(var_6_0, "anim_IslandSeekGameUI_in")

	pg = var_1

	local var_6_1 = var_1.island_set.seek_game_reset_cd.key_value_int

	pg = var_6_0

	local var_6_2 = var_6_0.TimeMgr.GetInstance()

	arg_6_0.clickableTime = var_6_1 + var_2.GetServerTime(var_6_2)

	return
end

function var_0_1.OnDestroy(arg_7_0)
	if arg_7_0.aniDft then
		local var_7_0 = arg_7_0.aniDft

		var_1.SetEndEvent(var_7_0, nil)
	end

	return
end

return var_0_1
