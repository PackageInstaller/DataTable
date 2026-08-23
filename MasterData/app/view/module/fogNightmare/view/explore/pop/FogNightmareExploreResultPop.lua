local FogNightmareExploreResultPop = class("FogNightmareExploreResultPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreResultPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareExploreResultPop",
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = false,
		pkgName = "fogNightmare"
	}, ...)
end)
local var_0_1 = {
	TALENT = 1,
	KNIGHT = 0
}

function FogNightmareExploreResultPop:ctor(arg_2_1)
	self._curTabIndex = var_0_1.KNIGHT
	self._curStage = arg_2_1.curStage or 0
	self._historyMaxStage = arg_2_1.historyMaxStage or 0
	self._addStage = self._curStage - self._historyMaxStage
	self._historyMaxStage = math.max(self._historyMaxStage, self._curStage)
	self._isWin = arg_2_1.isWin or false
	self._knightList = arg_2_1.knightList or {}
	self._talentList = arg_2_1.talentList or {}
	self._callback = arg_2_1.callback
	self._isNewHistory = self._addStage > 0
	self._winUpSpine = nil
	self._isPlayingEnter = true
	self._isPlayKnight = false
	self._isPlayTalent = false

	self:_initView()

	if self._isWin then
		self.m_winEnterTransition:play()
		self.m_winEnterTransition:setHook("play", handler(self, self._onEnterPlayHook))
		self.m_effDownTitle:addEffectSpine({
			anim = "play",
			name = "eff_ui_FogNightmare_resultDownTitle",
			isLoop = false
		})

		self._winUpSpine = self.m_effUpTitle:addEffectSpine({
			anim = "play",
			name = "eff_ui_FogNightmare_resultUpTitle",
			isLoop = false,
			eventHandler = handler(self, self._winUpEffect)
		})
	else
		self.m_failEnterTransition:play()
		self.m_failEnterTransition:setHook("play", handler(self, self._onEnterPlayHook))
		self.m_effDownTitle:addEffectSpine({
			anim = "play2",
			name = "eff_ui_FogNightmare_resultDownTitle",
			isLoop = false
		})
	end

	self.m_effbg:addEffectSpine({
		anim = "play",
		name = "eff_ui_FogNightmare_resultbg",
		isLoop = false
	})
	self.m_closeComp:addClickListener(handler(self, self._onClosePopClick))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_STAGE_RESULT_POP)
end

function FogNightmareExploreResultPop:_winUpEffect(arg_3_1)
	if arg_3_1.type == "complete" and self._winUpSpine and not tolua.isnull(self._winUpSpine) then
		self._winUpSpine:setAnimation(0, "play2", true)
	end
end

function FogNightmareExploreResultPop:_onEnterPlayHook()
	self._isPlayingEnter = false
	self._isPlay = true

	self:updateView()
end

function FogNightmareExploreResultPop:_onClosePopClick()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function FogNightmareExploreResultPop:_initView()
	self:showAtCenter()
	self.m_showListController:setSelectedIndex(self._curTabIndex)
	self.m_showListController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onShowListChanged))
	self.m_knightList:setVirtual()
	self.m_knightList:doFairyBatching(false)
	self.m_knightList:setItemRenderer(handler(self, self._onRendererKnightList))
	self.m_talentList:setVirtual()
	self.m_talentList:setItemRenderer(handler(self, self._onRendererTalentList))
	self.m_isWinController:setSelectedIndex(self._isWin and 1 or 0)
	self.m_historyMaxStageText:setText(g.core.lang:get(500148, {
		stage = self._historyMaxStage
	}))
	self.m_addStageText:setText(self._addStage)
	self.m_stageText:setText(self._curStage)
end

function FogNightmareExploreResultPop:_onRendererKnightList(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._knightList[arg_7_1 + 1], arg_7_1, not self._isPlayKnight)
end

function FogNightmareExploreResultPop:_onRendererTalentList(arg_8_1, arg_8_2)
	arg_8_2:updateCell(self._talentList[arg_8_1 + 1], not self._isPlayTalent)
end

function FogNightmareExploreResultPop:_onShowListChanged()
	local var_9_0 = self.m_showListController:getSelectedIndex()

	if var_9_0 == self._curTabIndex then
		return
	end

	self._curTabIndex = var_9_0

	self:updateView()
end

function FogNightmareExploreResultPop:onLoad()
	self:updateView()
end

function FogNightmareExploreResultPop:updateView()
	if self._isPlayingEnter then
		return
	end

	if self._curTabIndex == var_0_1.TALENT then
		self.m_isEmptyController:setSelectedIndex(#self._talentList == 0 and 1 or 0)
		self.m_talentList:setNumItems(#self._talentList)

		self._isPlayTalent = false
	elseif self._curTabIndex == var_0_1.KNIGHT then
		self.m_isEmptyController:setSelectedIndex(#self._knightList == 0 and 1 or 0)
		self.m_knightList:setNumItems(#self._knightList)

		self._isPlayKnight = true
	end
end

function FogNightmareExploreResultPop:onRemoved()
	if self._callback then
		self._callback()
	end
end

return FogNightmareExploreResultPop
