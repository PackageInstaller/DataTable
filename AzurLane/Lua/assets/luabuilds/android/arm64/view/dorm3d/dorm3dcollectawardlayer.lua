class = var_0_10000

local var_0_0 = "Dorm3dCollectAwardLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dCollectAwardUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0 = var_1_10002.dorm3d_collection_template[arg_2_0.contextData.itemId]

	GetSpriteFromAtlasAsync = var_3

	var_3("dorm3dcollection/" .. var_2_0.icon, "", function(arg_3_0)
		arg_2_0.iconSprite = arg_3_0

		arg_2_1()

		return
	end)

	return
end

function var_0_1.init(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_4.Find(var_4_1, "bg")

	local function var_4_3()
		if arg_4_0.isBlock then
			return
		end

		local var_5_0 = arg_4_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_4_1

	var_1_10001(var_4_0, var_4_2, var_4_3, var_4_1)

	arg_4_0.isBlock = true
	pg = var_1

	local var_4_4 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_4_4, arg_4_0._tf)

	return
end

function var_0_1.onBackPressed(arg_6_0)
	if arg_6_0.isBlock then
		return
	end

	var_0_1.super.onBackPressed(arg_6_0)

	return
end

function var_0_1.didEnter(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.dorm3d_collection_template[arg_7_0.contextData.itemId]

	setText = var_2

	local var_7_1 = arg_7_0._tf

	var_2(var_4.Find(var_7_1, "panel/name/Text"), var_7_0.name)

	setText = var_2

	local var_7_2 = arg_7_0._tf

	var_2(var_4.Find(var_7_2, "panel/desc/content/desc"), var_7_0.desc)

	local var_7_3

	if var_7_0.award > 0 then
		pg = var_7_3
		var_7_3 = var_7_3.dorm3d_favor_trigger[var_7_0.award].num
		setText = var_3

		local var_7_4 = arg_7_0._tf
		local var_7_5 = var_5.Find(var_7_4, "panel/favor/Text")

		i18n = var_7_2

		var_3(var_7_5, var_7_2("dorm3d_collect_favor_plus") .. var_7_3)

		setActive = var_3

		local var_7_6 = arg_7_0._tf

		var_3(var_5.Find(var_7_6, "panel/favor"), arg_7_0.contextData.isNew)
	else
		setActive = var_7_3

		local var_7_7 = arg_7_0._tf

		var_7_3(var_4.Find(var_7_7, "panel/favor"), false)
	end

	setImageSprite = var_7_3

	local var_7_8 = arg_7_0._tf

	var_7_3(var_4.Find(var_7_8, "panel/icon"), arg_7_0.iconSprite, true)

	LeanTween = var_7_3

	local var_7_9 = var_7_3.delayedCall
	local var_7_10 = 1.5

	System = var_5

	var_7_9(var_7_10, var_5.Action(function()
		arg_7_0.isBlock = false

		return
	end))

	return
end

function var_0_1.willExit(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0._tf)

	return
end

return var_0_1
