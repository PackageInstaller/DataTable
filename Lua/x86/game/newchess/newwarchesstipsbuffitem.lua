local var_0_0 = class("NewWarChessTipsBuffItem")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_3_0, arg_3_0.gameObject_)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.index_ = arg_4_1
	arg_4_0.buffEntity_ = arg_4_3
	arg_4_0.cfg_ = NewWarChessBuffPoolCfg[arg_4_0.buffEntity_.buffPoolID]

	arg_4_0:RefreshUI()

	if arg_4_1 == arg_4_2 then
		SetActive(arg_4_0.arrowGo_, true)
	else
		SetActive(arg_4_0.arrowGo_, false)
	end
end

function var_0_0.RefreshUI(arg_5_0)
	arg_5_0.nameText_.text = arg_5_0.cfg_.name
	arg_5_0.icon_.sprite = getSprite("Atlas/NewWarChess", arg_5_0.cfg_.icon)

	if arg_5_0.buffEntity_.CurRemainRound and arg_5_0.buffEntity_.CurRemainRound > 0 then
		SetActive(arg_5_0.remainGo_, true)

		arg_5_0.remainText_.text = arg_5_0.buffEntity_.CurRemainRound
	else
		SetActive(arg_5_0.remainGo_, false)
	end

	if arg_5_0.buffEntity_.CurUpdateRound then
		SetActive(arg_5_0.updateGo_, true)

		arg_5_0.updateText_.text = arg_5_0.buffEntity_.CurUpdateRound
		arg_5_0.updateImage_.fillAmount = arg_5_0.buffEntity_.CurUpdateRound / arg_5_0.buffEntity_.UpdateRound
	else
		SetActive(arg_5_0.updateGo_, false)
	end
end

function var_0_0.Dispose(arg_6_0)
	return
end

return var_0_0
