local var_0_0 = class("SkuldSystemPhotoViewItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller_ = arg_3_0.controllerEx_:GetController("lock")
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = GameSetting["skuld_photo" .. arg_4_0.index_].value

	arg_4_0.photoImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Skuld/Skuld_Photos/" .. var_4_0[1])
	arg_4_0.nameText_.text = GetTips(var_4_0[2])

	if SkuldSystemData:GetLevelIDIsClear(var_4_0[5]) then
		arg_4_0.controller_:SetSelectedState("false")
	else
		arg_4_0.controller_:SetSelectedState("true")
	end

	local var_4_1 = RedPointConst.SKULD_SYSTEM_PHOTO .. arg_4_0.index_

	manager.redPoint:bindUIandKey(arg_4_0.transform_, var_4_1)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		local var_6_0 = GameSetting["skuld_photo" .. arg_5_0.index_].value

		if SkuldSystemData:GetLevelIDIsClear(var_6_0[5]) then
			SkuldSystemAction.SendMark("PhotoClick" .. arg_5_0.index_)

			local var_6_1 = RedPointConst.SKULD_SYSTEM_PHOTO .. arg_5_0.index_

			manager.redPoint:setTip(var_6_1, 0)
			JumpTools.OpenPageByJump("skuldSystemPhotoPopView", {
				index = arg_5_0.index_
			})
		else
			ShowTips(var_6_0[4])
		end
	end)
end

function var_0_0.OnExit(arg_7_0)
	local var_7_0 = RedPointConst.SKULD_SYSTEM_PHOTO .. arg_7_0.index_

	manager.redPoint:unbindUIandKey(arg_7_0.transform_, var_7_0)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
