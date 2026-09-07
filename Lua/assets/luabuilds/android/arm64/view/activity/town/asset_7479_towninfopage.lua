local TownInfoPage = class("TownInfoPage", import("view.base.BaseSubView"))

TownInfoPage.SLOT_CNT = 9

function TownInfoPage:getUIName()
	return "TownInfoPage"
end

function TownInfoPage:OnLoaded()
	self.togglesTF = self._tf:Find("frame/toggles")

	eachChild(self.togglesTF, function(arg_3_0)
		onToggle(self, arg_3_0, function(arg_4_0)
			setImageColor(arg_3_0:Find("name"), Color.NewHex(arg_4_0 and "F5ECDD" or "796464"))

			return
		end, SFX_PANEL)

		return
	end)

	self.townTip = self.togglesTF:Find("town/tip")
	self.placeTip = self.togglesTF:Find("place/tip")
	self.shipTip = self.togglesTF:Find("ship/tip")
	self.townPanel = self._tf:Find("frame/panels/town_panel")
	self.townLevelNow = self.townPanel:Find("lvmask/level_now")
	self.townLevelNext = self.townPanel:Find("lvmask/level_next")
	self.curExp = self.townPanel:Find("infos/exp/value/cur")
	self.needExp = self.townPanel:Find("infos/exp/value/need")
	self.goldOutput = self.townPanel:Find("infos/output/value")
	self.goldLimit = self.townPanel:Find("infos/limit/value")
	self.townUpgradeTF = self.townPanel:Find("upgrade_status")
	self.shipPanel = self._tf:Find("frame/panels/ship_panel")
	self.shipUIList = UIItemList.New(self.shipPanel:Find("content"), self.shipPanel:Find("content/tpl"))

	self.shipUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			self:UpdateShip(arg_5_1, arg_5_2)
		end

		return
	end)

	self.placePanel = self._tf:Find("frame/panels/place_panel")

	setText(self.placePanel:Find("view/content/tpl/next/title"), i18n("town_place_next_title"))

	self.placeUIList = UIItemList.New(self.placePanel:Find("view/content"), self.placePanel:Find("view/content/tpl"))

	self.placeUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			self:UpdatePlace(arg_6_1, arg_6_2)
		end

		return
	end)

	self.specialWorkGroup = pg.gameset.activity_town_special_work.key_value

	return
end

function TownInfoPage:SetActivity(arg_7_1)
	self.activity = arg_7_1 or getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN)

	assert(self.activity and not self.activity:isEnd(), "not exist town act, type: " .. ActivityConst.ACTIVITY_TYPE_TOWN)

	return
end

function TownInfoPage:OnInit()
	self:SetActivity()

	self.slotUnlockLv = {}

	;(function()
		for iter_9_0, iter_9_1 in ipairs(pg.activity_town_level.all) do
			for iter_9_2 = 1, pg.activity_town_level[iter_9_1].unlock_chara do
				self.slotUnlockLv[iter_9_2] = self.slotUnlockLv[iter_9_2] or iter_9_1

				if self.slotUnlockLv[TownInfoPage.SLOT_CNT] then
					return
				end
			end
		end

		return
	end)()
	triggerToggle(self.togglesTF:Find("town"), true)

	return
end

function TownInfoPage:Flush()
	self:FlushTownPanel()
	self:FlushShipPanel()
	self:FlushPlacePanel()
	self:Show()

	return
end

function TownInfoPage:OnExpUpdate()
	local var_11_0 = self.activity:GetExp()
	local var_11_1 = pg.activity_town_level[self.townLv].exp

	setText(self.curExp, var_11_0)
	setTextColor(self.curExp, Color.NewHex(not isMaxLv and var_11_0 < var_11_1 and "CC3A33" or "63423E"))
	setText(self.needExp, "/" .. (isMaxLv and 0 or var_11_1))

	return
end

function TownInfoPage:OnTownUpgrade(arg_12_1)
	local var_12_0 = self.townPanel:GetComponent(typeof(DftAniEvent))

	var_12_0:SetEndEvent(function()
		if arg_12_1 then
			arg_12_1()
		end

		self.inTownAnim = false

		var_12_0:SetEndEvent(nil)

		return
	end)
	var_12_0:SetTriggerEvent(function()
		self:Flush()
		var_12_0:SetTriggerEvent(nil)

		return
	end)
	self.townPanel:GetComponent(typeof(Animation)):Play("anim_cowboy_info_town_lvup")

	self.inTownAnim = true

	self:managedTween(LeanTween.delayedCall, function()
		self:FlushTownWithoutLv()

		return
	end, 0.265, nil)

	return
end

function TownInfoPage:OnPlaceUpgrade(arg_16_1)
	self.townUpgradeCb = arg_16_1

	self:Flush()

	return
end

function TownInfoPage:UpdateTownStatus()
	local var_17_0, var_17_1, var_17_2 = self.activity:CanUpgradeTown()

	setActive(self.townTip, var_17_0)
	eachChild(self.townUpgradeTF, function(arg_18_0)
		setActive(arg_18_0, arg_18_0.name == var_17_1)

		return
	end)
	onButton(self, self.townUpgradeTF:Find("normal"), function()
		if not var_17_0 or self.inTownAnim then
			return
		end

		self:emit(TownMediator.UPGRADE_TOWN)

		return
	end, SFX_PANEL)

	if var_17_1 == "no_story" then
		setText(self.townUpgradeTF:Find("no_story/content/value/cur"), var_17_2[1])
		setText(self.townUpgradeTF:Find("no_story/content/value/need"), "/" .. var_17_2[2])
	elseif var_17_1 == "no_exp_or_gold" then
		setTextColor(self.townUpgradeTF:Find("no_exp_or_gold/cost/Text"), Color.NewHex(var_17_2 == "no_gold" and "FF756E" or "FFEBC9"))
	end

	return
end

function TownInfoPage:FlushTownWithoutLv()
	self:OnExpUpdate()
	setText(self.goldOutput, string.format("+%s/H", TownActivity.GoldToShow((self.activity:GetGoldOutput()))))
	setText(self.goldLimit, TownActivity.GoldToShow((self.activity:GetLimitGold())))

	local var_20_0 = TownActivity.GoldToShow(pg.activity_town_level[self.townLv].gold)

	setText(self.townUpgradeTF:Find("normal/cost/Text"), var_20_0)
	setText(self.townUpgradeTF:Find("no_exp_or_gold/cost/Text"), var_20_0)
	self:UpdateTownStatus()

	return
end

function TownInfoPage:FlushTownPanel()
	self.townLv = self.activity:GetTownLevel()

	local var_21_0 = self.activity:IsMaxTownLevel()

	setText(self.townLevelNow, "LV." .. (var_21_0 and "MAX" or self.townLv))
	setText(self.townLevelNext, "LV." .. (var_21_0 and "MAX" or self.townLv + 1))
	self:FlushTownWithoutLv()

	return
end

function TownInfoPage:FlushShipPanel()
	self.shipIds = self.activity:GetShipIds()
	self.unlockCnt = self.activity:GetUnlockSlotCnt()

	self.shipUIList:align(TownInfoPage.SLOT_CNT)
	setActive(self.shipTip, self.activity:HasEmptySlot())

	return
end

function TownInfoPage:UpdateShip(arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1 + 1
	local var_23_1 = arg_23_1 + 1 > self.unlockCnt

	setActive(arg_23_2:Find("lock"), arg_23_1 + 1 > self.unlockCnt)

	if var_23_1 then
		setText(arg_23_2:Find("lock/Text"), i18n("town_lock_level", "LV" .. self.slotUnlockLv[arg_23_1 + 1]))
	end

	local var_23_2 = self.shipIds[arg_23_1 + 1]
	local var_23_3 = not self.shipIds[arg_23_1 + 1] or var_23_2 == 0

	setActive(arg_23_2:Find("empty"), not self.shipIds[arg_23_1 + 1] or var_23_2 == 0)
	setActive(arg_23_2:Find("mask"), not var_23_3)

	local var_23_4

	if not var_23_3 then
		local var_23_5 = getProxy(BayProxy):RawGetShipById(var_23_2)

		if var_23_5 then
			setImageSprite(arg_23_2:Find("mask/icon"), LoadSprite("qicon/" .. var_23_5:getPainting()), true)
		else
			setActive(arg_23_2:Find("empty"), true)
			setActive(arg_23_2:Find("mask"), false)
		end
	end

	onButton(self, arg_23_2, function()
		if var_23_1 then
			return
		end

		self:emit(TownMediator.OPEN_CHUANWU, var_23_0, var_23_4)

		return
	end, SFX_PANEL)

	return
end

function TownInfoPage:FlushPlacePanel()
	self.placeList = self.activity:GetPlaceList()

	table.sort(self.placeList, CompareFuncs({
		function(arg_26_0)
			return arg_26_0:GetNextId() and 0 or 1
		end,
		function(arg_27_0)
			return arg_27_0.id
		end
	}))
	self.placeUIList:align(#self.placeList)

	return
end

function TownInfoPage:UpdatePlaceStatus(arg_28_1, arg_28_2)
	local var_28_0 = arg_28_2:Find("upgrade_status")
	local var_28_1 = TownActivity.GoldToShow(arg_28_1:GetCostGold())

	setText(var_28_0:Find("normal/cost/Text"), var_28_1)
	setText(var_28_0:Find("no_gold/cost/Text"), var_28_1)

	local var_28_2, var_28_3 = self.activity:CanUpgradePlace(arg_28_1.id)

	if var_28_2 then
		self.isShowPlaceTip = true
	end

	eachChild(var_28_0, function(arg_29_0)
		setActive(arg_29_0, arg_29_0.name == var_28_3)

		return
	end)
	onButton(self, var_28_0:Find("normal"), function()
		if not var_28_2 or self.inPlaceAnim then
			return
		end

		self.upgradePlaceName = arg_28_2.name

		self:emit(TownMediator.UPGRADE_WORKPLACE, arg_28_1.id)

		return
	end, SFX_PANEL)

	if var_28_3 == "no_level" then
		setText(var_28_0:Find("no_level/Text"), i18n("town_lock_level", "LV" .. arg_28_1:GetNeedTownLv()))
	end

	return
end

function TownInfoPage:UpdatePlace(arg_31_1, arg_31_2)
	local var_31_0 = self.placeList[arg_31_1 + 1]

	arg_31_2.name = arg_31_1 + 1

	setImageSprite(arg_31_2:Find("info/icon"), GetSpriteFromAtlas("ui/townui_atlas", var_31_0:GetIcon()), true)
	setText(arg_31_2:Find("info/name"), var_31_0:GetName())
	setText(arg_31_2:Find("info/gold/Text"), var_31_0:GetEffectStr())
	seriesAsync({
		function(arg_32_0)
			if self.upgradePlaceName and arg_31_2.name == self.upgradePlaceName then
				local var_32_0 = arg_31_2:GetComponent(typeof(DftAniEvent))

				var_32_0:SetEndEvent(function()
					if self.townUpgradeCb then
						self.townUpgradeCb()

						self.townUpgradeCb = nil
					end

					self.inPlaceAnim = false

					var_32_0:SetEndEvent(nil)

					return
				end)
				arg_31_2:GetComponent(typeof(Animation)):Play("anim_cowboy_info_place_lvup")

				self.inPlaceAnim = true

				self:managedTween(LeanTween.delayedCall, function()
					arg_32_0()

					return
				end, 0.2, nil)

				self.upgradePlaceName = nil
			else
				arg_32_0()
			end

			return
		end,
		function(arg_35_0)
			local var_35_0 = var_31_0:GetNextId()

			setActive(arg_31_2:Find("next"), not not var_35_0)

			if not not var_35_0 then
				setText(arg_31_2:Find("next/infos/exp/value"), "+" .. var_31_0:GetAddExp())
				setText(arg_31_2:Find("next/infos/gold/value"), TownWorkplace.New(var_35_0):GetEffectStr())
			end

			return
		end
	}, function()
		return
	end)
	setActive(arg_31_2:Find("info/gold"), var_31_0:GetGroup() ~= self.specialWorkGroup)
	setActive(arg_31_2:Find("next/infos/gold"), var_31_0:GetGroup() ~= self.specialWorkGroup)
	self:UpdatePlaceStatus(var_31_0, arg_31_2)

	return
end

function TownInfoPage:OnUpdateTime()
	self:UpdateTownStatus()

	self.isShowPlaceTip = false

	for iter_37_0, iter_37_1 in ipairs(self.placeList) do
		self:UpdatePlaceStatus(iter_37_1, self.placeUIList.container:Find(iter_37_0))
	end

	setActive(self.placeTip, self.isShowPlaceTip)

	return
end

function TownInfoPage:OnDestroy()
	return
end

return TownInfoPage
