local SeaWarfareGmPanelView = class("SeaWarfareGmPanelView", ReduxView)

function SeaWarfareGmPanelView:UIName()
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Navigation/QuanZhou_NavigationGmUI"
end

function SeaWarfareGmPanelView:UIParent()
	return manager.ui.uiMain.transform
end

function SeaWarfareGmPanelView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SeaWarfareGmPanelView:InitUI()
	self:BindCfgUI()

	self.normalStageList_ = LuaList.New(handler(self, self.IndexNormalStage), self.normalStageListGo_, SeaWarfareGmButtonItem)
	self.marinerSkillList_ = LuaList.New(handler(self, self.IndexMarinerSkill), self.marinerSkillListGo_, SeaWarfareGmButtonItem)
	self.skillList_ = LuaList.New(handler(self, self.IndexSkill), self.skillListGo_, SeaWarfareGmButtonItem)
	self.tagList_ = LuaList.New(handler(self, self.IndexTag), self.tagListGo_, SeaWarfareGmButtonItem)
	self.clickNormalStageHandler_ = handler(self, self.OnClickNormalStage)
	self.clickMarinerSkillHandler_ = handler(self, self.OnClickMarinerSkill)
	self.clickSkillStageHandler_ = handler(self, self.OnClickSkill)
	self.clickTagHandler_ = handler(self, self.OnClickTag)
end

function SeaWarfareGmPanelView:AddUIListener()
	self:AddBtnListener(self.startNormalBattleBtn_, nil, function()
		if self.selectNormaslStageID_ and self.selectSkillID_ then
			local var_6_0 = {}

			for iter_6_0, iter_6_1 in ipairs(self.selectMarinerDic_) do
				table.insert(var_6_0, iter_6_1)
			end

			SeaWarfareTools.LaunchBattle(self.selectNormaslStageID_, self.selectSkillID_, var_6_0)
		end
	end)
	self:AddBtnListener(self.openTagBtn_, nil, function()
		if self.selectTagID_ then
			QWorldMgr:GetQWorldTagMgr():GotoTag(self.selectTagID_)
		end
	end)
end

function SeaWarfareGmPanelView:OnEnter()
	self:ResetParams()
	self:RefreshUI()
end

function SeaWarfareGmPanelView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function SeaWarfareGmPanelView:ResetParams()
	self.selectNormaslStageID_ = nil
	self.selectSkillID_ = nil
	self.selectTagID_ = nil
	self.selectMarinerDic_ = {}
end

function SeaWarfareGmPanelView:OnExit()
	manager.windowBar:HideBar()
end

function SeaWarfareGmPanelView:RefreshUI()
	self.normalStageIDList_ = SeaWarfareTools.GetStageIDList(SeaWarfareConst.STAGE_TYPE.NORMAL)

	self.normalStageList_:StartScroll(#self.normalStageIDList_)

	self.marinerIDList_ = SeaWarfareTools.GetMarinerIDList()

	self.marinerSkillList_:StartScroll(#self.marinerIDList_)

	self.skillIDList_ = SeaWarfareTools.GetSkillIDList()

	self.skillList_:StartScroll(#self.skillIDList_)

	self.tagIDList_ = SeaWarfareTools.GetTagIDList()

	self.tagList_:StartScroll(#self.tagIDList_)
end

function SeaWarfareGmPanelView:IndexNormalStage(arg_13_1, arg_13_2)
	arg_13_2:SetData(self.normalStageIDList_[arg_13_1])
	arg_13_2:SetClickCallBack(self.clickNormalStageHandler_)
	arg_13_2:SetSelect(self.normalStageIDList_[arg_13_1] == self.selectNormaslStageID_)
end

function SeaWarfareGmPanelView:IndexMarinerSkill(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.marinerIDList_[arg_14_1])
	arg_14_2:SetClickCallBack(self.clickMarinerSkillHandler_)
	arg_14_2:SetSelect(self.selectMarinerDic_[self.marinerIDList_[arg_14_1]])
end

function SeaWarfareGmPanelView:IndexSkill(arg_15_1, arg_15_2)
	arg_15_2:SetData(self.skillIDList_[arg_15_1])
	arg_15_2:SetClickCallBack(self.clickSkillStageHandler_)
	arg_15_2:SetSelect(self.skillIDList_[arg_15_1] == self.selectSkillID_)
end

function SeaWarfareGmPanelView:IndexTag(arg_16_1, arg_16_2)
	arg_16_2:SetData(self.tagIDList_[arg_16_1])
	arg_16_2:SetClickCallBack(self.clickTagHandler_)
	arg_16_2:SetSelect(self.tagIDList_[arg_16_1] == self.selectTagID_)
end

function SeaWarfareGmPanelView:OnClickNormalStage(arg_17_1)
	self.selectNormaslStageID_ = arg_17_1

	for iter_17_0, iter_17_1 in pairs((self.normalStageList_:GetItemList())) do
		iter_17_1:SetSelect(arg_17_1 == iter_17_1:GetID())
	end
end

function SeaWarfareGmPanelView:OnClickMarinerSkill(arg_18_1)
	self.selectMarinerDic_[arg_18_1] = not self.selectMarinerDic_[arg_18_1]

	for iter_18_0, iter_18_1 in pairs((self.marinerSkillList_:GetItemList())) do
		iter_18_1:SetSelect(self.selectMarinerDic_[iter_18_1:GetID()])
	end
end

function SeaWarfareGmPanelView:OnClickSkill(arg_19_1)
	self.selectSkillID_ = arg_19_1

	for iter_19_0, iter_19_1 in pairs((self.skillList_:GetItemList())) do
		iter_19_1:SetSelect(arg_19_1 == iter_19_1:GetID())
	end
end

function SeaWarfareGmPanelView:OnClickTag(arg_20_1)
	self.selectTagID_ = arg_20_1

	for iter_20_0, iter_20_1 in pairs((self.tagList_:GetItemList())) do
		iter_20_1:SetSelect(arg_20_1 == iter_20_1:GetID())
	end
end

function SeaWarfareGmPanelView:Dispose()
	SeaWarfareGmPanelView.super.Dispose(self)
	self.normalStageList_:Dispose()
	self.marinerSkillList_:Dispose()
	self.skillList_:Dispose()
	self.tagList_:Dispose()
end

return SeaWarfareGmPanelView
