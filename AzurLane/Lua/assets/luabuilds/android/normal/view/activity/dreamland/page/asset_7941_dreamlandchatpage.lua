class = var_0_10000

local var_0_0 = "DreamlandChatPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "DreamlandChatUI"
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_1.super.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	arg_2_0.uiList = {
		arg_2_1:Find("adapt/time"),
		arg_2_1:Find("adapt/handbook"),
		arg_2_1:Find("adapt/hotspring")
	}
	arg_2_0.toHideUI = {}

	return
end

function var_0_1.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "icon")
	local var_3_2 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_3_0.icon = var_3_2(var_3_1, var_3(var_1_10004))

	local var_3_3 = arg_3_0._tf
	local var_3_4 = var_1.Find(var_3_3, "Text")
	local var_3_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.content = var_3_5(var_3_4, var_3(var_1_10004))

	return
end

function var_0_1.OnInit(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf

	local function var_4_2()
		if arg_4_0.clickCnt < arg_4_0.totlalCnt then
			local var_5_0 = arg_4_0

			var_0.ShowContent(var_5_0)
		else
			local var_5_1 = arg_4_0

			var_0.Hide(var_5_1)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1)
	var_0_1.super.Show(arg_6_0)

	arg_6_0.clickCnt = 0
	_ = var_2
	arg_6_0.textList = var_2.flatten(arg_6_1.desc)
	arg_6_0.totlalCnt = #arg_6_0.textList

	arg_6_0:ShowContent()

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.GetPic(var_6_0, arg_6_1)

	LoadSprite = var_6_0

	local var_6_2 = var_6_0("exploreObj/icon_" .. var_6_1)

	arg_6_0.icon.sprite = var_6_2

	local var_6_3 = arg_6_0.icon

	var_4.SetNativeSize(var_6_3)
	arg_6_0:HideUI()

	return
end

function var_0_1.ShowContent(arg_7_0)
	arg_7_0.clickCnt = arg_7_0.clickCnt + 1

	local var_7_0

	if not arg_7_0.textList[arg_7_0.clickCnt] then
		var_7_0 = ""
	end

	local var_7_1 = arg_7_0.content

	HXSet = var_1_10003
	var_7_1.text = var_1_10003.hxLan(var_7_0)

	return
end

function var_0_1.HideUI(arg_8_0)
	arg_8_0.toHideUI = {}
	ipairs = var_1

	for iter_8_0, iter_8_1 in var_1(arg_8_0.uiList) do
		isActive = var_1_10006

		if var_1_10006(iter_8_1) then
			setActive = var_1_10006

			var_1_10006(iter_8_1, false)

			table = var_1_10006

			var_1_10006.insert(arg_8_0.toHideUI, iter_8_1)
		end
	end

	return
end

function var_0_1.ShowUI(arg_9_0)
	ipairs = var_1_10001

	local var_9_0

	if not arg_9_0.toHideUI then
		var_9_0 = {}
	end

	for iter_9_0, iter_9_1 in var_1_10001(var_9_0) do
		isActive = var_1_10006

		if not var_1_10006(iter_9_1) then
			setActive = var_1_10006

			var_1_10006(iter_9_1, true)
		end
	end

	arg_9_0.toHideUI = {}

	return
end

function var_0_1.Hide(arg_10_0)
	var_0_1.super.Hide(arg_10_0)

	arg_10_0.textList = {}
	arg_10_0.clickCnt = 0
	arg_10_0.totlalCnt = 0

	arg_10_0:ShowUI()

	return
end

function var_0_1.GetPic(arg_11_0, arg_11_1)
	pg = var_1_10002

	local var_11_0

	if not var_1_10002.activity_dreamland_explore.get_id_list_by_group[arg_11_1.group] then
		var_11_0 = {}
	end

	local var_11_1

	if not var_11_0[1] then
		var_11_1 = arg_11_1.id
	end

	pg = var_1_10005

	return var_1_10005.activity_dreamland_explore[var_11_1].pic
end

function var_0_1.OnDestroy(arg_12_0)
	return
end

return var_0_1
