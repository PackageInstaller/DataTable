local ActivitySkinDrawDLCPopView = class("ActivitySkinDrawDLCPopView", ReduxView)

function ActivitySkinDrawDLCPopView:UIName()
	return ActivitySkinDrawTools.GetDLCPopUIName(self.params_.mainActivity)
end

function ActivitySkinDrawDLCPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivitySkinDrawDLCPopView:Init()
	self:InitUI()
	self:AddUIListeners()

	self.dlcItemClickHandler_ = handler(self, self.OnDLCItemClick)
	self.getBtnCon_ = self.getBtnCon_:GetController("get")
end

function ActivitySkinDrawDLCPopView:InitUI()
	self:BindCfgUI()

	self.dlcList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, ActivitySkinDrawDLCItem)
	self.criMovie_ = self.movieGo_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player
	self.criplayer_.statusChangeCallback = handler(self, self.CirMovieStatusChange)
	self.getBtnController_ = self.getBtnCon_:GetController("get")
end

function ActivitySkinDrawDLCPopView:AddUIListeners()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.getBtn_, nil, function()
		if self.isGet_ then
			return
		end

		self:Back()

		if self.activityID_ then
			ActivitySkinDrawTools.JumpToDLCSource(self.cfg_.source[1], self.activityID_)
		end
	end)
end

function ActivitySkinDrawDLCPopView:IndexItem(arg_8_1, arg_8_2)
	arg_8_2:SetSelected(arg_8_1 == self.selectedIndex_)
	arg_8_2:RegisterClickCallBack(self.dlcItemClickHandler_)
	arg_8_2:SetData(arg_8_1, self.dlcIdList_[arg_8_1])
end

function ActivitySkinDrawDLCPopView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.sceneID_ = self.params_.sceneID
	self.dlcIdList_ = HomeSceneBundleCfg.get_id_list_by_scene_id[self.sceneID_]

	self:RefreshSelected(1)
	self.dlcList_:StartScroll(#self.dlcIdList_)
	SetActive(self.getBtn_.gameObject, self.activityID_ ~= nil)
end

function ActivitySkinDrawDLCPopView:RefreshSelected(arg_10_1)
	self.selectedIndex_ = arg_10_1

	if self.selectedIndex_ > #self.dlcIdList_ then
		self.selectedIndex_ = 1
	end

	self.cfg_ = HomeSceneBundleCfg[self.dlcIdList_[self.selectedIndex_]]
	self.dlcNameText_.text = self.cfg_.name
	self.dlcDescText_.text = self.cfg_.desc
	self.getPathText_.text = self.cfg_.source_desc
	self.isGet_ = ItemTools.getItemNum(self.cfg_.item_id) > 0

	self.getBtnCon_:SetSelectedState(self.isGet_ and "get" or "none")
	self:RefreshMovie()
end

function ActivitySkinDrawDLCPopView:RefreshMovie()
	self.criMovie_:Stop()

	if self.cfg_.start_path then
		SetFile(self.criplayer_, nil, self.cfg_.start_path, CriMana.Player.SetMode.New)
		self.criMovie_:Play()
	end
end

function ActivitySkinDrawDLCPopView:CirMovieStatusChange(arg_12_1)
	local var_12_0 = tostring(arg_12_1)

	if var_12_0 == "PlayEnd" or var_12_0 == "Stop" then
		if var_12_0 == "PlayEnd" then
			self.selectedIndex_ = self.selectedIndex_ + 1
		end

		self:RefreshSelected(self.selectedIndex_)
		self.dlcList_:Refresh()
	end
end

function ActivitySkinDrawDLCPopView:OnDLCItemClick(arg_13_1)
	self:RefreshSelected(arg_13_1)
	self.dlcList_:Refresh()
end

function ActivitySkinDrawDLCPopView:OnExit()
	self:RemoveAllEventListener()
end

function ActivitySkinDrawDLCPopView:Dispose()
	if self.dlcList_ then
		self.dlcList_:Dispose()
	end

	self.dlcIdList_ = nil

	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivitySkinDrawDLCPopView
