-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell25.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell25", package.seeall)

local AssistCell25 = class("AssistCell25", BaseAssistCell)

function AssistCell25:ctor(luaComponentContainer)
	AssistCell25.super.ctor(self, luaComponentContainer)

	self._itemList = {}
	self._itemsGo = goutil.findChild(self._parentGo, string.format("%s/items", self._name))

	local itemsTransform = self._itemsGo.transform

	for i = 1, itemsTransform.childCount do
		local item = {}

		item._go = itemsTransform:GetChild(i - 1).gameObject
		item._txt1 = goutil.findChildTextComponent(item._go, "txt1")
		item._txt2 = goutil.findChildTextComponent(item._go, "txt2")
		item._dropdown1 = DropDownAdapter.GetFrom(item._go, "dropdown1")
		item._img = goutil.findChild(item._go, "img")
		item._tagFinish = goutil.findChild(item._go, "tagFinish")

		GameUtil.SetActive(item._img, false)
		GameUtil.SetActive(item._tagFinish, false)
		table.insert(self._itemList, item)
	end
end

function AssistCell25:reset()
	AssistCell25.super.reset(self)

	for i, v in ipairs(self._itemList) do
		v._dropdown1:RemoveOnValueChanged()
	end

	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoAssistantRefreshCoin, self._refreshCostShow, self)
	XiaoNuoAssistantController.instance:unregisterLocalNotify(XiaoNuoAssistantController.HideDropdown, self._onHideDropdown, self)
end

function AssistCell25:init(data)
	AssistCell25.super.init(self, data)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoAssistantRefreshCoin, self._refreshCostShow, self)
	XiaoNuoAssistantController.instance:registerLocalNotify(XiaoNuoAssistantController.HideDropdown, self._onHideDropdown, self)

	self._assistCellData = self._data:getAssistCellData()

	self:_refreshUI()
end

function AssistCell25:_selectAll()
	return
end

function AssistCell25:_cancelAll()
	return
end

function AssistCell25:_onClickAll()
	AssistCell25.super._onClickAll(self)
	self:_dispatchRefreshCostShow()
end

function AssistCell25:_onValueChanged1(idx, value)
	local list = self._allMap[idx]

	if list and value > 0 then
		local cfg = list[value]

		self._data:setIndexData(idx, cfg.activityId)
	else
		self._data:setIndexData(idx, 0)
	end

	self:_refreshUI()
end

function AssistCell25:_refreshUI()
	local list = self._data:getSelectableCfgList()
	local len = #list
	local selectableActivityIdMap = {}

	for _, cfg in ipairs(list) do
		selectableActivityIdMap[cfg.activityId] = true
	end

	local tem = {}

	for idx, v in ipairs(self._itemList) do
		v._dropdown1:RemoveOnValueChanged()

		local activityId = self._data:getIndexData(idx)

		if activityId > 0 and (len < idx or not selectableActivityIdMap[activityId] or tem[activityId]) then
			self._data:setIndexData(idx, 0)

			activityId = 0
		end

		if activityId > 0 then
			tem[activityId] = true
		end
	end

	self._allMap = {}

	local remainTimesMap = {}

	for idx, v in ipairs(self._itemList) do
		v._dropdown1:SetValue(0)
		self:_refreshCell(v, nil, remainTimesMap)
		GameUtil.SetActive(v._img, len < idx)
		v._dropdown1:ClearOptions()
		v._dropdown1:AddOptions("选择挑战")

		local activityId = self._data:getIndexData(idx)
		local itemList = {}

		for i, cfg in ipairs(list) do
			if cfg.activityId == activityId then
				table.insert(itemList, cfg)
				v._dropdown1:AddOptions(cfg.name)
				v._dropdown1:SetValue(#itemList)
				self:_refreshCell(v, cfg, remainTimesMap)
			elseif not tem[cfg.activityId] then
				table.insert(itemList, cfg)
				v._dropdown1:AddOptions(cfg.name)
			end
		end

		v._dropdown1:AddOnValueChanged(GameUtil.handler(self._onValueChanged1, self, idx))

		self._allMap[idx] = itemList
	end
end

function AssistCell25:_getTimeGatePreview(cfg, remainTimesMap, needReserve)
	local timeGateCfg = self._data:getTimeGateCfg(cfg.activityId)

	if not timeGateCfg or TimeGateModel.instance:isOpenByRaceId(timeGateCfg.raceId) then
		return true
	end

	local typeIndex = timeGateCfg.type

	if remainTimesMap[typeIndex] == nil then
		remainTimesMap[typeIndex] = checknumber(TimeGateModel.instance:getLeftTime(typeIndex))
	end

	local leftTime = remainTimesMap[typeIndex]
	local canOpen = leftTime > 0

	if needReserve and canOpen then
		remainTimesMap[typeIndex] = leftTime - 1
	end

	return canOpen, leftTime, TimeGateModel.instance:getTimesLimitWithRegress(typeIndex)
end

function AssistCell25:_refreshCell(item, cfg, remainTimesMap)
	item._txt1.text = ""
	item._txt2.text = "（选择一个挑战）"

	GameUtil.SetActive(item._tagFinish, false)

	if not cfg then
		return
	end

	item._txt2.text = ""

	local info = SignInBuffModel.instance:getBaseInfo(cfg.activityId)
	local hasSignInToday = info and info.hasSignInToday

	if info then
		::label_10_0::

		local isSignInBuffMax = self._data:isSignInBuffMax(cfg.activityId, info)
		local canSignIn = info and not hasSignInToday and not isSignInBuffMax
		local canOpen, leftTime, timesLimit = self:_getTimeGatePreview(cfg, remainTimesMap, canSignIn)

		if isSignInBuffMax then
			item._txt1.text = "<color=#eb4642>签到已满级</color>"
		elseif hasSignInToday then
			item._txt1.text = "<color=#20b376>今日已签到</color>"

			GameUtil.SetActive(item._tagFinish, true)
		elseif not canOpen then
			item._txt1.text = "<color=#eb4642>不可签到</color>"
		elseif info then
			item._txt1.text = "<color=#eb4642>可签到</color>"
		end

		local timeGateCfg = self._data:getTimeGateCfg(cfg.activityId)

		if timeGateCfg and not TimeGateModel.instance:isOpenByRaceId(timeGateCfg.raceId) then
			local leftTimeText = not canOpen and "<color=#eb4642>0</color>" or leftTime

			if timeGateCfg.type == TimeGateModel.Normal then
				item._txt2.text = langPara("消耗<color=#eb4642>1</color>次普通时间之门，剩余：%s/%s", leftTimeText, timesLimit)
			end

			if timeGateCfg.type == TimeGateModel.High then
				item._txt2.text = langPara("消耗<color=#eb4642>1</color>次高级时间之门，剩余：%s/%s", leftTimeText, timesLimit)
			end
		end
	end
end

function AssistCell25:_refreshCostShow(tabId)
	return
end

function AssistCell25:_onHideDropdown()
	for i, v in ipairs(self._itemList) do
		self:_hideDropdown(v._dropdown1.dropdown)
	end
end

return AssistCell25
