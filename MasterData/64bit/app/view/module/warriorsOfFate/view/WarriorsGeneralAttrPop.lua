local var_0_0 = g.core.model.User.warriorsOfFateData
local WarriorsConst = require("app.view.module.warriorsOfFate.const.WarriorsConst")
local WarriorsGeneralAttrPop = class("WarriorsGeneralAttrPop", require("app.fairyGUI.warriorsOfFate.UI_WarriorsGeneralAttrPop"), function()
	return fgui.GComponent:create({
		resName = "WarriorsGeneralAttrPop",
		pkgName = "warriorsOfFate",
		isFullScreen = false,
		pkgPath = "ui/warriorsOfFate/warriorsOfFate"
	}, ...)
end)

function WarriorsGeneralAttrPop:ctor(arg_2_1)
	self._tabType = arg_2_1.tabType
	self.attrsData = {}

	self:showAtCenter()
	self.m_attrsList:setVirtual(self)
	self.m_attrsList:setItemRenderer(handler(self, self._onAttrsItemRenderer))
end

function WarriorsGeneralAttrPop:onLoad()
	if not self._tabType then
		return
	end

	self:_updateView()
end

function WarriorsGeneralAttrPop:_updateView()
	self:_updateAtrrsList()
end

function WarriorsGeneralAttrPop:_updateAtrrsList()
	local var_5_0 = {}
	local var_5_1 = var_0_0:getActChaptersByType(self._tabType)

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		var_5_0[iter_5_1.attribute_type] = var_5_0[iter_5_1.attribute_type] or {
			value = 0,
			type = iter_5_1.attribute_type
		}
		var_5_0[iter_5_1.attribute_type].value = var_5_0[iter_5_1.attribute_type].value + iter_5_1.attribute_value
	end

	if self._tabType == WarriorsConst.GENERAL then
		for iter_5_2, iter_5_3 in pairs(var_5_1) do
			for iter_5_4, iter_5_5 in ipairs(iter_5_3) do
				if iter_5_5.stage_id ~= 0 then
					local var_5_2 = g.core.config.scroll_stage_growth_info.get(iter_5_5.stage_id)

					for iter_5_6 = 1, 4 do
						var_5_0[var_5_2["attribute_type_" .. iter_5_6]] = var_5_0[var_5_2["attribute_type_" .. iter_5_6]] or {
							value = 0,
							type = var_5_2["attribute_type_" .. iter_5_6]
						}
						var_5_0[var_5_2["attribute_type_" .. iter_5_6]].value = var_5_0[var_5_2["attribute_type_" .. iter_5_6]].value + var_5_2["attribute_value_" .. 1]
					end
				end
			end
		end
	end

	self.attrsData = table.values(var_5_0)

	self.m_attrsList:setNumItems(#self.attrsData)
	self.m_attrStateController:setSelectedIndex(#self.attrsData > 0 and 0 or 1)
end

function WarriorsGeneralAttrPop:_onAttrsItemRenderer(arg_6_1, arg_6_2)
	local var_6_0, var_6_1 = g.core.lang:getAttr(self.attrsData[arg_6_1 + 1].type, self.attrsData[arg_6_1 + 1].value)

	arg_6_2:updateAttr({
		name = var_6_0,
		value = var_6_1
	})
end

return WarriorsGeneralAttrPop
