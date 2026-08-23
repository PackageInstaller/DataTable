local MonopolyGridNumberComp = class("MonopolyGridNumberComp", require("app.fairyGUI.monopoly.UI_MonopolyGridNumberComp"))
local var_0_1 = "ui://monopoly/pic_mnzj_zjm_shuzi"

function MonopolyGridNumberComp:setNumProgressShow(arg_1_1, arg_1_2)
	self.m_isMaxController:setSelectedIndex(0)
	self.m_l1:setURL("")
	self.m_l2:setURL("")
	self.m_r1:setURL("")
	self.m_r2:setURL("")

	if arg_1_1 > 10 then
		self.m_l1:setURL(var_0_1 .. arg_1_1 % 10)
		self.m_l2:setURL(var_0_1 .. math.floor(arg_1_1 / 10))
	else
		self.m_l1:setURL(var_0_1 .. arg_1_1)
	end

	if arg_1_2 > 10 then
		self.m_r1:setURL(var_0_1 .. math.floor(arg_1_2 / 10))
		self.m_r2:setURL(var_0_1 .. arg_1_2 % 10)
	else
		self.m_r1:setURL(var_0_1 .. arg_1_2)
	end
end

function MonopolyGridNumberComp:setIsMax()
	self.m_isMaxController:setSelectedIndex(1)
end

return MonopolyGridNumberComp
