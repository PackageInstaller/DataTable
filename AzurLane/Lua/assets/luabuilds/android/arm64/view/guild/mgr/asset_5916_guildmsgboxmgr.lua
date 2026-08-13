pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.GuildMsgBoxMgr = var_0_10001("GuildMsgBoxMgr")
pg = var_0

local var_0_1 = var_0.GuildMsgBoxMgr

function var_0_1.Init(arg_1_0, arg_1_1)
	pg = var_1_10002

	local var_1_0 = var_1_10002.UIMgr.GetInstance()

	var_2.LoadingOn(var_1_0)

	PoolMgr = var_2

	local var_1_1 = var_2.GetInstance()

	var_2.GetUI(var_1_1, "GuildMsgBoxUI", true, function(arg_2_0)
		pg = var_2_10001

		var_2_10001.DelegateInfo.New(arg_1_0)

		arg_1_0._go = arg_2_0

		local var_2_0 = arg_1_0._go

		var_1.SetActive(var_2_0, false)

		arg_1_0._tf = arg_1_0._go.transform

		local var_2_1 = arg_1_0

		GameObject = var_2
		var_2_1.UIOverlay = var_2.Find("Overlay/UIOverlay")

		local var_2_2 = arg_1_0._go.transform

		var_1.SetParent(var_2_2, arg_1_0.UIOverlay.transform, false)

		local var_2_3 = arg_1_0

		findTF = var_2
		var_2_3.confirmBtn = var_2(arg_1_0._go, "frame/confirm_btn")

		local var_2_4 = arg_1_0

		findTF = var_2
		var_2_4.cancelBtn = var_2(arg_1_0._go, "frame/cancel_btn")
		setText = var_2_4

		local var_2_5 = arg_1_0.cancelBtn
		local var_2_6 = var_3.Find(var_2_5, "Text")

		i18n = var_4

		var_2_4(var_2_6, var_4("text_iknow"))

		setText = var_2_4

		local var_2_7 = arg_1_0.confirmBtn
		local var_2_8 = var_3.Find(var_2_7, "Text")

		i18n = var_4

		var_2_4(var_2_8, var_4("text_forward"))

		local var_2_9 = arg_1_0

		findTF = var_2

		local var_2_10 = var_2(arg_1_0._go, "frame/content/Text")
		local var_2_11 = var_2.GetComponent

		typeof = var_5
		Text = var_2_10007
		var_2_9.contextTxt = var_2_11(var_2_10, var_5(var_2_10007))
		pg = var_2_9

		local var_2_12 = var_2_9.UIMgr.GetInstance()

		var_1.LoadingOff(var_2_12)

		arg_1_0.isInited = true

		if arg_1_1 then
			arg_1_1()
		end

		return
	end)

	return
end

function var_0_1.Notification(arg_3_0, arg_3_1)
	assert = var_1_10002

	var_1_10002(arg_3_1.condition)

	if arg_3_1.condition() then
		if not arg_3_0.isInited then
			arg_3_0:Init(function()
				local var_4_0 = arg_3_0

				var_0.RefreshView(var_4_0, arg_3_1)

				return
			end)
		else
			arg_3_0:RefreshView(arg_3_1)
		end
	elseif arg_3_1.OnNo then
		arg_3_1.OnNo()
	end

	return
end

function var_0_1.RefreshView(arg_5_0, arg_5_1)
	arg_5_0.settings = arg_5_1
	setActive = var_1_10002

	var_1_10002(arg_5_0._tf, true)

	local var_5_0 = arg_5_0.contextTxt
	local var_5_1

	if not arg_5_1.content then
		var_5_1 = ""
	end

	var_5_0.text = var_5_1
	onButton = var_5_0

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.confirmBtn

	local function var_5_4()
		if arg_5_1.OnYes then
			arg_5_1.OnYes()
		end

		local var_6_0 = arg_5_0

		var_0.Close(var_6_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_5_0(var_5_2, var_5_3, var_5_4, var_1_10007)

	onButton = var_5_0

	local var_5_5 = arg_5_0
	local var_5_6 = arg_5_0.cancelBtn

	local function var_5_7()
		if arg_5_1.OnNo then
			arg_5_1.OnNo()
		end

		local var_7_0 = arg_5_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_5_0(var_5_5, var_5_6, var_5_7, var_1_10007)

	onButton = var_5_0

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0._tf

	local function var_5_10()
		if arg_5_1.OnNo then
			arg_5_1.OnNo()
		end

		local var_8_0 = arg_5_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_5_0(var_5_8, var_5_9, var_5_10, var_1_10007)

	onButton = var_5_0

	local var_5_11 = arg_5_0

	findTF = var_5_9

	local var_5_12 = var_5_9(arg_5_0._go, "frame/close")

	local function var_5_13()
		if arg_5_1.OnNo then
			arg_5_1.OnNo()
		end

		local var_9_0 = arg_5_0

		var_0.Hide(var_9_0)

		return
	end

	SFX_PANEL = var_7

	var_5_0(var_5_11, var_5_12, var_5_13, var_7)

	pg = var_5_0

	local var_5_14 = var_5_0.UIMgr.GetInstance()

	var_2.BlurPanel(var_5_14, arg_5_0._tf, {
		blurCamList = arg_5_1.blurCamList
	})

	local var_5_15 = arg_5_0._tf

	var_2.SetAsLastSibling(var_5_15)

	return
end

function var_0_1.Close(arg_10_0)
	if arg_10_0._tf then
		isActive = var_1

		if var_1(arg_10_0._tf) then
			arg_10_0.settings = nil
			pg = var_1

			local var_10_0 = var_1.UIMgr.GetInstance()

			var_1.UnOverlayPanel(var_10_0, arg_10_0._tf, arg_10_0.UIOverlay)

			setActive = var_1

			var_1(arg_10_0._tf, false)
		end
	end

	return
end

function var_0_1.Hide(arg_11_0)
	if arg_11_0._tf then
		isActive = var_1

		if var_1(arg_11_0._tf) and arg_11_0.settings.OnHide then
			arg_11_0.settings.OnHide()
		end
	end

	arg_11_0:Close()

	return
end

function var_0_1.Destroy(arg_12_0)
	if arg_12_0.isInited then
		pg = var_1

		var_1.DelegateInfo.Dispose(arg_12_0)

		arg_12_0.isInited = nil
		Destroy = var_1

		var_1(arg_12_0._go)
	end

	return
end

function var_0_1.NotificationForGuildEvent(arg_13_0, arg_13_1)
	getProxy = var_1_10002
	GuildProxy = var_1_10004

	local var_13_0 = var_1_10002(var_1_10004)

	if var_2.getRawData(var_13_0) then
		if var_2:GetActiveWeeklyTask() and arg_13_1.id == var_3:GetPresonTaskId() then
			local var_13_1 = arg_13_0
			local var_13_2 = arg_13_0.Notification
			local var_13_3 = {
				condition = function()
					local var_14_0 = var_0
					local var_14_1 = var_0.SamePrivateTaskType

					GuildTask = var_2_10003

					local var_14_3

					if var_14_1(var_14_0, var_2_10003.PRIVATE_TASK_TYPE_EVENT) then
						local var_14_2 = var_0

						var_14_3 = var_0.PrivateBeFinished(var_14_2)
					end

					return var_14_3
				end
			}

			i18n = var_8
			var_13_3.content = var_8("guild_mission_complate", var_3:GetPrivateTaskName())

			function var_13_3.OnYes()
				pg = var_2_10000

				local var_15_0 = var_2_10000.m02
				local var_15_1 = var_0.sendNotification

				GuildMainMediator = var_2_10003

				var_15_1(var_15_0, var_2_10003.SWITCH_TO_OFFICE)

				return
			end

			var_13_2(var_13_1, var_13_3)
		end
	end

	return
end

function var_0_1.OnBeginBattle(arg_16_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10003

	if not var_1_10001(var_1_10003) then
		return
	end

	getProxy = var_1
	GuildProxy = var_1_10003

	local var_16_0 = var_1(var_1_10003)

	if var_1.getRawData(var_16_0) then
		if var_1:GetActiveWeeklyTask() and var_2:PrivateBeFinished() then
			local var_16_1 = var_2

			var_16_0 = var_2.SamePrivateTaskType
			GuildTask = var_1_10006
			var_16_0 = var_16_0(var_16_1, var_1_10006.PRIVATE_TASK_TYPE_BATTLE)
		end

		arg_16_0.taskFinished = var_16_0
		print = var_16_0

		var_16_0("taskFinished : ", arg_16_0.taskFinished)
	end

	return
end

function var_0_1.OnFinishBattle(arg_17_0, arg_17_1)
	getProxy = var_1_10002
	GuildProxy = var_1_10004

	if not var_1_10002(var_1_10004) then
		return
	end

	getProxy = var_2
	GuildProxy = var_1_10004

	local var_17_0 = var_2(var_1_10004)

	if var_2.getRawData(var_17_0) and arg_17_1 then
		local var_17_1 = arg_17_1.system

		SYSTEM_SCENARIO = var_17_0

		if var_17_0 <= var_17_1 then
			local var_17_2 = arg_17_1.system

			SYSTEM_WORLD = var_17_0

			if var_17_2 <= var_17_0 then
				if var_2:GetActiveWeeklyTask() and var_3:PrivateBeFinished() then
					local var_17_3 = var_3

					var_17_0 = var_3.SamePrivateTaskType
					GuildTask = var_1_10007
					var_17_0 = var_17_0(var_17_3, var_1_10007.PRIVATE_TASK_TYPE_BATTLE)
				end

				if not arg_17_0.taskFinished and var_17_0 then
					arg_17_0.shouldShowBattleTip = true
				end
			end
		end
	end

	arg_17_0.taskFinished = nil

	return
end

function var_0_1.NotificationForBattle(arg_18_0, arg_18_1)
	if arg_18_0.shouldShowBattleTip then
		getProxy = var_2
		GuildProxy = var_1_10004

		local var_18_0 = var_2(var_1_10004)
		local var_18_1

		if var_2.getRawData(var_18_0) then
			::label_18_0::

			var_1_10005 = var_2
			var_18_1 = var_2.GetActiveWeeklyTask(var_1_10005)
		end

		if var_18_1 then
			local var_18_2 = false

			seriesAsync = var_1_10005

			var_1_10005({
				function(arg_19_0)
					local var_19_0 = arg_18_0

					var_1.SubmitTask(var_19_0, function(arg_20_0, arg_20_1, arg_20_2)
						var_18_2 = arg_20_0

						arg_19_0()

						return
					end)

					return
				end,
				function(arg_21_0)
					if var_18_2 then
						local var_21_0 = "\n"

						i18n = var_2_10002
						var_2_10004 = "guild_task_autoaccept_2"

						local var_21_1 = var_18_1
						local var_21_2

						if not (var_21_0 .. var_2_10002(var_2_10004, var_5.GetPrivateTaskName(var_21_1))) then
							var_21_2 = ""
						end

						getProxy = var_2_10002
						ChapterProxy = var_2_10004

						local var_21_3 = var_2_10002(var_2_10004)
						local var_21_4 = var_2.getActiveChapter(var_21_3)
						local var_21_5 = {}

						pg = var_21_3
						var_21_5[1] = var_21_3.UIMgr.CameraLevel

						if var_21_4 and var_21_4:CheckChapterWin() then
							var_21_5 = nil
						end

						local var_21_6 = arg_18_0
						local var_21_7 = var_4.Notification
						local var_21_8 = {
							condition = function()
								return true
							end
						}

						i18n = var_8

						local var_21_9 = "guild_mission_complate"
						local var_21_10 = var_18_1

						var_21_8.content = var_8(var_21_9, var_11.GetPrivateTaskName(var_21_10)) .. var_21_2

						function var_21_8.OnYes()
							pg = var_3_10000

							local var_23_0 = var_3_10000.m02
							local var_23_1 = var_0.sendNotification

							GAME = var_3_10003

							local var_23_2 = var_3_10003.GO_SCENE

							SCENE = var_3_10004

							var_23_1(var_23_0, var_23_2, var_3_10004.GUILD, {
								page = "office"
							})

							return
						end

						var_21_8.blurCamList = var_21_5
						var_21_8.OnHide = arg_18_1

						var_21_7(var_21_6, var_21_8)

						return
					end
				end
			})
		elseif arg_18_1 then
			arg_18_1()
		end
	elseif arg_18_1 then
		arg_18_1()
	end

	arg_18_0.shouldShowBattleTip = nil

	return
end

function var_0_1.NotificationForDailyBattle(arg_24_0)
	if arg_24_0.shouldShowBattleTip then
		getProxy = var_1
		GuildProxy = var_1_10003

		local var_24_0 = var_1(var_1_10003)
		local var_24_1

		if var_1.getRawData(var_24_0) then
			::label_24_0::

			var_1_10004 = var_1
			var_24_1 = var_1.GetActiveWeeklyTask(var_1_10004)
		end

		if var_24_1 then
			local var_24_2 = false

			seriesAsync = var_1_10004

			var_1_10004({
				function(arg_25_0)
					local var_25_0 = arg_24_0

					var_1.SubmitTask(var_25_0, function(arg_26_0, arg_26_1, arg_26_2)
						var_24_2 = arg_26_0

						arg_25_0()

						return
					end)

					return
				end,
				function()
					if var_24_2 then
						local var_27_0 = "\n"

						i18n = var_2_10001

						local var_27_1 = "guild_task_autoaccept_2"
						local var_27_2 = var_24_1
						local var_27_3

						if not (var_27_0 .. var_2_10001(var_27_1, var_4.GetPrivateTaskName(var_27_2))) then
							var_27_3 = ""
						end

						local var_27_4 = arg_24_0
						local var_27_5 = var_1.Notification
						local var_27_6 = {
							condition = function()
								return true
							end
						}

						i18n = var_5

						local var_27_7 = "guild_mission_complate"
						local var_27_8 = var_24_1

						var_27_6.content = var_5(var_27_7, var_8.GetPrivateTaskName(var_27_8)) .. var_27_3

						function var_27_6.OnYes()
							pg = var_3_10000

							local var_29_0 = var_3_10000.m02
							local var_29_1 = var_0.sendNotification

							GAME = var_3_10003

							local var_29_2 = var_3_10003.GO_SCENE

							SCENE = var_3_10004

							var_29_1(var_29_0, var_29_2, var_3_10004.GUILD, {
								page = "office"
							})

							return
						end

						var_27_5(var_27_4, var_27_6)

						return
					end
				end
			})
		end
	end

	arg_24_0.shouldShowBattleTip = nil

	return
end

function var_0_1.NotificationForWorld(arg_30_0, arg_30_1)
	if arg_30_0.shouldShowBattleTip then
		getProxy = var_2
		GuildProxy = var_1_10004

		local var_30_0 = var_2(var_1_10004)
		local var_30_1

		if var_2.getRawData(var_30_0) then
			::label_30_0::

			var_1_10005 = var_2
			var_30_1 = var_2.GetActiveWeeklyTask(var_1_10005)
		end

		if var_30_1 then
			local var_30_2 = false

			seriesAsync = var_1_10005

			var_1_10005({
				function(arg_31_0)
					local var_31_0 = arg_30_0

					var_1.SubmitTask(var_31_0, function(arg_32_0, arg_32_1, arg_32_2)
						var_30_2 = arg_32_0

						arg_31_0()

						return
					end)

					return
				end,
				function()
					if var_30_2 then
						local var_33_0 = "\n"

						i18n = var_2_10001

						local var_33_1 = "guild_task_autoaccept_2"
						local var_33_2 = var_30_1
						local var_33_3

						if not (var_33_0 .. var_2_10001(var_33_1, var_4.GetPrivateTaskName(var_33_2))) then
							var_33_3 = ""
						end

						local var_33_4 = arg_30_0
						local var_33_5 = var_1.Notification
						local var_33_6 = {
							condition = function()
								return true
							end
						}

						i18n = var_5

						local var_33_7 = "guild_mission_complate"
						local var_33_8 = var_30_1

						var_33_6.content = var_5(var_33_7, var_8.GetPrivateTaskName(var_33_8)) .. var_33_3

						function var_33_6.OnYes()
							pg = var_3_10000

							local var_35_0 = var_3_10000.m02
							local var_35_1 = var_0.sendNotification

							GAME = var_3_10003

							local var_35_2 = var_3_10003.GO_SCENE

							SCENE = var_3_10004

							var_35_1(var_35_0, var_35_2, var_3_10004.GUILD, {
								page = "office"
							})

							return
						end

						var_33_6.OnHide = arg_30_1

						var_33_5(var_33_4, var_33_6)

						return
					end
				end
			})
		elseif arg_30_1 then
			arg_30_1()
		end
	elseif arg_30_1 then
		arg_30_1()
	end

	arg_30_0.shouldShowBattleTip = nil

	return
end

function var_0_1.GetShouldShowBattleTip(arg_36_0)
	return arg_36_0.shouldShowBattleTip
end

function var_0_1.CancelShouldShowBattleTip(arg_37_0)
	arg_37_0.shouldShowBattleTip = nil

	return
end

function var_0_1.SubmitTask(arg_38_0, arg_38_1)
	arg_38_1 = arg_38_1 or function()
		return
	end
	getProxy = var_1_10002
	GuildProxy = var_1_10004

	local var_38_0 = var_1_10002(var_1_10004)

	if not var_2.getRawData(var_38_0) then
		arg_38_1()

		return
	end

	local var_38_1

	if var_2 then
		::label_38_0::

		var_1_10005 = var_2
		var_38_1 = var_2.GetActiveWeeklyTask(var_1_10005)
	end

	if not var_38_1 then
		arg_38_1()

		return
	end

	if var_38_1 and var_38_1:isFinished() then
		arg_38_1()

		return
	end

	local var_38_2 = var_38_1:GetPresonTaskId()

	getProxy = var_1_10005
	TaskProxy = var_1_10007

	local var_38_3 = var_1_10005(var_1_10007)
	local var_38_4

	if not var_5.getTaskById(var_38_3, var_38_2) then
		var_38_4 = var_5:getFinishTaskById(var_38_2)
	end

	if var_38_4 and not var_38_4:isFinish() then
		arg_38_1()

		return
	end

	if not var_2:hasWeeklyTaskFlag() then
		arg_38_1(false, false, var_38_2)

		return
	end

	local var_38_5 = false
	local var_38_6 = {}

	if var_38_4 and var_38_4:isFinish() and not var_38_4:isReceive() then
		table = var_1_10010

		var_1_10010.insert(var_38_6, function(arg_40_0)
			pg = var_2_10001

			local var_40_0 = var_2_10001.m02
			local var_40_1 = var_1.sendNotification

			GAME = var_2_10004

			var_40_1(var_40_0, var_2_10004.SUBMIT_TASK, var_38_2, function(arg_41_0)
				var_38_5 = arg_41_0

				arg_40_0()

				return
			end)

			return
		end)
	end

	table = var_1_10010

	var_1_10010.insert(var_38_6, function(arg_42_0)
		local var_42_0 = var_0
		local var_42_2

		if not var_1.getTaskById(var_42_0, var_38_2) then
			local var_42_1 = var_0

			var_42_2 = var_1.getFinishTaskById(var_42_1, var_38_2)
		end

		if var_38_1 then
			local var_42_3 = var_38_1

			if not var_2.isFinished(var_42_3) and (not var_42_2 or var_42_2 and var_42_2:isFinish() and var_42_2:isReceive()) then
				pg = var_2

				local var_42_4 = var_2.m02
				local var_42_5 = var_2.sendNotification

				GAME = var_2_10005

				var_42_5(var_42_4, var_2_10005.TRIGGER_TASK, var_38_2, arg_42_0)

				goto label_42_0
			end
		end

		arg_42_0()

		::label_42_0::

		return
	end)

	seriesAsync = var_10

	var_10(var_38_6, function()
		local var_43_0 = var_0
		local var_43_1 = var_0.getTaskById(var_43_0, var_38_2)

		arg_38_1(var_43_1 ~= nil, var_38_5, var_38_2)

		return
	end)

	return
end

return
