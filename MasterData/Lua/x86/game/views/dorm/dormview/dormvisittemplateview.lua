local DormVisitTemplateView = class("DormVisitTemplateView", ReduxView)

function DormVisitTemplateView:UIName()
	return "Widget/BackHouseUI/Dorm/DormCollectionSchemePopUI"
end

function DormVisitTemplateView:UIParent()
	return manager.ui.uiMain.transform
end

function DormVisitTemplateView:OnCtor()
	return
end

function DormVisitTemplateView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormVisitTemplateView:InitUI()
	self:BindCfgUI()

	self.curFurNumController = ControllerUtil.GetController(self.transform_, "curState")
	self.showListController = ControllerUtil.GetController(self.transform_, "pulldown")
	self.templateScroll = LuaList.New(handler(self, self.indexItem), self.uilistGo_, DormVisitFurTemplateItem)
end

function DormVisitTemplateView:OnEnter()
	self:RegisterEvents()

	self.type = BackHomeCfg[DormData:GetCurrectSceneID()].type

	if self.type == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
		self.type = DormConst.BACKHOME_TYPE.PublicDorm
	elseif self.type == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		self.type = DormConst.BACKHOME_TYPE.PrivateDorm
	end

	self.maxNum = 0
	self.maxNum = self.type == DormConst.BACKHOME_TYPE.PublicDorm and DormConst.DORM_TEMPLATE_NUM_MAX or DormConst.DORM_TEMPLATE_PRIVATE_NUM_MAX
	self.showFlag = false

	self:UpdataView()
end

function DormVisitTemplateView:OnExit()
	self:RemoveAllEventListener()
	self.showListController:SetSelectedState("off")

	self.showFlag = false
	self.selTemplateID = nil
	self.selectedPos = nil
end

function DormVisitTemplateView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.confirmBtn_, nil, function()
		local var_11_0 = {
			layout_uid = DormVisitTools:GetLayoutID(),
			user_id = DormVisitTools:GetVisitUserID()
		}

		if self.selTemplateID >= 0 then
			ShowMessageBox({
				isTop = true,
				content = GetTips("DORM_MOULD_COVER"),
				OkCallback = function()
					local var_12_0 = DormData:GetCurrectSceneID()

					DormFurnitureTemplateData:SaveDormSceneTemplate(self.selTemplateID, BackHomeCfg[var_12_0].type, DormFurnitureTemplateData:GetDormTemplateInfo(self.selTemplateID):GetTemplateName(), var_12_0, self.selectedPos, var_11_0)
				end,
				CancelCallback = function()
					return
				end
			})
		else
			local var_11_1 = DormData:GetCurrectSceneID()

			DormFurnitureTemplateData:SaveDormSceneTemplate(DormFurnitureTemplateData:GetCanUseTemplateID(), BackHomeCfg[var_11_1].type, string.format(GetTips("DORM_MOULD_DEFAULT_NAME"), tostring(self.selectedPos)), var_11_1, self.selectedPos, var_11_0)
		end
	end)
	self:AddBtnListener(self.chooseBtn, nil, function()
		if self.showFlag then
			self.showFlag = false

			self.showListController:SetSelectedState("off")
		else
			self.showFlag = true

			self.showListController:SetSelectedState("on")
			self:RefreshList()
		end
	end)
end

function DormVisitTemplateView:UpdataView()
	local var_15_0 = 0

	if not self.selectedPos then
		self.selectedPos = 1
		self.selTemplateID = DormFurnitureTemplateData:GetDormTemplateInfoByPosID(1, self.type) or -1
	end

	if self.selTemplateID > 0 then
		local var_15_1 = DormFurnitureTemplateData:GetDormTemplateInfo(self.selTemplateID)

		var_15_0 = var_15_1:GetDormTemplateFurNumInfo()
		self.curTemplateName.text = var_15_1.name
	else
		self.curTemplateName.text = string.format(GetTips("DORM_MOULD_DEFAULT_NAME"), self.selectedPos)
	end

	self.curFurNum.text = string.format(GetTips("DORM_MOULD_FURNITURE_NUM"), var_15_0)

	if var_15_0 <= 0 then
		self.curFurNumController:SetSelectedState("false")
	else
		self.curFurNumController:SetSelectedState("true")
	end
end

function DormVisitTemplateView:indexItem(arg_16_1, arg_16_2)
	arg_16_2:RefreshUI(self.templateData[arg_16_1], self.selectedPos, arg_16_1)
	arg_16_2:ClickCallBack(function(arg_17_0, arg_17_1)
		self.selTemplateID = arg_17_0
		self.selectedPos = arg_17_1
		self.showFlag = false

		self.showListController:SetSelectedState("off")
		self:UpdataView()
	end)
end

function DormVisitTemplateView:RefreshList()
	self.templateData = {}

	for iter_18_0 = 1, self.maxNum do
		local var_18_0 = DormFurnitureTemplateData:GetDormTemplateInfoByPosID(iter_18_0, self.type)

		if var_18_0 then
			table.insert(self.templateData, var_18_0)
		else
			table.insert(self.templateData, -1)
		end
	end

	self.templateScroll:StartScroll(#self.templateData)
end

function DormVisitTemplateView:RegisterEvents()
	self:RegistEventListener(DORM_TEMPLATE_CHANGE, function()
		JumpTools.Back()
	end)
end

function DormVisitTemplateView:Dispose()
	if self.templateScroll then
		self.templateScroll:Dispose()
	end

	DormVisitTemplateView.super.Dispose(self)
end

return DormVisitTemplateView
