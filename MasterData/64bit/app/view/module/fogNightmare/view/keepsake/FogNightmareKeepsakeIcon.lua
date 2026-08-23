local FogNightmareKeepsakeIcon = class("FogNightmareKeepsakeIcon", require("app.fairyGUI.fogNightmare.UI_FogNightmareKeepsakeIcon"))
local FogNightmareKeepsakeStruct = require("app.view.module.fogNightmare.model.struct.FogNightmareKeepsakeStruct")
local var_0_2 = g.core.config.fog_seal_info
local var_0_3 = g.core.config.fog_seal_level_info
local var_0_4 = g.core.model.User.fogNightmareData

function FogNightmareKeepsakeIcon:ctor()
	self._struct = nil
	self._isBook = false
	self._isCanClick = true
	self._lv = 1

	self:addEventListener(fgui.UIEventType.Click, handler(self, self._onShowKeepsakePop))
end

function FogNightmareKeepsakeIcon:updateIconBySealId(arg_2_1, arg_2_2)
	self._isBook = arg_2_2
	self._cfg = var_0_2.get(arg_2_1)

	self:_updateIcon()

	if arg_2_2 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				seal_id = arg_2_1
			}
		})
	end
end

function FogNightmareKeepsakeIcon:updateIconById(arg_3_1)
	self._cfg = var_0_2.get(var_0_3.get(arg_3_1).seal_id)

	self:_updateIcon()
end

function FogNightmareKeepsakeIcon:_updateIcon()
	self.m_keepsakeIcon:setURL(g.core.common.Path:getFogNightmareKeepsakePicRes(self._cfg.seal_icon))
	self.m_qualityController:setSelectedIndex(self._cfg.type - 1)
end

function FogNightmareKeepsakeIcon:updateIconLv(arg_5_1)
	if arg_5_1 then
		self._lv = arg_5_1

		self.m_levelText:setText("Lv." .. arg_5_1)
		self.m_showLvController:setSelectedIndex(1)
	end
end

function FogNightmareKeepsakeIcon:setSealLv(arg_6_1)
	self._lv = arg_6_1
end

function FogNightmareKeepsakeIcon:setIconClickEnable(arg_7_1)
	self._isCanClick = arg_7_1 == true
end

function FogNightmareKeepsakeIcon:_onShowKeepsakePop()
	if not self._isCanClick then
		return
	end

	if self._isBook then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.keepsake.FogNightmareKeepsakeBookInfoPop").new({
			cfg = self._cfg
		}), {
			touchDisappear = true,
			ignoreTouch = false
		})
	else
		g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareKnightKeepsakeInfoPop").new(var_0_4:getKeepsakeData():getKeepsakeStructsByTypeAndId(self._cfg.type, self._cfg.seal_id)[self._lv], true), {
			touchDisappear = true,
			hideContinue = false,
			ignoreTouch = false
		})
	end
end

return FogNightmareKeepsakeIcon
