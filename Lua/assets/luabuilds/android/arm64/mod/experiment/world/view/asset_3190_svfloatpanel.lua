local SVFloatPanel = class("SVFloatPanel", import("view.base.BaseSubView"))

SVFloatPanel.ShowView = "SVFloatPanel.ShowView"
SVFloatPanel.HideView = "SVFloatPanel.HideView"
SVFloatPanel.ReturnCall = "SVFloatPanel.ReturnCall"

function SVFloatPanel:getUIName()
	return "SVFloatPanel"
end

function SVFloatPanel:OnLoaded()
	return
end

function SVFloatPanel:OnInit()
	self.rtBasePoint = self._tf:Find("point")
	self.rtInfoPanel = self.rtBasePoint:Find("line/bg")
	self.rtMarking = self.rtInfoPanel:Find("icon/marking")
	self.rtRes = self._tf:Find("res")
	self.awardItemList = UIItemList.New(self.rtInfoPanel:Find("pressing_award"), self.rtInfoPanel:Find("pressing_award/award_tpl"))

	self.awardItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = {
				type = self.awardConfig[arg_4_1 + 1][1],
				id = self.awardConfig[arg_4_1 + 1][2],
				count = self.awardConfig[arg_4_1 + 1][3]
			}

			updateDrop(arg_4_2:Find("IconTpl"), var_4_0)
			onButton(self, arg_4_2:Find("IconTpl"), function()
				self:emit(BaseUI.ON_DROP, var_4_0)

				return
			end, SFX_PANEL)
			setActive(arg_4_2:Find("is_pressing"), self.mapList[self.destIndex].isPressing)
			setActive(arg_4_2:Find("IconTpl"), not self.mapList[self.destIndex].isPressing)
		end

		return
	end)

	self.btnBack = self.rtInfoPanel:Find("back")

	onButton(self, self.btnBack, function()
		self:emit(WorldScene.SceneOp, "OpSetInMap", true)

		return
	end, SFX_CONFIRM)

	self.btnEnter = self.rtInfoPanel:Find("enter")

	onButton(self, self.btnEnter, function()
		local var_7_0 = {}
		local var_7_1 = self.mapList[self.destIndex]

		if WorldConst.HasDangerConfirm(self.mapList[self.destIndex].config.entrance_ui) then
			table.insert(var_7_0, function(arg_8_0)
				self:emit(WorldScene.SceneOp, "OpCall", function(arg_9_0)
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

		seriesAsync(var_7_0, function()
			local var_10_0 = nowWorld().staminaMgr

			if not var_7_1.isCost and var_7_1.config.enter_cost > var_10_0:GetTotalStamina() then
				var_10_0:Show()
			else
				self:emit(WorldScene.SceneOp, "OpTransport", self.entrance, var_7_1)
			end

			return
		end)

		return
	end, SFX_CONFIRM)

	self.btnLock = self.rtInfoPanel:Find("lock")
	self.btnReturn = self.rtInfoPanel:Find("return")

	onButton(self, self.btnReturn, function()
		self:emit(SVFloatPanel.ReturnCall, self.entrance)

		return
	end, SFX_CONFIRM)

	self.btnSwitch = self.rtInfoPanel:Find("switch")

	onButton(self, self.btnSwitch, function()
		if self.isTweening then
			return
		end

		self:ShowToggleMask()

		return
	end, SFX_PANEL)

	self.rtSelectMask = self._tf:Find("select_mask")

	onButton(self, self.rtSelectMask:Find("bg"), function()
		if self.isTweening then
			return
		end

		self:HideToggleMask()

		return
	end, SFX_PANEL)

	self.rtMaskMarking = self.rtSelectMask:Find("marking")
	self.rtToggles = self.rtMaskMarking:Find("toggles")
	self.toggleItemList = UIItemList.New(self.rtToggles, self.rtToggles:Find("toggle"))

	self.toggleItemList:make(function(arg_14_0, arg_14_1, arg_14_2)
		arg_14_1 = arg_14_1 + 1

		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0, var_14_1 = World.ReplacementMapType(self.entrance, self.mapList[arg_14_1])

			setText(arg_14_2:Find("Text"), var_14_1)
			onToggle(self, arg_14_2, function(arg_15_0)
				if arg_15_0 then
					self:HideToggleMask()

					self.destIndex = arg_14_1

					self:UpdatePanel()
				end

				return
			end, SFX_PANEL)
			triggerToggle(arg_14_2, false)
		end

		return
	end)

	return
end

function SVFloatPanel:OnDestroy()
	return
end

function SVFloatPanel:Show()
	setActive(self._tf, true)

	return
end

function SVFloatPanel:Hide()
	setActive(self._tf, false)

	return
end

function SVFloatPanel:Setup(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	self.entrance = arg_19_1

	setAnchoredPosition(self.rtBasePoint, self._tf:InverseTransformPoint(GameObject.Find("OverlayCamera"):GetComponent(typeof(Camera)):ScreenToWorldPoint((arg_19_4:GetMapScreenPos(Vector2(arg_19_1.config.area_pos[1], arg_19_1.config.area_pos[2]))))))

	self.mapList = nowWorld():EntranceToReplacementMapList(arg_19_1)

	self.toggleItemList:align(#self.mapList)
	triggerToggle(self.rtToggles:GetChild((function()
		if arg_19_2 then
			for iter_20_0, iter_20_1 in ipairs(self.mapList) do
				if iter_20_1.id == arg_19_2 then
					return iter_20_0
				end
			end
		end

		if arg_19_3 then
			for iter_20_2, iter_20_3 in ipairs(arg_19_3) do
				for iter_20_4, iter_20_5 in ipairs(self.mapList) do
					if iter_20_3 == World.ReplacementMapType(arg_19_1, iter_20_5) then
						return iter_20_4
					end
				end
			end
		end

		if arg_19_1.active then
			for iter_20_6, iter_20_7 in ipairs(self.mapList) do
				if iter_20_7.active then
					return iter_20_6
				end
			end
		end

		return 1
	end)() - 1), true)

	return
end

function SVFloatPanel:setColorfulImage(arg_21_1, arg_21_2, arg_21_3)
	arg_21_3 = defaultValue(arg_21_3, true)

	setImageSprite(arg_21_1, getImageSprite(self.rtRes:Find(arg_21_1.name .. "/" .. arg_21_2)), arg_21_3)

	return
end

function SVFloatPanel:UpdatePanel()
	local var_22_0 = nowWorld()
	local var_22_1 = self.mapList[self.destIndex]
	local var_22_2, var_22_3 = World.ReplacementMapType(self.entrance, self.mapList[self.destIndex])
	local var_22_4 = var_22_2 == "complete_chapter" and "safe" or WorldConst.GetMapIconState(var_22_1.config.entrance_ui)
	local var_22_5 = var_22_1:IsMapOpen()

	self:setColorfulImage(self.rtBasePoint, var_22_4)
	self:setColorfulImage(self.rtInfoPanel, var_22_4, false)
	setImageSprite(self.rtInfoPanel:Find("icon"), (GetSpriteFromAtlas("world/mapicon/" .. var_22_1.config.entrance_mapicon, "")))
	self:setColorfulImage(self.btnBack, var_22_4)
	self:setColorfulImage(self.btnEnter, var_22_4)
	self:setColorfulImage(self.rtMarking, var_22_4)
	self:setColorfulImage(self.rtMarking:Find("mark_bg"), var_22_4)
	self:setColorfulImage(self.rtMaskMarking, var_22_4)
	self:setColorfulImage(self.rtMaskMarking:Find("mark_bg"), var_22_4)
	setText(self.rtMarking:Find("Text"), var_22_3)
	setText(self.rtMaskMarking:Find("Text"), var_22_3)
	setActive(self.rtInfoPanel:Find("sairen"), var_22_2 == "sairen_chapter")
	setText(self.rtInfoPanel:Find("sairen/Text"), i18n("area_yaosai_2"))
	setText(self.rtInfoPanel:Find("danger_text"), var_22_5 and var_22_1:GetDanger() or "?")
	changeToScrollText(self.rtInfoPanel:Find("title/name"), var_22_1:GetName(self.entrance))

	local var_22_6, var_22_7, var_22_8 = var_22_0:CountAchievements(self.entrance)

	setText(self.rtInfoPanel:Find("title/achievement/number"), var_22_6 + var_22_7 .. "/" .. var_22_8)

	local var_22_9 = var_22_0:GetPressingAward(var_22_1.id)

	setActive(self.rtInfoPanel:Find("pressing_award"), var_22_9 and var_22_9.flag)

	if var_22_9 and var_22_9.flag then
		self.awardConfig = pg.world_event_complete[var_22_9.id].tips_icon

		self.awardItemList:align(#self.awardConfig)
	end

	self:UpdateCost()

	local var_22_10 = nowWorld():GetAtlas()
	local var_22_11 = var_22_10:GetActiveMap()
	local var_22_12, var_22_13 = var_22_11:CkeckTransport()
	local var_22_14 = false

	setActive(self.btnBack, not var_22_14 and var_22_10:GetActiveEntrance() == self.entrance and var_22_11 == var_22_1)

	var_22_14 = var_22_14 or isActive(self.btnBack)

	setActive(self.btnEnter, not var_22_14 and var_22_12 and var_22_5 and var_22_10.transportDic[self.entrance.id])

	local var_22_15

	if not var_22_14 then
		var_22_14 = isActive(self.btnEnter)
		var_22_15 = var_22_5 and i18n("world_map_locked_border") or i18n("world_map_locked_stage")
	end

	setText(self.btnLock:Find("Text"), var_22_15)
	setActive(self.btnLock, not var_22_14 and var_22_12)

	var_22_14 = var_22_14 or isActive(self.btnLock)

	setActive(self.btnReturn, not var_22_14)

	local var_22_16

	var_22_16 = var_22_14 or isActive(self.btnReturn)

	return
end

function SVFloatPanel:UpdateCost()
	local var_23_0 = self.btnEnter:Find("cost")

	setActive(var_23_0, not self.mapList[self.destIndex].isCost)

	local var_23_1 = nowWorld().staminaMgr:GetTotalStamina()

	setText(var_23_0:Find("Text"), setColorStr(var_23_1, (var_23_1 < self.mapList[self.destIndex].config.enter_cost or nil) and (COLOR_RED or COLOR_GREEN)) .. "/" .. self.mapList[self.destIndex].config.enter_cost)

	return
end

function SVFloatPanel:ShowToggleMask()
	self.isTweening = true

	setActive(self.rtMarking, false)
	setActive(self.rtSelectMask, true)
	setActive(self.rtToggles, false)

	self.rtMaskMarking.position = self.rtMarking.position

	LeanTween.moveY(self.rtMaskMarking, self.rtMaskMarking.anchoredPosition.y + 22, 0.2):setOnComplete(System.Action(function()
		setActive(self.rtToggles, true)

		self.isTweening = false

		return
	end))
	setActive(self.btnSwitch, false)

	return
end

function SVFloatPanel:HideToggleMask()
	self.isTweening = true

	setActive(self.rtToggles, false)

	self.rtMaskMarking.position = self.rtMarking.position

	setAnchoredPosition(self.rtMaskMarking, {
		y = self.rtMaskMarking.anchoredPosition.y + 22
	})
	LeanTween.moveY(self.rtMaskMarking, self.rtMaskMarking.anchoredPosition.y - 22, 0.2):setOnComplete(System.Action(function()
		setActive(self.rtSelectMask, false)
		setActive(self.rtMarking, true)

		self.isTweening = false

		setActive(self.btnSwitch, #self.mapList > 1)

		return
	end))

	return
end

return SVFloatPanel
