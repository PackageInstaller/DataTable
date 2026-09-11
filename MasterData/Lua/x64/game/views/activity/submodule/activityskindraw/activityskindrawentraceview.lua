local ActivitySkinDrawEntraceView = class("ActivitySkinDrawEntraceView", ReduxView)

function ActivitySkinDrawEntraceView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivitySkinDrawEntraceView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawEntraceView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ActivitySkinDrawEntraceItem)
end

function ActivitySkinDrawEntraceView:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:Refresh(self.list_[arg_4_1])
end

function ActivitySkinDrawEntraceView:AddUIListeners()
	return
end

function ActivitySkinDrawEntraceView:OnEnter()
	manager.notify:RegistListener(ACTIVITY_SKIN_DRAW_UPDATE, handler(self, self.OnSkinDrawUpdate))
	self:RefreshList()
	self:RefreshScrollView()
end

function ActivitySkinDrawEntraceView:GetActivityList()
	local var_7_0 = {}
	local var_7_1 = ActivitySkinDrawData:GetActivityList() or {}
	local var_7_2 = ActivityOathDrawData:GetActivityList() or {}

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		table.insert(var_7_0, iter_7_1)
	end

	for iter_7_2, iter_7_3 in ipairs(var_7_2) do
		table.insert(var_7_0, iter_7_3)
	end

	return var_7_0
end

function ActivitySkinDrawEntraceView:RefreshList()
	self.list_ = self:GetActivityList()

	self.scrollHelper_:StartScroll(#self.list_)
end

function ActivitySkinDrawEntraceView:RefreshScrollView()
	if #self.list_ <= 0 then
		SetActive(self.gameObject_, false)

		return
	end

	SetActive(self.gameObject_, true)

	if #self.list_ > 1 then
		self.scrollView_.enabled = true
	else
		self.scrollView_.verticalNormalizedPosition = 0
		self.scrollView_.enabled = false
	end
end

function ActivitySkinDrawEntraceView:CheckActivityType(arg_10_1)
	if ActivityTemplateConst.ACTIVITY_SKIN_DRAW == ActivityTools.GetActivityType(arg_10_1) then
		return true
	elseif ActivityTemplateConst.ACTIVITY_OATH_DRAW_MAIN == ActivityTools.GetActivityType(arg_10_1) then
		return true
	end

	return false
end

function ActivitySkinDrawEntraceView:OnSkinDrawUpdate(arg_11_1)
	if not self:CheckActivityType(arg_11_1) or isNil(self.gameObject_) or self.isRefreshed_ then
		return
	end

	self.isRefreshed_ = true

	self:RefreshList()
	self:RefreshScrollView()
end

function ActivitySkinDrawEntraceView:OnExit()
	manager.notify:RemoveListener(ACTIVITY_SKIN_DRAW_UPDATE, handler(self, self.OnSkinDrawUpdate))

	for iter_12_0, iter_12_1 in pairs(self.scrollHelper_:GetItemList()) do
		iter_12_1:OnExit()
	end
end

function ActivitySkinDrawEntraceView:Dispose()
	ActivitySkinDrawEntraceView.super.Dispose(self)
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
end

return ActivitySkinDrawEntraceView
