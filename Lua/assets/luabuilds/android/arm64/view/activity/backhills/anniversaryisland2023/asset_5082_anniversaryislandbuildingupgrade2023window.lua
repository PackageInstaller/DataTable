local AnniversaryIslandBuildingUpgrade2023Window = class("AnniversaryIslandBuildingUpgrade2023Window", import("view.base.BaseUI"))

function AnniversaryIslandBuildingUpgrade2023Window:getUIName()
	return "AnniversaryIslandBuildingUpgrade2023Window"
end

function AnniversaryIslandBuildingUpgrade2023Window:GetAtlasPath()
	return "ui/" .. self:getUIName() .. "_atlas"
end

function AnniversaryIslandBuildingUpgrade2023Window:init()
	self.window = self._tf:Find("Window")
	self.upgradeWindow = self.window:Find("Upgrade")
	self.displayWindow = self.window:Find("Display")

	setText(self.window:Find("Upgrade/MaterialsTitle"), i18n("workbench_need_materials"))
	setText(self.window:Find("Display/MaxTip"), i18n("workbench_tips6"))

	self.loader = AutoLoader.New()

	return
end

function AnniversaryIslandBuildingUpgrade2023Window:didEnter()
	local var_4_0 = self.contextData.buildingID

	onButton(self, self._tf:Find("BG"), function()
		self:onBackPressed()

		return
	end)
	onButton(self, self.upgradeWindow:Find("Cancel"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self.upgradeWindow:Find("Upgrade"), function()
		if self.isMaxLevel then
			return
		elseif self.isOverAvg then
			pg.TipsMgr.GetInstance():ShowTips(i18n("haidaojudian_upgrade_limit"))
		elseif self.isLackMat then
			pg.TipsMgr.GetInstance():ShowTips(i18n("haidaojudian_building_tip"))
		else
			self:emit(BuildingUpgradeMediator.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = self.activityId,
				arg1 = var_4_0
			})
		end

		return
	end)
	onButton(self, self.displayWindow:Find("Confirm"), function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	self:UpdateView()

	return
end

function AnniversaryIslandBuildingUpgrade2023Window:UpdateView()
	local var_9_0 = self.contextData.buildingID
	local var_9_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)

	self.activityId = var_9_1.id

	local var_9_2 = var_9_1:GetBuildingLevel(var_9_0)
	local var_9_3 = pg.activity_event_building[var_9_0]
	local var_9_4 = #pg.activity_event_building[var_9_0].buff

	self.isMaxLevel = #pg.activity_event_building[var_9_0].buff <= var_9_2
	self.isOverAvg = var_9_2 > var_9_1:GetTotalBuildingLevel()

	setActive(self.upgradeWindow, not self.isMaxLevel)
	setActive(self.displayWindow, self.isMaxLevel)

	local var_9_5

	if self.isMaxLevel then
		var_9_5 = self.displayWindow or self.upgradeWindow
	end

	self.loader:GetSpriteQuiet(self:GetAtlasPath(), AnniversaryIsland2023Scene.Buildings[var_9_0], var_9_5:Find("Title/BuildingName"), true)

	local var_9_6 = 0

	;(function()
		self.loader:GetSpriteQuiet(self:GetAtlasPath(), var_9_2, var_9_5:Find("Title/LevelBefore"), true)

		local var_10_0 = CommonBuff.New({
			id = var_9_3.buff[var_9_2]
		})
		local var_10_1 = string.split(var_10_0:getConfig("desc"), "/")

		assert(var_10_1)

		local var_10_2, var_10_3, var_10_4 = string.find(var_10_1[1], "([^%+]*)%+")
		local var_10_5, var_10_6, var_10_7 = string.find(var_10_1[2], "([^%+]*)%+")

		setText(var_9_5:Find("Progress1/1/Desc"), var_10_4)
		setText(var_9_5:Find("Progress1/1/Value"), (string.sub(var_10_1[1], var_10_3, #var_10_1[1])))
		setText(var_9_5:Find("Progress2/1/Desc"), var_10_7)
		setText(var_9_5:Find("Progress2/1/Value"), (string.sub(var_10_1[2], var_10_6, #var_10_1[2])))

		var_9_6 = tonumber(var_10_0:getConfig("benefit_effect"))

		return
	end)()
	;(function()
		if var_9_2 >= var_9_4 then
			return
		end

		local var_11_0 = var_9_2 + 1

		self.loader:GetSpriteQuiet(self:GetAtlasPath(), var_9_2 + 1, var_9_5:Find("Title/LevelAfter"), true)

		local var_11_1 = CommonBuff.New({
			id = var_9_3.buff[var_11_0]
		})
		local var_11_2 = string.split(var_11_1:getConfig("desc"), "/")

		assert(var_11_2)

		local var_11_3, var_11_4, var_11_5 = string.find(var_11_2[1], "([^%+]*)%+")
		local var_11_6, var_11_7, var_11_8 = string.find(var_11_2[2], "([^%+]*)%+")

		setText(var_9_5:Find("Progress1/2/Desc"), var_11_5)
		setText(var_9_5:Find("Progress1/2/Value"), (string.sub(var_11_2[1], var_11_4, #var_11_2[1])))
		setText(var_9_5:Find("Progress2/2/Desc"), var_11_8)
		setText(var_9_5:Find("Progress2/2/Value"), (string.sub(var_11_2[2], var_11_7, #var_11_2[2])))
		setActive(var_9_5:Find("Progress2/2/Up"), tonumber(var_11_1:getConfig("benefit_effect")) > var_9_6)

		return
	end)()
	;(function()
		if var_9_2 >= var_9_4 then
			return
		end

		local var_12_0 = var_9_3.material[var_9_2]
		local var_12_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)

		self.isLackMat = false

		UIItemList.StaticAlign(var_9_5:Find("Materials"), var_9_5:Find("Materials"):GetChild(0), #var_12_0, function(arg_13_0, arg_13_1, arg_13_2)
			if arg_13_0 ~= UIItemList.EventUpdate then
				return
			end

			local var_13_0 = var_12_0[arg_13_1 + 1]
			local var_13_1 = {
				type = var_12_0[arg_13_1 + 1][1],
				id = var_12_0[arg_13_1 + 1][2],
				count = var_12_0[arg_13_1 + 1][3]
			}

			self:UpdateActivityDrop(arg_13_2:Find("Icon"), var_13_1)
			onButton(self, arg_13_2:Find("Icon"), function()
				if var_13_1.type == DROP_TYPE_WORKBENCH_DROP then
					self:emit(WorkBenchItemDetailMediator.SHOW_DETAIL, WorkBenchItem.New({
						configId = var_13_1.id,
						count = var_13_1.count
					}))
				else
					self:emit(BaseUI.ON_DROP, var_13_1)
				end

				return
			end)

			local var_13_2 = var_12_1:getVitemNumber(var_13_0[2])
			local var_13_3 = var_13_2 < var_13_0[3]

			setText(arg_13_2:Find("Text"), setColorStr(var_13_2, var_13_2 < var_13_0[3] and "#bb6754" or "#6b5a48") .. "/" .. var_13_0[3])

			self.isLackMat = self.isLackMat or var_13_3

			return
		end)

		return
	end)()

	return
end

local var_0_1 = "ui/AtelierCommonUI_atlas"

function AnniversaryIslandBuildingUpgrade2023Window:UpdateActivityDrop(arg_15_1, arg_15_2, arg_15_3)
	updateDrop(arg_15_1, arg_15_2)
	SetCompomentEnabled(arg_15_1:Find("icon_bg"), typeof(Image), false)
	setActive(arg_15_1:Find("bg"), false)
	setActive(arg_15_1:Find("icon_bg/frame"), false)
	setActive(arg_15_1:Find("icon_bg/stars"), false)

	local var_15_0 = arg_15_2:getConfig("rarity")

	if arg_15_2.type == DROP_TYPE_EQUIP or arg_15_2.type == DROP_TYPE_EQUIPMENT_SKIN then
		var_15_0 = var_15_0 - 1
	end

	local var_15_1 = "icon_frame_" .. var_15_0

	if arg_15_3 then
		var_15_1 = var_15_1 .. "_small"
	end

	self.loader:GetSpriteQuiet(var_0_1, var_15_1, arg_15_1)

	return
end

function AnniversaryIslandBuildingUpgrade2023Window:willExit()
	self.loader:Clear()

	return
end

return AnniversaryIslandBuildingUpgrade2023Window
