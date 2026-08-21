local var_0_0 = class("EducateTargetSetLayer", import(".base.EducateBaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "EducateTargetSetUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.initData(arg_3_0)
	arg_3_0:initTargetList()

	arg_3_0.selectedIndex = 1

	return
end

function var_0_0.initTargetList(arg_4_0)
	local var_4_0 = getProxy(EducateProxy)
	local var_4_1 = var_4_0:GetCharData()

	arg_4_0.maxAttrId = var_4_1:GetAttrSortIds()[1]

	local var_4_2 = var_4_0:GetTaskProxy():GetTargetId() == 0 and 1 or var_4_1:GetStage() + 1
	local var_4_3 = var_4_0:GetPersonalityId()

	for iter_4_0, iter_4_1 in ipairs(pg.child_target_set.all) do
		if pg.child_target_set[iter_4_1].stage == var_4_2 then
			if pg.child_target_set[iter_4_1].condition == "" or #pg.child_target_set[iter_4_1].condition == 0 then
				table.insert({}, iter_4_1)
			elseif var_4_3 == pg.child_target_set[iter_4_1].condition[2][1] then
				table.insert({}, iter_4_1)
			end
		end
	end

	table.sort({}, CompareFuncs({
		function(arg_5_0)
			return -var_4_1:GetAttrById(pg.child_target_set[arg_5_0].condition[1][1])
		end,
		function(arg_6_0)
			return arg_6_0
		end
	}))

	local var_4_4 = 0

	arg_4_0.targetList = {}

	for iter_4_2, iter_4_3 in ipairs({}) do
		table.insert(arg_4_0.targetList, iter_4_3)

		var_4_4 = var_4_4 + 1

		if var_4_4 == 4 then
			break
		end
	end

	if var_4_4 < 4 then
		for iter_4_4, iter_4_5 in ipairs({}) do
			table.insert(arg_4_0.targetList, iter_4_5)

			var_4_4 = var_4_4 + 1

			if var_4_4 == 4 then
				break
			end
		end
	end

	return
end

function var_0_0.findUI(arg_7_0)
	arg_7_0.windowTF = arg_7_0._tf:Find("anim_root/window")
	arg_7_0.targetContent = arg_7_0.windowTF:Find("content")
	arg_7_0.targetTpl = arg_7_0.targetContent:Find("tpl")

	setActive(arg_7_0.targetTpl, false)

	arg_7_0.sureBtn = arg_7_0.windowTF:Find("sure_btn")

	setText(arg_7_0.sureBtn:Find("Text"), i18n("word_ok"))

	return
end

function var_0_0.addListener(arg_8_0)
	onButton(arg_8_0, arg_8_0.sureBtn, function()
		arg_8_0:emit(EducateBaseUI.EDUCATE_ON_MSG_TIP, {
			content = i18n("child_target_set_sure_tip", pg.child_attr[pg.child_target_set[arg_8_0.targetList[arg_8_0.selectedIndex]].recommend_attr2].name),
			onYes = function()
				arg_8_0:emit(EducateTargetSetMediator.ON_TARGET_SET, {
					open = true,
					id = var_0
				})

				local var_10_0 = arg_8_0._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

				arg_8_0._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
					var_10_0:SetEndEvent(nil)
					arg_8_0:emit(var_0_0.ON_CLOSE)

					return
				end)
				arg_8_0._tf:Find("anim_root"):GetComponent(typeof(Animation)):Play("anim_educate_targetset_out")

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_12_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_12_0._tf)
	arg_12_0:initTarget()

	return
end

function var_0_0.initTarget(arg_13_0)
	for iter_13_0 = 1, #arg_13_0.targetList do
		local var_13_0 = cloneTplTo(arg_13_0.targetTpl, arg_13_0.targetContent, tostring(iter_13_0))
		local var_13_1 = arg_13_0.targetList[iter_13_0]

		setImageSprite(var_13_0:Find("animroot/icon/Image"), LoadSprite("educatetarget/" .. pg.child_target_set[arg_13_0.targetList[iter_13_0]].icon), true)
		setImageSprite(var_13_0:Find("animroot/name"), LoadSprite("educatetarget/" .. pg.child_target_set[var_13_1].pic), true)
		onButton(arg_13_0, var_13_0, function()
			if arg_13_0.selectedIndex == iter_13_0 then
				return
			end

			arg_13_0.selectedIndex = iter_13_0

			arg_13_0:updateTarget()

			return
		end, SFX_PANEL)
		setActive(var_13_0:Find("animroot/recommand"), pg.child_target_set[var_13_1].recommend_attr == arg_13_0.maxAttrId)
	end

	arg_13_0:updateTarget()
	table.insert({}, function(arg_15_0)
		onDelayTick(function()
			arg_15_0()

			return
		end, 0.066)

		return
	end)

	for iter_13_1 = 1, #arg_13_0.targetList do
		table.insert({}, function(arg_17_0)
			arg_13_0.targetContent:Find(tostring(iter_13_1)):GetComponent(typeof(Animation)):Play("anim_educate_targetset_tpl_in")
			onDelayTick(function()
				arg_17_0()

				return
			end, 0.066)

			return
		end)
	end

	seriesAsync({}, function()
		return
	end)

	return
end

function var_0_0.updateTarget(arg_20_0)
	eachChild(arg_20_0.targetContent, function(arg_21_0)
		setActive(arg_21_0:Find("animroot/selected"), arg_20_0.selectedIndex == tonumber(arg_21_0.name))

		return
	end)

	return
end

function var_0_0.willExit(arg_22_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_22_0._tf)

	return
end

function var_0_0.onBackPressed(arg_23_0)
	return
end

return var_0_0
