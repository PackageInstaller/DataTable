local var_0_0 = g.core.model.User.fogNightmareData
local var_0_1 = g.core.common.Goods
local FogNightmareDetailPop = class("FogNightmareDetailPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareDetailPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareDetailPop",
		pkgPath = "ui/fogNightmare/fogNightmare",
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightmareDetailPop:ctor()
	self:showAtCenter()
	self:initView()
end

function FogNightmareDetailPop:initView()
	local var_3_0 = var_0_0:getIdleData()
	local var_3_1 = var_3_0:getCurDayRewardItem()

	for iter_3_0 = 1, 2 do
		if var_3_1[iter_3_0] then
			local var_3_2 = var_0_1:convert(var_3_1[iter_3_0])

			self["m_curReward" .. iter_3_0]:setTitle(g.core.lang:get(500107, {
				num = var_3_1[iter_3_0].size
			}))
			self["m_curReward" .. iter_3_0]:setIcon(var_3_2.icon)
		end
	end

	local var_3_3, var_3_4 = var_3_0:getNextStageDayRewardItem()

	if #var_3_3 == 0 then
		self.m_maxFloorController:setSelectedIndex(1)
	else
		self.m_maxFloorController:setSelectedIndex(0)

		for iter_3_1 = 1, 2 do
			if var_3_3[iter_3_1] then
				local var_3_5 = var_0_1:convert(var_3_3[iter_3_1])

				self["m_nextReward" .. iter_3_1]:setTitle(g.core.lang:get(500107, {
					num = var_3_3[iter_3_1].size
				}))
				self["m_nextReward" .. iter_3_1]:setIcon(var_3_5.icon)
			end
		end

		self.m_nextStageTxt:setText(g.core.lang:get(500108, {
			num = var_3_4.floor_id
		}))
	end
end

return FogNightmareDetailPop
