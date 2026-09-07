local CrossRoadItemMgr = class("CrossRoadItemMgr")

function CrossRoadItemMgr:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tpl = arg_1_1
	self._runningData = arg_1_2
	self._event = arg_1_3
	self.time = 0
	self.itemListTF = arg_1_2:GetItemListTF()
	self.itemListTpl = arg_1_2:GetAllItemTpl()
	self.xuanWoLifeTime = CrossRoadGameConst.XUANWO_LIFE_TIME
	self.binLifeTime = CrossRoadGameConst.BINGMIAN_LIFE_TIME
	self.makeHongChaTime = CrossRoadGameConst.GAME_TIME
	self.hongChaTF = arg_1_2:GetHongChaTF()
	self.hongChaItem = self.itemListTpl[1]
	self.sceneContent = arg_1_2:GetItemScene()
	self.itemGoList = {}

	return
end

function CrossRoadItemMgr:Step(arg_2_1)
	self.time = self.time + arg_2_1

	for iter_2_0 = 1, CrossRoadGameConst.GAME_TRACK_COUNT do
		if self.itemGoList[iter_2_0] ~= nil and self:CheckItemResTime(self.itemGoList[iter_2_0]) then
			self:DisposeItemByIndex(iter_2_0)
		end
	end

	if self.time > self.makeHongChaTime + CrossRoadGameConst.HONGCHA_MISS_TIME then
		self:ClearHongcha()
	end

	return
end

function CrossRoadItemMgr:DisposeItemByIndex(arg_3_1)
	self:DisposeGoInList(self.itemGoList[arg_3_1])

	self.itemGoList[arg_3_1] = nil

	self._runningData:SetItemGoList(self.itemGoList)

	return
end

function CrossRoadItemMgr:DisposeGoInList(arg_4_1)
	if arg_4_1.go then
		destroy(arg_4_1.go)
	end

	arg_4_1.makeTime = nil
	arg_4_1.id = nil

	return
end

function CrossRoadItemMgr:MakeHongcha()
	if math.random(1, 100) > CrossRoadGameConst.HONGCHA_PERCENT then
		return
	end

	setParent(self.hongChaItem, self.sceneContent, false)

	self.hongChaItem.anchoredPosition = self.hongChaTF.anchoredPosition

	setActive(self.hongChaItem, true)

	self.makeHongChaTime = self.time

	return
end

function CrossRoadItemMgr:ClearHongcha()
	SetActive(self.hongChaItem, false)
	setParent(self.hongChaItem, self._tpl, false)

	self.makeHongChaTime = CrossRoadGameConst.GAME_TIME + self.time

	return
end

function CrossRoadItemMgr:MakeXuanWo(arg_7_1)
	self:MakeItemInList(arg_7_1, CrossRoadGameConst.XUAN_WO)

	return
end

function CrossRoadItemMgr:MakeBingMain(arg_8_1)
	local var_8_0, var_8_1 = self:GetNearTrackId(arg_8_1)

	self:MakeItemInList(var_8_0, CrossRoadGameConst.BING_MIAN)
	self:MakeItemInList(var_8_1, CrossRoadGameConst.BING_MIAN)

	return
end

function CrossRoadItemMgr:MakeItemInList(arg_9_1, arg_9_2)
	if arg_9_1 == nil or self.itemGoList[arg_9_1] ~= nil then
		return
	end

	local var_9_0 = tf(instantiate(self.itemListTpl[arg_9_2]))

	if arg_9_2 == CrossRoadGameConst.BING_MIAN then
		local var_9_1 = var_9_0:GetComponent(typeof(RectTransform))

		var_9_1.sizeDelta.x = CrossRoadGameConst.BINGMIAN_DISTANCE
		var_9_1.sizeDelta = var_9_1.sizeDelta
	end

	setParent(var_9_0, self.sceneContent, false)

	var_9_0.anchoredPosition = self.itemListTF[arg_9_1].anchoredPosition
	self.itemGoList[arg_9_1] = {
		id = arg_9_2,
		go = var_9_0,
		makeTime = self.time
	}

	self._runningData:SetItemGoList(self.itemGoList)

	return
end

function CrossRoadItemMgr:GetNearTrackId(arg_10_1)
	if arg_10_1 == 1 or arg_10_1 == 3 then
		return 2, nil
	end

	if arg_10_1 == 4 or arg_10_1 == 6 then
		return 5, nil
	end

	return arg_10_1 - 1, arg_10_1 + 1
end

function CrossRoadItemMgr:CheckItemResTime(arg_11_1)
	local var_11_0 = 0

	if arg_11_1.id == CrossRoadGameConst.BING_MIAN then
		var_11_0 = self.binLifeTime
	elseif arg_11_1.id == CrossRoadGameConst.XUAN_WO then
		var_11_0 = self.xuanWoLifeTime
	end

	return arg_11_1.makeTime + var_11_0 < self.time
end

function CrossRoadItemMgr:Clear()
	self:ClearHongcha()

	self.time = 0

	for iter_12_0 = 1, CrossRoadGameConst.GAME_TRACK_COUNT do
		if self.itemGoList[iter_12_0] ~= nil then
			self:DisposeGoInList(self.itemGoList[iter_12_0])

			self.itemGoList[iter_12_0] = nil
		end
	end

	self.itemGoList = {}

	return
end

function CrossRoadItemMgr:Dispose()
	return
end

return CrossRoadItemMgr
