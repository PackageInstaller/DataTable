local DormLevelInfoView = class("DormLevelInfoView", ReduxView)

function DormLevelInfoView:UIName()
	return "Widget/BackHouseUI/Dorm/DormPoplevelUI"
end

function DormLevelInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function DormLevelInfoView:OnCtor()
	return
end

function DormLevelInfoView:Init()
	self:InitUI()
	self:AddUIListener()

	self.levelScroll = LuaList.New(handler(self, self.indexItem), self.uilistGo_, DormLevelAwardItem)
	self.maxController = ControllerUtil.GetController(self.gameObject_.transform, "level")
end

function DormLevelInfoView:InitUI()
	self:BindCfgUI()
end

function DormLevelInfoView:OnEnter()
	self.roomID = DormData:GetCurrectSceneID()

	if BackHomeCfg[self.roomID].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		self.archiveID = self.params_.archiveID
	end

	self:RefreshList()
	self:RefreshExp()
end

function DormLevelInfoView:OnExit()
	return
end

function DormLevelInfoView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function DormLevelInfoView:indexItem(arg_10_1, arg_10_2)
	arg_10_2:RefreshUI(self.itemList[arg_10_1], arg_10_1, self.curLevel)
end

function DormLevelInfoView:RefreshList()
	self.itemList = BackHomeHeroCfg[DormData:GetHeroInfo(self.archiveID):GetCanUseHeroList()[1]].level_reward
	self.curLevel = DormitoryData:GetDormLevel(self.roomID)

	self.levelScroll:StartScroll(#self.itemList)
	self.levelScroll:ScrollToIndex(self.curLevel, false, false)
end

function DormLevelInfoView:RefreshExp()
	local var_12_0 = DormitoryData:GetDormLevel(self.roomID)

	self.level.text = tostring(var_12_0)

	if var_12_0 == #BackHomeDormLevel.all then
		self.maxController:SetSelectedState("full_rank")

		self.curExp.text = ""
		self.maxExp.text = ""
		self.progress.value = 1

		return
	end

	local var_12_1 = DormitoryData:GetDormExp(self.roomID)
	local var_12_2 = 0

	if var_12_0 >= 1 then
		for iter_12_0 = 1, var_12_0 do
			var_12_2 = var_12_2 + BackHomeDormLevel[iter_12_0].exp
		end
	end

	self.curExp.text = var_12_1
	self.maxExp.text = "/" .. var_12_2
	self.progress.value = var_12_1 / var_12_2
end

function DormLevelInfoView:Dispose()
	if self.levelScroll then
		self.levelScroll:Dispose()
	end

	DormLevelInfoView.super.Dispose(self)
end

return DormLevelInfoView
