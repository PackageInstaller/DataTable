local var_0_0 = class("NewWarChessBuffItem", ReduxView)

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
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickHandler_ then
			arg_4_0.clickHandler_(arg_4_0.index_, arg_4_0.cfg_.name, NewChessTools.GetBuffDes(arg_4_0.buffEntity_))
		else
			print("buffItem self.clickHandler_为空！！！！")
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.index_ = arg_6_1
	arg_6_0.buffEntity_ = arg_6_3
	arg_6_0.cfg_ = NewWarChessBuffPoolCfg[arg_6_0.buffEntity_.buffPoolID]

	arg_6_0:RefreshUI()

	if arg_6_1 == arg_6_2 then
		SetActive(arg_6_0.arrowGo_, true)
	else
		SetActive(arg_6_0.arrowGo_, false)
	end

	arg_6_0.btn_.interactable = false
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.nameText_.text = arg_7_0.cfg_.name
	arg_7_0.icon_.sprite = getSprite("Atlas/NewWarChess", arg_7_0.cfg_.icon)

	if arg_7_0.buffEntity_.CurRemainRound and arg_7_0.buffEntity_.CurRemainRound > 0 then
		SetActive(arg_7_0.remainGo_, true)

		arg_7_0.remainText_.text = arg_7_0.buffEntity_.CurRemainRound
	else
		SetActive(arg_7_0.remainGo_, false)
	end

	if arg_7_0.buffEntity_.CurUpdateRound then
		SetActive(arg_7_0.updateGo_, true)

		arg_7_0.updateText_.text = arg_7_0.buffEntity_.CurUpdateRound
		arg_7_0.updateImage_.fillAmount = arg_7_0.buffEntity_.CurUpdateRound / arg_7_0.buffEntity_.UpdateRound
	else
		SetActive(arg_7_0.updateGo_, false)
	end
end

function var_0_0.SetClickCallBack(arg_8_0, arg_8_1)
	arg_8_0.clickHandler_ = arg_8_1
	arg_8_0.btn_.interactable = true
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.clickHandler_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
