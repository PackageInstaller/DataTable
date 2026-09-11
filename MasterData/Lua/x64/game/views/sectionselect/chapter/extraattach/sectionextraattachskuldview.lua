SectionExtraAttachBaseView = import("game.views.sectionSelect.chapter.extraAttach.SectionExtraAttachBaseView")

local SectionSkuldExtraAttachView = class("SectionSkuldExtraAttachView", SectionExtraAttachBaseView)

function SectionSkuldExtraAttachView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.parent_ = arg_1_1
	self.gameObject_ = Object.Instantiate(Asset.Load(arg_1_2), arg_1_3.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function SectionSkuldExtraAttachView:OnEnter()
	self:AddMoveFollowTimer()
	SetActive(self.gameObject_, true)
end

function SectionSkuldExtraAttachView:OnExit()
	self:StopMoveFollowTimer()

	self.imageFlag_ = nil

	self:RemoveTween()
	SetActive(self.gameObject_, false)
end

function SectionSkuldExtraAttachView:AddListeners()
	return
end

function SectionSkuldExtraAttachView:RefreshUI()
	return
end

function SectionSkuldExtraAttachView:CheckSkuldBtn()
	return
end

function SectionSkuldExtraAttachView:AddMoveFollowTimer()
	local var_7_0 = BattleChapterStageCfg[ChapterCfg[self.parent_.chapterID_].section_id_list[#ChapterCfg[self.parent_.chapterID_].section_id_list]].position[1] - self.parent_.viewportRect_.rect.width / 2
	local var_7_1 = ChapterCfg[self.parent_.chapterID_].max_width

	var_7_1 = ChapterCfg[self.parent_.chapterID_].max_width == 0 and (self.parent_.bgTf_.rect.width - self.parent_.viewportRect_.rect.width) / 2 or var_7_1 - ChapterCfg[self.parent_.chapterID_].max_width / 2
	self.imagePanelTf_.localPosition = Vector3(self.parent_.contentRect_.localPosition.x * var_7_1 / var_7_0, 0, 0)

	self:StopMoveFollowTimer()

	self.moveFollowTimer_ = FrameTimer.New(function()
		self.imagePanelTf_.localPosition = Vector3(self.parent_.contentRect_.localPosition.x * var_7_1 / var_7_0, 0, 0)

		self:CheckImage()
	end, 1, -1)

	self.moveFollowTimer_:Start()
end

function SectionSkuldExtraAttachView:StopMoveFollowTimer()
	if self.moveFollowTimer_ then
		self.moveFollowTimer_:Stop()

		self.moveFollowTimer_ = nil
	end
end

function SectionSkuldExtraAttachView:CheckImage()
	if ChapterCfg[self.parent_.chapterID_].switch_bg_index == 0 then
		return
	end

	if self.parent_.contentRect_.localPosition.x * -1 < BattleChapterStageCfg[ChapterCfg[self.parent_.chapterID_].section_id_list[ChapterCfg[self.parent_.chapterID_].switch_bg_index - 1]].position[1] - self.parent_.viewportRect_.rect.width / 2 and self.imageFlag_ ~= 1 then
		self.imageFlag_ = 1

		self:SwitchMiddleGB(1)
	elseif self.parent_.contentRect_.localPosition.x * -1 > BattleChapterStageCfg[ChapterCfg[self.parent_.chapterID_].section_id_list[ChapterCfg[self.parent_.chapterID_].switch_bg_index + 1]].position[1] - self.parent_.viewportRect_.rect.width / 2 and self.imageFlag_ ~= 2 then
		self.imageFlag_ = 2

		self:SwitchMiddleGB(2)
	end
end

function SectionSkuldExtraAttachView:SwitchMiddleGB(arg_11_1)
	if self.imageFlag_ == nil then
		self.bgCanvas1_.alpha = arg_11_1 ~= 1 and 1 or 0
		self.bgCanvas2_.alpha = arg_11_1 == 1 and 1 or 0

		return
	end

	self:RemoveTween()

	self.tween_ = arg_11_1 == 1 and LeanTween.value(self.gameObject_, 1, 0, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
		self.bgCanvas2_.alpha = arg_12_0
		self.bgCanvas1_.alpha = 1 - arg_12_0
	end)):setOnComplete(System.Action(function()
		self.bgCanvas2_.alpha = 0

		self:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine) or LeanTween.value(self.gameObject_, 1, 0, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_14_0)
		self.bgCanvas1_.alpha = arg_14_0
		self.bgCanvas2_.alpha = 1 - arg_14_0
	end)):setOnComplete(System.Action(function()
		self.bgCanvas1_.alpha = 0

		self:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine)
end

function SectionSkuldExtraAttachView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

return SectionSkuldExtraAttachView
