local AutoChessBattleView = class("AutoChessBattleView", ReduxView)

function AutoChessBattleView:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_AutoChess/Activity_OsirisHorus_BattleUI"
end

function AutoChessBattleView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessBattleView:Init()
	self:InitUI()
end

function AutoChessBattleView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
	self:InitController()
	self:InitCallback()
	self:InitSubView()
	self:InitChessFormation()
	self:InitFightTimeline()
end

function AutoChessBattleView:AddUIListener()
	self:AddBtnListener(self.playBtn_, nil, handler(self, self.OnClickPlayBtn))
	self:AddBtnListener(self.skipBtn_, nil, handler(self, self.OnClickSkipBtn))
	self:AddBtnListener(self.doubleSpeedBtn_, nil, handler(self, self.OnClickDoubleSpeedBtn))
	self:AddBtnListener(self.maskBtn_, nil, function()
		SetActive(self.maskBtn_.gameObject, false)
		self.tipsPanelView_:SetActive(false)
		self:OnClickCloseTips()
	end)
end

function AutoChessBattleView:InitController()
	self.bottomController_ = self.controllerEx_:GetController("bottom")
	self.typeController_ = self.controllerEx_:GetController("type")
	self.playBtnController_ = self.playBtnControllerEx_:GetController("status")
	self.doubleSpeedBtnController_ = self.speedBtnControllerEx_:GetController("speed")
end

function AutoChessBattleView:InitCallback()
	self.clickChessHandler_ = handler(self, self.OnPointerClick)
end

function AutoChessBattleView:InitSubView()
	self.chessContainPosX_ = -645
	self.playerSelfInfoView_ = AutoChessPlayerInfoView.New(self.playerSelfInfoViewGo_)
	self.playerOpponentInfoView_ = AutoChessPlayerInfoView.New(self.playerOpponentInfoViewGo_)
	self.tipsPanelView_ = AutoChessTipsPanelView.New(self.tipsPanelGo_)
	self.buffDamageEffectItemList_ = {}

	for iter_9_0 = 1, 5 do
		freeItem = AutoChessBuffDamageEffectItem.New((Object.Instantiate(self.buffDamageEffectGo_, self.damageEffectContain_, false)))

		table.insert(self.buffDamageEffectItemList_, freeItem)
	end
end

function AutoChessBattleView:InitChessFormation()
	self.chessItemPool_ = {}
	self.usingChessItemDic_ = {}
	self.selfEnterChessItemList_ = {}
	self.opEnterChessItemList_ = {}
	self.selfFormationView_ = AutoChessFormationItemView.New(self.selfFormationGo_)
	self.opponentFormationView_ = AutoChessFormationItemView.New(self.opFormationGo_)
	self.formationTrans_ = self.fightDirector_.transform
	self.checkDeathWhisperTimerList_ = {}
end

function AutoChessBattleView:InitFightTimeline()
	self.fightDirector_.enabled = false
	self.fightPlayable_ = self.fightDirector_.playableAsset
end

function AutoChessBattleView:OnExit()
	AnimatorTools.Stop()

	if self.enterTimer_ then
		self.enterTimer_:Stop()

		self.enterTimer_ = nil
	end

	for iter_12_0, iter_12_1 in pairs(self.checkDeathWhisperTimerList_) do
		iter_12_1:Stop()

		iter_12_1 = nil
	end

	self.checkDeathWhisperTimerList_ = {}
	self.isSkipBattle_ = false
	self.usingChessItemDic_ = {}
	self.selfEnterChessItemList_ = {}
	self.opEnterChessItemList_ = {}

	SetActive(self.leftGo_, false)
	SetActive(self.rightGo_, false)
	SetActive(self.maskBtn_.gameObject, false)
	self.tipsPanelView_:SetActive(false)
	self.typeController_:SetSelectedIndex(0)

	self.chessFormationCount_ = GameSetting.auto_chess_prepare_grid_num.value[1]
	self.bg.localScale = Vector3.New(0.76, 0.76, 0.76)
	self.formationTrans_.localScale = Vector3.New(0.97, 0.97, 0.97)
end

function AutoChessBattleView:Dispose()
	self.selfFormationView_:Dispose()
	self.opponentFormationView_:Dispose()
	self.playerSelfInfoView_:Dispose()
	self.playerOpponentInfoView_:Dispose()
	self.tipsPanelView_:Dispose()

	for iter_13_0, iter_13_1 in pairs(self.buffDamageEffectItemList_) do
		iter_13_1:Dispose()
		Object.Destroy(iter_13_1.gameObject_)
	end

	for iter_13_2, iter_13_3 in pairs(self.chessItemPool_) do
		if iter_13_3.item then
			iter_13_3.item:Dispose()
		end
	end

	self.chessItemPool_ = nil

	AutoChessBattleView.super.Dispose(self)
end

function AutoChessBattleView:OnEnter()
	self:Reset()
	self:SetupBattleRenderer()
	self:UpdateBattleView()
	self:StartFormationTween()
end

function AutoChessBattleView:Reset()
	self:ResetAnim()
end

function AutoChessBattleView:SetupBattleRenderer()
	AutoChessBattleRenderer.GetInstance():SetBattleView(self)

	self.blackboard_ = AutoChessBattleRenderer.GetInstance():GetBlackboard()
	self.gameType_ = self.blackboard_:GetGameType()
end

function AutoChessBattleView:UpdateBattleView()
	self.bottomController_:SetSelectedState(AutoChessTools.IsHideBottomButton() and "hide" or "show")
	self:RefreshBg()
	self:InitBtnStatus()
	self:UpdateFormationView()
	self:UpdatePlayerData()
end

function AutoChessBattleView:RefreshBg()
	local var_18_0, var_18_1, var_18_2 = AutoChessTools.GetStagBgPath((AutoChessTools.GetCurStageId(self.gameType_)))

	self.imgBg_.sprite = pureGetSpriteWithoutAtlas(var_18_0)
	self.imgMachine_.sprite = pureGetSpriteWithoutAtlas(var_18_1)
	self.imgFuzzy_.sprite = pureGetSpriteWithoutAtlas(var_18_2)
end

function AutoChessBattleView:StartSimulator()
	AutoChessBattleSimulator.GetInstance():StartBattleSimulator()
end

function AutoChessBattleView:GetFormationView(arg_20_1)
	if arg_20_1 == AutoChessConst.PLAYER_TYPE.SELF then
		return self.selfFormationView_
	elseif arg_20_1 == AutoChessConst.PLAYER_TYPE.OPPONENT then
		return self.opponentFormationView_
	end
end

function AutoChessBattleView:GetFreeDamageEffectItem()
	local var_21_0

	for iter_21_0, iter_21_1 in pairs(self.buffDamageEffectItemList_) do
		if iter_21_1:GetIsFree() then
			var_21_0 = iter_21_1

			break
		end
	end

	if var_21_0 == nil then
		var_21_0 = AutoChessBuffDamageEffectItem.New((Object.Instantiate(self.buffDamageEffectGo_, self.damageEffectContain_, false)))

		table.insert(self.buffDamageEffectItemList_, var_21_0)
	end

	return var_21_0
end

function AutoChessBattleView:UpdateFormationView()
	self.chessFormationCount_ = GameSetting.auto_chess_prepare_grid_num.value[1]

	self.selfFormationView_:SetGameType(self.gameType_)
	self.opponentFormationView_:SetPlayerType(AutoChessConst.PLAYER_TYPE.OPPONENT)
	self.opponentFormationView_:SetGameType(self.gameType_)
	self:UpdateChessItem()
end

function AutoChessBattleView:GetChessItemByUniqueId(arg_23_1)
	if self.usingChessItemDic_[arg_23_1] then
		return self.usingChessItemDic_[arg_23_1]
	end
end

function AutoChessBattleView:GetFormationItemByIndex(arg_24_1, arg_24_2)
	if arg_24_1 == AutoChessConst.PLAYER_TYPE.SELF then
		return self.selfFormationView_:GetPosItem(arg_24_2)
	elseif arg_24_1 == AutoChessConst.PLAYER_TYPE.OPPONENT then
		return self.opponentFormationView_:GetPosItem(arg_24_2)
	end
end

function AutoChessBattleView:RemoveChessItemByUniqueId(arg_25_1)
	if self.usingChessItemDic_[arg_25_1] and self.usingChessItemDic_[arg_25_1].chessItemData_.attributeData.hp <= 0 then
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_disappear", "")

		self.usingChessItemDic_[arg_25_1] = nil

		self:ReturnChessItem(self.usingChessItemDic_[arg_25_1])
	end
end

function AutoChessBattleView:CheckDeathWhisper(arg_26_1)
	if self.usingChessItemDic_[arg_26_1] == nil then
		return false
	end

	for iter_26_0, iter_26_1 in pairs(self.usingChessItemDic_[arg_26_1].chessItemData_:GetBuffList()) do
		if AutoChessBuffCfg[iter_26_1.buffId].keyword_type == AutoChessConst.BUFF_KEYWORD_TYPE.DEATH_WHISPE then
			return true
		end
	end

	return false
end

function AutoChessBattleView:UpdateChessItem()
	self:ResetChessItemPool()
	self:UpdateChessFormation(AutoChessConst.PLAYER_TYPE.SELF)
	self:UpdateChessFormation(AutoChessConst.PLAYER_TYPE.OPPONENT)
end

function AutoChessBattleView:ResetChessItemPool()
	for iter_28_0, iter_28_1 in ipairs(self.chessItemPool_) do
		iter_28_1.isFree = true

		iter_28_1.item:SetActive(false)
	end
end

function AutoChessBattleView:UpdateChessFormation(arg_29_1)
	local var_29_0 = self:GetFormationView(arg_29_1)
	local var_29_1 = {}

	for iter_29_0, iter_29_1 in pairs(AutoChessData:GetSimulatePlayerData(arg_29_1).chessDataDicByUniqueId) do
		table.insert(var_29_1, iter_29_1)
	end

	table.sort(var_29_1, function(arg_30_0, arg_30_1)
		return arg_30_0.index < arg_30_1.index
	end)

	for iter_29_2, iter_29_3 in ipairs(var_29_1) do
		local var_29_2 = self:CreateChessItem()

		iter_29_3.index = iter_29_2

		var_29_2:SetActive(true)
		var_29_2:SetParent(var_29_0:GetChessPanelTrans())
		var_29_2:SetLocalScale(Vector3.one)
		var_29_2:SetLocalPos(var_29_0:GetChessPos(iter_29_3.index))
		var_29_2:SetPlayerType(arg_29_1)
		var_29_2:SetData(iter_29_3)
		var_29_2:ShowGradeEffect()
		var_29_2:RegisterEvent("PointerClick", self.clickChessHandler_)

		self.usingChessItemDic_[iter_29_3.uniqueId] = var_29_2

		if arg_29_1 == AutoChessConst.PLAYER_TYPE.SELF then
			table.insert(self.selfEnterChessItemList_, var_29_2)
		else
			table.insert(self.opEnterChessItemList_, var_29_2)
		end
	end
end

function AutoChessBattleView:AddChess(arg_31_1, arg_31_2)
	local var_31_0 = self:GetFormationView(arg_31_1)
	local var_31_1 = self:CreateChessItem()

	var_31_1:SetActive(true)
	var_31_1:SetParent(var_31_0:GetChessPanelTrans())
	var_31_1:SetLocalScale(Vector3.one)
	var_31_1:SetLocalPos(var_31_0:GetChessPos(arg_31_2.index))
	var_31_1:SetPlayerType(arg_31_1)
	var_31_1:SetData(arg_31_2)
	var_31_1:ShowGradeEffect()
	var_31_1:RegisterEvent("PointerClick", self.clickChessHandler_)

	self.usingChessItemDic_[arg_31_2.uniqueId] = var_31_1

	return var_31_1
end

function AutoChessBattleView:PlayChangeBgAnim(arg_32_1)
	if not arg_32_1 or arg_32_1 <= self.chessFormationCount_ then
		return
	end

	local var_32_0 = {
		{
			index = 1,
			anim = "BgScale5_6"
		},
		{
			index = 2,
			anim = "BgScale5_7"
		},
		max = {
			index = 2,
			anim = "BgScale6_7"
		}
	}

	if self.chessFormationCount_ == GameSetting.auto_chess_prepare_grid_num.value[1] then
		local var_32_1 = var_32_0[arg_32_1 - GameSetting.auto_chess_prepare_grid_num.value[1]] or var_32_0.max

		if var_32_1 and self.typeController_ and self.bgAnim_ then
			self.typeController_:SetSelectedIndex(var_32_1.index)
			self.bgAnim_:Play(var_32_1.anim, -1, 0)
		end
	end

	self.chessFormationCount_ = math.max(self.chessFormationCount_, arg_32_1)
end

function AutoChessBattleView:GetChessFormationCount()
	return self.chessFormationCount_
end

function AutoChessBattleView:CreateChessItem()
	local var_34_0

	for iter_34_0, iter_34_1 in pairs(self.chessItemPool_) do
		if iter_34_1.isFree then
			iter_34_1.isFree = false
			var_34_0 = iter_34_1.item

			break
		end
	end

	if not var_34_0 then
		var_34_0 = AutoChessTeamItem.New((Object.Instantiate(self.chessItemGo_, self.chessItemGo_.transform.parent)))
		self.chessItemPool_[#self.chessItemPool_ + 1] = {
			isFree = false,
			item = var_34_0
		}
	end

	var_34_0:SetLocalPos(Vector3.New(9999, 9999, 0))

	return var_34_0
end

function AutoChessBattleView:ReturnChessItem(arg_35_1)
	for iter_35_0, iter_35_1 in pairs(self.chessItemPool_) do
		if arg_35_1 == iter_35_1.item then
			iter_35_1.isFree = true

			arg_35_1:Reset()
			arg_35_1:SetLocalPos(Vector3.New(9999, 9999, 0))
			arg_35_1:SetActive(false)

			break
		end
	end
end

function AutoChessBattleView:GetChessPosByPlayerType(arg_36_1, arg_36_2)
	if arg_36_1 == AutoChessConst.PLAYER_TYPE.SELF then
		return self.selfFormationView_:GetChessPos(arg_36_2)
	else
		return self.opponentFormationView_:GetChessPos(arg_36_2)
	end
end

function AutoChessBattleView:OnPointerClick(arg_37_1, arg_37_2)
	if self.isPlay_ then
		self.isTipPause_ = true

		self:OnClickPlayBtn()
	end

	SetActive(self.maskBtn_.gameObject, true)
	self.tipsPanelView_:SetData(arg_37_1)
	self.tipsPanelView_:SetGoldState(false)
	self.tipsPanelView_:SetPivot(0, 1)
	self.tipsPanelView_:SetPos((arg_37_2:GetPos()))
	AutoChessTools.ScreenAdapter(arg_37_2, self.tipsPanelView_)
	OperationRecorder.RecordButtonTouch({
		type = 1,
		button_name = "activity_autochess_combat_chess_touch",
		activity_id = AutoChessData:GetActivityID(),
		polyhedron_id_str = AutoChessData:GetSimulatePlayerData(AutoChessConst.PLAYER_TYPE.SELF).battleUID,
		other_data = AutoChessTools.GetChessTrackingPointStr(arg_37_1)
	})
end

function AutoChessBattleView:OnClickCloseTips()
	if self.isTipPause_ then
		self.isTipPause_ = false

		self:OnClickPlayBtn()
	end
end

function AutoChessBattleView:UpdatePlayerData()
	self:UpdateSelfPlayerData()
	self:UpdateOpponentPlayerData()
end

function AutoChessBattleView:UpdateSelfPlayerData()
	self.playerSelfInfoView_:SetGameType(self.gameType_)
	self.playerSelfInfoView_:SetData(AutoChessData:GetSimulatePlayerData(AutoChessConst.PLAYER_TYPE.SELF))
end

function AutoChessBattleView:UpdateOpponentPlayerData()
	local var_41_0 = AutoChessData:GetCurGameType() == AutoChessConst.GAME_TYPE.PVE

	self.playerOpponentInfoView_:SetGameType(self.gameType_)
	self.playerOpponentInfoView_:SetData(AutoChessData:GetSimulatePlayerData(AutoChessConst.PLAYER_TYPE.OPPONENT))
	self.playerOpponentInfoView_:SetHideData(var_41_0)
end

function AutoChessBattleView:InitBtnStatus()
	self.isPlay_ = true

	self.playBtnController_:SetSelectedState("play")

	self.isAccelerating_ = getData("AutoChess", "battleSpeed") == 1

	self.doubleSpeedBtnController_:SetSelectedState(self.isAccelerating_ and "2" or "1")
	AutoChessBattleRenderer.GetInstance():SetIsForceSpeedUp(false)
	AutoChessBattleRenderer.GetInstance():SetSpeed(self.isAccelerating_ and 2 or 1)
end

function AutoChessBattleView:OnClickPlayBtn()
	if self.isPlay_ then
		self.isPlay_ = false

		self.playBtnController_:SetSelectedState("pause")
		AutoChessBattleSimulator.GetInstance():Pause()
	else
		self.isPlay_ = true

		self.playBtnController_:SetSelectedState("play")
		AutoChessBattleSimulator.GetInstance():Resume()
	end
end

function AutoChessBattleView:OnClickSkipBtn()
	self.isSkipBattle_ = true

	AutoChessBattleSimulator.GetInstance():Skip()
	OperationRecorder.RecordButtonTouch({
		button_name = "activity_autochess_combat_pvp_skip_touch",
		activity_id = AutoChessData:GetActivityID(),
		polyhedron_id_str = AutoChessData:GetSimulatePlayerData(AutoChessConst.PLAYER_TYPE.SELF).battleUID
	})
end

function AutoChessBattleView:OnClickDoubleSpeedBtn()
	if self.isAccelerating_ then
		self.isAccelerating_ = false

		self.doubleSpeedBtnController_:SetSelectedState("1")
		AutoChessBattleRenderer.GetInstance():SetSpeed(1)
	else
		self.isAccelerating_ = true

		self.doubleSpeedBtnController_:SetSelectedState("2")
		AutoChessBattleRenderer.GetInstance():SetSpeed(2)
	end

	saveData("AutoChess", "battleSpeed", self.isAccelerating_ and 1 or 0)
end

function AutoChessBattleView:ResetAnim()
	SetActive(self.attackAniGo_, false)
end

function AutoChessBattleView:StartFormationTween()
	local var_47_0 = false
	local var_47_1 = false

	self.rightGo_.transform.anchoredPosition = Vector2.New(0, -60)

	SetActive(self.selfChessContain_.gameObject, false)
	SetActive(self.opChessContain_.gameObject, false)
	AnimatorTools.PlayAnimationWithCallback(self.bgAnim_, "BgScale5x5", function()
		SetActive(self.leftGo_, true)
		SetActive(self.rightGo_, true)

		self.selfChessContain_.transform.anchoredPosition = Vector2.New(self.chessContainPosX_ - _G.SCREEN_WIDTH / 2, 0)
		self.opChessContain_.transform.anchoredPosition = Vector2.New(self.chessContainPosX_ + _G.SCREEN_WIDTH / 2, 0)

		SetActive(self.selfChessContain_.gameObject, true)
		SetActive(self.opChessContain_.gameObject, true)
		LeanTween.moveLocalX(self.selfChessContain_, 2 * self.chessContainPosX_, 1.5):setOnComplete(LuaHelper.VoidAction(function()
			var_47_0 = true
		end))
		LeanTween.moveLocalX(self.opChessContain_, 0, 1.5):setOnComplete(LuaHelper.VoidAction(function()
			var_47_1 = true
		end))
		self:PlayItemEnterAnim()

		if self.enterTimer_ then
			self.enterTimer_:Stop()

			self.enterTimer_ = nil
		end

		self.enterTimer_ = Timer.New(function()
			if var_47_0 and var_47_1 then
				self:ResetItemAnim()
				self.enterTimer_:Stop()

				self.enterTimer_ = nil

				if not self.isSkipBattle_ then
					self:StartSimulator()
				end
			end
		end, 0.33, -1)

		self.enterTimer_:Start()
	end, -1, 0)
	self.bgAnim_:Update(0)
end

function AutoChessBattleView:PlayItemEnterAnim()
	manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_jump", "")

	local var_52_0 = 1
	local var_52_1 = 1
	local var_52_2
	local var_52_3

	var_52_2 = Timer.New(function()
		if var_52_0 <= #self.selfEnterChessItemList_ then
			self.selfEnterChessItemList_[var_52_0]:PlayItemAnim("ChessItem_ruchang")

			var_52_0 = var_52_0 + 1
		else
			var_52_2:Stop()
		end
	end, 0.03, -1)
	var_52_3 = Timer.New(function()
		if var_52_1 <= #self.opEnterChessItemList_ then
			self.opEnterChessItemList_[var_52_1]:PlayItemAnim("ChessItem_ruchang")

			var_52_1 = var_52_1 + 1
		else
			var_52_3:Stop()
		end
	end, 0.03, -1)

	;(nil):Start()
	var_52_3:Start()
end

function AutoChessBattleView:ResetItemAnim()
	for iter_55_0, iter_55_1 in pairs(self.usingChessItemDic_) do
		iter_55_1:PlayItemAnim("ChessIdleAnim")
	end
end

function AutoChessBattleView:PlayShakeAnim(arg_56_1, arg_56_2)
	local var_56_0 = 1

	for iter_56_0, iter_56_1 in ipairs(GameSetting.auto_chess_shake.value) do
		if iter_56_1 <= arg_56_1 then
			var_56_0 = iter_56_0 + 1
		end
	end

	local var_56_1

	var_56_1 = Timer.New(function()
		self.shakeAnim_:Play("U_zhenping_0" .. var_56_0, -1, 0)
		self.shakeAnim_:Update(0)
		var_56_1:Stop()

		var_56_1 = nil
	end, arg_56_2, 1)

	;(nil):Start()
end

return AutoChessBattleView
