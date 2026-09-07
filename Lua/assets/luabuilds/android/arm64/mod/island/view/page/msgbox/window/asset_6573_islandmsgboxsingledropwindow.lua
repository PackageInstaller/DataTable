local IslandMsgBoxSingleDropWindow = class("IslandMsgBoxSingleDropWindow", import(".IslandCommonMsgboxWindow"))

function IslandMsgBoxSingleDropWindow:getUIName()
	return "IslandCommonMsgBoxWithSingleItem"
end

function IslandMsgBoxSingleDropWindow:OnLoaded()
	IslandMsgBoxSingleDropWindow.super.OnLoaded(self)

	self.itemTr = self._tf:Find("IslandItemTpl")
	self.nameTxt = self._tf:Find("name"):GetComponent(typeof(Text))
	self.ownTxt = self._tf:Find("own"):GetComponent(typeof(Text))
	self.uiItemList = UIItemList.New(self._tf:Find("way/Viewport/list"), self._tf:Find("way/Viewport/list/tpl"))
	self.contentTF = self._tf:Find("way/Viewport/list")

	setText(self._tf:Find("label/Text"), i18n("island_get_way"))

	return
end

function IslandMsgBoxSingleDropWindow:OnShow()
	IslandMsgBoxSingleDropWindow.super.OnShow(self)

	local var_3_0 = IslandDropDescribeInfo.New(self.settings.dropData)

	self:FlushMain(var_3_0)
	self:FlushAcquiringWay(var_3_0)

	return
end

function IslandMsgBoxSingleDropWindow:FlushMain(arg_4_1)
	self.nameTxt.text = arg_4_1:GetName()
	self.contentTxt.text = arg_4_1:GetDes()
	self.ownTxt.text = i18n("island_own_cnt") .. setColorStr(arg_4_1:GetOwnCount(), "#39beff")

	updateCustomDrop(self.itemTr, arg_4_1:GetDrop(), {
		style = "island"
	})

	return
end

function IslandMsgBoxSingleDropWindow:FlushAcquiringWay(arg_5_1)
	local var_5_0

	if arg_5_1:IsTecUnlocked() then
		var_5_0 = arg_5_1:GetAcquiringWay()
	else
		var_5_0 = {}

		local var_5_1 = {}

		table.insert(var_5_1, arg_5_1:GetTecDes())
		table.insert(var_5_0, var_5_1)
	end

	local var_5_2 = #var_5_0 > 0

	setActive(self._tf:Find("line"), #var_5_0 > 0)
	setActive(self._tf:Find("label"), var_5_2)
	setActive(self._tf:Find("way"), var_5_2)
	self.uiItemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			local var_6_0 = var_5_0[arg_6_1 + 1]

			setText(arg_6_2:Find("Text"), var_5_0[arg_6_1 + 1][1])
			setText(arg_6_2:Find("go/Text"), i18n("island_word_go"))
			onButton(self, arg_6_2:Find("go"), function()
				local var_7_0 = Clone(var_6_0[2])

				table.remove(var_7_0, 1)
				self:GetMsgBoxMgr():emit(IslandMediator.OPEN_PAGE, var_7_0[1], var_7_0)
				self:Hide()

				return
			end, SFX_PANEL)
			setActive(arg_6_2:Find("go"), var_5_0[arg_6_1 + 1][2] and #var_5_0[arg_6_1 + 1][2] > 0)
		end

		return
	end)
	self.uiItemList:align(#var_5_0)
	setAnchoredPosition(self.contentTF, {
		x = 0,
		y = 0
	})

	return
end

function IslandMsgBoxSingleDropWindow:FlushBtn(arg_8_1)
	setActive(self.cancelBtn, false)

	return
end

return IslandMsgBoxSingleDropWindow
