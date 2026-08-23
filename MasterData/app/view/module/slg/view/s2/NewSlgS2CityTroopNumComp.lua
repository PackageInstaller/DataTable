local NewSlgS2CityTroopNumComp = class("NewSlgS2CityTroopNumComp", require("app.fairyGUI.newSlg.UI_NewSlgS2CityTroopNumComp"))

function NewSlgS2CityTroopNumComp:ctor()
	self._txtSelfNum = self:getChild("Txt_selfNum")
	self._txtDefNum = self:getChild("Txt_defNum")
	self._compProg = self:getChild("Comp_prog")
end

function NewSlgS2CityTroopNumComp:updateView(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_1.num1 or 0
	local var_2_1 = arg_2_1.num2 or 0
	local var_2_2 = arg_2_1.isDef

	self._txtSelfNum:setText(var_2_0)
	self._txtDefNum:setText(var_2_1)

	if var_2_0 == 0 and var_2_1 == 0 then
		self._compProg:setMax(100)

		if var_2_2 then
			self._compProg:setValue(0)
		else
			self._compProg:setValue(100)
		end
	elseif var_2_0 == 0 then
		self.m_Comp_prog:setMax(100)
		self.m_Comp_prog:setValue(0)
	elseif var_2_1 == 0 then
		self.m_Comp_prog:setMax(100)
		self.m_Comp_prog:setValue(100)
	else
		self.m_Comp_prog:setMax(var_2_0 + var_2_1)
		self.m_Comp_prog:setValue(var_2_0)
	end
end

return NewSlgS2CityTroopNumComp
