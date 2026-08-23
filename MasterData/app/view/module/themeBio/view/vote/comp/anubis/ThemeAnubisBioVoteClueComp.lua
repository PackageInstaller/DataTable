local var_0_0 = g.core.model.User.bagData
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.module.ModuleManager
local ThemeAnubisBioVoteClueComp = class("ThemeAnubisBioVoteClueComp", require("app.fairyGUI.themeBio.UI_ThemeAnubisBioVoteClueComp"))

function ThemeAnubisBioVoteClueComp:ctor()
	self._info = nil

	self.m_lockController:setSelectedIndex(0)
	self:addClickListener(handler(self, self._onClickClue))
end

function ThemeAnubisBioVoteClueComp:updateClue(arg_2_1, arg_2_2)
	if arg_2_1 then
		self._info = arg_2_1
	end

	if arg_2_2 then
		self._themeValue = arg_2_2
	end

	self:_updateClueComp()
end

function ThemeAnubisBioVoteClueComp:onLoad()
	self.m_redPointComp:setId(416)
end

function ThemeAnubisBioVoteClueComp:_updateClueComp()
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

function ThemeAnubisBioVoteClueComp:playClueUnlockEffect(arg_5_1)
	local var_5_0 = (arg_5_1 + 1) % 5

	if (arg_5_1 + 1) % 5 == 0 then
		var_5_0 = 5
	end

	self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		self.m_iconMask:setVisible(true)
	end), cc.CallFunc:create(function()
		self.m_effLock:addEffectSpine({
			anim = "play",
			remove = true,
			isLoop = false,
			name = "eff_ui_themeBio_clue" .. var_5_0
		})
	end), cc.CallFunc:create(function()
		self.m_iconMask:setVisible(false)
	end)))
end

function ThemeAnubisBioVoteClueComp:_onClickClue()
	if not self._info then
		var_0_2:tip(g.core.lang:get(409151))

		return
	end

	if var_0_0:isOwnItem(var_0_1.TYPE_THEME_BIO_ITEM, self._info.id) then
		self._themeBioData = g.core.model.User.themeData:getThemeData(21):getThemeBioData()

		if self._themeBioData:judgeBioChapterRecordByType(self._info.id, "_NEW_ITEM") then
			self._themeBioData:setBioChapterRecordByType(self._info.id, "_NEW_ITEM")
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = self.m_redPointComp
			})
			self:dispatchCompEvent("refresh_tab_red_point")
		end

		self:_onClueShowPop()
	else
		var_0_2:tip(g.core.lang:get(409151))
	end
end

function ThemeAnubisBioVoteClueComp:_onClueShowPop()
	var_0_2:pushPopup(require("app.view.module.themeBio.view.vote.pop.anubis.ThemeAnubisBioVoteClueDetailPop").new({
		info = self._info
	}), {
		withoutAni = false,
		hideContinue = false,
		touchDisappear = true
	})
end

function ThemeAnubisBioVoteClueComp:refreshRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			themeValue = self._themeValue,
			itemId = self._info.id
		}
	})
end

return ThemeAnubisBioVoteClueComp
