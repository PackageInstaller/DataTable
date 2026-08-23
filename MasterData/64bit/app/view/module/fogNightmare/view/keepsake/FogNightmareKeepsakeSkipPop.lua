local FogNightmareKeepsakeSkipPop = class("FogNightmareKeepsakeSkipPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareKeepsakeSkipPop"), function()
	return fgui.GComponent:create({
		pkgName = "fogNightmare",
		isFullScreen = true,
		pkgPath = "ui/fogNightmare/fogNightmare",
		resName = "FogNightmareKeepsakeSkipPop"
	}, ...)
end)
local var_0_1 = g.core.model.User.fogNightmareData

function FogNightmareKeepsakeSkipPop:ctor()
	self.m_cancelBtn:addClickListener(handler(self, self._onCancel))
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirm))
	self.m_checkBtn:addClickListener(handler(self, self._onCheckBtnClick))
	self.m_checkBtn:setSelected(var_0_1:getKeepsakeData():getIsSelectSkipPop())
end

function FogNightmareKeepsakeSkipPop:_onCheckBtnClick()
	var_0_1:getKeepsakeData():setIsSelectSkipPop((self.m_checkBtn:isSelected()))
end

function FogNightmareKeepsakeSkipPop:_onCancel()
	g.core.module.ModuleManager:popComponent()
end

function FogNightmareKeepsakeSkipPop:_onConfirm()
	return
end

return FogNightmareKeepsakeSkipPop
