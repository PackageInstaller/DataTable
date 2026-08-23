local var_0_0 = g.core.common.Goods
local StormOverlordRoadPop = class("StormOverlordRoadPop", require("app.fairyGUI.storm.UI_StormOverlordRoadPop"), function()
	return fgui.GComponent:create({
		resName = "StormOverlordRoadPop",
		pkgPath = "ui/storm/storm",
		pkgName = "storm"
	}, ...)
end)

function StormOverlordRoadPop:ctor()
	self._selfRecord = nil

	self.m_infoList:setVirtual()
	self.m_infoList:setItemRenderer(handler(self, self._onInfoCellRenderer))
	self.m_infoList:doFairyBatching(false)
	self:showAtCenter()
	self:_initView()
end

function StormOverlordRoadPop:_initView()
	local var_3_0 = g.core.config.resource_info.get(var_0_0.RESOURCE.TYPE_LORD).name

	for iter_3_0, iter_3_1 in ipairs((g.core.model.User.stormCityData:getLordRankInfoList())) do
		local var_3_1 = 0

		while iter_3_1["reward_type" .. 1] > 0 do
			if iter_3_1["reward_type" .. 1] == var_0_0.TYPE_RESOURCE and iter_3_1["reward_value" .. 1] == var_0_0.RESOURCE.TYPE_LORD then
				var_3_1 = iter_3_1["reward_size" .. 1]

				break
			end
		end

		local var_3_3

		if var_3_1 > 0 then
			self["m_descTxt" .. 1]:setText((g.core.lang:get(304618, {
				city = g.core.config.storm_info.get(iter_3_1.rank_type).name,
				name = var_3_0,
				num = var_3_1
			})))

			var_3_3 = 1 + 1
		end
	end

	self:_updateView()
end

function StormOverlordRoadPop:_updateView()
	self._selfRecord = g.core.model.User.stormCityData:getSelfLordRecord()

	table.sort(self._selfRecord, function(arg_5_0, arg_5_1)
		return arg_5_0.time < arg_5_1.time
	end)

	if #self._selfRecord > 0 then
		self.m_stateController:setSelectedIndex(1)
		self.m_infoList:setNumItems(#self._selfRecord)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function StormOverlordRoadPop:_onInfoCellRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateView(self._selfRecord[arg_6_1 + 1])
end

return StormOverlordRoadPop
