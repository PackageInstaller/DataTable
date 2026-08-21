local var_0_0 = class("RefluxSignView", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "RefluxSignUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:updateUI()
	arg_2_0:tryAutoSign()

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
	arg_5_0.dayAwardList = arg_5_0:getAllAwardList()
	arg_5_0.totalSignCount = #pg.return_sign_template.all

	return
end

function var_0_0.initUI(arg_6_0)
	local var_6_0 = arg_6_0._tf:Find("DayImg")

	arg_6_0.daySpriteList = {}

	for iter_6_0 = 0, arg_6_0.totalSignCount - 1 do
		table.insert(arg_6_0.daySpriteList, (getImageSprite((var_6_0:GetChild(iter_6_0)))))
	end

	arg_6_0.dayTpl = arg_6_0._tf:Find("DayTpl")
	arg_6_0.scrollRectTF = arg_6_0._tf:Find("ScrollRect")
	arg_6_0.dayContainerTF = arg_6_0._tf:Find("ScrollRect/Container")
	arg_6_0.signCountText = arg_6_0._tf:Find("DayCount/Text")
	arg_6_0.dayUIItemList = UIItemList.New(arg_6_0.dayContainerTF, arg_6_0.dayTpl)

	arg_6_0.dayUIItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = arg_7_2:Find("DayImg")
			local var_7_1 = arg_7_2:Find("Got")
			local var_7_2 = arg_7_2:Find("GotMask")

			arg_7_1 = arg_7_1 + 1

			for iter_7_0, iter_7_1 in ipairs({
				arg_7_2:Find("Item1/Icon"),
				arg_7_2:Find("Item2/Icon"),
				(arg_7_2:Find("Item3/Icon"))
			}) do
				if arg_6_0.dayAwardList[arg_7_1][iter_7_0].type ~= DROP_TYPE_SHIP then
					setImageSprite(iter_7_1, LoadSprite(arg_6_0.dayAwardList[arg_7_1][iter_7_0]:getIcon()))
				else
					local var_7_3 = Ship.New({
						configId = arg_6_0.dayAwardList[arg_7_1][iter_7_0].id
					})

					setImageSprite(iter_7_1, LoadSprite("QIcon/" .. var_7_3:getPainting()))
				end
			end

			local var_7_4 = arg_7_1 <= arg_6_0.refluxProxy.signCount

			setActive(var_7_1, arg_7_1 <= arg_6_0.refluxProxy.signCount)
			setActive(var_7_2, var_7_4)
			setImageSprite(var_7_0, arg_6_0.daySpriteList[arg_7_1])
		end

		return
	end)

	arg_6_0.scrollSC = arg_6_0.scrollRectTF:GetComponent(typeof(ScrollRect))
	arg_6_0.hlgSC = arg_6_0.dayContainerTF:GetComponent(typeof(HorizontalLayoutGroup))
	arg_6_0.hlgLeft = arg_6_0.hlgSC.padding.left
	arg_6_0.hlgSpacing = arg_6_0.hlgSC.spacing
	arg_6_0.tplWidth = arg_6_0.dayTpl:GetComponent(typeof(LayoutElement)).preferredWidth

	return
end

function var_0_0.updateUI(arg_8_0)
	setText(arg_8_0.signCountText, arg_8_0.refluxProxy.signCount)
	arg_8_0.dayUIItemList:align(arg_8_0.totalSignCount)
	arg_8_0:autoScroll(arg_8_0.refluxProxy.signCount)

	return
end

function var_0_0.updateOutline(arg_9_0)
	return
end

function var_0_0.getAllAwardList(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(pg.return_sign_template.all) do
		for iter_10_2, iter_10_3 in ipairs(pg.return_sign_template[iter_10_1].award_display[arg_10_0:getLevelIndex(arg_10_0.refluxProxy.returnLV, pg.return_sign_template[iter_10_1].level)]) do
			table.insert({}, (Drop.Create(iter_10_3)))
		end

		table.insert({}, {})
	end

	return {}
end

function var_0_0.getLevelIndex(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
		if iter_11_1[1] <= arg_11_1 and arg_11_1 <= iter_11_1[2] then
			return iter_11_0
		end
	end

	return
end

function var_0_0.tryAutoSign(arg_12_0)
	if arg_12_0.refluxProxy:isCanSign() then
		pg.m02:sendNotification(GAME.REFLUX_SIGN)
	end

	return
end

function var_0_0.autoScroll(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.dayContainerTF.childCount

	arg_13_0.scrollSC.horizontalNormalizedPosition = math.clamp(arg_13_1 == 1 and 0 or arg_13_1 == arg_13_0.dayContainerTF.childCount and 1 or arg_13_1 / var_13_0, 0, 1)

	return
end

return var_0_0
