local ActivityNewWarChessRewardItem = class("ActivityNewWarChessRewardItem", ReduxView)

function ActivityNewWarChessRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityNewWarChessRewardItem:Init()
	self:InitUI()
end

function ActivityNewWarChessRewardItem:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.m_list, ActivityNewWarChessRewardItemItem)
end

function ActivityNewWarChessRewardItem:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, self.levelCfg_.id_level, self.activityId_, self.levelCfg_.explore[arg_4_1])
end

function ActivityNewWarChessRewardItem:SetData(arg_5_1)
	self.activityId_ = arg_5_1
	self.levelCfg_ = NewWarChessLevelCfg[NewWarChessLevelCfg.get_id_list_by_activity[self.activityId_][1]]
	self.m_title.text = self.levelCfg_.name_level

	self.uiList_:StartScroll(#self.levelCfg_.explore)
end

function ActivityNewWarChessRewardItem:UpdateView()
	return
end

function ActivityNewWarChessRewardItem:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	ActivityNewWarChessRewardItem.super.Dispose(self)
end

return ActivityNewWarChessRewardItem
