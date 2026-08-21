local var_0_0 = class("DOACharacterGiftPage", import("view.activity.CorePage.CorePtTemplatePage"))
local var_0_1 = 7

function var_0_0.OnInit(arg_1_0)
	arg_1_0.AD = arg_1_0._tf:Find("AD")
	arg_1_0.task = arg_1_0.AD:Find("task")
	arg_1_0.awardTF = arg_1_0.task:Find("award")
	arg_1_0.slider = arg_1_0.task:Find("slider")
	arg_1_0.friendText = arg_1_0.task:Find("friendText")
	arg_1_0.targetText = arg_1_0.task:Find("targetText")
	arg_1_0.displayBtn = arg_1_0.AD:Find("display_btn")
	arg_1_0.getAwardTxt = arg_1_0.displayBtn:Find("Text")
	arg_1_0.hearts = UIItemList.New(arg_1_0.AD:Find("heart"), arg_1_0.AD:Find("heart/1"))
	arg_1_0.btnGroup = arg_1_0.AD:Find("btnGroup")
	arg_1_0.battleBtn = arg_1_0.btnGroup:Find("battle_btn")
	arg_1_0.getBtn = arg_1_0.btnGroup:Find("get_btn")
	arg_1_0.gotBtn = arg_1_0.btnGroup:Find("got_btn")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	arg_2_0:InitLocal()
	onButton(arg_2_0, arg_2_0.battleBtn, function()
		arg_2_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.InitLocal(arg_4_0)
	arg_4_0.imgHeart = GetSpriteFromAtlas("ui/DOACharacterGiftPage_atlas", "heart")
	arg_4_0.imgHeratGreay = GetSpriteFromAtlas("ui/DOACharacterGiftPage_atlas", "heart_greay")

	setText(arg_4_0.friendText, i18n("doa3_activityPageUI_7"))
	setText(arg_4_0.getAwardTxt, i18n("doa3_activityPageUI_6"))

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	arg_5_0:UpdateSlider()
	arg_5_0:UpdateBtnGroup()
	arg_5_0:UpdateAward()
	arg_5_0:UpdateHearts()

	return
end

function var_0_0.UpdateSlider(arg_6_0)
	local var_6_0, var_6_1, var_6_2 = arg_6_0.ptData:GetResProgress()

	setText(arg_6_0.targetText, "<color=#353c70>" .. var_6_0 .. "</color>" .. "/" .. "<color=#AEB7D0>" .. var_6_1 .. "</color>")
	setSlider(arg_6_0.slider, 0, 1, var_6_2)

	return
end

function var_0_0.UpdateBtnGroup(arg_7_0)
	local var_7_0 = arg_7_0.ptData:CanGetAward()
	local var_7_1 = arg_7_0.ptData:CanGetNextAward()

	setActive(arg_7_0.battleBtn, arg_7_0.ptData:CanGetMorePt() and not var_7_0 and var_7_1)
	setActive(arg_7_0.getBtn, var_7_0)
	setActive(arg_7_0.gotBtn, not var_7_1)

	return
end

function var_0_0.UpdateHearts(arg_8_0)
	arg_8_0.hearts:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			if arg_9_1 < arg_8_0.ptData.level then
				setImageSprite(arg_9_2, arg_8_0.imgHeart)
			else
				setImageSprite(arg_9_2, arg_8_0.imgHeratGreay)
			end
		end

		return
	end)
	arg_8_0.hearts:align(var_0_1)

	return
end

function var_0_0.UpdateAward(arg_10_0)
	updateDrop(arg_10_0.awardTF, (arg_10_0.ptData:GetAward()))
	onButton(arg_10_0, arg_10_0.awardTF, function()
		arg_10_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	return
end

return var_0_0
