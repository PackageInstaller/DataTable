local MultHeartDemonListItem = class("MultHeartDemonListItem", ReduxView)

function MultHeartDemonListItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MultHeartDemonListItem:Init()
	self:InitUI()
end

function MultHeartDemonListItem:InitUI()
	self:BindCfgUI()

	if self.headItem_ then
		self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	end

	self.rankController_ = self.conExCollection_ and self.conExCollection_:GetController("rank") or ControllerUtil.GetController(self.transform_, "rank")

	if self.viewBtn_ then
		self:AddBtnListener(self.viewBtn_, nil, function()
			JumpTools.OpenPageByJump("MultHeartDemonRankSquads", {
				data = self.data
			})
		end)
	end
end

function MultHeartDemonListItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.index = arg_5_2
	self.data = arg_5_1
	self.type = arg_5_3

	self:UpdateView()
end

function MultHeartDemonListItem:UpdateView()
	if self.data == nil then
		self.rankController_:SetSelectedState("5")

		self.rankText_.text = ""

		return
	end

	self.nickText_.text = self.data.nick
	self.rankText_.text = self.data.rank

	self.rankController_:SetSelectedState(tostring(self.data.rank > 3 and 0 or self.data.rank))
	self[self.type == 2 and "UpdateRankView" or "UpdateMainView"](self)
end

function MultHeartDemonListItem:UpdateRankView()
	self.finishTimeText_.text = manager.time:DescCdTime2(self.data.staticInfo.clearTime)

	self.commonPortrait_:RenderHead(self.data.portrait)
	self.commonPortrait_:RenderFrame(self.data.frame)

	self.gradeText_.text = self.data.score
	self.hitDamageText_.text = self.data.staticInfo.hitNumber
end

function MultHeartDemonListItem:UpdateMainView()
	return
end

function MultHeartDemonListItem:OnEnter()
	self:UpdateView()
end

function MultHeartDemonListItem:Dispose()
	if self.commonPortrait_ then
		self.commonPortrait_:Dispose()
	end

	MultHeartDemonListItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return MultHeartDemonListItem
