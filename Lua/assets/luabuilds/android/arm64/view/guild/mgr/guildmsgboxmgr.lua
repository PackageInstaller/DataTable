pg = pg or {}
pg.GuildMsgBoxMgr = singletonClass("GuildMsgBoxMgr")

function pg.GuildMsgBoxMgr.Init(arg_1_0, arg_1_1)
	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetUI("GuildMsgBoxUI", true, function(arg_2_0)
		pg.DelegateInfo.New(arg_1_0)

		arg_1_0._go = arg_2_0

		arg_1_0._go:SetActive(false)

		arg_1_0._tf = arg_1_0._go.transform
		arg_1_0.UIOverlay = GameObject.Find("Overlay/UIOverlay")

		arg_1_0._go.transform:SetParent(arg_1_0.UIOverlay.transform, false)

		arg_1_0.confirmBtn = findTF(arg_1_0._go, "frame/confirm_btn")
		arg_1_0.cancelBtn = findTF(arg_1_0._go, "frame/cancel_btn")

		setText(arg_1_0.cancelBtn:Find("Text"), i18n("text_iknow"))
		setText(arg_1_0.confirmBtn:Find("Text"), i18n("text_forward"))

		arg_1_0.contextTxt = findTF(arg_1_0._go, "frame/content/Text"):GetComponent(typeof(Text))

		pg.UIMgr.GetInstance():LoadingOff()

		arg_1_0.isInited = true

		if arg_1_1 then
			arg_1_1()
		end

		return
	end)

	return
end

function pg.GuildMsgBoxMgr.Notification(arg_3_0, arg_3_1)
	assert(arg_3_1.condition)

	if arg_3_1.condition() then
		if not arg_3_0.isInited then
			arg_3_0:Init(function()
				arg_3_0:RefreshView(arg_3_1)

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

function pg.GuildMsgBoxMgr.RefreshView(arg_5_0, arg_5_1)
	arg_5_0.settings = arg_5_1

	setActive(arg_5_0._tf, true)

	arg_5_0.contextTxt.text = arg_5_1.content or ""

	onButton(arg_5_0, arg_5_0.confirmBtn, function()
		if arg_5_1.OnYes then
			arg_5_1.OnYes()
		end

		arg_5_0:Close()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.cancelBtn, function()
		if arg_5_1.OnNo then
			arg_5_1.OnNo()
		end

		arg_5_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0._tf, function()
		if arg_5_1.OnNo then
			arg_5_1.OnNo()
		end

		arg_5_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, findTF(arg_5_0._go, "frame/close"), function()
		if arg_5_1.OnNo then
			arg_5_1.OnNo()
		end

		arg_5_0:Hide()

		return
	end, SFX_PANEL)
	pg.UIMgr.GetInstance():BlurPanel(arg_5_0._tf, {
		blurCamList = arg_5_1.blurCamList
	})
	arg_5_0._tf:SetAsLastSibling()

	return
end

function pg.GuildMsgBoxMgr.Close(arg_10_0)
	if arg_10_0._tf and isActive(arg_10_0._tf) then
		arg_10_0.settings = nil

		pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf, arg_10_0.UIOverlay)
		setActive(arg_10_0._tf, false)
	end

	return
end

function pg.GuildMsgBoxMgr.Hide(arg_11_0)
	if arg_11_0._tf and isActive(arg_11_0._tf) and arg_11_0.settings.OnHide then
		arg_11_0.settings.OnHide()
	end

	arg_11_0:Close()

	return
end

function pg.GuildMsgBoxMgr.Destroy(arg_12_0)
	if arg_12_0.isInited then
		pg.DelegateInfo.Dispose(arg_12_0)

		arg_12_0.isInited = nil

		Destroy(arg_12_0._go)
	end

	return
end

function pg.GuildMsgBoxMgr.NotificationForGuildEvent(arg_13_0, arg_13_1)
	local var_13_0 = getProxy(GuildProxy):getRawData()

	if var_13_0 then
		local var_13_1 = var_13_0:GetActiveWeeklyTask()

		if var_13_1 and arg_13_1.id == var_13_1:GetPresonTaskId() then
			arg_13_0:Notification({
				condition = function()
					return var_13_1:SamePrivateTaskType(GuildTask.PRIVATE_TASK_TYPE_EVENT) and var_13_1:PrivateBeFinished()
				end,
				content = i18n("guild_mission_complate", var_13_1:GetPrivateTaskName()),
				OnYes = function()
					pg.m02:sendNotification(GuildMainMediator.SWITCH_TO_OFFICE)

					return
				end
			})
		end
	end

	return
end

function pg.GuildMsgBoxMgr.OnBeginBattle(arg_16_0)
	if not getProxy(GuildProxy) then
		return
	end

	local var_16_0 = getProxy(GuildProxy):getRawData()

	if var_16_0 then
		local var_16_1 = var_16_0:GetActiveWeeklyTask()

		arg_16_0.taskFinished = var_16_1 and var_16_1:PrivateBeFinished() and var_16_1:SamePrivateTaskType(GuildTask.PRIVATE_TASK_TYPE_BATTLE)

		print("taskFinished : ", arg_16_0.taskFinished)
	end

	return
end

function pg.GuildMsgBoxMgr.OnFinishBattle(arg_17_0, arg_17_1)
	if not getProxy(GuildProxy) then
		return
	end

	local var_17_0 = getProxy(GuildProxy):getRawData()

	if var_17_0 and arg_17_1 and arg_17_1.system >= SYSTEM_SCENARIO and arg_17_1.system <= SYSTEM_WORLD then
		local var_17_1 = var_17_0:GetActiveWeeklyTask()
		local var_17_2 = var_17_1 and var_17_1:PrivateBeFinished() and var_17_1:SamePrivateTaskType(GuildTask.PRIVATE_TASK_TYPE_BATTLE)

		if not arg_17_0.taskFinished and var_17_2 then
			arg_17_0.shouldShowBattleTip = true
		end
	end

	arg_17_0.taskFinished = nil

	return
end

function pg.GuildMsgBoxMgr.NotificationForBattle(arg_18_0, arg_18_1)
	if arg_18_0.shouldShowBattleTip then
		local var_18_0 = getProxy(GuildProxy):getRawData()

		if var_18_0 and var_18_0:GetActiveWeeklyTask() then
			local var_18_1 = false

			seriesAsync({
				function(arg_19_0)
					arg_18_0:SubmitTask(function(arg_20_0, arg_20_1, arg_20_2)
						var_18_1 = arg_20_0

						arg_19_0()

						return
					end)

					return
				end,
				function(arg_21_0)
					local var_21_0 = var_18_1 and "\n" .. i18n("guild_task_autoaccept_2", var_0:GetPrivateTaskName()) or ""
					local var_21_1 = getProxy(ChapterProxy):getActiveChapter()
					local var_21_2 = {
						pg.UIMgr.CameraLevel
					}

					if var_21_1 and var_21_1:CheckChapterWin() then
						var_21_2 = nil
					end

					arg_18_0:Notification({
						condition = function()
							return true
						end,
						content = i18n("guild_mission_complate", var_0:GetPrivateTaskName()) .. var_21_0,
						OnYes = function()
							pg.m02:sendNotification(GAME.GO_SCENE, SCENE.GUILD, {
								page = "office"
							})

							return
						end,
						blurCamList = var_21_2,
						OnHide = arg_18_1
					})

					return
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

function pg.GuildMsgBoxMgr.NotificationForDailyBattle(arg_24_0)
	if arg_24_0.shouldShowBattleTip then
		local var_24_0 = getProxy(GuildProxy):getRawData()

		if var_24_0 and var_24_0:GetActiveWeeklyTask() then
			local var_24_1 = false

			seriesAsync({
				function(arg_25_0)
					arg_24_0:SubmitTask(function(arg_26_0, arg_26_1, arg_26_2)
						var_24_1 = arg_26_0

						arg_25_0()

						return
					end)

					return
				end,
				function()
					local var_27_0 = var_24_1 and "\n" .. i18n("guild_task_autoaccept_2", var_0:GetPrivateTaskName()) or ""

					arg_24_0:Notification({
						condition = function()
							return true
						end,
						content = i18n("guild_mission_complate", var_0:GetPrivateTaskName()) .. var_27_0,
						OnYes = function()
							pg.m02:sendNotification(GAME.GO_SCENE, SCENE.GUILD, {
								page = "office"
							})

							return
						end
					})

					return
				end
			})
		end
	end

	arg_24_0.shouldShowBattleTip = nil

	return
end

function pg.GuildMsgBoxMgr.NotificationForWorld(arg_30_0, arg_30_1)
	if arg_30_0.shouldShowBattleTip then
		local var_30_0 = getProxy(GuildProxy):getRawData()

		if var_30_0 and var_30_0:GetActiveWeeklyTask() then
			local var_30_1 = false

			seriesAsync({
				function(arg_31_0)
					arg_30_0:SubmitTask(function(arg_32_0, arg_32_1, arg_32_2)
						var_30_1 = arg_32_0

						arg_31_0()

						return
					end)

					return
				end,
				function()
					local var_33_0 = var_30_1 and "\n" .. i18n("guild_task_autoaccept_2", var_0:GetPrivateTaskName()) or ""

					arg_30_0:Notification({
						condition = function()
							return true
						end,
						content = i18n("guild_mission_complate", var_0:GetPrivateTaskName()) .. var_33_0,
						OnYes = function()
							pg.m02:sendNotification(GAME.GO_SCENE, SCENE.GUILD, {
								page = "office"
							})

							return
						end,
						OnHide = arg_30_1
					})

					return
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

function pg.GuildMsgBoxMgr.GetShouldShowBattleTip(arg_36_0)
	return arg_36_0.shouldShowBattleTip
end

function pg.GuildMsgBoxMgr.CancelShouldShowBattleTip(arg_37_0)
	arg_37_0.shouldShowBattleTip = nil

	return
end

function pg.GuildMsgBoxMgr.SubmitTask(arg_38_0, arg_38_1)
	arg_38_1 = arg_38_1 or function()
		return
	end

	local var_38_0 = getProxy(GuildProxy):getRawData()

	if not var_38_0 then
		arg_38_1()

		return
	end

	local var_38_1 = var_38_0 and var_38_0:GetActiveWeeklyTask()

	if not var_38_1 then
		arg_38_1()

		return
	end

	if var_38_1 and var_38_1:isFinished() then
		arg_38_1()

		return
	end

	local var_38_2 = var_38_1:GetPresonTaskId()
	local var_38_3 = getProxy(TaskProxy)
	local var_38_4 = var_38_3:getTaskById(var_38_2) or var_38_3:getFinishTaskById(var_38_2)

	if var_38_4 and not var_38_4:isFinish() then
		arg_38_1()

		return
	end

	if not var_38_0:hasWeeklyTaskFlag() then
		arg_38_1(false, false, var_38_2)

		return
	end

	local var_38_5 = false

	if var_38_4 and var_38_4:isFinish() and not var_38_4:isReceive() then
		table.insert({}, function(arg_40_0)
			pg.m02:sendNotification(GAME.SUBMIT_TASK, var_38_2, function(arg_41_0)
				var_38_5 = arg_41_0

				arg_40_0()

				return
			end)

			return
		end)
	end

	table.insert({}, function(arg_42_0)
		local var_42_0 = var_38_3:getTaskById(var_38_2) or var_38_3:getFinishTaskById(var_38_2)

		if var_38_1 and not var_38_1:isFinished() and (not var_42_0 or var_42_0 and var_42_0:isFinish() and var_42_0:isReceive()) then
			pg.m02:sendNotification(GAME.TRIGGER_TASK, var_38_2, arg_42_0)
		else
			arg_42_0()
		end

		return
	end)
	seriesAsync({}, function()
		arg_38_1(var_38_3:getTaskById(var_38_2) ~= nil, var_38_5, var_38_2)

		return
	end)

	return
end

return
