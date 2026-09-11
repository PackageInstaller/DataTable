local GuildMemberItem = class("GuildMemberItem", ReduxView)

function GuildMemberItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transformPost_, "conName")
end

function GuildMemberItem:Dispose()
	GuildMemberItem.super.Dispose(self)
end

function GuildMemberItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(self.id_)
	end)
end

function GuildMemberItem:SetData(arg_5_1, arg_5_2)
	self.id_ = arg_5_1

	local var_5_0 = GuildData:GetGuildMemberData(arg_5_1)

	self.imageIcon_.sprite = ItemTools.getItemSprite(var_5_0.icon)
	self.imageHeadBg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. var_5_0.frame)
	self.textName_.text = GetI18NText(var_5_0.name)
	self.textLevel_.text = GetTips("LEVEL") .. string.format("%s", var_5_0.level)
	self.textContribute_.text = arg_5_2 and GetI18NText(var_5_0.weekContribute) or GetI18NText(var_5_0.contribute)
	self.textOnline_.text = var_5_0.offlineStamptime == 0 and string.format("<color=#6AA788>%s</color>", manager.time:GetOnLineText(var_5_0.offlineStamptime)) or string.format("<color=#494A4F>%s</color>", manager.time:GetOnLineText(var_5_0.offlineStamptime))

	self.controller_:SetSelectedState(var_5_0.post)

	if var_5_0.post == GuildConst.GUILD_POST.CAPTAIN then
		self.labelText_.text = GetTips("CLUB_CHAIR_MAN")
	elseif var_5_0.post == GuildConst.GUILD_POST.DEPUTY then
		self.labelText_.text = GetTips("CLUB_VICE_CHAIR_MAN")
	elseif var_5_0.post == GuildConst.GUILD_POST.MEMBER then
		self.labelText_.text = GetTips("CLUB_MEMBER")
	elseif var_5_0.post == GuildConst.GUILD_POST.TRAINEE then
		self.labelText_.text = GetTips("CLUB_NOVICIATE")
	end
end

return GuildMemberItem
