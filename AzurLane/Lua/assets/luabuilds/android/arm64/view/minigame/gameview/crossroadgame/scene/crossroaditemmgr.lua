class = var_0_10000

local var_0_0 = var_0_10000("CrossRoadItemMgr")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tpl = arg_1_1
	arg_1_0._runningData = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0.time = 0
	arg_1_0.itemListTF = arg_1_2:GetItemListTF()
	arg_1_0.itemListTpl = arg_1_2:GetAllItemTpl()
	CrossRoadGameConst = var_4
	arg_1_0.xuanWoLifeTime = var_4.XUANWO_LIFE_TIME
	CrossRoadGameConst = var_4
	arg_1_0.binLifeTime = var_4.BINGMIAN_LIFE_TIME
	CrossRoadGameConst = var_4
	arg_1_0.makeHongChaTime = var_4.GAME_TIME
	arg_1_0.hongChaTF = arg_1_2:GetHongChaTF()
	arg_1_0.hongChaItem = arg_1_0.itemListTpl[1]
	arg_1_0.sceneContent = arg_1_2:GetItemScene()
	arg_1_0.itemGoList = {}

	return
end

function var_0_0.Step(arg_2_0, arg_2_1)
	arg_2_0.time = arg_2_0.time + arg_2_1

	local var_2_0 = 1

	CrossRoadGameConst = var_1_10003

	for iter_2_0 = var_2_0, var_1_10003.GAME_TRACK_COUNT do
		if arg_2_0.itemGoList[iter_2_0] ~= nil and arg_2_0:CheckItemResTime(arg_2_0.itemGoList[iter_2_0]) then
			arg_2_0:DisposeItemByIndex(iter_2_0)
		end
	end

	local var_2_1 = arg_2_0.time
	local var_2_2 = arg_2_0.makeHongChaTime

	CrossRoadGameConst = var_4

	if var_2_1 > var_2_2 + var_4.HONGCHA_MISS_TIME then
		arg_2_0:ClearHongcha()
	end

	return
end

function var_0_0.DisposeItemByIndex(arg_3_0, arg_3_1)
	arg_3_0:DisposeGoInList(arg_3_0.itemGoList[arg_3_1])

	arg_3_0.itemGoList[arg_3_1] = nil

	local var_3_0 = arg_3_0._runningData

	var_2.SetItemGoList(var_3_0, arg_3_0.itemGoList)

	return
end

function var_0_0.DisposeGoInList(arg_4_0, arg_4_1)
	if arg_4_1.go then
		destroy = var_2

		var_2(arg_4_1.go)
	end

	arg_4_1.makeTime = nil
	arg_4_1.id = nil

	return
end

function var_0_0.MakeHongcha(arg_5_0)
	math = var_1_10001

	local var_5_0 = var_1_10001.random(1, 100)

	CrossRoadGameConst = var_1_10002

	if var_1_10002.HONGCHA_PERCENT < var_5_0 then
		return
	end

	setParent = var_2

	var_2(arg_5_0.hongChaItem, arg_5_0.sceneContent, false)

	local var_5_1 = arg_5_0.hongChaItem

	var_5_1.anchoredPosition = arg_5_0.hongChaTF.anchoredPosition
	setActive = var_5_1

	var_5_1(arg_5_0.hongChaItem, true)

	arg_5_0.makeHongChaTime = arg_5_0.time

	return
end

function var_0_0.ClearHongcha(arg_6_0)
	SetActive = var_1_10001

	var_1_10001(arg_6_0.hongChaItem, false)

	setParent = var_1_10001

	var_1_10001(arg_6_0.hongChaItem, arg_6_0._tpl, false)

	CrossRoadGameConst = var_1_10001
	arg_6_0.makeHongChaTime = var_1_10001.GAME_TIME + arg_6_0.time

	return
end

function var_0_0.MakeXuanWo(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.MakeItemInList
	local var_7_2 = arg_7_1

	CrossRoadGameConst = var_1_10006

	var_7_1(var_7_0, var_7_2, var_1_10006.XUAN_WO)

	return
end

function var_0_0.MakeBingMain(arg_8_0, arg_8_1)
	local var_8_0, var_8_1 = arg_8_0:GetNearTrackId(arg_8_1)
	local var_8_2 = arg_8_0
	local var_8_3 = arg_8_0.MakeItemInList
	local var_8_4 = var_8_0

	CrossRoadGameConst = var_1_10008

	var_8_3(var_8_2, var_8_4, var_1_10008.BING_MIAN)

	local var_8_5 = arg_8_0
	local var_8_6 = arg_8_0.MakeItemInList
	local var_8_7 = var_8_1

	CrossRoadGameConst = var_8

	var_8_6(var_8_5, var_8_7, var_8.BING_MIAN)

	return
end

function var_0_0.MakeItemInList(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == nil or arg_9_0.itemGoList[arg_9_1] ~= nil then
		return
	end

	local var_9_0 = arg_9_0.itemListTpl[arg_9_2]

	tf = var_1_10004
	instantiate = var_1_10006

	local var_9_1 = var_1_10004(var_1_10006(var_9_0))

	CrossRoadGameConst = var_1_10005

	local var_9_3

	if arg_9_2 == var_1_10005.BING_MIAN then
		local var_9_2 = var_9_1

		var_9_3 = var_9_1.GetComponent
		typeof = var_8
		RectTransform = var_1_10010

		local var_9_4 = var_9_3(var_9_2, var_8(var_1_10010)).sizeDelta

		CrossRoadGameConst = var_9_2
		var_9_4.x = var_9_2.BINGMIAN_DISTANCE
		var_9_3.sizeDelta = var_9_4
	end

	setParent = var_9_3

	var_9_3(var_9_1, arg_9_0.sceneContent, false)

	var_9_1.anchoredPosition = arg_9_0.itemListTF[arg_9_1].anchoredPosition
	arg_9_0.itemGoList[arg_9_1] = {
		id = arg_9_2,
		go = var_9_1,
		makeTime = arg_9_0.time
	}

	local var_9_5 = arg_9_0._runningData

	var_5.SetItemGoList(var_9_5, arg_9_0.itemGoList)

	return
end

function var_0_0.GetNearTrackId(arg_10_0, arg_10_1)
	if arg_10_1 == 1 or arg_10_1 == 3 then
		return 2, nil
	end

	if arg_10_1 == 4 or arg_10_1 == 6 then
		return 5, nil
	end

	return arg_10_1 - 1, arg_10_1 + 1
end

function var_0_0.CheckItemResTime(arg_11_0, arg_11_1)
	local var_11_0 = 0
	local var_11_1 = arg_11_1.id

	CrossRoadGameConst = var_1_10004

	if var_11_1 == var_1_10004.BING_MIAN then
		var_11_0 = arg_11_0.binLifeTime
	else
		local var_11_2 = arg_11_1.id

		CrossRoadGameConst = var_4

		if var_11_2 == var_4.XUAN_WO then
			var_11_0 = arg_11_0.xuanWoLifeTime
		end
	end

	return arg_11_1.makeTime + var_11_0 < arg_11_0.time
end

function var_0_0.Clear(arg_12_0)
	arg_12_0:ClearHongcha()

	arg_12_0.time = 0

	local var_12_0 = 1

	CrossRoadGameConst = var_1_10002

	for iter_12_0 = var_12_0, var_1_10002.GAME_TRACK_COUNT do
		if arg_12_0.itemGoList[iter_12_0] ~= nil then
			arg_12_0:DisposeGoInList(arg_12_0.itemGoList[iter_12_0])

			arg_12_0.itemGoList[iter_12_0] = nil
		end
	end

	arg_12_0.itemGoList = {}

	return
end

function var_0_0.Dispose(arg_13_0)
	return
end

return var_0_0
