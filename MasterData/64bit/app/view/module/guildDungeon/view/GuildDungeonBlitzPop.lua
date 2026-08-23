local GuildDungeonBlitzPop = class("GuildDungeonBlitzPop", require("app.fairyGUI.guildDungeon.UI_GuildDungeonBlitzPop"), function()
	return fgui.GComponent:create({
		resName = "GuildDungeonBlitzPop",
		pkgPath = "ui/guildDungeon/guildDungeon",
		pkgName = "guildDungeon"
	})
end)
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.model.User.resourceData
local var_0_3 = g.core.model.User.guildData
local var_0_4 = g.core.module.ModuleManager
local var_0_5 = g.core.network.GameNetProxy
local var_0_6 = g.core.event.EventManager
local var_0_7 = g.core.event.enum

function GuildDungeonBlitzPop:ctor(arg_2_1)
	self._stageData = arg_2_1.stageData
	self._stageInfo = self._stageData:getCfg()
	self._preRank = nil
	self._totalDamage = 0
	self._blitzData = {}
	self._blitzIdx = 0
	self._blitzCount = 0
	self._hasTimes = var_0_2:getGuildDungeonTimes() > 0
	self.m_rankUpImg = self.m_rankTitle:getChild("upImg")

	self:_initUI()
end

function GuildDungeonBlitzPop:_initUI()
	self:showAtCenter()
	self.m_blitzBtn:addClickListener(handler(self, self._onClickBlitz))
	self.m_finishBtn:addClickListener(handler(self, self._onClickFinish))
	self.m_blitzList:setVirtual()
	self.m_blitzList:setItemRenderer(handler(self, self._onRenderCell))
end

function GuildDungeonBlitzPop:onLoad()
	var_0_6:addEventListener(var_0_7.EVENT_NET_S2C_GUILD_DUNGEON_ATTACKFINISH, self._onRcvAttackFinish, self)
	var_0_5:send_C2S_GuildDungeon_AttackBegin({
		stage_id = self._stageInfo.id
	})
end

function GuildDungeonBlitzPop:_onRcvAttackBegin()
	local var_5_0 = self._stageData:isStageFinish()

	self._hasTimes = var_0_2:getGuildDungeonTimes() > 0
	self._blitzCount = self._blitzCount + 1

	if self._hasTimes and not var_5_0 and self._blitzCount < 5 then
		var_0_5:send_C2S_GuildDungeon_AttackBegin({
			stage_id = self._stageInfo.id
		})
	else
		var_0_6:dispatchEvent(var_0_7.EVENT_REFRESH_GUILD_DUNGEON_LAYER)
		table.insert(self._blitzData, {
			finish = true,
			enough = var_5_0 or self._blitzCount == 5
		})
	end

	self.m_blitzList:setNumItems(#self._blitzData)
	self.m_blitzList:addSelection(#self._blitzData - 1, true)
end

function GuildDungeonBlitzPop:_onRcvAttackFinish(arg_6_1, arg_6_2, arg_6_3)
	self._preRank = self._preRank or arg_6_3.pre_rank > 0 and arg_6_3.pre_rank or var_0_3:getMemberNum()

	self.m_rankTitle:setTitle(arg_6_3.cur_rank)

	if arg_6_3.cur_rank ~= self._preRank then
		self.m_rankUpImg:setVisible(true)
	else
		self.m_rankUpImg:setVisible(false)
	end

	self._totalDamage = arg_6_3.total_damage

	self.m_dmgTitle:setTitle(self._totalDamage)

	local var_6_0 = arg_6_3.awards or {}

	self._blitzIdx = self._blitzIdx + 1

	table.insert(self._blitzData, {
		damage = arg_6_3.damage,
		awards = var_6_0,
		blitzIdx = self._blitzIdx
	})
	self:_onRcvAttackBegin()
end

function GuildDungeonBlitzPop:_onRenderCell(arg_7_1, arg_7_2)
	if self._blitzData[arg_7_1 + 1] then
		arg_7_2:updateBlitzCell({
			data = self._blitzData[arg_7_1 + 1],
			cellIdx = arg_7_1 + 1
		})
	end
end

function GuildDungeonBlitzPop:_onClickBlitz()
	self._preRank = nil
	self._totalDamage = 0
	self._blitzData = {}
	self._blitzIdx = 0
	self._blitzCount = 0

	if self._stageData:isStageFinish() then
		var_0_4:tip(g.core.lang:get(306003))
		var_0_4:popComponent()
	elseif var_0_2:getGuildDungeonTimes() > 0 then
		var_0_5:send_C2S_GuildDungeon_AttackBegin({
			stage_id = self._stageInfo.id
		})
	else
		require("app.view.base.infoPop.BasePlayNumPop").createBuy(var_0_1.ShopConst.SHOP_SCORE.GUILD_DUNGEON_NUM)
	end
end

function GuildDungeonBlitzPop:_onClickFinish()
	var_0_4:popComponent()
end

return GuildDungeonBlitzPop
