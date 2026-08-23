local EasterEggDescComp = class("EasterEggDescComp")

function EasterEggDescComp:ctor()
	self.m_eggDesc = self:getChild("eggDesc")
end

function EasterEggDescComp:setDesc(arg_2_1)
	self.m_eggDesc:setText(arg_2_1)
end

return EasterEggDescComp
