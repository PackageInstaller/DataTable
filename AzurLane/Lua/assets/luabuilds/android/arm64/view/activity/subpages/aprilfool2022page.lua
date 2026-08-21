local var_0_0 = class("AprilFool2022Page", import("view.base.BaseActivityPage"))

var_0_0.Order = {
	1,
	3,
	2
}

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.selectIndex = 0
	arg_1_0.stars = {}

	for iter_1_0 = 1, 3 do
		arg_1_0.stars[iter_1_0] = arg_1_0.bg:Find("Star" .. iter_1_0)
	end

	arg_1_0.clickIndex = 0
	arg_1_0.btnBattle = arg_1_0.bg:Find("Battle_btn")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity:getConfig("config_client")

	if type(var_2_0) == "table" and var_2_0[2] and type(var_2_0[2]) == "string" then
		if not pg.NewStoryMgr.GetInstance():IsPlayed(var_2_0[2]) then
			pg.NewStoryMgr.GetInstance():Play(var_2_0[2], nil, true, true)
		end
	end

	if arg_2_0.activity.data2 == 0 and arg_2_0.activity.data3 == 1 then
		arg_2_0.activity.data3 = 0

		arg_2_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 2,
			activity_id = arg_2_0.activity.id
		})

		return true
	end

	if arg_2_0.activity.data1 == 0 then
		if arg_2_0.activity:getConfig("config_client").autounlock <= pg.TimeMgr.GetInstance():GetServerTime() - arg_2_0.activity:getStartTime() then
			arg_2_0:emit(ActivityMediator.EVENT_OPERATION, {
				arg1 = 1,
				cmd = 1,
				activity_id = arg_2_0.activity.id
			})

			return true
		end
	end

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	var_0_0.super.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.btnBattle, function()
		arg_3_0:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
			warnMsg = "bulin_tip_other3",
			stageId = arg_3_0.activity:getConfig("config_client").stageid
		}, function()
			if not pg.NewStoryMgr.GetInstance():IsPlayed(tostring(var_0), true) then
				pg.m02:sendNotification(GAME.STORY_UPDATE, {
					storyId = tostring(var_0)
				})
			end

			local var_5_0 = getProxy(ActivityProxy)
			local var_5_1 = var_5_0:getActivityById(arg_3_0.activity.id)

			if var_5_1.data2 > 0 then
				return
			end

			var_5_1.data3 = 1

			var_5_0:updateActivity(var_5_1)

			return
		end)

		return
	end, SFX_PANEL)

	local function var_3_0(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = GetOrAddComponent(arg_6_1, "ButtonEventExtend").onPointerDown

		pg.DelegateInfo.Add(arg_6_0, var_6_0)
		var_6_0:RemoveAllListeners()
		var_6_0:AddListener(function()
			if arg_3_0.activity.data1 ~= 0 then
				return
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_6_2 ~= arg_3_0.Order[arg_3_0.clickIndex + 1] and "event:/ui/shibai" or "event:/ui/deng" .. arg_3_0.clickIndex + 1)

			return
		end)

		return
	end

	table.Foreach(arg_3_0.stars, function(arg_8_0, arg_8_1)
		onButton(arg_3_0, arg_8_1, function()
			if arg_3_0.activity.data1 ~= 0 then
				return
			end

			if arg_8_0 ~= arg_3_0.Order[arg_3_0.clickIndex + 1] then
				arg_3_0.clickIndex = 0

				arg_3_0:OnUpdateFlush()

				return
			end

			arg_3_0.clickIndex = arg_3_0.clickIndex + 1

			arg_3_0:OnUpdateFlush()

			if arg_3_0.clickIndex < #arg_3_0.Order then
				return
			end

			arg_3_0:emit(ActivityMediator.EVENT_OPERATION, {
				arg1 = 1,
				cmd = 1,
				activity_id = arg_3_0.activity.id
			})

			return
		end)
		var_3_0(arg_3_0, arg_8_1, arg_8_0)

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_10_0)
	var_0_0.super.OnUpdateFlush(arg_10_0)
	setActive(arg_10_0.btnBattle, arg_10_0.activity.data1 ~= 0)
	SetCompomentEnabled(arg_10_0.btnBattle, "Animator", arg_10_0.activity.data2 == 0)
	table.Foreach(arg_10_0.Order, function(arg_11_0, arg_11_1)
		setActive(arg_10_0.stars[arg_11_1]:Find("Effect"), arg_11_0 <= arg_10_0.clickIndex or arg_10_0.activity.data1 ~= 0)

		return
	end)

	return
end

return var_0_0
