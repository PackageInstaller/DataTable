local OsirisPlayGameChapterItem = class("OsirisPlayGameChapterItem", ReduxView)

function OsirisPlayGameChapterItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.index = arg_1_2

	self:Init()
end

function OsirisPlayGameChapterItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function OsirisPlayGameChapterItem:InitUI()
	self:BindCfgUI()

	self.stateCon_ = self.controllerEx_:GetController("status")
	self.starCon_1 = self.starCtrl_1:GetController("star")
	self.starCon_2 = self.starCtrl_2:GetController("star")
	self.starCon_3 = self.starCtrl_3:GetController("star")
end

function OsirisPlayGameChapterItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.index > 1 and not OsirisPlayGameData:IsPassChaptersById(self.index - 1) then
			ShowTips("CAPTURE_GAME_PRE_SECTION_UNREACHED")

			return
		end

		JumpTools.OpenPageByJump("/osirisPlayGameStageView", {
			chapterID = self.index
		})
	end)
end

function OsirisPlayGameChapterItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function OsirisPlayGameChapterItem:RefreshView()
	for iter_7_0 = 1, 3 do
		self["starCon_" .. iter_7_0]:SetSelectedIndex(0)
	end

	self.firstUnlockChapterId = OsirisPlayGameData:GetFirstUnlock()

	local var_7_0 = ActivityGeneralityChapterCfg[self.index]

	self.anim_:Play("UI_unlock_cx_01", -1, 0)
	self.anim_:Update(0)

	if self.index == 1 then
		self.stateCon_:SetSelectedIndex(1)
	elseif OsirisPlayGameData:IsPassChaptersById(self.index - 1) then
		if self.firstUnlockChapterId == self.index then
			self.stateCon_:SetSelectedIndex(0)

			self.timer_ = Timer.New(function()
				self:StopTimer()
				self.stateCon_:SetSelectedIndex(1)
				self.anim_:Play("UI_unlock_cx_01", -1, 0)
				self.anim_:Update(0)
				OsirisPlayGameData:SetFirstUnlock(0)
			end, 1.8, 1)

			self.timer_:Start()
		else
			self.stateCon_:SetSelectedIndex(1)
		end
	else
		self.stateCon_:SetSelectedIndex(0)
	end

	local var_7_1 = OsirisPlayGameData:GetPassStagesNumByChapterId(self.index)

	for iter_7_1 = 1, var_7_1 > 3 and 3 or var_7_1 do
		self["starCon_" .. iter_7_1]:SetSelectedIndex(1)
	end

	if var_7_0 then
		self.skillTxt_1.text = GetI18NText(var_7_0.chapter_name)
		self.skillTxt_2.text = GetI18NText(var_7_0.chapter_name)
		self.skillImg_1.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Osiris/" .. var_7_0.icon)
		self.skillImg_2.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Osiris/" .. var_7_0.icon)
	end
end

function OsirisPlayGameChapterItem:OnExit()
	self:StopTimer()
	OsirisPlayGameChapterItem.super.OnExit(self)
end

function OsirisPlayGameChapterItem:Dispose()
	self:RemoveAllListeners()
	OsirisPlayGameChapterItem.super.Dispose(self)
end

return OsirisPlayGameChapterItem
