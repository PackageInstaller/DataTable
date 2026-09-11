ChapterSectionView = import("game.views.sectionSelect.chapter.ChapterSectionView")

local ChapterSectionRollBgView = class("ChapterSectionRollBgView", ChapterSectionView)

function ChapterSectionRollBgView:OnEnter()
	ChapterSectionRollBgView.super.OnEnter(self)
	self.bgTypeController_:SetSelectedState("roll")
	self:SwitchBG()
end

function ChapterSectionRollBgView:RefreshUI()
	ChapterSectionRollBgView.super.RefreshUI(self)
	self:SwitchBG()
end

function ChapterSectionRollBgView:SwitchBG()
	self:AddRollBG()
end

function ChapterSectionRollBgView:AddRollBG()
	if self.rollBgPath and self.rollBgPath == ChapterCfg[self.chapterID_].bg then
		self:UpdateBgWidth()
		self:OnScrollValueChanged(true)

		return
	elseif self.rollBg then
		GameObject.Destroy(self.rollBg)

		self.rollBg = nil
	end

	if not self.rollBg then
		self.rollBg = GameObject.Instantiate(Asset.Load(ChapterCfg[self.chapterID_].bg), self.rollnodebgTrs_)
		self.rollBgTrs = self.rollBg.transform
		self.rollBgPos = self.rollBgTrs.localPosition
		self.bgWidth = self.rollBgTrs:Find("panel/bg"):GetComponent("RectTransform").sizeDelta.x
	end

	self:UpdateBgWidth()

	self.rollBgPath = ChapterCfg[self.chapterID_].bg
end

function ChapterSectionRollBgView:UpdateBgWidth()
	if self.bgWidth then
		self.bgMaxWidth = (self.bgWidth - manager.ui.canvasSize_.x) * self:CalcuteStageOpenProgress()
	end
end

function ChapterSectionRollBgView:FindMaxScrollPos()
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(ChapterCfg[self.chapterID_].section_id_list) do
		local var_6_1 = self:GetCfgName()[iter_6_1]

		if var_6_1.position ~= "" then
			local var_6_2 = var_6_1.position[1] or 0

			if var_6_0 < var_6_2 then
				var_6_0 = var_6_2
			end
		end
	end

	return var_6_0
end

function ChapterSectionRollBgView:CalcuteStageOpenProgress()
	return (self:GetScrollWidth() + self.viewportRect_.rect.width / 4) / (self:FindMaxScrollPos() + self.viewportRect_.rect.width / 4)
end

function ChapterSectionRollBgView:OnScrollValueChanged(arg_8_1)
	if not arg_8_1 and self.contentRect_.rect.width < self.viewportRect_.rect.width then
		return
	end

	if self.rollBg and self.rollBgPos then
		local var_8_0 = -self.scrollMoveView_.scrollView_.horizontalNormalizedPosition * self.bgMaxWidth

		if -self.scrollMoveView_.scrollView_.horizontalNormalizedPosition * self.bgMaxWidth > 0 then
			var_8_0 = 0
		end

		if var_8_0 < -self.bgMaxWidth then
			var_8_0 = -self.bgMaxWidth
		end

		self.rollBgPos.x = var_8_0
		self.rollBgTrs.localPosition = self.rollBgPos
	end
end

function ChapterSectionRollBgView:OnExit()
	ChapterSectionRollBgView.super.OnExit(self)

	self.rollBgPath = nil

	if self.rollBg then
		GameObject.Destroy(self.rollBg)

		self.rollBg = nil
	end
end

return ChapterSectionRollBgView
