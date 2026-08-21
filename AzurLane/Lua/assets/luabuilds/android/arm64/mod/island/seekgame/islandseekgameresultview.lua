local var_0_0 = class("IslandSeekGameResultView", import("Mod.Island.Core.View.IslandASynLoadSubView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.uiName = arg_1_2

	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.GetUIName(arg_2_0)
	return arg_2_0.uiName
end

function var_0_0.FirstFlush(arg_3_0)
	arg_3_0.animation = arg_3_0._tf:GetComponent(typeof(Animation))

	local var_3_0 = arg_3_0._tf:GetComponent(typeof(DftAniEvent))

	setText(arg_3_0._tf:Find("Text"), i18n("island_seek_game_tip"))
	onButton(arg_3_0, arg_3_0._tf, function()
		if arg_3_0.clickableTime then
			if arg_3_0.clickableTime > pg.TimeMgr.GetInstance():GetServerTime() then
				return
			end
		end

		if arg_3_0.playAnimation then
			return
		end

		arg_3_0.playAnimation = true

		arg_3_0:GetView():RestartGame()
		arg_3_0.animation:Play("anim_IslandSeekGameUI_out")

		return
	end, SFX_PANEL)
	var_3_0:SetEndEvent(function(arg_5_0)
		arg_3_0:Hide()

		arg_3_0.playAnimation = false

		return
	end)

	arg_3_0.aniDft = var_3_0

	return
end

function var_0_0.Flush(arg_6_0)
	arg_6_0.animation:Play("anim_IslandSeekGameUI_in")

	arg_6_0.clickableTime = pg.island_set.seek_game_reset_cd.key_value_int + pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function var_0_0.OnDestroy(arg_7_0)
	if arg_7_0.aniDft then
		arg_7_0.aniDft:SetEndEvent(nil)
	end

	return
end

return var_0_0
