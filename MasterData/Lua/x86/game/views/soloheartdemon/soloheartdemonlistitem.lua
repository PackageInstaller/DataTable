local SoloHeartDemonListItem = class("SoloHeartDemonListItem", ReduxView)

function SoloHeartDemonListItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SoloHeartDemonListItem:Init()
	self:InitUI()
end

function SoloHeartDemonListItem:InitUI()
	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.rankController_ = self.conExCollection_ and self.conExCollection_:GetController("rank") or ControllerUtil.GetController(self.transform_, "rank")
end

function SoloHeartDemonListItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.index = arg_4_2
	self.data = arg_4_1
	self.type = arg_4_3

	self:UpdateView()
end

function SoloHeartDemonListItem:UpdateView()
	if self.data == nil then
		self.rankController_:SetSelectedState("5")

		self.rankText_.text = ""

		return
	end

	self.nickText_.text = self.data.nick
	self.rankText_.text = self.data.rank

	self.rankController_:SetSelectedState(tostring(self.data.rank > 3 and 0 or self.data.rank))
	self.commonPortrait_:RenderHead(self.data.portrait)
	self.commonPortrait_:RenderFrame(self.data.frame)
	self[self.type == 2 and "UpdateRankView" or "UpdateMainView"](self)
end

function SoloHeartDemonListItem:UpdateRankView()
	self.finishTimeText_.text = manager.time:DescCdTime2(self.data.staticInfo.clearTime)
	self.gradeText_.text = self.data.score
	self.hitDamageText_.text = self.data.staticInfo.hitNumber
end

function SoloHeartDemonListItem:UpdateMainView()
	return
end

function SoloHeartDemonListItem:OnEnter()
	self:UpdateView()
end

function SoloHeartDemonListItem:Dispose()
	self.commonPortrait_:Dispose()
	SoloHeartDemonListItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return SoloHeartDemonListItem
