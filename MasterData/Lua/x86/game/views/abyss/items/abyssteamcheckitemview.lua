local AbyssTeamCheckItemView = class("AbyssTeamCheckItemView", ReduxView)

function AbyssTeamCheckItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AbyssTeamCheckItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AbyssTeamCheckItemView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, AbyssTeamCheckHeroItemView)
end

function AbyssTeamCheckItemView:indexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, self.userId_, self.heroInfoList_[arg_4_1])
end

function AbyssTeamCheckItemView:AddUIListener()
	return
end

function AbyssTeamCheckItemView:AddEventListeners()
	return
end

function AbyssTeamCheckItemView:SetData(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self.index_ = arg_7_1
	self.layerId_ = arg_7_2
	self.userId_ = arg_7_3
	self.stageRankInfo_ = arg_7_4
	self.stageId_ = arg_7_4.stage_id
	self.heroInfoList_ = arg_7_4.heroList

	self:UpdateView()
end

function AbyssTeamCheckItemView:UpdateView()
	self.nameText_.text = GetI18NText(BattleAbyssCfg[self.stageId_].name or "关卡" .. self.index_)

	self.uiList_:StartScroll(#self.heroInfoList_)
end

function AbyssTeamCheckItemView:OnEnter()
	self:AddEventListeners()
end

function AbyssTeamCheckItemView:OnExit()
	self:RemoveAllEventListener()
end

function AbyssTeamCheckItemView:OnMainHomeViewTop()
	return
end

function AbyssTeamCheckItemView:Dispose()
	self.data_ = nil

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	AbyssTeamCheckItemView.super.Dispose(self)
end

return AbyssTeamCheckItemView
