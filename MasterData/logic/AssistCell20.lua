-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell20.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell20", package.seeall)

local AssistCell20 = class("AssistCell20", BaseAssistCell)

function AssistCell20:ctor(luaComponentContainer)
	AssistCell20.super.ctor(self, luaComponentContainer)

	local itemGo1 = goutil.findChild(self._parentGo, self:getCellPath("item1"))
	local itemGo2 = goutil.cloneAndSetParent(itemGo1, itemGo1.transform.parent, "item2")

	GameUtil.setAnchoredPos(itemGo2, 0, -46)

	self._itemList = {}

	for i = 1, 2 do
		local go = i == 1 and itemGo1 or itemGo2
		local itemInfo = {}

		itemInfo.txt1 = goutil.findChildTextComponent(go, "txt1")
		itemInfo.dropdown1 = DropDownAdapter.GetFrom(go, "dropdown1")
		itemInfo.dropdown2 = DropDownAdapter.GetFrom(go, "dropdown2")

		table.insert(self._itemList, itemInfo)
	end
end

function AssistCell20:reset()
	AssistCell20.super.reset(self)

	for i, v in ipairs(self._itemList) do
		v.dropdown1:RemoveOnValueChanged()
		v.dropdown2:RemoveOnValueChanged()
	end
end

function AssistCell20:init(data)
	AssistCell20.super.init(self, data)

	for i, v in ipairs(self._itemList) do
		v.dropdown1:AddOnValueChanged(function(value)
			self:_onValueChanged1(i, value)
		end)
		v.dropdown2:AddOnValueChanged(function(value)
			self:_onValueChanged2(i, value)
		end)
		v.dropdown1:ClearOptions()
		v.dropdown1:AddOptions(tostring(0))

		for j = 1, AssistData20.MaxChallengeNum do
			v.dropdown1:AddOptions(tostring(j))
		end

		v.dropdown2:ClearOptions()
		v.dropdown2:AddOptions(tostring(0))

		for j = 1, AssistData20.MaxSelectPosIndex do
			v.dropdown2:AddOptions(tostring(j))
		end

		v.txt1.text = self:_getRankTxt(i)

		v.dropdown1:SetValue(self._data:getCellDataToNumber(self._data[string.format("keyDropdownNum%d_1", i)]))
		v.dropdown2:SetValue(self._data:getCellDataToNumber(self._data[string.format("keyDropdownNum%d_2", i)]))
	end
end

function AssistCell20:_onValueChanged1(index, value)
	if index == 1 then
		self._data:setCellData(self._data.keyDropdownNum1_1, value)
	else
		self._data:setCellData(self._data.keyDropdownNum2_1, value)
	end
end

function AssistCell20:_onValueChanged2(index, value)
	if index == 1 then
		self._data:setCellData(self._data.keyDropdownNum1_2, value)
	else
		self._data:setCellData(self._data.keyDropdownNum2_2, value)
	end
end

function AssistCell20:_getRankTxt(index)
	if index == 1 then
		local rank = ArenaModel.instance:getPosition()

		return "竞技场排名\n" .. rank
	elseif index == 2 then
		local rank = SeniorArenaModel.instance:getMyRank()

		return "高阶竞技场排名\n" .. rank
	end
end

return AssistCell20
