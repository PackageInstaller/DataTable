local MainGuildBtn = class("MainGuildBtn", import(".MainBaseBtn"))

function MainGuildBtn:Ctor(arg_1_1, arg_1_2)
	MainGuildBtn.super.Ctor(self, arg_1_1, arg_1_2)

	self.guildLock = arg_1_1:Find("lock")
	self.guildImage = arg_1_1:GetComponent(typeof(Image))

	return
end

function MainGuildBtn:OnClick()
	if getProxy(GuildProxy):getRawData() then
		self:emit(NewMainMediator.GO_SCENE, SCENE.GUILD)
	else
		self:emit(NewMainMediator.GO_SCENE, SCENE.NEWGUILD)
	end

	return
end

function MainGuildBtn:Flush(arg_3_1)
	local var_3_0 = pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "NewGuildMediator")

	if not self.isOpenGuild or self.isOpenGuild ~= var_3_0 then
		setActive(self.guildLock, not var_3_0)

		self.guildImage.color = var_3_0 and Color(1, 1, 1, 1) or Color(0.3, 0.3, 0.3, 1)
		self.isOpenGuild = var_3_0
	end

	return
end

return MainGuildBtn
