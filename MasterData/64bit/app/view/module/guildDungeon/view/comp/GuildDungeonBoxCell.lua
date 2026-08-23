local GuildDungeonBoxCell = class("GuildDungeonBoxCell", require("app.fairyGUI.guildDungeon.UI_GuildDungeonBoxCell"))
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.model.User.guildData
local var_0_3 = g.core.common.Goods
local var_0_4 = g.core.common.Path
local var_0_5 = g.core.lang
local var_0_6 = g.core.config.guild_dungeon_award_info
local var_0_7 = "kuyexingdong"

function GuildDungeonBoxCell:ctor()
	self._index = 0
	self._stageData = {}
	self._awardData = {}
	self._effect = nil
	self._isRec = false

	self:addClickListener(handler(self, self._onClickBox))
	self.m_boxIcon:setURL(var_0_4:getItemIconById(var_0_7))
end

function GuildDungeonBoxCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETTREASUREBOX, handler(self, self._onRcvGetTreasureBox), self)
end

function GuildDungeonBoxCell:_onRcvGetTreasureBox(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_4.position == self._awardData.pos then
		({}).award = clone(self._awardData.award)
	end
end

function GuildDungeonBoxCell:updateCell(arg_4_1)
	if arg_4_1 then
		self._index = arg_4_1.index or 1
	end

	if arg_4_1 then
		self._awardData = arg_4_1.awardData or {}
	end

	if arg_4_1 then
		self._stageData = arg_4_1.stageData or {}
	end

	if arg_4_1 then
		self._hasRec = arg_4_1.hasRec or false
	end

	self._isRec = checkbool(next(self._awardData))

	self.m_numberTxt:setText(string.format("%02d", self._index))
	self.m_isReceiveController:setSelectedIndex(self._isRec and 1 or 0)

	if self._isRec then
		local var_4_0 = var_0_2:getGuildMemberByPlayerId(self._awardData.playerId)

		if var_4_0 then
			local var_4_1 = var_4_0.user

			self.m_isSelfController:setSelectedIndex(var_4_0.user.id == g.core.model.User:getId() and 1 or 0)
			self.m_nameText:setText(var_4_1.name)
		else
			self.m_isSelfController:setSelectedIndex(0)
			self.m_nameText:setText(var_0_5:get(306018))
		end

		local var_4_2 = {}

		if self._awardData.awardId then
			local var_4_3 = var_0_6.get(self._awardData.awardId)

			var_4_2 = var_0_3:convert({
				type = var_4_3.type,
				value = var_4_3.value,
				size = var_4_3.size
			})
		else
			var_4_2 = var_0_3:convert(clone(self._awardData.award))
		end

		self.m_qualityBg:setURL(var_0_4:getGuildDungeonAwardIconBg(var_4_2.quality))
		self.m_pic:setURL(var_4_2.icon)
		self.m_countTxt:setText(math.floor(var_4_2.size))
	else
		self.m_qualityBg:setURL(var_0_4:getGuildDungeonAwardIconBg())
	end
end

function GuildDungeonBoxCell:_onClickBox()
	if self._stageData:isStageFinish() then
		if self._isRec then
			var_0_1:tip(var_0_5:get(306006))
		elseif self._hasRec then
			var_0_1:tip(var_0_5:get(306006))
		else
			local var_5_0 = self._stageData:getCfg().id

			if g.core.model.User.guildDungeonData:canRecStageTreasure(var_5_0) then
				g.core.network.GameNetProxy:send_C2S_GuildDungeon_GetTreasureBox({
					position = self._index,
					stage_id = var_5_0
				})
			else
				var_0_1:tip(var_0_5:get(306019))
			end
		end
	else
		var_0_1:tip(var_0_5:get(306007))
	end
end

return GuildDungeonBoxCell
