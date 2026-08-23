local var_0_0 = g.core.config.talent_skill_info
local KnightSpProtectAttrCell = class("KnightSpProtectAttrCell", require("app.fairyGUI.knight.UI_KnightSpProtectAttrCell"))

function KnightSpProtectAttrCell:ctor()
	self._knight = nil

	self.m_knightIcon:setShowInfoEnable(true)
end

function KnightSpProtectAttrCell:updateAttrDetail(arg_2_1, arg_2_2)
	table.sort(arg_2_1, function(arg_3_0, arg_3_1)
		return arg_3_0.cfg.star < arg_3_1.cfg.star
	end)

	local var_2_0 = arg_2_1[1].knightAdvId
	local var_2_1 = g.core.model.User.knightsData:getKnight({
		advance_id = arg_2_1[1].knightAdvId
	})

	self._knight = var_2_1

	local var_2_2 = -1

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if iter_2_1.cfg.star <= var_2_1:getStar() then
			var_2_2 = iter_2_0
		else
			break
		end
	end

	self.m_isActiveController:setSelectedIndex(arg_2_2:isSpSupportActive(var_2_0) and 1 or 0)
	self.m_nameTxt:setText(var_2_1:getName())
	self.m_knightIcon:updateIcon({
		overrideClick = true,
		struct = var_2_1,
		star = var_2_1:getStar()
	})
	self.m_knightIcon:setTouchFunc(handler(self, self.onGetKnightClick))

	local var_2_3 = var_0_0.get(arg_2_1[var_2_2 == -1 and 1 or var_2_2].cfg.talent_skill)
	local var_2_4 = {}
	local var_2_5 = 1

	while var_0_0.hasKey("affect_type_" .. var_2_5) do
		if var_2_3["affect_type_" .. var_2_5] > 0 then
			var_2_4[var_2_3["affect_type_" .. var_2_5]] = var_2_4[var_2_3["affect_type_" .. var_2_5]] or 0
			var_2_4[var_2_3["affect_type_" .. var_2_5]] = var_2_4[var_2_3["affect_type_" .. var_2_5]] + var_2_3["affect_value_" .. var_2_5]
		end

		var_2_5 = var_2_5 + 1
	end

	local var_2_6 = ""

	for iter_2_2, iter_2_3 in pairs(var_2_4) do
		local var_2_7, var_2_8 = g.core.lang:getAttr(iter_2_2, iter_2_3)

		var_2_6 = var_2_6 .. g.core.lang:get(105007, {
			name = var_2_7,
			value = var_2_8
		}) .. "\n"
	end

	self.m_attrDescTxt:setText(var_2_6)
end

function KnightSpProtectAttrCell:onGetKnightClick()
	if not self._knight then
		return
	end

	g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
		size = 1,
		type = g.core.common.Goods.TYPE_KNIGHT,
		value = self._knight:getBaseId()
	})
end

return KnightSpProtectAttrCell
