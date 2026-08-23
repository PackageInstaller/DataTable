local var_0_0 = g.core.config.avata_info
local var_0_1 = g.core.config.dress_info
local var_0_2 = g.core.config.knight_base_info
local var_0_3 = g.core.config.knight_info
local var_0_4 = g.core.common.Path
local var_0_5 = g.core.model.User.guildData
local var_0_6 = {
	{
		hideScore = true,
		subId = 308623,
		title = g.core.lang:get(308620)
	},
	{
		subId = 308624,
		title = g.core.lang:get(308621)
	},
	{
		subId = 308625,
		title = g.core.lang:get(308622)
	}
}
local var_0_7 = {
	{
		subId = 308629,
		title = g.core.lang:get(308626)
	},
	{
		subId = 308630,
		title = g.core.lang:get(308627)
	},
	{
		subId = 308631,
		title = g.core.lang:get(308628)
	}
}
local GuildWarResultBadgeIconComp = class("GuildWarResultBadgeIconComp", require("app.fairyGUI.guildWar.UI_GuildWarResultBadgeIconComp"))

function GuildWarResultBadgeIconComp:ctor()
	self._userSnapshot = nil
	self._guildSnapshot = nil

	self.m_showIcon:addClickListener(handler(self, self._onClickIcon))
end

function GuildWarResultBadgeIconComp:_onClickIcon()
	if self._userSnapshot and self._userSnapshot.id then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
			isUpdate = true,
			uid = self._userSnapshot.id
		})
	elseif self._guildSnapshot and self._guildSnapshot.id then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.GuildDetailsPop").new(self._guildSnapshot), {
			touchDisappear = true
		})
	end
end

function GuildWarResultBadgeIconComp:updateCompByFight(arg_3_1, arg_3_2)
	local var_3_0 = var_0_6[arg_3_2] or {}

	self:setTitle(var_3_0.title or "")

	self._userSnapshot = nil
	self._guildSnapshot = nil

	local var_3_1 = arg_3_1.value or 0

	if var_3_0.hideScore then
		self.m_isShowScoreController:setSelectedIndex(0)
		self.m_descText:setText(g.core.lang:get(var_3_0.subId, {
			score = var_3_1
		}))
		self.m_showIcon:setURL((var_0_4:getGuildMidIconById(var_0_5:getGuildData().icon or 5)))

		self._guildSnapshot = var_0_5:getGuildData()
	else
		self.m_isShowScoreController:setSelectedIndex(1)

		local var_3_2 = arg_3_1.user or {}

		self.m_descText:setText(var_3_2.name or "")
		self.m_scoreText:setText(g.core.lang:get(var_3_0.subId, {
			score = var_3_1
		}))

		self._userSnapshot = var_3_2

		self.m_showIcon:setTouchable(true)
		self:updateUserIcon(var_3_2)
	end
end

function GuildWarResultBadgeIconComp:updateUserIcon(arg_4_1)
	local var_4_1 = var_0_3.get(arg_4_1.base_id or 210000)
	local var_4_2

	if arg_4_1.skin and arg_4_1.skin > 0 and arg_4_1.skin_ts and (arg_4_1.skin_ts == 0 or arg_4_1.skin_ts > g.core.common.ServerTime:getTime()) then
		var_4_2 = var_0_2.get(g.core.config.skin_info.get(arg_4_1.skin).res)
	end

	var_4_2 = var_4_2 or var_0_2.get(var_4_1.res_id)

	local var_4_3 = var_4_2.icon_id
	local var_4_4 = 0

	if arg_4_1.dress_id and arg_4_1.dress_id ~= 0 then
		var_4_4 = var_4_1.sex
		var_4_3 = var_0_2.get((var_4_1.sex == 0 or nil) and var_0_1.get(arg_4_1.dress_id).woman_res_id).icon_id
	end

	local var_4_7 = false
	local var_4_8 = arg_4_1.avata_id or 0

	if var_4_8 == 200000 or var_4_8 == 210000 then
		var_4_7 = true
		var_4_3 = var_4_8
	end

	if var_4_8 > 0 and not var_4_7 then
		local var_4_9 = var_0_0.get(var_4_8)
		local var_4_10 = string.split(var_4_9.res, ",")

		if #var_4_10 > 1 then
			local var_4_11 = {}

			for iter_4_0, iter_4_1 in ipairs(var_4_10) do
				local var_4_12 = string.split(iter_4_1, "_")

				var_4_11[var_4_12[1]] = var_4_12[2]
			end

			self.m_showIcon:setURL(var_0_4:getRoleHeadIcon(var_4_11[tostring(var_4_4)]))
		else
			self.m_showIcon:setURL(var_0_4:getRoleHeadIcon(var_4_9.res))
		end
	else
		self.m_showIcon:setURL(var_0_4:getKnightIconById(var_4_3))
	end
end

function GuildWarResultBadgeIconComp:updateCompBySeason(arg_5_1, arg_5_2)
	local var_5_0 = var_0_7[arg_5_2] or {}

	self:setTitle(var_5_0.title or "")

	self._userSnapshot = nil
	self._guildSnapshot = nil

	local var_5_1 = arg_5_1.value or 0

	self.m_descText:setText(g.core.lang:get(var_5_0.subId, {
		score = var_5_1
	}))

	local var_5_2 = arg_5_1.guild or {}

	self._guildSnapshot = var_5_2

	self.m_showIcon:setURL((var_0_4:getGuildMidIconById(var_5_2.icon or 5)))

	if var_5_0.hideScore then
		self.m_isShowScoreController:setSelectedIndex(0)
		self.m_descText:setText(g.core.lang:get(var_5_0.subId, {
			score = var_5_1
		}))

		local var_5_3 = arg_5_1.guild or {}

		self._guildSnapshot = var_5_3

		self.m_showIcon:setURL((var_0_4:getGuildMidIconById(var_5_3.icon or 5)))
	else
		self.m_isShowScoreController:setSelectedIndex(1)

		local var_5_4 = arg_5_1.guild or {}

		self.m_descText:setText(var_5_4.name or "")
		self.m_scoreText:setText(g.core.lang:get(var_5_0.subId, {
			score = var_5_1
		}))

		self._guildSnapshot = var_5_4

		self.m_showIcon:setURL((var_0_4:getGuildMidIconById(var_5_4.icon or 5)))
	end
end

return GuildWarResultBadgeIconComp
