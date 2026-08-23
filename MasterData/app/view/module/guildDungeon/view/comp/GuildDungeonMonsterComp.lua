local GuildDungeonMonsterComp = class("GuildDungeonMonsterComp", require("app.fairyGUI.guildDungeon.UI_GuildDungeonMonsterComp"))

function GuildDungeonMonsterComp:ctor()
	self._pic = nil
	self._stageData = {}
	self._stageIndex = 0
	self._chapterId = 0
	self._isFinish = false
	self._totalHp = 0
	self._curHp = 0

	self:addClickListener(handler(self, self._onClickMonster))
end

function GuildDungeonMonsterComp:onLoad()
	self:setVisible(false)
end

function GuildDungeonMonsterComp:updateComp(arg_3_1)
	self:setVisible(true)

	if arg_3_1 then
		self._stageData = arg_3_1.stageData or {}
	end

	if arg_3_1 then
		self._stageIndex = arg_3_1.index or 0
	end

	if arg_3_1 then
		self._chapterId = arg_3_1.chapterId or 0
	end

	local var_3_0 = self._stageData:getCfg()

	self._totalHp = self._stageData:getStageTotalHp()
	self._curHp = self._stageData:getStageCurHp()

	if g.core.model.User.guildDungeonData:getCurChapterId() > self._chapterId then
		self._curHp = 0
	end

	self._isFinish = math.uint64_equal(self._curHp, 0)

	self.m_nameText:setText(var_3_0.dungeon_name_1)
	self.m_progBar:setPercent({
		cur = self._curHp,
		max = self._totalHp
	})
	self.m_teamComp:updateFormation({
		teamId = var_3_0.monster_group
	})

	local var_3_1 = g.core.model.User.guildDungeonData:getDisplayVersion()
	local var_3_2 = {
		resId = (var_3_1 == 1 or nil) and (var_3_0.monster_image or var_3_0["monster_image_" .. var_3_1])
	}

	if self._pic then
		self._pic:removeFromParent()

		self._pic = nil
	end

	self._pic = require("app.view.battle.BattleKnight").new(var_3_2)

	self.m_picHolder:removeChildren()
	self.m_picHolder:addNode(self._pic)
	self:setFinish(self._isFinish)
end

function GuildDungeonMonsterComp:showDamage(arg_4_1)
	if self._isFinish then
		return
	end

	local var_4_0 = g.core.model.User.guildData:getGuildMemberByPlayerId(arg_4_1.member_id)

	self._curHp = math.uint64_sub(self._curHp, arg_4_1.damage)

	self.m_progBar:setPercent({
		cur = self._curHp,
		max = self._totalHp
	})

	self._isFinish = math.uint64_equal(self._curHp, 0)

	self:setFinish(self._isFinish)

	if math.uint64_equal(self._curHp, 0) then
		self:dispatchCompEvent("GuildDungeonMonsterComp_finish")
	end
end

function GuildDungeonMonsterComp:setFinish(arg_5_1)
	self.m_isPassController:setSelectedIndex(arg_5_1 and 1 or 0)

	if self._pic then
		if arg_5_1 then
			self._pic:stop()
		else
			self._pic:restart()
		end

		self._pic:setGray(arg_5_1)
	end
end

function GuildDungeonMonsterComp:_onClickMonster()
	self:addPopup(require("app.view.module.guildDungeon.view.GuildDungeonBattleInfoPop").new({
		index = self._stageIndex,
		stageData = self._stageData,
		chapterId = self._chapterId,
		isFinish = self._isFinish
	}))
end

return GuildDungeonMonsterComp
