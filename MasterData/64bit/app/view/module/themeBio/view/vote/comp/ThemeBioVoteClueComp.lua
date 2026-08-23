local var_0_0 = g.core.model.User.bagData
local var_0_1 = g.core.common.Goods
local ThemeBioVoteClueComp = class("ThemeBioVoteClueComp", require("app.fairyGUI.themeBio.UI_ThemeBioVoteClueComp"))

function ThemeBioVoteClueComp:ctor()
	self._info = nil

	self.m_lockController:setSelectedIndex(0)
	self:addClickListener(handler(self, self._onClickClue))
end

function ThemeBioVoteClueComp:updateClue(arg_2_1, arg_2_2)
	if arg_2_1 then
		self._info = arg_2_1
	end

	if arg_2_2 then
		self._themeValue = arg_2_2
	end

	self:_updateClueComp()
end

function ThemeBioVoteClueComp:onLoad()
	self.m_redPointComp:setId(416)
end

function ThemeBioVoteClueComp:_updateClueComp()
	if not self._info then
		self.m_lockController:setSelectedIndex(0)

		return
	end

	self.m_lockController:setSelectedIndex(var_0_0:isOwnItem(var_0_1.TYPE_THEME_BIO_ITEM, self._info.id) and 1 or 0)
	self:setTitle(self._info.name)
	self.m_iconShow:setURL((g.core.common.Path:getMiddleItemIconById(self._info.icon)))
	self.m_iconMask:setURL((g.core.common.Path:getBioDarkItemIcon(self._info.icon)))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			themeValue = self._themeValue,
			itemId = self._info.id
		}
	})
end

function ThemeBioVoteClueComp:playClueUnlockEffect()
	self.m_effLock:addEffectSpine({
		name = "eff_ui_themeBioVote_clueLock",
		anim = "animation",
		remove = true,
		isLoop = false
	})
end

function ThemeBioVoteClueComp:onUnload()
	return
end

function ThemeBioVoteClueComp:_onClickClue()
	if not self._info then
		g.core.module.ModuleManager:tip(g.core.lang:get(409151))

		return
	end

	if var_0_0:isOwnItem(var_0_1.TYPE_THEME_BIO_ITEM, self._info.id) then
		self:dispatchCompEvent("ThemeBioVoteClueComp_onClickClue", {
			info = self._info
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(409151))
	end
end

function ThemeBioVoteClueComp:refreshRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			themeValue = self._themeValue,
			itemId = self._info.id
		}
	})
end

return ThemeBioVoteClueComp
