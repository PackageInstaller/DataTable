local var_0_0 = g.core.model.User.knightSoulData
local KnightSoulHonorComp = class("KnightSoulHonorComp", require("app.fairyGUI.knightSoul.UI_KnightSoulHonorComp"))

function KnightSoulHonorComp:ctor()
	self._honorNum = 0
	self._activationHonorId = 0
	self._maxHonorId = var_0_0:getMaxHonorId()
end

function KnightSoulHonorComp:updateHonorComp()
	local var_2_0 = var_0_0:getCurHonorNum()

	self.m_honorNum:setText(var_2_0)

	if var_0_0:getActivationHonorId() == self._maxHonorId then
		self.m_isMaxController:setSelectedIndex(1)
		self.m_processBar:setMax(var_2_0)
		self.m_processBar:setValue(var_2_0)
	else
		self.m_isMaxController:setSelectedIndex(0)

		local var_2_1 = var_0_0:getCurActivationHonorId()
		local var_2_2 = var_0_0:getHonorNumById(var_2_1)

		self.m_processTxt:setText(math.min(var_2_0, var_2_2) .. "/" .. var_2_2)
		self.m_processBar:setMax(var_2_2)
		self.m_processBar:setValue(var_2_0)

		local var_2_3 = g.core.config.ksoul_honor_info.fetch(var_2_1)

		if var_2_3 then
			self.m_tipTxt:setText(g.core.lang:get(410601, {
				name = var_2_3.name
			}))
		end
	end
end

return KnightSoulHonorComp
