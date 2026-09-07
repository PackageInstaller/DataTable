local NewDodgemResultGradePage = class("NewDodgemResultGradePage", import("..NewBattleResultGradePage"))

function NewDodgemResultGradePage:LoadBG(arg_1_1)
	LoadAnyAsync("BattleResultItems/" .. "CommonBg", "", nil, function(arg_2_0)
		if self.exited or IsNil(arg_2_0) then
			if arg_1_1 then
				arg_1_1()
			end

			return
		end

		Object.Instantiate(arg_2_0, self.bgTr).transform:SetAsFirstSibling()

		if arg_1_1 then
			arg_1_1()
		end

		return
	end)

	return
end

function NewDodgemResultGradePage:RegisterEvent(arg_3_1)
	seriesAsync({
		function(arg_4_0)
			NewDodgemResultGradePage.super.RegisterEvent(self, arg_4_0)

			return
		end,
		function(arg_5_0)
			removeOnButton(self._tf)
			self:LoadPainitingContainer(arg_5_0)

			return
		end,
		function(arg_6_0)
			self:MovePainting(arg_6_0)

			return
		end
	}, function()
		onButton(self, self._tf, function()
			arg_3_1()

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function NewDodgemResultGradePage:MovePainting(arg_9_1)
	local var_9_0 = self.paintingTr.parent

	LeanTween.value(self.paintingTr.parent.gameObject, 2500, 587, 0.3):setOnUpdate(System.Action_float(function(arg_10_0)
		var_9_0.localPosition = Vector3(arg_10_0, 0, 0)

		return
	end)):setOnComplete(System.Action(arg_9_1))
	LeanTween.value(self.gradePanel.gameObject, self.gradePanel.anchoredPosition, self.gradePanel.anchoredPosition + Vector2(-247, 213), 0.29):setOnUpdate(System.Action_UnityEngine_Vector2(function(arg_11_0)
		self.gradePanel.anchoredPosition3D = Vector3(arg_11_0.x, arg_11_0.y, 0)

		return
	end))

	return
end

function NewDodgemResultGradePage:GetGetObjectives()
	local var_12_0 = {}

	table.insert(var_12_0, {
		text = setColorStr(i18n("battle_result_total_score"), "#FFFFFFFF"),
		value = setColorStr(self.contextData.statistics.dodgemResult.score, COLOR_BLUE)
	})
	table.insert(var_12_0, {
		text = setColorStr(i18n("battle_result_max_combo"), "#FFFFFFFF"),
		value = setColorStr(self.contextData.statistics.dodgemResult.maxCombo, COLOR_YELLOW)
	})

	return var_12_0
end

function NewDodgemResultGradePage:LoadPainitingContainer(arg_13_1)
	LoadAny("BattleResultItems/Painting", "", nil, function(arg_14_0)
		if self.exited then
			return
		end

		self:UpdatePainting(Object.Instantiate(arg_14_0, self.bgTr), arg_13_1)

		return
	end)

	return
end

function NewDodgemResultGradePage:UpdatePainting(arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1.transform:Find("painting")
	local var_15_1 = self:GetFlagShip()
	local var_15_2 = var_15_1:getPainting()

	setPaintingPrefabAsync(var_15_0, var_15_2, "biandui", function()
		ShipExpressionHelper.SetExpression(findTF(var_15_0, "fitter"):GetChild(0), var_15_2, ShipWordHelper.WORD_TYPE_MVP)
		arg_15_2()

		return
	end)
	self:DisplayShipDialogue(arg_15_1.transform:Find("chat"), var_15_1)

	self.paintingTr = var_15_0
	arg_15_1.transform.localPosition = Vector3(2500, 0, 0)

	arg_15_1.transform:SetSiblingIndex(2)
	setActive(self.objectiveContainer.parent, false)

	return
end

function NewDodgemResultGradePage:DisplayShipDialogue(arg_17_1, arg_17_2)
	local var_17_1

	if self.contextData.score > 1 then
		local var_17_3, var_17_4

		var_17_3, var_17_4, var_17_1 = ShipWordHelper.GetWordAndCV(arg_17_2.skinId, ShipWordHelper.WORD_TYPE_MVP)
	else
		local var_17_5, var_17_6

		var_17_5, var_17_6, var_17_1 = ShipWordHelper.GetWordAndCV(arg_17_2.skinId, ShipWordHelper.WORD_TYPE_LOSE)
	end

	local var_17_7 = arg_17_1:Find("Text"):GetComponent(typeof(Text))

	var_17_7.text = var_17_1

	if #var_17_1 > CHAT_POP_STR_LEN then
		var_17_7.alignment = TextAnchor.MiddleLeft or TextAnchor.MiddleCenter
	end

	return
end

function NewDodgemResultGradePage:GetFlagShip()
	return Ship.New({
		id = 9999,
		configId = 205021,
		skin_id = 205020
	})
end

function NewDodgemResultGradePage:OnDestroy()
	if self.paintingTr then
		retPaintingPrefab(self.paintingTr, self:GetFlagShip():getPainting())
	end

	NewDodgemResultGradePage.super.OnDestroy(self)

	return
end

return NewDodgemResultGradePage
