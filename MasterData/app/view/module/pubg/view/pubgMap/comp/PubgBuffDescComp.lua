local var_0_0 = g.core.config.pubg_effect_info
local var_0_1 = g.core.model.User.pubgData
local PubgBuffDescComp = class("PubgBuffDescComp", require("app.fairyGUI.pubg.UI_PubgBuffDescComp"))

function PubgBuffDescComp:updateDescComp(arg_1_1)
	local var_1_0 = var_0_1:getMapData()
	local var_1_1 = var_1_0:getMyUser():getBuff(arg_1_1)

	if not var_1_0 then
		var_1_1 = {}
	end

	local var_1_2 = var_1_1.level or 0

	self.m_buff:setBuffTp(arg_1_1)
	self.m_buff:updateBuffIcon()

	local var_1_3 = var_1_1.cfg or var_0_1:getMapData():getBuffInfo(arg_1_1, var_1_2 <= 0 and 1 or var_1_2)
	local var_1_4 = {
		name = var_1_3.name,
		curLevel = var_1_2
	}

	var_1_4.maxLevel = var_0_1:getMapData():getBuffMaxLevel(arg_1_1)

	self.m_name:setText(g.core.lang:get(430932, var_1_4))
	self.m_desc:setText(var_1_3.des)
end

function PubgBuffDescComp:updateAirBuffDescComp(arg_2_1)
	self._buffData = arg_2_1

	local var_2_0 = var_0_0.get(arg_2_1.base_id)

	self.m_name:setText(var_2_0.name)
	self.m_desc:setText(var_2_0.res)
	self.m_buff:setBuffIcon(var_2_0)
end

return PubgBuffDescComp
