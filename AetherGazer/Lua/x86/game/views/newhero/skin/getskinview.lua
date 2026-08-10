local var_0_0 = class("GetSkinView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Obtain/Skin/SkinAUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddListeners()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		if arg_5_0.playableDirector_.time >= arg_5_0:GetTimeLineEndTime() then
			arg_5_0:Back()
			arg_5_0.callback_()
		else
			arg_5_0.playableDirector_.time = arg_5_0:GetTimeLineEndTime()
		end
	end)
end

function var_0_0.GetTimeLineEndTime(arg_7_0)
	return 6.27
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.skinID_ = arg_8_0.params_.skinID

	local var_8_0 = SkinCfg[arg_8_0.skinID_]

	arg_8_0.portrait_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. var_8_0.picture_id)
	arg_8_0.name_.text = ItemTools.getItemName(arg_8_0.skinID_)

	arg_8_0.playableDirector_:Evaluate()
	arg_8_0.playableDirector_:Play()

	arg_8_0.callback_ = arg_8_0.params_.callback

	SetActive(arg_8_0.gameObject_, true)
end

function var_0_0.OnExit(arg_9_0)
	if not (arg_9_0.playableDirector_.time >= arg_9_0:GetTimeLineEndTime()) then
		arg_9_0.playableDirector_.time = arg_9_0.playableDirector_.duration
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
