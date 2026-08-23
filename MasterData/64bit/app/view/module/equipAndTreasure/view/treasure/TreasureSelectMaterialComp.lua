local var_0_0 = g.core.config.treasure_info
local var_0_2 = g.core.config.parameter_info
local var_0_3 = g.core.common.Goods
local var_0_4 = g.core.const.ConstMgr.QUALITY_TYPE
local TreasureSelectMaterialComp = class("TreasureSelectMaterialComp", require("app.fairyGUI.equipAndTreasure.UI_TreasureSelectMaterialComp"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/equipAndTreasure/equipAndTreasure",
		resName = "TreasureSelectMaterialComp",
		pkgName = "equipAndTreasure"
	})
end)

function TreasureSelectMaterialComp:ctor(arg_2_1)
	self._quality = nil
	self._treasureOnlyId = nil
	self._selectTreasureId = {}
	self._treasureData = {}

	self:_initView()
end

function TreasureSelectMaterialComp:_initView()
	self.m_strengthBtn:addClickListener(handler(self, self._onClickStrength))
end

function TreasureSelectMaterialComp:onLoad()
	return
end

function TreasureSelectMaterialComp:updateView(arg_5_1)
	if arg_5_1 then
		self._quality = arg_5_1.quality or 1
	end

	if arg_5_1 then
		self._treasureOnlyId = arg_5_1.id or 0
	end

	if arg_5_1 then
		self._selectTreasureId = arg_5_1.selectTreasId or {}
	end

	self:_initTreasureData()
	self:_initListView()
	self:_calculateGoldNum()
end

function TreasureSelectMaterialComp:_initTreasureData()
	self._treasureData = {}

	for iter_6_0, iter_6_1 in pairs((g.core.model.User.treasureData:getTreasureData())) do
		local var_6_0 = var_0_0.get(iter_6_1.base_id)

		if var_6_0 then
			local var_6_2 = clone(iter_6_1)

			var_6_2.quality = var_6_0.quality
			var_6_2.totalExp = 0 + g.core.model.User.treasureData:getNeedExpUpToNextLv(iter_6_1.base_id, iter_6_1.level - 1) + var_6_0.treasure_exp + iter_6_1.exp
			var_6_2.sortType = var_6_0.type == 3 and 1 or 0
			var_6_2.selectIndex = 0

			for iter_6_2, iter_6_3 in ipairs(self._selectTreasureId) do
				if iter_6_1.id == iter_6_3 then
					var_6_2.isSelect = true
					var_6_2.selectIndex = 1
				end
			end

			if var_6_0.type == 3 then
				if iter_6_1.refining_level < 1 and iter_6_1.id ~= self._treasureOnlyId and iter_6_1.position == 0 then
					table.insert(self._treasureData, var_6_2)
				end
			elseif var_6_0.type == 4 then
				-- block empty
			elseif iter_6_1.refining_level < 1 and iter_6_1.id ~= self._treasureOnlyId and iter_6_1.position == 0 and not iter_6_1.lock then
				table.insert(self._treasureData, var_6_2)
			end
		end
	end

	table.sort(self._treasureData, function(arg_7_0, arg_7_1)
		if arg_7_0.selectIndex ~= arg_7_1.selectIndex then
			return arg_7_0.selectIndex > arg_7_1.selectIndex
		end

		if arg_7_0.sortType ~= arg_7_1.sortType then
			return arg_7_0.sortType > arg_7_1.sortType
		end

		if arg_7_0.quality ~= arg_7_1.quality then
			return arg_7_0.quality < arg_7_1.quality
		end

		if arg_7_0.level ~= arg_7_1.level then
			return arg_7_0.level < arg_7_1.level
		end

		if arg_7_0.base_id ~= arg_7_1.base_id then
			return arg_7_0.base_id < arg_7_1.base_id
		end
	end)
end

function TreasureSelectMaterialComp:_initListView()
	self.m_materialList:setVirtual()
	self.m_materialList:setItemRenderer(function(arg_9_0, arg_9_1)
		arg_9_1:updateView({
			index = arg_9_0 + 1,
			data = self._treasureData[arg_9_0 + 1]
		})
	end)
	self.m_materialList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickItem), 1)

	local var_8_0 = #self._treasureData

	self.m_materialList:setNumItems(#self._treasureData)
	self.m_emptyController:setSelectedIndex(var_8_0 == 0 and 0 or 1)
end

function TreasureSelectMaterialComp:_onClickItem(arg_10_1)
	local var_10_0 = g.core.common.Storage:load("treasureStrength.json") or {
		isChecked = false,
		day = 0
	}
	local var_10_1 = var_10_0.isChecked and var_10_0.day == os.date("%d", os.time())
	local var_10_2 = var_10_0.day
	local var_10_3 = arg_10_1:getDataValue()

	if self._treasureData[var_10_3 + 1].isSelect then
		self._treasureData[var_10_3 + 1].isSelect = false

		self:_updateMaterial()

		return
	end

	if not self._treasureData[var_10_3 + 1].isSelect and self._treasureData[var_10_3 + 1].quality == var_0_4.SSR and (var_10_1 and os.date("%d", os.time()) ~= var_10_2 or not var_10_1) then
		self._treasureData[var_10_3 + 1].isSelect = true

		self:_updateMaterial()
	elseif not self._treasureData[var_10_3 + 1].isSelect then
		self._treasureData[var_10_3 + 1].isSelect = true

		self:_updateMaterial()
	end
end

function TreasureSelectMaterialComp:_updateMaterial()
	local var_11_0 = #self._treasureData

	self.m_materialList:setNumItems(#self._treasureData)
	self.m_emptyController:setSelectedIndex(var_11_0 == 0 and 0 or 1)
	self:_calculateGoldNum()
	self:_updateSelectMaterial()
end

function TreasureSelectMaterialComp:_updateSelectMaterial()
	self:dispatchCompEvent("select_click", self._selectTreasureId)
end

function TreasureSelectMaterialComp:_getSelectList()
	local var_13_0 = {}

	self._selectTreasureId = {}

	for iter_13_0, iter_13_1 in ipairs(self._treasureData) do
		if iter_13_1.isSelect then
			table.insert(var_13_0, iter_13_1.id)
			table.insert(self._selectTreasureId, iter_13_1.id)
		end
	end

	return var_13_0
end

function TreasureSelectMaterialComp:_calculateGoldNum()
	local var_14_0 = math.ceil(self:getAddExp() * (var_0_2.get(101).parameter / 1000))

	self._needCoinNum = var_14_0

	if var_14_0 == 0 then
		self.m_showResNumController:setSelectedIndex(0)
	else
		self.m_showResNumController:setSelectedIndex(1)
		self.m_resNumComp:updateByTVS({
			type = var_0_3.TYPE_RESOURCE,
			value = var_0_3.RESOURCE.TYPE_COIN,
			size = var_14_0
		})
	end
end

function TreasureSelectMaterialComp:getAddExp()
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs((self:_getSelectList())) do
		local var_15_1 = g.core.model.User.treasureData:getTreasureDataByOnlyId(iter_15_1)

		for iter_15_2 = 1, var_15_1.level - 1 do
			var_15_0 = var_15_0 + g.core.model.User.treasureData:getNeedExpUpToNextLv(var_15_1.base_id, iter_15_2)
		end

		local var_15_2 = var_0_0.get(var_15_1.base_id)

		if var_15_2 then
			var_15_0 = var_15_0 + var_15_2.treasure_exp + var_15_1.exp
		end
	end

	return var_15_0
end

function TreasureSelectMaterialComp:_onClickStrength()
	if #self._selectTreasureId == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(202020))
	elseif g.core.model.User.resourceData:getCoin() < self._needCoinNum then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			value = 3,
			type = g.core.common.Goods.TYPE_RESOURCE,
			size = g.core.model.User.resourceData:getCoin()
		})
	else
		g.core.network.GameNetProxy:send_C2S_Treasure_Upgrade({
			id = self._treasureOnlyId,
			consume_list = self._selectTreasureId
		})
	end
end

return TreasureSelectMaterialComp
