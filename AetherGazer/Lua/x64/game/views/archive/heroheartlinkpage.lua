local var_0_0 = class("HeroHeartLinkPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.itemList_ = {}
	arg_2_0.dataList_ = {}
	arg_2_0.heartLinkVoice_ = {
		HeroVoiceCfg.get_id_list_by_file.trust1[1],
		HeroVoiceCfg.get_id_list_by_file.trust2[1],
		HeroVoiceCfg.get_id_list_by_file.trust3[1],
		HeroVoiceCfg.get_id_list_by_file.trust4[1],
		HeroVoiceCfg.get_id_list_by_file.trust5[1]
	}

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "conName")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.UpdateData(arg_5_0)
	arg_5_0.dataList_ = {}

	local var_5_0 = 1
	local var_5_1 = HeroRecordCfg[arg_5_0.archiveID_]

	for iter_5_0 = 1, 100 do
		if not var_5_1["heart_chain" .. iter_5_0] or var_5_1["heart_chain" .. iter_5_0] == "" then
			break
		end

		local var_5_2 = GameSetting.heart_chain_unlock_condition.value[iter_5_0]
		local var_5_3, var_5_4, var_5_5 = IsConditionAchieved(var_5_2, {
			heroId = arg_5_0.archiveID_
		})

		arg_5_0.dataList_[var_5_0] = {
			isUnlock = var_5_3,
			current = var_5_4,
			all = var_5_5,
			id = iter_5_0,
			index = var_5_0
		}
		var_5_0 = var_5_0 + 1
	end

	table.sort(arg_5_0.dataList_, function(arg_6_0, arg_6_1)
		if arg_6_0.isUnlock ~= arg_6_1.isUnlock then
			return arg_6_0.isUnlock
		end

		return arg_6_0.id < arg_6_1.id
	end)
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.archiveID_ = arg_7_1
	arg_7_0.heroID_ = arg_7_2

	if not table.indexof(GameDisplayCfg.heart_chain_missing.value, arg_7_2) then
		arg_7_0:UpdateData()

		local var_7_0 = 1

		for iter_7_0, iter_7_1 in ipairs(arg_7_0.dataList_) do
			if not arg_7_0.itemList_[iter_7_0] then
				arg_7_0.itemList_[iter_7_0] = HeartLinkItem.New(arg_7_0.itemGo_)
			end

			arg_7_0.itemList_[iter_7_0]:RegisterRefresh(handler(arg_7_0, arg_7_0.UpdateLayout))
			arg_7_0.itemList_[iter_7_0]:RefreshUI(arg_7_0.archiveID_, iter_7_1)

			var_7_0 = var_7_0 + 1
		end

		for iter_7_2 = var_7_0, #arg_7_0.itemList_ do
			arg_7_0.itemList_[iter_7_2]:Hide()
		end

		arg_7_0.controller_:SetSelectedState("true")
	else
		arg_7_0.controller_:SetSelectedState("false")
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.contentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.contentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.contentTrs_)
end

function var_0_0.OnExit(arg_8_0)
	for iter_8_0 = 1, #arg_8_0.itemList_ do
		arg_8_0.itemList_[iter_8_0]:OnExit()
	end
end

function var_0_0.UpdateLayout(arg_9_0, arg_9_1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.contentTrs_)
	arg_9_0:PlayVoice(arg_9_1)
end

function var_0_0.PlayVoice(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.heartLinkVoice_[arg_10_1]

	if var_10_0 == nil then
		return
	end

	SDKTools.SendMessageToSDK("hero_sound", {
		hero_id = arg_10_0.heroID_,
		sound_id = var_10_0
	})
	arg_10_0.interruptFunc_()

	if arg_10_0.delayPlayTimer_ then
		arg_10_0.delayPlayTimer_:Stop()

		arg_10_0.delayPlayTimer_ = nil
	end

	arg_10_0.delayPlayTimer_ = Timer.New(function()
		if manager.audio:IsStoppedOfVoice() then
			arg_10_0.delayPlayTimer_:Stop()

			arg_10_0.delayPlayTimer_ = nil

			HeroTools.PlayVoice(arg_10_0.heroID_, HeroVoiceCfg[var_10_0].file, HeroVoiceCfg[var_10_0].type)

			local var_11_0 = HeroTools.GetTalkLength(arg_10_0.heroID_, HeroVoiceCfg[var_10_0].file, HeroVoiceCfg[var_10_0].type)
			local var_11_1 = math.max(var_11_0, 0.017)

			arg_10_0.timer_ = TimeTools.StartAfterSeconds(var_11_1 / 1000, function()
				arg_10_0:StopVoice()
			end, {})
		end
	end, 0.033, -1)

	arg_10_0.delayPlayTimer_:Start()

	arg_10_0.textinfoText_.text = GetI18NText(HeroVoiceDescCfg.Get(arg_10_0.heroID_, var_10_0))
end

function var_0_0.StopVoice(arg_13_0)
	if arg_13_0.delayPlayTimer_ then
		arg_13_0.delayPlayTimer_:Stop()

		arg_13_0.delayPlayTimer_ = nil
	end

	manager.audio:StopVoiceImmediate()

	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end
end

function var_0_0.RegisterInterruptVoice(arg_14_0, arg_14_1)
	arg_14_0.interruptFunc_ = arg_14_1
end

function var_0_0.Dispose(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.itemList_) do
		iter_15_1:Dispose()
	end

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
