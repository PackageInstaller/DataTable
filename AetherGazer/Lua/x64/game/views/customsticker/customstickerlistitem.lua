local var_0_0 = class("CustomStickerListItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = arg_3_0.mainControllerEx_:GetController("select")
	arg_3_0.useController_ = arg_3_0.mainControllerEx_:GetController("use")
	arg_3_0.nameController_ = arg_3_0.mainControllerEx_:GetController("name")
	arg_3_0.lockController_ = arg_3_0.mainControllerEx_:GetController("lock")
	arg_3_0.collectController_ = arg_3_0.mainControllerEx_:GetController("collect")
	arg_3_0.pageController_ = arg_3_0.mainControllerEx_:GetController("page")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.mainBtn_, nil, function()
		if arg_4_0.click_ then
			arg_4_0.click_()
		end

		if arg_4_0.Tag_ and not arg_4_0.Lock_ and not getData("PlayerCustomStickerTriggered", "StickerItem_" .. arg_4_0.ID_) and manager.redPoint:getTipValue(RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. arg_4_0.ID_) == 1 then
			saveData("PlayerCustomStickerTriggered", "StickerItem_" .. arg_4_0.ID_, 1)
			manager.redPoint:setTip(RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. arg_4_0.ID_, 0)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7, arg_6_8, arg_6_9)
	arg_6_0.click_ = arg_6_7

	if arg_6_8 then
		if arg_6_0.Tag_ then
			manager.redPoint:unbindUIandKey(arg_6_0.transform_, RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. arg_6_0.ID_)
		end

		manager.redPoint:bindUIandKey(arg_6_0.transform_, RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. arg_6_1.id)
	end

	arg_6_0.Tag_ = arg_6_8
	arg_6_0.ID_ = arg_6_1.id
	arg_6_0.Lock_ = arg_6_5

	arg_6_0.selectController_:SetSelectedState(arg_6_2 and "state1" or "state0")
	arg_6_0.useController_:SetSelectedState(arg_6_3 and "state1" or "state0")
	arg_6_0.nameController_:SetSelectedState(arg_6_4 and "state1" or "state0")
	arg_6_0.lockController_:SetSelectedState(arg_6_5 and "state1" or "state0")
	arg_6_0.collectController_:SetSelectedState(arg_6_6 and "state1" or "state0")

	if arg_6_1.item_type == 4 then
		arg_6_0.staticImg_.spriteAsync = "TextureConfig/Sticker/Background_m/Stickerbg_m_" .. arg_6_1.resource
	elseif arg_6_1.item_type == 5 then
		arg_6_0.staticImg_.spriteAsync = "TextureConfig/Sticker/Sticker_s/" .. arg_6_1.resource
	elseif arg_6_1.item_type == 6 then
		arg_6_0.staticImg_.spriteAsync = "TextureConfig/Sticker/Foreground_m/Stickerfg_m_" .. arg_6_1.resource
	end

	if arg_6_4 then
		arg_6_0.nameText_.text = ItemTools.getItemName(arg_6_1.id)
	end

	if arg_6_0.pageController_ then
		if arg_6_9 and arg_6_9 ~= 0 then
			arg_6_0.pageController_:SetSelectedState("state1")

			arg_6_0.pageText_.text = arg_6_9
		else
			arg_6_0.pageController_:SetSelectedState("state0")
		end
	end
end

function var_0_0.Select(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedState(arg_7_1 and "state1" or "state0")
end

function var_0_0.SetUse(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.useController_:SetSelectedState(arg_8_1 and "state1" or "state0")

	if arg_8_0.pageController_ then
		if arg_8_2 and arg_8_2 ~= 0 then
			arg_8_0.pageController_:SetSelectedState("state1")

			arg_8_0.pageText_.text = arg_8_2
		else
			arg_8_0.pageController_:SetSelectedState("state0")
		end
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)

	if arg_9_0.Tag_ then
		manager.redPoint:unbindUIandKey(arg_9_0.transform_, RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. arg_9_0.ID_)
	end
end

return var_0_0
