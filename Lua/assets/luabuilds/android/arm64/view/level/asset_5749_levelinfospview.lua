local LevelInfoSPView = class("LevelInfoSPView", import(".LevelInfoView"))

function LevelInfoSPView:getUIName()
	return "LevelInfoSPUI"
end

function LevelInfoSPView:InitUI()
	LevelInfoSPView.super.InitUI(self)

	self.levelBanner = self._tf:Find("panel/Level")
	self.btnSwitchNormal = self._tf:Find("panel/Difficulty/Normal")
	self.btnSwitchHard = self._tf:Find("panel/Difficulty/Hard")
	self.tfAnim = self._tf:GetComponent(typeof(Animation))
	self.tfAniEvent = self._tf:GetComponent(typeof(DftAniEvent))

	self.tfAniEvent:SetEndEvent(function()
		self:playSelectFX()

		return
	end)

	self.diffBtn = self._tf:Find("panel/Difficulty")
	self.btnAnim = self._tf:Find("panel/Difficulty"):GetComponent(typeof(Animation))
	self.btnAniEvent = self._tf:Find("panel/Difficulty"):GetComponent(typeof(DftAniEvent))

	self.btnAniEvent:SetEndEvent(function()
		self:playButtonLoopFX()

		return
	end)

	self.btnAnimNormal = self._tf:Find("panel/Difficulty/Mask_Normal")
	self.btnAnimHard = self._tf:Find("panel/Difficulty/Mask_Difficlty")
	self.btnAnimLoopNormal = self._tf:Find("panel/Difficulty/Normal/Mask_Normal_Loop/Image")
	self.btnAnimLoopHard = self._tf:Find("panel/Difficulty/Hard/Mask_Difficulty_Loop")
	self.doEaseIn = false

	return
end

function LevelInfoSPView:playSelectFX()
	local var_5_0 = 1

	if #self.groupInfo > 1 then
		var_5_0 = table.indexof(self.groupInfo, self.chapter.id)
	elseif self.chapter:IsSpChapter() or self.chapter:IsEXChapter() then
		var_5_0 = 2
	end

	if #self.groupInfo > 1 then
		if var_5_0 == 2 then
			setActive(self.btnAnimNormal, false)
			setActive(self.btnAnimLoopNormal, false)
			quickPlayAnimation(self.diffBtn, "Anim_LevelInfoSPUI_DifficultySelected")
		else
			setActive(self.btnAnimHard, false)
			setActive(self.btnAnimLoopHard, false)
			quickPlayAnimation(self.diffBtn, "Anim_LevelInfoSPUI_NormalSelected")
		end
	end

	return
end

function LevelInfoSPView:playButtonLoopFX()
	if self.btnAnim:IsPlaying("Anim_LevelInfoSPUI_DifficultySelected") then
		quickPlayAnimation(self.diffBtn, "Anim_LevelInfoSPUI_DifficultyInLoop")
	elseif self.btnAnim:IsPlaying("Anim_LevelInfoSPUI_NormalSelected") then
		quickPlayAnimation(self.diffBtn, "Anim_LevelInfoSPUI_NormalInLoop")
	end

	return
end

function LevelInfoSPView:SetChapterGroupInfo(arg_7_1)
	self.groupInfo = arg_7_1

	return
end

function LevelInfoSPView:Show()
	pg.UIMgr.GetInstance():BlurPanel(self._tf, {
		force = true
	})
	setActive(self._tf, true)
	quickPlayAnimation(self._tf, "Anim_LevelInfoSPUI_in")

	return
end

function LevelInfoSPView:set(arg_9_1, arg_9_2)
	LevelInfoSPView.super.set(self, arg_9_1, arg_9_2)

	local var_9_0 = getProxy(ChapterProxy):getChapterById(arg_9_1, true)
	local var_9_1 = self.groupInfo

	assert(self.groupInfo)

	local var_9_2 = {
		"Normal",
		"Hard"
	}
	local var_9_3 = 1
	local var_9_4

	if #var_9_1 > 1 then
		local var_9_5 = table.indexof(var_9_1, arg_9_1)

		var_9_3 = var_9_5
		var_9_4 = var_9_1[#var_9_1 - var_9_5 + 1]
	elseif var_9_0:IsSpChapter() or var_9_0:IsEXChapter() then
		var_9_3 = 2
	end

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		setActive(self.titleBG:Find(iter_9_1), iter_9_0 == var_9_3)
	end

	for iter_9_2, iter_9_3 in ipairs(var_9_2) do
		setActive(self.levelBanner:Find(iter_9_3), iter_9_2 == var_9_3)
	end

	setActive(self.btnSwitchNormal, #var_9_1 > 1 and var_9_3 == 1)
	setActive(self.btnSwitchHard, #var_9_1 > 1 and var_9_3 == 2)

	if #var_9_1 > 1 then
		for iter_9_4 = 1, 2 do
			local var_9_6 = ((var_9_3 == 1 or nil) and (self.btnSwitchNormal or self.btnSwitchHard)):Find("Bonus" .. iter_9_4)
			local var_9_7 = getProxy(ChapterProxy):getChapterById(var_9_1[iter_9_4], true)
			local var_9_8 = var_9_7:GetDailyBonusQuota()

			setActive(var_9_6, var_9_8)

			if var_9_8 then
				self.loader:GetSprite("ui/levelmainscene_atlas", getProxy(ChapterProxy):getMapById(var_9_7:getConfig("map")):getConfig("type") == Map.ACTIVITY_HARD and "bonus_us_hard" or "bonus_us", var_9_6:Find("Image"))
			end
		end
	end

	local var_9_9 = var_9_3 == 1 and Color.NewHex("FFDE38") or Color.white

	setTextColor(self.txTitle:Find("title_index"), var_9_9)
	setTextColor(self.txTitle:Find("title"), var_9_9)
	setTextColor(self.txTitle:Find("title_en"), var_9_9)

	local var_9_10 = var_9_0:getConfig("boss_expedition_id")

	if var_9_0:getPlayType() == ChapterConst.TypeMultiStageBoss then
		var_9_10 = pg.chapter_model_multistageboss[var_9_0.id].boss_expedition_id
	end

	setText(self.levelBanner:Find("Text"), "LV " .. pg.expedition_data_template[var_9_10[#var_9_10]].level)
	onButton(self, self.btnSwitchNormal:Find("Switch"), function()
		setActive(self.btnAnimNormal, false)
		setActive(self.btnAnimLoopNormal, false)
		quickPlayAnimation(self.diffBtn, "Anim_LevelInfoSPUI_DifficultySelected")
		self:emit(LevelUIConst.SWITCH_SPCHAPTER_DIFFICULTY, var_9_4)
		self:set(var_9_4)

		return
	end, SFX_PANEL)
	onButton(self, self.btnSwitchHard:Find("Switch"), function()
		setActive(self.btnAnimHard, false)
		setActive(self.btnAnimLoopHard, false)
		quickPlayAnimation(self.diffBtn, "Anim_LevelInfoSPUI_NormalSelected")
		self:emit(LevelUIConst.SWITCH_SPCHAPTER_DIFFICULTY, var_9_4)
		self:set(var_9_4)

		return
	end, SFX_PANEL)
	;(function()
		if IsUnityEditor and not ENABLE_GUIDE then
			return
		end

		if var_9_3 ~= 1 or #var_9_1 == 1 then
			return
		end

		local var_12_0 = "NG0045"

		if pg.NewStoryMgr.GetInstance():IsPlayed("NG0045") then
			return
		end

		pg.SystemGuideMgr.GetInstance():PlayByGuideId(var_12_0)

		return
	end)()

	return
end

return LevelInfoSPView
