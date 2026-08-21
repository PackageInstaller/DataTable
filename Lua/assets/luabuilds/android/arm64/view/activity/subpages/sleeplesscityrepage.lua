local var_0_0 = class("SleeplessCityRePage", import(".TemplatePage.PtTemplatePage"))

var_0_0.COLOR = "#BD3F40"

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)
	onButton(arg_1_0, arg_1_0.getBtn, function()
		local var_2_0 = arg_1_0.ptData:GetAward()
		local var_2_1 = getProxy(PlayerProxy):getRawData()
		local var_2_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
		local var_2_3, var_2_4 = Task.StaticJudgeOverflow(var_2_1.gold, var_2_1.oil, var_2_2, true, true, {
			{
				var_2_0.type,
				var_2_0.id,
				var_2_0.count
			}
		})

		if var_2_3 then
			table.insert({}, function(arg_3_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_2_4,
					onYes = arg_3_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			local var_4_0, var_4_1 = arg_1_0.ptData:GetResProgress()

			arg_1_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = arg_1_0.ptData:GetId(),
				arg1 = var_4_1,
				callback = function()
					arg_1_0:OnUpdateFlush()

					return
				end
			})

			return
		end)

		return
	end, SFX_PANEL)
	arg_1_0:OnUpdateFlush()

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	local var_6_0 = arg_6_0.activity:getConfig("config_client").story

	if arg_6_0.level and checkExist(var_6_0, {
		arg_6_0.level
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_6_0[arg_6_0.level][1])
	end

	arg_6_0.level = arg_6_0.ptData:getTargetLevel()

	if arg_6_0.step then
		local var_6_1, var_6_2, var_6_3 = arg_6_0.ptData:GetLevelProgress()

		setText(arg_6_0.step, var_6_1 .. "/" .. var_6_2)
	end

	local var_6_4, var_6_5, var_6_6 = arg_6_0.ptData:GetResProgress()
	local var_6_7 = var_6_6 >= 1 and setColorStr(var_6_4, COLOR_GREEN) or setColorStr(var_6_4, var_0_0.COLOR)

	setText(arg_6_0.progress, var_6_7 .. "/" .. var_6_5)
	setSlider(arg_6_0.slider, 0, 1, var_6_6)

	local var_6_8 = arg_6_0.ptData:CanGetAward()
	local var_6_9 = arg_6_0.ptData:CanGetNextAward()

	setActive(arg_6_0.battleBtn, arg_6_0.ptData:CanGetMorePt() and not var_6_8 and var_6_9)
	setActive(arg_6_0.getBtn, var_6_8)
	setActive(arg_6_0.gotBtn, not var_6_9)
	updateDrop(arg_6_0.awardTF, (arg_6_0.ptData:GetAward()))
	onButton(arg_6_0, arg_6_0.awardTF, function()
		arg_6_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	setText(arg_6_0.bg:Find("description"), i18n("activity_victory"))

	if not var_6_9 and var_6_6 >= 1 and not var_6_8 then
		arg_6_0.level = arg_6_0.level + 1
	end

	return
end

return var_0_0
