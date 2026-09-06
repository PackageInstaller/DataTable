-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell15.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell15", package.seeall)

local AssistCell15 = class("AssistCell15", BaseAssistCell)

function AssistCell15:ctor(luaComponentContainer)
	AssistCell15.super.ctor(self, luaComponentContainer)

	self._itemList = {}

	for i = 1, 3 do
		local item = {}

		item._txt1 = goutil.findChildTextComponent(self._parentGo, string.format("%s/item%d/txt1", self._name, i))
		item._dropdown1 = DropDownAdapter.GetFrom(self._parentGo, string.format("%s/item%d/dropdown1", self._name, i))
		item._dropdown2 = DropDownAdapter.GetFrom(self._parentGo, string.format("%s/item%d/dropdown2", self._name, i))

		table.insert(self._itemList, item)
	end
end

function AssistCell15:reset()
	AssistCell15.super.reset(self)

	for i, v in ipairs(self._itemList) do
		v._dropdown1:RemoveOnValueChanged()
		v._dropdown2:RemoveOnValueChanged()
	end

	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoAssistantRefreshCoin, self._refreshCostShow, self)
	XiaoNuoAssistantController.instance:unregisterLocalNotify(XiaoNuoAssistantController.HideDropdown, self._onHideDropdown, self)
end

function AssistCell15:init(data)
	AssistCell15.super.init(self, data)
	self._itemList[1]._dropdown1:AddOnValueChanged(self._onValueChanged1, self)
	self._itemList[1]._dropdown2:AddOnValueChanged(self._onValueChanged2, self)
	self._itemList[2]._dropdown1:AddOnValueChanged(self._onValueChanged3, self)
	self._itemList[2]._dropdown2:AddOnValueChanged(self._onValueChanged4, self)
	self._itemList[3]._dropdown1:AddOnValueChanged(self._onValueChanged5, self)
	self._itemList[3]._dropdown2:AddOnValueChanged(self._onValueChanged6, self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoAssistantRefreshCoin, self._refreshCostShow, self)
	XiaoNuoAssistantController.instance:registerLocalNotify(XiaoNuoAssistantController.HideDropdown, self._onHideDropdown, self)

	self._assistCellData = self._data:getAssistCellData()

	for i, v in ipairs(self._itemList) do
		v._dropdown2:ClearOptions()
		v._dropdown2:AddOptions("答案")
		v._dropdown2:AddOptions(AssistData15.Answer[1])
		v._dropdown2:AddOptions(AssistData15.Answer[2])
		v._dropdown2:AddOptions(AssistData15.Answer[3])
		v._dropdown2:AddOptions(AssistData15.Answer[4])
	end

	self._oriList = self:_filterList()

	local index1, index2, index3 = self:_initOriList()

	self._dropdownIndex1 = index1
	self._dropdownIndex2 = index2
	self._dropdownIndex3 = index3

	self._itemList[1]._dropdown1:SetValue(index1)
	self._itemList[1]._dropdown2:SetValue(self._assistCellData.answer1)
	self._itemList[2]._dropdown1:SetValue(index2)
	self._itemList[2]._dropdown2:SetValue(self._assistCellData.answer2)
	self._itemList[3]._dropdown1:SetValue(index3)
	self._itemList[3]._dropdown2:SetValue(self._assistCellData.answer3)
	self:_updateTxt(self._assistCellData.raceId1, 1)
	self:_updateTxt(self._assistCellData.raceId2, 2)
	self:_updateTxt(self._assistCellData.raceId3, 3)
end

function AssistCell15:_selectAll()
	return
end

function AssistCell15:_cancelAll()
	return
end

function AssistCell15:_onClickAll()
	AssistCell15.super._onClickAll(self)
	self:_dispatchRefreshCostShow()
end

function AssistCell15:_initOriList()
	local index1 = 0
	local index2 = 0
	local index3 = 0

	self._oriList_1 = {}
	self._oriList_2 = {}
	self._oriList_3 = {}

	local oriListIndex1 = 0
	local oriListIndex2 = 0
	local oriListIndex3 = 0

	self._itemList[1]._dropdown1:ClearOptions()
	self._itemList[1]._dropdown1:AddOptions("选择精灵")
	self._itemList[2]._dropdown1:ClearOptions()
	self._itemList[2]._dropdown1:AddOptions("选择精灵")
	self._itemList[3]._dropdown1:ClearOptions()
	self._itemList[3]._dropdown1:AddOptions("选择精灵")

	for i, v in ipairs(self._oriList) do
		local lv = GoodFeelModel.instance:getPetGoodFeelLv(v.raceId)
		local cfg = CharacterConfig.instance:getPetCo(v.raceId)
		local str = cfg.name .. " " .. lv

		if v.raceId ~= self._assistCellData.raceId2 and v.raceId ~= self._assistCellData.raceId3 then
			table.insert(self._oriList_1, v)
			self._itemList[1]._dropdown1:AddOptions(str)

			oriListIndex1 = oriListIndex1 + 1
		end

		if v.raceId ~= self._assistCellData.raceId1 and v.raceId ~= self._assistCellData.raceId3 then
			table.insert(self._oriList_2, v)
			self._itemList[2]._dropdown1:AddOptions(str)

			oriListIndex2 = oriListIndex2 + 1
		end

		if v.raceId ~= self._assistCellData.raceId1 and v.raceId ~= self._assistCellData.raceId2 then
			table.insert(self._oriList_3, v)
			self._itemList[3]._dropdown1:AddOptions(str)

			oriListIndex3 = oriListIndex3 + 1
		end

		if v.raceId == self._assistCellData.raceId1 then
			index1 = oriListIndex1
		end

		if v.raceId == self._assistCellData.raceId2 then
			index2 = oriListIndex2
		end

		if v.raceId == self._assistCellData.raceId3 then
			index3 = oriListIndex3
		end
	end

	return index1, index2, index3
end

function AssistCell15:_onValueChangeUpdateOriList(changeTypeIndex)
	local index1 = 0
	local index2 = 0
	local index3 = 0
	local oriListIndex1 = 0
	local oriListIndex2 = 0
	local oriListIndex3 = 0
	local isFirst = changeTypeIndex == 2 or changeTypeIndex == 3
	local isSecond = changeTypeIndex == 1 or changeTypeIndex == 3
	local isThird = changeTypeIndex == 1 or changeTypeIndex == 2

	if isFirst then
		table.clear(self._oriList_1)
		self._itemList[1]._dropdown1:ClearOptions()
		self._itemList[1]._dropdown1:AddOptions("选择精灵")
	end

	if isSecond then
		table.clear(self._oriList_2)
		self._itemList[2]._dropdown1:ClearOptions()
		self._itemList[2]._dropdown1:AddOptions("选择精灵")
	end

	if isThird then
		table.clear(self._oriList_3)
		self._itemList[3]._dropdown1:ClearOptions()
		self._itemList[3]._dropdown1:AddOptions("选择精灵")
	end

	for i, v in ipairs(self._oriList) do
		local lv = GoodFeelModel.instance:getPetGoodFeelLv(v.raceId)
		local cfg = CharacterConfig.instance:getPetCo(v.raceId)
		local str = cfg.name .. " " .. lv

		if isFirst and v.raceId ~= self._assistCellData.raceId2 and v.raceId ~= self._assistCellData.raceId3 then
			table.insert(self._oriList_1, v)
			self._itemList[1]._dropdown1:AddOptions(str)

			oriListIndex1 = oriListIndex1 + 1
		end

		if isSecond and v.raceId ~= self._assistCellData.raceId1 and v.raceId ~= self._assistCellData.raceId3 then
			table.insert(self._oriList_2, v)
			self._itemList[2]._dropdown1:AddOptions(str)

			oriListIndex2 = oriListIndex2 + 1
		end

		if isThird and v.raceId ~= self._assistCellData.raceId1 and v.raceId ~= self._assistCellData.raceId2 then
			table.insert(self._oriList_3, v)
			self._itemList[3]._dropdown1:AddOptions(str)

			oriListIndex3 = oriListIndex3 + 1
		end

		if v.raceId == self._assistCellData.raceId1 then
			index1 = oriListIndex1
		end

		if v.raceId == self._assistCellData.raceId2 then
			index2 = oriListIndex2
		end

		if v.raceId == self._assistCellData.raceId3 then
			index3 = oriListIndex3
		end
	end

	if isFirst then
		self._dropdownIndex1 = index1

		self._itemList[1]._dropdown1:SetValue(index1)
		self._itemList[1]._dropdown2:SetValue(self._assistCellData.answer1)
	end

	if isSecond then
		self._dropdownIndex2 = index2

		self._itemList[2]._dropdown1:SetValue(index2)
		self._itemList[2]._dropdown2:SetValue(self._assistCellData.answer2)
	end

	if isThird then
		self._dropdownIndex3 = index3

		self._itemList[3]._dropdown1:SetValue(index3)
		self._itemList[3]._dropdown2:SetValue(self._assistCellData.answer3)
	end
end

function AssistCell15:_onValueChanged1(value)
	printInfo("test AssistCell15:_onValueChanged1", value, type(value))

	self._assistCellData.raceId1 = 0

	local index = 1
	local isExcute = self._dropdownIndex1 ~= value

	if value > 0 and self._oriList_1[value] and self._oriList_1[value].raceId and self._oriList_1[value].raceId > 0 and self._oriList_1[value].raceId ~= self._assistCellData.raceId2 and self._oriList_1[value].raceId ~= self._assistCellData.raceId3 then
		self._dropdownIndex1 = value
		self._assistCellData.raceId1 = self._oriList_1[value].raceId

		self._data:setCellData(self._data.keyInputNum1, self._oriList_1[value].raceId)
		self:_updateTxt(self._oriList_1[value].raceId, index)
	else
		self._data:setCellData(self._data.keyInputNum1, 0)
		self._itemList[index]._dropdown1:SetValue(0)
		self:_updateTxt(0, index)
	end

	if isExcute then
		self:_onValueChangeUpdateOriList(1)
	end
end

function AssistCell15:_onValueChanged2(value)
	printInfo("test AssistCell15:_onValueChanged2", value)

	self._assistCellData.answer1 = value

	self._data:setCellData(self._data.keyInputNum2, value)
end

function AssistCell15:_onValueChanged3(value)
	printInfo("test AssistCell15:_onValueChanged3", value, type(value))

	self._assistCellData.raceId2 = 0

	local index = 2
	local isExcute = self._dropdownIndex2 ~= value

	if value > 0 and self._oriList_2[value] and self._oriList_2[value].raceId and self._oriList_2[value].raceId > 0 and self._oriList_2[value].raceId ~= self._assistCellData.raceId1 and self._oriList_2[value].raceId ~= self._assistCellData.raceId3 then
		self._dropdownIndex2 = value
		self._assistCellData.raceId2 = self._oriList_2[value].raceId

		self._data:setCellData(self._data.keyInputNum3, self._oriList_2[value].raceId)
		self:_updateTxt(self._oriList_2[value].raceId, index)
	else
		self._data:setCellData(self._data.keyInputNum3, 0)
		self._itemList[index]._dropdown1:SetValue(0)
		self:_updateTxt(0, index)
	end

	if isExcute then
		self:_onValueChangeUpdateOriList(2)
	end
end

function AssistCell15:_onValueChanged4(value)
	printInfo("test AssistCell15:_onValueChanged4", value)

	self._assistCellData.answer2 = value

	self._data:setCellData(self._data.keyInputNum4, value)
end

function AssistCell15:_onValueChanged5(value)
	printInfo("test AssistCell15:_onValueChanged5", value, type(value))

	self._assistCellData.raceId3 = 0

	local index = 3
	local isExcute = self._dropdownIndex3 ~= value

	if value > 0 and self._oriList_3[value] and self._oriList_3[value].raceId and self._oriList_3[value].raceId > 0 and self._oriList_3[value].raceId ~= self._assistCellData.raceId1 and self._oriList_3[value].raceId ~= self._assistCellData.raceId2 then
		self._dropdownIndex3 = value
		self._assistCellData.raceId3 = self._oriList_3[value].raceId

		self._data:setCellData(self._data.keyInputNum5, self._oriList_3[value].raceId)
		self:_updateTxt(self._oriList_3[value].raceId, index)
	else
		self._data:setCellData(self._data.keyInputNum5, 0)
		self._itemList[index]._dropdown1:SetValue(0)
		self:_updateTxt(0, index)
	end

	if isExcute then
		self:_onValueChangeUpdateOriList(3)
	end
end

function AssistCell15:_onValueChanged6(value)
	printInfo("test AssistCell15:_onValueChanged6", value)

	self._assistCellData.answer3 = value

	self._data:setCellData(self._data.keyInputNum6, value)
end

function AssistCell15:_updateTxt(raceId, index)
	self._itemList[index]._txt1.text = raceId > 0 and string.format("好感度等级：%d", GoodFeelModel.instance:getPetGoodFeelLv(raceId)) or "好感度等级："
end

function AssistCell15:_filterList()
	local maxLv = #GoodFeelConfig.instance:getGoodFeelExpCfgs().dataList
	local tempList = GoodFeelModel.instance:getInfoLists() or {}
	local tempDic = {}

	for i, v in ipairs(tempList) do
		local lv = GoodFeelModel.instance:getPetGoodFeelLv(v.raceId)

		if lv < maxLv then
			tempDic[lv] = tempDic[lv] or {}

			table.insert(tempDic[lv], v)
		end
	end

	local keys = {}

	for k, v in pairs(tempDic) do
		table.insert(keys, k)
	end

	table.sort(keys)

	local list = {}

	for _, k in ipairs(keys) do
		local mo = tempDic[k]

		for _, v in ipairs(mo) do
			table.insert(list, v)
		end
	end

	return list
end

function AssistCell15:_refreshCostShow(tabId)
	if self._data:getTabIndex() == tabId then
		self:_updateTxt(self._assistCellData.raceId1, 1)
		self:_updateTxt(self._assistCellData.raceId2, 2)
		self:_updateTxt(self._assistCellData.raceId3, 3)
	end
end

function AssistCell15:_onHideDropdown()
	for i, v in ipairs(self._itemList) do
		self:_hideDropdown(v._dropdown1.dropdown)
		self:_hideDropdown(v._dropdown2.dropdown)
	end
end

return AssistCell15
