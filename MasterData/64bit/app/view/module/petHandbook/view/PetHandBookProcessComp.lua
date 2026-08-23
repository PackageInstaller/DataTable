local var_0_0 = g.core.model.User.petHandBookData
local HandBookProcessComp = class("HandBookProcessComp", require("app.fairyGUI.petHandBook.UI_PetHandBookProcessComp"))

function HandBookProcessComp:ctor()
	self._achieveShow = false
	self._totalScore = 0
	self._curScore = nil
end

function HandBookProcessComp:update()
	self._totalScore = var_0_0:getMaxPetNum()
	self._curScore = var_0_0:getActivatedNum()

	self.m_ownNumTxt:setText(self._curScore)
	self.m_maxNumTxt:setText("/" .. self._totalScore)
	self.m_bookProcess:setMax(self._totalScore)
	self.m_bookProcess:setValue(self._curScore)
end

return HandBookProcessComp
