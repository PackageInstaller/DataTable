local DormInfoOverviewPage = class("DormInfoOverviewPage", ReduxView)

function DormInfoOverviewPage:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormInfoOverviewPage:BuildContext()
	self.modules = {
		canteen = {
			script = DormOverviewCanteenModule
		},
		dormitory = {
			script = DormOverviewDormitoryModule
		},
		training = {
			script = DormOverviewTrainingModule
		}
	}
end

function DormInfoOverviewPage:BuildView()
	self.modules.training.entity = self.modules.training.entity or self.modules.training.script.New(self.container)
	self.modules.canteen.entity = self.modules.canteen.entity or self.modules.canteen.script.New(self.container)
	self.modules.dormitory.entity = self.modules.dormitory.entity or self.modules.dormitory.script.New(self.container)
end

function DormInfoOverviewPage:InitUI()
	self:BindCfgUI()
	self:AddListener()
	self:BuildContext()
	self:BuildView()
end

function DormInfoOverviewPage:Show()
	SetActive(self.gameObject_, true)
	self:Render()
	self:RegisterEvents()

	for iter_5_0, iter_5_1 in pairs(self.modules) do
		iter_5_1.entity:RegisterEvents()
		iter_5_1.entity:OnEnter()
	end

	self.cacheEntrustNum_ = 0
	self.refreshTimer = self.refreshTimer or Timer.New(function()
		local var_6_0 = CanteenEntrustData:CheckTimeOverEntrustNum()

		if self.cacheEntrustNum_ ~= var_6_0 then
			self.cacheEntrustNum_ = var_6_0

			self.modules.canteen.entity:Render()
		end
	end, 1, -1)

	self.refreshTimer:Start()
end

function DormInfoOverviewPage:Hide()
	SetActive(self.gameObject_, false)

	for iter_7_0, iter_7_1 in pairs(self.modules) do
		iter_7_1.entity:RemoveAllEventListener()
		iter_7_1.entity:OnExit()
	end

	self:RemoveAllEventListener()

	if self.refreshTimer then
		self.refreshTimer:Stop()

		self.refreshTimer = nil
	end

	self.cacheEntrustNum_ = 0
end

function DormInfoOverviewPage:NeedEmpty()
	return false
end

function DormInfoOverviewPage:Render()
	self.modules.canteen.entity:Render()
	self.modules.dormitory.entity:Render()
	self.modules.training.entity:Render()
end

function DormInfoOverviewPage:AddListener()
	return
end

function DormInfoOverviewPage:Dispose()
	if self.refreshTimer then
		self.refreshTimer:Stop()

		self.refreshTimer = nil
	end

	self.cacheEntrustNum_ = 0

	if self.modules.canteen.entity then
		self.modules.canteen.entity:Dispose()

		self.modules.canteen.entity = nil
	end

	if self.modules.dormitory.entity then
		self.modules.dormitory.entity:Dispose()

		self.modules.dormitory.entity = nil
	end

	if self.modules.training.entity then
		self.modules.training.entity:Dispose()

		self.modules.training.entity = nil
	end

	DormInfoOverviewPage.super.Dispose(self)
end

function DormInfoOverviewPage:RegisterEvents()
	self:RegistEventListener(DORM_REFRESH_HERO_DEPLOY_LIST, function()
		self:Render()
	end)
end

return DormInfoOverviewPage
