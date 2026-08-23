local var_0_0 = g.core.model.User.bagData
local var_0_1 = g.core.model.User.releaseActivityData
local ReleaseActivityDrawBtn = class("ReleaseActivityDrawBtn", require("app.fairyGUI.release.UI_ReleaseActivityDrawBtn"))

function ReleaseActivityDrawBtn:ctor()
	self:addClickListener(handler(self, self._onClick))
end

function ReleaseActivityDrawBtn:updateBtn(arg_2_1)
	self._time = arg_2_1

	local var_2_0 = var_0_1:getReleaseInfo()

	self.m_isEnoughController:setSelectedIndex(checkbool(var_2_0.open_size * self._time <= var_0_0:getOwnNum(var_2_0.open_type, var_2_0.open_value)) and 1 or 0)

	local var_2_1 = g.core.common.Goods:convert({
		type = var_2_0.open_type,
		value = var_2_0.open_value
	})

	if var_2_1 then
		self.m_costImg:setURL(var_2_1.icon)
		self.m_numTxt:setText(g.core.lang:get(107073, {
			num = var_2_0.open_size * self._time
		}))
	end
end

function ReleaseActivityDrawBtn:_onClick()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Gear_Turn)

	local var_3_0 = var_0_1:getReleaseInfo()
	local var_3_1 = var_0_0:getOwnNum(var_3_0.open_type, var_3_0.open_value)

	if var_3_1 < var_3_0.open_size * self._time then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_3_0.open_type,
			value = var_3_0.open_value,
			curSize = var_3_1,
			needSize = var_3_0.open_size * self._time - var_3_1
		})

		return
	end

	g.core.network.GameNetProxy:send_C2S_Release_Draw({
		times = self._time
	})
end

return ReleaseActivityDrawBtn
