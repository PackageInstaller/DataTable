local FogNightmareMonsterWaveComp = class("FogNightmareMonsterWaveComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareMonsterWaveComp"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareMonsterWaveComp",
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = false,
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightmareMonsterWaveComp:ctor()
	self._effectStruct = nil
	self._monsters = {}
	self._uniteTokens = {}
	self._waveCount = 0

	self.m_monsterList:setVirtual(self)
	self.m_monsterList:doFairyBatching(false)
	self.m_monsterList:setItemRenderer(handler(self, self._onMonsterItemRender))
	self.m_uniteTokenList:setVirtual(self)
	self.m_uniteTokenList:setItemRenderer(handler(self, self._onUniteTokenItemRender))
end

function FogNightmareMonsterWaveComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.FOG_NIGHTMARE_BATTLE_RESULT_EXIT, self._onFogBattleResultExit, self)
end

function FogNightmareMonsterWaveComp:_onMonsterItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateComp(self._monsters[arg_4_1 + 1])
end

function FogNightmareMonsterWaveComp:_onUniteTokenItemRender(arg_5_1, arg_5_2)
	arg_5_2:setScale(0.8)
	arg_5_2:setRollEnable(false)
	arg_5_2:setClickShowInfoPopEnable(true)
	arg_5_2:updateBtn(self._uniteTokens[arg_5_1 + 1], true)
end

function FogNightmareMonsterWaveComp:updateComp(arg_6_1, arg_6_2, arg_6_3)
	self._effectStruct = arg_6_1
	self._waveCount = arg_6_2
	self._monsters = arg_6_1:getAllMonsters()
	self._uniteTokens = arg_6_1:getALLUniteTokens()

	self.m_monsterList:setNumItems(#self._monsters)

	if arg_6_3 == nil or arg_6_3 then
		self.m_monsterList:transitionShowCells("listIconUiLeftIn", 0.03)
	end

	self.m_fightText:setText(g.core.lang:get(405712, {
		num = arg_6_1:getPower()
	}))
	self.m_uniteTokenList:setNumItems(#self._uniteTokens)
	self.m_showUniteTokenController:setSelectedIndex(#self._uniteTokens > 0 and 1 or 0)
	self.m_showSkillComp:updateCompView(arg_6_1:getAllShowSkills())
end

function FogNightmareMonsterWaveComp:_doClickAction(arg_7_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareExploreFormationPop").new({
		floor = arg_7_1.floor:getFloorId(),
		stage = arg_7_1.stage:getStageId(),
		wave = arg_7_1.wave,
		tabNum = self._waveCount
	}), {
		blackOpacity = 0.7,
		ignoreTouch = false,
		touchDisappear = false
	})
end

function FogNightmareMonsterWaveComp:_onFogBattleResultExit()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FLOOR_STATE, false)
end

return FogNightmareMonsterWaveComp
