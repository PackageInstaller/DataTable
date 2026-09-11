local ChapterResidentActItem = class("ChapterResidentActItem", ReduxView)

function ChapterResidentActItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChapterResidentActItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChapterResidentActItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.controllerEx_:GetController("select")
	self.stateController_ = self.controllerEx_:GetController("state")
end

function ChapterResidentActItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallback then
			self.clickCallback(self, self)
		end
	end)
end

function ChapterResidentActItem:SetData(arg_6_1)
	self.chapterID = arg_6_1
	self.paintImage_.spriteAsync = "TextureConfig/Chapter/" .. ChapterClientCfg[arg_6_1].chapter_paint

	self.stateController_:SetSelectedState(ChapterResidentTools.GetResidentActFinishState((self:GetActID())) and "completed" or "normal")
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.RESIDENT_ACT .. self:GetActID())
end

function ChapterResidentActItem:SetClickCallback(arg_7_1)
	if arg_7_1 then
		self.clickCallback = arg_7_1
	end
end

function ChapterResidentActItem:GetChapterID()
	return self.chapterID
end

function ChapterResidentActItem:GetActID()
	return ChapterClientCfg[self.chapterID].activity_id
end

function ChapterResidentActItem:UpdateSelectState(arg_10_1)
	self.selectController_:SetSelectedState(arg_10_1 and "true" or "false")
end

function ChapterResidentActItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.RESIDENT_ACT .. self:GetActID())
end

function ChapterResidentActItem:Dispose()
	ChapterResidentActItem.super.Dispose(self)
end

return ChapterResidentActItem
