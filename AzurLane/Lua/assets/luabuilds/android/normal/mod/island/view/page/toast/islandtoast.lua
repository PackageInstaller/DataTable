class = var_0_10000

local var_0_0 = "IslandToast"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.TYPE_COMMON = 1
var_0_1.TYPE_STATE = 2

function var_0_1.getUIName(arg_1_0)
	return "IslandToastUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.container = var_1.Find(var_2_0, "content")

	local var_2_1 = arg_2_0._tf

	arg_2_0.tpl = var_1.Find(var_2_1, "new")
	arg_2_0.hideTime = 3

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.tasks = {}
	arg_3_0.pools = {}

	return
end

function var_0_1.Show(arg_4_0, arg_4_1)
	var_0_1.super.Show(arg_4_0)

	table = var_2

	var_2.insert(arg_4_0.tasks, arg_4_1)
	arg_4_0:SetUp()

	return
end

function var_0_1.SetUp(arg_5_0)
	if #arg_5_0.tasks == 1 then
		arg_5_0:NextOne()
	end

	return
end

function var_0_1.NewTpl(arg_6_0)
	local var_6_0

	if #arg_6_0.pools == 0 then
		cloneTplTo = var_2
		var_6_0 = var_2(arg_6_0.tpl, arg_6_0.container)
	else
		table = var_2
		var_6_0 = var_2.remove(arg_6_0.pools, #arg_6_0.pools)
		setParent = var_2

		var_2(var_6_0, arg_6_0.container)
	end

	setActive = var_2

	var_2(var_6_0, true)

	return var_6_0
end

function var_0_1.ReturnTpl(arg_7_0, arg_7_1)
	setActive = var_1_10002

	var_1_10002(arg_7_1, false)

	table = var_1_10002

	var_1_10002.insert(arg_7_0.pools, arg_7_1)

	return
end

function var_0_1.NextOne(arg_8_0)
	if #arg_8_0.tasks <= 0 then
		arg_8_0:Hide()

		return
	end

	local var_8_0 = arg_8_0.tasks[1]
	local var_8_1 = arg_8_0
	local var_8_2 = arg_8_0.NewTpl(var_8_1)

	setActive = var_8_1

	var_8_1(var_8_2, true)

	setText = var_8_1

	var_8_1(var_8_2:Find("Text"), var_8_0.content)

	local var_8_3

	if not var_8_0.type then
		var_8_3 = var_0_1.TYPE_COMMON
	end

	local var_8_4 = var_8_2:Find("icon")
	local var_8_5 = var_4.GetComponent

	typeof = var_6
	Image = var_1_10007

	local var_8_6 = var_8_5(var_8_4, var_6(var_1_10007))

	GetSpriteFromAtlas = var_8_4
	var_8_6.sprite = var_8_4("ui/IslandUI_atlas", "notice_icon_" .. var_8_3)

	arg_8_0:AddTimer(var_8_2)

	return
end

function var_0_1.AddTimer(arg_9_0, arg_9_1)
	Timer = var_1_10002
	arg_9_0.timer = var_1_10002.New(function()
		local var_10_0 = arg_9_0.timer

		var_0.Stop(var_10_0)

		local var_10_1 = arg_9_0

		var_0.ReturnTpl(var_10_1, arg_9_1)

		table = var_0

		var_0.remove(arg_9_0.tasks, 1)

		local var_10_2 = arg_9_0

		var_0.NextOne(var_10_2)

		return
	end, arg_9_0.hideTime, 1)

	local var_9_0 = arg_9_0.timer

	var_2.Start(var_9_0)

	return
end

function var_0_1.OnDestroy(arg_11_0)
	if arg_11_0.timer then
		local var_11_0 = arg_11_0.timer

		var_1.Stop(var_11_0)

		arg_11_0.timer = nil
	end

	return
end

return var_0_1
