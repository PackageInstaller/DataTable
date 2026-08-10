local var_0_0 = class("MatrixItemInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("UI/Matrix/Main/MatrixItemInfo")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:initUI()
	arg_1_0:AddUIListener()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.Refresh(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = MatrixItemCfg[arg_4_1]

	if not var_4_0 then
		return
	end

	local var_4_1 = ""
	local var_4_2

	if arg_4_3 then
		if arg_4_4 then
			local var_4_3 = ActivityTools.GetActivityType(activity_id)

			if var_4_3 == ActivityTemplateConst.SUB_SINGLE_MATRIX then
				var_4_2 = ActivityMatrixData:GetHeroData(arg_4_4, arg_4_3)
			elseif var_4_3 == ActivityTemplateConst.STRATEGY_MATRIX then
				var_4_2 = StrategyMatrixData:GetHeroData(arg_4_3)
			end
		else
			var_4_2 = MatrixData:GetHeroData(arg_4_3)
		end
	end

	if var_4_0.matrix_item_type == MatrixConst.ITEM_TYPE.ASTROLABE and var_4_2 then
		local var_4_4 = var_4_2:GetAstrolabeNum(var_4_0.params[1])

		for iter_4_0 = 1, var_4_4 do
			if var_4_1 then
				var_4_1 = var_4_1 .. GetI18NText(MatrixTools.GetMatrixItemDes(arg_4_1, iter_4_0)) .. "\n"
			else
				var_4_1 = GetI18NText(MatrixTools.GetMatrixItemDes(arg_4_1, iter_4_0, arg_4_4))
			end
		end
	else
		var_4_1 = GetI18NText(MatrixTools.GetMatrixItemDes(arg_4_1, arg_4_2, arg_4_4))
	end

	arg_4_0:RefreshText(var_4_0.name, var_4_1, arg_4_2)
end

function var_0_0.RefreshAffix(arg_5_0, arg_5_1)
	local var_5_0 = getAffixName(arg_5_1)
	local var_5_1 = getAffixDesc(arg_5_1)

	arg_5_0:RefreshText(var_5_0, var_5_1)
end

function var_0_0.RefreshBeacon(arg_6_0, arg_6_1)
	local var_6_0 = MatrixBeaconCfg[arg_6_1]
	local var_6_1 = var_6_0.name
	local var_6_2 = var_6_0.desc

	arg_6_0:RefreshText(var_6_1, var_6_2)
end

function var_0_0.RefreshText(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	print(arg_7_1)
	print(arg_7_2)

	arg_7_0.m_name.text = GetI18NText(arg_7_1)
	arg_7_0.m_content.text = GetI18NText(arg_7_2)

	if arg_7_3 then
		arg_7_0.m_levelText.text = arg_7_3
	else
		arg_7_0.m_levelText.text = ""
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.textTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.m_contentTrs)

	local var_7_0 = arg_7_0.m_bottom:TransformPoint(Vector3(0, 0, 0))
	local var_7_1 = manager.ui.uiMain.transform:InverseTransformPoint(var_7_0)
	local var_7_2 = manager.ui.uiMain.transform.transform.rect.height / 2

	if var_7_2 < -var_7_1.y then
		local var_7_3 = -var_7_1.y - var_7_2
		local var_7_4 = arg_7_0.transform_.localPosition

		arg_7_0.transform_.localPosition = Vector3(var_7_4.x, var_7_4.y + var_7_3, var_7_4.z)
	end
end

function var_0_0.SetPosition(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.transform_.localPosition = Vector3(arg_8_1, arg_8_2, 0)
end

function var_0_0.SetWorldPosition(arg_9_0, arg_9_1)
	arg_9_0.transform_.position = arg_9_1
end

function var_0_0.SetActive(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)

	if arg_10_1 then
		arg_10_0.gameObject_.transform:SetAsLastSibling()
	end
end

function var_0_0.Dispose(arg_11_0)
	Object.Destroy(arg_11_0.gameObject_)
	var_0_0.super.Dispose(arg_11_0)

	arg_11_0.transform_ = nil
	arg_11_0.gameObject_ = nil
end

return var_0_0
