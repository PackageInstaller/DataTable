local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.bagData
local var_0_2 = g.core.common.Path
local InfoItemsGiftBagPop = class("InfoItemsGiftBagPop", require("app.fairyGUI.infoPop.UI_InfoItemsGiftBagPop"), function()
	return fgui.GComponent:create({
		resName = "InfoItemsGiftBagPop",
		pkgPath = "ui/infoPop/infoPop",
		pkgName = "infoPop"
	}, ...)
end)

function InfoItemsGiftBagPop:ctor(arg_2_1)
	self._giftList = {}
	self._dropType = 0
	self._list = nil

	self:showAtCenter()
	self:_initView()
	self:_updateView(arg_2_1)
end

function InfoItemsGiftBagPop:_initView()
	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onItemRenderer))
end

function InfoItemsGiftBagPop:_onItemRenderer(arg_4_1, arg_4_2)
	self._giftList[arg_4_1 + 1].hideNum = false

	arg_4_2:updateIcon(self._giftList[arg_4_1 + 1])
end

function InfoItemsGiftBagPop:_updateView(arg_5_1)
	local var_5_0 = {
		type = arg_5_1.type,
		value = arg_5_1.value
	}

	var_5_0.size = arg_5_1.size or 1

	local var_5_1 = var_0_0:convert(var_5_0)

	self.m_baseItem:setURL(var_5_1.bigIcon or var_5_1.icon)
	self.m_itemBg:setURL(var_0_2:getBaseBuyPopItemBg(var_5_1.quality))
	self.m_nameTxt:setText(var_5_1.name)

	if self.m_nameTxt:getWidth() > 436 then
		self.m_nameTxt:setWidth(436)
		self.m_nameTxt:setAutoSize(3)
	end

	self.m_nameBg:setURL(var_0_2:getBaseBuyPopNameBg(var_5_1.quality or 0))
	self.m_haveNumTxt:setText(var_0_1:getOwnNum(arg_5_1.type, arg_5_1.value))

	local var_5_2 = g.core.config.item_info.get(arg_5_1.value)

	self._itemInfo = var_5_2

	self:_initGiftInfo(var_5_2.item_value)

	local var_5_3 = ""
	local var_5_4

	if var_5_2.use_type == 2 then
		if self._dropType == 1 then
			var_5_3 = g.core.lang:get(400010)
		elseif self._dropType == 2 then
			var_5_3 = g.core.lang:get(400011)
		elseif self._dropType == 3 then
			var_5_3 = g.core.lang:get(400012)
		end
	elseif var_5_2.use_type == 3 then
		var_5_3 = g.core.lang:get(400009)
		var_5_4 = g.core.platform.PlatformProxy:getCurChannel().name == require("app.core.platform.const.ChannelConst").ChannelNames.HUAWEI
	end

	if (config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.KR or var_5_4) and var_5_2.item_value == 900004 and var_5_2.item_type == 3 then
		self.m_useTxt:setText(g.core.lang:get(108497))
	else
		self.m_useTxt:setText(var_5_3)
	end
end

function InfoItemsGiftBagPop:_getGiftInfo(arg_6_1)
	local var_6_0 = {}

	for iter_6_0 = 1, g.core.config.drop_info.getLength() do
		local var_6_1 = g.core.config.drop_info.indexOf(iter_6_0)

		if var_6_1.id == arg_6_1 then
			self._dropType = var_6_1.drop_mode

			table.insert(var_6_0, var_6_1)
		end
	end

	return var_6_0
end

function InfoItemsGiftBagPop:_initGiftInfo(arg_7_1)
	self._giftList = {}

	local var_7_0 = 0
	local var_7_1 = 0
	local var_7_2 = {}

	for iter_7_0, iter_7_1 in ipairs((self:_getGiftInfo(arg_7_1))) do
		if self._itemInfo.item_type == 3 and self._itemInfo.item_value ~= 0 then
			if iter_7_1.drop_mode == 1 then
				var_7_1 = 0

				for iter_7_2 = 1, 5 do
					var_7_1 = var_7_1 + iter_7_1["reward_pro_" .. iter_7_2]
				end

				var_7_0 = var_7_0 + var_7_1
			elseif iter_7_1.drop_mode == 3 then
				var_7_1 = iter_7_1.drop_pro
			end
		end

		for iter_7_3 = 1, 5 do
			if iter_7_1["reward_type_" .. iter_7_3] > 0 then
				local var_7_5

				if iter_7_1["reward_type_" .. iter_7_3] == g.core.common.Goods.TYPE_ROLE_SKIN then
					local var_7_4 = g.core.config.role_skin_info.get(g.core.config.role_skin_module_info.get(iter_7_1["reward_value_" .. iter_7_3]).id).gender

					var_7_5 = var_7_4 == 2 or (g.core.model.User:getUserUniqueAdvanceId() == 210000 and 1 or 0) == var_7_4
				else
					var_7_5 = true
				end
			end
		end
	end

	for iter_7_4, iter_7_5 in ipairs(var_7_2) do
		iter_7_5.prob = string.format("%.2f%%", tonumber(iter_7_5.tempProb) / var_7_0)
		iter_7_5.tempProb = nil
	end

	self.m_itemList:setNumItems(#self._giftList)
end

return InfoItemsGiftBagPop
