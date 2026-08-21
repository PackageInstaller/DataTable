local var_0_0 = class("IlluIllustrationItem", ReduxView)

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

	arg_3_0.itemiconImg_.cacheLimit = 3
	arg_3_0.roleiconImg_.cacheLimit = 3
	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "conName")
	arg_3_0.giftCon_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "gift")
	arg_3_0.haveCon_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "have")
	arg_3_0.selectCon_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "select")
	arg_3_0.multitCon_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "multi")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.id_ = arg_4_1
	arg_4_0.type_ = CollectPictureCfg[arg_4_1].type
	arg_4_0.index_ = arg_4_3

	if arg_4_0.type_ == 1 then
		arg_4_0.controller_:SetSelectedState("item")

		arg_4_0.itemiconImg_.spriteSync = SpritePathCfg.CollectPictureSmall.path .. CollectPictureCfg[arg_4_1].picture
	else
		arg_4_0.controller_:SetSelectedState("role")

		arg_4_0.roleiconImg_.spriteSync = SpritePathCfg.CollectPictureSmall.path .. CollectPictureCfg[arg_4_1].picture
	end

	arg_4_0.have_ = IllustratedData:GetIllustrationInfo()[arg_4_0.id_]

	if arg_4_0.have_ then
		if not arg_4_2 then
			local var_4_0 = CollectPictureCfg.get_id_list_by_group_id[CollectPictureCfg[arg_4_0.id_].group_id]
			local var_4_1 = 1

			for iter_4_0, iter_4_1 in ipairs(var_4_0) do
				local var_4_2 = IllustratedData:GetIllustrationInfo()[iter_4_1]

				if var_4_2 and var_4_2.is_receive == 0 then
					var_4_1 = 0

					break
				end
			end

			if var_4_1 == 1 then
				arg_4_0.giftCon_:SetSelectedState("notShow")
			else
				arg_4_0.giftCon_:SetSelectedState("show")
			end
		else
			arg_4_0.giftCon_:SetSelectedState("notShow")
		end

		arg_4_0.haveCon_:SetSelectedState("1")

		arg_4_0.itemBtn_.interactable = true
	else
		arg_4_0.haveCon_:SetSelectedState("0")

		arg_4_0.itemBtn_.interactable = false
	end

	local var_4_3 = CollectPictureCfg[arg_4_0.id_]

	arg_4_0.nameText_.text = GetI18NText(var_4_3.name)

	local var_4_4 = CollectPictureCfg.get_id_list_by_group_id[var_4_3.group_id] or {}

	arg_4_0.multitCon_:SetSelectedState(#var_4_4 > 1 and not arg_4_2 and "true" or "false")
end

function var_0_0.SetSelect(arg_5_0, arg_5_1)
	arg_5_0.selectCon_:SetSelectedState(arg_5_1 and "true" or "false")
end

function var_0_0.RegisterGiftFunc(arg_6_0, arg_6_1)
	arg_6_0.registerGiftFunc_ = arg_6_1
end

function var_0_0.RegisterItemFunc(arg_7_0, arg_7_1)
	arg_7_0.itemClickFunc_ = arg_7_1
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.itemBtn_, nil, function()
		if arg_8_0.itemClickFunc_ then
			arg_8_0.itemClickFunc_(arg_8_0.id_, arg_8_0.index_)
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.receiveBtn_, nil, function()
		if arg_8_0.registerGiftFunc_ then
			arg_8_0.registerGiftFunc_()
		end
	end)
end

function var_0_0.Show(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
