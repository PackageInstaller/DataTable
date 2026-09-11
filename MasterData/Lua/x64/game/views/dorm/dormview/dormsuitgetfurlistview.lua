local DormSuitGetFurListView = class("DormSuitGetFurListView", ReduxView)

function DormSuitGetFurListView:UIName()
	return "Widget/BackHouseUI/Dorm/DormFurnitureGetPopUI"
end

function DormSuitGetFurListView:UIParent()
	return manager.ui.uiPop.transform
end

function DormSuitGetFurListView:OnCtor()
	return
end

function DormSuitGetFurListView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormSuitGetFurListView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, FurnitureItem)
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function DormSuitGetFurListView:OnEnter()
	self.canStorageList = self.params_.furEidList or nil

	self:RefreshView()
end

function DormSuitGetFurListView:OnExit()
	self:RemoveAllEventListener()
end

function DormSuitGetFurListView:AddUIListener()
	self:AddBtnListenerScale(self.confirmBtn, nil, function()
		if self.canStorageList then
			for iter_9_0, iter_9_1 in pairs(self.canStorageList) do
				for iter_9_2 = 0, iter_9_1.Length - 1 do
					DormFurnitureManager.GetInstance().FindAndRemove(iter_9_1[iter_9_2])
					DormFurEditStateData:ReviseFurNumInEditRoom(iter_9_0, -1)
				end
			end
		end

		if self.params_.callBack then
			self.params_.callBack()
		end

		self.params_.furEidList = nil
		self.canStorageList = nil

		JumpTools.Back()
	end)
	self:AddBtnListener(self.cancelBtn, nil, function()
		self.params_.furEidList = nil
		self.canStorageList = nil

		JumpTools.Back()
	end)
end

function DormSuitGetFurListView:RefreshView()
	if self.canStorageList then
		self.stateController:SetSelectedState("have")
		self:RefreshFurInfoList()
	else
		self.stateController:SetSelectedState("no")
	end
end

function DormSuitGetFurListView:RefreshFurInfoList()
	if self.canStorageList then
		self.furInfoList = {}

		for iter_12_0, iter_12_1 in pairs(self.canStorageList) do
			table.insert(self.furInfoList, {
				furID = iter_12_0,
				canStorageNum = iter_12_1.Length
			})
		end

		self.scrollHelper_:StartScroll(#self.furInfoList)
	end
end

function DormSuitGetFurListView:indexItem(arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(self.furInfoList[arg_13_1], nil, DormEnum.FurItemType.StorageFurShow, nil, arg_13_1)
end

function DormSuitGetFurListView:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()
	end

	DormSuitGetFurListView.super.Dispose(self)
end

return DormSuitGetFurListView
