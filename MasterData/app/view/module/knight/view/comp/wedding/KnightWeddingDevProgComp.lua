local var_0_0 = g.core.model.User.weddingData
local KnightWeddingDevProgComp = class("KnightWeddingDevProgComp", require("app.fairyGUI.knight.UI_KnightWeddingDevProgComp"))

function KnightWeddingDevProgComp:ctor(arg_1_1)
	self._lastShowProgress = 0

	self.m_barPic:setMin(0)
end

function KnightWeddingDevProgComp:updateProgressComp(arg_2_1)
	self.m_rankText:setText(arg_2_1.level)

	if arg_2_1.next_id > 0 then
		local var_2_0 = var_0_0:getLevelMaxNodeCount(arg_2_1) - 1
		local var_2_1 = var_0_0:getCurLevelActiveCount(arg_2_1)

		self.m_barPic:setMax(var_2_0)

		local var_2_2 = var_2_1 / var_2_0

		if var_2_1 / var_2_0 > self._lastShowProgress then
			self.m_barPic:tweenValue(var_2_1, 0.3)
		else
			self.m_barPic:setValue(var_2_1)
		end

		self._lastShowProgress = var_2_2
	else
		self.m_barPic:setValue(self.m_barPic:getMax())
	end
end

return KnightWeddingDevProgComp
