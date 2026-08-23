local var_0_0 = g.core.model.User.domainData
local DomainChooseDungeonLayer = class("DomainChooseDungeonLayer", require("app.fairyGUI.domainDungeon.UI_DomainChooseDungeonLayer"), function()
	return fgui.GComponent:create({
		resName = "DomainChooseDungeonLayer",
		pkgName = "domainDungeon",
		isFullScreen = true,
		pkgPath = "ui/domainDungeon/domainDungeon"
	}, ...)
end)

function DomainChooseDungeonLayer:ctor()
	self:addBg("bg/domain/bg_mnly_dtxgbg.jpg")
	self.m_dungeonList:setVirtual()
	self.m_dungeonList:setScrollLimit(true)
	self.m_dungeonList:doFairyBatching(false)
	self.m_dungeonList:setItemRenderer(handler(self, self._onDungeonItemRender))
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.DOMAIN)
	self.m_enterTransition:play()
end

function DomainChooseDungeonLayer:_onDungeonItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateDungeon(self._dungeonData[arg_3_1 + 1])
end

function DomainChooseDungeonLayer:onLoad()
	self:updateMainView()
end

function DomainChooseDungeonLayer:updateMainView()
	self._dungeonData = var_0_0:getDungeonList()

	self.m_dungeonList:setNumItems(#self._dungeonData)
	self.m_dungeonList:transitionShowCells("enter_right", 0.03, 1)
	self.m_bgEff:removeAllEffect()
	self.m_bgEff:addEffectSpine({
		name = "eff_ui_domainDungeon_bgglow",
		isLoop = true
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SimulationField)
	self:_checkGuide()
end

function DomainChooseDungeonLayer:_checkGuide()
	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.DOMAIN_CHOOSE_TICK_GUIDE_ID) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
			tickType = 6,
			enum = g.core.const.ConstMgr.GuideConst.ENUM_TICK.DOMAIN_GUIDE
		})
		g.core.model.User.guideData:setGuideTickedFinish(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.DOMAIN_CHOOSE_TICK_GUIDE_ID)
	end
end

return DomainChooseDungeonLayer
