local LikeInfoPopItem = class("LikeInfoPopItem", ReduxView)

function LikeInfoPopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function LikeInfoPopItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function LikeInfoPopItem:InitUI()
	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
end

function LikeInfoPopItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(self.id_)
	end)
end

function LikeInfoPopItem:OnEnter()
	return
end

function LikeInfoPopItem:RefreshData(arg_7_1, arg_7_2)
	self.id_ = arg_7_1.id
	self.nick_ = arg_7_1.nick
	self.icon_ = arg_7_1.icon
	self.frame_ = arg_7_1.frame
	self.level_ = arg_7_1.level
	self.time_ = arg_7_2

	self:RefreshUI()
end

function LikeInfoPopItem:RefreshUI()
	self.commonPortrait_:RenderHead(self.icon_)
	self.commonPortrait_:RenderFrame(self.frame_)

	self.nickTxt_.text = self.nick_
	self.levelTxt_.text = self.level_
	self.timeTxt_.text = manager.time:STimeDescS(self.time_, "!%Y/%m/%d %H:%M")
end

function LikeInfoPopItem:OnExit()
	return
end

function LikeInfoPopItem:Dispose()
	if self.commonPortrait_ ~= nil then
		self.commonPortrait_:Dispose()

		self.commonPortrait_ = nil
	end

	self:RemoveAllEventListener()
	LikeInfoPopItem.super.Dispose(self)
end

return LikeInfoPopItem
