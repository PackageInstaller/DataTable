class = var_0_10000

local var_0_0 = "DOACharacterGiftPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CorePtTemplatePage"))
local var_0_2 = 7

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.AD = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.AD

	arg_1_0.task = var_1.Find(var_1_1, "task")

	local var_1_2 = arg_1_0.task

	arg_1_0.awardTF = var_1.Find(var_1_2, "award")

	local var_1_3 = arg_1_0.task

	arg_1_0.slider = var_1.Find(var_1_3, "slider")

	local var_1_4 = arg_1_0.task

	arg_1_0.friendText = var_1.Find(var_1_4, "friendText")

	local var_1_5 = arg_1_0.task

	arg_1_0.targetText = var_1.Find(var_1_5, "targetText")

	local var_1_6 = arg_1_0.AD

	arg_1_0.displayBtn = var_1.Find(var_1_6, "display_btn")

	local var_1_7 = arg_1_0.displayBtn

	arg_1_0.getAwardTxt = var_1.Find(var_1_7, "Text")
	UIItemList = var_1

	local var_1_8 = var_1.New
	local var_1_9 = arg_1_0.AD
	local var_1_10 = var_3.Find(var_1_9, "heart")
	local var_1_11 = arg_1_0.AD

	arg_1_0.hearts = var_1_8(var_1_10, var_4.Find(var_1_11, "heart/1"))

	local var_1_12 = arg_1_0.AD

	arg_1_0.btnGroup = var_1.Find(var_1_12, "btnGroup")

	local var_1_13 = arg_1_0.btnGroup

	arg_1_0.battleBtn = var_1.Find(var_1_13, "battle_btn")

	local var_1_14 = arg_1_0.btnGroup

	arg_1_0.getBtn = var_1.Find(var_1_14, "get_btn")

	local var_1_15 = arg_1_0.btnGroup

	arg_1_0.gotBtn = var_1.Find(var_1_15, "got_btn")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)
	arg_2_0:InitLocal()

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.battleBtn

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_3_1(var_3_0, var_2_10003.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	return
end

function var_0_1.InitLocal(arg_4_0)
	GetSpriteFromAtlas = var_1_10001
	arg_4_0.imgHeart = var_1_10001("ui/DOACharacterGiftPage_atlas", "heart")
	GetSpriteFromAtlas = var_1
	arg_4_0.imgHeratGreay = var_1("ui/DOACharacterGiftPage_atlas", "heart_greay")
	setText = var_1

	local var_4_0 = arg_4_0.friendText

	i18n = var_4

	var_1(var_4_0, var_4("doa3_activityPageUI_7"))

	setText = var_1

	local var_4_1 = arg_4_0.getAwardTxt

	i18n = var_4

	var_1(var_4_1, var_4("doa3_activityPageUI_6"))

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	arg_5_0:UpdateSlider()
	arg_5_0:UpdateBtnGroup()
	arg_5_0:UpdateAward()
	arg_5_0:UpdateHearts()

	return
end

function var_0_1.UpdateSlider(arg_6_0)
	local var_6_0 = arg_6_0.ptData
	local var_6_1, var_6_2, var_6_3 = var_1.GetResProgress(var_6_0)

	setText = var_1_10004

	var_1_10004(arg_6_0.targetText, "<color=#353c70>" .. var_6_1 .. "</color>" .. "/" .. "<color=#AEB7D0>" .. var_6_2 .. "</color>")

	setSlider = var_1_10004

	var_1_10004(arg_6_0.slider, 0, 1, var_6_3)

	return
end

function var_0_1.UpdateBtnGroup(arg_7_0)
	local var_7_0 = arg_7_0.ptData
	local var_7_1 = var_1.CanGetAward(var_7_0)
	local var_7_2 = arg_7_0.ptData
	local var_7_3 = var_2.CanGetNextAward(var_7_2)
	local var_7_4 = arg_7_0.ptData
	local var_7_5 = var_3.CanGetMorePt(var_7_4)

	setActive = var_7_2

	var_7_2(arg_7_0.battleBtn, var_7_5 and not var_7_1 and var_7_3)

	setActive = var_7_2

	var_7_2(arg_7_0.getBtn, var_7_1)

	setActive = var_7_2

	var_7_2(arg_7_0.gotBtn, not var_7_3)

	return
end

function var_0_1.UpdateHearts(arg_8_0)
	local var_8_0 = arg_8_0.hearts

	var_1.make(var_8_0, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			if arg_9_1 < arg_8_0.ptData.level then
				setImageSprite = var_3

				var_3(arg_9_2, arg_8_0.imgHeart)
			else
				setImageSprite = var_3

				var_3(arg_9_2, arg_8_0.imgHeratGreay)
			end
		end

		return
	end)

	local var_8_1 = arg_8_0.hearts

	var_1.align(var_8_1, var_0_2)

	return
end

function var_0_1.UpdateAward(arg_10_0)
	local var_10_0 = arg_10_0.ptData
	local var_10_1 = var_1.GetAward(var_10_0)

	updateDrop = var_1_10002

	var_1_10002(arg_10_0.awardTF, var_10_1)

	onButton = var_1_10002

	local var_10_2 = arg_10_0
	local var_10_3 = arg_10_0.awardTF

	local function var_10_4()
		local var_11_0 = arg_10_0
		local var_11_1 = var_0.emit

		BaseUI = var_2_10003

		var_11_1(var_11_0, var_2_10003.ON_DROP, var_10_1)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_10_2, var_10_3, var_10_4, var_1_10007)

	return
end

return var_0_1
