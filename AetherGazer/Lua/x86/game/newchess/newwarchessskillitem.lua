local var_0_0 = class("NewWarChessSkillItem", ReduxView)

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
			manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_NEW_DICESKILL .. arg_4_0.data_.skillID, 0)
			arg_4_0.clickHandler_(arg_4_0.data_.skillID)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.data_ = arg_6_1
	arg_6_0.cfg_ = NewWarChessDiceSkillCfg[arg_6_0.data_.skillID]
	arg_6_0.leftUseLimit_ = arg_6_0.data_.useLimit
	arg_6_0.totalUseLimit_ = arg_6_0.cfg_.use_limit
	arg_6_0.name_ = arg_6_0.cfg_.name

	arg_6_0:RefreshUI()

	arg_6_0.btn_.interactable = false
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.title_.text = arg_7_0.name_
	arg_7_0.iconImage_.sprite = getSprite("Atlas/NewWarChess", arg_7_0.cfg_.icon)
	arg_7_0.useText_.text = arg_7_0.leftUseLimit_ .. "/" .. arg_7_0.totalUseLimit_
end

function var_0_0.SetClickCallBack(arg_8_0, arg_8_1)
	arg_8_0.clickHandler_ = arg_8_1
	arg_8_0.btn_.interactable = true
end

function var_0_0.BindSkillRedPoint(arg_9_0)
	arg_9_0.enableRed_ = true

	if arg_9_0.data_ then
		manager.redPoint:bindUIandKey(arg_9_0.transform_, RedPointConst.NEW_WARCHESS_NEW_DICESKILL .. arg_9_0.data_.skillID)
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.clickHandler_ = nil

	if arg_10_0.enableRed_ and arg_10_0.data_ then
		manager.redPoint:unbindUIandKey(arg_10_0.transform_, RedPointConst.NEW_WARCHESS_NEW_DICESKILL .. arg_10_0.data_.skillID)
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
