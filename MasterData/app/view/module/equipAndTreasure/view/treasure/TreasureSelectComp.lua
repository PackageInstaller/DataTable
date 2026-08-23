local TreasureSelectComp = class("TreasureSelectComp", require("app.fairyGUI.equipAndTreasure.UI_TreasureSelectComp"), function()
	return fgui.GComponent:create({
		resName = "TreasureSelectComp",
		pkgPath = "ui/equipAndTreasure/equipAndTreasure",
		pkgName = "equipAndTreasure"
	})
end)
local var_0_1 = g.core.model.User.knightsData
local var_0_2 = g.core.model.User.treasureData
local TreasureConst = require("app.view.module.equipAndTreasure.const.TreasureConst")
local var_0_4 = TreasureConst.TREASURE_QUALITY
local var_0_5 = TreasureConst.TREASURE_TAB
local var_0_6 = TreasureConst.TREASURE_INFO_TYPE
local var_0_7 = g.core.config.treasure_info

function TreasureSelectComp:ctor(arg_2_1)
	self._treasureData = nil
	self._callback = nil
	self._knightId = nil
	self._knightFormation = nil
	self._qualityType = nil
	self._curType = nil
	self._isHideWear = true
	self._knightIndex = nil
	self._selectPositionData = nil

	self.m_goToBtn:addClickListener(handler(self, self._onGoToBtnClick))
	self:_initView()
end

function TreasureSelectComp:onLoad()
	return
end

function TreasureSelectComp:updateView(arg_4_1)
	self._knightId = arg_4_1.knightId
	self._knightIndex = arg_4_1.knightIndex
	self._selectPositionData = arg_4_1.selectPositionData
	self._callback = arg_4_1.callback

	self:_initData()
	self:_updateTreasureList()
end

function TreasureSelectComp:_initData()
	self._knightFormation = var_0_1:getFormationKnights()
	self._qualityType = self._qualityType or var_0_4.ALL

	if self._selectPositionData.positionType == 5 then
		self._curType = var_0_6.ATTACK or var_0_6.DEFENSE
	end

	self:_updateTreasureData(self._isHideWear)
end

function TreasureSelectComp:_initView()
	self.m_treasureList:setVirtual()
	self.m_treasureList:setItemRenderer(handler(self, self._renderTreasureItem))
	self.m_treasureList:doFairyBatching(false)
	self.m_checkBtn:setSelected(self._isHideWear)
	self.m_checkBtn:addEventListener(fgui.UIEventType.Changed, handler(self, self._onHideWearChanged))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabChanged))
	self.m_tabList:setSelectedIndex(0)
end

function TreasureSelectComp:_onHideWearChanged()
	self._isHideWear = self.m_checkBtn:isSelected()

	self:_updateTreasureData(self._isHideWear)
	self:_updateTreasureList()
end

function TreasureSelectComp:_renderTreasureItem(arg_8_1, arg_8_2)
	arg_8_2:updateView({
		index = arg_8_1 + 1,
		data = self._treasureData[arg_8_1 + 1],
		selectPositionData = self._selectPositionData
	})
end

function TreasureSelectComp:_changeTab()
	self:_updateTreasureList()
end

function TreasureSelectComp:_onTabChanged(arg_10_1)
	local var_10_0 = arg_10_1:getDataValue()

	self._qualityType = var_10_0 == var_0_5.ALL and var_0_4.ALL or g.core.const.ConstMgr.QUALITY_TYPE.MAX_QUALITY - var_10_0 + 1

	self:_updateTreasureData(self._isHideWear)
	self:_updateTreasureList()
end

function TreasureSelectComp:_updateTreasureList()
	if #self._treasureData == 0 then
		self.m_emptyComp:updateView({
			text1 = g.core.lang:get(202038),
			text2 = g.core.lang:get(202005)
		})
		self.m_emptyController:setSelectedIndex(0)
	else
		self.m_emptyController:setSelectedIndex(1)
		self.m_treasureList:setNumItems(#self._treasureData)
		self.m_treasureList:transitionShowCells("listCrosbandBUiRightIn_cell", 0.03)
	end
end

function TreasureSelectComp:_updateTreasureData(arg_12_1)
	self._treasureData = {}

	for iter_12_0, iter_12_1 in pairs((var_0_2:getTreasureData())) do
		local var_12_0 = var_0_7.get(iter_12_1.base_id)
		local var_12_2 = clone(iter_12_1)

		var_12_2.type = var_12_0.type
		var_12_2.quality = var_12_0.quality
		var_12_2.potential = var_12_0.potential
		var_12_2.sortType = var_12_0.type == 3 and 1 or 0

		if iter_12_1.position ~= 0 then
			local var_12_3 = 0
			local var_12_4

			if iter_12_1.position % 2 > 0 then
				var_12_3 = (iter_12_1.position + 1) / 2
			else
				var_12_3 = iter_12_1.position / 2
				var_12_4 = {}
			end

			var_12_4.id = self._knightFormation[var_12_3]

			local var_12_5 = var_0_1:getKnight(var_12_4)

			if var_12_5 then
				var_12_2.name = var_12_5:getName()
				var_12_2.KnightQua = var_12_5:getBaseInfo().quality
			end
		end

		if self._qualityType == var_0_4.ALL then
			if self._curType == var_12_2.type then
				if arg_12_1 then
					if iter_12_1.position == 0 then
						table.insert(self._treasureData, var_12_2)
					end
				else
					table.insert(self._treasureData, var_12_2)
				end
			end
		elseif self._curType == var_12_2.type and self._qualityType == var_12_2.quality then
			if arg_12_1 then
				if iter_12_1.position == 0 then
					table.insert(self._treasureData, var_12_2)
				end
			else
				table.insert(self._treasureData, var_12_2)
			end
		end
	end

	table.sort(self._treasureData, function(arg_13_0, arg_13_1)
		if arg_13_0.position ~= 0 and arg_13_1.position == 0 or arg_13_0.position == 0 and arg_13_1.position ~= 0 then
			return arg_13_0.position ~= 0
		end

		if arg_13_0.position ~= arg_13_1.position then
			return arg_13_0.position < arg_13_1.position
		end

		if arg_13_0.sortType ~= arg_13_1.sortType then
			return arg_13_0.sortType < arg_13_1.sortType
		end

		if arg_13_0.potential ~= arg_13_1.potential then
			return arg_13_0.potential > arg_13_1.potential
		end

		if arg_13_0.quality ~= arg_13_1.quality then
			return arg_13_0.quality > arg_13_1.quality
		end

		if arg_13_0.level ~= arg_13_1.level then
			return arg_13_0.level > arg_13_1.level
		end

		if arg_13_0.refining_level ~= arg_13_1.refining_level then
			return arg_13_0.refining_level > arg_13_1.refining_level
		end

		if arg_13_0.base_id ~= arg_13_1.base_id then
			return arg_13_0.base_id < arg_13_1.base_id
		end
	end)
end

function TreasureSelectComp:_onGoToBtnClick()
	g.view.entrance.ModuleGotoProxy:gotoModule(240)
end

return TreasureSelectComp
