local DormVisitFurTemplateItem = class("DormVisitFurTemplateItem", ReduxView)

function DormVisitFurTemplateItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormVisitFurTemplateItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function DormVisitFurTemplateItem:AddUIListener()
	self:AddBtnListener(self.chooseBtn, nil, function()
		if self.clickCallBack then
			self.clickCallBack(self.templateID, self.pos)
		end
	end)
end

function DormVisitFurTemplateItem:RefreshUI(arg_5_1, arg_5_2, arg_5_3)
	self.templateID = arg_5_1

	local var_5_0 = 0

	if self.templateID >= 0 then
		local var_5_1 = DormFurnitureTemplateData:GetDormTemplateInfo(arg_5_1)

		self.name.text = var_5_1.name
		var_5_0 = var_5_1:GetDormTemplateFurNumInfo()
	else
		self.name.text = string.format(GetTips("DORM_MOULD_DEFAULT_NAME"), arg_5_3)
	end

	self.num.text = string.format(GetTips("DORM_MOULD_FURNITURE_NUM"), var_5_0)
	self.pos = arg_5_3

	if self.pos == arg_5_2 then
		if var_5_0 <= 0 then
			self.stateController:SetSelectedState("select1_0")
		else
			self.stateController:SetSelectedState("select_1")
		end
	elseif var_5_0 <= 0 then
		self.stateController:SetSelectedState("normal_0")
	else
		self.stateController:SetSelectedState("normal_1")
	end
end

function DormVisitFurTemplateItem:ClickCallBack(arg_6_1)
	if arg_6_1 then
		self.clickCallBack = arg_6_1
	end
end

function DormVisitFurTemplateItem:Dispose()
	DormVisitFurTemplateItem.super.Dispose(self)
end

return DormVisitFurTemplateItem
