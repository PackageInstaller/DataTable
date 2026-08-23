local BaseUsePop = class("BaseUsePop", require("app.fairyGUI.infoPop.UI_BaseUsePop"), function()
	return fgui.GComponent:create({
		resName = "BaseUsePop",
		pkgName = "infoPop",
		pkgPath = "ui/infoPop/infoPop"
	})
end)
local var_0_1 = g.core.config.basic_figure_info
local var_0_2 = g.core.config.parameter_info
local var_0_3 = g.core.config.drop_info
local var_0_4 = g.core.const.ConstMgr
local var_0_5 = g.core.lang
local var_0_6 = g.core.network.GameNetProxy
local var_0_7 = g.core.event.EventManager
local var_0_8 = g.core.event.enum
local var_0_9 = g.core.module.ModuleManager
local var_0_10 = g.core.model.User
local var_0_11 = g.core.model.User.bagData
local var_0_12 = g.core.config.item_info

function BaseUsePop:ctor(arg_2_1, arg_2_2)
	arg_2_2 = arg_2_2 or 1
	self._type = arg_2_2

	self:showAtCenter()
	self:_initBase(arg_2_1)

	self._listView = nil
	self._chooseItems = nil

	if arg_2_1.use_type == 1 or arg_2_1.use_type == 2 then
		self:_updateUseItem(arg_2_1)
	elseif arg_2_1.use_type == 3 then
		-- block empty
	else
		return
	end
end

function BaseUsePop:create(arg_3_1)
	arg_3_1 = arg_3_1 or 1

	local var_3_0 = BaseUsePop.new(self, arg_3_1)

	var_0_9:pushPopup(var_3_0, {
		touchDisappear = self.use_type == 1 or self.use_type == 2
	})

	return var_3_0
end

function BaseUsePop:createUse(arg_4_1, arg_4_2)
	arg_4_2 = arg_4_2 or 1

	local var_4_0 = var_0_12.fetch(self)

	if var_4_0 == nil then
		return false
	end

	if var_0_10:getLevel() < var_4_0.use_level then
		var_0_9:tip(var_0_5:get(1066, {
			level = var_4_0.use_level
		}))

		return false
	end

	local var_4_1 = var_4_0.toObject()

	if arg_4_1 == nil then
		function var_4_1.netHandler(arg_5_0, arg_5_1)
			var_0_6:send_C2S_Item_Use({
				id = arg_5_0,
				num = arg_5_1
			})
		end
	else
		var_4_1.okHandler = arg_4_1
	end

	if BaseUsePop._checkUseLimit(var_4_1) == 0 then
		return
	end

	BaseUsePop.create(var_4_1, arg_4_2)
end

function BaseUsePop:createPlayNumItemUse(arg_6_1)
	local var_6_0 = var_0_12.fetch(self)

	if var_6_0 == nil then
		return false
	end

	if var_0_10:getLevel() < var_6_0.use_level then
		var_0_9:tip(var_0_5:get(1066, {
			level = var_6_0.use_level
		}))

		return false
	end

	local var_6_1 = var_6_0.toObject()

	function var_6_1.netHandler(arg_7_0, arg_7_1)
		var_0_6:send_C2S_Item_Use({
			id = arg_7_0,
			num = arg_7_1
		})
	end

	if BaseUsePop._checkUseLimit(var_6_1) == 0 then
		return
	end

	local var_6_2 = BaseUsePop.create(var_6_1, 1)

	if var_6_2 then
		var_6_2:setFinishHandler(function(arg_8_0)
			if arg_8_0 then
				local var_8_0 = arg_8_0.id or 0

				if var_8_0 > 0 then
					local var_8_1 = var_0_12.get(var_8_0)

					if var_8_1 then
						var_0_9:tip(var_8_1.use_text)

						if arg_6_1 then
							arg_6_1()
						end
					end
				end
			end
		end)
	end
end

function BaseUsePop:_checkUseLimit()
	local var_9_0 = -1

	if self.item_type == 3 and self.use_type == 1 then
		local var_9_2 = {}

		for iter_9_0 = 1, var_0_1.getLength() do
			local var_9_3 = var_0_1.indexOf(iter_9_0)

			var_9_2[#var_9_2 + 1] = {
				type = var_9_3.type,
				value = var_9_3.value,
				limit = var_9_3.max_limit,
				name = var_9_3.name
			}
		end

		local var_9_4 = var_0_3.get(self.item_value, 1)

		for iter_9_1 = 1, 5 do
			if var_9_4["reward_type_" .. iter_9_1] ~= 0 then
				for iter_9_2 = 1, #var_9_2 do
					if var_9_4["reward_type_" .. iter_9_1] == 1 and var_9_4["reward_value_" .. iter_9_1] == var_9_2[iter_9_2].value then
						var_9_0 = math.floor((var_9_2[iter_9_2].limit - var_0_10.resourceData:getResourceById(var_9_2[iter_9_2].value)) / var_9_4["reward_min_" .. iter_9_1])

						if var_9_0 == 0 then
							var_0_9:tip(var_0_5:get(1014, {
								name = var_9_2[iter_9_2].name
							}))
						end

						break
					end
				end
			end
		end
	elseif self.use_type ~= 2 then
		if self.use_type == 3 then
			var_9_0 = tonumber(var_0_2.get(var_0_4.BAG_TYPE.ITEM_LIMITE).parameter)
		end
	end

	return var_9_0
end

function BaseUsePop:_updateUseItem(arg_10_1)
	self.m_baseItem:updateIcon({
		type = var_0_4.BAG_TYPE.ITEM,
		value = arg_10_1.id,
		size = var_0_11:getOwnNum(var_0_4.BAG_TYPE.ITEM, arg_10_1.id)
	})
end

function BaseUsePop:_initBase(arg_11_1)
	local var_11_0 = 1
	local var_11_1, var_11_2 = BaseUsePop._checkUseLimit(arg_11_1)

	self.m_chooseNumComp:initMinMaxNum({
		min = 1,
		cur = 1,
		max = var_0_11:getOwnNum(var_0_4.BAG_TYPE.ITEM, arg_11_1.id),
		callback = function(arg_12_0)
			if var_11_1 ~= -1 and arg_12_0 > var_11_1 then
				if not var_11_2 then
					var_0_9:tip(var_0_5:get(2054))
				end

				arg_12_0 = var_11_1

				self.m_chooseNumComp:setCurNum(var_11_1)
			end

			var_11_0 = self.m_chooseNumComp:getCurNum()
		end
	})
	self.m_confirmBtn:addClickListener(function()
		if arg_11_1.netHandler then
			var_0_7:removeListenerWithTarget(self)
			var_0_7:addEventListener(var_0_8.EVENT_NET_S2C_ITEM_USE, self._onRcvItemUse, self)
			arg_11_1.netHandler(arg_11_1.id, var_11_0)

			return
		end

		if arg_11_1.okHandler then
			local var_13_0 = {}

			if self._listView ~= nil then
				local var_13_1 = self._listView:getSelectedIndex()

				if var_13_1 < 0 then
					var_0_9:tip(var_0_5:get(2055))

					return
				end

				var_13_0.selectedIndex = var_13_1 + 1
			end

			var_13_0.id = arg_11_1.id
			var_13_0.count = var_11_0

			var_0_9:popComponent()
			arg_11_1.okHandler(var_13_0)
		end
	end)
end

function BaseUsePop:setFinishHandler(arg_14_1)
	self._finishHandler = arg_14_1
end

function BaseUsePop:_onRcvItemUse(arg_15_1, arg_15_2, arg_15_3)
	var_0_9:popComponent()

	if self._finishHandler then
		self._finishHandler(arg_15_3)
	end
end

return BaseUsePop
