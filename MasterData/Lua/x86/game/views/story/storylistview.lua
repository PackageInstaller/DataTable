local StoryListView = class("StoryListView", ReduxView)

function StoryListView:UIName()
	return "UI/StoryPreviewListUI"
end

function StoryListView:UIParent()
	return manager.ui.uiMain.transform
end

function StoryListView:OnCtor()
	return
end

function StoryListView:InitUI()
	self.list_ = self:FindTrs("list/Grid")
	self.item_ = Asset.Load("UI/StoryPreviewItem")
	self.items_ = {}

	for iter_4_0, iter_4_1 in ipairs((keyPairsSort(StoryCfg))) do
		self.items_[iter_4_1] = StoryItem.New(self, Object.Instantiate(self.item_, self.list_), StoryCfg[iter_4_1])
	end

	self.input_ = self:FindCom(typeof(InputField), "InputField")
end

function StoryListView:AddUIListener()
	self.input_.onEndEdit:AddListener(function()
		local var_6_0 = self.input_.text

		for iter_6_0, iter_6_1 in pairs(self.items_) do
			iter_6_1:Show(string.gmatch(iter_6_0, var_6_0)() ~= nil)
		end
	end)
end

function StoryListView:Render()
	return
end

function StoryListView:RefreshUI()
	return
end

function StoryListView:MoveList(arg_9_1)
	self.list_.transform.localPosition = Vector3(self.list_.transform.localPosition.x, math.floor((self.list_.transform.localPosition.y + arg_9_1) / 440) * 440 + 10, self.list_.transform.localPosition.z)
end

function StoryListView:Init()
	self:InitUI()
	self:AddUIListener()
end

function StoryListView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
	self:RefreshUI()
end

function StoryListView:OnExit()
	manager.windowBar:HideBar()
end

function StoryListView:Dispose()
	self:RemoveAllListeners()

	for iter_13_0, iter_13_1 in pairs(self.items_) do
		iter_13_1:Dispose()
	end

	StoryListView.super.Dispose(self)
end

return StoryListView
