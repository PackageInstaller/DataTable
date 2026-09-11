local TetrisGameRankItem = class("TetrisGameRankItem", ReduxView)

function TetrisGameRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function TetrisGameRankItem:Init()
	self:InitUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.skillListGo_, TetrisGameSkillIconItem)

	self:AddUIListener()
end

function TetrisGameRankItem:IndexItem(arg_3_1, arg_3_2)
	arg_3_2:RefreshUI(self.skillList_[arg_3_1])
	arg_3_2:RegisterClickFunc(handler(self, self.OnClickSkillItem))
end

function TetrisGameRankItem:OnClickSkillItem(arg_4_1)
	JumpTools.OpenPageByJump("tetrisGameGetSkillView", {
		skillList = self.skillList_,
		skillID = arg_4_1
	})
end

function TetrisGameRankItem:InitUI()
	self:BindCfgUI()
end

function TetrisGameRankItem:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1
	self.data_ = arg_6_2

	self:UpdateView()
end

function TetrisGameRankItem:UpdateView()
	self.userID_ = self.data_.id
	self.nickText_.text = GetI18NText(self.data_.nick)
	self.rankText_.text = tostring(self.index_)
	self.scoreText_.text = self.data_.score

	self.commonPortrait_:RenderHead(self.data_.portrait)
	self.commonPortrait_:RenderFrame(self.data_.frame)

	self.skillList_ = self.data_.extraInfo

	self.uiList_:StartScroll(#self.skillList_)
end

function TetrisGameRankItem:AddUIListener()
	return
end

function TetrisGameRankItem:AddEventListeners()
	return
end

function TetrisGameRankItem:Dispose()
	self.commonPortrait_:Dispose()

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	TetrisGameRankItem.super.Dispose(self)
end

return TetrisGameRankItem
