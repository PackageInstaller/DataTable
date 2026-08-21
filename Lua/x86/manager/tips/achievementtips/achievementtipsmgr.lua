local var_0_0 = class("AchievementTipsMgr")

function var_0_0.Ctor(arg_1_0)
	arg_1_0:InitData()
end

function var_0_0.InitData(arg_2_0)
	arg_2_0.achievementList_ = {}
	arg_2_0.fliterTypeList_ = {}
	arg_2_0.fliterList_ = {}
	arg_2_0.canShow_ = true
end

function var_0_0.FliteAchievementType(arg_3_0, arg_3_1)
	arg_3_0.fliterTypeList_ = arg_3_1

	if #arg_3_1 <= 0 then
		table.insertto(arg_3_0.achievementList_, arg_3_0.fliterList_)

		arg_3_0.fliterList_ = {}
	end

	arg_3_0:SetShowFlag(true)
end

function var_0_0.AddAchievementID(arg_4_0, arg_4_1)
	local var_4_0 = AchievementCfg[arg_4_1].type_id

	if #arg_4_0.fliterTypeList_ > 0 and not table.keyof(arg_4_0.fliterTypeList_, var_4_0) then
		table.insert(arg_4_0.fliterList_, arg_4_1)
	else
		table.insert(arg_4_0.achievementList_, arg_4_1)
	end

	arg_4_0:ShowAchievementTips()
end

function var_0_0.SetShowFlag(arg_5_0, arg_5_1)
	arg_5_0.canShow_ = arg_5_1

	if arg_5_1 and arg_5_0.timer_ == nil then
		arg_5_0:ShowAchievementTips()
	end
end

function var_0_0.ShowAchievementTips(arg_6_0)
	if arg_6_0.timer_ then
		return
	end

	if #arg_6_0.achievementList_ > 0 then
		if arg_6_0.canShow_ == false then
			return
		end

		arg_6_0.isRuning_ = true

		local var_6_0 = arg_6_0.achievementList_[1]
		local var_6_1 = AchievementCfg[var_6_0]

		if arg_6_0.gameObject_ == nil then
			arg_6_0:InitUI()
		end

		arg_6_0.textName_.text = var_6_1.name

		arg_6_0.typeController_:SetSelectedState(var_6_1.type_id)
		SetActive(arg_6_0.gameObject_, true)
		table.remove(arg_6_0.achievementList_, 1)

		arg_6_0.timer_ = Timer.New(function()
			SetActive(arg_6_0.gameObject_, false)

			arg_6_0.timer_ = nil

			arg_6_0:ShowAchievementTips()
		end, 2, 1)

		arg_6_0.timer_:Start()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.rectItem_)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.textRect_)
	end
end

function var_0_0.InitUI(arg_8_0)
	local var_8_0 = GameObject.Find("UICamera_DontDestroy/Canvas/UIMessage")

	arg_8_0.gameObject_ = GameObject.Instantiate(Asset.Load("Widget/Common/Pop/AchievementTipsUI"), var_8_0.transform)
	arg_8_0.transform_ = arg_8_0.gameObject_.transform

	ComponentBinder.GetInstance():BindCfgUI(arg_8_0, arg_8_0.gameObject_)

	arg_8_0.typeController_ = arg_8_0.controllerEx_:GetController("icon")
end

function var_0_0.Hide(arg_9_0, arg_9_1)
	if arg_9_0.gameObject_ == nil then
		return
	end

	SetActive(arg_9_0.goPanel_, not arg_9_1)
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end

	arg_10_0.transform_ = nil

	Object.Destroy(arg_10_0.gameObject_)

	arg_10_0.gameObject_ = nil
end

return var_0_0
