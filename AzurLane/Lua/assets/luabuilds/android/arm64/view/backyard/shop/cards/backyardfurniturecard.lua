local var_0_0 = class("BackYardFurnitureCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.group = arg_1_0._tf:GetComponent(typeof(CanvasGroup))
	arg_1_0.icon = findTF(arg_1_0._tf, "icon"):GetComponent(typeof(Image))
	arg_1_0.comfortableTF = findTF(arg_1_0._tf, "comfortable")
	arg_1_0.comfortable = findTF(arg_1_0._tf, "comfortable"):GetComponent(typeof(Text))
	arg_1_0.name = findTF(arg_1_0._tf, "name"):GetComponent(typeof(Text))
	arg_1_0.themeName = findTF(arg_1_0._tf, "theme"):GetComponent(typeof(Text))
	arg_1_0.desc = findTF(arg_1_0._tf, "desc"):GetComponent(typeof(Text))
	arg_1_0.resGold = findTF(arg_1_0._tf, "res/gold")
	arg_1_0.resGoldTxt = findTF(arg_1_0._tf, "res/gold/Text"):GetComponent(typeof(Text))
	arg_1_0.resGemTxt = findTF(arg_1_0._tf, "res/gem/Text"):GetComponent(typeof(Text))
	arg_1_0.resGem = findTF(arg_1_0._tf, "res/gem")
	arg_1_0.cantPurchase = findTF(arg_1_0._tf, "res/unopen")
	arg_1_0.countTxt = findTF(arg_1_0._tf, "count"):GetComponent(typeof(Text))
	arg_1_0.maskTF = findTF(arg_1_0._tf, "mask")
	arg_1_0.hotTF = findTF(arg_1_0._tf, "hot")
	arg_1_0.newTF = findTF(arg_1_0._tf, "new")
	arg_1_0.skinMark = findTF(arg_1_0._tf, "skin_mark")
	arg_1_0.maskUnOpen = findTF(arg_1_0._tf, "mask1")
	arg_1_0.countDownTm = findTF(arg_1_0._tf, "time/Text"):GetComponent(typeof(Text))
	arg_1_0.timerTr = findTF(arg_1_0._tf, "time")

	setActive(arg_1_0.timerTr, false)

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	if arg_2_0.group then
		arg_2_0.group.alpha = 1
	end

	arg_2_0.furniture = arg_2_1
	arg_2_0.name.text = shortenString(HXSet.hxLan(arg_2_1:getConfig("name")), 9)
	arg_2_0.themeName.text = shortenString(arg_2_1:GetThemeName(), 7)
	arg_2_0.desc.text = HXSet.hxLan(arg_2_1:getConfig("describe"))
	arg_2_0.comfortable.text = "+" .. arg_2_1:getConfig("comfortable")

	GetSpriteFromAtlasAsync("furnitureicon/" .. arg_2_1:getConfig("icon"), "", function(arg_3_0)
		if IsNil(arg_2_0.icon) then
			return
		end

		arg_2_0.icon.sprite = arg_3_0

		return
	end)

	local var_2_0 = arg_2_1:getConfig("count")

	if var_2_0 > 1 then
		arg_2_0.countTxt.text = arg_2_1.count .. "/" .. var_2_0 or ""

		local var_2_1 = arg_2_1:canPurchaseByGem()

		setActive(arg_2_0.resGem, var_2_1)

		local var_2_2 = arg_2_1:canPurchaseByDormMoeny()

		setActive(arg_2_0.resGold, var_2_2)

		local var_2_3 = arg_2_1:canPurchase()

		if arg_2_0.maskUnOpen then
			setActive(arg_2_0.maskUnOpen, var_2_3 and (not var_2_1 and not var_2_2 or not arg_2_1:inTime()))
		end

		arg_2_0.resGoldTxt.text = arg_2_1:getPrice(PlayerConst.ResDormMoney)
		arg_2_0.resGemTxt.text = arg_2_1:getPrice(PlayerConst.ResDiamond)

		setActive(arg_2_0.maskTF, not var_2_3)
		setActive(arg_2_0.hotTF, false)
		setActive(arg_2_0.newTF, arg_2_1:IsNew() and var_2_3)

		local var_2_4, var_2_5 = arg_2_1:inTime()
		local var_2_6 = arg_2_1:isTimeLimit() and var_2_4

		if var_2_6 then
			arg_2_0:UpdateCountdown(var_2_5)
		else
			arg_2_0:DestoryTimer()

			arg_2_0.countDownTm.text = ""
		end

		setActive(arg_2_0.timerTr, var_2_6)
		arg_2_0:UpdateSkinType()

		return
	end
end

function var_0_0.UpdateSkinType(arg_4_0)
	if IsNil(arg_4_0.skinMark) then
		return
	end

	setActive(arg_4_0.skinMark, (Goods.ExistFurniture((Goods.FurnitureId2Id(arg_4_0.furniture.id)))))

	return
end

function var_0_0.UpdateCountdown(arg_5_0, arg_5_1)
	local var_5_0 = pg.TimeMgr.GetInstance()

	arg_5_0:DestoryTimer()

	local var_5_1 = pg.TimeMgr.GetInstance():Table2ServerTime(arg_5_1)

	arg_5_0.prevStr = ""
	arg_5_0.updateTimer = Timer.New(function()
		local var_6_0 = ""
		local var_6_1 = var_5_0:GetServerTime()

		if var_6_1 > var_5_1 then
			arg_5_0.countDownTm.text = ""

			setActive(arg_5_0.timerTr, false)
			arg_5_0:DestoryTimer()

			return
		end

		local var_6_2 = var_5_1 - var_6_1

		var_6_2 = var_5_1 - var_6_1 < 0 and 0 or var_6_2

		local var_6_3 = math.floor(var_6_2 / 0)

		if var_6_3 > 0 then
			var_6_0 = var_6_3 .. i18n("word_date")
		else
			local var_6_4 = math.floor(var_6_2 / 16)

			if var_6_4 > 0 then
				var_6_0 = var_6_4 .. i18n("word_hour")
			else
				local var_6_5 = math.floor(var_6_2 / 60)

				var_6_0 = var_6_5 > 0 and var_6_5 .. i18n("word_minute") or var_6_2 .. i18n("word_second")
			end
		end

		if var_6_0 ~= arg_5_0.prevStr then
			arg_5_0.prevStr = var_6_0
			arg_5_0.countDownTm.text = var_6_0
		end

		return
	end, 1, -1)

	arg_5_0.updateTimer:Start()
	arg_5_0.updateTimer.func()

	return
end

function var_0_0.DestoryTimer(arg_7_0)
	if arg_7_0.updateTimer then
		arg_7_0.updateTimer:Stop()

		arg_7_0.updateTimer = nil
	end

	return
end

function var_0_0.Clear(arg_8_0)
	arg_8_0:DestoryTimer()

	return
end

return var_0_0
