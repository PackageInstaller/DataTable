local IslandDrawAwardListWindow = class("IslandDrawAwardListWindow", import("Mod.Island.View.page.msgbox.window.IslandBaseMsgboxWindow"))

function IslandDrawAwardListWindow:getUIName()
	return "IslandDrawAwardListMsgBox"
end

function IslandDrawAwardListWindow:OnLoaded()
	return
end

function IslandDrawAwardListWindow:OnInit()
	setText(self.rtTitle, i18n("island_draw_S_order_title"))
	onButton(self, self.btnClose, function()
		self:Hide()

		return
	end, SFX_CANCEL)

	self.toggleList = UIItemList.New(self.rtToggles, self.rtToggleTpl)

	self.toggleList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0, var_5_1 = unpack(self.countAwardList[arg_5_1])

			arg_5_2.name = var_5_0

			local var_5_2 = Drop.New({
				type = pg.island_draw_reward[var_5_0].drop_type,
				id = pg.island_draw_reward[var_5_0].drop_id
			})

			IslandShopDrawAwardPage.ShowDropInfo(var_5_2, arg_5_2:Find("mask/Image"))
			setScrollText(arg_5_2:Find("name/Text"), var_5_2:getName())
			setText(arg_5_2:Find("got/got/Text"), i18n("island_draw_get"))
			setActive(arg_5_2:Find("got"), not var_5_1)
			self:detachOnCardButton(arg_5_2)

			if var_5_1 then
				self:attachOnCardButton(arg_5_2)
			end
		end

		return
	end)

	self.marksList = UIItemList.New(self.rtMarks, self.rtMakrsTpl)

	self.marksList:make(function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_1 = arg_6_1 + 1

		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0, var_6_1 = unpack(self.countAwardList[arg_6_1])

			setActive(arg_6_2:Find("mark"), var_6_1)
			setText(arg_6_2:Find("mark/Text"), arg_6_1)
		end

		return
	end)
	setText(self.btnConfirm:Find("Text"), i18n("word_ok"))
	onButton(self, self.btnConfirm, function()
		local var_7_0 = {
			op = "set_list",
			activity_id = self.activity.id
		}

		var_7_0.list = underscore(self.countAwardList):chain():filter(function(arg_8_0)
			return arg_8_0[2]
		end):map(function(arg_9_0)
			return arg_9_0[1]
		end):value()

		self:emit(IslandMediator.DRAW_AWARD_OPERATION, var_7_0)
		self:Hide()

		return
	end, SFX_CONFIRM)

	return
end

function IslandDrawAwardListWindow:detachOnCardButton(arg_10_1)
	local var_10_0 = GetOrAddComponent(arg_10_1, "EventTriggerListener")

	var_10_0:RemovePointClickFunc()
	var_10_0:RemoveBeginDragFunc()
	var_10_0:RemoveDragFunc()
	var_10_0:RemoveDragEndFunc()

	return
end

function IslandDrawAwardListWindow:attachOnCardButton(arg_11_1)
	local var_11_0 = GetOrAddComponent(arg_11_1, "EventTriggerListener")
	local var_11_1 = arg_11_1.parent
	local var_11_2 = {}

	var_11_0:AddBeginDragFunc(function()
		if self.carddrag then
			return
		end

		self._currentDragDelegate = var_11_0
		self.carddrag = arg_11_1

		for iter_12_0 = 1, self.count do
			var_11_2[iter_12_0] = var_11_1:GetChild(iter_12_0 - 1).localPosition.x
		end

		self.before = arg_11_1:GetSiblingIndex() + 1
		self.after = self.before
		self.copyCard = cloneTplTo(arg_11_1, var_11_1, "copy")

		self.copyCard:SetSiblingIndex(self.before - 1)

		GetOrAddComponent(self.copyCard, typeof(CanvasGroup)).alpha = 0
		GetOrAddComponent(arg_11_1, typeof(LayoutElement)).ignoreLayout = true

		arg_11_1:SetAsLastSibling()
		LeanTween.scale(arg_11_1, Vector3(1.1, 1.1, 1), 0.3)

		return
	end)
	var_11_0:AddDragFunc(function(arg_13_0, arg_13_1)
		if self.carddrag ~= arg_11_1 then
			return
		end

		local var_13_0 = arg_11_1.localPosition

		var_13_0.x = math.clamp(self:change2ScrPos(var_11_1, arg_13_1.position).x, var_11_2[1], var_11_2[#var_11_2])
		arg_11_1.localPosition = var_13_0

		local var_13_1 = 1

		for iter_13_0, iter_13_1 in ipairs(var_11_2) do
			if not var_11_2[iter_13_0 + 1] or var_13_0.x < (iter_13_1 + var_11_2[iter_13_0 + 1]) / 2 then
				var_13_1 = iter_13_0

				break
			end
		end

		if var_13_1 ~= self.after then
			self.after = var_13_1

			self.copyCard:SetSiblingIndex(self.after - 1)
		end

		return
	end)
	var_11_0:AddDragEndFunc(function(arg_14_0, arg_14_1)
		if self.carddrag ~= arg_11_1 then
			return
		end

		local var_14_0 = self._forceDropCharacter

		self._forceDropCharacter = nil
		self._currentDragDelegate = nil
		var_11_0.enabled = false

		local var_14_1 = {}

		table.insert(var_14_1, function(arg_15_0)
			if var_14_0 then
				arg_11_1.localScale = Vector3(1, 1, 1)

				arg_15_0()
			else
				parallelAsync({
					function(arg_16_0)
						LeanTween.moveLocalX(arg_11_1.gameObject, var_11_2[self.after], math.min(math.abs(arg_11_1.localPosition.x - var_11_2[self.after]) / 200, 1) * 0.3):setEase(LeanTweenType.easeOutCubic):setOnComplete(System.Action(arg_16_0))

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
		seriesAsync(var_14_1, function()
			Destroy(self.copyCard)

			self.copyCard = nil

			arg_11_1:SetSiblingIndex(self.after - 1)

			GetOrAddComponent(arg_11_1, typeof(LayoutElement)).ignoreLayout = false

			table.insert(self.countAwardList, self.after, table.remove(self.countAwardList, self.before))

			self.before = nil
			self.after = nil
			var_11_0.enabled = true
			self.carddrag = nil

			return
		end)

		return
	end)

	return
end

function IslandDrawAwardListWindow:ForceDropChar()
	if self._currentDragDelegate then
		self._forceDropCharacter = true

		LuaHelper.triggerEndDrag(self._currentDragDelegate)
	end

	return
end

function IslandDrawAwardListWindow:change2ScrPos(arg_20_1, arg_20_2)
	return (LuaHelper.ScreenToLocal(arg_20_1, arg_20_2, pg.UIMgr.GetInstance().overlayCameraComp))
end

function IslandDrawAwardListWindow:OnShow()
	IslandDrawAwardListWindow.super.OnShow(self)
	self:UpdateActivity(self.settings.activity)

	return
end

function IslandDrawAwardListWindow:UpdateActivity(arg_22_1)
	self.activity = arg_22_1
	self.countAwardList = arg_22_1:GetList()

	mergeSort(self.countAwardList, CompareFuncs({
		function(arg_23_0)
			return arg_23_0[2] and 0 or 1
		end
	}, true))

	self.count = #underscore.filter(self.countAwardList, function(arg_24_0)
		return arg_24_0[2]
	end)

	self.toggleList:align(#self.countAwardList)
	self.marksList:align(#self.countAwardList)
	setText(self.rtCountWord, i18n("island_draw_S_order"))

	return
end

return IslandDrawAwardListWindow
