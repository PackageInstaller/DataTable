local var_0_0 = class("DormLinkGameSkillItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.stateController = ControllerUtil.GetController(arg_2_0.transform_, "item")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListenerScale(arg_4_0.illustrateBtn_, nil, function()
		JumpTools.OpenPageByJump("dormLinkGameItemTips", {
			itemID = arg_4_0.itemID
		})
	end)
	arg_4_0:AddBtnListenerScale(arg_4_0.useItemBtn_, nil, function()
		if arg_4_0.useItem then
			arg_4_0.useItem(arg_4_0.itemID)
		end
	end)
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.itemID = arg_7_1

	local var_7_0 = DormLinkGameData:GetMainActivityID()

	arg_7_0.iconImg_.sprite = DormLinkGameTools:GetDormLinkGameItemIcon(var_7_0, arg_7_1)

	if arg_7_2 then
		arg_7_0.stateController:SetSelectedState("lock")

		arg_7_0.nameText_.text = ActivityLinkGameGoodsCfg[arg_7_1].name
	else
		if ActivityLinkGameGoodsCfg[arg_7_0.itemID].coin_num > DormLinkGameData:GetCurCnaUseTokenNum() then
			arg_7_0.stateController:SetSelectedState("none")
		else
			arg_7_0.stateController:SetSelectedState("normal")
		end

		local var_7_1 = DormLinkGameData:GetMainActivityID()
		local var_7_2 = DormLinkGameTools:GetCurrencyID(var_7_1)

		arg_7_0.neediconImg_.sprite = ItemTools.getItemSprite(var_7_2)
		arg_7_0.neednumtextText_.text = ActivityLinkGameGoodsCfg[arg_7_1].coin_num
	end
end

function var_0_0.UseItem(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0.useItem = arg_8_1
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
