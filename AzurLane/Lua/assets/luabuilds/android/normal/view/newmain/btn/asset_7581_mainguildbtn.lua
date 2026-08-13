class = var_0_10000

local var_0_0 = "MainGuildBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseBtn"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.guildLock = arg_1_1:Find("lock")

	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.GetComponent

	typeof = var_5
	Image = var_6
	arg_1_0.guildImage = var_1_1(var_1_0, var_5(var_6))

	return
end

function var_0_1.OnClick(arg_2_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)

	if var_1.getRawData(var_2_0) then
		local var_2_1 = arg_2_0
		local var_2_2 = arg_2_0.emit

		NewMainMediator = var_1_10003
		var_1_10003 = var_1_10003.GO_SCENE
		SCENE = var_1_10004

		var_2_2(var_2_1, var_1_10003, var_1_10004.GUILD)
	else
		local var_2_3 = arg_2_0
		local var_2_4 = arg_2_0.emit

		NewMainMediator = var_1_10003

		local var_2_5 = var_1_10003.GO_SCENE

		SCENE = var_1_10004

		var_2_4(var_2_3, var_2_5, var_1_10004.NEWGUILD)
	end

	return
end

function var_0_1.Flush(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_3_0 = var_1_10002(var_1_10003)
	local var_3_1 = var_2.getRawData(var_3_0)

	pg = var_3_0

	local var_3_2 = var_3_0.SystemOpenMgr.GetInstance()
	local var_3_3 = var_3.isOpenSystem(var_3_2, var_3_1.level, "NewGuildMediator")

	if not arg_3_0.isOpenGuild or arg_3_0.isOpenGuild ~= var_3_3 then
		setActive = var_3_4

		var_3_4(arg_3_0.guildLock, not var_3_3)

		if var_3_3 then
			Color = var_3_4

			local var_3_4

			if not var_3_4(1, 1, 1, 1) then
				Color = var_3_4
				var_3_4 = var_3_4(0.3, 0.3, 0.3, 1)
			end

			arg_3_0.guildImage.color = var_3_4
			arg_3_0.isOpenGuild = var_3_3

			return
		end
	end
end

return var_0_1
