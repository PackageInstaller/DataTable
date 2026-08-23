local AncientsAgainVsComp = class("AncientsAgainVsComp", require("app.fairyGUI.ancients.UI_AncientsAgainVsComp"))

function AncientsAgainVsComp:ctor()
	self._data = nil

	self:_initView()
end

function AncientsAgainVsComp:_initView()
	self.m_effDi:removeAllEffect()
	self.m_effDi:addEffectSpine({
		name = "eff_ui_ancients_vslight",
		isLoop = true
	})
end

function AncientsAgainVsComp:updateView()
	return
end

return AncientsAgainVsComp
