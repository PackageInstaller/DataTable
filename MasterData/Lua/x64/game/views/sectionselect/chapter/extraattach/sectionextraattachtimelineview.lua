SectionExtraAttachBaseView = import("game.views.sectionSelect.chapter.extraAttach.SectionExtraAttachBaseView")

local SectionExtraAttachTimelineView = class("SectionExtraAttachTimelineView", SectionExtraAttachBaseView)

function SectionExtraAttachTimelineView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.parent_ = arg_1_1
	self.gameObject_ = Object.Instantiate(Asset.Load(arg_1_2), arg_1_3.transform)
	self.transform_ = self.gameObject_.transform
	self.playableDirector_ = self.gameObject_:GetComponent(typeof(PlayableDirector))
end

function SectionExtraAttachTimelineView:OnEnter()
	self:AddMoveFollowTimer()
	SetActive(self.gameObject_, true)
end

function SectionExtraAttachTimelineView:OnExit()
	self:StopMoveFollowTimer()
	SetActive(self.gameObject_, false)
end

function SectionExtraAttachTimelineView:AddMoveFollowTimer()
	local var_4_0 = BattleChapterStageCfg[ChapterCfg[self.parent_.chapterID_].section_id_list[#ChapterCfg[self.parent_.chapterID_].section_id_list]].position[1] - self.parent_.viewportRect_.rect.width + self.parent_.viewportRect_.rect.width / 4

	self:Play(var_4_0)

	self.moveFollowTimer_ = FrameTimer.New(function()
		self:Play(var_4_0)
	end, 1, -1)

	self.moveFollowTimer_:Start()
end

function SectionExtraAttachTimelineView:Play(arg_6_1)
	local var_6_0 = -1 * self.parent_.contentRect_.localPosition.x / arg_6_1
	local var_6_1 = ChapterCfg[self.parent_.chapterID_]
	local var_6_2 = ChapterTools.GetUnclearStageCnt(self.parent_.chapterID_)

	if -1 * self.parent_.contentRect_.localPosition.x / arg_6_1 < 0 then
		var_6_0 = 0
	elseif var_6_0 > 1 then
		var_6_0 = 1
	end

	local var_6_3 = 1

	if type(var_6_1.unlock_scroll_rate) == "table" then
		for iter_6_0, iter_6_1 in ipairs(var_6_1.unlock_scroll_rate) do
			if #var_6_1.section_id_list - var_6_2 < iter_6_1[1] then
				var_6_3 = iter_6_1[2]

				break
			end
		end
	end

	if var_6_3 < var_6_0 then
		var_6_0 = var_6_3
	end

	self.playableDirector_.time = self.playableDirector_.duration * var_6_0

	self.playableDirector_:Evaluate()
end

function SectionExtraAttachTimelineView:StopMoveFollowTimer()
	if self.moveFollowTimer_ then
		self.moveFollowTimer_:Stop()

		self.moveFollowTimer_ = nil
	end
end

return SectionExtraAttachTimelineView
