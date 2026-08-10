local var_0_0 = class("RogueCardGameCardBuffStyleItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.lookTipsCon_ = arg_2_0.controller_:GetController("looktips")
	arg_2_0.selectCon_ = arg_2_0.controller_:GetController("select")
	arg_2_0.qualityCon_ = arg_2_0.controller_:GetController("quality")
	arg_2_0.lockCon_ = arg_2_0.controller_:GetController("lock")
	arg_2_0.newCon_ = arg_2_0.controller_:GetController("new")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		manager.redPoint:SetRedPointIndependent(arg_4_0.transform_, false)
		RogueCardGameData:SetIllustratedRedPoint_Enhance(arg_4_0.id)

		if arg_4_0.clickHandle_ then
			arg_4_0.selectCon_:SetSelectedIndex(1)
			arg_4_0.clickHandle_(arg_4_0.id, arg_4_0.index)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.btn_2, nil, function()
		if arg_4_0.clickHandle_ then
			arg_4_0.selectCon_:SetSelectedIndex(1)
			arg_4_0.clickHandle_(arg_4_0.id, arg_4_0.index)
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.id = arg_7_1
	arg_7_0.index = arg_7_2

	if RogueCardGameTools.IsUnlockCardBuff(arg_7_0.id) then
		local var_7_0 = RogueCardEnhanceCfg[arg_7_1]

		arg_7_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_JokerCard/itembg/" .. var_7_0.pic)

		arg_7_0.lockCon_:SetSelectedIndex(1)
		manager.redPoint:SetRedPointIndependent(arg_7_0.transform_, RogueCardGameData:GetIllustratedRedPoint_Enhance(arg_7_1))
	else
		arg_7_0.lockCon_:SetSelectedIndex(0)
		manager.redPoint:SetRedPointIndependent(arg_7_0.transform_, false)
	end
end

function var_0_0.SetSelected(arg_8_0, arg_8_1)
	arg_8_0.selectCon_:SetSelectedIndex(arg_8_0.index == arg_8_1 and 1 or 0)
end

function var_0_0.SetClickHandle(arg_9_0, arg_9_1)
	arg_9_0.clickHandle_ = arg_9_1
end

function var_0_0.Show(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
