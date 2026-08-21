local var_0_0 = class("BobingPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	if PLATFORM_CODE == PLATFORM_CHT or PLATFORM_CODE == PLATFORM_CH then
		setActive(findTF(arg_1_0._tf, "bobing"), true)
		setActive(findTF(arg_1_0._tf, "lottery"), false)
	else
		setActive(findTF(arg_1_0._tf, "bobing"), false)
		setActive(findTF(arg_1_0._tf, "lottery"), true)
	end

	arg_1_0:bind(ActivityMediator.ON_BOBING_RESULT, function(arg_2_0, arg_2_1, arg_2_2)
		if PLATFORM_CODE == PLATFORM_CHT or PLATFORM_CODE == PLATFORM_CH then
			arg_1_0:displayBBResult(arg_2_1.awards, arg_2_1.numbers, function()
				arg_2_1.callback()

				return
			end)
		else
			arg_1_0:displayLotteryAni(arg_2_1.awards, arg_2_1.numbers, function()
				arg_2_1.callback()

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	if PLATFORM_CODE == PLATFORM_CHT or PLATFORM_CODE == PLATFORM_CH then
		arg_5_0:bobingUpdate()
	else
		arg_5_0:lotteryUpdate()
	end

	return
end

function var_0_0.lotteryUpdate(arg_6_0)
	local var_6_0 = findTF(arg_6_0._tf, "lottery/layer")
	local var_6_1 = arg_6_0.lotteryWrap

	if not arg_6_0.lotteryWrap then
		var_6_1 = {
			btnLotteryBtn = findTF(var_6_0, "lottery_btn"),
			phase = findTF(var_6_0, "phase"),
			nums = findTF(var_6_0, "nums")
		}
		arg_6_0.lotteryWrap = var_6_1
	end

	local var_6_2 = arg_6_0.activity:getConfig("config_id")

	if var_6_2 <= arg_6_0.activity.data1 then
		setActive(findTF(var_6_1.phase, "bg"), false)
		setActive(findTF(var_6_1.phase, "Text"), false)
		setActive(findTF(var_6_1.phase, "finish"), true)
	else
		setActive(findTF(var_6_1.phase, "bg"), true)
		setActive(findTF(var_6_1.phase, "Text"), true)
		setText(findTF(var_6_1.phase, "Text"), setColorStr(arg_6_0.activity.data1, "FFD43F") .. "/" .. var_6_2)
		setActive(findTF(var_6_1.phase, "finish"), false)
	end

	local var_6_4

	if arg_6_0.activity.data2 < 1 then
		LeanTween.alpha(var_6_1.btnLotteryBtn, 1, 1):setLoopPingPong()
		setActive(findTF(var_6_1.btnLotteryBtn, "mask"), false)
		onButton(arg_6_0, var_6_1.btnLotteryBtn, function()
			if arg_6_0.activity.data2 < 1 then
				arg_6_0:emit(ActivityMediator.EVENT_OPERATION, {
					cmd = 1,
					activity_id = arg_6_0.activity.id
				})
				arg_6_0:emit(ActivityMainScene.LOCK_ACT_MAIN, true)
			end

			return
		end, SFX_PANEL)
	else
		LeanTween.cancel(var_6_1.btnLotteryBtn.gameObject)
		setActive(findTF(var_6_1.btnLotteryBtn, "mask"), true)

		local var_6_3 = arg_6_0:getIndexByNumbers(arg_6_0.activity.data1_list)

		setActive(findTF(var_6_1.btnLotteryBtn, "mask/1"), var_6_3 == 1)
		setActive(findTF(var_6_1.btnLotteryBtn, "mask/2"), var_6_3 == 2)
		setActive(findTF(var_6_1.btnLotteryBtn, "mask/3"), var_6_3 == 3)
		onButton(arg_6_0, var_6_1.btnLotteryBtn, function()
			if arg_6_0.activity.data2 < 1 then
				arg_6_0:emit(ActivityMediator.EVENT_OPERATION, {
					cmd = 1,
					activity_id = arg_6_0.activity.id
				})
				arg_6_0:emit(ActivityMainScene.LOCK_ACT_MAIN, true)
			end

			return
		end, SFX_PANEL)

		var_6_4 = setText
	end

	var_6_4(findTF(var_6_1.nums, "text"), string.format("<color=#%s>%s</color> / %s", arg_6_0.activity.data2 == 0 and "FFD43F" or "d2d4db", 1 - arg_6_0.activity.data2, 1))

	return
end

function var_0_0.getIndexByNumbers(arg_9_0, arg_9_1)
	local var_9_0 = ActivityConst.BBRule(arg_9_1)
	local var_9_1 = 3

	if var_9_0 and var_9_0 >= 1 and var_9_0 <= 2 then
		var_9_1 = 1
	end

	if var_9_0 and var_9_0 >= 3 and var_9_0 <= 4 then
		var_9_1 = 2
	end

	return var_9_1
end

function var_0_0.displayLotteryAni(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0:getIndexByNumbers(arg_10_2)
	local var_10_1 = findTF(arg_10_0._tf, "lottery")
	local var_10_2 = findTF(arg_10_0._tf, "lottery"):Find("omikuji_anim"):GetComponent(typeof(DftAniEvent))

	var_10_2:SetEndEvent(function(arg_11_0)
		setActive(var_10_2.gameObject, false)

		local var_11_0 = var_10_1:Find("omikuji_result")

		setActive(var_11_0, true)

		local var_11_1 = var_11_0:Find("title")

		for iter_11_0 = 1, var_11_1.childCount do
			setActive(var_11_1:GetChild(iter_11_0 - 1), iter_11_0 == var_10_0)
		end

		setText(var_11_0:Find("desc"), (i18n("draw_" .. ({
			"big",
			"medium",
			"little"
		})[var_10_0] .. "_luck_" .. math.random(1, 3))))

		local var_11_2 = var_11_0:Find("award")
		local var_11_3 = var_11_0:Find("award_list")

		setActive(var_11_2, false)
		removeAllChildren(var_11_3)

		if arg_10_1 then
			for iter_11_1, iter_11_2 in ipairs(arg_10_1) do
				local var_11_4 = cloneTplTo(var_11_2, var_11_3)

				updateDrop(var_11_4, {
					type = iter_11_2.type,
					id = iter_11_2.id,
					count = iter_11_2.count
				})
				onButton(arg_10_0, var_11_4, function()
					arg_10_0:emit(BaseUI.ON_DROP, var_0)

					return
				end, SFX_PANEL)
			end
		end

		arg_10_0:emit(ActivityMainScene.LOCK_ACT_MAIN, false)
		onButton(arg_10_0, var_11_0, function()
			setActive(var_11_0, false)
			arg_10_3()

			return
		end)

		return
	end)
	setActive(var_10_2.gameObject, true)

	return
end

function var_0_0.bobingUpdate(arg_14_0)
	local var_14_0 = arg_14_0.activity
	local var_14_1 = findTF(arg_14_0._tf, "bobing")
	local var_14_2 = arg_14_0.bobingWrap

	if not arg_14_0.bobingWrap then
		var_14_2 = {
			bg = arg_14_0._tf:Find("AD"),
			progress = var_14_1:Find("award/nums"),
			get = var_14_1:Find("award/get"),
			nums = var_14_1:Find("nums/text"),
			bowlDisable = var_14_1:Find("bowl_disable"),
			bowlEnable = var_14_1:Find("bowl_enable")
		}
		var_14_2.bowlShine = var_14_2.bowlEnable:Find("bowl_shine")
		var_14_2.btnRule = var_14_1:Find("btnRule")
		var_14_2.layerRule = var_14_1:Find("rule")
		var_14_2.btnReturn = var_14_2.layerRule:Find("btnReturn")
		var_14_2.item = var_14_2.layerRule:Find("item")
		var_14_2.top = var_14_2.layerRule:Find("top")
		var_14_2.itemRow = var_14_2.layerRule:Find("row")
		var_14_2.itemColumn = var_14_2.layerRule:Find("column")

		setActive(var_14_2.layerRule, false)
		setActive(var_14_2.item, false)
		setActive(var_14_2.itemRow, false)
		setActive(var_14_2.itemColumn, true)

		local var_14_3 = pg.gameset.bb_front_awards.description[1]
		local var_14_4 = _.slice(pg.gameset.bb_front_awards.description, 2, #pg.gameset.bb_front_awards.description - 1)
		local var_14_5 = UIItemList.New(var_14_2.top, var_14_2.item)

		var_14_5:make(function(arg_15_0, arg_15_1, arg_15_2)
			if arg_15_0 == UIItemList.EventUpdate then
				updateDrop(arg_15_2, {
					type = var_14_3[arg_15_1 + 1][1],
					id = var_14_3[arg_15_1 + 1][2],
					count = var_14_3[arg_15_1 + 1][3]
				})
				onButton(arg_14_0, arg_15_2, function()
					arg_14_0:emit(BaseUI.ON_DROP, var_0)

					return
				end, SFX_PANEL)
			end

			return
		end)
		var_14_5:align(#pg.gameset.bb_front_awards.description[1])

		local var_14_6 = UIItemList.New(var_14_2.itemColumn, var_14_2.itemRow)

		var_14_6:make(function(arg_17_0, arg_17_1, arg_17_2)
			if arg_17_0 == UIItemList.EventUpdate then
				local var_17_0 = var_14_4[arg_17_1 + 1]
				local var_17_1 = UIItemList.New(arg_17_2, var_14_2.item)

				var_17_1:make(function(arg_18_0, arg_18_1, arg_18_2)
					if arg_18_0 == UIItemList.EventUpdate then
						updateDrop(arg_18_2, {
							type = var_17_0[arg_18_1 + 1][1],
							id = var_17_0[arg_18_1 + 1][2],
							count = var_17_0[arg_18_1 + 1][3]
						})
						onButton(arg_14_0, arg_18_2, function()
							arg_14_0:emit(BaseUI.ON_DROP, var_0)

							return
						end, SFX_PANEL)
					end

					return
				end)
				var_17_1:align(#var_14_4[arg_17_1 + 1])
			end

			return
		end)
		var_14_6:align(#_.slice(pg.gameset.bb_front_awards.description, 2, #pg.gameset.bb_front_awards.description - 1))
		onButton(arg_14_0, var_14_2.btnRule, function()
			setActive(var_14_2.layerRule, true)

			return
		end, SFX_PANEL)
		onButton(arg_14_0, var_14_2.btnReturn, function()
			setActive(var_14_2.layerRule, false)

			return
		end, SFX_CANCEL)
		onButton(arg_14_0, var_14_2.bowlEnable, function()
			arg_14_0:emit(ActivityMainScene.LOCK_ACT_MAIN, true)
			arg_14_0:displayBBAnim(function()
				arg_14_0:emit(ActivityMediator.EVENT_OPERATION, {
					cmd = 1,
					activity_id = var_14_0.id
				})

				return
			end)

			return
		end, SFX_PANEL)

		arg_14_0.bobingWrap = var_14_2
	end

	local var_14_7 = arg_14_0.activity:getConfig("config_id")

	setActive(var_14_2.layerRule, false)
	setActive(var_14_2.get, var_14_7 <= arg_14_0.activity.data1)
	setActive(var_14_2.bowlDisable, arg_14_0.activity.data2 == 0)
	setActive(var_14_2.bowlEnable, arg_14_0.activity.data2 > 0)

	if arg_14_0.activity.data2 < 1 then
		LeanTween.alpha(var_14_2.bowlShine, 1, 1):setLoopPingPong()
	else
		LeanTween.cancel(var_14_2.bowlShine.gameObject)
	end

	setText(var_14_2.progress, string.format("<color=#%s>%s</color> %s", "FFD43F", math.min(arg_14_0.activity.data1, var_14_7) .. "/", var_14_7))
	setActive(var_14_2.progress, var_14_7 > arg_14_0.activity.data1)
	setText(var_14_2.nums, string.format("<color=#%s>%s</color>", var_14_8, arg_14_0.activity.data2))

	return
end

function var_0_0.displayBBAnim(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._tf:Find("bobing/bb_anim")
	local var_24_1 = var_24_0:Find("ship")
	local var_24_2 = var_24_0:Find("bowl")

	if not arg_24_0.animBowl then
		arg_24_0.animBowl = var_24_0:Find("bowl"):GetComponent(typeof(SpineAnimUI))

		arg_24_0.animBowl:SetAction("bobing", 0)
		arg_24_0.animBowl:SetActionCallBack(function(arg_25_0)
			if arg_25_0 == "finsih" then
				setActive(var_24_1, false)
				setActive(var_24_2, false)
				arg_24_1()
			end

			return
		end)
	end

	local function var_24_3()
		setActive(var_24_1, true)
		setActive(var_24_2, true)
		arg_24_0.model:GetComponent(typeof(SpineAnimUI)):SetAction("victory", 0)

		return
	end

	if not arg_24_0.model then
		PoolMgr.GetInstance():GetSpineChar(getProxy(BayProxy):getShipById(getProxy(PlayerProxy):getRawData().character):getPrefab(), false, function(arg_27_0)
			arg_24_0.model = arg_27_0
			arg_24_0.model.transform.localScale = Vector3(0.5, 0.5, 1)

			arg_24_0.model.transform:SetParent(var_24_1, false)
			var_24_3()

			return
		end)
	else
		var_24_3()
	end

	setActive(var_24_0, true)

	return
end

function var_0_0.displayBBResult(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_0.animation = findTF(arg_28_0._tf, "bobing")

	setActive(arg_28_0.animation:Find("bb_anim"), false)

	local var_28_0 = arg_28_0.animation:Find("bb_result")
	local var_28_1 = var_28_0:Find("numbers")
	local var_28_2 = var_28_0:Find("number")
	local var_28_3 = var_28_0:Find("rank")
	local var_28_4 = var_28_0:Find("bgRank")

	setActive(var_28_2, false)

	local var_28_5 = var_28_0:Find("award")
	local var_28_6 = var_28_0:Find("award_list")

	setActive(var_28_5, false)
	removeAllChildren(var_28_6)

	if arg_28_1 then
		for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
			local var_28_7 = cloneTplTo(var_28_5, var_28_6)

			updateDrop(var_28_7, {
				type = iter_28_1.type,
				id = iter_28_1.id,
				count = iter_28_1.count
			})
			onButton(arg_28_0, var_28_7, function()
				arg_28_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end
	end

	local var_28_8 = UIItemList.New(var_28_1, var_28_2)

	var_28_8:make(function(arg_30_0, arg_30_1, arg_30_2)
		if arg_30_0 == UIItemList.EventUpdate then
			arg_28_0:setSpriteTo("bobing/bb_icon/dice" .. arg_28_2[arg_30_1 + 1], arg_30_2)
			setImageAlpha(arg_30_2, 0)
		end

		return
	end)
	var_28_8:align(#arg_28_2)

	local var_28_9 = ActivityConst.BBRule(arg_28_2)

	setActive(var_28_3, var_28_9 < 7)
	setActive(var_28_4, var_28_9 < 7)

	if var_28_9 < 7 then
		arg_28_0:setSpriteTo("bobing/bb_icon/rank" .. var_28_9, var_28_3)
		setImageAlpha(var_28_3, 0)
	end

	local var_28_10 = false

	if var_28_9 == 7 then
		LeanTween.value(go(var_28_1), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_31_0)
			var_28_8:each(function(arg_32_0, arg_32_1)
				setImageAlpha(arg_32_1, arg_31_0)

				return
			end)

			return
		end)):setOnComplete(System.Action(function()
			arg_28_0:emit(ActivityMainScene.LOCK_ACT_MAIN, false)

			var_28_10 = true

			return
		end))
	else
		LeanTween.value(go(var_28_3), 0, 1, 0.2):setDelay(1):setOnUpdate(System.Action_float(function(arg_34_0)
			setImageAlpha(var_28_3, arg_34_0)

			var_28_3.localScale = Vector3.Lerp(Vector3(2, 2, 2), Vector3.one, arg_34_0)

			return
		end))

		local var_28_11 = var_28_0:Find("rank_p") or cloneTplTo(var_28_3, var_28_0, "rank_p")

		arg_28_0:setSpriteTo("bobing/bb_icon/rank" .. var_28_9, var_28_11)
		arg_28_0:setSpriteTo("bobing/bb_icon/rank" .. var_28_9, var_28_3)
		LeanTween.value(go(var_28_11), 1, 0, 0.3):setDelay(1.5):setOnUpdate(System.Action_float(function(arg_35_0)
			setImageAlpha(var_28_11, arg_35_0)

			var_28_11.localScale = Vector3.Lerp(Vector3(2, 2, 2), Vector3.one, arg_35_0)

			return
		end)):setOnComplete(System.Action(function()
			arg_28_0:emit(ActivityMainScene.LOCK_ACT_MAIN, false)

			var_28_10 = true

			return
		end))
	end

	setActive(var_28_0, true)
	onButton(arg_28_0, var_28_0, function()
		if var_28_10 then
			setActive(var_28_0, false)
			arg_28_3()
		end

		return
	end)

	return
end

function var_0_0.setSpriteTo(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_2:GetComponent(typeof(Image))

	var_38_0.sprite = arg_38_0._tf:Find(arg_38_1):GetComponent(typeof(Image)).sprite

	if arg_38_3 then
		var_38_0:SetNativeSize()
	end

	return
end

function var_0_0.OnDestroy(arg_39_0)
	if arg_39_0.bobingWrap then
		clearImageSprite(arg_39_0.bobingWrap.bg)
		LeanTween.cancel(arg_39_0.bobingWrap.bowlShine.gameObject)
	end

	return
end

return var_0_0
