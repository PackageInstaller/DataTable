local SettingView = class("SettingView", ReduxView)

function SettingView:UIName()
	return "Widget/System/Setting/SettingUI"
end

function SettingView:UIParent()
	return manager.ui.uiMain.transform
end

function SettingView:Init()
	self:InitUI()
	self:AddListeners()

	self.selectIndex = -1
	self.pages = {}
end

function SettingView:OnPicSettingChange(arg_4_1, arg_4_2)
	if self.pages.Graphic then
		self.pages.Graphic:OnPicSettingChange(arg_4_1, arg_4_2)
	end
end

function SettingView:OnSoundSettingChange(arg_5_1, arg_5_2)
	if self.pages.Sound then
		self.pages.Sound:OnSoundSettingChange(arg_5_1, arg_5_2)
	end

	if self.pages.Game then
		self.pages.Game:OnSoundSettingChange(arg_5_1, arg_5_2)
	end
end

function SettingView:OnPushSettingChange(arg_6_1, arg_6_2)
	return
end

function SettingView:OnGameSettingChange(arg_7_1, arg_7_2)
	if self.pages.Game then
		self.pages.Game:OnGameSettingChange(arg_7_1, arg_7_2)
	end
end

function SettingView:OnDownloaded(arg_8_1)
	if self.pages.Sound then
		self.pages.Sound:OnDownloaded(arg_8_1)
	end
end

function SettingView:OnCancalDownload()
	if self.pages.Sound then
		self.pages.Sound:OnCancalDownload()
	end
end

function SettingView:OnRemindChange(arg_10_1, arg_10_2)
	if self.pages.Remind then
		self.pages.Remind:OnRemindChange(arg_10_1, arg_10_2)
	end
end

function SettingView:OnCooperationRestrictUpdate(arg_11_1, arg_11_2)
	if self.pages.Remind then
		self.pages.Remind:OnCooperationRestrictUpdate()
	end
end

function SettingView:OnPolyhedronSwitchHero()
	if self.pages.PolyhedronTeamInfo then
		self.pages.PolyhedronTeamInfo:OnPolyhedronSwitchHero()
	end
end

function SettingView:OnAssetPendDownloadEnd(arg_13_1, arg_13_2)
	if self.pages.AssetPend then
		self.pages.AssetPend:OnAssetPendDownloadEnd(arg_13_1, arg_13_2)
	end
end

function SettingView:InitUI()
	self:BindCfgUI()

	self.toggleList = LuaList.New(handler(self, self.IndexItem), self.m_list, SettingToggleItem)
end

function SettingView:AddListeners()
	self:AddBtnListenerScale(self.resetBtn_, nil, function()
		self.curPage:RecoverTmpData()
	end)
	self:AddBtnListenerScale(self.resetDefBtn_, nil, function()
		if self.curPage.ResetDefaultData then
			self.curPage:ResetDefaultData()
		end
	end)
	self:AddBtnListenerScale(self.quitBattleBtn_, nil, function()
		local var_18_0 = self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM and GetTips("POLYHEDRON_BATTLE_GIVE_UP_AND_SETTLE") or GetTips("GIVE_UP_BATTLE")

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = var_18_0,
			OkCallback = function()
				gameContext:DestroyCurRoutes()

				if self.params_.stageData:GetIsCooperation() then
					CooperationAction.LeaveCooperationBattle(function(arg_20_0)
						BattleInstance.QuitBattle(self.params_.stageData, true, true)
					end, (BattleFieldData:GetServerBattleID()))
				else
					LuaExchangeHelper.GameOver(3)
				end
			end,
			prefabPath = (self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.ASH_BATTLE or nil) and "Widget/System/Activity_EkChuah/EkChuah_Com/EkChuah_Com_PopUI"
		})
	end)
	self:AddBtnListenerScale(self.restartBtn_, nil, function()
		manager.audio:DestoryCriAtom()

		self.isRestartFlag_ = true

		BattleController.GetInstance():LaunchBattle(self.params_.stageData, nil, nil, true)
		LuaForCursor.SwitchCursor(false)
	end)
	self:AddBtnListenerScale(self.polyhedronSettlementBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("POLYHEDRON_BATTLE_GIVE_UP_AND_SETTLE"),
			OkCallback = function()
				PolyhedronAction.QueryPolyhedronGiveUp(function(arg_24_0)
					if isSuccess(arg_24_0.result) then
						manager.audio:PlayBGM("ui_battle", "ui_battle_lose", "ui_battle.awb")
						manager.audio:PlayEffect("ui_battle", "ui_battle_ultimate_out", "")
						manager.audio:PlayEffect("ui_skip", "ui_reset", "")
						AudioManager.Instance:DestoryPlayer("effect")
						DestroyLua()
						LuaExchangeHelper.GoToMain()
						OpenPageUntilLoaded("/polyhedronBlank/polyhedronOver", {})
					else
						ShowMessageBox({
							title = GetTips("PROMPT"),
							content = GetTips(arg_24_0.result) .. "\n" .. GetTips("GIVE_UP_BATTLE"),
							OkCallback = function()
								DestroyLua()
								LuaExchangeHelper.GoToMain()
								OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
							end
						})
					end
				end)
			end
		})
	end)
	self:AddBtnListenerScale(self.polyhedronQuitBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_BATTLE"),
			OkCallback = function()
				manager.audio:PlayBGM("ui_battle", "ui_battle_lose", "ui_battle.awb")
				manager.audio:PlayEffect("ui_battle", "ui_battle_ultimate_out", "")
				manager.audio:PlayEffect("ui_skip", "ui_reset", "")
				AudioManager.Instance:DestoryPlayer("effect")
				DestroyLua()
				LuaExchangeHelper.GoToMain()
				OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
			end
		})
	end)
end

function SettingView:OnTop()
	self:RefreshQuitType()
end

function SettingView:OnEnter()
	self.toggles = self:GetToggleList()

	table.sort(self.toggles, function(arg_30_0, arg_30_1)
		return arg_30_0:Order() < arg_30_1:Order()
	end)
	self:RefreshBtns()
	self.toggleList:StartScroll(#self.toggles)

	local var_29_0 = 1

	if self.params_.toggleName then
		for iter_29_0, iter_29_1 in ipairs(self.toggles) do
			if iter_29_1:GetName() == self.params_.toggleName then
				var_29_0 = iter_29_0

				break
			end
		end
	end

	self:SetSelectPage(var_29_0)
	self:RefreshQuitType()

	if self.pages.Sound then
		self.pages.Sound:OnEnter()
	end
end

function SettingView:OnExit()
	for iter_31_0, iter_31_1 in pairs(self.pages) do
		iter_31_1:OnExit()
	end

	if self.isSystem_ then
		manager.windowBar:HideBar()
	else
		manager.windowBar:HideBar()
		LuaExchangeHelper.ApplyBattleSetting()
		self:BackFunc()

		if self.isRestartFlag_ then
			self.isRestartFlag_ = false
		else
			LuaExchangeHelper.ContinueGame()
		end
	end

	self.isSystem_ = nil
	self.selectIndex = -1

	self:RecordStay(self.params_.selectType)
end

function SettingView:RecordStay(arg_32_1)
	local var_32_0 = self:GetStayTime()

	if var_32_0 == 0 then
		return
	end

	if arg_32_1 == "screen" then
		OperationRecorder.RecordStayView("STAY_VIEW_SETTING", var_32_0, 10201)
	elseif arg_32_1 == "sound" then
		OperationRecorder.RecordStayView("STAY_VIEW_SETTING", var_32_0, 10202)
	elseif arg_32_1 == "game" then
		OperationRecorder.RecordStayView("STAY_VIEW_SETTING", var_32_0, 10203)
	elseif arg_32_1 == "skill" then
		self:RecordStaySkill((self.pages.skill or nil) and (self.pages.skill.nType or 1))
	end

	self:UpdateLastOpenTime()
end

function SettingView:RecordStaySkill(arg_33_1)
	local var_33_0 = self:GetStayTime()

	if var_33_0 == 0 then
		return
	end

	local var_33_1 = 0

	if arg_33_1 == 1 then
		var_33_1 = 50201
	elseif arg_33_1 == 2 then
		var_33_1 = 50202
	end

	OperationRecorder.RecordStayView("STAY_VIEW_SETTING_SKILL", var_33_0, var_33_1)
	self:UpdateLastOpenTime()
end

function SettingView:IndexItem(arg_34_1, arg_34_2)
	arg_34_2:SetData(arg_34_1, self.toggles[arg_34_1])
	arg_34_2:SetSelect(self.selectIndex)
	arg_34_2:RegistCallBack(handler(self, self.SetSelectPage))
end

function SettingView:SetSelectPage(arg_35_1)
	if arg_35_1 == self.selectIndex then
		return
	end

	arg_35_1 = math.min(arg_35_1, #self.toggles)
	self.selectIndex = arg_35_1

	for iter_35_0, iter_35_1 in ipairs((self.toggleList:GetItemList())) do
		iter_35_1:SetSelect(self.selectIndex)
	end

	self:RefreshUI()
end

function SettingView:RefreshUI()
	if self.curPage then
		self.curPage:SetActive(false)
	end

	local var_36_0 = self.toggles[self.selectIndex]
	local var_36_1 = self.toggles[self.selectIndex]:GetName()

	self.pages[var_36_1] = self.pages[var_36_1] or var_36_0:UIClass().New(self, Object.Instantiate(Asset.Load(var_36_0:GetPath()), self.m_content), (var_36_0:GetParams()))
	self.curPage = self.pages[var_36_1]

	self.curPage:SetActive(true)

	if self.curPage.class == GraphicSettingPCView or self.curPage.class == GraphicSettingView then
		self.curPage:RefreshUI()
	end

	SetActive(self.resetGo_, var_36_0:IsSetting())
	SetActive(self.resetDefGo_, self.curPage.ResetDefaultData ~= nil)
end

function SettingView:RefreshQuitType()
	if self.isSystem_ then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			NAVI_BAR
		})
		manager.windowBar:RegistBackCallBack(function()
			self:BackFunc(function()
				self:Back()
			end)
		end)
		manager.windowBar:RegistHomeCallBack(function()
			self:BackFunc(function()
				self:Go("/home")
			end)
		end)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
		manager.windowBar:RegistBackCallBack(function()
			self:BackFunc()

			if self:GetIsContinuousFight() then
				self:Back()
			else
				gameContext:DestroyCurRoutes()
			end
		end)
	end
end

function SettingView:GetIsContinuousFight()
	if self.isSystem_ or self.params_.stageData == nil then
		return false
	end

	return self.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON
end

function SettingView:BackFunc(arg_44_1)
	local var_44_0 = false

	for iter_44_0, iter_44_1 in pairs(self.pages) do
		if iter_44_1.CheckDataChange and iter_44_1:CheckDataChange() then
			var_44_0 = true
		end
	end

	if var_44_0 then
		for iter_44_2, iter_44_3 in pairs(self.pages) do
			if iter_44_3.SaveData then
				iter_44_3:SaveData()
			end
		end

		OperationRecorder.Record(self.class.__cname, "panel/btn_save")
	end

	if arg_44_1 then
		arg_44_1()
	end
end

function SettingView:GetToggleList()
	local var_45_1 = self.params_.stageData

	self.isSystem_ = (self.params_.setType or SettingConst.SETTING_TYPE.SYSTEM) == SettingConst.SETTING_TYPE.SYSTEM

	local var_45_2 = {}

	if self.isSystem_ then
		table.insert(var_45_2, GraphicSettingToggle.New())
	end

	if var_45_1 and not self.isSystem_ and (var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX) then
		table.insert(var_45_2, IntelligenceSettingToggle.New({
			self.params_
		}))
	end

	table.insert(var_45_2, SoundSettingToggle.New())
	table.insert(var_45_2, GameSettingToggle.New(self.params_))

	if not self.isSystem_ then
		local var_45_3 = var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON
		local var_45_4 = var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STRONGHOLD
		local var_45_5 = var_45_1 and (var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS)
		local var_45_6 = var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.ARTIFACT

		if not (var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL) and not var_45_3 and not var_45_4 and not var_45_5 and not var_45_6 and not (var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL) and not (var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM) and not (var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME) then
			local var_45_9 = {}

			if var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.RACE_TRIAL then
				for iter_45_0, iter_45_1 in ipairs((RaceTrialData:GetCustomList((var_45_1:GetActivityID())))) do
					table.insert(var_45_9, {
						ActivityAffixPoolCfg[iter_45_1].affix[1],
						ActivityAffixPoolCfg[iter_45_1].affix[2]
					})
				end
			else
				var_45_9 = var_45_1:GetSettingShowAffix()
			end

			if #var_45_9 > 0 then
				table.insert(var_45_2, AffixSettingToggle.New({
					affixData = var_45_9,
					stageData = var_45_1
				}))
			end
		end
	end

	if not self.isSystem_ and var_45_1 and var_45_1:GetType() ~= BattleConst.STAGE_TYPE_NEW.LEVIATHAN_GAME and var_45_1:GetType() ~= BattleConst.STAGE_TYPE_NEW.SKADI_GAME and var_45_1:GetType() ~= BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME and not table.keyof(GameSetting.setting_need_not_skill_info.value, var_45_1:GetStageId()) then
		local var_45_11 = GetSceneDataForExcehange().roleDataInLua[0]

		if var_45_11 then
			local var_45_12 = SkinCfg[var_45_11.ID] and SkinCfg[var_45_11.ID].hero

			if not HeroCfg[var_45_12] or HeroCfg[var_45_12].hide_info == 0 then
				table.insert(var_45_2, SkillSettingToggle.New({
					stageData = var_45_1
				}))
			end
		end
	end

	if not self.isSystem_ and var_45_1 and (var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS) then
		table.insert(var_45_2, ArtifactSettingToggle.New({
			stageData = var_45_1
		}))
	end

	table.insert(var_45_2, OperationSettingToggle.New())

	if self.isSystem_ then
		table.insert(var_45_2, RemindSettingToggle.New())
	end

	if var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON then
		table.insert(var_45_2, PolyhedronAdditionSettingToggle.New())
	end

	if var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON then
		table.insert(var_45_2, PolyhedronTeamInfoSettingToggle.New())
	end

	if var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON then
		table.insert(var_45_2, PolyhedronHeroInfoSettingToggle.New())
	end

	if var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM then
		table.insert(var_45_2, RogueTeamItemInfoSettingToggle.New())
	end

	if var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM then
		table.insert(var_45_2, RogueTeamHeroInfoSettingToggle.New())
	end

	if self.isSystem_ and #manager.assetPend:GetAssetPendList() > 0 then
		self.assetPendToggle_ = AssetPendSettingToggle.New()

		table.insert(var_45_2, self.assetPendToggle_)
	end

	return var_45_2
end

function SettingView:RefreshBtns()
	local var_46_1 = self.params_.stageData

	self.isSystem_ = (self.params_.setType or SettingConst.SETTING_TYPE.SYSTEM) == SettingConst.SETTING_TYPE.SYSTEM

	local var_46_2

	if var_46_1 then
		var_46_2 = var_46_1:GetType()
	end

	SetActive(self.restartGo_, not self.isSystem_ and var_46_1 and (var_46_2 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or var_46_2 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE or var_46_2 == BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON or var_46_2 == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON or var_46_2 == BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE or var_46_2 == BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE2 or var_46_2 == BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE3 or var_46_2 == BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE4))
	SetActive(self.quitBattleGo_, not self.isSystem_ and not self.params_.newbie and var_46_2 ~= BattleConst.STAGE_TYPE_NEW.POLYHEDRON)
	SetActive(self.polyhedronSettlementGo_, not self.isSystem_ and var_46_1 and var_46_2 == BattleConst.STAGE_TYPE_NEW.POLYHEDRON)
	SetActive(self.polyhedronQuitGo_, not self.isSystem_ and var_46_1 and var_46_2 == BattleConst.STAGE_TYPE_NEW.POLYHEDRON)

	if not self.isSystem_ and var_46_1 and var_46_2 == BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM then
		self.exitBtnText_.text = GetTips("EXIT_AND_SETTLEMENT")

		if not ChallengeRogueTeamData:IsFinishGuide() then
			SetActive(self.quitBattleGo_, false)
		end
	end
end

function SettingView:Dispose()
	self.toggleList:Dispose()

	for iter_47_0, iter_47_1 in pairs(self.pages) do
		iter_47_1:Dispose()
	end

	self.pages = {}

	SettingView.super.Dispose(self)
end

function SettingView:OnExitInput()
	if not self.isSystem_ then
		if self:GetIsContinuousFight() then
			self:Back()
		else
			gameContext:DestroyCurRoutes()
		end

		LuaExchangeHelper.ContinueGame()

		return true
	end
end

function SettingView:JumpToLanguageManageUI()
	if self.assetPendToggle_ then
		self:SetSelectPage(table.indexof(self.toggles, self.assetPendToggle_))
		self.pages.AssetPend:GoToLanguageManage()
	end
end

return SettingView
