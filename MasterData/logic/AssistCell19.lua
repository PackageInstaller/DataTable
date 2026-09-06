-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell19.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell19", package.seeall)

local AssistCell19 = class("AssistCell19", BaseAssistCell)

AssistCell19.CoinType1 = GameEnum.GoldType.PixieDust
AssistCell19.CoinType2 = GameEnum.GoldType.TimeWheelOverflow

function AssistCell19:ctor(luaComponentContainer)
	AssistCell19.super.ctor(self, luaComponentContainer)

	self._items = goutil.findChild(self._parentGo, self:getCellPath("items"))
	self._itemCell = goutil.findChild(self._parentGo, self:getCellPath("item"))
	self._recordPos = self._items:GetComponent("TestRecordPos")

	self._itemCell.transform:SetParent(self._items.transform)

	self._itemCell.name = "item1"

	local itemGos = {}

	table.insert(itemGos, self._itemCell)

	for i = 2, AssistData19.MaxNum do
		local go = goutil.cloneAndSetParent(self._itemCell, self._items.transform, "item" .. i)

		table.insert(itemGos, go)
	end

	self._recordPos:LoadPlan(0)

	self._itemList = {}

	for i, v in ipairs(itemGos) do
		local item = {}

		item.btn = Framework.ButtonAdapter.GetFrom(v, "btn")
		item.markbtn = goutil.findChild(v, "btn/Background/Checkmark")
		item.dropdown = DropDownAdapter.GetFrom(v, "dropdown")
		item.txtName = goutil.findChildTextComponent(v, "btn/Label")

		table.insert(self._itemList, item)
	end

	self._txt3 = MaterialMgr.findGraphicText(self._parentGo, self:getCellPath("txt3"))
	self._txt4 = MaterialMgr.findGraphicText(self._parentGo, self:getCellPath("txt4"))
end

function AssistCell19:reset()
	AssistCell19.super.reset(self)

	for i, v in ipairs(self._itemList) do
		v.btn:RemoveClickListener()
		v.dropdown:RemoveOnValueChanged()
	end
end

function AssistCell19:init(data)
	AssistCell19.super.init(self, data)

	for i, v in ipairs(self._itemList) do
		v.btn:AddClickListener(function()
			self:_onClickSelect(i)
		end)
		v.dropdown:AddOnValueChanged(function(value)
			self:_onValueChanged(i, value)
		end)
		v.dropdown:ClearOptions()
		v.dropdown:AddOptions(tostring(0))

		if self._data.cfgs[i].limitType == "none" then
			for j = 1, AssistData19.MaxBuyNum do
				v.dropdown:AddOptions(tostring(j))
			end
		else
			for j = 1, self._data.cfgs[i].limitTimes do
				v.dropdown:AddOptions(tostring(j))
			end
		end

		v.dropdown:SetValue(self._data:getSelectNum(i))
		self:_setBtnIsOn(i, self._data:getCellSelect(self._data["selectIndex" .. i]))

		v.txtName.text = self._data.cfgs[i].name
	end

	self:_updateCostCoins()
end

function AssistCell19:_setBtnIsOn(index, isOn)
	goutil.setActive(self._itemList[index].markbtn, isOn)
end

function AssistCell19:_updateCostCoins()
	self._curCostPixieDust, self._curCostTimeWheelOverflow = self._data:getCostCoins()

	self:_updateCoinTxt()
end

function AssistCell19:_updateCoinTxt()
	XiaoNuoAssistCostModel.instance:setCoin(self._data:getFuncIndex(), GameEnum.GoldType.PixieDust, self._curCostPixieDust)
	XiaoNuoAssistCostModel.instance:setCoin(self._data:getFuncIndex(), GameEnum.GoldType.TimeWheelOverflow, self._curCostTimeWheelOverflow)

	local costPixieDust = XiaoNuoAssistCostModel.instance:getTotalCoin(self._data:getFuncIndex(), GameEnum.GoldType.PixieDust)
	local costTimeWheelOverflow = XiaoNuoAssistCostModel.instance:getTotalCoin(self._data:getFuncIndex(), GameEnum.GoldType.TimeWheelOverflow)

	if costPixieDust <= MaterialMgr.getMatCount(GameEnum.GoldType.PixieDust) then
		if not XiaoNuoAssistantModel.CostColor then
			local pixieDustColorStr = ColorConst.Red

			if costTimeWheelOverflow <= MaterialMgr.getMatCount(GameEnum.GoldType.TimeWheelOverflow) then
				if not XiaoNuoAssistantModel.CostColor then
					local timeWheelOverflowColorStr = ColorConst.Red

					self._txt3.text = string.format("<quad name=%s|icon size=25 width=1 offsetY=-5/> x <color=#%s>%d</color>", GameEnum.GoldType.PixieDust, pixieDustColorStr, self._curCostPixieDust)

					self:_fixTxtShow(self._txt3)

					self._txt4.text = string.format("<quad name=%s|icon size=25 width=1 offsetY=-5/> x <color=#%s>%d</color>", GameEnum.GoldType.TimeWheelOverflow, timeWheelOverflowColorStr, self._curCostTimeWheelOverflow)

					self:_fixTxtShow(self._txt4)
				end
			end
		end
	end
end

function AssistCell19:_onClickSelect(index)
	local isOn = self._data:getCellSelect(self._data["selectIndex" .. index])

	self._data:setCellSelect(self._data["selectIndex" .. index], not isOn)
	self:_setBtnIsOn(index, not isOn)
	self:_updateCostCoins()
end

function AssistCell19:_onValueChanged(index, value)
	self._data:setSelectNum(index, value)
	self:_updateCostCoins()
end

return AssistCell19
