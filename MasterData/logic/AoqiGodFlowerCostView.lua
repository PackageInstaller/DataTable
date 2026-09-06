-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodFlowerCostView.lua

module("logic.extensions.aoqigod.view.AoqiGodFlowerCostView", package.seeall)

local AoqiGodFlowerCostView = class("AoqiGodFlowerCostView", ViewComponent)
local MAX_SELECT_FLOWER_TYPE_COUNT = 10

function AoqiGodFlowerCostView:ctor()
	AoqiGodFlowerCostView.super.ctor(self)
end

function AoqiGodFlowerCostView:unbindEvents()
	AoqiGodFlowerCostView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function AoqiGodFlowerCostView:bindEvents()
	AoqiGodFlowerCostView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function AoqiGodFlowerCostView:buildUI()
	AoqiGodFlowerCostView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._cell = self:getGo("cell")
	self._scrollView = self:getGo("ScrollView")
	self._tableList = ScrollerList.create(self._scrollView, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableList:setCenterMode(true)

	self._goEmpty = self:getGo("goEmpty")
	self._textTotalCharm = self:getTxt("textTotalCharm")
end

function AoqiGodFlowerCostView:onExit()
	AoqiGodFlowerCostView.super.onExit(self)
end

function AoqiGodFlowerCostView:onEnter()
	AoqiGodFlowerCostView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	local selectItem = params[2]

	self._additionCharm = checknumber(params[3])
	self._activityCfg = AoqiGodConfig.instance:getActData(self._activityId)

	local list = {}
	local flowerCfgs = SendFlowerConfig.instance:getFlowerCfg()

	for i, v in ipairs(flowerCfgs) do
		local isForbit = false

		for j, id in ipairs(self._activityCfg.forbitFlowerId) do
			if v.id == id then
				isForbit = true

				break
			end
		end

		if not isForbit then
			local matType, matId, matNum = MaterialMgr.getMatParams(v.content)

			if MaterialModel.instance:IsEnough(matType, matId, matNum) then
				table.insert(list, v)
			end
		end
	end

	table.sort(list, function(a, b)
		return a.sort < b.sort
	end)

	self._itemCountMap = {}

	for i, v in ipairs(selectItem or {}) do
		self._itemCountMap[v.id] = v.num
	end

	self._tableList:reloadData(list)
	GameUtil.SetActive(self._goEmpty, #list <= 0)
	self:_refreshView()
end

function AoqiGodFlowerCostView:_refreshView()
	self._tableList:refresh()

	local charmNum = 0

	for k, v in pairs(self._itemCountMap) do
		local flowerCfg = SendFlowerConfig.instance:getFlowerCfg(k)

		charmNum = charmNum + flowerCfg.value * v
	end

	self._textTotalCharm.text = langPara("总魅力值：%d/%d", charmNum + self._additionCharm, self._activityCfg.charmLimit)
end

function AoqiGodFlowerCostView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtCharmCount = goutil.findChildTextComponent(cell, "txtCharmCount")
	local item = goutil.findChild(cell, "item")
	local btnAdd = goutil.findChild(go, "chooseCount/btnAdd")
	local btnLess = goutil.findChild(go, "chooseCount/btnLess")
	local inputField = Framework.InputFieldAdapter.GetFrom(go, "chooseCount/InputField")
	local flowerCfg = data
	local matType, matId, matNum = MaterialMgr.getMatParams(flowerCfg.content)
	local myMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
	local proxy = MaterialMgr.setCellByCfg(flowerCfg.content, item)

	if proxy then
		proxy.binder:setNum(myMatNum)
	end

	txtName.text = MaterialMgr.getMaterialsName(matType, matId)
	txtCharmCount.text = langPara("魅力值:%d", flowerCfg.value * checknumber(self._itemCountMap[data.id]))

	GameUtil.addClickHandler(btnAdd, GameUtil.handler(self._onClickAdd, self, data.id))
	GameUtil.addClickHandler(btnLess, GameUtil.handler(self._onClickLess, self, data.id))
	inputField:RemoveOnValueChanged()
	inputField:SetText(tostring(checknumber(self._itemCountMap[data.id])))
	inputField:AddOnValueChanged(function(strNum)
		self:_onTextFieldValueChange(strNum, inputField, flowerCfg, myMatNum)
	end, self)
end

function AoqiGodFlowerCostView:_clearCell(cell)
	local con = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(cell)
end

function AoqiGodFlowerCostView:getTotalTypeCount()
	local count = 0

	for k, v in pairs(self._itemCountMap) do
		if v > 0 then
			count = count + 1
		end
	end

	return count
end

function AoqiGodFlowerCostView:_onTextFieldValueChange(strNum, inputField, flowerCfg, myMatNum)
	inputField:RemoveOnValueChanged()

	local num = checknumber(inputField:GetText())

	num = Mathf.Clamp(num, 0, myMatNum)

	local totalCharmNum = 0

	for k, v in pairs(self._itemCountMap) do
		if k ~= flowerCfg.id then
			local checkFlowerCfg = SendFlowerConfig.instance:getFlowerCfg(k)

			totalCharmNum = totalCharmNum + checkFlowerCfg.value * v
		end
	end

	local maxAddCharm = self._activityCfg.charmLimit - totalCharmNum - self._additionCharm
	local maxAddNum = math.floor(maxAddCharm / flowerCfg.value)

	num = math.min(num, maxAddNum)

	if num == 0 then
		self._itemCountMap[flowerCfg.id] = nil
	else
		self._itemCountMap[flowerCfg.id] = num
	end

	if self:getTotalTypeCount() > MAX_SELECT_FLOWER_TYPE_COUNT then
		self._itemCountMap[flowerCfg.id] = nil
		num = 0

		TipsFacade.instance:openCommonTips(langPara("最多只能赠送%d种鲜花", MAX_SELECT_FLOWER_TYPE_COUNT))
	end

	inputField:SetText(tostring(num))
	self:_refreshView()
end

function AoqiGodFlowerCostView:_onClickAdd(flowerId)
	local flowerCfg = SendFlowerConfig.instance:getFlowerCfg(flowerId)
	local matType, matId, matNum = MaterialMgr.getMatParams(flowerCfg.content)
	local myMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
	local num = checknumber(self._itemCountMap[flowerId])

	if num == 0 and self:getTotalTypeCount() > MAX_SELECT_FLOWER_TYPE_COUNT then
		TipsFacade.instance:openCommonTips(langPara("最多只能赠送%d种鲜花", MAX_SELECT_FLOWER_TYPE_COUNT))

		return
	end

	if myMatNum < num + 1 then
		TipsFacade.instance:openCommonTips("选择数量已达到上限")

		return
	end

	local totalCharmNum = 0

	for k, v in pairs(self._itemCountMap) do
		local checkFlowerCfg = SendFlowerConfig.instance:getFlowerCfg(k)

		totalCharmNum = totalCharmNum + checkFlowerCfg.value * v
	end

	if flowerCfg.value + totalCharmNum + self._additionCharm > self._activityCfg.charmLimit then
		TipsFacade.instance:openCommonTips("所选鲜花已超过魅力值上限")

		return
	end

	num = num + 1
	self._itemCountMap[flowerId] = num

	self:_refreshView()
end

function AoqiGodFlowerCostView:_onClickLess(flowerId)
	local flowerCfg = SendFlowerConfig.instance:getFlowerCfg(flowerId)
	local matType, matId, matNum = MaterialMgr.getMatParams(flowerCfg.content)
	local myMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
	local num = checknumber(self._itemCountMap[flowerId])

	if num - 1 >= 0 then
		num = num - 1
		self._itemCountMap[flowerId] = num

		self:_refreshView()
	end
end

function AoqiGodFlowerCostView:_onClickSure()
	local selectItem = {}

	for id, num in pairs(self._itemCountMap) do
		if num > 0 then
			table.insert(selectItem, {
				id = id,
				num = num
			})
		end
	end

	table.sort(selectItem, function(a, b)
		local flowerCfgA = SendFlowerConfig.instance:getFlowerCfg(a.id)
		local flowerCfgB = SendFlowerConfig.instance:getFlowerCfg(b.id)

		return flowerCfgA.sort < flowerCfgB.sort
	end)
	GlobalDispatcher:dispatch(GlobalNotify.AoqiGodSelectFlowerChange, selectItem)
	self:close()
end

return AoqiGodFlowerCostView
