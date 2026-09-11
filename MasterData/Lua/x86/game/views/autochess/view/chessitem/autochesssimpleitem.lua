local AutoChessSimpleItem = class("AutoChessSimpleItem", AutoChessItem)

function AutoChessSimpleItem:InitUI()
	self:BindCfgUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.originalGo_)
	self:InitController()
	self:InitBuffKeywordConfig()
end

function AutoChessSimpleItem:InitController()
	AutoChessSimpleItem.super.InitController(self)

	self.lvController_ = self.levelControllerEx_:GetController("lv")
	self.lvStateController_ = self.levelControllerEx_:GetController("state")
	self.lvStarController_ = self.levelControllerEx_:GetController("star")
	self.lvSpecialController_ = self.levelControllerEx_:GetController("special")
	self.lvUpController_ = self.levelControllerEx_:GetController("levelUp")
	self.selectChessController_ = self.controllerEx_:GetController("group")
end

function AutoChessSimpleItem:UpdateUI()
	self:UpdateLevel()
	self:UpdateIcon()
	self:UpdateAttack()
	self:UpdateHP()
	self:UpdateBuffKeyword()
end

function AutoChessSimpleItem:SetAppearance(arg_4_1, arg_4_2)
	self.sunglassFlag = arg_4_1
	self.chessSkin = arg_4_2
end

function AutoChessSimpleItem:UpdateIcon()
	if self.chessItemData_ then
		if self.chessItemData_.shopType == AutoChessConst.SHOP_TYPE.PROP then
			self.roleImg_.sprite = AutoChessTools.GetPropIcon(self.chessCfg_.icon)

			self.sunglassController_:SetSelectedState("hide")
		else
			self.roleImg_.transform.sizeDelta = self.chessItemData_.chessId == AutoChessConst.BRAHMA_BOSS_ID and Vector2(341, 273) or Vector2(240, 220)
			self.sprite, self.grade, self.sunglassSprite = AutoChessTools.GetChessBody(self.chessItemData_.chessId, self.playerType_, self.chessSkin)
			self.roleImg_.sprite = self.sprite
			self.sunglassImg_.sprite = self.sunglassSprite

			self.sunglassController_:SetSelectedState(self.sunglassFlag == AutoChessConst.SUNGLASS_FLAG.UNLOCK and "show" or "hide")
		end
	end
end

function AutoChessSimpleItem:UpdateLevel()
	if self.chessCfg_.type == AutoChessConst.CHESS_TYPE.PLAYER_CHESS then
		local var_6_0 = 0

		for iter_6_0, iter_6_1 in pairs((AutoChessTools.GetPlayerChessLevelBuff(self.chessCfg_))) do
			for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
				if table.indexof(self.chessItemData_.buffList, iter_6_3) then
					var_6_0 = iter_6_0

					break
				end
			end
		end

		self.lvController_:SetSelectedIndex(var_6_0)
		self.lvStateController_:SetSelectedState(0)
		self.lvSpecialController_:SetSelectedState("Special")
	elseif self.chessCfg_.type == AutoChessConst.CHESS_TYPE.OP_PLAYER_CHESS then
		self.lvController_:SetSelectedIndex(self.chessItemData_.attributeData.level - 1)
		self.lvStateController_:SetSelectedState(0)
		self.lvSpecialController_:SetSelectedState("Special")
	else
		local var_6_1 = self.chessItemData_.attributeData.level
		local var_6_2 = self.chessItemData_.attributeData.exp
		local var_6_3 = self.chessItemData_.attributeData.expTable

		self.lvController_:SetSelectedIndex(self.chessItemData_.attributeData.level)
		self.lvStateController_:SetSelectedState((var_6_3[var_6_1 + 1] or nil) and (var_6_3[var_6_1 + 1] - var_6_3[var_6_1] or 0))
		self.lvSpecialController_:SetSelectedState("Normal")
		self.lvStarController_:SetSelectedIndex(var_6_2 - var_6_3[var_6_1])
	end
end

return AutoChessSimpleItem
