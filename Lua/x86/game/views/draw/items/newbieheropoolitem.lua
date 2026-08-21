local var_0_0 = class("NewBieHeroPoolItem", ReduxView)

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
	arg_4_0:AddBtnListener(arg_4_0.detailBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			isDraw = true,
			hid = arg_4_0.id_
		})
	end)
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.index_ = arg_7_1
	arg_7_0.id_ = arg_7_2
	arg_7_0.cfg_ = HeroCfg[arg_7_0.id_]

	arg_7_0:UpdateView()
end

function var_0_0.UpdateView(arg_8_0)
	local var_8_0 = HeroCfg[arg_8_0.id_]

	if var_8_0 == nil then
		return
	end

	arg_8_0.nameText_.text = GetI18NText(var_8_0.name)

	if arg_8_0.suffixText_ then
		arg_8_0.suffixText_.text = GetI18NText(var_8_0.suffix)
	else
		arg_8_0.nameText_.text = HeroTools.GetHeroFullName(arg_8_0.id_)
	end

	arg_8_0.campIcon_.sprite = HeroTools.GetHeroRaceIcon(arg_8_0.id_)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:AddEventListeners()
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.data_ = nil

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
