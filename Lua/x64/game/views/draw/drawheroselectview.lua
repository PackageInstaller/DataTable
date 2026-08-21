local var_0_0 = class("DrawHeroSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Pool/PoolSelectPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.selectController = ControllerUtil.GetController(arg_4_0.m_controller, "select")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_leftBtn, nil, function()
		arg_5_0:SetSelect(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_rightBtn, nil, function()
		arg_5_0:SetSelect(2)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_sureBtn, nil, function()
		local var_8_0 = arg_5_0.optional_lists[arg_5_0.select]
		local var_8_1 = DrawData:GetPollUpID(arg_5_0.poolId)

		if var_8_0 then
			if var_8_1 ~= var_8_0 then
				DrawAction.SetPollUpID(arg_5_0.poolId, var_8_0)
			else
				arg_5_0:Back()
			end
		else
			error("DrawHeroSelectView with empty pool up id")
		end
	end)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnSetPollUpID(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:Back()
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:SetSelect(0)

	arg_11_0.poolId = arg_11_0.params_.poolId
	arg_11_0.cfg = DrawPoolCfg[arg_11_0.poolId]

	if arg_11_0.optional_lists ~= arg_11_0.cfg.optional_lists_poolId then
		arg_11_0.optional_lists = arg_11_0.cfg.optional_lists_poolId

		arg_11_0:CreatOptionalHeroCom()
	elseif arg_11_0.leftCom == nil or arg_11_0.rightCom == nil then
		arg_11_0:CreatOptionalHeroCom()
	end

	local var_11_0 = DrawData:GetPollUpID(arg_11_0.poolId)

	arg_11_0:SetSelect(table.indexof(arg_11_0.optional_lists, var_11_0) or 0)
end

function var_0_0.CreatOptionalHeroCom(arg_12_0)
	if arg_12_0.leftCom then
		Object.Destroy(arg_12_0.leftCom)
	end

	if arg_12_0.rightCom then
		Object.Destroy(arg_12_0.rightCom)
	end

	local var_12_0 = arg_12_0.cfg.optional_detail
	local var_12_1 = Asset.Load("UI/Draw/SelectUp/select_" .. var_12_0[1])

	arg_12_0.leftCom = Object.Instantiate(var_12_1, arg_12_0.m_leftContent)

	local var_12_2 = Asset.Load("UI/Draw/SelectUp/select_" .. var_12_0[2])

	arg_12_0.rightCom = Object.Instantiate(var_12_2, arg_12_0.m_rightContent)
end

function var_0_0.SetSelect(arg_13_0, arg_13_1)
	arg_13_0.select = arg_13_1

	arg_13_0.selectController:SetSelectedIndex(arg_13_1)

	arg_13_0.m_sureBtn.interactable = arg_13_1 ~= 0
end

function var_0_0.OnExit(arg_14_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.leftCom = nil
	arg_15_0.rightCom = nil

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
