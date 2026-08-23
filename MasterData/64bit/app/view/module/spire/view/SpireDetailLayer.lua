local var_0_0 = g.core.const.ConstMgr.SpireConst
local var_0_1 = g.core.model.User.spireData
local SpireDetailLayer = class("SpireDetailLayer", require("app.fairyGUI.spire.UI_SpireDetailLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/spire/spire",
		resName = "SpireDetailLayer",
		pkgName = "spire"
	}, ...)
end)

function SpireDetailLayer:ctor(arg_2_1)
	self._upNum = 0
	self._awardList = {}
	self._towerInfo = arg_2_1

	self:_initView()
	self:_initBtn()
	self:_initListView()
end

function SpireDetailLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_GET, handler(self, self._enterChallengeLayer), self)
	self:updateView()
	self.m_enterTransition:play()
end

function SpireDetailLayer:_initBtn()
	self.m_helpBtn:addClickListener(handler(self, self._onHelpBtnClick))
	self.m_bossIcon:addClickListener(handler(self, self._onHelpBtnClick))
	self.m_fightBtn:addClickListener(handler(self, self._onFightBtnClick))
end

function SpireDetailLayer:_initListView()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_awardList2:setVirtual()
	self.m_awardList2:setItemRenderer(handler(self, self._onRenderAwardList))
end

function SpireDetailLayer:_onRenderAwardList(arg_6_1, arg_6_2)
	arg_6_2:getChild("itemComp"):updateIcon(self._awardList[arg_6_1 + 1])
	arg_6_2:getController("isUp"):setSelectedIndex(arg_6_1 < self._upNum and 1 or 0)
end

function SpireDetailLayer:_initView(arg_7_1)
	self:addBg("bg/spire/bg_shmc_guanqia.jpg")
	self.m_topBarComp:setResInfoById(var_0_0.MAIN_TOP_BAR_ID)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EvilCastle_01)
end

function SpireDetailLayer:updateView()
	if not self._towerInfo then
		return
	end

	local var_8_0 = self._towerInfo:getCfg()

	var_0_1:saveTowerOpenIndex(var_8_0.type)

	self._awardList = {}

	local var_8_1 = self._towerInfo:getPassFloorIdleAwards(true)
	local var_8_2 = self._towerInfo:getPassFloorPassAwards(true)

	self._upNum = 0

	local var_8_3 = {}

	for iter_8_0 = 1, #var_8_1 do
		if not var_8_3[var_8_1[iter_8_0].type .. "_" .. var_8_1[iter_8_0].value] then
			self._upNum = self._upNum + 1

			table.insert(self._awardList, var_8_1[iter_8_0])

			var_8_3[var_8_1[iter_8_0].type .. "_" .. var_8_1[iter_8_0].value] = true
		end
	end

	local var_8_4 = {}

	for iter_8_1 = 1, #var_8_2 do
		if not var_8_4[var_8_2[iter_8_1].type .. "_" .. var_8_2[iter_8_1].value] then
			table.insert(self._awardList, var_8_2[iter_8_1])

			var_8_4[var_8_2[iter_8_1].type .. "_" .. var_8_2[iter_8_1].value] = true
		end
	end

	self.m_nameText:setText(var_8_0.name)
	self.m_towerController:setSelectedIndex(var_8_0.type - 1)

	local var_8_5 = var_8_0.boss_id > 0

	if var_8_0.boss_id > 0 then
		self.m_awardList2:setNumItems(#self._awardList)
		self.m_descComp2:setTitle(var_8_0.tower_des)
		self.m_targetText2:setText(var_8_0.battle_des)

		local var_8_6 = self._towerInfo:getMaxFloor():getBossStage()

		self.m_bossNameText:setText(var_8_6:getCfg().name)
		self.m_bossIcon:setIcon(g.core.common.Path:getRoleHeadIcon((var_8_6:getShowSpineId())))
	else
		self.m_awardList:setNumItems(#self._awardList)
		self.m_descComp:setTitle(var_8_0.tower_des)
		self.m_targetText:setText(var_8_0.battle_des)
	end

	self.m_haveBossController:setSelectedIndex(var_8_5 and 1 or 0)
end

function SpireDetailLayer:_onHelpBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SPIRE_BOSS_DETAIL_POP, self._towerInfo:getMaxFloor():getBossStage())
end

function SpireDetailLayer:_onFightBtnClick()
	if not var_0_1:isActivityOpen() then
		g.core.module.ModuleManager:tip(g.core.lang:get(308618))

		return
	end

	if var_0_1:getCurStage() == var_0_0.STAGE.SHOW_RESULT then
		g.core.module.ModuleManager:tip(g.core.lang:get(432035))

		return
	end

	if self._towerInfo:isPass() then
		g.core.module.ModuleManager:tip(g.core.lang:get(432015))

		return
	end

	self:_onEnterChallengeLayer()
end

function SpireDetailLayer:_onEnterChallengeLayer()
	local var_11_0 = self._towerInfo:getMulFormationType()

	if not var_0_1:isReqFormation(var_11_0) then
		g.core.network.GameNetProxy:send_C2S_Formation_Get({
			tp = var_11_0
		})
	else
		self:_enterChallengeLayer()
	end
end

function SpireDetailLayer:_enterChallengeLayer()
	var_0_1:saveTowerEnterIndex(self._towerInfo:getCfg().type)
	var_0_1:formationRequested(self._towerInfo:getMulFormationType())

	local var_12_0 = self._towerInfo

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_ENTER_PLAY_TRANSITION, false, {
		toRight = false,
		callback = handler(self, function(arg_13_0)
			g.core.module.ModuleManager:pushModule(g.view.entrance.SPIRE_CHALLENGE_LAYER, var_12_0)
		end)
	})
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return SpireDetailLayer
