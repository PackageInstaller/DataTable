local MallUpgradeBox = class("MallUpgradeBox", import("view.base.BaseSubView"))

function MallUpgradeBox:getUIName()
	return "MallUpgradeBox"
end

function MallUpgradeBox:OnLoaded()
	setText(self.uiTitleText, i18n("mall_upgrade_title"))
	setText(self.uiSureText, i18n("text_confirm"))
	setText(self.uiLevelHeaderText, i18n("mall_level_header"))

	return
end

function MallUpgradeBox:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.uiSureBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.unlockUIList = UIItemList.New(self.uiContentTF, self.uiContentTF:Find("tpl"))

	self.unlockUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			setText(arg_6_2:Find("header"), i18n("word_unlock"))
			setText(arg_6_2:Find("Text"), self.unlockNameList[arg_6_1 + 1])
		end

		return
	end)

	self.lv2FloorIds = {}

	for iter_3_0, iter_3_1 in ipairs(pg.activity_mall_template.all) do
		self.lv2FloorIds[pg.activity_mall_template[iter_3_1].need_mall_level] = self.lv2FloorIds[pg.activity_mall_template[iter_3_1].need_mall_level] or {}

		table.insert(self.lv2FloorIds[pg.activity_mall_template[iter_3_1].need_mall_level], iter_3_1)
	end

	return
end

function MallUpgradeBox:Show(arg_7_1, arg_7_2, arg_7_3)
	MallUpgradeBox.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.onHide = arg_7_3

	setText(self.uiOldLevelText, arg_7_1)
	setText(self.uiNewLevelText, arg_7_2)

	self.unlockNameList = {}

	for iter_7_0 = arg_7_1 + 1, arg_7_2 do
		if self.lv2FloorIds[iter_7_0] then
			for iter_7_1, iter_7_2 in ipairs(self.lv2FloorIds[iter_7_0]) do
				table.insert(self.unlockNameList, pg.activity_mall_template[iter_7_2].name)
			end
		end
	end

	self.unlockUIList:align(#self.unlockNameList)

	return
end

function MallUpgradeBox:Hide()
	MallUpgradeBox.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	existCall(self.onHide)

	self.onHide = nil

	return
end

function MallUpgradeBox:OnDestroy()
	return
end

return MallUpgradeBox
