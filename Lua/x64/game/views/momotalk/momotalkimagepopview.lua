local var_0_0 = class("MomoTalkImagePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Momotalk/MomotalkImagePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	if arg_3_0.controller_ then
		arg_3_0.stateController_ = arg_3_0.controller_:GetController("state")
	end

	arg_3_0:AddListeners()
end

function var_0_0.AddListeners(arg_4_0)
	if arg_4_0.fullScreenBtn_ then
		arg_4_0:AddBtnListener(arg_4_0.fullScreenBtn_, nil, function()
			arg_4_0:Back()
		end)
	end
end

function var_0_0.OnEnter(arg_6_0)
	local var_6_0 = arg_6_0.params_ or {}

	arg_6_0:RefreshImage(var_6_0.contentID)
end

function var_0_0.RefreshImage(arg_7_0, arg_7_1)
	local var_7_0 = ChatContentCfg[arg_7_1 or 0]
	local var_7_1 = (var_7_0 and var_7_0.type or nil) == MomoTalkConst.MSG_TYPE.STICKER
	local var_7_2 = var_7_1 and "face" or "image"
	local var_7_3 = var_7_1 and arg_7_0.faceImg_ or arg_7_0.normalImg_
	local var_7_4 = MomoTalkTools.GetImageSpritePath(var_7_0)

	if arg_7_0.stateController_ then
		arg_7_0.stateController_:SetSelectedState(var_7_2)
	end

	if var_7_3 then
		var_7_3.sprite = var_7_4 and pureGetSpriteWithoutAtlas(var_7_4) or nil
	end
end

return var_0_0
