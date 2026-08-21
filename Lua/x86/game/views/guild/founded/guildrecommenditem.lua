local var_0_0 = class("GuildRecommendItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.recommendClickHandler_ = handler(arg_1_0, arg_1_0.ClickRecommendItem)

	manager.notify:RegistListener(GUILD_RECOMMEND_CLICK, arg_1_0.recommendClickHandler_)

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "conName")
	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	manager.notify:RemoveListener(GUILD_RECOMMEND_CLICK, arg_2_0.recommendClickHandler_)

	arg_2_0.recommendClickHandler_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		manager.notify:Invoke(GUILD_RECOMMEND_CLICK, arg_3_0.index_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.index_ = arg_5_1
	arg_5_0.textName_.text = GetI18NText(arg_5_2.name)
	arg_5_0.textLv_.text = arg_5_2.level
	arg_5_0.textMember_.text = string.format("%s/%s", GetI18NText(arg_5_2.member), GetI18NText(arg_5_2.maxMemberCnt))
	arg_5_0.textContribute_.text = GetI18NText(arg_5_2.contribute)

	local var_5_0 = ClubHeadIconCfg[arg_5_2.icon]

	arg_5_0.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", var_5_0.icon_bg)

	SetActive(arg_5_0.goFreeTag_, arg_5_2.isFree)
	arg_5_0:RefreshSelect(arg_5_3)

	if arg_5_2.isFree then
		arg_5_0.controller_:SetSelectedState("0")
	else
		arg_5_0.controller_:SetSelectedState("1")
	end
end

function var_0_0.ClickRecommendItem(arg_6_0, arg_6_1)
	arg_6_0:RefreshSelect(arg_6_0.index_ == arg_6_1)
end

function var_0_0.RefreshSelect(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.selectController_:SetSelectedState("true")
	else
		arg_7_0.selectController_:SetSelectedState("false")
	end
end

return var_0_0
