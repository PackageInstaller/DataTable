local var_0_0 = class("HeroInteractionGMContentView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/HeroInteractionGMContentUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.OnEnter(arg_4_0)
	if arg_4_0.inited == false then
		arg_4_0:Init()
	end
end

function var_0_0.Init(arg_5_0)
	arg_5_0:InitUI()
	arg_5_0:AddUIListener()

	arg_5_0.inited = true
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0.skinId_ = arg_6_0.params_.skinId

	if SkinCfg[arg_6_0.skinId_] == nil then
		print("SkinCfg[self.skinId_] == nil")
	end

	arg_6_0.typeName_ = arg_6_0.params_.typeName

	local var_6_0 = string.split(arg_6_0.typeName_, "_")

	if #var_6_0 == 1 then
		arg_6_0.actionType_ = var_6_0[1]
		arg_6_0.voiceType_ = arg_6_0.actionType_ .. "_talk"
		arg_6_0.voiceDelayType_ = arg_6_0.actionType_ .. "_delay"
	else
		arg_6_0.actionType_ = var_6_0[1]
		arg_6_0.voiceType_ = arg_6_0.typeName_
		arg_6_0.voiceDelayType_ = var_6_0[1] .. "_delay"
	end

	arg_6_0.actionNameList = {}
	arg_6_0.actionList_ = {}
	arg_6_0.voiceList_ = {}
	arg_6_0.voiceDelayList_ = {}

	local var_6_1 = SkinCfg[arg_6_0.skinId_].hero

	arg_6_0.interactionCfg_ = HeroTools.GetOldInteractionCfg(var_6_1)

	if arg_6_0.interactionCfg_ and arg_6_0.interactionCfg_[arg_6_0.typeName_] ~= nil then
		arg_6_0.actionNameList = arg_6_0.interactionCfg_[arg_6_0.typeName_]
	end

	if arg_6_0.interactionCfg_ and arg_6_0.interactionCfg_[arg_6_0.voiceType_] ~= nil then
		arg_6_0.voiceList_ = arg_6_0.interactionCfg_[arg_6_0.voiceType_]
	end

	if arg_6_0.interactionCfg_ and arg_6_0.interactionCfg_[arg_6_0.actionType_] ~= nil then
		arg_6_0.actionList_ = arg_6_0.interactionCfg_[arg_6_0.actionType_]
	end

	if arg_6_0.interactionCfg_ and arg_6_0.interactionCfg_[arg_6_0.voiceDelayType_] ~= nil then
		arg_6_0.voiceDelayList_ = arg_6_0.interactionCfg_[arg_6_0.voiceDelayType_]
	end

	if arg_6_0.backgroundBtn_ == nil then
		arg_6_0.backgroundBtn_ = arg_6_0:FindCom("Button", "background")
	end

	if arg_6_0.btn_prefab == nil then
		arg_6_0.btn_prefab = arg_6_0:FindGo("HeroInteractionBut_prefab")
	end

	if arg_6_0.panel_go == nil then
		arg_6_0.panel_go = arg_6_0:FindTrs("panel")
	end

	arg_6_0.btn_list = {}
	arg_6_0.btnGo_list = {}

	arg_6_0:GenBtn()
end

function var_0_0.GenBtn(arg_7_0)
	if arg_7_0.actionNameList ~= nil and #arg_7_0.actionNameList > 0 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0.actionNameList) do
			local var_7_0 = Object.Instantiate(arg_7_0.btn_prefab, arg_7_0.panel_go)
			local var_7_1 = var_7_0:GetComponentInChildren(typeof(Text))

			if var_7_1 ~= nil then
				var_7_1.text = GetI18NText(iter_7_1)
			else
				print("btn_text为空")
			end

			local var_7_2 = var_7_0:GetComponent(typeof(Button))

			if var_7_2 == nil then
				print("button_:按钮为空")
			end

			table.insert(arg_7_0.btn_list, var_7_2)
			table.insert(arg_7_0.btnGo_list, var_7_0)
		end
	end
end

function var_0_0.AddUIListener(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.btn_list) do
		arg_8_0:AddBtnListener(iter_8_1, nil, function()
			arg_8_0:DelayToPlayInteractionAnimation(iter_8_0, 0)
		end)
	end

	arg_8_0:AddBtnListener(arg_8_0.backgroundBtn_, nil, function()
		arg_8_0:Back()
	end)
end

function var_0_0.DelayToPlayInteractionAnimation(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.playingInteraction_ then
		return
	end

	if arg_11_2 == nil then
		arg_11_2 = 1
	end

	arg_11_0:PlayInteractionAnimation(arg_11_1)
end

function var_0_0.PlayInteractionAnimation(arg_12_0, arg_12_1)
	manager.posterGirl:SetForceRandomIndex(arg_12_1)

	if arg_12_0.typeName_ == "greeting" then
		manager.posterGirl:DoGreeting()
	elseif arg_12_0.typeName_ == "mainTouch" then
		manager.posterGirl:DoTouch()
	elseif arg_12_0.typeName_ == "mainQuickTouch" then
		manager.posterGirl:DoQuickTouch()
	elseif arg_12_0.typeName_ == "shaking" then
		manager.posterGirl:DoShacking()
	elseif arg_12_0.typeName_ == "showing" then
		manager.posterGirl:DoShowing()
	elseif arg_12_0.typeName_ == "idle" then
		manager.posterGirl:DoIdle()
	else
		error("HeroInteractionGMContentView can not find interaction by typeName :" .. arg_12_0.typeName_)
	end
end

function var_0_0.PlaySpecialAnimation(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	return
end

function var_0_0.OnPlaySpecialCallback(arg_14_0)
	return
end

function var_0_0.PlayIdleAni(arg_15_0)
	return
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:RemoveAllListeners()

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.btnGo_list) do
		Object.Destroy(iter_16_1)
	end

	arg_16_0.btn_list = nil
	arg_16_0.btnGo_list = nil
	arg_16_0.inited = false
	arg_16_0.playingInteraction_ = false

	HeroTools.StopTalk()
end

function var_0_0.Dispose(arg_17_0)
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
