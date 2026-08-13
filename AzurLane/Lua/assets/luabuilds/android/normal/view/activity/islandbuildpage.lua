class = var_0_10000

local var_0_0 = var_0_10000("IslandBuildPage")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.buildPanel = arg_1_1
	ActivityConst = var_1_10003
	arg_1_0.activityId = var_1_10003.ISLAND_TASK_ID
	pg = var_3

	if var_3.activity_template[arg_1_0.activityId].config_client.pt_id and var_3.pt_id > 0 then
		arg_1_0.ptId = var_3.pt_id
		pg = var_4
		arg_1_0.ptName = var_4.player_resource[arg_1_0.ptId].name
	end

	arg_1_0.buffs = var_3.buff
	arg_1_0.maxNum = arg_1_0.buffs[#arg_1_0.buffs].pt[1]
	setActive = var_4

	var_4(arg_1_0.buildPanel, false)

	findTF = var_4
	arg_1_0.pointProgressText = var_4(arg_1_0.buildPanel, "progressContent/progress")
	findTF = var_4
	arg_1_0.pointProgressSlider = var_4(arg_1_0.buildPanel, "slider")
	findTF = var_4
	arg_1_0.pointStarTpl = var_4(arg_1_0.buildPanel, "levelStar/starTpl")
	findTF = var_4
	arg_1_0.pointAdd = var_4(arg_1_0.buildPanel, "add")
	findTF = var_4
	arg_1_0.pointLevelStar = var_4(arg_1_0.buildPanel, "levelStar")
	arg_1_0.pointStarTfs = {}

	local var_1_0 = arg_1_0.pointLevelStar.sizeDelta.x

	for iter_1_0 = 1, #arg_1_0.buffs do
		tf = var_1_10009
		Instantiate = var_1_10010
		var_1_10009 = var_1_10009(var_1_10010(arg_1_0.pointStarTpl))
		SetParent = var_1_10010

		var_1_10010(var_1_10009, arg_1_0.pointLevelStar)

		setActive = var_1_10010

		var_1_10010(var_1_10009, true)

		setText = var_1_10010
		findTF = var_11

		var_1_10010(var_11(var_1_10009, "bg/text"), iter_1_0)

		setImageSprite = var_1_10010
		findTF = var_11

		local var_1_1 = var_11(var_1_10009, "img")

		LoadSprite = var_12
		IslandTaskScene = var_13

		var_1_10010(var_1_1, var_12(var_13.ui_atlas, "img_level_" .. iter_1_0))

		var_1_10010 = arg_1_0.buffs[iter_1_0].pt[1]
		Vector3 = var_1_1
		var_1_10009.anchoredPosition = var_1_1(var_1_10010 / arg_1_0.maxNum * var_1_0, 0, 0)
		table = var_11

		var_11.insert(arg_1_0.pointStarTfs, var_1_10009)

		if iter_1_0 == 1 then
			setActive = var_11

			var_11(var_1_10009, false)
		end
	end

	setText = var_5
	findTF = var_6

	local var_1_2 = var_6(arg_1_0.buildPanel, "levelNum/text")

	i18n = var_7
	IslandTaskScene = var_8

	var_5(var_1_2, var_7(var_8.island_build_level))

	setText = var_5
	findTF = var_1_2

	local var_1_3 = var_1_2(arg_1_0.buildPanel, "levelBuff/text")

	i18n = var_7
	IslandTaskScene = var_8

	var_5(var_1_3, var_7(var_8.island_build_level))

	setText = var_5
	findTF = var_1_3

	local var_1_4 = var_1_3(arg_1_0.buildPanel, "buildDesc")

	i18n = var_7
	IslandTaskScene = var_8

	var_5(var_1_4, var_7(var_8.island_build_desc))
	arg_1_0:updatePoint()

	return
end

function var_0_0.updatePoint(arg_2_0)
	local var_2_0 = 0
	local var_2_1 = 1

	if arg_2_0.ptId then
		getProxy = var_3
		PlayerProxy = var_1_10004

		local var_2_2 = var_3(var_1_10004)

		var_2_0 = var_3.getData(var_2_2)[arg_2_0.ptName] or 0
	else
		var_2_0 = arg_2_0:getNum()
	end

	if var_2_0 > arg_2_0.maxNum then
		var_2_0 = arg_2_0.maxNum
	end

	local var_2_3 = arg_2_0:getBuildLv(var_2_0)

	for iter_2_0 = 1, #arg_2_0.pointStarTfs do
		local var_2_4 = arg_2_0.pointStarTfs[iter_2_0]

		if iter_2_0 <= var_2_3 then
			setActive = var_1_10008
			findTF = var_1_10009

			var_1_10008(var_1_10009(var_2_4, "img"), true)

			setActive = var_1_10008
			findTF = var_1_10009

			var_1_10008(var_1_10009(var_2_4, "lock"), false)

			GetComponent = var_1_10008
			var_1_10009 = var_2_4
			typeof = var_1_10010
			CanvasGroup = var_11
			var_1_10008 = var_1_10008(var_1_10009, var_1_10010(var_11))
			var_1_10008.alpha = 1
		else
			setActive = var_1_10008
			findTF = var_1_10009

			var_1_10008(var_1_10009(var_2_4, "img"), false)

			setActive = var_1_10008
			findTF = var_1_10009

			var_1_10008(var_1_10009(var_2_4, "lock"), true)

			GetComponent = var_1_10008
			var_1_10009 = var_2_4
			typeof = var_1_10010
			CanvasGroup = var_11
			var_1_10008 = var_1_10008(var_1_10009, var_1_10010(var_11))
			var_1_10008.alpha = 0.5
		end
	end

	local var_2_5 = arg_2_0.buffs[var_2_3].benefit

	for iter_2_1 = 1, #var_2_5 do
		local var_2_6 = var_2_5[iter_2_1]

		pg = var_1_10009
		var_1_10009 = var_1_10009.benefit_buff_template[var_2_6].desc
		findTF = var_1_10010
		var_1_10010 = var_1_10010(arg_2_0.buildPanel, "add/" .. iter_2_1)
		PLATFORM_CODE = var_2_7
		PLATFORM_JP = var_12

		local var_2_7

		if var_2_7 == var_12 then
			findTF = var_2_7
			var_2_7 = var_2_7(var_1_10010, "img")
			Vector2 = var_12
			var_2_7.sizeDelta = var_12(450, 70)
			setText = var_2_7
			findTF = var_12

			var_2_7(var_12(var_1_10010, "text_jp"), var_1_10009)
		else
			setText = var_2_7
			findTF = var_12

			var_2_7(var_12(var_1_10010, "text"), var_1_10009)
		end
	end

	setSlider = var_4

	var_4(arg_2_0.pointProgressSlider, 0, arg_2_0.maxNum, var_2_0)

	setText = var_4
	findTF = var_5

	var_4(var_5(arg_2_0.buildPanel, "levelNum/num"), "Lv." .. var_2_3)

	setText = var_4
	findTF = var_5

	var_4(var_5(arg_2_0.buildPanel, "levelBuff/num"), "Lv." .. var_2_3)
	arg_2_0:setProgressText()

	return
end

function var_0_0.getBuildLv(arg_3_0, arg_3_1)
	local var_3_0 = 1

	for iter_3_0 = #arg_3_0.buffs, 1, -1 do
		var_3_0 = arg_3_1 >= arg_3_0.buffs[iter_3_0].pt[1] and var_3_0 < iter_3_0 and iter_3_0 or var_3_0
	end

	return var_3_0
end

function var_0_0.setProgressText(arg_4_0)
	local var_4_0 = arg_4_0:getNum()
	local var_4_1 = arg_4_0.maxNum

	setText = var_1_10003

	local var_4_2 = arg_4_0.pointProgressText

	setColorStr = var_1_10005

	local var_4_3 = var_1_10005(var_4_0, "#C2695B")

	setColorStr = var_6

	var_1_10003(var_4_2, var_4_3 .. var_6("/" .. var_4_1, "#9D6B59"))

	return
end

function var_0_0.getNum(arg_5_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_5_0 = var_1_10001(var_1_10002)
	local var_5_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_5_2 = var_5_1(var_5_0, var_1_10003.ACTIVITY_TYPE_BUILDING_BUFF_2)

	return var_1.GetBuildingLevelSum(var_5_2)
end

function var_0_0.setActive(arg_6_0, arg_6_1)
	setActive = var_1_10002

	var_1_10002(arg_6_0.buildPanel, arg_6_1)

	return
end

function var_0_0.dispose(arg_7_0)
	return
end

return var_0_0
