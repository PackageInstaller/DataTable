local IslandShopDrawAwardPage = class("IslandShopDrawAwardPage", import("view.base.BaseSubView"))

function IslandShopDrawAwardPage:getUIName()
	return "IslandDrawAwardPage"
end

function IslandShopDrawAwardPage:Ctor(arg_2_1, arg_2_2)
	IslandShopDrawAwardPage.super.Ctor(self, arg_2_1, arg_2_2.event, arg_2_2.contextData)

	self.viewComponent = arg_2_2

	return
end

function IslandShopDrawAwardPage:OnLoaded()
	setActive(self.rtDisplayPanel, false)

	return
end

function IslandShopDrawAwardPage:OnInit()
	self.bannerRectDic = {}

	eachChild(self.rtMiddle, function(arg_5_0, arg_5_1)
		setText(arg_5_0:Find("got/Text"), i18n("island_draw_get"))

		local var_5_0 = arg_5_0.name

		switch(arg_5_0.name, {
			S = function()
				setText(arg_5_0:Find("state_sequence/Text"), i18n("选择"))
				setText(arg_5_0:Find("finish/Text"), i18n("island_draw_null"))
				onButton(self, arg_5_0:Find("state_sequence"), function()
					self:OpenChangeListWindow()

					return
				end, SFX_PANEL)
				onButton(self, arg_5_0:Find("btn_sequence"), function()
					self:OpenChangeListWindow()

					return
				end, SFX_PANEL)

				self.bannerRectDic[var_5_0] = BannerScrollRect4IslandDrawAward.New(arg_5_0:Find("mask/view/container"), arg_5_0:Find("dots"))

				return
			end,
			A = function()
				self.bannerRectDic[var_5_0] = BannerScrollRect4IslandDrawAward.New(arg_5_0:Find("mask/view/container"), arg_5_0:Find("dots"))

				return
			end,
			select = function()
				setText(arg_5_0:Find("count_word/Text"), i18n("island_draw_num"))
				setText(arg_5_0:Find("btn_select/Text"), i18n("island_draw_pick"))
				onButton(self, arg_5_0:Find("btn_select"), function()
					self:OpenSelectAwardWindow()

					return
				end, SFX_PANEL)

				self.bannerRectDic[var_5_0] = BannerScrollRect4IslandDrawAward.New(arg_5_0:Find("mask/view/container"), arg_5_0:Find("dots"))

				return
			end
		})

		return
	end)
	setText(self.rtTitle:Find("Text"), i18n("island_draw_time"))
	setText(self.btnAll:Find("Text"), i18n("island_draw_reward"))
	onButton(self, self.btnAll, function()
		self:OpenAllAwardWindow()

		return
	end, SFX_PANEL)
	setText(self.btnDraw:Find("Text"), i18n("island_draw_lottery"))
	onButton(self, self.btnDraw, function()
		if self.activity:GetTimesLeft() < 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_draw_float"))

			return
		end

		self:TryDraw(1)

		return
	end, SFX_PANEL)
	setText(self.btnDrawTen:Find("Text"), i18n("island_draw_lottery"))
	onButton(self, self.btnDrawTen, function()
		if self.activity:GetTimesLeft() < 10 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_draw_float"))

			return
		end

		self:TryDraw(10)

		return
	end, SFX_PANEL)
	onButton(self, self.rtDisplayPanel:Find("bg"), function()
		if self.inAnim then
			return
		end

		self:HideDrawAwardWindow()

		return
	end, SFX_CANCEL)

	return
end

function IslandShopDrawAwardPage:TryDraw(arg_16_1)
	local var_16_0 = self.activity:GetDrawTimes()

	if var_16_0 < arg_16_1 then
		local var_16_1 = Goods.Create({
			id = self.activity:GetDrawConfig("shop")
		}, Goods.TYPE_SHOPSTREET)
		local var_16_2 = var_16_1:GetConsume()

		self.rawIconDic.diamond = self.rawIconDic.diamond or GetSpriteFromAtlas(var_16_2:getIcon(), "")

		self.viewComponent:ShowMsgBox({
			type = IslandMsgBox.TYPE_COMMON,
			content = i18n("island_draw_tip3", string.format("<icon name=diamond w=0.76 h=0.76/>×%d", var_16_2.count * (arg_16_1 - var_16_0)), string.format("<icon name=ticket w=0.76 h=0.76/>×%d", arg_16_1 - var_16_0)),
			onYes = function()
				if var_16_2:getOwnedCount() < var_16_2.count * (arg_16_1 - var_16_0) then
					self:ShowChargeWindow()
				else
					self:emit(IslandMediator.SHOPPING, var_16_1.id, arg_16_1 - var_16_0)
				end

				return
			end,
			rawIconDic = self.rawIconDic
		})
	else
		self.viewComponent:ShowMsgBox({
			type = IslandMsgBox.TYPE_COMMON,
			content = i18n("island_draw_ready"),
			onYes = function()
				self:emit(IslandMediator.DRAW_AWARD_OPERATION, {
					op = "do_draw",
					activity_id = self.activity.id,
					count = arg_16_1
				})

				return
			end
		})
	end

	return
end

function IslandShopDrawAwardPage:ShowChargeWindow()
	self.viewComponent:ShowMsgBox({
		type = IslandMsgBox.TYPE_COMMON,
		content = i18n("island_draw_tip4"),
		onYes = function()
			self.viewComponent:emit(IslandMediator.CHANGE_SCENE, SCENE.CHARGE, {
				wrap = ChargeScene.TYPE_DIAMOND
			})

			return
		end
	})

	return
end

function IslandShopDrawAwardPage:UpdateActivity(arg_21_1)
	self.activity = arg_21_1

	local var_21_0 = self.activity:GetList()

	eachChild(self.rtMiddle, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0.name

		switch(arg_22_0.name, {
			S = function()
				setActive(arg_22_0:Find("mask"), var_21_0)
				setActive(arg_22_0:Find("btn_sequence"), var_21_0)
				setActive(arg_22_0:Find("state_sequence"), not var_21_0)

				if var_21_0 then
					local var_23_0 = self.activity:GetShowRankList(var_22_0)

					self.bannerRectDic[var_22_0]:Reset()

					for iter_23_0, iter_23_1 in ipairs(var_23_0) do
						GetImageSpriteFromAtlasAsync("island/IslandDrawAwardIcon/" .. pg.island_draw_reward[iter_23_1].show, "", self.bannerRectDic[var_22_0]:AddChild():Find("Image"), true)
					end

					self.bannerRectDic[var_22_0]:SetTriggerDotCall(function(arg_24_0)
						setActive(arg_22_0:Find("got"), self.activity:GetLastItemCount(var_23_0[arg_24_0]) == 0)

						return
					end)
					self.bannerRectDic[var_22_0]:SetUp()
				else
					setActive(arg_22_0:Find("got"), false)
				end

				local var_23_1 = self.activity:GetTimesLeft(var_22_0)

				setText(arg_22_0:Find("times_left/Text"), var_23_1 > 0 and i18n("island_draw_last") or i18n("island_draw_null"))
				setText(arg_22_0:Find("times_left/times"), var_23_1 > 0 and var_23_1 or "")

				return
			end,
			A = function()
				setActive(arg_22_0:Find("got"), false)

				local var_25_0 = self.activity:GetTimesLeft(var_22_0)

				setText(arg_22_0:Find("times_left/Text"), var_25_0 > 0 and i18n("island_draw_last") or i18n("island_draw_null"))
				setText(arg_22_0:Find("times_left/times"), var_25_0 > 0 and var_25_0 or "")

				local var_25_1 = self.activity:GetShowRankList(var_22_0)

				self.bannerRectDic[var_22_0]:Reset()

				for iter_25_0, iter_25_1 in ipairs(var_25_1) do
					GetImageSpriteFromAtlasAsync("island/IslandDrawAwardIcon/" .. pg.island_draw_reward[iter_25_1].show, "", self.bannerRectDic[var_22_0]:AddChild():Find("Image"), true)
				end

				self.bannerRectDic[var_22_0]:SetTriggerDotCall(function(arg_26_0)
					setActive(arg_22_0:Find("got"), self.activity:GetLastItemCount(var_25_1[arg_26_0]) == 0)

					return
				end)
				self.bannerRectDic[var_22_0]:SetUp(1)

				return
			end,
			select = function()
				setActive(arg_22_0:Find("got"), false)

				local var_27_0 = self.activity:GetDrawCount()
				local var_27_1 = self.activity:GetNextCountAwardTimes() or 0

				setText(arg_22_0:Find("count_word"), string.format("%d/%d", var_27_0, var_27_1))
				setActive(arg_22_0:Find("btn_select/on"), var_27_1 > 0 and var_27_1 <= var_27_0)

				local var_27_2 = self.activity:GetCountAwards()

				self.bannerRectDic[var_22_0]:Reset()

				for iter_27_0, iter_27_1 in ipairs(var_27_2) do
					local var_27_3, var_27_4 = unpack(iter_27_1)

					GetImageSpriteFromAtlasAsync("island/IslandDrawAwardIcon/" .. pg.island_draw_reward[var_27_3].show, "", self.bannerRectDic[var_22_0]:AddChild():Find("Image"), true)
				end

				self.bannerRectDic[var_22_0]:SetTriggerDotCall(function(arg_28_0)
					local var_28_0, var_28_1 = unpack(var_27_2[arg_28_0])

					setActive(arg_22_0:Find("got"), not var_28_1)

					return
				end)
				self.bannerRectDic[var_22_0]:SetUp(2)

				return
			end
		}, function()
			setActive(arg_22_0:Find("got"), false)

			local var_29_0 = self.activity:GetTimesLeft(var_22_0)

			setText(arg_22_0:Find("times_left/Text"), var_29_0 > 0 and i18n("island_draw_last") or i18n("island_draw_null"))
			setText(arg_22_0:Find("times_left/times"), var_29_0 > 0 and var_29_0 or "")

			local var_29_1 = self.activity:GetShowRankList(var_22_0)[1]

			if var_29_1 then
				GetImageSpriteFromAtlasAsync("island/IslandDrawAwardIcon/" .. pg.island_draw_reward[var_29_1].show, "", arg_22_0:Find("mask/Image"), true)
				setActive(arg_22_0:Find("got"), false)
			end

			return
		end)

		return
	end)

	local var_21_1 = pg.TimeMgr.GetInstance()

	setText(self.rtTitle:Find("Text_1"), string.format("%s\n-%s", unpack((underscore.map({
		self.activity:getStartTime(),
		self.activity.stopTime
	}, function(arg_30_0)
		return i18n("trade_card_tips4", unpack(string.split(var_21_1:STimeDescS(arg_30_0, "%Y/%m/%d"), "/")))
	end)))) .. i18n("island_draw_time_1"))

	local var_21_2 = self.activity:GetTimesLeft()

	setActive(self.btnDraw:Find("bg/on"), var_21_2 >= 1)
	setActive(self.btnDraw:Find("bg/off"), var_21_2 < 1)
	setActive(self.btnDrawTen:Find("bg/on"), var_21_2 >= 10)
	setActive(self.btnDrawTen:Find("bg/off"), var_21_2 < 10)

	local var_21_3 = Drop.New({
		type = DROP_TYPE_VITEM,
		id = self.activity:GetDrawConfig("cost_free")
	})

	self.rawIconDic = {
		ticket = GetSpriteFromAtlas(var_21_3:getIcon(), "")
	}

	GetImageSpriteFromAtlasAsync(var_21_3:getIcon(), "", self.btnDraw:Find("cost/icon"))
	GetImageSpriteFromAtlasAsync(var_21_3:getIcon(), "", self.btnDrawTen:Find("cost/icon"))

	return
end

function IslandShopDrawAwardPage:OpenChangeListWindow()
	self.viewComponent:ShowMsgBox({
		type = IslandMsgBox.TYPE_DRAW_AWARD_LIST,
		activity = self.activity
	})

	return
end

function IslandShopDrawAwardPage:OpenAllAwardWindow()
	self.viewComponent:ShowMsgBox({
		type = IslandMsgBox.TYPE_DRAW_AWARD_ALL,
		activity = self.activity
	})

	return
end

function IslandShopDrawAwardPage:OpenSelectAwardWindow()
	self.viewComponent:ShowMsgBox({
		type = IslandMsgBox.TYPE_DRAW_AWARD_COUNT,
		activity = self.activity
	})

	return
end

function IslandShopDrawAwardPage:DrawOperation(arg_34_1)
	switch(arg_34_1.op, {
		set_list = function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_draw_sort"))

			return
		end
	}, function()
		if #arg_34_1.awards > 0 then
			self:ShowDrawAwardWindow(arg_34_1.awards)
		end

		return
	end)

	return
end

function IslandShopDrawAwardPage:ShowDrawAwardWindow(arg_37_1)
	local var_37_0 = #arg_37_1 > 1 and "ten" or "one"
	local var_37_1

	eachChild(self.rtDisplayPanel:Find("window"), function(arg_38_0, arg_38_1)
		setActive(arg_38_0, arg_38_0.name == var_37_0)

		if arg_38_0.name == var_37_0 then
			var_37_1 = arg_38_0
		end

		eachChild(arg_38_0:Find("container"), function(arg_39_0, arg_39_1)
			local var_39_0 = arg_39_0:Find("card")

			setActive(var_39_0:Find("front/S/IslandDrawAwardPage_bomb01"), false)
			setActive(var_39_0:Find("bg/S/SCardLoopVX"), false)
			setActive(var_39_0:Find("front/A/IslandDrawAwardPage_bomb02"), false)
			setActive(var_39_0:Find("bg/A/ACardLoopVX"), false)

			return
		end)

		return
	end)

	local var_37_2 = {}

	UIItemList.StaticAlign(var_37_1:Find("container"), var_37_1:Find("container/tpl"), #arg_37_1, function(arg_40_0, arg_40_1, arg_40_2)
		arg_40_1 = var_37_0 == "ten" and arg_40_1 % 2 * 5 + 5 - math.floor(arg_40_1 / 2) or arg_40_1 + 1

		if arg_40_0 == UIItemList.EventUpdate then
			local var_40_0 = arg_40_2:Find("card")

			IslandShopDrawAwardPage.ShowDropInfo(Drop.New({
				type = pg.island_draw_reward[arg_37_1[arg_40_1]].drop_type,
				id = pg.island_draw_reward[arg_37_1[arg_40_1]].drop_id
			}), var_40_0:Find("mask/Image"))

			local var_40_1 = switch(pg.island_draw_reward[arg_37_1[arg_40_1]].rarity, {
				function()
					return "C"
				end,
				function()
					return "B"
				end,
				function()
					return "A"
				end,
				function()
					return "S"
				end
			})
			local var_40_2 = var_40_0:Find("mask/Image")

			if var_40_1 == "S" then
				setLocalScale(var_40_0:Find("mask/Image"), Vector3(1.2, 1.2, 1))
				setLocalPosition(var_40_0:Find("mask/Image"), {
					x = -17.5,
					y = -20
				})
			else
				setLocalScale(var_40_0:Find("mask/Image"), Vector3(1.7, 1.7, 1))
				setLocalPosition(var_40_0:Find("mask/Image"), Vector3.zero)
			end

			eachChild(var_40_0:Find("bg"), function(arg_45_0, arg_45_1)
				setActive(arg_45_0, arg_45_0.name == var_40_1)

				return
			end)
			eachChild(var_40_0:Find("word"), function(arg_46_0, arg_46_1)
				setActive(arg_46_0, arg_46_0.name == var_40_1)

				return
			end)
			eachChild(var_40_0:Find("front"), function(arg_47_0, arg_47_1)
				setActive(arg_47_0, arg_47_0.name == var_40_1)

				return
			end)
			var_40_0:Find("Book"):GetComponent(typeof(Book)):SetCurrentPage(2)
			setCanvasGroupAlpha(var_40_0, 0)
			setCanvasGroupAlpha(var_40_0:Find("Book"), 1)

			var_37_2[arg_40_1] = arg_40_2
		end

		return
	end)
	setCanvasGroupAlpha(self.rtDisplayPanel:Find("page"), 0)

	local var_37_3 = {}

	table.insert(var_37_3, function(arg_48_0)
		self.inAnim = true

		pg.UIMgr.GetInstance():BlurPanel(self.rtDisplayPanel, {
			staticBlur = true
		})
		setActive(self.rtDisplayPanel, true)
		self.rtDisplayPanel:GetComponent(typeof(DftAniEvent)):SetTriggerEvent(arg_48_0)

		return
	end)
	table.insert(var_37_3, function(arg_49_0)
		local var_49_0 = {}

		for iter_49_0, iter_49_1 in ipairs(var_37_2) do
			local var_49_1 = iter_49_1:Find("card")

			table.insert(var_49_0, function(arg_50_0)
				local var_50_0 = {}
				local var_50_1 = (iter_49_0 - 1) % 5 * 2 + (iter_49_0 > 5 and 1 or 0)

				if var_37_0 == "ten" and (iter_49_0 - 1) % 5 * 2 + (iter_49_0 > 5 and 1 or 0) > 0 then
					table.insert(var_50_0, function(arg_51_0)
						LeanTween.delayedCall(iter_49_1.gameObject, 0.03 * var_50_1, System.Action(arg_51_0))

						return
					end)
				end

				table.insert(var_50_0, function(arg_52_0)
					var_49_1:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_53_0)
						arg_52_0()

						return
					end)
					switch(var_37_0, {
						one = function()
							quickPlayAnimation(var_49_1, "anim_IslandDrawAwardPage_onetpl_In")

							return
						end,
						ten = function()
							quickPlayAnimation(var_49_1, var_50_1 % 2 == 0 and "anim_IslandDrawAwardPage_ten" or "anim_IslandDrawAwardPage_ten02")

							return
						end
					})

					return
				end)
				seriesAsync(var_50_0, arg_50_0)

				return
			end)
		end

		parallelAsync(var_49_0, function()
			LeanTween.delayedCall(0.6, System.Action(function()
				arg_49_0()

				return
			end))

			return
		end)

		return
	end)
	table.insert(var_37_3, function(arg_58_0)
		local var_58_0 = {}

		for iter_58_0, iter_58_1 in ipairs(var_37_2) do
			local var_58_1 = iter_58_1:Find("card")

			table.insert(var_58_0, function(arg_59_0)
				local var_59_0 = {}
				local var_59_1 = iter_58_0 - 1

				if iter_58_0 - 1 > 0 then
					table.insert(var_59_0, function(arg_60_0)
						LeanTween.delayedCall(iter_58_1.gameObject, 0.1 * var_59_1, System.Action(arg_60_0))

						return
					end)
				end

				table.insert(var_59_0, function(arg_61_0)
					local var_61_0 = var_58_1:Find("Book"):GetComponent(typeof(AutoFlip))

					var_61_0:StartControl()
					var_58_1:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
						var_61_0:StopControl()
						arg_61_0()

						return
					end)
					quickPlayAnimation(var_58_1, "anim_IslandDrawAwardPage_uncover")

					return
				end)
				seriesAsync(var_59_0, arg_59_0)

				return
			end)
		end

		quickPlayAnimation(self.rtDisplayPanel:Find("page"), "anim_IslandDrawAwardPage_page_in")
		parallelAsync(var_58_0, arg_58_0)

		return
	end)
	table.insert(var_37_3, function(arg_63_0)
		LeanTween.delayedCall(0.5, System.Action(function()
			arg_63_0()

			return
		end))

		return
	end)
	seriesAsync(var_37_3, function()
		if self._state == IslandShopDrawAwardPage.STATES.DESTROY then
			return
		end

		quickPlayAnimation(self.rtDisplayPanel:Find("page"), "anim_IslandDrawAwardPage_page_out")

		self.inAnim = false

		return
	end)

	return
end

function IslandShopDrawAwardPage:HideDrawAwardWindow()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.rtDisplayPanel, self._tf)
	setActive(self.rtDisplayPanel, false)
	eachChild(self.rtDisplayPanel:Find("window"), function(arg_67_0, arg_67_1)
		eachChild(arg_67_0:Find("container"), function(arg_68_0, arg_68_1)
			LeanTween.cancel(arg_68_0.gameObject)

			return
		end)

		return
	end)

	return
end

function IslandShopDrawAwardPage:Hide()
	if isActive(self.rtDisplayPanel) then
		self:HideDrawAwardWindow()
	end

	IslandShopDrawAwardPage.super.Hide(self)

	return
end

function IslandShopDrawAwardPage:OnDestroy()
	self:Hide()

	for iter_70_0, iter_70_1 in pairs(self.bannerRectDic) do
		iter_70_1:Dispose()
	end

	self.bannerRectDic = nil

	return
end

function IslandShopDrawAwardPage:ShowDropInfo(arg_71_1)
	switch(self.type, {
		[DROP_TYPE_ISLAND_INVITATION] = function()
			GetImageSpriteFromAtlasAsync("island/IslandCharIcon/" .. self:getConfig("chara_pic"), "", arg_71_1, true)

			return
		end,
		[DROP_TYPE_ISLAND_FURNITURE] = function()
			GetImageSpriteFromAtlasAsync("Island/IslandFurnitureIcon/" .. self:getConfig("icon"), "", arg_71_1, true)

			return
		end,
		[DROP_TYPE_ISLAND_DRESS] = function()
			GetImageSpriteFromAtlasAsync("island/IslandDressIcon/" .. self:getConfig("icon"), "", arg_71_1, true)

			return
		end,
		[DROP_TYPE_ISLAND_SKIN] = function()
			GetImageSpriteFromAtlasAsync("island/IslandDressIcon/" .. self:getConfig("icon"), "", arg_71_1, true)

			return
		end,
		[DROP_TYPE_ISLAND_ACTION] = function()
			GetImageSpriteFromAtlasAsync("Island/IslandActionIcon/" .. self:getConfig("resource"), "", arg_71_1, true)

			return
		end
	})

	return
end

return IslandShopDrawAwardPage
