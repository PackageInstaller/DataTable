local var_0_0 = class("MainGuildBtn", import(".MainBaseBtn"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.guildLock = arg_1_1:Find("lock")
	arg_1_0.guildImage = arg_1_1:GetComponent(typeof(Image))

	return
end

function var_0_0.OnClick(arg_2_0)
	if getProxy(GuildProxy):getRawData() then
		arg_2_0:emit(NewMainMediator.GO_SCENE, SCENE.GUILD)
	else
		arg_2_0:emit(NewMainMediator.GO_SCENE, SCENE.NEWGUILD)
	end

	return
end

function var_0_0.Flush(arg_3_0, arg_3_1)
	local var_3_0 = pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "NewGuildMediator")

	if not arg_3_0.isOpenGuild or arg_3_0.isOpenGuild ~= var_3_0 then
		setActive(arg_3_0.guildLock, not var_3_0)

		arg_3_0.guildImage.color = var_3_0 and Color(1, 1, 1, 1) or Color(0.3, 0.3, 0.3, 1)
		arg_3_0.isOpenGuild = var_3_0
	end

	return
end

return var_0_0
