local GuildDungeonBattleInfoPop = class("GuildDungeonBattleInfoPop", require("app.fairyGUI.guildDungeon.UI_GuildDungeonBattleInfoPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/guildDungeon/guildDungeon",
		resName = "GuildDungeonBattleInfoPop",
		pkgName = "guildDungeon",
		isFullScreen = true
	})
end)
local DrawKnight = require("app.view.common.DrawKnight")

function GuildDungeonBattleInfoPop:ctor(arg_2_1)
	self._params = arg_2_1

	if arg_2_1 then
		self._stageData = arg_2_1.stageData or 0
	end

	if arg_2_1 then
		self._stageIndex = arg_2_1.index or 0
	end

	if arg_2_1 then
		self._chapterId = arg_2_1.chapterId or 0
	end

	self._stageInfo = self._stageData:getCfg()
	self._isBlitz = false

	self:_initComp()
	self:_addListener()
	self.m_playTimesComp:initView({
		type = g.core.common.Goods.RESOURCE.TYPE_GUILD_DUN_TIME,
		getTimesFunc = function()
			return g.core.model.User.resourceData:getGuildDungeonTimes()
		end,
		onGetTimes = function()
			require("app.view.base.infoPop.BasePlayNumPop").createBuy(g.core.const.ConstMgr.ShopConst.SHOP_SCORE.GUILD_DUNGEON_NUM)
		end,
		refreshEvent = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_ATTACKFINISH
		}
	})
end

function GuildDungeonBattleInfoPop:onLoad()
	self:_addNetWorkListener()
	self:_updateView()
	self.m_playTimesComp:updateView()
end

function GuildDungeonBattleInfoPop:_initComp()
	self:_initUI()
end

function GuildDungeonBattleInfoPop:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "GuildDungeonBattleInfoComp_Blitz" then
		self._isBlitz = true

		self:removeSelf()
	end
end

function GuildDungeonBattleInfoPop:_initUI()
	self.m_topBar:setResInfoById(26)
end

function GuildDungeonBattleInfoPop:_addListener()
	self.m_touchBg:addClickListener(handler(self, self._onClose))
end

function GuildDungeonBattleInfoPop:_addNetWorkListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_ATTACKBEGIN, self._onRcvAttackBegin, self)
end

function GuildDungeonBattleInfoPop:_updateView()
	local var_11_0 = g.core.model.User.guildDungeonData:getDisplayVersion()

	self.m_knightPicComp:updateKnight({
		isAlphaNode = true,
		resId = (var_11_0 == 1 or nil) and (self._stageInfo.image or self._stageInfo["image_" .. var_11_0])
	})
	self.m_infoComp:updateComp(self._params)
end

function GuildDungeonBattleInfoPop:_onClose()
	self:removeSelf()
end

function GuildDungeonBattleInfoPop:_onRcvAttackBegin(arg_13_1, arg_13_2, arg_13_3)
	if self._isBlitz then
		return
	end

	g.core.module.ModuleManager:popComponent({
		withoutAni = true
	})

	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		soundType = 1,
		type = BattleConst.TYPE_GUILD,
		battle_id = arg_13_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVP,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		bgId = g.core.config.guild_dungeon_week_info.get((g.core.model.User.guildDungeonData:getRebirth())).battle_stage
	})
end

return GuildDungeonBattleInfoPop
