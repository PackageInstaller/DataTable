local RogueTeamItemInfoSetttingRelicView = class("RogueTeamItemInfoSetttingRelicView", ReduxView)

function RogueTeamItemInfoSetttingRelicView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.relicUIList_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, RogueTeamItemInfoSettingRelicItem)
	self.relicDataList_ = ChallengeRogueTeamData:EffectItemGetDataList(ChallengeRogueTeamConst.ITEM_TYPE.RELIC)

	self.relicUIList_:StartScroll(#self.relicDataList_)
end

function RogueTeamItemInfoSetttingRelicView:Dispose()
	self.relicUIList_:Dispose()

	self.relicUIList_ = nil

	RogueTeamItemInfoSetttingRelicView.super.Dispose(self)
end

function RogueTeamItemInfoSetttingRelicView:AddListeners()
	return
end

function RogueTeamItemInfoSetttingRelicView:RefreshUI()
	return
end

function RogueTeamItemInfoSetttingRelicView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.relicDataList_[arg_5_1].id)
end

return RogueTeamItemInfoSetttingRelicView
