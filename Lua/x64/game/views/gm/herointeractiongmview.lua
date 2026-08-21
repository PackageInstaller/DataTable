local var_0_0 = class("HeroInteractionGMView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/HeroInteractionGMUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.btnPool_ = {}
	arg_3_0.curBtnCount_ = 0
	arg_3_0.skinId_ = -1
	arg_3_0.inited_ = false
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0.backgroundBtn_ = arg_5_0:FindCom("Button", "background")
	arg_5_0.btn_prefab = arg_5_0:FindGo("HeroInteractionBut_prefab")
	arg_5_0.panel_go = arg_5_0:FindTrs("panel")
	arg_5_0.btn_list = {}
	arg_5_0.btnGo_list = {}
	arg_5_0.skinId_ = arg_5_0.params_.skinId

	if arg_5_0.skinId_ == nil then
		print("skinId 为 nil")
	end

	arg_5_0.animator_ = arg_5_0.params_.animator

	if arg_5_0.inited_ == false then
		arg_5_0:InitData()
		arg_5_0:AddUIListener()

		arg_5_0.inited_ = true
	end
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.skinId_ = arg_6_0.params_.skinId

	if arg_6_0.skinId_ == nil then
		print("skinId 为 nil")
	end

	arg_6_0.animator_ = arg_6_0.params_.animator

	if arg_6_0.inited_ == false then
		arg_6_0:InitData()
		arg_6_0:AddUIListener()
	end
end

function var_0_0.InitData(arg_7_0)
	local var_7_0 = SkinCfg[arg_7_0.skinId_].hero

	if var_7_0 == nil then
		print("heroID 为 nil")
	end

	arg_7_0.interactionCfg_ = HeroTools.GetOldInteractionCfg(var_7_0)

	if arg_7_0.interactionCfg_ == nil then
		print("self.interactionCfg_ 为 nil")
	end

	arg_7_0.actionTypeList_ = {}

	if arg_7_0.interactionCfg_ ~= nil then
		for iter_7_0, iter_7_1 in pairs(arg_7_0.interactionCfg_) do
			if type(arg_7_0.interactionCfg_[iter_7_0]) == "table" and #arg_7_0.interactionCfg_[iter_7_0] ~= 0 and string.find(iter_7_0, "delay") == nil and string.find(iter_7_0, "talk") == nil and string.find(iter_7_0, "weight") == nil then
				table.insert(arg_7_0.actionTypeList_, iter_7_0)
			end
		end
	end

	arg_7_0:GenBtn()
end

function var_0_0.GenBtn(arg_8_0)
	if arg_8_0.actionTypeList_ ~= nil and #arg_8_0.actionTypeList_ > 0 then
		local var_8_0
		local var_8_1
		local var_8_2

		for iter_8_0, iter_8_1 in ipairs(arg_8_0.actionTypeList_) do
			if #arg_8_0.btnPool_ > arg_8_0.curBtnCount_ then
				arg_8_0.curBtnCount_ = arg_8_0.curBtnCount_ + 1
				var_8_0 = arg_8_0.btnPool_[arg_8_0.curBtnCount_]

				SetActive(var_8_0, true)
			else
				var_8_0 = Object.Instantiate(arg_8_0.btn_prefab, arg_8_0.panel_go)
				arg_8_0.curBtnCount_ = arg_8_0.curBtnCount_ + 1

				table.insert(arg_8_0.btnPool_, var_8_0)

				local var_8_3 = var_8_0:GetComponent(typeof(Button))

				if var_8_3 == nil then
					print("button_:按钮为空")
				end

				table.insert(arg_8_0.btn_list, var_8_3)
			end

			local var_8_4 = var_8_0:GetComponentInChildren(typeof(Text))

			if var_8_4 ~= nil then
				var_8_4.text = GetI18NText(iter_8_1)
			else
				print("btn_text为空")
			end
		end
	end
end

function var_0_0.AddUIListener(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.btn_list) do
		arg_9_0:AddBtnListener(iter_9_1, nil, function()
			JumpTools.GoToSystem("heroInteractionGMContent", {
				typeName = arg_9_0.actionTypeList_[iter_9_0],
				skinId = arg_9_0.skinId_,
				animator = arg_9_0.animator_
			})
		end)
	end

	arg_9_0:AddBtnListener(arg_9_0.backgroundBtn_, nil, function()
		arg_9_0:Back()
	end)
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllListeners()

	for iter_12_0 = 1, arg_12_0.curBtnCount_ do
		SetActive(arg_12_0.btnPool_[iter_12_0], false)
	end

	arg_12_0.curBtnCount_ = 0
	arg_12_0.inited_ = false
	arg_12_0.animator_ = nil
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.btn_list = nil

	if arg_13_0.btnPool_ then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0.btnPool_) do
			Object.Destroy(iter_13_1)
		end

		arg_13_0.btnPool_ = nil
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
