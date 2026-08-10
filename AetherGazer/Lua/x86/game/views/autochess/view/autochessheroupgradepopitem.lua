local var_0_0 = class("AutoChessHeroUpgradePopItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()

	arg_1_0.isSelect_ = false
	arg_1_0.isNeedClick_ = true
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController("select")
	arg_3_0.gradeController_ = arg_3_0.controllerEx_:GetController("grade")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickCb then
			arg_4_0.clickCb(arg_4_0)
		end
	end)
	TerminologyTools.AddTerminologyHandler(arg_4_0, arg_4_0.buffDescText_, nil, handler(arg_4_0, arg_4_0.TerminologyDefaultHandler))
end

function var_0_0.TerminologyDefaultHandler(arg_6_0, arg_6_1)
	if #arg_6_1 <= 0 or not arg_6_0.isSelect_ and arg_6_0.isNeedClick_ then
		if arg_6_0.clickCb then
			arg_6_0.clickCb(arg_6_0)
		end
	else
		TerminologyTools.TerminologyDefaultHandler(arg_6_1)
	end
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	arg_7_0.isAttr_ = arg_7_1
	arg_7_0.index_ = arg_7_2
	arg_7_0.gameType_ = AutoChessData:GetCurGameType()

	arg_7_0.gradeController_:SetSelectedIndex(arg_7_4 - 1)

	if arg_7_1 then
		arg_7_0.nowAttkText_.text = arg_7_5.attributeData.atk
		arg_7_0.nowHPText_.text = arg_7_5.attributeData.hp
		arg_7_0.addAttkText_.text = arg_7_3.atk
		arg_7_0.addHPText_.text = arg_7_3.hp
	else
		local var_7_0 = AutoChessBuffCfg[tonumber(arg_7_3)]

		if var_7_0 then
			AutoChessTools.GetChessBuffDesc(AutoChessData:GetPlayerChessData(arg_7_0.gameType_), tonumber(arg_7_3), arg_7_0.buffDescText_)

			arg_7_0.skillIcon_.sprite = AutoChessTools.GetBuffIcon(var_7_0.icon)
		end
	end
end

function var_0_0.SetClickCb(arg_8_0, arg_8_1)
	arg_8_0.clickCb = arg_8_1
end

function var_0_0.SetNotClick(arg_9_0, arg_9_1)
	arg_9_0.isNeedClick_ = arg_9_1
end

function var_0_0.SetSelect(arg_10_0, arg_10_1)
	arg_10_0.isSelect_ = arg_10_1

	arg_10_0.selectController_:SetSelectedState(tostring(arg_10_1))
end

return var_0_0
