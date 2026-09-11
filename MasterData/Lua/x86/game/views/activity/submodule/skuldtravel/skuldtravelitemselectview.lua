local SkuldTravelItemSelectView = class("SkuldTravelItemSelectView", ReduxView)

function SkuldTravelItemSelectView:UIName()
	return "UI/EmptyDream/EDream_travelled/EDream_travelchoosepop"
end

function SkuldTravelItemSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldTravelItemSelectView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldTravelItemSelectView:InitUI()
	self:BindCfgUI()

	self.itemselecthandle_ = handler(self, self.OnSelectItem)
	self.list_ = LuaList.New(handler(self, self.rendeler), self.listgo_, SkuldTravelItemSelectItem)
	self.isgetcontroller_ = ControllerUtil.GetController(self.transform_, "isget")
end

function SkuldTravelItemSelectView:rendeler(arg_5_1, arg_5_2)
	arg_5_2:SetData(TravelSkuldStoryCfg[self.plotlist_[arg_5_1]].item_id, self.params_.mapindex, self.curitemid_)
	arg_5_2:SetSelecthandler(self.itemselecthandle_)
end

function SkuldTravelItemSelectView:OnSelectItem(arg_6_1)
	self.curitemid_ = arg_6_1
	self.itemnametext_.text = GetI18NText(TravelSkuldItemCfg[arg_6_1].name)
	self.desctext_.text = GetI18NText(TravelSkuldItemCfg[arg_6_1].desc)

	for iter_6_0, iter_6_1 in pairs((self.list_:GetItemList())) do
		iter_6_1:RefreshSelectStatu(arg_6_1)
	end

	self:RefreshGetStatu()
end

function SkuldTravelItemSelectView:RefreshGetStatu()
	if SkuldTravelData:GetPlotIsGetByMapIdAndItemId(self.params_.mapindex, self.curitemid_) then
		self.isgetcontroller_:SetSelectedState("true")
	else
		self.isgetcontroller_:SetSelectedState("false")
	end
end

function SkuldTravelItemSelectView:AddUIListeners()
	self:AddBtnListener(self.travelbtn_, nil, function()
		local var_9_0 = SkuldTravelData:GetPlotIdByMapIdAndItemId(self.params_.mapindex, self.curitemid_)

		if SkuldTravelData:GetPlotIsGetByMapIdAndItemId(self.params_.mapindex, self.curitemid_) then
			ShowMessageBox({
				content = GetTips("TRAVEL_SKULD_STORY_GETTED"),
				OkCallback = function()
					SkuldTravelAction:GotoTravel(var_9_0)
				end
			})
		else
			SkuldTravelAction:GotoTravel(var_9_0)
		end
	end)
	self:AddBtnListener(self.bgbtn_, nil, function()
		JumpTools.Back()
	end)
end

function SkuldTravelItemSelectView:OnEnter()
	if self.curmapid_ ~= self.params_.mapindex then
		self.curmapid_ = self.params_.mapindex
		self.plotlist_ = TravelSkuldStoryCfg.get_id_list_by_location_id[self.params_.mapindex]
		self.curitemid_ = TravelSkuldStoryCfg[self.plotlist_[1]].item_id
	end

	self.itemnametext_.text = GetI18NText(TravelSkuldItemCfg[self.curitemid_].name)
	self.desctext_.text = GetI18NText(TravelSkuldItemCfg[self.curitemid_].desc)

	self:RefreshGetStatu()
	self.list_:StartScroll(#self.plotlist_)
end

function SkuldTravelItemSelectView:OnExit()
	return
end

function SkuldTravelItemSelectView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	self.itemselecthandle_ = nil

	SkuldTravelItemSelectView.super.Dispose(self)
end

return SkuldTravelItemSelectView
