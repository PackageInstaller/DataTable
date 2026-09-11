local MatrixItemInfoView = class("MatrixItemInfoView", ReduxView)

function MatrixItemInfoView:OnCtor(arg_1_1)
	self.gameObject_ = Object.Instantiate(Asset.Load("UI/Matrix/Main/MatrixItemInfo"), arg_1_1)
	self.transform_ = self.gameObject_.transform

	self:initUI()
	self:AddUIListener()
end

function MatrixItemInfoView:initUI()
	self:BindCfgUI()
end

function MatrixItemInfoView:AddUIListener()
	return
end

function MatrixItemInfoView:Refresh(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = MatrixItemCfg[arg_4_1]

	if not MatrixItemCfg[arg_4_1] then
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
		for iter_4_0 = 1, var_4_2:GetAstrolabeNum(var_4_0.params[1]) do
			var_4_1 = var_4_1 and var_4_1 .. GetI18NText(MatrixTools.GetMatrixItemDes(arg_4_1, iter_4_0)) .. "\n" or GetI18NText(MatrixTools.GetMatrixItemDes(arg_4_1, iter_4_0, arg_4_4))
		end
	else
		var_4_1 = GetI18NText(MatrixTools.GetMatrixItemDes(arg_4_1, arg_4_2, arg_4_4))
	end

	self:RefreshText(var_4_0.name, var_4_1, arg_4_2)
end

function MatrixItemInfoView:RefreshAffix(arg_5_1)
	self:RefreshText(getAffixName(arg_5_1), (getAffixDesc(arg_5_1)))
end

function MatrixItemInfoView:RefreshBeacon(arg_6_1)
	self:RefreshText(MatrixBeaconCfg[arg_6_1].name, MatrixBeaconCfg[arg_6_1].desc)
end

function MatrixItemInfoView:RefreshText(arg_7_1, arg_7_2, arg_7_3)
	print(arg_7_1)
	print(arg_7_2)

	self.m_name.text = GetI18NText(arg_7_1)
	self.m_content.text = GetI18NText(arg_7_2)
	self.m_levelText.text = arg_7_3 and arg_7_3 or ""

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.textTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_contentTrs)

	local var_7_0 = manager.ui.uiMain.transform:InverseTransformPoint((self.m_bottom:TransformPoint(Vector3(0, 0, 0))))

	if manager.ui.uiMain.transform.transform.rect.height / 2 < -var_7_0.y then
		self.transform_.localPosition = Vector3(self.transform_.localPosition.x, self.transform_.localPosition.y + (-var_7_0.y - manager.ui.uiMain.transform.transform.rect.height / 2), self.transform_.localPosition.z)
	end
end

function MatrixItemInfoView:SetPosition(arg_8_1, arg_8_2)
	self.transform_.localPosition = Vector3(arg_8_1, arg_8_2, 0)
end

function MatrixItemInfoView:SetWorldPosition(arg_9_1)
	self.transform_.position = arg_9_1
end

function MatrixItemInfoView:SetActive(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)

	if arg_10_1 then
		self.gameObject_.transform:SetAsLastSibling()
	end
end

function MatrixItemInfoView:Dispose()
	Object.Destroy(self.gameObject_)
	MatrixItemInfoView.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

return MatrixItemInfoView
