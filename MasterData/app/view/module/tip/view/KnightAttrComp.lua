local KnightAttrComp = class("KnightAttrComp", require("app.fairyGUI.tip.UI_KnightAttrComp"))

KnightAttrComp.SENIOR_ATTR_NUM = 18
KnightAttrComp.PROB_NUM = 6
KnightAttrComp.MASTER_ID = 910
KnightAttrComp.RESIST_ID = 911
KnightAttrComp.ELEM_ATTR_PRE = 1400
KnightAttrComp.ELEM_ATTR_PRE_NUM = 12
KnightAttrComp.ELEM_ATTR = 1500
KnightAttrComp.ELEM_ATTR_NUM = 10

local var_0_1 = g.core.model.User.knightsData
local TipConst = require("app.view.module.tip.const.TipConst")

function KnightAttrComp:ctor()
	self:_initList()
end

function KnightAttrComp:_initList()
	self.m_baseAttrList:setIniter()
	self.m_baseAttrList:setItemRenderer(handler(self, self._onBaseAttrRenderer))
	self.m_seniorAttrList:setIniter()
	self.m_seniorAttrList:setItemRenderer(handler(self, self._onSeniorAttrRenderer))
	self.m_elemAttrList:setIniter()
	self.m_elemAttrList:setItemRenderer(handler(self, self._onElemAttrRenderer))
	self.m_baseAttrComp:addClickListener(handler(self, self._clickBaseAttrTitle))
	self.m_seniorAttrComp:addClickListener(handler(self, self._clickSeniorAttrTitle))
	self.m_elemAttrComp:addClickListener(handler(self, self._clickElemAttrTitle))
end

function KnightAttrComp:updateComp(arg_3_1)
	if arg_3_1.knightSid and arg_3_1.knightSid > 0 then
		local var_3_0 = var_0_1:getKnight({
			id = arg_3_1.knightSid
		})
		local var_3_1 = var_3_0:getBaseInfo()

		self.m_icon:updateIcon({
			sid = arg_3_1.knightSid
		})

		if var_3_0:isMain() then
			self.m_nameText:setText(g.core.model.User:getName())
		else
			self.m_nameText:setText(var_3_1.name)
		end

		self.m_featureText:setText(var_3_1.feature)

		self._data = {}
		self._data.baseAttr = var_3_0:getBaseAttrs()
		self._data.seniorAttr = {}

		local var_3_2 = var_3_0:getInfo().other_attrs

		if var_3_2 then
			for iter_3_0 = 1, KnightAttrComp.SENIOR_ATTR_NUM do
				local var_3_3 = 100 + iter_3_0

				if iter_3_0 > KnightAttrComp.PROB_NUM then
					var_3_3 = 200 + iter_3_0 - KnightAttrComp.PROB_NUM
				end

				local var_3_4 = 0

				for iter_3_1, iter_3_2 in pairs(var_3_2) do
					if iter_3_2.id == var_3_3 then
						var_3_4 = iter_3_2.num

						break
					end
				end

				table.insert(self._data.seniorAttr, {
					type = var_3_3,
					value = var_3_4
				})
			end

			local var_3_5 = false
			local var_3_6 = false

			for iter_3_3, iter_3_4 in pairs(var_3_2) do
				if iter_3_4.id == KnightAttrComp.MASTER_ID then
					table.insert(self._data.seniorAttr, {
						type = iter_3_4.id,
						value = iter_3_4.num
					})

					var_3_5 = true
				elseif iter_3_4.id == KnightAttrComp.RESIST_ID then
					table.insert(self._data.seniorAttr, {
						type = iter_3_4.id,
						value = iter_3_4.num
					})

					var_3_6 = true
				end
			end

			if not var_3_5 then
				table.insert(self._data.seniorAttr, {
					value = 0,
					type = KnightAttrComp.MASTER_ID
				})
			end

			if not var_3_6 then
				table.insert(self._data.seniorAttr, {
					value = 0,
					type = KnightAttrComp.RESIST_ID
				})
			end
		end

		self._data.elemAttr = {}

		for iter_3_5 = 1, KnightAttrComp.ELEM_ATTR_PRE_NUM do
			local var_3_7 = 0

			for iter_3_6, iter_3_7 in pairs(var_3_2) do
				if iter_3_7.id == KnightAttrComp.ELEM_ATTR_PRE + iter_3_5 then
					var_3_7 = iter_3_7.num

					break
				end
			end

			table.insert(self._data.elemAttr, {
				type = KnightAttrComp.ELEM_ATTR_PRE + iter_3_5,
				value = var_3_7
			})
		end

		for iter_3_8 = 1, KnightAttrComp.ELEM_ATTR_NUM do
			local var_3_8 = 0

			for iter_3_9, iter_3_10 in pairs(var_3_2) do
				if iter_3_10.id == KnightAttrComp.ELEM_ATTR + iter_3_8 then
					var_3_8 = iter_3_10.num

					break
				end
			end

			table.insert(self._data.elemAttr, {
				type = KnightAttrComp.ELEM_ATTR + iter_3_8,
				value = var_3_8
			})
		end

		self.m_baseAttrList:setNumItems(#self._data.baseAttr)
		self.m_baseAttrList:setNumItems(#self._data.baseAttr)

		if self._data.seniorAttr then
			self.m_seniorAttrList:setNumItems(#self._data.seniorAttr)
			self.m_seniorAttrList:resizeToFit(#self._data.seniorAttr)
		end

		self.m_elemAttrList:setNumItems(#self._data.elemAttr)
		self.m_elemAttrList:resizeToFit(#self._data.elemAttr)
	end
end

function KnightAttrComp:_onBaseAttrRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._data.baseAttr[arg_4_1 + 1])
end

function KnightAttrComp:_onSeniorAttrRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._data.seniorAttr[arg_5_1 + 1])
end

function KnightAttrComp:_onElemAttrRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._data.elemAttr[arg_6_1 + 1])
end

function KnightAttrComp:getObjAttrByType(arg_7_1)
	if arg_7_1 == TipConst.KnightAttrType.SENIOR_ATTR_TYPE then
		return self._data.seniorAttr or {}
	elseif arg_7_1 == TipConst.KnightAttrType.ELEM_ATTR_TYPE then
		return self._data.elemAttr or {}
	else
		return self._data.baseAttr or {}
	end
end

function KnightAttrComp:_clickBaseAttrTitle(arg_8_1)
	self:_clickAttrTitle(TipConst.KnightAttrType.BASE_ATTR_TYPE, arg_8_1)
end

function KnightAttrComp:_clickSeniorAttrTitle(arg_9_1)
	self:_clickAttrTitle(TipConst.KnightAttrType.SENIOR_ATTR_TYPE, arg_9_1)
end

function KnightAttrComp:_clickElemAttrTitle(arg_10_1)
	self:_clickAttrTitle(TipConst.KnightAttrType.ELEM_ATTR_TYPE, arg_10_1)
end

function KnightAttrComp:_clickAttrTitle(arg_11_1, arg_11_2)
	local var_11_0 = {}
	local var_11_1 = arg_11_2:getInput():getTouch()

	var_11_0.x = var_11_1:getLocationInView().x
	var_11_0.y = var_11_1:getLocationInView().y

	self:dispatchCompEvent("KnightAttrExpandClick", {
		type = arg_11_1,
		pos = var_11_0
	})
end

return KnightAttrComp
