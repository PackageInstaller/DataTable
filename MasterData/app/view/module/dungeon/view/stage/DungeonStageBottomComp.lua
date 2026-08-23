local DungeonStageBottomComp = class("DungeonStageBottomComp", require("app.fairyGUI.dungeon.UI_DungeonStageBottomComp"))
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.model.User.dungeonData

function DungeonStageBottomComp:ctor()
	self._stageNum = 0
	self._chapterId = 0
	self._chapterInfo = nil

	self.m_rankBtn:addClickListener(handler(self, self._onStarRankClick))
	self.m_registBtn:addClickListener(handler(self, self._onClickPreRegistBtn))
	self.m_youngBtn:addClickListener(handler(self, self._onClickYoungBtn))
	self.m_edenGardenBtn:addClickListener(handler(self, self._onClickEdenGardenBtn))
	self.m_achievementBtn:addClickListener(handler(self, self._onClickAchievementBtn))
	self.m_normalSkipFight:addClickListener(handler(self, self._onClickNormalSkipFight))
	self.m_autoChallengeBtn:addClickListener(handler(self, self._onAutoChallenge))
	self.m_autoChallengeBtn:getChild("eff"):addEffectSpine({
		anim = "play",
		name = "eff_ui_dungeon_autobtn",
		isLoop = true
	})
	self.m_previewList:setIniter()
	self.m_previewList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_eff:addEffectSpine({
		isLoop = true,
		name = "eff_ui_dungeon_checklight"
	})
end

function DungeonStageBottomComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DUNGEON_CHALLENGESTAGEFINISH, handler(self, self.checkAutoBtn), self)
	self:checkAutoBtn()
end

function DungeonStageBottomComp:checkAutoBtn()
	self.m_autoChallengeBtn:setVisible(not var_0_2:isAllPassed() and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DUNGEON_AUTO_CHALLENGE))

	if self.m_autoChallengeBtn:isVisible() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
			tickType = 6,
			enum = g.core.const.ConstMgr.GuideConst.ENUM_TICK.Dungeon_AUTO_GUIDE
		})
	end
end

function DungeonStageBottomComp:updateChestInfo(arg_4_1)
	self._chapterInfo = arg_4_1
	self._chapterId = arg_4_1.id

	self.m_progChestComp:update(arg_4_1)

	self._stageList = var_0_2:getStageIds(self._chapterId)
	self._stageNum = #self._stageList

	self.m_previewList:setNumItems(self._stageNum)
	self.m_registBtn:updateRegistBtn()

	local var_4_0 = var_0_2:getLastPassedChapter()

	self.m_youngBtn:setVisible(var_0_2:isShowYoungGift())
	self.m_youngBtn:setTitle(var_4_0 .. "/" .. g.core.config.achievement_info.get(10029).num)
	self.m_edenGardenBtn:setVisible(var_0_2:isShowEdenGarden())
	self.m_edenGardenBtn:setTitle(var_4_0 .. "/" .. g.core.config.achievement_info.get(10030).num)
	self:updateAchieveBtn()

	local var_4_1 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DUNGEON_SKIP_FIGHT)

	self.m_normalSkipFight:setVisible(var_4_1)
	self.m_skipTxt:setVisible(var_4_1)
	self.m_normalSkipFight:setSelected((var_0_2:getNormalSkipFight()))
	self:_updateSkipBattleEff()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_achievementBtn
	})
end

function DungeonStageBottomComp:updateAchieveBtn()
	local var_5_0 = g.core.model.User.dungeonData:isShowAchievePop()

	self.m_achievementBtn:setVisible(var_5_0)

	if var_5_0 then
		self.m_achievementBtn:setTitle(g.core.model.User.dungeonData:getTotalStars() .. "/" .. g.core.model.User.dungeonData:getNearestStarNum())
	end

	local var_5_1 = g.core.model.User.dungeonData:canReceiveStarAward()

	if var_5_1 and not self._achieveGetEffect then
		self._achieveGetEffect = self.m_achievementBtn:getChild("effectHolder"):addEffectSpine({
			isLoop = true,
			name = "eff_ui_dungeon_achievementBtn"
		})
	elseif self._achieveGetEffect then
		self._achieveGetEffect:setVisible(var_5_1)
	end
end

function DungeonStageBottomComp:_onItemRenderer(arg_6_1, arg_6_2)
	local var_6_0

	if self._stageNum == arg_6_1 + 1 then
		arg_6_2:setCtrlState("isFinish", {
			index = 1
		})

		var_6_0 = var_0_2:getLastUnlockStageId()
	end

	if self._chapterId == var_0_2:getLastUnlockChapter() then
		if var_6_0 > 0 and var_6_0 == self._stageList[arg_6_1 + 1] then
			arg_6_2:setCtrlState("isCur", {
				index = 1
			})
		else
			arg_6_2:setCtrlState("isCur", {
				index = 0
			})
		end
	end

	arg_6_2:updateView(self._stageList[arg_6_1 + 1])
end

function DungeonStageBottomComp:_onStarRankClick()
	var_0_1:pushModule(g.view.entrance.DUNGEON_STAR_RANK)
end

function DungeonStageBottomComp:_onClickPreRegistBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.dungeon.view.DungeonPreRegistrationPop").new()))
end

function DungeonStageBottomComp:_onClickYoungBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.dungeon.view.DungeonYoungLinkPop").new()))
end

function DungeonStageBottomComp:_onClickEdenGardenBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.dungeon.view.DungeonEdenGardenPop").new()))
end

function DungeonStageBottomComp:_onClickAchievementBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.dungeon.view.achievement.DungeonAchievementPop").new()))
end

function DungeonStageBottomComp:_onClickNormalSkipFight()
	var_0_2:setNormalSkipFight((self.m_normalSkipFight:isSelected()))
	self:_updateSkipBattleEff()
end

function DungeonStageBottomComp:_updateSkipBattleEff()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DUNGEON_SKIP_FIGHT) then
		self.m_eff:setVisible(not var_0_2:isCanAutoFightByStageId())
	else
		self.m_eff:setVisible(false)
	end
end

function DungeonStageBottomComp:_onAutoChallenge()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(2807),
		desc = g.core.lang:get(2806),
		onConfirm = handler(self, self.onStartAutoAction)
	}), {
		touchDisappear = true
	})
end

function DungeonStageBottomComp:onStartAutoAction()
	self.m_autoChallengeBtn:getChild("eff"):removeAllEffect()
	fgui.UIPackage:addPackage("ui/infoPop/infoPop")

	local var_15_0 = fgui.UIPackage:createObject("dungeon", "DungeonAutoRunComp")

	var_15_0:setPosition(display.width / 2 + display.cx, display.height)
	g.core.layer.LayerManager:getGuideTopLayer():addChild(var_15_0)
end

return DungeonStageBottomComp
