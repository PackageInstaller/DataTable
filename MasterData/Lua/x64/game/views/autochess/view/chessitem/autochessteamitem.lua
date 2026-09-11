local AutoChessTeamItem = class("AutoChessTeamItem", AutoChessItem)

function AutoChessTeamItem:InitUI()
	self:BindCfgUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.originalGo_)
	self:InitController()
	self:InitBuffKeywordConfig()
end

function AutoChessTeamItem:InitController()
	AutoChessTeamItem.super.InitController(self)

	self.showLvController_ = self.battleChessControllerEX_:GetController("showLv")
	self.gradeController_ = self.battleChessControllerEX_:GetController("grade")
	self.lvController_ = self.levelControllerEx_:GetController("lv")
	self.lvStateController_ = self.levelControllerEx_:GetController("state")
	self.lvStarController_ = self.levelControllerEx_:GetController("star")
	self.lvSpecialController_ = self.levelControllerEx_:GetController("special")
	self.lvUpController_ = self.levelControllerEx_:GetController("levelUp")
	self.selectChessController_ = self.controllerEx_:GetController("group")
end

function AutoChessTeamItem:ShowGradeEffect()
	if not self.grade then
		return
	end

	self.roleLightImg_.sprite = self.sprite

	self.gradeController_:SetSelectedIndex(self.grade - 1)

	if self.gradeTimer then
		self.gradeTimer:Stop()

		self.gradeTimer = nil
	end

	self.gradeTimer = Timer.New(function()
		self.gradeController_:SetSelectedIndex(0)

		self.isShowGradeEffect = nil
	end, 2.1, 1)

	self.gradeTimer:Start()
end

function AutoChessTeamItem:UpdateLevel()
	if self.chessCfg_.type == AutoChessConst.CHESS_TYPE.PLAYER_CHESS then
		local var_5_0 = 0

		for iter_5_0, iter_5_1 in pairs((AutoChessTools.GetPlayerChessLevelBuff(self.chessCfg_))) do
			for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
				if table.indexof(self.chessItemData_.buffList, iter_5_3) then
					var_5_0 = iter_5_0

					break
				end
			end
		end

		self.lvController_:SetSelectedIndex(var_5_0)
		self.lvStateController_:SetSelectedState(0)
		self.lvSpecialController_:SetSelectedState("Special")
	elseif self.chessCfg_.type == AutoChessConst.CHESS_TYPE.OP_PLAYER_CHESS then
		self.lvController_:SetSelectedIndex(self.chessItemData_.attributeData.level - 1)
		self.lvStateController_:SetSelectedState(0)
		self.lvSpecialController_:SetSelectedState("Special")
	else
		local var_5_1 = self.chessItemData_.attributeData.level
		local var_5_2 = self.chessItemData_.attributeData.exp
		local var_5_3 = self.chessItemData_.attributeData.expTable

		self.lvController_:SetSelectedIndex(self.chessItemData_.attributeData.level)
		self.lvStateController_:SetSelectedState((var_5_3[var_5_1 + 1] or nil) and (var_5_3[var_5_1 + 1] - var_5_3[var_5_1] or 0))
		self.lvSpecialController_:SetSelectedState("Normal")
		self.lvStarController_:SetSelectedIndex(var_5_2 - var_5_3[var_5_1])
	end
end

function AutoChessTeamItem:UpdateLvUp(arg_6_1)
	if arg_6_1 then
		self.lvUpController_:SetSelectedState("on")
	else
		self.lvUpController_:SetSelectedState("off")
	end
end

function AutoChessTeamItem:playLvPointAnim(arg_7_1, arg_7_2)
	if not arg_7_1 then
		return
	end

	if not self.chessItemData_.attributeData then
		return
	end

	if AutoChessTools.IsPlayerChess(self.chessItemData_.chessId) then
		return
	end

	local var_7_0 = arg_7_1.attributeData.hp - AutoChessCfg[arg_7_1.chessId].body[2] + 1
	local var_7_1 = arg_7_1.attributeData.atk - AutoChessCfg[arg_7_1.chessId].body[1] + 1
	local var_7_2 = self.chessItemData_.attributeData.level
	local var_7_3 = self.chessItemData_.attributeData.expTable
	local var_7_4 = self.chessItemData_.attributeData.hp
	local var_7_5 = self.chessItemData_.attributeData.atk
	local var_7_6 = self.chessItemData_.attributeData.expTable[#self.chessItemData_.attributeData.expTable]
	local var_7_7 = 0
	local var_7_9 = 0
	local var_7_10 = 1

	if var_7_6 < self.chessItemData_.attributeData.exp + arg_7_1.attributeData.exp then
		var_7_9 = #var_7_3
		var_7_1 = var_7_1 - (arg_7_1.attributeData.exp - (var_7_6 - self.chessItemData_.attributeData.exp))
		var_7_0 = var_7_0 - (arg_7_1.attributeData.exp - (var_7_6 - self.chessItemData_.attributeData.exp))
	else
		for iter_7_0, iter_7_1 in ipairs(var_7_3) do
			if iter_7_1 >= self.chessItemData_.attributeData.exp + arg_7_1.attributeData.exp then
				break
			end

			var_7_9 = var_7_9 + 1
		end

		if var_7_2 ~= var_7_9 then
			var_7_10 = 1
			var_7_7 = self.chessItemData_.attributeData.exp + arg_7_1.attributeData.exp - var_7_3[var_7_9]
		else
			var_7_10 = self.chessItemData_.attributeData.exp - var_7_3[var_7_9] + 1
			var_7_7 = self.chessItemData_.attributeData.exp + arg_7_1.attributeData.exp - var_7_3[var_7_9]
		end
	end

	if arg_7_2 then
		self.lvController_:SetSelectedIndex(var_7_9)
		self.lvStateController_:SetSelectedState((var_7_3[var_7_9 + 1] or nil) and (var_7_3[var_7_9 + 1] - var_7_3[var_7_9] or 0))

		for iter_7_2 = var_7_10, var_7_7 do
			self["starAnim" .. iter_7_2 .. "_"]:Play("LvStar02", 0, 0)
		end

		self.bottomAnim_:Play("preview", 0, 0)

		self.hpText_.text = var_7_4 + var_7_0
		self.attactkText_.text = var_7_5 + var_7_1
	else
		self.lvController_:SetSelectedIndex(var_7_2)
		self.lvStateController_:SetSelectedState((var_7_3[var_7_2 + 1] or nil) and (var_7_3[var_7_2 + 1] - var_7_3[var_7_2] or 0))

		for iter_7_3 = 1, var_7_7 do
			self["starAnim" .. iter_7_3 .. "_"]:Play("New State", 0, 0)
		end

		self.bottomAnim_:Play("New State", 0, 0)
		self:UpdateHP()
		self:UpdateAttack()
	end
end

function AutoChessTeamItem:playLevelUpAnim(arg_8_1)
	if not self.chessItemData_.attributeData then
		return
	end

	if not arg_8_1 then
		return
	end

	local var_8_0 = arg_8_1.attributeData.exp
	local var_8_1 = self.chessItemData_.attributeData.level
	local var_8_2 = self.chessItemData_.attributeData.exp
	local var_8_3 = self.chessItemData_.attributeData.expTable
	local var_8_4 = 0
	local var_8_5 = 0
	local var_8_6 = 1

	if self.chessItemData_.attributeData.expTable[#self.chessItemData_.attributeData.expTable] < self.chessItemData_.attributeData.exp + arg_8_1.attributeData.exp then
		var_8_5 = #var_8_3
	else
		for iter_8_0, iter_8_1 in ipairs(var_8_3) do
			if iter_8_1 >= var_8_2 + var_8_0 then
				break
			end

			var_8_5 = var_8_5 + 1
		end

		if var_8_1 ~= var_8_5 then
			var_8_6 = 1
			var_8_4 = var_8_2 + var_8_0 - var_8_3[var_8_5]
		else
			var_8_6 = var_8_2 - var_8_3[var_8_5] + 1
			var_8_4 = var_8_2 + var_8_0 - var_8_3[var_8_5]
		end
	end

	if var_8_1 < #var_8_3 and var_8_2 + var_8_0 >= var_8_3[var_8_1 + 1] then
		for iter_8_2 = 1, var_8_4 do
			self["starAnim" .. iter_8_2 .. "_"]:Play("New State", 0, 0)
		end

		self.levelUpAnim_:Play("ChessLvUp", 0, 0)
	else
		for iter_8_3 = var_8_6, var_8_4 do
			self["starAnim" .. iter_8_3 .. "_"]:Play("LvStar01", 0, 0)
		end
	end

	self.bottomAnim_:Play("New State", 0, 0)
end

function AutoChessTeamItem:UpdateBigHp(arg_9_1)
	if arg_9_1 == 0 then
		arg_9_1 = "-" .. arg_9_1
	end

	self.bigHpText1_.text = arg_9_1
	self.bigHpText2_.text = arg_9_1

	manager.audio:PlayEffect("minigame_activity_4_5", "minigame_activity_4_5_duel_down", "")
end

function AutoChessTeamItem:GetBigHpAnim()
	return self.bigHpAnim_
end

function AutoChessTeamItem:PlayAttackChangeAnim()
	self.attackChangeAnim_.speed = AutoChessTools.IsPrepareStatus() and 1 or AutoChessBattleRenderer.GetInstance():GetSpeed()

	self.attackChangeAnim_:Play("AttackAni_add", 0, 0)
	self.attackChangeAnim_:Update(0)
end

function AutoChessTeamItem:ResetUI()
	if self.atkChangeController_ then
		self.atkChangeController_:SetSelectedState("none")
	end

	if self.hpChangeController_ then
		self.hpChangeController_:SetSelectedState("none")
	end

	self:SetSelectChessState(false)
end

function AutoChessTeamItem:SetSelectChessState(arg_13_1)
	if arg_13_1 then
		self.selectChessController_:SetSelectedState("unselect")
	else
		self.selectChessController_:SetSelectedState("select")
	end
end

function AutoChessTeamItem:PlayItemAnim(arg_14_1)
	self.animator_.speed = AutoChessTools.IsPrepareStatus() and 1 or AutoChessBattleRenderer.GetInstance():GetSpeed()

	self.animator_:Play(arg_14_1, -1, 0)
	self.animator_:Update(0)
end

function AutoChessTeamItem:PlayPropAnimator(arg_15_1)
	self.propImg_.sprite = AutoChessTools.GetPropIcon(arg_15_1)

	self.propAnim_:Play("Props", -1, 0)
	self.propAnim_:Update(0)
	Timer.New(function()
		AutoChessData:SetIsInUseProp(false)
	end, 1, 1):Start()
end

function AutoChessTeamItem:OnExit()
	if self.gradeTimer then
		self.gradeTimer:Stop()

		self.gradeTimer = nil
	end

	AutoChessTeamItem.super.OnExit(self)
end

function AutoChessTeamItem:Dispose()
	AutoChessTeamItem.super.Dispose(self)
end

return AutoChessTeamItem
