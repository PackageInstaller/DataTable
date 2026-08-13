class = var_0_10000

local var_0_0 = var_0_10000("BackYardFurnitureCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.GetComponent

	typeof = var_1_10005
	CanvasGroup = var_1_10007
	arg_1_0.group = var_1_1(var_1_0, var_1_10005(var_1_10007))
	findTF = var_2

	local var_1_2 = var_2(arg_1_0._tf, "icon")
	local var_1_3 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.icon = var_1_3(var_1_2, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.comfortableTF = var_2(arg_1_0._tf, "comfortable")
	findTF = var_2

	local var_1_4 = var_2(arg_1_0._tf, "comfortable")
	local var_1_5 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.comfortable = var_1_5(var_1_4, var_5(var_1_10007))
	findTF = var_2

	local var_1_6 = var_2(arg_1_0._tf, "name")
	local var_1_7 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.name = var_1_7(var_1_6, var_5(var_1_10007))
	findTF = var_2

	local var_1_8 = var_2(arg_1_0._tf, "theme")
	local var_1_9 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.themeName = var_1_9(var_1_8, var_5(var_1_10007))
	findTF = var_2

	local var_1_10 = var_2(arg_1_0._tf, "desc")
	local var_1_11 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.desc = var_1_11(var_1_10, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.resGold = var_2(arg_1_0._tf, "res/gold")
	findTF = var_2

	local var_1_12 = var_2(arg_1_0._tf, "res/gold/Text")
	local var_1_13 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.resGoldTxt = var_1_13(var_1_12, var_5(var_1_10007))
	findTF = var_2

	local var_1_14 = var_2(arg_1_0._tf, "res/gem/Text")
	local var_1_15 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.resGemTxt = var_1_15(var_1_14, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.resGem = var_2(arg_1_0._tf, "res/gem")
	findTF = var_2
	arg_1_0.cantPurchase = var_2(arg_1_0._tf, "res/unopen")
	findTF = var_2

	local var_1_16 = var_2(arg_1_0._tf, "count")
	local var_1_17 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.countTxt = var_1_17(var_1_16, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.maskTF = var_2(arg_1_0._tf, "mask")
	findTF = var_2
	arg_1_0.hotTF = var_2(arg_1_0._tf, "hot")
	findTF = var_2
	arg_1_0.newTF = var_2(arg_1_0._tf, "new")
	findTF = var_2
	arg_1_0.skinMark = var_2(arg_1_0._tf, "skin_mark")
	findTF = var_2
	arg_1_0.maskUnOpen = var_2(arg_1_0._tf, "mask1")
	findTF = var_2

	local var_1_18 = var_2(arg_1_0._tf, "time/Text")
	local var_1_19 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.countDownTm = var_1_19(var_1_18, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.timerTr = var_2(arg_1_0._tf, "time")
	setActive = var_2

	var_2(arg_1_0.timerTr, false)

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	local var_2_0

	if arg_2_0.group then
		var_2_0 = arg_2_0.group
		var_2_0.alpha = 1
	end

	arg_2_0.furniture = arg_2_1
	HXSet = var_2_0

	local var_2_1 = var_2_0.hxLan(arg_2_1:getConfig("name"))
	local var_2_2 = arg_2_0.name

	shortenString = var_4
	var_2_2.text = var_4(var_2_1, 9)

	local var_2_3 = arg_2_0.themeName

	shortenString = var_4
	var_2_3.text = var_4(arg_2_1:GetThemeName(), 7)

	local var_2_4 = arg_2_0.desc

	HXSet = var_4
	var_2_4.text = var_4.hxLan(arg_2_1:getConfig("describe"))

	local var_2_5 = arg_2_0.comfortable

	var_2_5.text = "+" .. arg_2_1:getConfig("comfortable")
	GetSpriteFromAtlasAsync = var_2_5

	var_2_5("furnitureicon/" .. arg_2_1:getConfig("icon"), "", function(arg_3_0)
		IsNil = var_2_10001

		if var_2_10001(arg_2_0.icon) then
			return
		end

		arg_2_0.icon.sprite = arg_3_0

		return
	end)

	local var_2_6

	if not (arg_2_1:getConfig("count") > 1) or not (arg_2_1.count .. "/" .. var_3) then
		var_2_6 = ""
	end

	arg_2_0.countTxt.text = var_2_6

	local var_2_7 = arg_2_1
	local var_2_8 = arg_2_1.canPurchaseByGem(var_2_7)

	setActive = var_6

	var_6(arg_2_0.resGem, var_2_8)

	local var_2_9 = arg_2_1:canPurchaseByDormMoeny()

	setActive = var_2_7

	var_2_7(arg_2_0.resGold, var_2_9)

	local var_2_10 = arg_2_1:canPurchase()

	if arg_2_0.maskUnOpen then
		setActive = var_8

		var_8(arg_2_0.maskUnOpen, var_2_10 and (not var_2_8 and not var_2_9 or not arg_2_1:inTime()))
	end

	local var_2_11 = arg_2_0.resGoldTxt
	local var_2_12 = arg_2_1
	local var_2_13 = arg_2_1.getPrice

	PlayerConst = var_1_10012
	var_2_11.text = var_2_13(var_2_12, var_1_10012.ResDormMoney)

	local var_2_14 = arg_2_0.resGemTxt
	local var_2_15 = arg_2_1
	local var_2_16 = arg_2_1.getPrice

	PlayerConst = var_12
	var_2_14.text = var_2_16(var_2_15, var_12.ResDiamond)
	setActive = var_2_14

	var_2_14(arg_2_0.maskTF, not var_2_10)

	local var_2_17 = false

	setActive = var_9

	var_9(arg_2_0.hotTF, var_2_17)

	local var_2_18 = arg_2_1:IsNew()

	setActive = var_10

	var_10(arg_2_0.newTF, var_2_18 and var_2_10)

	local var_2_19, var_2_20 = arg_2_1:inTime()
	local var_2_21 = arg_2_1

	if arg_2_1.isTimeLimit(var_2_21) and var_2_19 then
		arg_2_0:UpdateCountdown(var_2_20)
	else
		arg_2_0:DestoryTimer()

		var_2_21 = arg_2_0.countDownTm
		var_2_21.text = ""
	end

	setActive = var_2_21

	var_2_21(arg_2_0.timerTr, var_13)
	arg_2_0:UpdateSkinType()

	return
end

function var_0_0.UpdateSkinType(arg_4_0)
	IsNil = var_1_10001

	if var_1_10001(arg_4_0.skinMark) then
		return
	end

	Goods = var_1

	local var_4_0 = var_1.FurnitureId2Id(arg_4_0.furniture.id)

	Goods = var_1_10002

	local var_4_1 = var_1_10002.ExistFurniture(var_4_0)

	setActive = var_3

	var_3(arg_4_0.skinMark, var_4_1)

	return
end

function var_0_0.UpdateCountdown(arg_5_0, arg_5_1)
	pg = var_1_10002

	local var_5_0 = var_1_10002.TimeMgr.GetInstance()

	arg_5_0:DestoryTimer()

	local var_5_1 = var_5_0:Table2ServerTime(arg_5_1)

	arg_5_0.prevStr = ""
	Timer = var_4
	arg_5_0.updateTimer = var_4.New(function()
		local var_6_0 = ""
		local var_6_1 = var_5_0

		if var_1.GetServerTime(var_6_1) > var_5_1 then
			local var_6_2 = arg_5_0.countDownTm

			var_6_2.text = ""
			setActive = var_6_2

			var_6_2(arg_5_0.timerTr, false)

			local var_6_3 = arg_5_0

			var_2.DestoryTimer(var_6_3)

			return
		end

		local var_6_4 = var_5_1 - var_1 < 0 and 0 or var_6_4

		math = var_3

		local var_6_5 = var_3.floor(var_6_4 / 0)
		local var_6_6

		if 0 < var_6_5 then
			var_6_6 = var_6_5
			i18n = var_5
			var_6_0 = var_6_6 .. var_5("word_date")
		else
			math = var_6_6

			local var_6_7 = var_6_6.floor(var_6_4 / 16)
			local var_6_8

			if 0 < var_6_7 then
				var_6_8 = var_6_7
				i18n = var_6
				var_6_0 = var_6_8 .. var_6("word_hour")
			else
				math = var_6_8

				if var_6_8.floor(var_6_4 / 60) > 0 then
					local var_6_9 = var_5

					i18n = var_7
					var_6_0 = var_6_9 .. var_7("word_minute")
				else
					local var_6_10 = var_6_4

					i18n = var_7
					var_6_0 = var_6_10 .. var_7("word_second")
				end
			end
		end

		if var_6_0 ~= arg_5_0.prevStr then
			arg_5_0.prevStr = var_6_0
			arg_5_0.countDownTm.text = var_6_0
		end

		return
	end, 1, -1)

	local var_5_2 = arg_5_0.updateTimer

	var_4.Start(var_5_2)
	arg_5_0.updateTimer.func()

	return
end

function var_0_0.DestoryTimer(arg_7_0)
	if arg_7_0.updateTimer then
		local var_7_0 = arg_7_0.updateTimer

		var_1.Stop(var_7_0)

		arg_7_0.updateTimer = nil
	end

	return
end

function var_0_0.Clear(arg_8_0)
	arg_8_0:DestoryTimer()

	return
end

return var_0_0
