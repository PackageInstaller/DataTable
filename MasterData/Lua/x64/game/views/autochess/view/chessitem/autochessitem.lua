local AutoChessItem = class("AutoChessItem", ReduxView)

function AutoChessItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.gameType_ = AutoChessConst.GAME_TYPE.PVP
	self.playerType_ = AutoChessConst.PLAYER_TYPE.SELF

	self:Init()
end

function AutoChessItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AutoChessItem:InitUI()
	self:BindCfgUI()
	self:InitController()
	self:InitBuffKeywordConfig()

	self.isMoving_ = false
end

function AutoChessItem:AddUIListeners()
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDrag)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(self, self.Drag)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDrag)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(handler(self, self.PointerClick)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(handler(self, self.PointerDown)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerEnter, LuaHelper.EventTriggerAction1(handler(self, self.PointerEnter)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerExit, LuaHelper.EventTriggerAction1(handler(self, self.PointerExit)))
end

function AutoChessItem:InitController()
	self.atkChangeController_ = self.controllerEx_:GetController("atkChange")
	self.hpChangeController_ = self.controllerEx_:GetController("hpChange")
	self.sunglassController_ = self.controllerEx_:GetController("sunglass")
end

function AutoChessItem:InitBuffKeywordConfig()
	self.buffKeywordConfigDic_ = {
		[AutoChessConst.BUFF_KEYWORD_TYPE.SHIELD] = {
			disappearAnimName = "Shield_use",
			appearAnimName = "Shield_get",
			useAnimName = "Shield_use",
			useAnimSoundEffect = "minigame_activity_4_5_duel_attribute02",
			controller = self.controllerEx_:GetController("Shield"),
			animator = self.shieldAnim_
		},
		[AutoChessConst.BUFF_KEYWORD_TYPE.GROW] = {
			disappearAnimName = "Grow_dis",
			appearAnimName = "Grow_get",
			useAnimName = "Grow_use",
			useAnimSoundEffect = "minigame_activity_4_5_duel_attribute01",
			controller = self.controllerEx_:GetController("Grow"),
			animator = self.growAnim_
		},
		[AutoChessConst.BUFF_KEYWORD_TYPE.DEATH_WHISPE] = {
			disappearAnimName = "BUFF_DeathWhispe_use",
			appearAnimName = "BUFF_DeathWhispe_get",
			useAnimName = "BUFF_DeathWhispe_use",
			useAnimSoundEffect = "",
			controller = self.controllerEx_:GetController("DeathWhispe"),
			animator = self.deathWhispeAnim_
		},
		[AutoChessConst.BUFF_KEYWORD_TYPE.RAGE] = {
			disappearAnimName = "BUFF_Rage_use",
			appearAnimName = "BUFF_Rage_get",
			useAnimName = "BUFF_Rage_use",
			useAnimSoundEffect = "minigame_activity_4_5_duel_attribute03",
			controller = self.controllerEx_:GetController("Rage"),
			animator = self.rageAnim_
		},
		[AutoChessConst.BUFF_KEYWORD_TYPE.VENOMOUS] = {
			disappearAnimName = "BUFF_Rage_use",
			appearAnimName = "BUFF_Rage_get",
			useAnimName = "BUFF_Rage_use",
			useAnimSoundEffect = "minigame_activity_4_5_duel_attribute03",
			controller = self.controllerEx_:GetController("Venomous"),
			animator = self.venomousAnim_
		}
	}
end

function AutoChessItem:SetData(arg_7_1)
	self:UpdateData(arg_7_1)

	if self.chessItemData_ and self.chessItemData_.uniqueId then
		self:Reset()
		self:UpdateUI()
		SetActive(self.panelGo_, true)
	else
		SetActive(self.panelGo_, false)
	end
end

function AutoChessItem:SetGameType(arg_8_1)
	self.gameType_ = arg_8_1
end

function AutoChessItem:UpdateData(arg_9_1)
	self.chessItemData_ = arg_9_1

	if self.chessItemData_ and self.chessItemData_.chessId then
		if self.chessItemData_.shopType == AutoChessConst.SHOP_TYPE.PROP then
			self.chessCfg_ = AutoChessItemCfg[self.chessItemData_.chessId] or AutoChessCfg[self.chessItemData_.chessId]
		end
	end
end

function AutoChessItem:Reset()
	self:ResetUI()
	self:ResetAnim()
end

function AutoChessItem:SetSelectChessState(arg_11_1)
	return
end

function AutoChessItem:SetPlayerType(arg_12_1)
	self.playerType_ = arg_12_1
end

function AutoChessItem:UpdateUI()
	self:UpdateLevel()
	self:UpdateIcon()
	self:UpdateAttack()
	self:UpdateHP()
	self:UpdateAttribute()
	self:UpdateRare()
	self:UpdateBuffKeyword()
end

function AutoChessItem:UpdateLevel()
	return
end

function AutoChessItem:UpdateIcon()
	if self.chessItemData_ then
		if self.chessItemData_.shopType == AutoChessConst.SHOP_TYPE.PROP then
			self.roleImg_.sprite = AutoChessTools.GetPropIcon(self.chessCfg_.icon)

			self.sunglassController_:SetSelectedState("hide")
		else
			self.roleImg_.transform.sizeDelta = self.chessItemData_.chessId == AutoChessConst.BRAHMA_BOSS_ID and Vector2(341, 273) or Vector2(240, 220)
			self.sprite, self.grade, self.sunglassSprite = AutoChessTools.GetChessBody(self.chessItemData_.chessId, self.playerType_)
			self.roleImg_.sprite = self.sprite
			self.sunglassImg_.sprite = self.sunglassSprite

			self.sunglassController_:SetSelectedState(AutoChessData:GetSunglassFlag(self.playerType_) == AutoChessConst.SUNGLASS_FLAG.UNLOCK and "show" or "hide")
		end
	end
end

function AutoChessItem:UpdateAttack(arg_16_1)
	self.chessItemData_.attributeData.atk = arg_16_1 or self.chessItemData_.attributeData.atk
	self.attactkText_.text = self.chessItemData_.attributeData.atk
end

function AutoChessItem:UpdateAttackChange(arg_17_1)
	if arg_17_1 == 0 then
		return
	end

	local var_17_0 = math.abs(arg_17_1)

	if arg_17_1 > 0 then
		self.attackAddText_.text = var_17_0

		self.atkChangeController_:SetSelectedState("add")
		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_improve", "")
	else
		self.attackReduceText_.text = var_17_0

		self.atkChangeController_:SetSelectedState("reduce")
	end

	self:PlayAttackChangeAnim()
end

function AutoChessItem:UpdateHP(arg_18_1)
	self.chessItemData_.attributeData.hp = arg_18_1 or self.chessItemData_.attributeData.hp
	self.hpText_.text = self.chessItemData_.attributeData.hp
end

function AutoChessItem:UpdateHPChange(arg_19_1)
	if arg_19_1 == 0 then
		return
	end

	local var_19_0 = math.abs(arg_19_1)

	if arg_19_1 > 0 then
		self.hpChangeController_:SetSelectedState("add")

		self.hpAddText_.text = var_19_0

		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_improve", "")
	else
		self.hpChangeController_:SetSelectedState("reduce")

		self.hpReduceText_.text = var_19_0

		manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_down", "")
	end

	self:PlayHpChangeAnim()
end

function AutoChessItem:UpdateAttribute()
	return
end

function AutoChessItem:UpdateRare()
	return
end

function AutoChessItem:ResetUI()
	if self.atkChangeController_ then
		self.atkChangeController_:SetSelectedState("none")
	end

	if self.hpChangeController_ then
		self.hpChangeController_:SetSelectedState("none")
	end
end

function AutoChessItem:UpdateBuffKeyword()
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(self.chessItemData_:GetBuffList()) do
		local var_23_1 = AutoChessBuffCfg[iter_23_1.buffId]

		if AutoChessBuffCfg[iter_23_1.buffId] == nil then
			print("AutoChessItem:UpdateBuffKeyword buffCfg is nil, buffId = " .. iter_23_1.buffId)
		elseif var_23_1.keyword_type ~= AutoChessConst.BUFF_KEYWORD_TYPE.NONE then
			var_23_0[var_23_1.keyword_type] = true
		end
	end

	for iter_23_2, iter_23_3 in pairs(self.buffKeywordConfigDic_) do
		iter_23_3.controller:SetSelectedState(var_23_0[iter_23_2] and "on" or "off")
	end
end

function AutoChessItem:AddBuff(arg_24_1)
	if AutoChessBuffCfg[arg_24_1.buffId].keyword_type ~= AutoChessConst.BUFF_KEYWORD_TYPE.NONE then
		self.buffKeywordConfigDic_[AutoChessBuffCfg[arg_24_1.buffId].keyword_type].controller:SetSelectedState("on")
	end
end

function AutoChessItem:RemoveBuff(arg_25_1)
	if AutoChessBuffCfg[arg_25_1.buffId].keyword_type ~= AutoChessConst.BUFF_KEYWORD_TYPE.NONE then
		self.buffKeywordConfigDic_[AutoChessBuffCfg[arg_25_1.buffId].keyword_type].controller:SetSelectedState("off")
	end
end

function AutoChessItem:GetBuffKeywordConfig(arg_26_1)
	return self.buffKeywordConfigDic_[arg_26_1]
end

function AutoChessItem:ContainBuff(arg_27_1)
	return self.chessItemData_:ContainBuff(arg_27_1)
end

function AutoChessItem:SetActive(arg_28_1)
	SetActive(self.gameObject_, arg_28_1)
end

function AutoChessItem:SetParent(arg_29_1)
	self.transform_:SetParent(arg_29_1)
end

function AutoChessItem:SetLocalPos(arg_30_1)
	self.transform_.localPosition = arg_30_1
end

function AutoChessItem:GetLocalPos()
	return self.transform_.localPosition
end

function AutoChessItem:GetPos()
	return self.transform_.position
end

function AutoChessItem:GetWidth()
	return self.transform_.rect.width
end

function AutoChessItem:GetHeight()
	return self.transform_.rect.height
end

function AutoChessItem:SetLocalScale(arg_35_1)
	self.transform_.localScale = arg_35_1
	self.roleImg_.transform.localScale = arg_35_1
	self.roleImg_.transform.localRotation = Quaternion.identity
end

function AutoChessItem:SetIsMoving(arg_36_1)
	self.isMoving_ = arg_36_1
end

function AutoChessItem:RegisterEvent(arg_37_1, arg_37_2)
	if arg_37_1 == "PointerClick" then
		self.pointerClickFunc = arg_37_2
	elseif arg_37_1 == "BeginDrag" then
		self.beginDragFunc = arg_37_2
	elseif arg_37_1 == "Drag" then
		self.dragFunc = arg_37_2
	elseif arg_37_1 == "EndDrag" then
		self.endDragFunc = arg_37_2
	elseif arg_37_1 == "PointerEnter" then
		self.pointerEnterFunc = arg_37_2
	elseif arg_37_1 == "PointerExit" then
		self.pointerExitFunc = arg_37_2
	end
end

function AutoChessItem:PointerClick(arg_38_1)
	if self.isMoving_ then
		return
	end

	if self.pointerClickFunc then
		self.pointerClickFunc(self.chessItemData_, self)
	end
end

function AutoChessItem:PointerDown(arg_39_1)
	if self.isMoving_ then
		return
	end

	if manager.guide:IsPlaying() and self.pointerClickFunc then
		self.pointerClickFunc(self.chessItemData_)
	end
end

function AutoChessItem:BeginDrag(arg_40_1, arg_40_2)
	if not self.chessItemData_.uniqueId then
		return
	end

	if self.beginDragFunc then
		self.beginDragFunc(self.chessItemData_, arg_40_2)
	end
end

function AutoChessItem:Drag(arg_41_1, arg_41_2)
	if self.dragFunc then
		self.dragFunc(arg_41_2)
	end
end

function AutoChessItem:EndDrag(arg_42_1, arg_42_2)
	if self.endDragFunc then
		self.endDragFunc(arg_42_2)
	end
end

function AutoChessItem:PointerEnter(arg_43_1)
	if self.isMoving_ then
		return
	end

	if self.pointerEnterFunc then
		self.pointerEnterFunc(self.chessItemData_, self)
	end
end

function AutoChessItem:PointerExit(arg_44_1)
	if self.isMoving_ then
		return
	end

	if self.pointerExitFunc then
		self.pointerExitFunc(self.chessItemData_, self)
	end
end

function AutoChessItem:SetIndex(arg_45_1)
	self.chessItemData_.index = arg_45_1
end

function AutoChessItem:GetAnimator()
	return self.animator_
end

function AutoChessItem:GetDeathWhispeTriggerAnimator()
	return self.deathWhispeTriggerAnim_
end

function AutoChessItem:GetAddBuffAnimator()
	return self.addBuffAnim_
end

function AutoChessItem:PlayHpChangeAnim()
	self.hpChangeAnim_.speed = AutoChessTools.IsPrepareStatus() and 1 or AutoChessBattleRenderer.GetInstance():GetSpeed()

	self.hpChangeAnim_:Play("HPAni_add", 0, 0)
	self.hpChangeAnim_:Update(0)
end

function AutoChessItem:PlayAttackChangeAnim()
	self.attackChangeAnim_.speed = AutoChessTools.IsPrepareStatus() and 1 or AutoChessBattleRenderer.GetInstance():GetSpeed()

	self.attackChangeAnim_:Play("AttackAni_add", 0, 0)
	self.attackChangeAnim_:Update(0)
end

function AutoChessItem:ResetAnim()
	self.animator_:Play("ChessIdleAnim", 0, 0)
	self.animator_:Update(0)
end

function AutoChessItem:Dispose()
	AutoChessItem.super.Dispose(self)
end

return AutoChessItem
