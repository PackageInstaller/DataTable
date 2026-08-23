local BagNewSelectPop = class("BagNewSelectPop", require("app.fairyGUI.bagNew.UI_BagNewSelectPop"), function()
	return fgui.GComponent:create({
		resName = "BagNewSelectPop",
		pkgName = "bagNew"
	})
end)
local BagNewPropCfg = require("app.view.module.bagNew.const.BagNewPropCfg")
local var_0_2 = g.core.config.basic_figure_info
local var_0_3 = g.core.config.parameter_info
local var_0_4 = g.core.config.drop_info
local var_0_5 = g.core.const.ConstMgr
local var_0_6 = g.core.const.ConstMgr.BASE_CONST
local var_0_7 = g.core.lang
local var_0_8 = g.core.network.GameNetProxy
local var_0_9 = g.core.event.EventManager
local var_0_10 = g.core.event.enum
local var_0_11 = g.core.module.ModuleManager
local var_0_12 = g.core.model.User
local var_0_13 = g.core.model.User.bagData
local var_0_14 = g.core.config.item_info

function BagNewSelectPop:ctor(arg_2_1, arg_2_2)
	if arg_2_1.use_type ~= BagNewPropCfg.USE_TYPE.SELECT then
		return
	end

	arg_2_2 = arg_2_2 or 1
	self._type = arg_2_2

	self:showAtCenter()

	self._chooseIndex = -1

	self:_initBase(arg_2_1)

	self._chooseItems = nil

	self.m_selectList:setVirtual()
	self.m_selectList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_selectList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickItem))

	self._info = arg_2_1

	self.m_selectList:setScrollLimit(true)
	self:updateView()
end

function BagNewSelectPop:_getListData(arg_3_1)
	local var_3_0 = {}

	for iter_3_0 = 1, var_0_4.getLength() do
		local var_3_1 = var_0_4.indexOf(iter_3_0)

		if var_3_1.id == arg_3_1.item_value then
			for iter_3_1 = 1, 5 do
				local var_3_3 = var_3_1["reward_value_" .. iter_3_1]

				if var_3_1["reward_type_" .. iter_3_1] ~= 0 then
					local var_3_6

					if var_3_1["reward_type_" .. iter_3_1] == g.core.common.Goods.TYPE_ROLE_SKIN then
						local var_3_5 = g.core.config.role_skin_info.get(g.core.config.role_skin_module_info.get(var_3_3).id).gender

						var_3_6 = var_3_5 == 2 or (g.core.model.User:getUserUniqueAdvanceId() == 210000 and 1 or 0) == var_3_5
					else
						var_3_6 = true
					end
				end
			end
		end
	end

	return var_3_0
end

function BagNewSelectPop:updateView()
	if not self._info then
		return
	end

	self._listDatas = self:_getListData(self._info)

	self.m_haveTxt:setText(var_0_7:get(400004, {
		num = var_0_13:getOwnNum(var_0_5.BAG_TYPE.ITEM, self._info.id)
	}))
	self.m_selectList:setNumItems(table.nums(self._listDatas))

	if self._info.autoSelcetData then
		for iter_4_0, iter_4_1 in ipairs(self._listDatas) do
			if iter_4_1.type == self._info.autoSelcetData.type and iter_4_1.value == self._info.autoSelcetData.value then
				self.m_selectList:setSelectedIndex(iter_4_0 - 1)
				self.m_selectList:scrollToView(iter_4_0 - 1)

				break
			elseif self._info.autoSelcetData.type == g.core.common.Goods.TYPE_FRAGMENT then
				local var_4_0 = g.core.config.fragment_info.get(self._info.autoSelcetData.value)

				if iter_4_1.type == var_4_0.fragment_type and iter_4_1.value == var_4_0.fragment_value then
					self.m_selectList:setSelectedIndex(iter_4_0 - 1)
					self.m_selectList:scrollToView(iter_4_0 - 1)

					break
				end
			end
		end
	end
end

function BagNewSelectPop:_onItemRenderer(arg_5_1, arg_5_2)
	if self._listDatas[arg_5_1 + 1] then
		arg_5_2:updateCell(self._listDatas[arg_5_1 + 1])
	end
end

function BagNewSelectPop:_onClickItem()
	self._chooseIndex = self._chooseIndex == -1 and self.m_selectList:getSelectedIndex() or self._chooseIndex == self.m_selectList:getSelectedIndex() and -1 or self.m_selectList:getSelectedIndex()

	self.m_selectList:setSelectedIndex(self._chooseIndex)
end

function BagNewSelectPop:create(arg_7_1)
	arg_7_1 = arg_7_1 or 1

	local var_7_0 = BagNewSelectPop.new(self, arg_7_1)

	var_0_11:pushPopup(var_7_0, {
		touchDisappear = true
	})

	return var_7_0
end

function BagNewSelectPop:createUse(arg_8_1, arg_8_2, arg_8_3)
	arg_8_2 = arg_8_2 or 1

	local var_8_0 = var_0_14.fetch(self)

	if var_8_0 == nil then
		return false
	end

	if var_0_12:getLevel() < var_8_0.use_level then
		var_0_11:tip(var_0_7:get(200516, {
			level = var_8_0.use_level
		}))

		return false
	end

	local var_8_1 = var_8_0.toObject()

	if arg_8_1 == nil then
		function var_8_1.netHandler(arg_9_0, arg_9_1)
			var_0_8:send_C2S_Item_Use({
				id = arg_9_0,
				num = arg_9_1
			})
		end
	else
		var_8_1.okHandler = arg_8_1
	end

	if arg_8_3 then
		var_8_1.autoSelcetData = arg_8_3
	end

	if BagNewSelectPop._checkUseLimit(var_8_1) == 0 then
		return
	end

	BagNewSelectPop.create(var_8_1, arg_8_2)
end

function BagNewSelectPop:_checkUseLimit()
	local var_10_0 = -1

	if self.item_type == 3 and self.use_type == BagNewPropCfg.USE_TYPE.USE then
		local var_10_2 = {}

		for iter_10_0 = 1, var_0_2.getLength() do
			local var_10_3 = var_0_2.indexOf(iter_10_0)

			var_10_2[#var_10_2 + 1] = {
				type = var_10_3.type,
				value = var_10_3.value,
				limit = var_10_3.max_limit,
				name = var_10_3.name
			}
		end

		local var_10_4 = var_0_4.get(self.item_value, 1)

		for iter_10_1 = 1, 5 do
			if var_10_4["reward_type_" .. iter_10_1] ~= 0 then
				for iter_10_2 = 1, #var_10_2 do
					if var_10_4["reward_type_" .. iter_10_1] == 1 and var_10_4["reward_value_" .. iter_10_1] == var_10_2[iter_10_2].value then
						var_10_0 = math.floor((var_10_2[iter_10_2].limit - var_0_12.resourceData:getResourceById(var_10_2[iter_10_2].value)) / var_10_4["reward_min_" .. iter_10_1])

						if var_10_0 == 0 then
							var_0_11:tip(var_0_7:get(200515, {
								name = var_10_2[iter_10_2].name
							}))
						end

						break
					end
				end
			end
		end
	elseif self.use_type ~= BagNewPropCfg.USE_TYPE.DROP then
		if self.use_type == BagNewPropCfg.USE_TYPE.SELECT then
			var_10_0 = tonumber(var_0_3.get(var_0_5.BAG_TYPE.ITEM_LIMITE).parameter)
		end
	end

	return var_10_0
end

function BagNewSelectPop:_initBase(arg_11_1)
	local var_11_0 = 1
	local var_11_1, var_11_2 = BagNewSelectPop._checkUseLimit(arg_11_1)
	local var_11_3 = var_0_13:getOwnNum(var_0_5.BAG_TYPE.ITEM, arg_11_1.id)

	var_11_3 = var_11_1 < var_11_3 and var_11_1 or var_11_3

	self.m_subAddNumComp:initMinMaxNum({
		cur = 1,
		min = 1,
		max = var_11_3
	})
	self.m_btn:addClickListener(function()
		if arg_11_1.netHandler then
			var_0_9:removeListenerWithTarget(self)
			var_0_9:addEventListener(var_0_10.EVENT_NET_S2C_ITEM_USE, self._onRcvItemUse, self)
			arg_11_1.netHandler(arg_11_1.id, var_11_0)

			return
		end

		if arg_11_1.okHandler then
			local var_12_0 = {}

			if self.m_selectList ~= nil then
				local var_12_1 = self.m_selectList:getSelectedIndex()

				if var_12_1 < 0 then
					var_0_11:tip(var_0_7:get(200514))

					return
				end

				var_12_0.selectedIndex = var_12_1 + 1
			end

			var_12_0.id = arg_11_1.id
			var_12_0.count = self.m_subAddNumComp:getCurNum()

			if self._listDatas[var_12_0.selectedIndex] and self._listDatas[var_12_0.selectedIndex].type == g.core.common.Goods.TYPE_SKIN and g.core.model.User.skinData:getSkinState(self._listDatas[var_12_0.selectedIndex].value) ~= 0 then
				local var_12_2 = g.core.lang:get(10043) or ""

				var_0_11:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
					title = g.core.lang:get(111026),
					desc = var_12_2,
					onConfirm = function()
						var_0_11:popComponent()
						arg_11_1.okHandler(var_12_0)
					end,
					onCancel = function()
						return
					end
				}), {
					touchDisappear = true
				})

				return
			end

			if self._listDatas[var_12_0.selectedIndex] and var_0_6.HAS_PUT_CHECK then
				local var_12_3 = false

				if self._listDatas[var_12_0.selectedIndex].type == g.core.common.Goods.TYPE_KNIGHT then
					var_12_3 = g.core.config.knight_info.get(self._listDatas[var_12_0.selectedIndex].value).put == 0
				elseif self._listDatas[var_12_0.selectedIndex].type == g.core.common.Goods.TYPE_UNITETOKEN then
					var_12_3 = g.core.config.unite_token_info.get(self._listDatas[var_12_0.selectedIndex].value).put == 0
				elseif self._listDatas[var_12_0.selectedIndex].type == g.core.common.Goods.TYPE_ARTIFACT then
					var_12_3 = g.core.config.artifact_info.get(self._listDatas[var_12_0.selectedIndex].value).put == 0
				elseif self._listDatas[var_12_0.selectedIndex].type == g.core.common.Goods.TYPE_PET then
					var_12_3 = g.core.config.pet_info.get(self._listDatas[var_12_0.selectedIndex].value).put == 0
				end

				if var_12_3 then
					var_0_11:tip(g.core.lang:get(1159))

					return
				end
			end

			var_0_11:popComponent()
			arg_11_1.okHandler(var_12_0)
		end
	end)
end

function BagNewSelectPop:setFinishHandler(arg_15_1)
	self._finishHandler = arg_15_1
end

function BagNewSelectPop:_onRcvItemUse(arg_16_1, arg_16_2, arg_16_3)
	var_0_11:popComponent()

	if self._finishHandler then
		self._finishHandler(arg_16_3)
	end
end

return BagNewSelectPop
