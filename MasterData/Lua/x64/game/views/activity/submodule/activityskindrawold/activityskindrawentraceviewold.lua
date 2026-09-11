local ActivitySkinDrawEntraceViewOld = class("ActivitySkinDrawEntraceViewOld", ReduxView)

function ActivitySkinDrawEntraceViewOld:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivitySkinDrawEntraceViewOld:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawEntraceViewOld:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ActivitySkinDrawEntraceItemOld)
end

function ActivitySkinDrawEntraceViewOld:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:Refresh(self.list_[arg_4_1])
end

function ActivitySkinDrawEntraceViewOld:AddUIListeners()
	return
end

function ActivitySkinDrawEntraceViewOld:OnEnter()
	manager.notify:RegistListener(ACTIVITY_SKIN_DRAW_UPDATE, handler(self, self.OnSkinDrawUpdate))
	self:RefreshList()
	self:RefreshScrollView()
end

function ActivitySkinDrawEntraceViewOld:RefreshList()
	self.list_ = ActivitySkinDrawDataOld:GetActivityList() or {}

	self.scrollHelper_:StartScroll(#self.list_)
end

function ActivitySkinDrawEntraceViewOld:RefreshScrollView()
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

function ActivitySkinDrawEntraceViewOld:OnSkinDrawUpdate(arg_9_1)
	if ActivityTemplateConst.ACTIVITY_SKIN_DRAW ~= ActivityTools.GetActivityType(arg_9_1) or isNil(self.gameObject_) then
		return
	end

	self:RefreshList()
	self:RefreshScrollView()
end

function ActivitySkinDrawEntraceViewOld:OnExit()
	manager.notify:RemoveListener(ACTIVITY_SKIN_DRAW_UPDATE, handler(self, self.OnSkinDrawUpdate))

	for iter_10_0, iter_10_1 in pairs(self.scrollHelper_:GetItemList()) do
		iter_10_1:OnExit()
	end
end

function ActivitySkinDrawEntraceViewOld:Dispose()
	ActivitySkinDrawEntraceViewOld.super.Dispose(self)
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
end

return ActivitySkinDrawEntraceViewOld
