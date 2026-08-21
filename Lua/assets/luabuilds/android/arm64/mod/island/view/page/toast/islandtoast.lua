local var_0_0 = class("IslandToast", import("view.base.BaseSubView"))

var_0_0.TYPE_COMMON = 1
var_0_0.TYPE_STATE = 2

function var_0_0.getUIName(arg_1_0)
	return "IslandToastUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.container = arg_2_0._tf:Find("content")
	arg_2_0.tpl = arg_2_0._tf:Find("new")
	arg_2_0.hideTime = 3

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.tasks = {}
	arg_3_0.pools = {}

	return
end

function var_0_0.Show(arg_4_0, arg_4_1)
	var_0_0.super.Show(arg_4_0)
	table.insert(arg_4_0.tasks, arg_4_1)
	arg_4_0:SetUp()

	return
end

function var_0_0.SetUp(arg_5_0)
	if #arg_5_0.tasks == 1 then
		arg_5_0:NextOne()
	end

	return
end

function var_0_0.NewTpl(arg_6_0)
	local var_6_0

	if #arg_6_0.pools == 0 then
		var_6_0 = cloneTplTo(arg_6_0.tpl, arg_6_0.container)
	else
		var_6_0 = table.remove(arg_6_0.pools, #arg_6_0.pools)

		setParent(var_6_0, arg_6_0.container)
	end

	setActive(var_6_0, true)

	return var_6_0
end

function var_0_0.ReturnTpl(arg_7_0, arg_7_1)
	setActive(arg_7_1, false)
	table.insert(arg_7_0.pools, arg_7_1)

	return
end

function var_0_0.NextOne(arg_8_0)
	if #arg_8_0.tasks <= 0 then
		arg_8_0:Hide()

		return
	end

	local var_8_0 = arg_8_0.tasks[1]
	local var_8_1 = arg_8_0:NewTpl()

	setActive(var_8_1, true)
	setText(var_8_1:Find("Text"), var_8_0.content)

	local var_8_2 = var_8_0.type or var_0_0.TYPE_COMMON
	local var_8_3 = var_8_1:Find("icon")

	var_8_3:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/IslandUI_atlas", "notice_icon_" .. var_8_2)

	arg_8_0:AddTimer(var_8_1)

	return
end

function var_0_0.AddTimer(arg_9_0, arg_9_1)
	arg_9_0.timer = Timer.New(function()
		arg_9_0.timer:Stop()
		arg_9_0:ReturnTpl(arg_9_1)
		table.remove(arg_9_0.tasks, 1)
		arg_9_0:NextOne()

		return
	end, arg_9_0.hideTime, 1)

	arg_9_0.timer:Start()

	return
end

function var_0_0.OnDestroy(arg_11_0)
	if arg_11_0.timer then
		arg_11_0.timer:Stop()

		arg_11_0.timer = nil
	end

	return
end

return var_0_0
