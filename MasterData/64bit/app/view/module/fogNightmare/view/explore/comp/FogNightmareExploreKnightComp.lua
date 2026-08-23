local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.fogNightmareData
local var_0_2 = g.core.const.ConstMgr.FogNightmareConst
local PressComp = require("app.view.module.recruit.view.comp.PressComp")
local FogNightmareExploreKnightComp = class("FogNightmareExploreKnightComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreKnightComp"))

function FogNightmareExploreKnightComp:ctor()
	self._isFormation = false
	self._knightStrcut = nil
	self._isTouchd = false

	self.m_knightClickNode:addClickListener(handler(self, self._onAddBtnClicked))
	self.m_knightLoader:addClickListener(handler(self, self._onAddBtnClicked), 1)
	self.m_keepsakeLoader:addClickListener(handler(self, self._onKeepsakeClicked))
	self.m_hpBar:setMax(100)
	self.m_starGroupComp:initStar({
		gap = -10,
		index = 3,
		num = 0
	})
end

function FogNightmareExploreKnightComp:updateComp(arg_2_1, arg_2_2, arg_2_3)
	self._isFormation = arg_2_3 == true
	self._knightStrcut = arg_2_1
	self._pos = arg_2_2

	if not self._knightStrcut then
		self:_updateEmptyComp()
		self.m_starGroupComp:initStar({
			gap = -10,
			index = 3,
			num = 0
		})

		return
	end

	self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(self._knightStrcut:getBaseInfo().classical))
	self.m_leaderLoader:setVisible(self._knightStrcut:getBaseInfo().is_element_leader > 0)
	self.m_leftQualityLoader:setURL(var_0_0:getMulTeamLeftVerticalQualityBarURL((self._knightStrcut:getQuality())))
	self.m_knightLoader:setURL(var_0_0:getKnightIconById(self._knightStrcut:getResInfo().painted_id))
	self.m_starGroupComp:initStar({
		gap = -10,
		index = 3,
		num = self._knightStrcut:getStarLv()
	})
	self.m_hpBar:setValue((self._knightStrcut:getHpPercent()))
	self.m_hasKnightController:setSelectedIndex(1)

	local var_2_0 = arg_2_1:getDevelopStruct(var_0_2.KNIGHT_DEVELOP_KEY.KEEPSAKE)

	if var_2_0 then
		self.m_hasSealController:setSelectedIndex(1)
		self.m_keepsakeLoader:setURL(var_0_0:getFogNightmareKeepsakePicRes(var_2_0:getBaseInfo().seal_icon))
		self.m_levelText:setText(var_2_0:getCfg().level)
	else
		self.m_hasSealController:setSelectedIndex(0)
	end
end

function FogNightmareExploreKnightComp:updateKnightState()
	if not self._knightStrcut then
		return
	end

	if self._knightStrcut:getKnightState() == g.core.const.ConstMgr.KNIGHT_CONST.SPECIAL_KNIGHT_STATE.DEFEATED then
		self.m_stateController:setSelectedIndex(2)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function FogNightmareExploreKnightComp:_updateEmptyComp()
	self.m_hasKnightController:setSelectedIndex(0)
	self.m_leftQualityLoader:setURL(var_0_0:getMulTeamLeftVerticalQualityBarURL(0))
	self.m_leaderLoader:setVisible(false)
end

function FogNightmareExploreKnightComp:_onAddBtnClicked()
	if not self._isFormation then
		if var_0_1:getFormationData():hasPoolMember() and self._knightStrcut then
			g.core.module.ModuleManager:tip(g.core.lang:get(500168))

			return
		end
	end

	if self._isTouchd then
		return
	end

	self:dispatchCompEvent("clickAddKnight", {
		pos = self._pos
	})

	if config.DEBUG_VERSION and require("app.view.module.debug.common.DebugCommon").getDebugGlobalValueByKey("fight_value_dump") then
		dump(var_0_1:getFormationData():debugGetKnightFightValue(self._knightStrcut:getServerId()), nil, nil, false, true)
	end
end

function FogNightmareExploreKnightComp:addKnightPress()
	if self._addPress then
		return
	end

	self._addPress = true

	self.m_knightLoader:removeClickListener(1)
	PressComp.bindComp(self.m_knightLoader)
	self.m_knightLoader:addPressListener(handler(self, self._onKnightInfoPress))
	self.m_knightLoader:setClickListener(handler(self, self._onAddBtnClicked))
end

function FogNightmareExploreKnightComp:_onKnightInfoPress()
	if self._knightStrcut then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
			knightAdvId = self._knightStrcut:getAdvanceId()
		}), {
			touchDisappear = true,
			hideContinue = true
		})
		self.m_knightLoader:clearSchedule()
	end
end

function FogNightmareExploreKnightComp:showMoveBg(arg_8_1)
	self.m_moveBg:setVisible(arg_8_1 == true)
end

function FogNightmareExploreKnightComp:setTouch(arg_9_1)
	self._isTouchd = arg_9_1 == true
end

function FogNightmareExploreKnightComp:_onKeepsakeClicked()
	self:dispatchCompEvent("onClickedKeepsake", {
		pos = self._pos
	})
end

return FogNightmareExploreKnightComp
