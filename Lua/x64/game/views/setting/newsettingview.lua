local var_0_0 = class("SettingView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Setting/SettingUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()

	arg_3_0.selectIndex = -1
	arg_3_0.pages = {}
end

function var_0_0.OnPicSettingChange(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.pages.Graphic then
		arg_4_0.pages.Graphic:OnPicSettingChange(arg_4_1, arg_4_2)
	end
end

function var_0_0.OnSoundSettingChange(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.pages.Sound then
		arg_5_0.pages.Sound:OnSoundSettingChange(arg_5_1, arg_5_2)
	end

	if arg_5_0.pages.Game then
		arg_5_0.pages.Game:OnSoundSettingChange(arg_5_1, arg_5_2)
	end
end

function var_0_0.OnPushSettingChange(arg_6_0, arg_6_1, arg_6_2)
	return
end

function var_0_0.OnGameSettingChange(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.pages.Game then
		arg_7_0.pages.Game:OnGameSettingChange(arg_7_1, arg_7_2)
	end
end

function var_0_0.OnDownloaded(arg_8_0, arg_8_1)
	if arg_8_0.pages.Sound then
		arg_8_0.pages.Sound:OnDownloaded(arg_8_1)
	end
end

function var_0_0.OnCancalDownload(arg_9_0)
	if arg_9_0.pages.Sound then
		arg_9_0.pages.Sound:OnCancalDownload()
	end
end

function var_0_0.OnRemindChange(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.pages.Remind then
		arg_10_0.pages.Remind:OnRemindChange(arg_10_1, arg_10_2)
	end
end

function var_0_0.OnCooperationRestrictUpdate(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.pages.Remind then
		arg_11_0.pages.Remind:OnCooperationRestrictUpdate()
	end
end

function var_0_0.OnPolyhedronSwitchHero(arg_12_0)
	if arg_12_0.pages.PolyhedronTeamInfo then
		arg_12_0.pages.PolyhedronTeamInfo:OnPolyhedronSwitchHero()
	end
end

function var_0_0.OnAssetPendDownloadEnd(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.pages.AssetPend then
		arg_13_0.pages.AssetPend:OnAssetPendDownloadEnd(arg_13_1, arg_13_2)
	end
end

function var_0_0.InitUI(arg_14_0)
	arg_14_0:BindCfgUI()

	arg_14_0.toggleList = LuaList.New(handler(arg_14_0, arg_14_0.IndexItem), arg_14_0.m_list, SettingToggleItem)
end

function var_0_0.AddListeners(arg_15_0)
	arg_15_0:AddBtnListenerScale(arg_15_0.resetBtn_, nil, function()
		arg_15_0.curPage:RecoverTmpData()
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.resetDefBtn_, nil, function()
		if arg_15_0.curPage.ResetDefaultData then
			arg_15_0.curPage:ResetDefaultData()
		end
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.quitBattleBtn_, nil, function()
		local var_18_0

		if arg_15_0.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM then
			var_18_0 = GetTips("POLYHEDRON_BATTLE_GIVE_UP_AND_SETTLE")
		else
			var_18_0 = GetTips("GIVE_UP_BATTLE")
		end

		local var_18_1

		if arg_15_0.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.ASH_BATTLE then
			var_18_1 = "Widget/System/Activity_EkChuah/EkChuah_Com/EkChuah_Com_PopUI"
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = var_18_0,
			OkCallback = function()
				gameContext:DestroyCurRoutes()

				if arg_15_0.params_.stageData:GetIsCooperation() then
					local var_19_0 = BattleFieldData:GetServerBattleID()

					CooperationAction.LeaveCooperationBattle(function(arg_20_0)
						BattleInstance.QuitBattle(arg_15_0.params_.stageData, true, true)
					end, var_19_0)
				else
					LuaExchangeHelper.GameOver(3)
				end
			end,
			prefabPath = var_18_1
		})
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.restartBtn_, nil, function()
		manager.audio:DestoryCriAtom()

		arg_15_0.isRestartFlag_ = true

		BattleController.GetInstance():LaunchBattle(arg_15_0.params_.stageData, nil, nil, true)
		LuaForCursor.SwitchCursor(false)
	end)
	arg_15_0:AddBtnListenerScale(arg_15_0.polyhedronSettlementBtn_, nil, function()
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
	arg_15_0:AddBtnListenerScale(arg_15_0.polyhedronQuitBtn_, nil, function()
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

function var_0_0.OnTop(arg_28_0)
	arg_28_0:RefreshQuitType()
end

function var_0_0.OnEnter(arg_29_0)
	arg_29_0.toggles = arg_29_0:GetToggleList()

	table.sort(arg_29_0.toggles, function(arg_30_0, arg_30_1)
		return arg_30_0:Order() < arg_30_1:Order()
	end)
	arg_29_0:RefreshBtns()
	arg_29_0.toggleList:StartScroll(#arg_29_0.toggles)

	local var_29_0 = arg_29_0.params_.toggleName
	local var_29_1 = 1

	if var_29_0 then
		for iter_29_0, iter_29_1 in ipairs(arg_29_0.toggles) do
			if iter_29_1:GetName() == var_29_0 then
				var_29_1 = iter_29_0

				break
			end
		end
	end

	arg_29_0:SetSelectPage(var_29_1)
	arg_29_0:RefreshQuitType()

	if arg_29_0.pages.Sound then
		arg_29_0.pages.Sound:OnEnter()
	end
end

function var_0_0.OnExit(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.pages) do
		iter_31_1:OnExit()
	end

	if arg_31_0.isSystem_ then
		manager.windowBar:HideBar()
	else
		manager.windowBar:HideBar()
		LuaExchangeHelper.ApplyBattleSetting()
		arg_31_0:BackFunc()

		if arg_31_0.isRestartFlag_ then
			arg_31_0.isRestartFlag_ = false
		else
			LuaExchangeHelper.ContinueGame()
		end
	end

	arg_31_0.isSystem_ = nil
	arg_31_0.selectIndex = -1

	arg_31_0:RecordStay(arg_31_0.params_.selectType)
end

function var_0_0.RecordStay(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0:GetStayTime()

	if var_32_0 == 0 then
		return
	end

	local var_32_1 = 0

	if arg_32_1 == "screen" then
		local var_32_2 = 10201

		OperationRecorder.RecordStayView("STAY_VIEW_SETTING", var_32_0, var_32_2)
	elseif arg_32_1 == "sound" then
		local var_32_3 = 10202

		OperationRecorder.RecordStayView("STAY_VIEW_SETTING", var_32_0, var_32_3)
	elseif arg_32_1 == "game" then
		local var_32_4 = 10203

		OperationRecorder.RecordStayView("STAY_VIEW_SETTING", var_32_0, var_32_4)
	elseif arg_32_1 == "skill" then
		local var_32_5 = arg_32_0.pages.skill and arg_32_0.pages.skill.nType or 1

		arg_32_0:RecordStaySkill(var_32_5)
	end

	arg_32_0:UpdateLastOpenTime()
end

function var_0_0.RecordStaySkill(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:GetStayTime()

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
	arg_33_0:UpdateLastOpenTime()
end

function var_0_0.IndexItem(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0.toggles[arg_34_1]

	arg_34_2:SetData(arg_34_1, var_34_0)
	arg_34_2:SetSelect(arg_34_0.selectIndex)
	arg_34_2:RegistCallBack(handler(arg_34_0, arg_34_0.SetSelectPage))
end

function var_0_0.SetSelectPage(arg_35_0, arg_35_1)
	if arg_35_1 == arg_35_0.selectIndex then
		return
	end

	arg_35_1 = math.min(arg_35_1, #arg_35_0.toggles)
	arg_35_0.selectIndex = arg_35_1

	local var_35_0 = arg_35_0.toggleList:GetItemList()

	for iter_35_0, iter_35_1 in ipairs(var_35_0) do
		iter_35_1:SetSelect(arg_35_0.selectIndex)
	end

	arg_35_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_36_0)
	if arg_36_0.curPage then
		arg_36_0.curPage:SetActive(false)
	end

	local var_36_0 = arg_36_0.selectIndex
	local var_36_1 = arg_36_0.toggles[var_36_0]
	local var_36_2 = var_36_1:GetName()

	if not arg_36_0.pages[var_36_2] then
		local var_36_3 = var_36_1:GetParams()
		local var_36_4 = Asset.Load(var_36_1:GetPath())
		local var_36_5 = Object.Instantiate(var_36_4, arg_36_0.m_content)

		arg_36_0.pages[var_36_2] = var_36_1:UIClass().New(arg_36_0, var_36_5, var_36_3)
	end

	arg_36_0.curPage = arg_36_0.pages[var_36_2]

	arg_36_0.curPage:SetActive(true)

	if arg_36_0.curPage.class == GraphicSettingPCView or arg_36_0.curPage.class == GraphicSettingView then
		arg_36_0.curPage:RefreshUI()
	end

	SetActive(arg_36_0.resetGo_, var_36_1:IsSetting())
	SetActive(arg_36_0.resetDefGo_, arg_36_0.curPage.ResetDefaultData ~= nil)
end

function var_0_0.RefreshQuitType(arg_37_0)
	if arg_37_0.isSystem_ then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			NAVI_BAR
		})
		manager.windowBar:RegistBackCallBack(function()
			arg_37_0:BackFunc(function()
				arg_37_0:Back()
			end)
		end)
		manager.windowBar:RegistHomeCallBack(function()
			arg_37_0:BackFunc(function()
				arg_37_0:Go("/home")
			end)
		end)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
		manager.windowBar:RegistBackCallBack(function()
			arg_37_0:BackFunc()

			if arg_37_0:GetIsContinuousFight() then
				arg_37_0:Back()
			else
				gameContext:DestroyCurRoutes()
			end
		end)
	end
end

function var_0_0.GetIsContinuousFight(arg_43_0)
	if arg_43_0.isSystem_ or arg_43_0.params_.stageData == nil then
		return false
	end

	return arg_43_0.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON
end

function var_0_0.BackFunc(arg_44_0, arg_44_1)
	local var_44_0 = false

	for iter_44_0, iter_44_1 in pairs(arg_44_0.pages) do
		if iter_44_1.CheckDataChange and iter_44_1:CheckDataChange() then
			var_44_0 = true
		end
	end

	if var_44_0 then
		for iter_44_2, iter_44_3 in pairs(arg_44_0.pages) do
			if iter_44_3.SaveData then
				iter_44_3:SaveData()
			end
		end

		OperationRecorder.Record(arg_44_0.class.__cname, "panel/btn_save")
	end

	if arg_44_1 then
		arg_44_1()
	end
end

function var_0_0.GetToggleList(arg_45_0)
	local var_45_0 = arg_45_0.params_.setType or SettingConst.SETTING_TYPE.SYSTEM
	local var_45_1 = arg_45_0.params_.stageData

	arg_45_0.isSystem_ = var_45_0 == SettingConst.SETTING_TYPE.SYSTEM

	local var_45_2 = {}

	if arg_45_0.isSystem_ then
		table.insert(var_45_2, GraphicSettingToggle.New())
	end

	if var_45_1 and not arg_45_0.isSystem_ and (var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX) then
		table.insert(var_45_2, IntelligenceSettingToggle.New({
			arg_45_0.params_
		}))
	end

	table.insert(var_45_2, SoundSettingToggle.New())
	table.insert(var_45_2, GameSettingToggle.New(arg_45_0.params_))

	if not arg_45_0.isSystem_ then
		local var_45_3 = var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL
		local var_45_4 = var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON
		local var_45_5 = var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STRONGHOLD
		local var_45_6 = var_45_1 and (var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS)
		local var_45_7 = var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.ARTIFACT
		local var_45_8 = var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL
		local var_45_9 = var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM
		local var_45_10 = var_45_1 and var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME

		if not var_45_3 and not var_45_4 and not var_45_5 and not var_45_6 and not var_45_7 and not var_45_8 and not var_45_9 and not var_45_10 then
			local var_45_11 = {}

			if var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.RACE_TRIAL then
				local var_45_12 = var_45_1:GetActivityID()
				local var_45_13 = RaceTrialData:GetCustomList(var_45_12)
				local var_45_14

				for iter_45_0, iter_45_1 in ipairs(var_45_13) do
					local var_45_15 = ActivityAffixPoolCfg[iter_45_1].affix

					table.insert(var_45_11, {
						var_45_15[1],
						var_45_15[2]
					})
				end
			else
				var_45_11 = var_45_1:GetSettingShowAffix()
			end

			if #var_45_11 > 0 then
				table.insert(var_45_2, AffixSettingToggle.New({
					affixData = var_45_11,
					stageData = var_45_1
				}))
			end
		end
	end

	if not arg_45_0.isSystem_ and var_45_1 and var_45_1:GetType() ~= BattleConst.STAGE_TYPE_NEW.LEVIATHAN_GAME and var_45_1:GetType() ~= BattleConst.STAGE_TYPE_NEW.SKADI_GAME and var_45_1:GetType() ~= BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME and not table.keyof(GameSetting.setting_need_not_skill_info.value, var_45_1:GetStageId()) then
		local var_45_16 = GetSceneDataForExcehange().roleDataInLua[0]

		if var_45_16 then
			local var_45_17 = SkinCfg[var_45_16.ID] and SkinCfg[var_45_16.ID].hero

			if not HeroCfg[var_45_17] or HeroCfg[var_45_17].hide_info == 0 then
				table.insert(var_45_2, SkillSettingToggle.New({
					stageData = var_45_1
				}))
			end
		end
	end

	if not arg_45_0.isSystem_ and var_45_1 and (var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX or var_45_1:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS) then
		table.insert(var_45_2, ArtifactSettingToggle.New({
			stageData = var_45_1
		}))
	end

	table.insert(var_45_2, OperationSettingToggle.New())

	if arg_45_0.isSystem_ then
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

	local var_45_18 = #manager.assetPend:GetAssetPendList() > 0

	if arg_45_0.isSystem_ and var_45_18 then
		arg_45_0.assetPendToggle_ = AssetPendSettingToggle.New()

		table.insert(var_45_2, arg_45_0.assetPendToggle_)
	end

	return var_45_2
end

function var_0_0.RefreshBtns(arg_46_0)
	local var_46_0 = arg_46_0.params_.setType or SettingConst.SETTING_TYPE.SYSTEM
	local var_46_1 = arg_46_0.params_.stageData

	arg_46_0.isSystem_ = var_46_0 == SettingConst.SETTING_TYPE.SYSTEM

	local var_46_2

	if var_46_1 then
		var_46_2 = var_46_1:GetType()
	end

	SetActive(arg_46_0.restartGo_, not arg_46_0.isSystem_ and var_46_1 and (var_46_2 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or var_46_2 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE or var_46_2 == BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON or var_46_2 == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON or var_46_2 == BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE or var_46_2 == BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE2 or var_46_2 == BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE3 or var_46_2 == BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE4))
	SetActive(arg_46_0.quitBattleGo_, not arg_46_0.isSystem_ and not arg_46_0.params_.newbie and var_46_2 ~= BattleConst.STAGE_TYPE_NEW.POLYHEDRON)
	SetActive(arg_46_0.polyhedronSettlementGo_, not arg_46_0.isSystem_ and var_46_1 and var_46_2 == BattleConst.STAGE_TYPE_NEW.POLYHEDRON)
	SetActive(arg_46_0.polyhedronQuitGo_, not arg_46_0.isSystem_ and var_46_1 and var_46_2 == BattleConst.STAGE_TYPE_NEW.POLYHEDRON)

	if not arg_46_0.isSystem_ and var_46_1 and var_46_2 == BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM then
		arg_46_0.exitBtnText_.text = GetTips("EXIT_AND_SETTLEMENT")

		if not ChallengeRogueTeamData:IsFinishGuide() then
			SetActive(arg_46_0.quitBattleGo_, false)
		end
	end
end

function var_0_0.Dispose(arg_47_0)
	arg_47_0.toggleList:Dispose()

	for iter_47_0, iter_47_1 in pairs(arg_47_0.pages) do
		iter_47_1:Dispose()
	end

	arg_47_0.pages = {}

	var_0_0.super.Dispose(arg_47_0)
end

function var_0_0.OnExitInput(arg_48_0)
	if not arg_48_0.isSystem_ then
		if arg_48_0:GetIsContinuousFight() then
			arg_48_0:Back()
		else
			gameContext:DestroyCurRoutes()
		end

		LuaExchangeHelper.ContinueGame()

		return true
	end
end

function var_0_0.JumpToLanguageManageUI(arg_49_0)
	if arg_49_0.assetPendToggle_ then
		arg_49_0:SetSelectPage(table.indexof(arg_49_0.toggles, arg_49_0.assetPendToggle_))
		arg_49_0.pages.AssetPend:GoToLanguageManage()
	end
end

return var_0_0
