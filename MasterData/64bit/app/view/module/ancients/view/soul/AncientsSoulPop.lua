local AncientsSoulPop = class("AncientsSoulPop", require("app.fairyGUI.ancients.UI_AncientsSoulPop"), function()
	return fgui.GComponent:create({
		pkgName = "ancients",
		resName = "AncientsSoulPop",
		pkgPath = "ui/ancients/ancients"
	}, ...)
end)
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = g.core.event.EventManager
local var_0_5 = g.core.event.enum

function AncientsSoulPop:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	self:getView():center(true)
	self.m_soul_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCtrlSoulTabChange))

	self._tabIndex = arg_2_1.index or var_0_2

	self:_dealTabIndex()
	self.m_soul_tabController:setSelectedIndex(self._tabIndex)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Slide)
end

function AncientsSoulPop:_onCtrlSoulTabChange()
	local var_3_0 = self.m_soul_tabController:getSelectedIndex()

	if var_3_0 == var_0_3 and not g.core.model.User.ancientsData:isEchoUnlock() then
		self._tabIndex = var_0_2

		self.m_soul_tabController:setSelectedIndex(self._tabIndex)

		local var_3_1 = g.core.model.User.ancientsData:getPetBaseId()

		g.core.module.ModuleManager:tip(g.core.lang:get(433403, {
			level = g.core.config.ancients_pet_level_info.match(function(arg_4_0)
				if arg_4_0.pet_id == var_3_1 and arg_4_0.echo_num == 1 then
					return arg_4_0
				end
			end)[1].level
		}))

		return
	end

	if self._tabIndex == var_3_0 then
		return
	end

	self._tabIndex = var_3_0

	self:_updateView()
end

function AncientsSoulPop:_updateEchoTab()
	self.m_Comp_tab2:setCtrlState("lock", {
		index = g.core.model.User.ancientsData:isEchoUnlock() and 0 or 1
	})
end

function AncientsSoulPop:_dealTabIndex()
	if not g.core.model.User.ancientsData:isEchoUnlock() then
		self._tabIndex = var_0_2
	end
end

function AncientsSoulPop:onLoad()
	self:_updateView()
	var_0_4:dispatchEvent(var_0_5.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_Comp_tab1
	})
	var_0_4:addEventListener(var_0_5.EVENT_CROSS_DAY_NOTIFY, handler(self, self._updateView), self)
end

function AncientsSoulPop:receiveCompEvent(arg_8_1, arg_8_2)
	return
end

function AncientsSoulPop:_updateView()
	self:_updateEchoTab()

	if self._tabIndex == var_0_2 then
		self.m_Comp_dev:updateView()
	else
		self.m_Comp_echo:updateView()
	end
end

return AncientsSoulPop
