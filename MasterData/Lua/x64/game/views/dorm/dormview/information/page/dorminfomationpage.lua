local DormInfomationPage = class("DormInfomationPage", ReduxView)

function DormInfomationPage:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormInfomationPage:BuildContext()
	self.list = DormInfomationData:GetOpenList()
	self.modules = {}
end

function DormInfomationPage:BuildView()
	for iter_3_0, iter_3_1 in ipairs(self.list) do
		if not self:CheckIsCommonOverview(self:GetTemplateById(iter_3_1)) then
			table.insert(self.modules, self:InstModule(iter_3_1))
		end
	end
end

function DormInfomationPage:CheckIsCommonOverview(arg_4_1)
	if arg_4_1 == 2 then
		return true
	end

	return false
end

function DormInfomationPage:InitUI()
	self:BindCfgUI()
	self:AddListener()
	self:BuildContext()
	self:BuildView()
end

function DormInfomationPage:GetViewByTemplate(arg_6_1)
	if arg_6_1 == 1 then
		return DormInfomationCanteenModule
	elseif arg_6_1 == 2 then
		return DormInfomationIdolModule
	elseif arg_6_1 == 3 then
		return DormInfomationFurnitureModule
	elseif arg_6_1 == 4 then
		return DormInfomationModifierModule
	elseif arg_6_1 == 5 then
		return DormInfomationMotionModule
	elseif arg_6_1 == 6 then
		return DormInfomationFurnitureModule
	end
end

function DormInfomationPage:GetTemplateById(arg_7_1)
	return BackhomeContentNoticeCfg[arg_7_1].template
end

function DormInfomationPage:InstModule(arg_8_1)
	local var_8_0 = self:GetViewByTemplate((self:GetTemplateById(arg_8_1))).New(self.container)

	if var_8_0:CanShow(arg_8_1) then
		var_8_0:Show(arg_8_1)
	else
		var_8_0:Hide()
	end

	return var_8_0
end

function DormInfomationPage:Hide()
	SetActive(self.gameObject_, false)
end

function DormInfomationPage:Show()
	SetActive(self.gameObject_, true)
end

function DormInfomationPage:AddListener()
	return
end

function DormInfomationPage:NeedEmpty()
	local var_12_0 = false

	for iter_12_0, iter_12_1 in ipairs(self.modules) do
		if iter_12_1:CanShow(iter_12_1:GetId()) then
			var_12_0 = true

			break
		end
	end

	return not var_12_0
end

function DormInfomationPage:Dispose()
	for iter_13_0, iter_13_1 in ipairs(self.modules) do
		iter_13_1:Dispose()
	end

	self.modules = nil

	DormInfomationPage.super.Dispose(self)
end

return DormInfomationPage
