local var_0_0 = class("NewHeroWallPaperItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.roleImg_.immediate = true
	arg_3_0.roleController_ = ControllerUtil.GetController(arg_3_0.transform_, "role")

	arg_3_0:AddUIListener()
end

function var_0_0.OnTop(arg_4_0)
	return
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		if arg_5_0.clickCallBack_ then
			SDKTools.SendMessageToSDK("chain_story_picture_change", {
				chain_story_picture_id = arg_5_0.roleName_.text,
				record_id = arg_5_0.data_.id
			})
			arg_5_0.clickCallBack_(arg_5_0.id_, arg_5_0.type_)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		ShowTips(arg_5_0.lockTips_)
	end)
end

function var_0_0.SetClickFunc(arg_8_0, arg_8_1)
	arg_8_0.clickCallBack_ = arg_8_1
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.data_ = arg_9_1
	arg_9_0.index_ = arg_9_2
	arg_9_0.id_ = arg_9_1.id
	arg_9_0.type_ = arg_9_1.type
	arg_9_0.archiveID_ = arg_9_3

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = ArchiveData:GetSelectPicture(arg_10_0.archiveID_)

	if var_10_0.id == arg_10_0.id_ then
		arg_10_0.roleController_:SetSelectedState("yes")
	elseif var_10_0.id ~= arg_10_0.id_ then
		arg_10_0.roleController_:SetSelectedState("no")
	end

	local var_10_1 = ArchiveTools.CheckWallPaperIsUnlock(arg_10_0.data_)

	arg_10_0.lockPicGo_:SetActive(false)

	if not var_10_1 then
		arg_10_0.roleController_:SetSelectedState("lock")

		if arg_10_0.type_ == 3 then
			arg_10_0.lockPicGo_:SetActive(true)
		else
			arg_10_0.lockPicGo_:SetActive(false)
		end
	end

	if arg_10_0.type_ == 1 then
		arg_10_0.roleImg_.spriteSync = "TextureConfig/Character/Icon/" .. arg_10_0.id_
		arg_10_0.lockText_.text = GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_HERO")
		arg_10_0.roleName_.text = HeroCfg[arg_10_0.data_.id].name
		arg_10_0.lockTips_ = string.format(GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_HERO_NAME"), GetI18NText(HeroCfg[arg_10_0.data_.id].name))
	elseif arg_10_0.type_ == 2 then
		arg_10_0.roleImg_.spriteSync = "TextureConfig/Character/Icon/" .. arg_10_0.id_
		arg_10_0.lockText_.text = GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_SKIN")
		arg_10_0.roleName_.text = SkinCfg[arg_10_0.data_.id].name
		arg_10_0.lockTips_ = string.format(GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_SKIN_NAME"), GetI18NText(SkinCfg[arg_10_0.data_.id].name))
	elseif arg_10_0.type_ == 3 then
		local var_10_2 = CollectPictureCfg[arg_10_0.id_].picture

		arg_10_0.roleImg_.spriteSync = "TextureConfig/IllustratedHandbook/Portrait/" .. var_10_2
		arg_10_0.lockText_.text = GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_PICTURE")
		arg_10_0.roleName_.text = CollectPictureCfg[arg_10_0.data_.id].name
		arg_10_0.lockTips_ = string.format(GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_PICTURE_NAME"), GetI18NText(CollectPictureCfg[arg_10_0.data_.id].name))
	end
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
