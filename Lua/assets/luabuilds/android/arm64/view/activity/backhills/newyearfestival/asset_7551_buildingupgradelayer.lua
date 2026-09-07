local BuildingUpgradeLayer = class("BuildingUpgradeLayer", import("view.base.BaseUI"))

function BuildingUpgradeLayer:getUIName()
	return "BuildingUpgradePanel"
end

function BuildingUpgradeLayer:init()
	self.btnUpgrade = self._tf:Find("window/frame/upgrade_btn")

	setText(self._tf:Find("window/frame/costback/label"), i18n("word_consume"))
	setText(self._tf:Find("window/frame/upgrade_btn/Image"), i18n("msgbox_text_upgrade"))

	self.loader = AutoLoader.New()

	return
end

function BuildingUpgradeLayer:UpdateActivity(arg_3_1)
	self.activity = arg_3_1

	return
end

function BuildingUpgradeLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	onButton(self, self._tf:Find("window/top/btnBack"), function()
		self:closeView()

		return
	end)
	onButton(self, self._tf:Find("mengban"), function()
		self:closeView()

		return
	end)
	self:Set(self.activity)

	return
end

function BuildingUpgradeLayer:Set(arg_7_1, arg_7_2)
	local var_7_9000

	arg_7_2 = arg_7_2 or self.contextData.buildingID

	local var_7_0 = pg.activity_event_building[arg_7_2]

	assert(pg.activity_event_building[arg_7_2], "Can't Find activity_event_building Config ID: " .. arg_7_2)

	self.contextData.buildingID = arg_7_2

	local var_7_1 = arg_7_1.data1KeyValueList[2][arg_7_2] or 1
	local var_7_2 = var_7_0.material[var_7_1]
	local var_7_3 = #var_7_0.buff <= var_7_1
	local var_7_4 = 0
	local var_7_5 = false

	if var_7_9000 > var_7_1 then
		var_7_4 = var_7_2[1][2]
		var_7_5 = var_7_3 or (arg_7_1.data1KeyValueList[1][var_7_2[1][2]] or 0) >= var_7_2[1][3]
	end

	setText(self._tf:Find("window/top/name"), var_7_0.name)
	setText(self._tf:Find("window/top/name/lv"), "Lv." .. var_7_1)
	setScrollText(self._tf:Find("window/frame/describe/text"), var_7_0.desc)
	setText(self._tf:Find("window/frame/content/title/lv/current"), "Lv." .. var_7_1)
	setActive(self._tf:Find("window/frame/content/title/lv/next"), not var_7_3)

	if not var_7_3 then
		setText(self._tf:Find("window/frame/content/title/lv/next"), "Lv." .. var_7_1 + 1)
	end

	assert(pg.benefit_buff_template[var_7_0.buff[var_7_1]], "Can't Find benefit_buff_template Config ID: " .. var_7_0.buff[var_7_1])
	setText(self._tf:Find("window/frame/content/preview/current"), pg.benefit_buff_template[var_7_0.buff[var_7_1]].desc)
	setActive(self._tf:Find("window/frame/content/preview/arrow"), not var_7_3)
	setActive(self._tf:Find("window/frame/content/preview/next"), not var_7_3)

	if not var_7_3 then
		assert(pg.benefit_buff_template[var_7_0.buff[var_7_1 + 1]], "Can't Find benefit_buff_template Config ID: " .. var_7_0.buff[var_7_1 + 1])
		setText(self._tf:Find("window/frame/content/preview/next"), pg.benefit_buff_template[var_7_0.buff[var_7_1 + 1]].desc)
		self.loader:GetSprite(Item.getConfigData(var_7_4).icon, "", self._tf:Find("window/frame/costback/icon"))
	end

	setText(self._tf:Find("window/frame/costback/cost"), (not var_7_3 or nil) and (var_7_0.material[var_7_1][1][3] or 0))
	onButton(self, self.btnUpgrade, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("building_upgrade_tip"),
			onYes = function()
				if var_7_3 then
					return
				elseif var_7_5 then
					self:emit(BuildingUpgradeMediator.ACTIVITY_OPERATION, {
						cmd = 1,
						activity_id = self.activity.id,
						arg1 = arg_7_2
					})
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("building_tip"))
				end

				return
			end
		})

		return
	end)
	setGray(self.btnUpgrade, var_7_3)
	setButtonEnabled(self.btnUpgrade, not var_7_3)

	return
end

function BuildingUpgradeLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return BuildingUpgradeLayer
