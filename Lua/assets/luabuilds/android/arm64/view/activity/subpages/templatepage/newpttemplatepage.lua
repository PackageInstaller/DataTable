local var_0_0 = class("NewPtTemplatePage", import("view.base.BaseActivityPage"))

var_0_0.OFFSET = 0.00042
var_0_0.SHOW_COUNT = 8
var_0_0.AWARD_OFFSET = 1e-05

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.getBtn = arg_1_0.bg:Find("get_btn")
	arg_1_0.shopBtn = arg_1_0.bg:Find("exchange_btn")
	arg_1_0.content = arg_1_0.bg:Find("award_list/content")
	arg_1_0.awardTpl = arg_1_0.bg:Find("award")
	arg_1_0.sptf = arg_1_0.bg:Find("sp_award")
	arg_1_0.spAward = arg_1_0.bg:Find("sp_award/award")
	arg_1_0.ptCount = arg_1_0.bg:Find("ptCount")
	arg_1_0.getBtnGray = arg_1_0.bg:Find("gray")
	arg_1_0.get = arg_1_0.bg:Find("Obtained")
	arg_1_0.scrollCom = GetComponent(arg_1_0.content, "LScrollRect")

	function arg_1_0.scrollCom.onUpdateItem(arg_2_0, arg_2_1)
		arg_1_0:UpdateAward(arg_2_0, tf(arg_2_1))

		return
	end

	setActive(arg_1_0.awardTpl, false)

	return
end

function var_0_0.OnDataSetting(arg_3_0)
	if arg_3_0.ptData then
		arg_3_0.ptData:Update(arg_3_0.activity)
	else
		arg_3_0.highValueItemSort = arg_3_0.activity:getConfig("config_client").highValueItemSort
		arg_3_0.ptData = ActivityPtData.New(arg_3_0.activity)
		arg_3_0.awardList = {}

		for iter_3_0, iter_3_1 in pairs(arg_3_0.ptData.dropList) do
			table.insert(arg_3_0.awardList, {
				drop = Drop.New({
					type = iter_3_1[1],
					id = iter_3_1[2],
					count = iter_3_1[3]
				}),
				isImportant = table.contains(arg_3_0.highValueItemSort, iter_3_0),
				target = arg_3_0.ptData.targets[iter_3_0]
			})
		end
	end

	return
end

function var_0_0.OnFirstFlush(arg_4_0)
	onButton(arg_4_0, arg_4_0.getBtn, function()
		if arg_4_0.ptData:GetMaxAvailableTargetIndex() == arg_4_0.ptData:GetLevel() then
			return
		end

		local var_5_0 = {}
		local var_5_1 = getProxy(PlayerProxy):getRawData()
		local var_5_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
		local var_5_3, var_5_4 = Task.StaticJudgeOverflow(var_5_1.gold, var_5_1.oil, var_5_2, true, true, (arg_4_0.ptData:GetAllAvailableAwards()))

		if var_5_3 then
			table.insert(var_5_0, function(arg_6_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_5_4,
					onYes = arg_6_0
				})

				return
			end)
		end

		seriesAsync(var_5_0, function()
			arg_4_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 4,
				activity_id = arg_4_0.ptData:GetId(),
				arg1 = arg_4_0.ptData:GetCurrTarget()
			})

			return
		end)

		return
	end, SFX_PANEL)

	local var_4_0 = getProxy(ActivityProxy):getActivityById(arg_4_0.activity:getConfig("config_client").shopLinkActID)

	onButton(arg_4_0, arg_4_0.shopBtn, function()
		if not var_4_0 or var_4_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		;({
			warp = NewShopsScene.TYPE_ACTIVITY
		}).actId = var_4_0 and var_4_0.id

		var_8_0(arg_4_0, ActivityMediator.GO_SHOPS_LAYER, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)
	arg_4_0.scrollCom:SetTotalCount(#arg_4_0.awardList)
	arg_4_0:BuildPhaseAwardScrollPos()
	arg_4_0.scrollCom.onValueChanged:AddListener(function(arg_9_0)
		arg_4_0:UpdateNextAward(arg_9_0.x)

		return
	end)
	arg_4_0:UpdateNextAward(arg_4_0.scrollCom.value)

	return
end

function var_0_0.BuildPhaseAwardScrollPos(arg_10_0)
	arg_10_0.impTotalPos = arg_10_0.scrollCom:HeadIndexToValue(#arg_10_0.awardList - var_0_0.SHOW_COUNT) - arg_10_0.scrollCom:HeadIndexToValue(0)
	arg_10_0.importantPos = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0.awardList) do
		if iter_10_1.isImportant then
			table.insert(arg_10_0.importantPos, {
				index = iter_10_0,
				pos = arg_10_0.scrollCom:HeadIndexToValue(iter_10_0 - var_0_0.SHOW_COUNT) / arg_10_0.impTotalPos
			})
		end
	end

	return
end

function var_0_0.UpdateNextAward(arg_11_0, arg_11_1)
	arg_11_1 = math.min(arg_11_1, 1)

	for iter_11_0, iter_11_1 in pairs(arg_11_0.importantPos) do
		if arg_11_1 + var_0_0.AWARD_OFFSET < iter_11_1.pos then
			setActive(arg_11_0.sptf, true)
			arg_11_0:UpdateAward(iter_11_1.index - 1, arg_11_0.spAward)

			break
		elseif iter_11_0 == #arg_11_0.importantPos then
			setActive(arg_11_0.sptf, false)
		end
	end

	return
end

function var_0_0.UpdateAward(arg_12_0, arg_12_1, arg_12_2)
	updateDrop(arg_12_2:Find("icon"), arg_12_0.awardList[arg_12_1 + 1].drop)
	setText(arg_12_2:Find("pt"), arg_12_0.awardList[arg_12_1 + 1].target)

	local var_12_0 = arg_12_1 + 1 <= arg_12_0.ptData:GetLevel()
	local var_12_1 = not var_12_0 and arg_12_1 + 1 <= arg_12_0.ptData:GetMaxAvailableTargetIndex()
	local var_12_2 = not var_12_0 and not var_12_1

	setActive(arg_12_2:Find("got"), var_12_0)
	setActive(arg_12_2:Find("get"), var_12_1)
	setActive(arg_12_2:Find("lock"), var_12_2)
	onButton(arg_12_0, arg_12_2, function()
		arg_12_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_14_0)
	if isActive(arg_14_0._tf) then
		arg_14_0.scrollCom:ScrollTo(math.clamp(arg_14_0.scrollCom:HeadIndexToValue(arg_14_0.ptData:GetLevel()) / arg_14_0.impTotalPos + var_0_0.OFFSET * arg_14_0.ptData:GetLevel(), 0, 1), true)
	end

	setText(arg_14_0.get, i18n("word_got_pt"))
	setText(arg_14_0.ptCount, arg_14_0.ptData.count)
	setActive(arg_14_0.getBtnGray, arg_14_0.ptData:GetMaxAvailableTargetIndex() == arg_14_0.ptData:GetLevel())
	setActive(arg_14_0.getBtn, arg_14_0.ptData:GetMaxAvailableTargetIndex() ~= arg_14_0.ptData:GetLevel())

	return
end

function var_0_0.GetWorldPtData(arg_15_0, arg_15_1)
	local var_15_0 = ActivityMainScene.Data2Time or 0

	if arg_15_1 <= pg.TimeMgr.GetInstance():GetServerTime() - var_15_0 then
		ActivityMainScene.Data2Time = pg.TimeMgr.GetInstance():GetServerTime()

		arg_15_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 2,
			activity_id = arg_15_0.ptData:GetId()
		})
	end

	return
end

return var_0_0
