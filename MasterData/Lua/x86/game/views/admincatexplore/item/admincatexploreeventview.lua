local AdminCatExploreEventView = class("AdminCatExploreEventView", ReduxView)

function AdminCatExploreEventView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function AdminCatExploreEventView:Init()
	self:InitUI()
end

function AdminCatExploreEventView:InitUI()
	self:BindCfgUI()
end

function AdminCatExploreEventView:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.data = arg_4_1
	self.adminCatID = arg_4_2
	self.startTime = arg_4_3

	self:UpdateView()
end

function AdminCatExploreEventView:SetActive(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function AdminCatExploreEventView:UpdateView()
	self.timeTxt_.text = manager.time:DescCDTime(self.data.time)

	local var_6_0 = (GetI18NText(ExploreMeowCfg[self.adminCatID].meow_name) .. GetI18NText(ExploringEventCfg[self.data.address].description)) .. GetI18NText(ExploringEventCfg[self.data.content].description)

	if ExploringEventCfg[self.data.content].event_type == 3 then
		var_6_0 = var_6_0 .. "\n" .. GetTips("EXPLORE_PROCESS_EVENT_REWARD")

		for iter_6_0, iter_6_1 in ipairs(ExploringEventCfg[self.data.content].reward) do
			var_6_0 = var_6_0 .. "<color=#CFB9FB>" .. ItemTools.getItemName(iter_6_1[1]) .. " x " .. iter_6_1[2] .. "</color>  "
		end
	end

	self.contentTxt_.text = var_6_0
end

function AdminCatExploreEventView:OnEnter()
	self:UpdateView()
end

function AdminCatExploreEventView:OnExit()
	return
end

function AdminCatExploreEventView:Dispose()
	AdminCatExploreEventView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AdminCatExploreEventView
