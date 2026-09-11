local ChapterClueItem = class("ChapterClueItem", ReduxView)

function ChapterClueItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.positionController_ = self.controllerEx_:GetController("position")
	self.geryController_ = self.controllerEx_:GetController("get")
end

function ChapterClueItem:SetData(arg_2_1, arg_2_2)
	self.clueID_ = arg_2_1

	if arg_2_1 == 0 then
		self.nameText_.text = ""

		self.geryController_:SetSelectedState("false")
	else
		self.nameText_.text = StageArchiveCfg[arg_2_1].name

		self.geryController_:SetSelectedState("true")
	end

	if arg_2_2 % 2 == 1 then
		self.positionController_:SetSelectedState("state0")
	else
		self.positionController_:SetSelectedState("state1")
	end
end

function ChapterClueItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.clueID_ == 0 then
			ShowTips("COLLECTION_CULE_AND_READ")

			return
		end

		JumpTools.OpenPageByJump("stageArchive", {
			isClue = true,
			archiveID = self.clueID_
		})
	end)
end

function ChapterClueItem:Dispose()
	ChapterClueItem.super.Dispose(self)
end

return ChapterClueItem
