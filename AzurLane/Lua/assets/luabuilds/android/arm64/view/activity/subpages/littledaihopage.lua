local var_0_0 = class("LittleDaihoPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.helpBtn = arg_1_0.bg:Find("help_btn")

	local var_1_0 = arg_1_0.bg:Find("step_content")

	arg_1_0.itemList = UIItemList.New(var_1_0, var_1_0:Find("tpl"))

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.getBtn, function()
		if arg_2_0.inLT then
			return
		end

		local var_3_0 = {}
		local var_3_1 = arg_2_0.ptData:GetAward()
		local var_3_2 = getProxy(PlayerProxy):getRawData()
		local var_3_3 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
		local var_3_4, var_3_5 = Task.StaticJudgeOverflow(var_3_2.gold, var_3_2.oil, var_3_3, true, true, {
			{
				var_3_1.type,
				var_3_1.id,
				var_3_1.count
			}
		})

		if var_3_4 then
			table.insert(var_3_0, function(arg_4_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_3_5,
					onYes = arg_4_0
				})

				return
			end)
		end

		table.insert(var_3_0, function(arg_5_0)
			arg_2_0.inLT = true

			local var_5_0 = cloneTplTo(arg_2_0.itemList.container:Find("tpl"), arg_2_0.itemList.container)

			setLocalScale(var_5_0, Vector2.zero)
			LeanTween.scale(var_5_0, Vector3.one, 0.6):setEase(LeanTweenType.easeInBack):setOnComplete(System.Action(arg_5_0))

			return
		end)
		table.insert(var_3_0, function(arg_6_0)
			LeanTween.delayedCall(0.2, System.Action(arg_6_0))

			return
		end)
		seriesAsync(var_3_0, function()
			arg_2_0.inLT = false

			local var_7_0, var_7_1 = arg_2_0.ptData:GetResProgress()

			arg_2_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = arg_2_0.ptData:GetId(),
				arg1 = var_7_1
			})

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("littleTaihou_npc")
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_9_0)
	var_0_0.super.OnUpdateFlush(arg_9_0)
	arg_9_0.itemList:align(arg_9_0.ptData:GetLevel())

	local var_9_0, var_9_1, var_9_2 = arg_9_0.ptData:GetResProgress()
	local var_9_3 = var_9_2 >= 1 and setColorStr(var_9_0, "#9F413AFF") or var_9_0

	setText(arg_9_0.progress, var_9_3 .. "/" .. var_9_1)

	return
end

return var_0_0
