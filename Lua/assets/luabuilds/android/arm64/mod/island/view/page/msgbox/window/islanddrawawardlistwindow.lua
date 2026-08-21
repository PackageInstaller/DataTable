local var_0_0 = class("IslandDrawAwardListWindow", import("Mod.Island.View.page.msgbox.window.IslandBaseMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandDrawAwardListMsgBox"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.OnInit(arg_3_0)
	setText(arg_3_0.rtTitle, i18n("island_draw_S_order_title"))
	onButton(arg_3_0, arg_3_0.btnClose, function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)

	arg_3_0.toggleList = UIItemList.New(arg_3_0.rtToggles, arg_3_0.rtToggleTpl)

	arg_3_0.toggleList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0, var_5_1 = unpack(arg_3_0.countAwardList[arg_5_1])

			arg_5_2.name = var_5_0

			local var_5_2 = Drop.New({
				type = pg.island_draw_reward[var_5_0].drop_type,
				id = pg.island_draw_reward[var_5_0].drop_id
			})

			IslandShopDrawAwardPage.ShowDropInfo(var_5_2, arg_5_2:Find("mask/Image"))
			setScrollText(arg_5_2:Find("name/Text"), var_5_2:getName())
			setText(arg_5_2:Find("got/got/Text"), i18n("island_draw_get"))
			setActive(arg_5_2:Find("got"), not var_5_1)
			arg_3_0:detachOnCardButton(arg_5_2)

			if var_5_1 then
				arg_3_0:attachOnCardButton(arg_5_2)
			end
		end

		return
	end)

	arg_3_0.marksList = UIItemList.New(arg_3_0.rtMarks, arg_3_0.rtMakrsTpl)

	arg_3_0.marksList:make(function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_1 = arg_6_1 + 1

		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0, var_6_1 = unpack(arg_3_0.countAwardList[arg_6_1])

			setActive(arg_6_2:Find("mark"), var_6_1)
			setText(arg_6_2:Find("mark/Text"), arg_6_1)
		end

		return
	end)
	setText(arg_3_0.btnConfirm:Find("Text"), i18n("word_ok"))
	onButton(arg_3_0, arg_3_0.btnConfirm, function()
		({
			op = "set_list",
			activity_id = arg_3_0.activity.id
		}).list = underscore(arg_3_0.countAwardList):chain():filter(function(arg_8_0)
			return arg_8_0[2]
		end):map(function(arg_9_0)
			return arg_9_0[1]
		end):value()

		arg_3_0:emit(IslandMediator.DRAW_AWARD_OPERATION, {
			op = "set_list",
			activity_id = arg_3_0.activity.id
		})
		arg_3_0:Hide()

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.detachOnCardButton(arg_10_0, arg_10_1)
	local var_10_0 = GetOrAddComponent(arg_10_1, "EventTriggerListener")

	var_10_0:RemovePointClickFunc()
	var_10_0:RemoveBeginDragFunc()
	var_10_0:RemoveDragFunc()
	var_10_0:RemoveDragEndFunc()

	return
end

function var_0_0.attachOnCardButton(arg_11_0, arg_11_1)
	local var_11_0 = GetOrAddComponent(arg_11_1, "EventTriggerListener")
	local var_11_1 = arg_11_1.parent
	local var_11_2 = {}

	var_11_0:AddBeginDragFunc(function()
		if arg_11_0.carddrag then
			return
		end

		arg_11_0._currentDragDelegate = var_11_0
		arg_11_0.carddrag = arg_11_1

		for iter_12_0 = 1, arg_11_0.count do
			var_11_2[iter_12_0] = var_11_1:GetChild(iter_12_0 - 1).localPosition.x
		end

		arg_11_0.before = arg_11_1:GetSiblingIndex() + 1
		arg_11_0.after = arg_11_0.before
		arg_11_0.copyCard = cloneTplTo(arg_11_1, var_11_1, "copy")

		arg_11_0.copyCard:SetSiblingIndex(arg_11_0.before - 1)

		GetOrAddComponent(arg_11_0.copyCard, typeof(CanvasGroup)).alpha = 0
		GetOrAddComponent(arg_11_1, typeof(LayoutElement)).ignoreLayout = true

		arg_11_1:SetAsLastSibling()
		LeanTween.scale(arg_11_1, Vector3(1.1, 1.1, 1), 0.3)

		return
	end)
	var_11_0:AddDragFunc(function(arg_13_0, arg_13_1)
		if arg_11_0.carddrag ~= arg_11_1 then
			return
		end

		local var_13_0 = arg_11_1.localPosition

		var_13_0.x = math.clamp(arg_11_0:change2ScrPos(var_11_1, arg_13_1.position).x, var_11_2[1], var_11_2[#var_11_2])
		arg_11_1.localPosition = var_13_0

		local var_13_1 = 1

		for iter_13_0, iter_13_1 in ipairs(var_11_2) do
			if not var_11_2[iter_13_0 + 1] or var_13_0.x < (iter_13_1 + var_11_2[iter_13_0 + 1]) / 2 then
				var_13_1 = iter_13_0

				break
			end
		end

		if var_13_1 ~= arg_11_0.after then
			arg_11_0.after = var_13_1

			arg_11_0.copyCard:SetSiblingIndex(arg_11_0.after - 1)
		end

		return
	end)
	var_11_0:AddDragEndFunc(function(arg_14_0, arg_14_1)
		if arg_11_0.carddrag ~= arg_11_1 then
			return
		end

		local var_14_0 = arg_11_0._forceDropCharacter

		arg_11_0._forceDropCharacter = nil
		arg_11_0._currentDragDelegate = nil
		var_11_0.enabled = false

		table.insert({}, function(arg_15_0)
			if var_14_0 then
				arg_11_1.localScale = Vector3(1, 1, 1)

				arg_15_0()
			else
				parallelAsync({
					function(arg_16_0)
						LeanTween.moveLocalX(arg_11_1.gameObject, var_11_2[arg_11_0.after], math.min(math.abs(arg_11_1.localPosition.x - var_11_2[arg_11_0.after]) / 200, 1) * 0.3):setEase(LeanTweenType.easeOutCubic):setOnComplete(System.Action(arg_16_0))

						return
					end,
					function(arg_17_0)
						LeanTween.scale(arg_11_1, Vector3(1, 1, 1), 0.3):setOnComplete(System.Action(arg_17_0))

						return
					end
				}, arg_15_0)
			end

			return
		end)
		seriesAsync({}, function()
			Destroy(arg_11_0.copyCard)

			arg_11_0.copyCard = nil

			arg_11_1:SetSiblingIndex(arg_11_0.after - 1)

			GetOrAddComponent(arg_11_1, typeof(LayoutElement)).ignoreLayout = false

			table.insert(arg_11_0.countAwardList, arg_11_0.after, table.remove(arg_11_0.countAwardList, arg_11_0.before))

			arg_11_0.before = nil
			arg_11_0.after = nil
			var_11_0.enabled = true
			arg_11_0.carddrag = nil

			return
		end)

		return
	end)

	return
end

function var_0_0.ForceDropChar(arg_19_0)
	if arg_19_0._currentDragDelegate then
		arg_19_0._forceDropCharacter = true

		LuaHelper.triggerEndDrag(arg_19_0._currentDragDelegate)
	end

	return
end

function var_0_0.change2ScrPos(arg_20_0, arg_20_1, arg_20_2)
	return (LuaHelper.ScreenToLocal(arg_20_1, arg_20_2, pg.UIMgr.GetInstance().overlayCameraComp))
end

function var_0_0.OnShow(arg_21_0)
	var_0_0.super.OnShow(arg_21_0)
	arg_21_0:UpdateActivity(arg_21_0.settings.activity)

	return
end

function var_0_0.UpdateActivity(arg_22_0, arg_22_1)
	arg_22_0.activity = arg_22_1
	arg_22_0.countAwardList = arg_22_1:GetList()

	mergeSort(arg_22_0.countAwardList, CompareFuncs({
		function(arg_23_0)
			return arg_23_0[2] and 0 or 1
		end
	}, true))

	arg_22_0.count = #underscore.filter(arg_22_0.countAwardList, function(arg_24_0)
		return arg_24_0[2]
	end)

	arg_22_0.toggleList:align(#arg_22_0.countAwardList)
	arg_22_0.marksList:align(#arg_22_0.countAwardList)
	setText(arg_22_0.rtCountWord, i18n("island_draw_S_order"))

	return
end

return var_0_0
