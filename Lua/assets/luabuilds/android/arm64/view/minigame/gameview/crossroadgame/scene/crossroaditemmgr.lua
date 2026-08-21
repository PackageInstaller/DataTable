local var_0_0 = class("CrossRoadItemMgr")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tpl = arg_1_1
	arg_1_0._runningData = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0.time = 0
	arg_1_0.itemListTF = arg_1_2:GetItemListTF()
	arg_1_0.itemListTpl = arg_1_2:GetAllItemTpl()
	arg_1_0.xuanWoLifeTime = CrossRoadGameConst.XUANWO_LIFE_TIME
	arg_1_0.binLifeTime = CrossRoadGameConst.BINGMIAN_LIFE_TIME
	arg_1_0.makeHongChaTime = CrossRoadGameConst.GAME_TIME
	arg_1_0.hongChaTF = arg_1_2:GetHongChaTF()
	arg_1_0.hongChaItem = arg_1_0.itemListTpl[1]
	arg_1_0.sceneContent = arg_1_2:GetItemScene()
	arg_1_0.itemGoList = {}

	return
end

function var_0_0.Step(arg_2_0, arg_2_1)
	arg_2_0.time = arg_2_0.time + arg_2_1

	for iter_2_0 = 1, CrossRoadGameConst.GAME_TRACK_COUNT do
		if arg_2_0.itemGoList[iter_2_0] ~= nil and arg_2_0:CheckItemResTime(arg_2_0.itemGoList[iter_2_0]) then
			arg_2_0:DisposeItemByIndex(iter_2_0)
		end
	end

	if arg_2_0.time > arg_2_0.makeHongChaTime + CrossRoadGameConst.HONGCHA_MISS_TIME then
		arg_2_0:ClearHongcha()
	end

	return
end

function var_0_0.DisposeItemByIndex(arg_3_0, arg_3_1)
	arg_3_0:DisposeGoInList(arg_3_0.itemGoList[arg_3_1])

	arg_3_0.itemGoList[arg_3_1] = nil

	arg_3_0._runningData:SetItemGoList(arg_3_0.itemGoList)

	return
end

function var_0_0.DisposeGoInList(arg_4_0, arg_4_1)
	if arg_4_1.go then
		destroy(arg_4_1.go)
	end

	arg_4_1.makeTime = nil
	arg_4_1.id = nil

	return
end

function var_0_0.MakeHongcha(arg_5_0)
	if math.random(1, 100) > CrossRoadGameConst.HONGCHA_PERCENT then
		return
	end

	setParent(arg_5_0.hongChaItem, arg_5_0.sceneContent, false)

	arg_5_0.hongChaItem.anchoredPosition = arg_5_0.hongChaTF.anchoredPosition

	setActive(arg_5_0.hongChaItem, true)

	arg_5_0.makeHongChaTime = arg_5_0.time

	return
end

function var_0_0.ClearHongcha(arg_6_0)
	SetActive(arg_6_0.hongChaItem, false)
	setParent(arg_6_0.hongChaItem, arg_6_0._tpl, false)

	arg_6_0.makeHongChaTime = CrossRoadGameConst.GAME_TIME + arg_6_0.time

	return
end

function var_0_0.MakeXuanWo(arg_7_0, arg_7_1)
	arg_7_0:MakeItemInList(arg_7_1, CrossRoadGameConst.XUAN_WO)

	return
end

function var_0_0.MakeBingMain(arg_8_0, arg_8_1)
	local var_8_0, var_8_1 = arg_8_0:GetNearTrackId(arg_8_1)

	arg_8_0:MakeItemInList(var_8_0, CrossRoadGameConst.BING_MIAN)
	arg_8_0:MakeItemInList(var_8_1, CrossRoadGameConst.BING_MIAN)

	return
end

function var_0_0.MakeItemInList(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == nil or arg_9_0.itemGoList[arg_9_1] ~= nil then
		return
	end

	local var_9_0 = tf(instantiate(arg_9_0.itemListTpl[arg_9_2]))

	if arg_9_2 == CrossRoadGameConst.BING_MIAN then
		local var_9_1 = var_9_0:GetComponent(typeof(RectTransform))

		var_9_1.sizeDelta.x = CrossRoadGameConst.BINGMIAN_DISTANCE
		var_9_1.sizeDelta = var_9_1.sizeDelta
	end

	setParent(var_9_0, arg_9_0.sceneContent, false)

	var_9_0.anchoredPosition = arg_9_0.itemListTF[arg_9_1].anchoredPosition
	arg_9_0.itemGoList[arg_9_1] = {
		id = arg_9_2,
		go = var_9_0,
		makeTime = arg_9_0.time
	}

	arg_9_0._runningData:SetItemGoList(arg_9_0.itemGoList)

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

	if arg_11_1.id == CrossRoadGameConst.BING_MIAN then
		var_11_0 = arg_11_0.binLifeTime
	elseif arg_11_1.id == CrossRoadGameConst.XUAN_WO then
		var_11_0 = arg_11_0.xuanWoLifeTime
	end

	return arg_11_1.makeTime + var_11_0 < arg_11_0.time
end

function var_0_0.Clear(arg_12_0)
	arg_12_0:ClearHongcha()

	arg_12_0.time = 0

	for iter_12_0 = 1, CrossRoadGameConst.GAME_TRACK_COUNT do
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
