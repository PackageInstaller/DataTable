local var_0_0 = class("AutoChessItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.gameType_ = AutoChessConst.GAME_TYPE.PVP
	arg_1_0.playerType_ = AutoChessConst.PLAYER_TYPE.SELF

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitController()
	arg_3_0:InitBuffKeywordConfig()

	arg_3_0.isMoving_ = false
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.BeginDrag)))
	arg_4_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.Drag)))
	arg_4_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.EndDrag)))
	arg_4_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.PointerClick)))
	arg_4_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.PointerDown)))
	arg_4_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerEnter, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.PointerEnter)))
	arg_4_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerExit, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.PointerExit)))
end

function var_0_0.InitController(arg_5_0)
	arg_5_0.atkChangeController_ = arg_5_0.controllerEx_:GetController("atkChange")
	arg_5_0.hpChangeController_ = arg_5_0.controllerEx_:GetController("hpChange")
	arg_5_0.sunglassController_ = arg_5_0.controllerEx_:GetController("sunglass")
end

function var_0_0.InitBuffKeywordConfig(arg_6_0)
	arg_6_0.buffKeywordConfigDic_ = {
		[AutoChessConst.BUFF_KEYWORD_TYPE.SHIELD] = {
			disappearAnimName = "Shield_use",
			appearAnimName = "Shield_get",
			useAnimName = "Shield_use",
			useAnimSoundEffect = "minigame_activity_4_5_duel_attribute02",
			controller = arg_6_0.controllerEx_:GetController("Shield"),
			animator = arg_6_0.shieldAnim_
		},
		[AutoChessConst.BUFF_KEYWORD_TYPE.GROW] = {
			disappearAnimName = "Grow_dis",
			appearAnimName = "Grow_get",
			useAnimName = "Grow_use",
			useAnimSoundEffect = "minigame_activity_4_5_duel_attribute01",
			controller = arg_6_0.controllerEx_:GetController("Grow"),
			animator = arg_6_0.growAnim_
		},
		[AutoChessConst.BUFF_KEYWORD_TYPE.DEATH_WHISPE] = {
			disappearAnimName = "BUFF_DeathWhispe_use",
			appearAnimName = "BUFF_DeathWhispe_get",
			useAnimName = "BUFF_DeathWhispe_use",
			useAnimSoundEffect = "",
			controller = arg_6_0.controllerEx_:GetController("DeathWhispe"),
			animator = arg_6_0.deathWhispeAnim_
		},
		[AutoChessConst.BUFF_KEYWORD_TYPE.RAGE] = {
			disappearAnimName = "BUFF_Rage_use",
			appearAnimName = "BUFF_Rage_get",
			useAnimName = "BUFF_Rage_use",
			useAnimSoundEffect = "minigame_activity_4_5_duel_attribute03",
			controller = arg_6_0.controllerEx_:GetController("Rage"),
			animator = arg_6_0.rageAnim_
		},
		[AutoChessConst.BUFF_KEYWORD_TYPE.VENOMOUS] = {
			disappearAnimName = "BUFF_Rage_use",
			appearAnimName = "BUFF_Rage_get",
			useAnimName = "BUFF_Rage_use",
			useAnimSoundEffect = "minigame_activity_4_5_duel_attribute03",
			controller = arg_6_0.controllerEx_:GetController("Venomous"),
			animator = arg_6_0.venomousAnim_
		}
	}
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0:UpdateData(arg_7_1)

	if arg_7_0.chessItemData_ and arg_7_0.chessItemData_.uniqueId then
		arg_7_0:Reset()
		arg_7_0:UpdateUI()
		SetActive(arg_7_0.panelGo_, true)
	else
		SetActive(arg_7_0.panelGo_, false)
	end
end

function var_0_0.SetGameType(arg_8_0, arg_8_1)
	arg_8_0.gameType_ = arg_8_1
end

function var_0_0.UpdateData(arg_9_0, arg_9_1)
	arg_9_0.chessItemData_ = arg_9_1

	if arg_9_0.chessItemData_ and arg_9_0.chessItemData_.chessId then
		arg_9_0.chessCfg_ = arg_9_0.chessItemData_.shopType == AutoChessConst.SHOP_TYPE.PROP and AutoChessItemCfg[arg_9_0.chessItemData_.chessId] or AutoChessCfg[arg_9_0.chessItemData_.chessId]
	end
end

function var_0_0.Reset(arg_10_0)
	arg_10_0:ResetUI()
	arg_10_0:ResetAnim()
end

function var_0_0.SetSelectChessState(arg_11_0, arg_11_1)
	return
end

function var_0_0.SetPlayerType(arg_12_0, arg_12_1)
	arg_12_0.playerType_ = arg_12_1
end

function var_0_0.UpdateUI(arg_13_0)
	arg_13_0:UpdateLevel()
	arg_13_0:UpdateIcon()
	arg_13_0:UpdateAttack()
	arg_13_0:UpdateHP()
	arg_13_0:UpdateAttribute()
	arg_13_0:UpdateRare()
	arg_13_0:UpdateBuffKeyword()
end

function var_0_0.UpdateLevel(arg_14_0)
	return
end

function var_0_0.UpdateIcon(arg_15_0)
	if arg_15_0.chessItemData_ then
		if arg_15_0.chessItemData_.shopType == AutoChessConst.SHOP_TYPE.PROP then
			arg_15_0.roleImg_.sprite = AutoChessTools.GetPropIcon(arg_15_0.chessCfg_.icon)

			arg_15_0.sunglassController_:SetSelectedState("hide")
		else
			if arg_15_0.chessItemData_.chessId == AutoChessConst.BRAHMA_BOSS_ID then
				arg_15_0.roleImg_.transform.sizeDelta = Vector2(341, 273)
			else
				arg_15_0.roleImg_.transform.sizeDelta = Vector2(240, 220)
			end

			arg_15_0.sprite, arg_15_0.grade, arg_15_0.sunglassSprite = AutoChessTools.GetChessBody(arg_15_0.chessItemData_.chessId, arg_15_0.playerType_)
			arg_15_0.roleImg_.sprite = arg_15_0.sprite
			arg_15_0.sunglassImg_.sprite = arg_15_0.sunglassSprite

			local var_15_0 = AutoChessData:GetSunglassFlag(arg_15_0.playerType_) == AutoChessConst.SUNGLASS_FLAG.UNLOCK

			arg_15_0.sunglassController_:SetSelectedState(var_15_0 and "show" or "hide")
		end
	end
end

function var_0_0.UpdateAttack(arg_16_0, arg_16_1)
	arg_16_0.chessItemData_.attributeData.atk = arg_16_1 or arg_16_0.chessItemData_.attributeData.atk
	arg_16_0.attactkText_.text = arg_16_0.chessItemData_.attributeData.atk
end

function var_0_0.UpdateAttackChange(arg_17_0, arg_17_1)
	if arg_17_1 == 0 then
		return
	end

	local var_17_0 = math.abs(arg_17_1)

	if arg_17_1 > 0 then
		arg_17_0.attackAddText_.text = var_17_0

		arg_17_0.atkChangeController_:SetSelectedState("add")
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_improve", "")
	else
		arg_17_0.attackReduceText_.text = var_17_0

		arg_17_0.atkChangeController_:SetSelectedState("reduce")
	end

	arg_17_0:PlayAttackChangeAnim()
end

function var_0_0.UpdateHP(arg_18_0, arg_18_1)
	arg_18_0.chessItemData_.attributeData.hp = arg_18_1 or arg_18_0.chessItemData_.attributeData.hp
	arg_18_0.hpText_.text = arg_18_0.chessItemData_.attributeData.hp
end

function var_0_0.UpdateHPChange(arg_19_0, arg_19_1)
	if arg_19_1 == 0 then
		return
	end

	local var_19_0 = math.abs(arg_19_1)

	if arg_19_1 > 0 then
		arg_19_0.hpChangeController_:SetSelectedState("add")

		arg_19_0.hpAddText_.text = var_19_0

		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_improve", "")
	else
		arg_19_0.hpChangeController_:SetSelectedState("reduce")

		arg_19_0.hpReduceText_.text = var_19_0

		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_down", "")
	end

	arg_19_0:PlayHpChangeAnim()
end

function var_0_0.UpdateAttribute(arg_20_0)
	return
end

function var_0_0.UpdateRare(arg_21_0)
	return
end

function var_0_0.ResetUI(arg_22_0)
	if arg_22_0.atkChangeController_ then
		arg_22_0.atkChangeController_:SetSelectedState("none")
	end

	if arg_22_0.hpChangeController_ then
		arg_22_0.hpChangeController_:SetSelectedState("none")
	end
end

function var_0_0.UpdateBuffKeyword(arg_23_0)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(arg_23_0.chessItemData_:GetBuffList()) do
		local var_23_1 = AutoChessBuffCfg[iter_23_1.buffId]

		if var_23_1 == nil then
			print("AutoChessItem:UpdateBuffKeyword buffCfg is nil, buffId = " .. iter_23_1.buffId)
		elseif var_23_1.keyword_type ~= AutoChessConst.BUFF_KEYWORD_TYPE.NONE then
			var_23_0[var_23_1.keyword_type] = true
		end
	end

	for iter_23_2, iter_23_3 in pairs(arg_23_0.buffKeywordConfigDic_) do
		iter_23_3.controller:SetSelectedState(var_23_0[iter_23_2] and "on" or "off")
	end
end

function var_0_0.AddBuff(arg_24_0, arg_24_1)
	local var_24_0 = AutoChessBuffCfg[arg_24_1.buffId]

	if var_24_0.keyword_type ~= AutoChessConst.BUFF_KEYWORD_TYPE.NONE then
		arg_24_0.buffKeywordConfigDic_[var_24_0.keyword_type].controller:SetSelectedState("on")
	end
end

function var_0_0.RemoveBuff(arg_25_0, arg_25_1)
	local var_25_0 = AutoChessBuffCfg[arg_25_1.buffId]

	if var_25_0.keyword_type ~= AutoChessConst.BUFF_KEYWORD_TYPE.NONE then
		arg_25_0.buffKeywordConfigDic_[var_25_0.keyword_type].controller:SetSelectedState("off")
	end
end

function var_0_0.GetBuffKeywordConfig(arg_26_0, arg_26_1)
	return arg_26_0.buffKeywordConfigDic_[arg_26_1]
end

function var_0_0.ContainBuff(arg_27_0, arg_27_1)
	return arg_27_0.chessItemData_:ContainBuff(arg_27_1)
end

function var_0_0.SetActive(arg_28_0, arg_28_1)
	SetActive(arg_28_0.gameObject_, arg_28_1)
end

function var_0_0.SetParent(arg_29_0, arg_29_1)
	arg_29_0.transform_:SetParent(arg_29_1)
end

function var_0_0.SetLocalPos(arg_30_0, arg_30_1)
	arg_30_0.transform_.localPosition = arg_30_1
end

function var_0_0.GetLocalPos(arg_31_0)
	return arg_31_0.transform_.localPosition
end

function var_0_0.GetPos(arg_32_0)
	return arg_32_0.transform_.position
end

function var_0_0.GetWidth(arg_33_0)
	return arg_33_0.transform_.rect.width
end

function var_0_0.GetHeight(arg_34_0)
	return arg_34_0.transform_.rect.height
end

function var_0_0.SetLocalScale(arg_35_0, arg_35_1)
	arg_35_0.transform_.localScale = arg_35_1
	arg_35_0.roleImg_.transform.localScale = arg_35_1
	arg_35_0.roleImg_.transform.localRotation = Quaternion.identity
end

function var_0_0.SetIsMoving(arg_36_0, arg_36_1)
	arg_36_0.isMoving_ = arg_36_1
end

function var_0_0.RegisterEvent(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_1 == "PointerClick" then
		arg_37_0.pointerClickFunc = arg_37_2
	elseif arg_37_1 == "BeginDrag" then
		arg_37_0.beginDragFunc = arg_37_2
	elseif arg_37_1 == "Drag" then
		arg_37_0.dragFunc = arg_37_2
	elseif arg_37_1 == "EndDrag" then
		arg_37_0.endDragFunc = arg_37_2
	elseif arg_37_1 == "PointerEnter" then
		arg_37_0.pointerEnterFunc = arg_37_2
	elseif arg_37_1 == "PointerExit" then
		arg_37_0.pointerExitFunc = arg_37_2
	end
end

function var_0_0.PointerClick(arg_38_0, arg_38_1)
	if arg_38_0.isMoving_ then
		return
	end

	if arg_38_0.pointerClickFunc then
		arg_38_0.pointerClickFunc(arg_38_0.chessItemData_, arg_38_0)
	end
end

function var_0_0.PointerDown(arg_39_0, arg_39_1)
	if arg_39_0.isMoving_ then
		return
	end

	if manager.guide:IsPlaying() and arg_39_0.pointerClickFunc then
		arg_39_0.pointerClickFunc(arg_39_0.chessItemData_)
	end
end

function var_0_0.BeginDrag(arg_40_0, arg_40_1, arg_40_2)
	if not arg_40_0.chessItemData_.uniqueId then
		return
	end

	if arg_40_0.beginDragFunc then
		arg_40_0.beginDragFunc(arg_40_0.chessItemData_, arg_40_2)
	end
end

function var_0_0.Drag(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_0.dragFunc then
		arg_41_0.dragFunc(arg_41_2)
	end
end

function var_0_0.EndDrag(arg_42_0, arg_42_1, arg_42_2)
	if arg_42_0.endDragFunc then
		arg_42_0.endDragFunc(arg_42_2)
	end
end

function var_0_0.PointerEnter(arg_43_0, arg_43_1)
	if arg_43_0.isMoving_ then
		return
	end

	if arg_43_0.pointerEnterFunc then
		arg_43_0.pointerEnterFunc(arg_43_0.chessItemData_, arg_43_0)
	end
end

function var_0_0.PointerExit(arg_44_0, arg_44_1)
	if arg_44_0.isMoving_ then
		return
	end

	if arg_44_0.pointerExitFunc then
		arg_44_0.pointerExitFunc(arg_44_0.chessItemData_, arg_44_0)
	end
end

function var_0_0.SetIndex(arg_45_0, arg_45_1)
	arg_45_0.chessItemData_.index = arg_45_1
end

function var_0_0.GetAnimator(arg_46_0)
	return arg_46_0.animator_
end

function var_0_0.GetDeathWhispeTriggerAnimator(arg_47_0)
	return arg_47_0.deathWhispeTriggerAnim_
end

function var_0_0.GetAddBuffAnimator(arg_48_0)
	return arg_48_0.addBuffAnim_
end

function var_0_0.PlayHpChangeAnim(arg_49_0)
	local var_49_0 = AutoChessTools.IsPrepareStatus() and 1 or AutoChessBattleRenderer.GetInstance():GetSpeed()

	arg_49_0.hpChangeAnim_.speed = var_49_0

	arg_49_0.hpChangeAnim_:Play("HPAni_add", 0, 0)
	arg_49_0.hpChangeAnim_:Update(0)
end

function var_0_0.PlayAttackChangeAnim(arg_50_0)
	local var_50_0 = AutoChessTools.IsPrepareStatus() and 1 or AutoChessBattleRenderer.GetInstance():GetSpeed()

	arg_50_0.attackChangeAnim_.speed = var_50_0

	arg_50_0.attackChangeAnim_:Play("AttackAni_add", 0, 0)
	arg_50_0.attackChangeAnim_:Update(0)
end

function var_0_0.ResetAnim(arg_51_0)
	arg_51_0.animator_:Play("ChessIdleAnim", 0, 0)
	arg_51_0.animator_:Update(0)
end

function var_0_0.Dispose(arg_52_0)
	var_0_0.super.Dispose(arg_52_0)
end

return var_0_0
