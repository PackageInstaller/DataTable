local OsirisPlayGameStageItem = class("OsirisPlayGameStageItem", ReduxView)
local var_0_1 = {
	[1] = "IS_CAPTAIN",
	[2] = "IS_SUPPORT"
}

function OsirisPlayGameStageItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.index = arg_1_2

	self:Init()
end

function OsirisPlayGameStageItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function OsirisPlayGameStageItem:InitUI()
	self:BindCfgUI()

	self.stateCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("state")
	self.typeCon_ = self.typeControllerEx_:GetController("type")
end

function OsirisPlayGameStageItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		local var_5_0 = ActivityGeneralityStageCfg[self.stageId]

		if ActivityGeneralityStageCfg[self.stageId] then
			local var_5_1 = var_5_0.pre_stage or 1

			if OsirisPlayGameData:IsPassStagesByStageId(var_5_1) or var_5_1 == 0 then
				OsirisPlayGameData:InitTempHeroData()
				JumpTools.OpenPageByJump("/osirisPlayGameSectionSelectHeroView", {
					section = var_5_0.stage_id,
					sectionType = BattleConst.STAGE_TYPE_NEW.OSIRIS_PLAY_GAME,
					activityID = var_5_0.activity_id,
					heroDataType = HeroConst.HERO_DATA_TYPE.OSIRISPLAYGAME
				})

				goto label_5_0
			end
		end

		ShowTips("CAPTURE_GAME_PRE_SECTION_UNREACHED")

		::label_5_0::
	end)
end

function OsirisPlayGameStageItem:RefreshView(arg_6_1, arg_6_2, arg_6_3)
	self.stageId = arg_6_1

	local var_6_0 = ActivityGeneralityStageCfg[arg_6_1]
	local var_6_1 = ActivityGeneralityStageCfg[arg_6_1].unlock_charactor

	if ActivityGeneralityStageCfg[arg_6_1].pre_stage == 0 then
		self.stateCon_:SetSelectedIndex(OsirisPlayGameData:IsPassStagesByStageId(var_6_0.stage_id) and 2 or 1)

		if not ActivityGeneralityCharactorCfg[var_6_1] then
			self.stateCon_:SetSelectedIndex(OsirisPlayGameData:IsPassStagesByStageId(var_6_0.stage_id) and 5 or 4)
		end
	elseif OsirisPlayGameData:IsPassStagesByStageId(var_6_0.pre_stage) and OsirisPlayGameData:IsPassStagesByStageId(var_6_0.stage_id) then
		if var_6_0.stage_id == arg_6_2 and arg_6_3 == false and OsirisPlayGameData:GetPassStageClearTimesByStageId(var_6_0.stage_id) == 0 then
			if OsirisPlayGameData:IsPassStagesByStageId(var_6_0.pre_stage) then
				self.stateCon_:SetSelectedIndex(1)

				if not ActivityGeneralityCharactorCfg[var_6_1] then
					self.stateCon_:SetSelectedIndex(4)
				end
			end

			self.timer_ = Timer.New(function()
				self.stateCon_:SetSelectedIndex(2)

				if not ActivityGeneralityCharactorCfg[var_6_1] then
					self.stateCon_:SetSelectedIndex(5)
				end

				self.animGo_:Play("UI_complete_cx", -1, 0)
				self.animGo_:Update(0)
				self:StopTimer()
			end, 2.5, 1)

			self.timer_:Start()
		else
			self.stateCon_:SetSelectedIndex(2)

			if not ActivityGeneralityCharactorCfg[var_6_1] then
				self.stateCon_:SetSelectedIndex(5)
			end
		end
	elseif OsirisPlayGameData:IsPassStagesByStageId(var_6_0.pre_stage) then
		self.stateCon_:SetSelectedIndex(1)

		if not ActivityGeneralityCharactorCfg[var_6_1] then
			self.stateCon_:SetSelectedIndex(4)
		end
	else
		self.stateCon_:SetSelectedIndex(0)

		if not ActivityGeneralityCharactorCfg[var_6_1] then
			self.stateCon_:SetSelectedIndex(3)
		end
	end

	self.skillNameTxt_.text = GetI18NText(var_6_0.name)
	self.skillDescTxt_.text = GetI18NText(var_6_0.desc)

	if ActivityGeneralityCharactorCfg[var_6_1] then
		self.typeTxt_.text = GetTips(var_0_1[ActivityGeneralityCharactorCfg[var_6_1].charactor_type])
		self.heroIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. var_6_1)
		self.campIcon_.sprite = getSprite("Atlas/SystemGroupAtlas", (string.format("com_white_icon_group_%d_c", HeroCfg[var_6_1].race)))
		self.descTxt_.text = HeroTools.GetHeroFullName(var_6_1)

		self.typeCon_:SetSelectedIndex(ActivityGeneralityCharactorCfg[var_6_1].charactor_type == 1 and 1 or 0)
	end
end

function OsirisPlayGameStageItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function OsirisPlayGameStageItem:OnExit()
	self:StopTimer()
	self.super.OnExit(self)
end

function OsirisPlayGameStageItem:Dispose()
	self:RemoveAllListeners()
	OsirisPlayGameStageItem.super.Dispose(self)
end

return OsirisPlayGameStageItem
