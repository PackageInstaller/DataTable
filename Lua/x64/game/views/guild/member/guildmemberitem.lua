local var_0_0 = class("GuildMemberItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transformPost_, "conName")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(arg_3_0.id_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.id_ = arg_5_1

	local var_5_0 = GuildData:GetGuildMemberData(arg_5_1)

	arg_5_0.imageIcon_.sprite = ItemTools.getItemSprite(var_5_0.icon)
	arg_5_0.imageHeadBg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. var_5_0.frame)
	arg_5_0.textName_.text = GetI18NText(var_5_0.name)
	arg_5_0.textLevel_.text = GetTips("LEVEL") .. string.format("%s", var_5_0.level)

	if arg_5_2 then
		arg_5_0.textContribute_.text = GetI18NText(var_5_0.weekContribute)
	else
		arg_5_0.textContribute_.text = GetI18NText(var_5_0.contribute)
	end

	if var_5_0.offlineStamptime == 0 then
		arg_5_0.textOnline_.text = string.format("<color=#6AA788>%s</color>", manager.time:GetOnLineText(var_5_0.offlineStamptime))
	else
		arg_5_0.textOnline_.text = string.format("<color=#494A4F>%s</color>", manager.time:GetOnLineText(var_5_0.offlineStamptime))
	end

	arg_5_0.controller_:SetSelectedState(var_5_0.post)

	if var_5_0.post == GuildConst.GUILD_POST.CAPTAIN then
		arg_5_0.labelText_.text = GetTips("CLUB_CHAIR_MAN")
	elseif var_5_0.post == GuildConst.GUILD_POST.DEPUTY then
		arg_5_0.labelText_.text = GetTips("CLUB_VICE_CHAIR_MAN")
	elseif var_5_0.post == GuildConst.GUILD_POST.MEMBER then
		arg_5_0.labelText_.text = GetTips("CLUB_MEMBER")
	elseif var_5_0.post == GuildConst.GUILD_POST.TRAINEE then
		arg_5_0.labelText_.text = GetTips("CLUB_NOVICIATE")
	end
end

return var_0_0
