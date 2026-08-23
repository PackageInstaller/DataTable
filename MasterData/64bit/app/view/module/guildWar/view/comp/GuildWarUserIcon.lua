local var_0_0 = g.core.config.avata_info
local var_0_1 = g.core.config.dress_info
local var_0_2 = g.core.config.knight_base_info
local var_0_3 = g.core.config.knight_info
local var_0_4 = g.core.common.Path
local GuildWarUserIcon = class("GuildWarUserIcon", require("app.fairyGUI.guildWar.UI_GuildWarUserIcon"))

function GuildWarUserIcon:ctor()
	self._clickCall = nil

	self:addClickListener(handler(self, self._onClickIcon))
end

function GuildWarUserIcon:updateAsUser(arg_2_1)
	local var_2_1 = var_0_3.get(arg_2_1.base_id or 210000)
	local var_2_2

	if arg_2_1.skin and arg_2_1.skin > 0 and arg_2_1.skin_ts and (arg_2_1.skin_ts == 0 or arg_2_1.skin_ts > g.core.common.ServerTime:getTime()) then
		var_2_2 = var_0_2.get(g.core.config.skin_info.get(arg_2_1.skin).res)
	end

	var_2_2 = var_2_2 or var_0_2.get(var_2_1.res_id)

	local var_2_3 = var_2_2.icon_id
	local var_2_4 = 0

	if arg_2_1.dress_id and arg_2_1.dress_id ~= 0 then
		var_2_4 = var_2_1.sex
		var_2_3 = var_0_2.get((var_2_1.sex == 0 or nil) and var_0_1.get(arg_2_1.dress_id).woman_res_id).icon_id
	end

	local var_2_7 = false
	local var_2_8 = arg_2_1.avata_id or 0

	if var_2_8 == 200000 or var_2_8 == 210000 then
		var_2_7 = true
		var_2_3 = var_2_8
	end

	if var_2_8 > 0 and not var_2_7 then
		local var_2_9 = var_0_0.get(var_2_8)
		local var_2_10 = string.split(var_2_9.res, ",")

		if #var_2_10 > 1 then
			local var_2_11 = {}

			for iter_2_0, iter_2_1 in ipairs(var_2_10) do
				local var_2_12 = string.split(iter_2_1, "_")

				var_2_11[var_2_12[1]] = var_2_12[2]
			end

			self.m_iconLoader:setURL(var_0_4:getRoleHeadIcon(var_2_11[tostring(var_2_4)]))
		else
			self.m_iconLoader:setURL(var_0_4:getRoleHeadIcon(var_2_9.res))
		end
	else
		self.m_iconLoader:setURL(var_0_4:getKnightIconById(var_2_3))
	end
end

function GuildWarUserIcon:_onClickIcon()
	if self._clickCall then
		self._clickCall()
	end
end

function GuildWarUserIcon:setTouchCallFunc(arg_4_1)
	self._clickCall = arg_4_1
end

return GuildWarUserIcon
