local var_0_0 = g.core.model.User.gmTotalRechargeData
local GmTotalRechargeTurnPop = class("GmTotalRechargeTurnPop", require("app.fairyGUI.gmTotalRecharge.UI_GmTotalRechargeTurnPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/gmTotalRecharge/gmTotalRecharge",
		resName = "GmTotalRechargeTurnPop",
		pkgName = "gmTotalRecharge"
	}, ...)
end)

function GmTotalRechargeTurnPop:ctor()
	self:showAtCenter()
	self:_updateRepeatView()
end

function GmTotalRechargeTurnPop:_updateRepeatView()
	local var_3_0 = var_0_0:getGmTotalRechargeGroupInfo()

	self.m_itemComp1:updateIcon({
		type = var_3_0.type,
		value = var_3_0.value
	})
	self.m_numTxt1:setText("×" .. 1)

	local var_3_1 = g.core.config.skin_info.fetch(var_3_0.value)

	if var_3_1 then
		self.m_itemComp2:updateIcon({
			type = var_3_1.repeat_type,
			value = var_3_1.repeat_value
		})
		self.m_numTxt2:setText("×" .. var_3_1.repeat_number)
		self.m_descTxt:setText(g.core.lang:get(404506, {
			num = var_3_1.repeat_number
		}))
	end
end

return GmTotalRechargeTurnPop
