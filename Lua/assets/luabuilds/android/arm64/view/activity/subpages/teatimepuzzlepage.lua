local var_0_0 = class("TeaTimePuzzlePage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.total = 15
	arg_1_0.Text = arg_1_0._tf:Find("AD/Text"):GetComponent(typeof(Text))
	arg_1_0.container = arg_1_0._tf:Find("AD/container")
	arg_1_0.GOBtn = arg_1_0._tf:Find("AD/go")
	arg_1_0.got = arg_1_0._tf:Find("AD/got")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.activity:getData1List() or {}) do
		local var_2_1 = iter_2_1 - 24

		assert(iter_2_1 - 24 > 0, "puzzlaIndex should more than zero" .. iter_2_1)
		table.insert(var_2_0, var_2_1)
	end

	local var_2_2 = {}

	if arg_2_0.activity:left4Day() then
		for iter_2_2 = 1, arg_2_0.total do
			table.insert(var_2_2, pg.gametip["activity_puzzle_get" .. iter_2_2].tip)
		end
	end

	local var_2_3 = getProxy(TaskProxy)
	local var_2_4 = getProxy(ActivityProxy)

	onButton(arg_2_0, arg_2_0.GOBtn, function()
		local var_3_0 = var_2_4:getActivityById(ActivityConst.TEATIME_TW)

		if not var_3_0 or var_3_0:isEnd() then
			return
		end

		local var_3_1 = var_3_0:getConfig("config_data")
		local var_3_2 = false

		for iter_3_0, iter_3_1 in pairs((var_2_3:getTasks())) do
			if _.any(_.flatten(var_3_1), function(arg_4_0)
				return arg_4_0 == iter_3_1.id
			end) then
				var_3_2 = true

				break
			end
		end

		if var_3_2 then
			arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = "activity"
			})
		else
			arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.NAVALACADEMYSCENE)
		end

		return
	end, SFX_PANEL)

	local var_2_5 = var_2_3:getTasks()
	local var_2_6 = getProxy(ActivityProxy):getActivityById(ActivityConst.TEATIME_TW):isEnd()

	setActive(arg_2_0.GOBtn, not var_2_6)
	setActive(arg_2_0.got, var_2_6)

	arg_2_0.Text.text = "<color=#A9F548FF>" .. #var_2_0 .. "</color>/" .. arg_2_0.total
	arg_2_0.puzzlaView = PuzzlaView.New({
		bg = "bg_1",
		go = arg_2_0.container,
		list = var_2_0,
		descs = var_2_2,
		fetch = arg_2_0.activity.data1 == 1
	}, nil)

	function arg_2_0.puzzlaView.onFinish()
		if arg_2_0.activity.data1 ~= 1 then
			arg_2_0:emit(ActivityMediator.EVENT_OPERATION, {
				cmd = 1,
				activity_id = arg_2_0.activity.id
			})
		end

		return
	end

	return
end

function var_0_0.OnDestroy(arg_6_0)
	clearImageSprite(arg_6_0.bg)

	if arg_6_0.puzzlaView then
		arg_6_0.puzzlaView:dispose()
	end

	return
end

return var_0_0
