local var_0_0 = g.core.model.User.guildWarData
local var_0_1 = g.core.model.User.resourceData
local var_0_2 = 4001
local var_0_3 = 4002
local var_0_4 = g.core.const.ConstMgr.BasicFigureConst
local GuildWarBuildPop = class("GuildWarBuildPop", require("app.fairyGUI.guildWar.UI_GuildWarBuildPop"), function()
	return fgui.GComponent:create({
		resName = "GuildWarBuildPop",
		pkgPath = "ui/guildWar/guildWar",
		pkgName = "guildWar"
	}, ...)
end)

function GuildWarBuildPop:ctor(arg_2_1)
	self:showAtCenter()

	self._userList = {}
	self._descTb = {}
	self._buildId = arg_2_1.buildId
	self.isFirstEnter = true
	self._maxPlayTimes = g.core.config.basic_figure_info.get(var_0_4.GUILD_WAR).time_limit
	self._buildData = var_0_0:getBuildDataById(self._buildId)
	self._cfg = self._buildData:getCfg()

	self.m_enemyList:setVirtual()
	self.m_enemyList:setItemRenderer(handler(self, self._onEnemyRenderer))
	self.m_enemyList:doFairyBatching(false)
	self.m_addBtn:addClickListener(handler(self, self.onBuyPlayTimes))
	self:initView()
end

function GuildWarBuildPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_ATTACKDEFENDERBEGIN, handler(self, self._onRcvBattleBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RECOVER_STEP, self.updatePlayTimes, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RECOVER_NOTIFY, self.updatePlayTimes, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_FORCE_FRESH, self.updatePlayTimes, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RFRESH_RESOURCE, self.updatePlayTimes, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_GETFORMATION, handler(self, self._onGetFormation), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_NOTIFY, handler(self, self._onRevNotify), self)
	self:updatePlayTimes()
	self:updateView()
end

function GuildWarBuildPop:initView()
	local var_4_0 = g.core.config.guild_war_parameter_info.get(var_0_2).parameter

	self._descTb = {
		[0] = {
			{
				id = 308643,
				value = var_4_0 .. "-" .. g.core.config.guild_war_parameter_info.get(var_0_3).parameter + var_4_0
			},
			{
				id = 308644,
				value = self._cfg.people_basic_score .. "-" .. self._cfg.people_basic_score + self._cfg.people_extra_score
			}
		},
		{
			{
				id = 308645,
				value = self._cfg.attack_score
			}
		}
	}
end

function GuildWarBuildPop:_onRcvBattleBegin(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		soundType = 5,
		battle_id = arg_5_4.battle_id,
		type = BattleConst.TYPE_GUILDWAR,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		battleType = BattleConst.BATTLE_TYPE.PVP
	})
end

function GuildWarBuildPop:_onGetFormation()
	self:updateView()
end

function GuildWarBuildPop:updatePlayTimes()
	self.m_playNumText:setText(var_0_1:getGuildWar() .. "/" .. self._maxPlayTimes)
end

function GuildWarBuildPop:onBuyPlayTimes()
	require("app.view.base.infoPop.BasePlayNumPop").createBuy(g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.GUILD_WAR)
end

function GuildWarBuildPop:_onRevNotify(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_4.guild_id ~= var_0_0:getCurWatchGuildId() then
		return
	end

	if arg_9_4.build_id ~= self._buildId then
		return
	end

	if arg_9_4.notify_type == 1 then
		-- block empty
	elseif arg_9_4.notify_type == 2 then
		-- block empty
	end

	self:updateView()
end

function GuildWarBuildPop:updateView()
	self._buildData = var_0_0:getBuildDataById(self._buildId)

	local var_10_0 = var_0_0:isUserEmpty(self._buildData)

	if var_10_0 then
		local var_10_1 = 0
		local var_10_2 = 0

		if self._buildData then
			var_10_1 = self._buildData:getCostHp()
			var_10_2 = self._buildData:getCostScore()
		end

		self.m_buildComp:updateBuild({
			cfg = self._cfg,
			hp = var_10_1,
			score = var_10_2,
			canBattle = var_10_0
		})

		if var_0_0:isBuildDestroy(self._buildData) then
			self.m_stateController:setSelectedIndex(2)
		else
			self.m_stateController:setSelectedIndex(1)
		end

		self:updateDescTip(1)

		if self.isFirstEnter then
			self.isFirstEnter = false

			self.m_enter_1Transition:play()
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.GUILD_WAR_OPEN_CHALLENGE_BUILD_POP)
		end
	else
		self.m_stateController:setSelectedIndex(0)

		if self.isFirstEnter then
			self.isFirstEnter = false

			self.m_enter_0Transition:play()
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.GUILD_WAR_SELECTED_USER_POP)
		end

		self._userList = {}

		for iter_10_0, iter_10_1 in pairs(self._buildData:getUsers()) do
			table.insert(self._userList, {
				playerData = iter_10_1,
				cfg = self._cfg
			})
		end

		self:updateDescTip(0)
		self.m_enemyList:setNumItems(#self._userList)
	end
end

function GuildWarBuildPop:updateDescTip(arg_11_1)
	self.m_desc1:setVisible(false)
	self.m_desc2:setVisible(false)

	if not self._descTb[arg_11_1] then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(self._descTb[arg_11_1]) do
		self["m_desc" .. iter_11_0]:setVisible(true)
		self["m_desc" .. iter_11_0 .. "Txt"]:setText(g.core.lang:get(iter_11_1.id))
		self["m_value" .. iter_11_0 .. "Txt"]:setText(iter_11_1.value)
	end
end

function GuildWarBuildPop:_onEnemyRenderer(arg_12_1, arg_12_2)
	arg_12_2:updateEnemy(self._userList[arg_12_1 + 1])
end

return GuildWarBuildPop
