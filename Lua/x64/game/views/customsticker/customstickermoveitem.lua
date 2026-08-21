local var_0_0 = class("CustomStickerMoveItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.rectTransform_ = arg_1_1:GetComponent("RectTransform")

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.curDynamicGo_ = nil
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.mainBtn_, nil, function()
		if arg_4_0.click_ then
			arg_4_0.click_()
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.click_ = arg_6_2
	arg_6_0.ID_ = arg_6_1.id

	arg_6_0:DestroyDynamicGo()

	if arg_6_1.type == 1 then
		arg_6_0.staticImg_.spriteSync = "TextureConfig/Sticker/Sticker/" .. arg_6_1.resource
		arg_6_0.staticImg_.enabled = true
		arg_6_0.outlineRect_ = arg_6_0.staticImg_.gameObject:GetComponent("RectTransform")
	elseif arg_6_1.type == 2 then
		arg_6_0.curDynamicGo_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Sticker/Stickeritem_" .. arg_6_1.resource), arg_6_0.dynamicTrs_)
		arg_6_0.staticImg_.enabled = false
		arg_6_0.outlineRect_ = arg_6_0.curDynamicGo_:GetComponent("RectTransform")
	end
end

function var_0_0.DestroyDynamicGo(arg_7_0)
	if arg_7_0.curDynamicGo_ then
		Object.Destroy(arg_7_0.curDynamicGo_)

		arg_7_0.curDynamicGo_ = nil
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
