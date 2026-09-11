local DormArchivesHeroChangeView = class("DormArchivesHeroChangeView", ReduxView)

function DormArchivesHeroChangeView:UIName()
	return "UI/HouseUI/TempUi/DormTempSameHeroChange"
end

function DormArchivesHeroChangeView:UIParent()
	return manager.ui.uiMain.transform
end

function DormArchivesHeroChangeView:OnCtor()
	return
end

function DormArchivesHeroChangeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormArchivesHeroChangeView:InitUI()
	self:BindCfgUI()
end

function DormArchivesHeroChangeView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:RefreshUI(self.heroIDList[arg_6_1], self.selheroID)
	arg_6_2:RegisterClickCallBack(function(arg_7_0)
		self.selheroID = arg_7_0

		self.heroScroll:Refresh()
	end)
end

function DormArchivesHeroChangeView:AddUIListener()
	self:AddBtnListenerScale(self.cancelbtnBtn_, nil, function()
		JumpTools:back()
	end)
	self:AddBtnListenerScale(self.confirmbtnBtn_, nil, function()
		local var_10_0 = {}

		table.insert(var_10_0, self.selheroID)
		DormAction:DeployHeroInRoom(DormData:GetCurrectSceneID(), var_10_0, DormEnum.DormDeployType.ReCall)
		JumpTools:back()
	end)
end

function DormArchivesHeroChangeView:OnEnter()
	self.heroID = self.params_.heroID or 0

	self:UpdataHerolList(self.heroID)
	self.heroScroll:StartScroll(#self.heroIDList)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function DormArchivesHeroChangeView:UpdataHerolList(arg_12_1)
	local var_12_0 = DormData:GetHeroArchiveID(arg_12_1)

	if HeroRecordCfg[var_12_0] then
		self.heroIDList = HeroRecordCfg[var_12_0].hero_id
	else
		Debug.LogError("不存在角色档案信息")
	end
end

function DormArchivesHeroChangeView:OnExit()
	manager.windowBar:HideBar()
end

function DormArchivesHeroChangeView:Dispose()
	DormArchivesHeroChangeView.super.Dispose(self)
end

return DormArchivesHeroChangeView
