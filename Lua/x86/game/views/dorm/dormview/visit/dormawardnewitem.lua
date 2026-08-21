local var_0_0 = class("DormAwardNewItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.item = CommonItemView.New(arg_2_0.commonItem_)
	arg_2_0.commonPortrait_ = CommonHeadPortrait.New(arg_2_0.headItem_)

	arg_2_0.commonPortrait_:RegisteClickCallback(function()
		local var_3_0 = arg_2_0:GetUserID()

		if var_3_0 then
			ForeignInfoAction:TryToCheckForeignDetailInfo(var_3_0)
		end
	end)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.GetUserID(arg_5_0)
	if arg_5_0.data then
		return arg_5_0.data.user.id
	end

	return nil
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	arg_6_0.data = arg_6_1

	if arg_6_1.name then
		arg_6_0.nickName.text = arg_6_1.user.name
	else
		arg_6_0.nickName.text = ""
	end

	arg_6_0.commonPortrait_:RenderHead(arg_6_1.user.icon)
	arg_6_0.commonPortrait_:RenderFrame(arg_6_1.user.icon_frame)
	arg_6_0.item:SetData({
		id = arg_6_1.id,
		number = arg_6_1.num,
		clickFun = function(arg_7_0)
			ShowPopItem(POP_ITEM, {
				arg_7_0.id
			})
		end
	})
end

function var_0_0.Dispose(arg_8_0)
	if arg_8_0.item then
		arg_8_0.item:Dispose()

		arg_8_0.item = nil
	end

	if arg_8_0.commonPortrait_ then
		arg_8_0.commonPortrait_:Dispose()
	end

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
