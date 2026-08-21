local var_0_0 = class("LevelAwardPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("bg")
	arg_1_0.award = arg_1_0._tf:Find("scroll/award")
	arg_1_0.content = arg_1_0._tf:Find("scroll/content")
	arg_1_0.scrollTF = arg_1_0._tf:Find("scroll")
	arg_1_0.pageSignDownTF = arg_1_0._tf:Find("sign")
	arg_1_0.pageSignUpTF = arg_1_0._tf:Find("sign_up")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.config = pg.activity_level_award[arg_2_0.activity:getConfig("config_id")]

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	setActive(arg_3_0.award, false)

	for iter_3_0 = 1, #arg_3_0.config.front_drops do
		local var_3_0 = arg_3_0.config.front_drops[iter_3_0][1]
		local var_3_1 = cloneTplTo(arg_3_0.award, arg_3_0.content, "award" .. tostring(iter_3_0))
		local var_3_2 = var_3_1:Find("limit_label/labelLevel")
		local var_3_3 = var_3_1:Find("btnAchieve")
		local var_3_4 = var_3_1:Find("items")
		local var_3_5 = var_3_1:Find("item")

		setActive(var_3_5, false)
		GetImageSpriteFromAtlasAsync("ui/activityuipage/level_award_atlas", tostring(arg_3_0.config.front_drops[iter_3_0][1]), var_3_2, true)

		for iter_3_1 = 2, #arg_3_0.config.front_drops[iter_3_0] do
			local var_3_6 = cloneTplTo(var_3_5, var_3_4)

			updateDrop(var_3_6, {
				type = arg_3_0.config.front_drops[iter_3_0][iter_3_1][1],
				id = arg_3_0.config.front_drops[iter_3_0][iter_3_1][2],
				count = arg_3_0.config.front_drops[iter_3_0][iter_3_1][3]
			})
			onButton(arg_3_0, var_3_6, function()
				arg_3_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end

		onButton(arg_3_0, var_3_3, function()
			arg_3_0:emit(ActivityMediator.EVENT_OPERATION, {
				cmd = 1,
				activity_id = arg_3_0.activity.id,
				arg1 = var_3_0
			})

			return
		end, SFX_PANEL)
		onScroll(arg_3_0, arg_3_0.scrollTF, function(arg_6_0)
			setActive(arg_3_0.pageSignDownTF, arg_6_0.y > 0.01)
			setActive(arg_3_0.pageSignUpTF, arg_6_0.y < 0.99)

			return
		end)
	end

	return
end

function var_0_0.OnUpdateFlush(arg_7_0)
	for iter_7_0 = 1, #arg_7_0.config.front_drops do
		local var_7_0 = arg_7_0.config.front_drops[iter_7_0]
		local var_7_1 = arg_7_0.content:Find("award" .. tostring(iter_7_0))
		local var_7_2 = var_7_1:Find("btnAchieve")
		local var_7_3 = var_7_1:Find("achieve_sign")
		local var_7_4 = _.include(arg_7_0.activity.data1_list, arg_7_0.config.front_drops[iter_7_0][1])

		if var_7_4 then
			var_7_1.transform:SetAsLastSibling()
		end

		setGray(var_7_1:Find("limit_label"), var_7_4)
		setGray(var_7_1:Find("items"), var_7_4)
		setActive(var_7_3, var_7_4)
		setActive(var_7_2, arg_7_0.shareData.player.level >= var_7_0[1] and not var_7_4)
	end

	return
end

function var_0_0.OnDestroy(arg_8_0)
	return
end

return var_0_0
