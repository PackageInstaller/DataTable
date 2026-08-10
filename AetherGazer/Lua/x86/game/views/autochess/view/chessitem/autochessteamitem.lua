local var_0_0 = class("AutoChessTeamItem", AutoChessItem)

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()
	ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_0.originalGo_)
	arg_1_0:InitController()
	arg_1_0:InitBuffKeywordConfig()
end

function var_0_0.InitController(arg_2_0)
	var_0_0.super.InitController(arg_2_0)

	arg_2_0.showLvController_ = arg_2_0.battleChessControllerEX_:GetController("showLv")
	arg_2_0.gradeController_ = arg_2_0.battleChessControllerEX_:GetController("grade")
	arg_2_0.lvController_ = arg_2_0.levelControllerEx_:GetController("lv")
	arg_2_0.lvStateController_ = arg_2_0.levelControllerEx_:GetController("state")
	arg_2_0.lvStarController_ = arg_2_0.levelControllerEx_:GetController("star")
	arg_2_0.lvSpecialController_ = arg_2_0.levelControllerEx_:GetController("special")
	arg_2_0.lvUpController_ = arg_2_0.levelControllerEx_:GetController("levelUp")
	arg_2_0.selectChessController_ = arg_2_0.controllerEx_:GetController("group")
end

function var_0_0.ShowGradeEffect(arg_3_0)
	if not arg_3_0.grade then
		return
	end

	arg_3_0.roleLightImg_.sprite = arg_3_0.sprite

	arg_3_0.gradeController_:SetSelectedIndex(arg_3_0.grade - 1)

	if arg_3_0.gradeTimer then
		arg_3_0.gradeTimer:Stop()

		arg_3_0.gradeTimer = nil
	end

	arg_3_0.gradeTimer = Timer.New(function()
		arg_3_0.gradeController_:SetSelectedIndex(0)

		arg_3_0.isShowGradeEffect = nil
	end, 2.1, 1)

	arg_3_0.gradeTimer:Start()
end

function var_0_0.UpdateLevel(arg_5_0)
	if arg_5_0.chessCfg_.type == AutoChessConst.CHESS_TYPE.PLAYER_CHESS then
		local var_5_0 = AutoChessTools.GetPlayerChessLevelBuff(arg_5_0.chessCfg_)
		local var_5_1 = 0

		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
				if table.indexof(arg_5_0.chessItemData_.buffList, iter_5_3) then
					var_5_1 = iter_5_0

					break
				end
			end
		end

		arg_5_0.lvController_:SetSelectedIndex(var_5_1)
		arg_5_0.lvStateController_:SetSelectedState(0)
		arg_5_0.lvSpecialController_:SetSelectedState("Special")
	elseif arg_5_0.chessCfg_.type == AutoChessConst.CHESS_TYPE.OP_PLAYER_CHESS then
		local var_5_2 = arg_5_0.chessItemData_.attributeData.level - 1

		arg_5_0.lvController_:SetSelectedIndex(var_5_2)
		arg_5_0.lvStateController_:SetSelectedState(0)
		arg_5_0.lvSpecialController_:SetSelectedState("Special")
	else
		local var_5_3 = arg_5_0.chessItemData_.attributeData.level
		local var_5_4 = arg_5_0.chessItemData_.attributeData.exp
		local var_5_5 = arg_5_0.chessItemData_.attributeData.expTable

		arg_5_0.lvController_:SetSelectedIndex(var_5_3)
		arg_5_0.lvStateController_:SetSelectedState(var_5_5[var_5_3 + 1] and var_5_5[var_5_3 + 1] - var_5_5[var_5_3] or 0)
		arg_5_0.lvSpecialController_:SetSelectedState("Normal")

		local var_5_6 = var_5_4 - var_5_5[var_5_3]

		arg_5_0.lvStarController_:SetSelectedIndex(var_5_6)
	end
end

function var_0_0.UpdateLvUp(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.lvUpController_:SetSelectedState("on")
	else
		arg_6_0.lvUpController_:SetSelectedState("off")
	end
end

function var_0_0.playLvPointAnim(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 then
		return
	end

	if not arg_7_0.chessItemData_.attributeData then
		return
	end

	if AutoChessTools.IsPlayerChess(arg_7_0.chessItemData_.chessId) then
		return
	end

	local var_7_0 = AutoChessCfg[arg_7_1.chessId]
	local var_7_1 = var_7_0.body[1]
	local var_7_2 = var_7_0.body[2]
	local var_7_3 = arg_7_1.attributeData.exp
	local var_7_4 = arg_7_1.attributeData.hp
	local var_7_5 = arg_7_1.attributeData.atk
	local var_7_6 = var_7_4 - var_7_2 + 1
	local var_7_7 = var_7_5 - var_7_1 + 1
	local var_7_8 = arg_7_0.chessItemData_.attributeData.level
	local var_7_9 = arg_7_0.chessItemData_.attributeData.exp
	local var_7_10 = arg_7_0.chessItemData_.attributeData.expTable
	local var_7_11 = arg_7_0.chessItemData_.attributeData.hp
	local var_7_12 = arg_7_0.chessItemData_.attributeData.atk
	local var_7_13 = var_7_10[#var_7_10]
	local var_7_14 = 0
	local var_7_15 = 0
	local var_7_16 = 0
	local var_7_17 = 1

	if var_7_13 < var_7_9 + var_7_3 then
		var_7_16 = #var_7_10

		local var_7_18 = var_7_13 - var_7_9

		var_7_7 = var_7_7 - (var_7_3 - var_7_18)
		var_7_6 = var_7_6 - (var_7_3 - var_7_18)
	else
		for iter_7_0, iter_7_1 in ipairs(var_7_10) do
			if iter_7_1 >= var_7_9 + var_7_3 then
				break
			end

			var_7_16 = var_7_16 + 1
		end

		local var_7_19 = var_7_3

		if var_7_8 ~= var_7_16 then
			var_7_17 = 1
			var_7_14 = var_7_9 + var_7_3 - var_7_10[var_7_16]
		else
			var_7_17 = var_7_9 - var_7_10[var_7_16] + 1
			var_7_14 = var_7_9 + var_7_3 - var_7_10[var_7_16]
		end
	end

	if arg_7_2 then
		arg_7_0.lvController_:SetSelectedIndex(var_7_16)
		arg_7_0.lvStateController_:SetSelectedState(var_7_10[var_7_16 + 1] and var_7_10[var_7_16 + 1] - var_7_10[var_7_16] or 0)

		for iter_7_2 = var_7_17, var_7_14 do
			arg_7_0["starAnim" .. iter_7_2 .. "_"]:Play("LvStar02", 0, 0)
		end

		arg_7_0.bottomAnim_:Play("preview", 0, 0)

		arg_7_0.hpText_.text = var_7_11 + var_7_6
		arg_7_0.attactkText_.text = var_7_12 + var_7_7
	else
		arg_7_0.lvController_:SetSelectedIndex(var_7_8)
		arg_7_0.lvStateController_:SetSelectedState(var_7_10[var_7_8 + 1] and var_7_10[var_7_8 + 1] - var_7_10[var_7_8] or 0)

		for iter_7_3 = 1, var_7_14 do
			arg_7_0["starAnim" .. iter_7_3 .. "_"]:Play("New State", 0, 0)
		end

		arg_7_0.bottomAnim_:Play("New State", 0, 0)
		arg_7_0:UpdateHP()
		arg_7_0:UpdateAttack()
	end
end

function var_0_0.playLevelUpAnim(arg_8_0, arg_8_1)
	if not arg_8_0.chessItemData_.attributeData then
		return
	end

	if not arg_8_1 then
		return
	end

	local var_8_0 = arg_8_1.attributeData.exp
	local var_8_1 = arg_8_0.chessItemData_.attributeData.level
	local var_8_2 = arg_8_0.chessItemData_.attributeData.exp
	local var_8_3 = arg_8_0.chessItemData_.attributeData.expTable
	local var_8_4 = var_8_3[#var_8_3]
	local var_8_5 = 0
	local var_8_6 = 0
	local var_8_7 = 1

	if var_8_4 < var_8_2 + var_8_0 then
		var_8_6 = #var_8_3
	else
		for iter_8_0, iter_8_1 in ipairs(var_8_3) do
			if iter_8_1 >= var_8_2 + var_8_0 then
				break
			end

			var_8_6 = var_8_6 + 1
		end

		if var_8_1 ~= var_8_6 then
			var_8_7 = 1
			var_8_5 = var_8_2 + var_8_0 - var_8_3[var_8_6]
		else
			var_8_7 = var_8_2 - var_8_3[var_8_6] + 1
			var_8_5 = var_8_2 + var_8_0 - var_8_3[var_8_6]
		end
	end

	if var_8_1 < #var_8_3 and var_8_2 + var_8_0 >= var_8_3[var_8_1 + 1] then
		for iter_8_2 = 1, var_8_5 do
			arg_8_0["starAnim" .. iter_8_2 .. "_"]:Play("New State", 0, 0)
		end

		arg_8_0.levelUpAnim_:Play("ChessLvUp", 0, 0)
	else
		for iter_8_3 = var_8_7, var_8_5 do
			arg_8_0["starAnim" .. iter_8_3 .. "_"]:Play("LvStar01", 0, 0)
		end
	end

	arg_8_0.bottomAnim_:Play("New State", 0, 0)
end

function var_0_0.UpdateBigHp(arg_9_0, arg_9_1)
	if arg_9_1 == 0 then
		arg_9_1 = "-" .. arg_9_1
	end

	arg_9_0.bigHpText1_.text = arg_9_1
	arg_9_0.bigHpText2_.text = arg_9_1

	manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_down", "")
end

function var_0_0.GetBigHpAnim(arg_10_0)
	return arg_10_0.bigHpAnim_
end

function var_0_0.PlayAttackChangeAnim(arg_11_0)
	local var_11_0 = AutoChessTools.IsPrepareStatus() and 1 or AutoChessBattleRenderer.GetInstance():GetSpeed()

	arg_11_0.attackChangeAnim_.speed = var_11_0

	arg_11_0.attackChangeAnim_:Play("AttackAni_add", 0, 0)
	arg_11_0.attackChangeAnim_:Update(0)
end

function var_0_0.ResetUI(arg_12_0)
	if arg_12_0.atkChangeController_ then
		arg_12_0.atkChangeController_:SetSelectedState("none")
	end

	if arg_12_0.hpChangeController_ then
		arg_12_0.hpChangeController_:SetSelectedState("none")
	end

	arg_12_0:SetSelectChessState(false)
end

function var_0_0.SetSelectChessState(arg_13_0, arg_13_1)
	if arg_13_1 then
		arg_13_0.selectChessController_:SetSelectedState("unselect")
	else
		arg_13_0.selectChessController_:SetSelectedState("select")
	end
end

function var_0_0.PlayItemAnim(arg_14_0, arg_14_1)
	local var_14_0 = AutoChessTools.IsPrepareStatus() and 1 or AutoChessBattleRenderer.GetInstance():GetSpeed()

	arg_14_0.animator_.speed = var_14_0

	arg_14_0.animator_:Play(arg_14_1, -1, 0)
	arg_14_0.animator_:Update(0)
end

function var_0_0.PlayPropAnimator(arg_15_0, arg_15_1)
	arg_15_0.propImg_.sprite = AutoChessTools.GetPropIcon(arg_15_1)

	arg_15_0.propAnim_:Play("Props", -1, 0)
	arg_15_0.propAnim_:Update(0)
	Timer.New(function()
		AutoChessData:SetIsInUseProp(false)
	end, 1, 1):Start()
end

function var_0_0.OnExit(arg_17_0)
	if arg_17_0.gradeTimer then
		arg_17_0.gradeTimer:Stop()

		arg_17_0.gradeTimer = nil
	end

	var_0_0.super.OnExit(arg_17_0)
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
