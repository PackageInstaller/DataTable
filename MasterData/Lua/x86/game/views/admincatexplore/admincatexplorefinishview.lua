local AdminCatExploreFinishView = class("AdminCatExploreFinishView", ReduxView)

function AdminCatExploreFinishView:UIName()
	return "Widget/System/ExploreUI/ExploreGetUI"
end

function AdminCatExploreFinishView:UIParent()
	return manager.ui.uiPop.transform
end

function AdminCatExploreFinishView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdminCatExploreFinishView:InitUI()
	self:BindCfgUI()

	self.controller = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.list = LuaList.New(handler(self, self.IndexItem), self.listGo_, CommonItemView)
	self.list2Items = {}
end

function AdminCatExploreFinishView:SetEventData(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.regionData.eventData[arg_5_1], self.adminCatID, self.regionData.startTime)
end

function AdminCatExploreFinishView:IndexItem(arg_6_1, arg_6_2)
	CommonTools.SetCommonData(arg_6_2, {
		id = self.reward[arg_6_1].id,
		number = self.reward[arg_6_1].num,
		clickFun = function(self)
			ShowPopItem(POP_OTHER_ITEM, {
				self.id
			})
		end
	})
end

function AdminCatExploreFinishView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		if self.eventId ~= 0 and self.isClick == nil then
			self.controller:SetSelectedState("get")
			self.animator_:Play("Fx_getPanel_cx", -1, 0)

			self.isClick = true

			manager.audio:PlayEffect("ui_system_explore", "explore_finish", "")

			return
		end

		if self.callBack then
			self.callBack()
		end

		self:Back()
	end)
end

function AdminCatExploreFinishView:UpdateBar()
	return
end

function AdminCatExploreFinishView:UpdateView()
	if self.eventId ~= 0 then
		self.controller:SetSelectedState("event")

		self.eventNameTxt_.text = GetI18NText(ExploreEventCfg[self.eventId].event_name)
		self.eventDescTxt_.text = GetI18NText(ExploreEventCfg[self.eventId].description)
		self.eventTxt_.text = string.format(GetTips("EXPLORE_EVENT_GAIN"), GetI18NText(ExploreEventCfg[self.eventId].effect_description))

		manager.audio:PlayEffect("ui_system_explore", "explore_working", "")
	else
		self.controller:SetSelectedState("get")
		manager.audio:PlayEffect("ui_system_explore", "explore_finish", "")
	end

	self.skillData = AdminCatExploreData:GetDataByPara("skillData")
	self.regionData = AdminCatExploreData:GetDataByPara("regionData")[self.regionId]

	local var_11_0 = ExploreMeowCfg[self.adminCatID]
	local var_11_1 = ExploreMeowSkillCfg[ExploreMeowCfg[self.adminCatID].skill]
	local var_11_2 = ExploreMeowSkillCfg[ExploreMeowCfg[self.adminCatID].skill].skill_effect[self.skillData[ExploreMeowCfg[self.adminCatID].skill]]
	local var_11_3 = ExploreMeowInbornCfg[ExploreMeowCfg[self.adminCatID].inborn]
	local var_11_4 = AdminCatExploreData:GetDataByPara("skillEffect")
	local var_11_5 = AdminCatExploreData:GetDataByPara("inbornEffect")
	local var_11_6 = ExploreAreaCfg[self.regionId]

	SetActive(self.eventTxt_.gameObject, self.eventId ~= 0)
	SetActive(self.skillTxt_.gameObject, var_11_4)
	SetActive(self.inbornTxt_.gameObject, var_11_5)

	self.skillTxt_.text = string.format(GetTips("EXPLORE_SKILL_GAIN"), string.format(GetI18NText(var_11_1.skill_description), var_11_2))
	self.inbornTxt_.text = string.format(GetTips("EXPLORE_INBORN_GAIN"), GetI18NText(var_11_3.inborn_description))

	self.list:StartScroll(#self.reward)

	self.nameTxt_.text = GetI18NText(var_11_6.area_name)
	self.regionImage_.sprite = pureGetSpriteWithoutAtlas("TextureBg/ExploreUI/" .. var_11_6.icon)
	self.adminCatImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Managecat_s/" .. var_11_0.meow_icon)

	for iter_11_0 = 1, #self.regionData.eventData do
		self.list2Items[iter_11_0] = self.list2Items[iter_11_0] or AdminCatExploreEventView.New((Object.Instantiate(self.itemGo_, self.contentTrs_)))

		local var_11_7 = self.regionData.eventData[iter_11_0]

		self.list2Items[iter_11_0]:SetActive(true)
		self.list2Items[iter_11_0]:SetData(var_11_7, self.adminCatID, self.regionData.startTime)
	end

	for iter_11_1 = #self.regionData.eventData + 1, #self.list2Items do
		self.list2Items[iter_11_1]:SetActive(false)
	end
end

function AdminCatExploreFinishView:OnEnter()
	self.regionId = self.params_.regionId
	self.reward = self.params_.reward
	self.eventId = self.params_.eventId
	self.adminCatID = self.params_.adminCatID
	self.callBack = self.params_.callBack

	self:UpdateView()
end

function AdminCatExploreFinishView:OnExit()
	self.isClick = nil
	self.callBack = nil

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

function AdminCatExploreFinishView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	for iter_14_0, iter_14_1 in ipairs(self.list2Items) do
		iter_14_1:Dispose()
	end

	AdminCatExploreFinishView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AdminCatExploreFinishView
