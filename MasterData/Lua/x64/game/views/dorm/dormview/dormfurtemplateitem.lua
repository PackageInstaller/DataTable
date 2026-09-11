local DormFurTemplateItem = class("DormFurTemplateItem", ReduxView)

function DormFurTemplateItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormFurTemplateItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.canUseController = ControllerUtil.GetController(self.transform_, "btnuse")
	self.preViewController = ControllerUtil.GetController(self.transform_, "ues")
end

function DormFurTemplateItem:AddUIListener()
	self:AddBtnListenerScale(self.previewBtn_, nil, function()
		if self.previewCallBack then
			self.previewCallBack(self.templateID, self.pos)
		end
	end)
	self:AddBtnListenerScale(self.useBtn_, nil, function()
		if self.useTemplateCallBack then
			self.useTemplateCallBack(self.templateID, self.pos)
		end
	end)
	self:AddBtnListenerScale(self.btn_editnameBtn_, nil, function()
		if self.ReviseCallBack then
			self.ReviseCallBack(self.templateID, self.pos)
		end
	end)
	self:AddBtnListenerScale(self.saveBtn_, nil, function()
		if self.SaveTemplate then
			self.SaveTemplate(self.templateID, self.pos)
		end
	end)
	self:AddBtnListenerScale(self.deleteBtn_, nil, function()
		if self.DelTemplate then
			self.DelTemplate(self.templateID, self.pos)
		end
	end)
end

function DormFurTemplateItem:RefreshUI(arg_9_1, arg_9_2, arg_9_3)
	self.templateID = arg_9_1
	self.pos = arg_9_2
	self.canPreView = arg_9_3
	self.indexText_.text = arg_9_2

	if arg_9_1 < 0 then
		self.nameText_.text = string.format(GetTips("DORM_MOULD_DEFAULT_NAME"), tostring(arg_9_2))
		self.furNumText_.text = 0

		self.preViewController:SetSelectedState("unedited")

		return
	end

	self.canUseController:SetSelectedState("on")
	self.preViewController:SetSelectedState("normal")

	local var_9_0 = DormFurnitureTemplateData:GetDormTemplateInfo(arg_9_1)

	self.nameText_.text = GetI18NText(var_9_0.name)
	self.furNumText_.text = var_9_0:GetDormTemplateFurNumInfo()

	if not arg_9_3 then
		self.canUseController:SetSelectedState("off")
	end
end

function DormFurTemplateItem:RegisterUseTemplateCallBack(arg_10_1)
	if arg_10_1 and self.canPreView ~= false then
		self.useTemplateCallBack = arg_10_1
	end
end

function DormFurTemplateItem:RegisterPreviewCallBack(arg_11_1)
	if arg_11_1 and self.canPreView ~= false then
		self.previewCallBack = arg_11_1
	end
end

function DormFurTemplateItem:DelTemplateCallBack(arg_12_1)
	if arg_12_1 then
		self.DelTemplate = arg_12_1
	end
end

function DormFurTemplateItem:SaveTemplateCallBack(arg_13_1)
	if arg_13_1 then
		self.SaveTemplate = arg_13_1
	end
end

function DormFurTemplateItem:ReviseNameCallBack(arg_14_1)
	if arg_14_1 then
		self.ReviseCallBack = arg_14_1
	end
end

function DormFurTemplateItem:Dispose()
	self:RemoveAllListeners()
	DormFurTemplateItem.super.Dispose(self)
end

return DormFurTemplateItem
