local var_0_0 = class("ActivityRaceAffixItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.levelController_ = ControllerUtil.GetController(arg_2_0.transform_, "level")
	arg_2_0.unlockController_ = ControllerUtil.GetController(arg_2_0.transform_, "unlock")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	if arg_4_0.btn_ then
		arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
			if arg_4_0.selectCallBack_ then
				arg_4_0.selectCallBack_(arg_4_0.index_, arg_4_0.affixID_, arg_4_0.affixLv_)
			end
		end)
	end
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0.index_ = arg_6_1
	arg_6_0.affixID_ = arg_6_2
	arg_6_0.affixLv_ = arg_6_3
	arg_6_0.unlock_ = arg_6_4

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshAffixImage()

	if arg_7_0.affixLv_ ~= nil then
		arg_7_0.levelController_:SetSelectedState(arg_7_0.affixLv_)
	else
		arg_7_0.levelController_:SetSelectedState(0)
	end

	arg_7_0.unlockController_:SetSelectedState(tostring(arg_7_0.unlock_))
end

function var_0_0.RefreshAffixImage(arg_8_0)
	if arg_8_0.affixID_ then
		local var_8_0 = AffixTypeCfg[arg_8_0.affixID_]
		local var_8_1 = PublicBuffCfg[var_8_0.affix_buff_id].icon

		if var_8_1 == "" then
			-- block empty
		end

		arg_8_0.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. var_8_1)
		arg_8_0.name_.text = GetI18NText(var_8_0.name)
	end
end

function var_0_0.RegistSelectCallBack(arg_9_0, arg_9_1)
	arg_9_0.selectCallBack_ = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.selectCallBack_ = nil

	Object.Destroy(arg_10_0.gameObject_)

	arg_10_0.gameObject_ = nil
	arg_10_0.transform_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.SetActive(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

return var_0_0
