local ChapterChallengeItemView = class("ChapterChallengeItemView", import("..ChapterBaseItemView"))

function ChapterChallengeItemView:OnEnter()
	ChapterChallengeItemView.super.OnEnter(self)
	self:AddCountdown()
	self:AddRedPoint()
end

function ChapterChallengeItemView:OnExit()
	ChapterChallengeItemView.super.OnExit(self)
	self:RemoveCountdown()
	self:RemoveRedPoint()
end

function ChapterChallengeItemView:Dispose()
	ChapterChallengeItemView.super.Dispose(self)
end

function ChapterChallengeItemView:RefreshCustomItem(arg_4_1)
	if self.oldCfgID_ ~= arg_4_1.id then
		self.nameText_.text = GetI18NText(arg_4_1.name)

		SetSpriteWithoutAtlasAsync(self.icon_, arg_4_1.drop_icon)

		self.oldCfgID_ = arg_4_1.id
	end
end

function ChapterChallengeItemView:AddCountdown()
	return
end

function ChapterChallengeItemView:RemoveCountdown()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ChapterChallengeItemView:GetLostTime()
	return 0
end

function ChapterChallengeItemView:ClickItem(arg_8_1)
	local var_8_0

	if self:CheckLock() then
		do return end

		var_8_0 = {}
	end

	var_8_0.chapterID = ChapterClientCfg[arg_8_1].chapter_list[1]

	self:Go("/challenge", var_8_0)
end

function ChapterChallengeItemView:AddRedPoint()
	manager.redPoint:bindUIandKey(self.panelTf_, ChapterTools.GetRedPoint(self.chapterClientID_))
end

function ChapterChallengeItemView:RemoveRedPoint()
	manager.redPoint:unbindUIandKey(self.panelTf_)
end

return ChapterChallengeItemView
