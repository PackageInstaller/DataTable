local HardLevelChapterView = class("HardLevelChapterView", import("..HardLevelBaseView"))

function HardLevelChapterView:GetHardLevelItem()
	return HardLevelChapterItem
end

function HardLevelChapterView:OnExit()
	HardLevelChapterView.super.OnExit(self)
	self:ShowRedPoint(true)
end

function HardLevelChapterView:ShowDifficultPanel(arg_3_1)
	HardLevelChapterView.super.ShowDifficultPanel(self, arg_3_1)
	self:ShowRedPoint(arg_3_1)
end

function HardLevelChapterView:ShowRedPoint(arg_4_1)
	if not arg_4_1 then
		if not self.isBind_ then
			manager.redPoint:bindUIandKey(self.transform_, RedPointConst.COMBAT_PLOT)

			self.isBind_ = true
		end
	elseif self.isBind_ then
		manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.COMBAT_PLOT)

		self.isBind_ = false
	end
end

return HardLevelChapterView
