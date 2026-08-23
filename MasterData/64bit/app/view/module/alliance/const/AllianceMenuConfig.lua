local var_0_0 = g.core.module.ModuleManager
local var_0_1 = {}
local var_0_2 = g.core.config.guild_alliance_right_info

var_0_1.BUTTON_TYPE = {
	GUILD_INFO = 3,
	QUIT_ALLIANCE = 2,
	DISMISS_ALLIANCE = 1,
	IMPEACH = 8,
	KICK = 7,
	TRANSFER = 6,
	LAYOFF = 5,
	SET_VICE = 4
}
var_0_1.BUTTON_CONFIG = {
	[var_0_1.BUTTON_TYPE.DISMISS_ALLIANCE] = {
		title = g.core.lang:get(428583),
		callback = function()
			var_0_0:popModule()
			var_0_0:pushPopup(require("app.view.module.alliance.view.hall.AllianceHallOperatePop").new({
				operationType = var_0_1.BUTTON_TYPE.DISMISS_ALLIANCE,
				onConfirm = function()
					local var_2_0, var_2_1 = g.core.model.User.guildData:getCanPlayerExitGuildOrAlliance()

					if not var_2_0 then
						g.core.module.ModuleManager:tip(var_2_1)

						return
					end

					g.core.network.GameNetProxy:send_C2S_GuildAlliance_Dismiss({})
				end,
				title = g.core.lang:get(428583)
			}), {
				ignoreTouch = false,
				touchDisappear = true
			})
		end
	},
	[var_0_1.BUTTON_TYPE.QUIT_ALLIANCE] = {
		title = g.core.lang:get(428584),
		callback = function()
			var_0_0:popModule()
			var_0_0:pushPopup(require("app.view.module.alliance.view.hall.AllianceHallOperatePop").new({
				operationType = var_0_1.BUTTON_TYPE.QUIT_ALLIANCE,
				onConfirm = function()
					local var_4_0, var_4_1 = g.core.model.User.guildData:getCanPlayerExitGuildOrAlliance()

					if not var_4_0 then
						g.core.module.ModuleManager:tip(var_4_1)

						return
					end

					g.core.network.GameNetProxy:send_C2S_GuildAlliance_Quit({})
				end,
				title = g.core.lang:get(428584)
			}), {
				ignoreTouch = false,
				touchDisappear = true
			})
		end
	},
	[var_0_1.BUTTON_TYPE.GUILD_INFO] = {
		title = g.core.lang:get(428585),
		callback = function(arg_5_0)
			var_0_0:popModule()
			var_0_0:pushPopup(require("app.view.base.infoPop.GuildDetailsPop").new(arg_5_0), {
				ignoreTouch = false,
				touchDisappear = true
			})
		end
	},
	[var_0_1.BUTTON_TYPE.SET_VICE] = {
		title = g.core.lang:get(428586),
		callback = function(arg_6_0)
			var_0_0:popModule()
			var_0_0:pushPopup(require("app.view.module.alliance.view.hall.AllianceHallOperatePop").new({
				operationType = var_0_1.BUTTON_TYPE.SET_VICE,
				onConfirm = function()
					g.core.network.GameNetProxy:send_C2S_GuildAlliance_Appoint({
						guild_id = arg_6_0.id,
						grade = g.core.const.ConstMgr.AllianceConst.GRADE.VICE_LEADER
					})
				end,
				guildSnapshot = arg_6_0,
				title = g.core.lang:get(428586)
			}), {
				ignoreTouch = false,
				touchDisappear = true
			})
		end
	},
	[var_0_1.BUTTON_TYPE.LAYOFF] = {
		title = g.core.lang:get(428587),
		callback = function(arg_8_0)
			var_0_0:popModule()
			var_0_0:pushPopup(require("app.view.module.alliance.view.hall.AllianceHallOperatePop").new({
				operationType = var_0_1.BUTTON_TYPE.LAYOFF,
				onConfirm = function()
					g.core.network.GameNetProxy:send_C2S_GuildAlliance_Appoint({
						guild_id = arg_8_0.id,
						grade = g.core.const.ConstMgr.AllianceConst.GRADE.MEMBER
					})
				end,
				guildSnapshot = arg_8_0,
				title = g.core.lang:get(428587)
			}), {
				ignoreTouch = false,
				touchDisappear = true
			})
		end
	},
	[var_0_1.BUTTON_TYPE.TRANSFER] = {
		title = g.core.lang:get(428588),
		callback = function(arg_10_0)
			var_0_0:popModule()
			var_0_0:pushPopup(require("app.view.module.alliance.view.hall.AllianceHallOperatePop").new({
				operationType = var_0_1.BUTTON_TYPE.TRANSFER,
				onConfirm = function()
					g.core.network.GameNetProxy:send_C2S_GuildAlliance_Appoint({
						guild_id = arg_10_0.id,
						grade = g.core.const.ConstMgr.AllianceConst.GRADE.LEADER
					})
				end,
				guildSnapshot = arg_10_0,
				title = g.core.lang:get(428588)
			}), {
				ignoreTouch = false,
				touchDisappear = true
			})
		end
	},
	[var_0_1.BUTTON_TYPE.KICK] = {
		title = g.core.lang:get(428589),
		callback = function(arg_12_0)
			var_0_0:popModule()
			var_0_0:pushPopup(require("app.view.module.alliance.view.hall.AllianceHallOperatePop").new({
				operationType = var_0_1.BUTTON_TYPE.KICK,
				onConfirm = function()
					local var_13_0, var_13_1 = g.core.model.User.guildData:getCanPlayerExitGuildOrAlliance()

					if not var_13_0 then
						g.core.module.ModuleManager:tip(var_13_1)

						return
					end

					g.core.network.GameNetProxy:send_C2S_GuildAlliance_Kick({
						guild_id = arg_12_0.id
					})
				end,
				guildSnapshot = arg_12_0,
				title = g.core.lang:get(428589)
			}), {
				ignoreTouch = false,
				touchDisappear = true
			})
		end
	},
	[var_0_1.BUTTON_TYPE.IMPEACH] = {
		title = g.core.lang:get(428590),
		callback = function()
			g.core.network.GameNetProxy:send_C2S_GuildAlliance_Impeach({})
		end
	}
}

function var_0_1._getNominateButtonType(arg_15_0, arg_15_1)
	local var_15_0 = {}

	if arg_15_0 == g.core.const.ConstMgr.AllianceConst.GRADE.LEADER and arg_15_1 ~= g.core.const.ConstMgr.AllianceConst.GRADE.VICE_LEADER then
		table.insert(var_15_0, var_0_1.BUTTON_TYPE.SET_VICE)
	end

	if arg_15_0 == g.core.const.ConstMgr.AllianceConst.GRADE.LEADER and arg_15_1 == g.core.const.ConstMgr.AllianceConst.GRADE.VICE_LEADER then
		table.insert(var_15_0, var_0_1.BUTTON_TYPE.TRANSFER)
	end

	if arg_15_0 < arg_15_1 and arg_15_1 ~= g.core.const.ConstMgr.AllianceConst.GRADE.MEMBER then
		table.insert(var_15_0, var_0_1.BUTTON_TYPE.LAYOFF)
	end

	return var_15_0
end

function var_0_1.getShowButtonByGrade(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = var_0_2.get(arg_16_0)
	local var_16_1 = {}

	table.insert(var_16_1, var_0_1.BUTTON_CONFIG[var_0_1.BUTTON_TYPE.GUILD_INFO])

	if arg_16_1 then
		if var_16_0.dissolve == 1 then
			table.insert(var_16_1, var_0_1.BUTTON_CONFIG[var_0_1.BUTTON_TYPE.DISMISS_ALLIANCE])
		else
			table.insert(var_16_1, var_0_1.BUTTON_CONFIG[var_0_1.BUTTON_TYPE.QUIT_ALLIANCE])
		end
	else
		if var_16_0.nominate == 1 then
			for iter_16_0, iter_16_1 in ipairs((var_0_1._getNominateButtonType(arg_16_0, arg_16_2))) do
				table.insert(var_16_1, var_0_1.BUTTON_CONFIG[iter_16_1])
			end
		end

		if var_16_0.kick_out == 1 and arg_16_0 < arg_16_2 then
			table.insert(var_16_1, var_0_1.BUTTON_CONFIG[var_0_1.BUTTON_TYPE.KICK])
		end

		if arg_16_2 == g.core.const.ConstMgr.AllianceConst.GRADE.LEADER and arg_16_0 == g.core.const.ConstMgr.AllianceConst.GRADE.VICE_LEADER and g.core.model.User.allianceData:isImpeachEnable() then
			table.insert(var_16_1, var_0_1.BUTTON_CONFIG[var_0_1.BUTTON_TYPE.IMPEACH])
		end
	end

	return var_16_1
end

return var_0_1
