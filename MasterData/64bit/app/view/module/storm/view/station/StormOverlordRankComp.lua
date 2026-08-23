local StormOverlordRankComp = class("StormOverlordRankComp", require("app.fairyGUI.storm.UI_StormOverlordRankComp"))

function StormOverlordRankComp:updateKnight(arg_1_1)
	self.m_rangeTxt:setText(g.core.lang:get(304535, {
		landName = (arg_1_1.city and arg_1_1.city > 0 or nil) and g.core.config.storm_info.get(arg_1_1.city).name
	}))
	self.m_playerNameTxt:setText(g.core.lang:get(304533, {
		name = arg_1_1.name,
		server = g.core.lang:getFormatServerName(arg_1_1.server_name)
	}))

	if arg_1_1 then
		local var_1_1 = arg_1_1.param or 0

		if var_1_1 > 0 and not g.core.model.User.stormCityData:isProcess() then
			self.m_upTimeTxt:setText(g.core.lang:get(304532, {
				num = g.core.utils.Number.toChineseNumber(var_1_1)
			}))
			self.m_stillRankController:setSelectedIndex(0)

			goto label_1_0
		end
	end

	self.m_stillRankController:setSelectedIndex(1)

	::label_1_0::
end

return StormOverlordRankComp
