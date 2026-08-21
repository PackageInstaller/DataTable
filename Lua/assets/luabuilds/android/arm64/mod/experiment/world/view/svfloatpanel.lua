local var_0_0 = class("SVFloatPanel", import("view.base.BaseSubView"))

var_0_0.ShowView = "SVFloatPanel.ShowView"
var_0_0.HideView = "SVFloatPanel.HideView"
var_0_0.ReturnCall = "SVFloatPanel.ReturnCall"

function var_0_0.getUIName(arg_1_0)
	return "SVFloatPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.rtBasePoint = arg_3_0._tf:Find("point")
	arg_3_0.rtInfoPanel = arg_3_0.rtBasePoint:Find("line/bg")
	arg_3_0.rtMarking = arg_3_0.rtInfoPanel:Find("icon/marking")
	arg_3_0.rtRes = arg_3_0._tf:Find("res")
	arg_3_0.awardItemList = UIItemList.New(arg_3_0.rtInfoPanel:Find("pressing_award"), arg_3_0.rtInfoPanel:Find("pressing_award/award_tpl"))

	arg_3_0.awardItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			updateDrop(arg_4_2:Find("IconTpl"), {
				type = arg_3_0.awardConfig[arg_4_1 + 1][1],
				id = arg_3_0.awardConfig[arg_4_1 + 1][2],
				count = arg_3_0.awardConfig[arg_4_1 + 1][3]
			})
			onButton(arg_3_0, arg_4_2:Find("IconTpl"), function()
				arg_3_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			setActive(arg_4_2:Find("is_pressing"), arg_3_0.mapList[arg_3_0.destIndex].isPressing)
			setActive(arg_4_2:Find("IconTpl"), not arg_3_0.mapList[arg_3_0.destIndex].isPressing)
		end

		return
	end)

	arg_3_0.btnBack = arg_3_0.rtInfoPanel:Find("back")

	onButton(arg_3_0, arg_3_0.btnBack, function()
		arg_3_0:emit(WorldScene.SceneOp, "OpSetInMap", true)

		return
	end, SFX_CONFIRM)

	arg_3_0.btnEnter = arg_3_0.rtInfoPanel:Find("enter")

	onButton(arg_3_0, arg_3_0.btnEnter, function()
		if WorldConst.HasDangerConfirm(arg_3_0.mapList[arg_3_0.destIndex].config.entrance_ui) then
			table.insert({}, function(arg_8_0)
				arg_3_0:emit(WorldScene.SceneOp, "OpCall", function(arg_9_0)
					arg_9_0()
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("world_map_dangerous_confirm"),
						onYes = arg_8_0
					})

					return
				end)

				return
			end)
		end

		seriesAsync({}, function()
			local var_10_0 = nowWorld().staminaMgr

			if not var_0.isCost and var_0.config.enter_cost > var_10_0:GetTotalStamina() then
				var_10_0:Show()
			else
				arg_3_0:emit(WorldScene.SceneOp, "OpTransport", arg_3_0.entrance, var_0)
			end

			return
		end)

		return
	end, SFX_CONFIRM)

	arg_3_0.btnLock = arg_3_0.rtInfoPanel:Find("lock")
	arg_3_0.btnReturn = arg_3_0.rtInfoPanel:Find("return")

	onButton(arg_3_0, arg_3_0.btnReturn, function()
		arg_3_0:emit(var_0_0.ReturnCall, arg_3_0.entrance)

		return
	end, SFX_CONFIRM)

	arg_3_0.btnSwitch = arg_3_0.rtInfoPanel:Find("switch")

	onButton(arg_3_0, arg_3_0.btnSwitch, function()
		if arg_3_0.isTweening then
			return
		end

		arg_3_0:ShowToggleMask()

		return
	end, SFX_PANEL)

	arg_3_0.rtSelectMask = arg_3_0._tf:Find("select_mask")

	onButton(arg_3_0, arg_3_0.rtSelectMask:Find("bg"), function()
		if arg_3_0.isTweening then
			return
		end

		arg_3_0:HideToggleMask()

		return
	end, SFX_PANEL)

	arg_3_0.rtMaskMarking = arg_3_0.rtSelectMask:Find("marking")
	arg_3_0.rtToggles = arg_3_0.rtMaskMarking:Find("toggles")
	arg_3_0.toggleItemList = UIItemList.New(arg_3_0.rtToggles, arg_3_0.rtToggles:Find("toggle"))

	arg_3_0.toggleItemList:make(function(arg_14_0, arg_14_1, arg_14_2)
		arg_14_1 = arg_14_1 + 1

		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0, var_14_1 = World.ReplacementMapType(arg_3_0.entrance, arg_3_0.mapList[arg_14_1])

			setText(arg_14_2:Find("Text"), var_14_1)
			onToggle(arg_3_0, arg_14_2, function(arg_15_0)
				if arg_15_0 then
					arg_3_0:HideToggleMask()

					arg_3_0.destIndex = arg_14_1

					arg_3_0:UpdatePanel()
				end

				return
			end, SFX_PANEL)
			triggerToggle(arg_14_2, false)
		end

		return
	end)

	return
end

function var_0_0.OnDestroy(arg_16_0)
	return
end

function var_0_0.Show(arg_17_0)
	setActive(arg_17_0._tf, true)

	return
end

function var_0_0.Hide(arg_18_0)
	setActive(arg_18_0._tf, false)

	return
end

function var_0_0.Setup(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_0.entrance = arg_19_1

	setAnchoredPosition(arg_19_0.rtBasePoint, arg_19_0._tf:InverseTransformPoint(GameObject.Find("OverlayCamera"):GetComponent(typeof(Camera)):ScreenToWorldPoint((arg_19_4:GetMapScreenPos(Vector2(arg_19_1.config.area_pos[1], arg_19_1.config.area_pos[2]))))))

	arg_19_0.mapList = nowWorld():EntranceToReplacementMapList(arg_19_1)

	arg_19_0.toggleItemList:align(#arg_19_0.mapList)
	triggerToggle(arg_19_0.rtToggles:GetChild((function()
		if arg_19_2 then
			for iter_20_0, iter_20_1 in ipairs(arg_19_0.mapList) do
				if iter_20_1.id == arg_19_2 then
					return iter_20_0
				end
			end
		end

		if arg_19_3 then
			for iter_20_2, iter_20_3 in ipairs(arg_19_3) do
				for iter_20_4, iter_20_5 in ipairs(arg_19_0.mapList) do
					if iter_20_3 == World.ReplacementMapType(arg_19_1, iter_20_5) then
						return iter_20_4
					end
				end
			end
		end

		if arg_19_1.active then
			for iter_20_6, iter_20_7 in ipairs(arg_19_0.mapList) do
				if iter_20_7.active then
					return iter_20_6
				end
			end
		end

		return 1
	end)() - 1), true)

	return
end

function var_0_0.setColorfulImage(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_3 = defaultValue(arg_21_3, true)

	setImageSprite(arg_21_1, getImageSprite(arg_21_0.rtRes:Find(arg_21_1.name .. "/" .. arg_21_2)), arg_21_3)

	return
end

function var_0_0.UpdatePanel(arg_22_0)
	local var_22_0 = nowWorld()
	local var_22_1 = arg_22_0.mapList[arg_22_0.destIndex]
	local var_22_2, var_22_3 = World.ReplacementMapType(arg_22_0.entrance, arg_22_0.mapList[arg_22_0.destIndex])
	local var_22_4 = var_22_2 == "complete_chapter" and "safe" or WorldConst.GetMapIconState(var_22_1.config.entrance_ui)
	local var_22_5 = var_22_1:IsMapOpen()

	arg_22_0:setColorfulImage(arg_22_0.rtBasePoint, var_22_4)
	arg_22_0:setColorfulImage(arg_22_0.rtInfoPanel, var_22_4, false)
	setImageSprite(arg_22_0.rtInfoPanel:Find("icon"), (GetSpriteFromAtlas("world/mapicon/" .. var_22_1.config.entrance_mapicon, "")))
	arg_22_0:setColorfulImage(arg_22_0.btnBack, var_22_4)
	arg_22_0:setColorfulImage(arg_22_0.btnEnter, var_22_4)
	arg_22_0:setColorfulImage(arg_22_0.rtMarking, var_22_4)
	arg_22_0:setColorfulImage(arg_22_0.rtMarking:Find("mark_bg"), var_22_4)
	arg_22_0:setColorfulImage(arg_22_0.rtMaskMarking, var_22_4)
	arg_22_0:setColorfulImage(arg_22_0.rtMaskMarking:Find("mark_bg"), var_22_4)
	setText(arg_22_0.rtMarking:Find("Text"), var_22_3)
	setText(arg_22_0.rtMaskMarking:Find("Text"), var_22_3)
	setActive(arg_22_0.rtInfoPanel:Find("sairen"), var_22_2 == "sairen_chapter")
	setText(arg_22_0.rtInfoPanel:Find("sairen/Text"), i18n("area_yaosai_2"))

	local var_22_6 = var_22_5 and var_22_1:GetDanger() or "?"

	setText(arg_22_0.rtInfoPanel:Find("danger_text"), var_22_6)
	changeToScrollText(arg_22_0.rtInfoPanel:Find("title/name"), var_22_1:GetName(arg_22_0.entrance))

	local var_22_7, var_22_8, var_22_9 = var_22_0:CountAchievements(arg_22_0.entrance)

	setText(arg_22_0.rtInfoPanel:Find("title/achievement/number"), var_22_7 + var_22_8 .. "/" .. var_22_9)

	local var_22_10 = var_22_0:GetPressingAward(var_22_1.id)

	setActive(arg_22_0.rtInfoPanel:Find("pressing_award"), var_22_10 and var_22_10.flag)

	if var_22_10 and var_22_10.flag then
		arg_22_0.awardConfig = pg.world_event_complete[var_22_10.id].tips_icon

		arg_22_0.awardItemList:align(#arg_22_0.awardConfig)
	end

	arg_22_0:UpdateCost()

	local var_22_11 = nowWorld():GetAtlas()
	local var_22_12 = var_22_11:GetActiveMap()
	local var_22_13, var_22_14 = var_22_12:CkeckTransport()
	local var_22_15 = false

	setActive(arg_22_0.btnBack, not var_22_15 and var_22_11:GetActiveEntrance() == arg_22_0.entrance and var_22_12 == var_22_1)

	var_22_15 = var_22_15 or isActive(arg_22_0.btnBack)

	setActive(arg_22_0.btnEnter, not var_22_15 and var_22_13 and var_22_5 and var_22_11.transportDic[arg_22_0.entrance.id])

	local var_22_16

	if not var_22_15 then
		var_22_15 = isActive(arg_22_0.btnEnter)
		var_22_16 = var_22_5 and i18n("world_map_locked_border") or i18n("world_map_locked_stage")
	end

	setText(arg_22_0.btnLock:Find("Text"), var_22_16)
	setActive(arg_22_0.btnLock, not var_22_15 and var_22_13)

	var_22_15 = var_22_15 or isActive(arg_22_0.btnLock)

	setActive(arg_22_0.btnReturn, not var_22_15)

	local var_22_17

	var_22_17 = var_22_15 or isActive(arg_22_0.btnReturn)

	return
end

function var_0_0.UpdateCost(arg_23_0)
	local var_23_0 = arg_23_0.btnEnter:Find("cost")

	setActive(var_23_0, not arg_23_0.mapList[arg_23_0.destIndex].isCost)

	local var_23_1 = nowWorld().staminaMgr:GetTotalStamina()
	local var_23_2 = arg_23_0.mapList[arg_23_0.destIndex].config.enter_cost
	local var_23_4 = var_23_0:Find("Text")
	local var_23_6 = var_23_1

	if var_23_1 < arg_23_0.mapList[arg_23_0.destIndex].config.enter_cost then
		local var_23_7 = COLOR_RED or COLOR_GREEN
		local var_23_8 = var_23_5(var_23_6, var_23_7)

		var_23_3(var_23_4, var_23_8 .. "/" .. var_23_2)

		return
	end
end

function var_0_0.ShowToggleMask(arg_24_0)
	arg_24_0.isTweening = true

	setActive(arg_24_0.rtMarking, false)
	setActive(arg_24_0.rtSelectMask, true)
	setActive(arg_24_0.rtToggles, false)

	arg_24_0.rtMaskMarking.position = arg_24_0.rtMarking.position

	LeanTween.moveY(arg_24_0.rtMaskMarking, arg_24_0.rtMaskMarking.anchoredPosition.y + 22, 0.2):setOnComplete(System.Action(function()
		setActive(arg_24_0.rtToggles, true)

		arg_24_0.isTweening = false

		return
	end))
	setActive(arg_24_0.btnSwitch, false)

	return
end

function var_0_0.HideToggleMask(arg_26_0)
	arg_26_0.isTweening = true

	setActive(arg_26_0.rtToggles, false)

	arg_26_0.rtMaskMarking.position = arg_26_0.rtMarking.position

	setAnchoredPosition(arg_26_0.rtMaskMarking, {
		y = arg_26_0.rtMaskMarking.anchoredPosition.y + 22
	})
	LeanTween.moveY(arg_26_0.rtMaskMarking, arg_26_0.rtMaskMarking.anchoredPosition.y - 22, 0.2):setOnComplete(System.Action(function()
		setActive(arg_26_0.rtSelectMask, false)
		setActive(arg_26_0.rtMarking, true)

		arg_26_0.isTweening = false

		setActive(arg_26_0.btnSwitch, #arg_26_0.mapList > 1)

		return
	end))

	return
end

return var_0_0
