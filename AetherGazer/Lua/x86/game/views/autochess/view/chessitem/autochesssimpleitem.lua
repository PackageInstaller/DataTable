local var_0_0 = class("AutoChessSimpleItem", AutoChessItem)

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()
	ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_0.originalGo_)
	arg_1_0:InitController()
	arg_1_0:InitBuffKeywordConfig()
end

function var_0_0.InitController(arg_2_0)
	var_0_0.super.InitController(arg_2_0)

	arg_2_0.lvController_ = arg_2_0.levelControllerEx_:GetController("lv")
	arg_2_0.lvStateController_ = arg_2_0.levelControllerEx_:GetController("state")
	arg_2_0.lvStarController_ = arg_2_0.levelControllerEx_:GetController("star")
	arg_2_0.lvSpecialController_ = arg_2_0.levelControllerEx_:GetController("special")
	arg_2_0.lvUpController_ = arg_2_0.levelControllerEx_:GetController("levelUp")
	arg_2_0.selectChessController_ = arg_2_0.controllerEx_:GetController("group")
end

function var_0_0.UpdateUI(arg_3_0)
	arg_3_0:UpdateLevel()
	arg_3_0:UpdateIcon()
	arg_3_0:UpdateAttack()
	arg_3_0:UpdateHP()
	arg_3_0:UpdateBuffKeyword()
end

function var_0_0.SetAppearance(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.sunglassFlag = arg_4_1
	arg_4_0.chessSkin = arg_4_2
end

function var_0_0.UpdateIcon(arg_5_0)
	if arg_5_0.chessItemData_ then
		if arg_5_0.chessItemData_.shopType == AutoChessConst.SHOP_TYPE.PROP then
			arg_5_0.roleImg_.sprite = AutoChessTools.GetPropIcon(arg_5_0.chessCfg_.icon)

			arg_5_0.sunglassController_:SetSelectedState("hide")
		else
			if arg_5_0.chessItemData_.chessId == AutoChessConst.BRAHMA_BOSS_ID then
				arg_5_0.roleImg_.transform.sizeDelta = Vector2(341, 273)
			else
				arg_5_0.roleImg_.transform.sizeDelta = Vector2(240, 220)
			end

			arg_5_0.sprite, arg_5_0.grade, arg_5_0.sunglassSprite = AutoChessTools.GetChessBody(arg_5_0.chessItemData_.chessId, arg_5_0.playerType_, arg_5_0.chessSkin)
			arg_5_0.roleImg_.sprite = arg_5_0.sprite
			arg_5_0.sunglassImg_.sprite = arg_5_0.sunglassSprite

			arg_5_0.sunglassController_:SetSelectedState(arg_5_0.sunglassFlag == AutoChessConst.SUNGLASS_FLAG.UNLOCK and "show" or "hide")
		end
	end
end

function var_0_0.UpdateLevel(arg_6_0)
	if arg_6_0.chessCfg_.type == AutoChessConst.CHESS_TYPE.PLAYER_CHESS then
		local var_6_0 = AutoChessTools.GetPlayerChessLevelBuff(arg_6_0.chessCfg_)
		local var_6_1 = 0

		for iter_6_0, iter_6_1 in pairs(var_6_0) do
			for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
				if table.indexof(arg_6_0.chessItemData_.buffList, iter_6_3) then
					var_6_1 = iter_6_0

					break
				end
			end
		end

		arg_6_0.lvController_:SetSelectedIndex(var_6_1)
		arg_6_0.lvStateController_:SetSelectedState(0)
		arg_6_0.lvSpecialController_:SetSelectedState("Special")
	elseif arg_6_0.chessCfg_.type == AutoChessConst.CHESS_TYPE.OP_PLAYER_CHESS then
		local var_6_2 = arg_6_0.chessItemData_.attributeData.level - 1

		arg_6_0.lvController_:SetSelectedIndex(var_6_2)
		arg_6_0.lvStateController_:SetSelectedState(0)
		arg_6_0.lvSpecialController_:SetSelectedState("Special")
	else
		local var_6_3 = arg_6_0.chessItemData_.attributeData.level
		local var_6_4 = arg_6_0.chessItemData_.attributeData.exp
		local var_6_5 = arg_6_0.chessItemData_.attributeData.expTable

		arg_6_0.lvController_:SetSelectedIndex(var_6_3)
		arg_6_0.lvStateController_:SetSelectedState(var_6_5[var_6_3 + 1] and var_6_5[var_6_3 + 1] - var_6_5[var_6_3] or 0)
		arg_6_0.lvSpecialController_:SetSelectedState("Normal")

		local var_6_6 = var_6_4 - var_6_5[var_6_3]

		arg_6_0.lvStarController_:SetSelectedIndex(var_6_6)
	end
end

return var_0_0
