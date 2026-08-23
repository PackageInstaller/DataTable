local EquipDetailComp = class("EquipDetailComp", require("app.fairyGUI.equipAndTreasure.UI_EquipWearComp"), function()
	return fgui.GComponent:create({
		resName = "EquipWearComp",
		pkgPath = "ui/equipAndTreasure/equipAndTreasure",
		pkgName = "equipAndTreasure"
	})
end)
local ETData = require("app.view.module.equipAndTreasure.model.ETData")
local var_0_2 = g.core.model.User.equipmentData
local var_0_3 = g.core.common.ModuleUnlock
local var_0_4 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_5 = g.core.const.ConstMgr.QUALITY_TYPE

function EquipDetailComp:ctor()
	self._selectPositionData = nil
	self._curEquipData = {}
	self._lineUpKnight = nil
	self._wearPos = 0
	self._isInit = false

	self.m_goToBtn:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onGoToBtnClick))
end

function EquipDetailComp:updateView()
	self._selectPositionData = ETData.selectPositionData

	if not self._selectPositionData then
		return
	end

	if not self._isInit then
		self._isInit = true

		self:initComp()
	end

	self._wearPos = self._selectPositionData.pos
	self._equipData = var_0_2:getEquipList(self._selectPositionData.positionType)
	self._lineUpKnight = g.core.model.User.knightsData:getKnight({
		pos = self._selectPositionData.knightPos
	})
	self._curEquipData = self:_getCurEquipDataBySelected()

	self:_sortCurEquipData()
	self.m_emptyController:setSelectedIndex(next(self._curEquipData) and 1 or 0)
	self.m_equipList:setNumItems(#self._curEquipData)
	self.m_equipList:transitionShowCells("listCrosbandBUiRightIn_cell", 0.03)
	self.m_checkBtn:setSelected(checkbool(var_0_2:getIsHideWearEquip()))
end

function EquipDetailComp:initComp()
	self.m_equipList:setVirtual(self)
	self.m_equipList:setItemRenderer(handler(self, self._onListEquipRenderer))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabChanged))
	self.m_tabList:setSelectedIndex(0)
	self.m_checkBtn:addClickListener(handler(self, self._onWearCheckClick))
end

function EquipDetailComp:_onTabChanged(arg_5_1)
	local var_5_0 = arg_5_1:getDataValue()

	if var_5_0 == 0 then
		self._qualityType = nil
	else
		self._qualityType = g.core.const.ConstMgr.QUALITY_TYPE.MAX_QUALITY - var_5_0 + 1
	end

	self._curEquipData = self:_getCurEquipDataBySelected()

	self:_sortCurEquipData()
	self.m_equipList:setNumItems(#self._curEquipData)
	self.m_equipList:transitionShowCells("listCrosbandBUiRightIn_cell", 0.03)
	self.m_emptyController:setSelectedIndex(next(self._curEquipData) and 1 or 0)
end

function EquipDetailComp:_getCurEquipDataBySelected()
	local var_6_0 = {}

	if var_0_2:getIsHideWearEquip() then
		if self._qualityType then
			for iter_6_0 = 1, #self._equipData.noWearIndex do
				if self._equipData.noWearIndex[iter_6_0]:getCfg().quality == self._qualityType then
					table.insert(var_6_0, self._equipData.noWearIndex[iter_6_0])
				end
			end
		else
			var_6_0 = self:_equipFiltering(self._equipData.noWearIndex)
		end
	else
		var_6_0 = {}

		local var_6_1 = {}

		if self._qualityType then
			for iter_6_1 = 1, #self._equipData.allIndex do
				if self._equipData.allIndex[iter_6_1]:getCfg().quality == self._qualityType then
					table.insert(var_6_1, self._equipData.allIndex[iter_6_1])
				end
			end
		else
			var_6_0 = self:_equipFiltering(self._equipData.allIndex)
		end

		for iter_6_2 = 1, #var_6_1 do
			if var_6_1[iter_6_2]:getPosition() > 0 then
				if not var_6_1[iter_6_2]:isInitEquipment() then
					table.insert(var_6_0, var_6_1[iter_6_2])
				end
			else
				table.insert(var_6_0, var_6_1[iter_6_2])
			end
		end
	end

	return var_6_0
end

function EquipDetailComp:_equipFiltering(arg_7_1)
	if var_0_3:isModuleUnlock(var_0_4.EQUIP_UR) or true then
		return arg_7_1
	else
		local var_7_0 = {}

		for iter_7_0 = 1, #arg_7_1 do
			if arg_7_1[iter_7_0]:getCfg().quality ~= var_0_5.UR then
				table.insert(var_7_0, arg_7_1[iter_7_0])
			end
		end

		return var_7_0
	end
end

function EquipDetailComp:_sortCurEquipData()
	if not next(self._curEquipData) then
		return
	end

	local var_8_0 = self._lineUpKnight:getInfo().id

	table.sort(self._curEquipData, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0:getCfg()
		local var_9_1 = arg_9_1:getCfg()
		local var_9_2 = arg_9_0:getServerData()
		local var_9_3 = arg_9_1:getServerData()
		local var_9_4 = arg_9_0:getPosition() > 0

		if var_9_4 ~= (arg_9_1:getPosition() > 0) then
			return var_9_4
		end

		local var_9_5 = var_9_2.magical_stage or 0
		local var_9_6 = var_9_3.magical_stage or 0

		if var_9_5 ~= var_9_6 then
			return var_9_6 < var_9_5
		end

		if var_9_2.level ~= var_9_3.level then
			return var_9_2.level > var_9_3.level
		end

		if var_9_0.quality ~= var_9_1.quality then
			return var_9_0.quality > var_9_1.quality
		end

		return var_9_0.id < var_9_1.id
	end)
end

function EquipDetailComp:_onWearCheckClick(arg_10_1)
	if arg_10_1:getSender():isSelected() then
		var_0_2:setHideWearEquip(true)
	else
		var_0_2:setHideWearEquip(false)
	end

	self._curEquipData = self:_getCurEquipDataBySelected()

	self:_sortCurEquipData()
	self.m_equipList:scrollToView(0, false)
	self.m_equipList:setNumItems(#self._curEquipData)
	self.m_equipList:transitionShowCells("listCrosbandBUiRightIn_cell", 0.03)
	self.m_emptyController:setSelectedIndex(next(self._curEquipData) and 1 or 0)
end

function EquipDetailComp:_onListEquipRenderer(arg_11_1, arg_11_2)
	arg_11_2:updateCell(self._curEquipData[arg_11_1 + 1], self._wearPos)
end

function EquipDetailComp:_onGoToBtnClick()
	local var_12_0, var_12_1 = g.view.entrance.ModuleGotoProxy:getModule(17)

	if not g.core.module.ModuleManager:isCurModule(var_12_0) then
		g.view.entrance.ModuleGotoProxy:gotoModule(17)
	end
end

return EquipDetailComp
