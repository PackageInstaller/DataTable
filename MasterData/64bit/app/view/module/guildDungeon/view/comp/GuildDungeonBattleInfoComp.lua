local GuildDungeonBattleInfoComp = class("GuildDungeonBattleInfoComp", require("app.fairyGUI.guildDungeon.UI_GuildDungeonBattleInfoComp"))
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.const.ConstMgr
local var_0_3 = g.core.common.ModuleUnlock
local var_0_4 = g.core.module.ModuleManager
local var_0_5 = g.core.model.User.resourceData
local var_0_6 = g.core.const.ConstMgr.FUNCTION_TYPE

function GuildDungeonBattleInfoComp:ctor(arg_1_1)
	self._stageData = nil
	self._stageIndex = 0
	self._chapterId = 0
	self._stageInfo = nil

	self:_addListener()
end

function GuildDungeonBattleInfoComp:updateComp(arg_2_1)
	self._stageData = arg_2_1 and arg_2_1.stageData
	self._stageIndex = arg_2_1 and arg_2_1.index
	self._chapterId = arg_2_1 and arg_2_1.chapterId
	self._stageInfo = self._stageData:getCfg()

	self.m_stageName:setText(self._stageInfo.dungeon_name_1)
	self.m_teamComp:updateFormation({
		teamId = self._stageInfo.monster_group
	})
	self.m_awardIcon:updateIcon({
		type = var_0_1.TYPE_RESOURCE,
		value = var_0_1.RESOURCE.TYPE_GUILD_EXP,
		size = self._stageInfo.guild_exp
	})

	for iter_2_0 = 1, 2 do
		self["m_dropIcon" .. iter_2_0]:updateIcon({
			type = self._stageInfo["attack_award_type_" .. iter_2_0],
			value = self._stageInfo["attack_award_value_" .. iter_2_0],
			size = self._stageInfo["attack_award_size_" .. iter_2_0]
		})
	end

	if self._stageData:isStageFinish() then
		self.m_stateController:setSelectedIndex(2)

		local var_2_0 = self._stageData:getMvpData()

		if var_2_0 and var_2_0.user then
			self.m_mvpTxt:setText(g.core.lang:get(306016, {
				name = var_2_0.user.name
			}))
		else
			self.m_mvpTxt:setText("")
		end
	else
		self.m_stateController:setSelectedIndex(var_0_3:isModuleShow(var_0_6.GUILD_DUNGEON_BLITZ) and 1 or 0)
	end
end

function GuildDungeonBattleInfoComp:_addListener()
	self.m_formationBtn:addClickListener(handler(self, self._onClickFormation))
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattle))
	self.m_blitzBtn:addClickListener(handler(self, self._onClickBlitz))
	self.m_recordBtn:addClickListener(handler(self, self._onClickRecord))
end

function GuildDungeonBattleInfoComp:_onClickBattle()
	if var_0_5:getGuildDungeonTimes() > 0 then
		g.core.network.GameNetProxy:send_C2S_GuildDungeon_AttackBegin({
			stage_id = self._stageInfo.id
		})
	else
		require("app.view.base.infoPop.BasePlayNumPop").createBuy(var_0_2.ShopConst.SHOP_SCORE.GUILD_DUNGEON_NUM)
	end
end

function GuildDungeonBattleInfoComp:_onClickBlitz()
	if not var_0_3:isModuleUnlock(var_0_6.GUILD_DUNGEON_BLITZ) then
		return
	end

	if var_0_5:getGuildDungeonTimes() > 0 then
		self:addPopup(require("app.view.module.guildDungeon.view.GuildDungeonBlitzPop").new({
			stageData = self._stageData
		}), {
			touchDisappear = true
		})
		self:dispatchCompEvent("GuildDungeonBattleInfoComp_Blitz")
	else
		require("app.view.base.infoPop.BasePlayNumPop").createBuy(var_0_2.ShopConst.SHOP_SCORE.GUILD_DUNGEON_NUM)
	end
end

function GuildDungeonBattleInfoComp:_onClickFormation()
	var_0_4:pushModule(g.view.entrance.FORMATION)
end

function GuildDungeonBattleInfoComp:_onClickRecord()
	self:addPopup(require("app.view.module.guildDungeon.view.GuildDungeonRecordPop").new({
		chapterId = self._chapterId,
		index = self._stageIndex
	}), {
		touchDisappear = true,
		hideContinue = true
	})
end

return GuildDungeonBattleInfoComp
