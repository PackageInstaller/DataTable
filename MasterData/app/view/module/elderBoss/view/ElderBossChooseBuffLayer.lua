local CommonKnight = require("app.view.common.CommonKnight")
local var_0_1 = g.core.const.ConstMgr.ElderBossConst
local var_0_2 = g.core.model.User.elderBossData
local ElderBossChooseBuffLayer = class("ElderBossChooseBuffLayer", require("app.fairyGUI.elderBoss.UI_ElderBossChooseBuffLayer"), function()
	return fgui.GComponent:create({
		resName = "ElderBossChooseBuffLayer",
		pkgPath = "ui/elderBoss/elderBoss",
		isFullScreen = true,
		pkgName = "elderBoss"
	}, ...)
end)

function ElderBossChooseBuffLayer:ctor()
	self.m_bgLoader:setURL("bg/elderBoss/bg_ljqs_main.jpg")
	self:_initBtn()
	self:_initView()
end

function ElderBossChooseBuffLayer:_initBtn()
	self.m_serverListTouchArea:addClickListener(handler(self, self._onServerCompClick))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRankBtn))
end

function ElderBossChooseBuffLayer:_initView()
	self.m_topBarComp:setResInfoById(var_0_1.CHOOSE_BUFF_STAGE_TOP_ID)
	self.m_enterTransition:play()
	self.m_enterTransition:setHook("show1", handler(self, self._onPlayShow1))
	self.m_enterTransition:setHook("show2", handler(self, self._onPlayShow2))
	self.m_enterTransition:setHook("show3", handler(self, self._onPlayShow3))
	self.m_enterTransition:setHook("show4", handler(self, self._onPlayShow4))
	self.m_enterTransition:setHook("show5", handler(self, self._onPlayShow5))
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ELDER_BOSS)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_CRITICALDECAY)
end

function ElderBossChooseBuffLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_ENTER, handler(self, self._onS2CElderBossEnter), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_CHOOSEBUFF, handler(self, self._onS2CElderBossChooseBuff), self)
	g.core.network.GameNetProxy:send_C2S_ElderBoss_Enter({})

	if #var_0_2:getGameServerList() <= 0 then
		g.core.network.GameNetProxy:send_C2S_ElderBoss_ServerInfos({})
	end
end

function ElderBossChooseBuffLayer:_onS2CElderBossEnter()
	local var_6_0 = var_0_2:getBossId()

	if var_6_0 > 0 then
		local var_6_1 = g.core.config.elder_boss_info.get(var_6_0)

		self.m_bossDescComp:updateDescComp(var_6_1)
		self.m_openTimeTxt:setText(g.core.lang:get(432518))

		local var_6_2 = var_0_2:getMonsterInfoByTeamId(var_6_1.monster_team_id)

		if var_6_2 and not self._bossSpine then
			self._bossSpine = CommonKnight.new({
				resId = var_6_2.res_id
			})

			self._bossSpine:setFlip(false)
			self.m_bossPlace:addChild(self._bossSpine)
		end

		for iter_6_0, iter_6_1 in g.core.config.elder_boss_buff_info.ipairs() do
			if self["m_group" .. iter_6_0] then
				self["m_group" .. iter_6_0]:updateGroupInfo(iter_6_1)
			end
		end
	end
end

function ElderBossChooseBuffLayer:_onS2CElderBossChooseBuff()
	local var_7_0 = g.view.entrance.ELDERBOSS_MAIN_LAYER

	if var_0_2:getCurStage() == var_0_1.STAGE.SHOW_RESULT then
		var_7_0 = g.view.entrance.ELDERBOSS_RESULT_LAYER
	end

	self:newScheduleOnce(function()
		g.core.module.ModuleManager:replaceModuleRoot(var_7_0)
	end, 0)
end

function ElderBossChooseBuffLayer:_onPlayShow1()
	self.m_group1:playShowTransition(1)
end

function ElderBossChooseBuffLayer:_onPlayShow2()
	self.m_group2:playShowTransition(2)
end

function ElderBossChooseBuffLayer:_onPlayShow3()
	self.m_group3:playShowTransition(3)
end

function ElderBossChooseBuffLayer:_onPlayShow4()
	self.m_group4:playShowTransition(4)
end

function ElderBossChooseBuffLayer:_onPlayShow5()
	self.m_group5:playShowTransition(5)
end

function ElderBossChooseBuffLayer:_onServerCompClick()
	g.core.common.GlobalFunc.pushMatchServerPop({
		serverInfo = var_0_2:getGameServerList()
	})
end

function ElderBossChooseBuffLayer:_onClickRankBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ELDERBOSS_RANK_LAYER)
end

return ElderBossChooseBuffLayer
