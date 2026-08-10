local var_0_0 = class("NewHeroArchiveHerofavorItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.index = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.favorController = ControllerUtil.GetController(arg_3_0.transform_, "favorability")
end

function var_0_0.OnTop(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.data = arg_5_1
	arg_5_0.id = arg_5_2
	arg_5_0.index = arg_5_3

	arg_5_0:RefreshUI()
end

function var_0_0.ResetData(arg_6_0)
	arg_6_0.data = nil
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1)
	if arg_7_0.data == nil then
		return
	end

	local var_7_0 = ArchiveData:GetTrustLevel(arg_7_0.id)

	arg_7_0.roleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Itemshead/" .. arg_7_0.id)

	if var_7_0 > 0 then
		arg_7_0.favorController:SetSelectedState("3")

		if arg_7_0.favorExText_ then
			arg_7_0.favorExText_.text = ArchiveTools.GetTrustLvDes(var_7_0)
		else
			arg_7_0.favorText_.text = ArchiveTools.GetTrustLvDes(var_7_0)
		end
	else
		if not arg_7_1 then
			arg_7_0.favorController:SetSelectedState("1")
		else
			arg_7_0.favorController:SetSelectedState("2")
		end

		if arg_7_0.favorExText_ then
			arg_7_0.favorExText_.text = string.format(GetTips("HERO_HEART_CHAIN_LOVE_TIP"), arg_7_0.data.lv)
		elseif arg_7_1 then
			arg_7_0.favorText_.text = string.format(GetTips("HERO_HEART_CHAIN_LOVE_TIP"), arg_7_0.data.lv)
		else
			arg_7_0.favorText_.text = "Lv." .. arg_7_0.data.lv
		end
	end

	if not arg_7_1 and arg_7_0.index > 1 then
		SetActive(arg_7_0.gameObject_, false)
	else
		SetActive(arg_7_0.gameObject_, true)
	end

	if arg_7_0.nameText_ then
		if arg_7_1 then
			arg_7_0.nameText_.text = HeroCfg[arg_7_0.id].name
		else
			arg_7_0.nameText_.text = HeroTools.GetHeroName(arg_7_0.id)
		end
	end
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
