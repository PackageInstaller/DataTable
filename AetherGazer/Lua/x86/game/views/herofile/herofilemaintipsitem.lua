local var_0_0 = class("HeroFileMainTipsItem", ReduxView)

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

	arg_3_0.unlockStateController_ = arg_3_0.btnControllerEx_:GetController("unlock")
	arg_3_0.rewardItem_ = CommonItemView.New(arg_3_0.item_)
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 <= ArchiveData:GetTrustLevel(arg_5_2) then
		arg_5_0.unlockStateController_:SetSelectedState("unlock")
	else
		arg_5_0.unlockStateController_:SetSelectedState("lock")
	end

	arg_5_0.titleText_.text = ArchiveTools.GetTrustLvDes(arg_5_1)

	local var_5_0 = HeroTrustCfg.get_id_list_by_hero_id[arg_5_2][arg_5_1 - 1]

	if var_5_0 then
		local var_5_1 = HeroTrustCfg[var_5_0].reward_item_list[1]

		if var_5_1 then
			local var_5_2 = clone(ItemTemplateData)

			var_5_2.id = var_5_1[1]
			var_5_2.number = var_5_1[2]

			function var_5_2.clickFun()
				ShowPopItem(POP_ITEM, {
					var_5_2.id
				})
			end

			arg_5_0.rewardItem_:SetData(var_5_2)
			SetActive(arg_5_0.item_, true)
		else
			SetActive(arg_5_0.item_, false)
		end
	else
		SetActive(arg_5_0.item_, false)
	end
end

function var_0_0.Dispose(arg_7_0)
	if arg_7_0.rewardItem_ then
		arg_7_0.rewardItem_:Dispose()

		arg_7_0.rewardItem_ = nil
	end

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
