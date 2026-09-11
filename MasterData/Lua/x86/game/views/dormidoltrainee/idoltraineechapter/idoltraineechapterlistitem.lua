local IdolTraineeChapterListItem = class("IdolTraineeChapterListItem", ReduxView)

function IdolTraineeChapterListItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function IdolTraineeChapterListItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
end

function IdolTraineeChapterListItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if not self.closeClick then
			JumpTools.OpenPageByJump("/idolTraineeLevelMainView", {
				chapterID = self.chapterID_
			})
		end
	end)
end

function IdolTraineeChapterListItem:SetData(arg_5_1, arg_5_2)
	self.chapterID_ = arg_5_1
	self.closeClick = arg_5_2

	local var_5_0, var_5_1 = IdolTraineeTools:GetChapterProgress(arg_5_1)

	self.progress_.text = string.format("%s/%s", var_5_0, var_5_1)
	self.name_.text = IdolTraineeChapterCfg[arg_5_1].title
end

function IdolTraineeChapterListItem:Dispose()
	IdolTraineeChapterListItem.super.Dispose(self)
end

return IdolTraineeChapterListItem
