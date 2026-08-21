local var_0_0 = class("RefluxPTView", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "RefluxPTUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:updateUI()

	return
end

function var_0_0.OnDestroy(arg_3_0)
	return
end

function var_0_0.OnBackPress(arg_4_0)
	arg_4_0:Hide()

	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.refluxProxy = getProxy(RefluxProxy)

	return
end

function var_0_0.initUI(arg_6_0)
	arg_6_0.nextBtn = arg_6_0._tf:Find("NextBtn")
	arg_6_0.countText = arg_6_0._tf:Find("PTCount")

	local var_6_0 = arg_6_0.countText:GetComponent(typeof(Text))

	var_6_0.material = Object.Instantiate(var_6_0.material)
	arg_6_0.faceSpriteList = {}

	local var_6_1 = arg_6_0._tf:Find("Face")

	for iter_6_0 = 0, var_6_1.childCount - 1 do
		table.insert(arg_6_0.faceSpriteList, (getImageSprite((var_6_1:GetChild(iter_6_0)))))
	end

	arg_6_0.scrollViewTF = arg_6_0._tf:Find("ScrollRect")
	arg_6_0.viewportTF = arg_6_0.scrollViewTF
	arg_6_0.tpl = arg_6_0._tf:Find("StepTpl")
	arg_6_0.tplContainerTF = arg_6_0._tf:Find("ScrollRect/Container")
	arg_6_0.stepUIIList = UIItemList.New(arg_6_0.tplContainerTF, arg_6_0.tpl)

	arg_6_0.stepUIIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_7_1 = arg_7_1 + 1

			arg_6_0:updateTpl(arg_7_2, arg_7_1)
		end

		return
	end)

	return
end

function var_0_0.updateData(arg_8_0)
	return
end

function var_0_0.updateUI(arg_9_0)
	arg_9_0:updateTplList()
	arg_9_0:ScrollPt(arg_9_0.refluxProxy.ptStage - 1)
	setText(arg_9_0.countText, arg_9_0.refluxProxy.ptNum)

	return
end

function var_0_0.updateOutline(arg_10_0)
	local var_10_0 = arg_10_0.countText:GetComponent(typeof(Text))

	var_10_0.material = Object.Instantiate(var_10_0.material)

	return
end

function var_0_0.updateTpl(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:Find("item")
	local var_11_1 = arg_11_1:Find("checked")
	local var_11_2 = arg_11_1:Find("face")
	local var_11_3 = arg_11_1:Find("progress")
	local var_11_4 = var_11_3:Find("text")
	local var_11_5 = var_11_3:Find("Fill Area")
	local var_11_6 = arg_11_1:Find("achieve")
	local var_11_7 = arg_11_0.refluxProxy.ptNum
	local var_11_8 = pg.return_pt_template[arg_11_2].pt_require
	local var_11_9 = arg_11_0.refluxProxy.ptStage + 1

	updateDrop(var_11_0:Find("award"), arg_11_0:getAwardForShow(arg_11_2), {
		Q = true
	})
	setText(var_11_0:Find("text_unlock"), i18n("reflux_word_2"))
	setText(var_11_0:Find("text_pt"), var_11_8 .. "PT")
	setActive(var_11_1, arg_11_2 < var_11_9)

	if arg_11_2 < var_11_9 then
		local var_11_11 = Color.gray or Color.white
		local var_11_12 = arg_11_1:GetComponentsInChildren(typeof(Image))

		for iter_11_0, iter_11_1 in ipairs((var_11_12:ToTable())) do
			iter_11_1.color = var_11_11
		end

		setImageColor(var_11_0, var_11_11)

		local var_11_13, var_11_14 = arg_11_0:getPTMinAndMax(arg_11_2)

		var_11_3.sizeDelta = Vector2(125, 20)

		setSlider(var_11_3, var_11_13, var_11_14, var_11_7)
		setActive(var_11_5, var_11_13 < var_11_7)
		setText(var_11_4, var_11_8 .. "PT")

		local var_11_15 = arg_11_2 == var_11_9 and var_11_8 <= var_11_7

		setActive(var_11_6, arg_11_2 == var_11_9 and var_11_8 <= var_11_7)

		if var_11_15 then
			onButton(arg_11_0, arg_11_1, function()
				arg_11_0:onStepClick(arg_11_2)

				return
			end, SFX_PANEL)
		else
			removeOnButton(arg_11_1)
		end

		setImageSprite(var_11_2, arg_11_0.faceSpriteList[(arg_11_2 - 1) % 10 + 1])

		return
	end
end

function var_0_0.updateTplList(arg_13_0)
	arg_13_0.stepUIIList:align(#pg.return_pt_template.all)

	return
end

function var_0_0.updateAfterServer(arg_14_0)
	if arg_14_0.refluxProxy.ptStage + 1 <= #pg.return_pt_template.all and arg_14_0.refluxProxy.ptStage + 1 >= 1 then
		arg_14_0:updateTpl(arg_14_0.tplContainerTF:GetChild(arg_14_0.refluxProxy.ptStage + 1 - 1), arg_14_0.refluxProxy.ptStage + 1)
	end

	if arg_14_0.refluxProxy.ptStage + 1 - 1 <= #pg.return_pt_template.all and arg_14_0.refluxProxy.ptStage + 1 - 1 >= 1 then
		arg_14_0:updateTpl(arg_14_0.tplContainerTF:GetChild(arg_14_0.refluxProxy.ptStage + 1 - 1 - 1), arg_14_0.refluxProxy.ptStage + 1 - 1)
	end

	arg_14_0:ScrollPt(arg_14_0.refluxProxy.ptStage - 1)

	return
end

function var_0_0.ScrollPt(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0.tplContainerTF:GetComponent(typeof(HorizontalLayoutGroup))
	local var_15_1 = arg_15_0.tpl:GetComponent(typeof(LayoutElement))

	arg_15_0.scrollViewTF:GetComponent(typeof(ScrollRect)).horizontalNormalizedPosition = math.clamp(math.max(arg_15_1 * (var_15_1.preferredWidth + var_15_0.spacing) - arg_15_0.viewportTF.rect.width * 0.5 + var_15_1.preferredWidth, 0) / (arg_15_0.tplContainerTF.childCount * var_15_1.preferredWidth + (arg_15_0.tplContainerTF.childCount - 1) * var_15_0.spacing - arg_15_0.viewportTF.rect.width), 0, 1)

	return
end

function var_0_0.onStepClick(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getAwardForShow(arg_16_1)

	var_16_0[1] = var_16_0.type
	var_16_0[2] = var_16_0.id
	var_16_0[3] = var_16_0.count

	local var_16_1, var_16_2 = Task.StaticJudgeOverflow(false, false, false, true, true, {
		var_16_0
	})

	if var_16_1 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_ITEM_BOX,
			content = i18n("award_max_warning"),
			items = var_16_2,
			onYes = function()
				pg.m02:sendNotification(GAME.REFLUX_GET_PT_AWARD)

				return
			end
		})
	else
		(function()
			pg.m02:sendNotification(GAME.REFLUX_GET_PT_AWARD)

			return
		end)()
	end

	return
end

function var_0_0.getAwardForShow(arg_18_0, arg_18_1)
	local var_18_0

	for iter_18_0, iter_18_1 in ipairs(pg.return_pt_template[arg_18_1].level) do
		if iter_18_1[1] <= arg_18_0.refluxProxy.returnLV and arg_18_0.refluxProxy.returnLV <= iter_18_1[2] then
			var_18_0 = iter_18_0
		end
	end

	return {
		type = pg.return_pt_template[arg_18_1].award_display[var_18_0][1],
		id = pg.return_pt_template[arg_18_1].award_display[var_18_0][2],
		count = pg.return_pt_template[arg_18_1].award_display[var_18_0][3]
	}
end

function var_0_0.getPTMinAndMax(arg_19_0, arg_19_1)
	local var_19_0

	var_19_0 = pg.return_pt_template[arg_19_1 - 1] and pg.return_pt_template[arg_19_1 - 1].pt_require or 0

	return var_19_0, nil
end

function var_0_0.isAnyPTCanGetAward()
	local var_20_0 = getProxy(RefluxProxy)
	local var_20_1 = var_20_0.ptStage + 1

	if var_20_0.ptStage + 1 <= #pg.return_pt_template.all then
		return pg.return_pt_template[var_20_1].pt_require <= var_20_0.ptNum
	else
		return false
	end

	return
end

return var_0_0
