local var_0_0 = class("HeroChipItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		manager.notify:Invoke(ON_CLICK_HEROCHIP_ITEM, arg_2_0.chipID_)
	end)
end

function var_0_0.SetChipID(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.chipID_ = arg_4_1
	arg_4_0.curHeroId_ = arg_4_2
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.gameObject_.name = arg_5_0.chipID_
	arg_5_0.curHeroId_ = arg_5_2

	local var_5_0 = ChipCfg[arg_5_0.chipID_]

	arg_5_0.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", var_5_0.picture_id)
	arg_5_0.name_.text = GetI18NText(var_5_0.suit_name)

	local var_5_1 = ChipData:GetUnlockHeroChipIDList()

	SetActive(arg_5_0.lockGo_, table.keyof(var_5_1, arg_5_0.chipID_) == nil)
	SetActive(arg_5_0.useGo_, ChipData:GetHeroChipIsEnableByChipId(arg_5_0.chipID_))
	SetActive(arg_5_0.selectGo_, arg_5_0.chipID_ == arg_5_1)
	SetActive(arg_5_0.prohibitGo_, false)
	arg_5_0:BindRedPoint()
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:UnbindRedPoint()
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.BindRedPoint(arg_7_0)
	manager.redPoint:bindUIandKey(arg_7_0.notice_, string.format("%s_%s", arg_7_0.curHeroId_, arg_7_0.chipID_), {
		x = 0,
		y = 0
	})
end

function var_0_0.UnbindRedPoint(arg_8_0)
	manager.redPoint:unbindUIandKey(arg_8_0.notice_)
end

return var_0_0
