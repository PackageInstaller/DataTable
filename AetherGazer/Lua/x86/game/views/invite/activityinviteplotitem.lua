local var_0_0 = class("ActivityInvitePlotItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "state")
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0.data = arg_4_1
	arg_4_0.index = arg_4_2
	arg_4_0.cfg = arg_4_3
	arg_4_0.curIndex = arg_4_4

	arg_4_0:UpdateView()
end

function var_0_0.UpdateView(arg_5_0)
	arg_5_0.contentTxt_.text = GetI18NText(arg_5_0:GetWordCfg(arg_5_0.data.id).content)

	arg_5_0.stateController:SetSelectedState(arg_5_0.data.role == 0 and "1" or "2")
	SetActive(arg_5_0.headGo_, arg_5_0.data.role == 1)

	if arg_5_0.curIndex == arg_5_0.index then
		arg_5_0.animator_:Play("ContenuUI_talkicon", 0, 0)
	end

	if arg_5_0.data.role == 0 then
		arg_5_0.myTxt_.text = GetI18NText(PlayerData:GetPlayerInfo().nick)
	elseif arg_5_0.data.role == 1 then
		local var_5_0 = HeroCfg[arg_5_0.data.heroId]

		arg_5_0.roleTxt_.text = GetI18NText(var_5_0.suffix)
		arg_5_0.headIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_5_0.cfg.hero_image_route)
	elseif arg_5_0.data.role == 2 then
		arg_5_0.roleTxt_.text = GetTips("ACTIVITY_INVITE_NPC1")
	elseif arg_5_0.data.role == 3 then
		arg_5_0.roleTxt_.text = GetTips("ACTIVITY_INVITE_NPC2")
	end
end

function var_0_0.GetWordCfg(arg_6_0, arg_6_1)
	if StoryWordCfg[arg_6_1] then
		return StoryWordCfg[arg_6_1]
	elseif StoryWordCfg2[arg_6_1] then
		return StoryWordCfg2[arg_6_1]
	else
		return StoryWordCfg3[arg_6_1]
	end
end

function var_0_0.OnEnter(arg_7_0)
	return
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	Object.Destroy(arg_9_0.gameObject_)
end

return var_0_0
