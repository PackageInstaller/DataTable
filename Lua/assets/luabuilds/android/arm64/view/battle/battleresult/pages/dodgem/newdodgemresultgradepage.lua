local var_0_0 = class("NewDodgemResultGradePage", import("..NewBattleResultGradePage"))

function var_0_0.LoadBG(arg_1_0, arg_1_1)
	LoadAnyAsync("BattleResultItems/" .. "CommonBg", "", nil, function(arg_2_0)
		if arg_1_0.exited or IsNil(arg_2_0) then
			if arg_1_1 then
				arg_1_1()
			end

			return
		end

		Object.Instantiate(arg_2_0, arg_1_0.bgTr).transform:SetAsFirstSibling()

		if arg_1_1 then
			arg_1_1()
		end

		return
	end)

	return
end

function var_0_0.RegisterEvent(arg_3_0, arg_3_1)
	seriesAsync({
		function(arg_4_0)
			var_0_0.super.RegisterEvent(arg_3_0, arg_4_0)

			return
		end,
		function(arg_5_0)
			removeOnButton(arg_3_0._tf)
			arg_3_0:LoadPainitingContainer(arg_5_0)

			return
		end,
		function(arg_6_0)
			arg_3_0:MovePainting(arg_6_0)

			return
		end
	}, function()
		onButton(arg_3_0, arg_3_0._tf, function()
			arg_3_1()

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function var_0_0.MovePainting(arg_9_0, arg_9_1)
	LeanTween.value(arg_9_0.paintingTr.parent.gameObject, 2500, 587, 0.3):setOnUpdate(System.Action_float(function(arg_10_0)
		var_0.localPosition = Vector3(arg_10_0, 0, 0)

		return
	end)):setOnComplete(System.Action(arg_9_1))
	LeanTween.value(arg_9_0.gradePanel.gameObject, arg_9_0.gradePanel.anchoredPosition, arg_9_0.gradePanel.anchoredPosition + Vector2(-247, 213), 0.29):setOnUpdate(System.Action_UnityEngine_Vector2(function(arg_11_0)
		arg_9_0.gradePanel.anchoredPosition3D = Vector3(arg_11_0.x, arg_11_0.y, 0)

		return
	end))

	return
end

function var_0_0.GetGetObjectives(arg_12_0)
	table.insert({}, {
		text = setColorStr(i18n("battle_result_total_score"), "#FFFFFFFF"),
		value = setColorStr(arg_12_0.contextData.statistics.dodgemResult.score, COLOR_BLUE)
	})
	table.insert({}, {
		text = setColorStr(i18n("battle_result_max_combo"), "#FFFFFFFF"),
		value = setColorStr(arg_12_0.contextData.statistics.dodgemResult.maxCombo, COLOR_YELLOW)
	})

	return {}
end

function var_0_0.LoadPainitingContainer(arg_13_0, arg_13_1)
	LoadAny("BattleResultItems/Painting", "", nil, function(arg_14_0)
		if arg_13_0.exited then
			return
		end

		arg_13_0:UpdatePainting(Object.Instantiate(arg_14_0, arg_13_0.bgTr), arg_13_1)

		return
	end)

	return
end

function var_0_0.UpdatePainting(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1.transform:Find("painting")
	local var_15_1 = arg_15_0:GetFlagShip()

	setPaintingPrefabAsync(var_15_0, var_15_1:getPainting(), "biandui", function()
		ShipExpressionHelper.SetExpression(findTF(var_15_0, "fitter"):GetChild(0), var_0, ShipWordHelper.WORD_TYPE_MVP)
		arg_15_2()

		return
	end)
	arg_15_0:DisplayShipDialogue(arg_15_1.transform:Find("chat"), var_15_1)

	arg_15_0.paintingTr = var_15_0
	arg_15_1.transform.localPosition = Vector3(2500, 0, 0)

	arg_15_1.transform:SetSiblingIndex(2)
	setActive(arg_15_0.objectiveContainer.parent, false)

	return
end

function var_0_0.DisplayShipDialogue(arg_17_0, arg_17_1, arg_17_2)
	local var_17_1

	if arg_17_0.contextData.score > 1 then
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

		return
	end
end

function var_0_0.GetFlagShip(arg_18_0)
	return Ship.New({
		id = 9999,
		configId = 205021,
		skin_id = 205020
	})
end

function var_0_0.OnDestroy(arg_19_0)
	if arg_19_0.paintingTr then
		retPaintingPrefab(arg_19_0.paintingTr, arg_19_0:GetFlagShip():getPainting())
	end

	var_0_0.super.OnDestroy(arg_19_0)

	return
end

return var_0_0
