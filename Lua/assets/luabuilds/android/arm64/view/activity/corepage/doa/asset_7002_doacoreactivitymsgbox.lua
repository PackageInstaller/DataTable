local DOACoreActivityMsgBox = class("DOACoreActivityMsgBox", import("view.base.BaseSubView"))

DOACoreActivityMsgBox.SKIP_TYPE_SCENE = 2
DOACoreActivityMsgBox.SKIP_TYPE_ACTIVITY = 3

function DOACoreActivityMsgBox:Ctor(arg_1_1, arg_1_2, arg_1_3)
	DOACoreActivityMsgBox.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3)

	return
end

function DOACoreActivityMsgBox:getUIName()
	return "DOACoreActivityMsgBox"
end

function DOACoreActivityMsgBox:OnLoaded()
	self.bg = self._tf:Find("bg")
	self.btnClose = self._tf:Find("window/top/btnBack")

	onButton(self, self.btnClose, function()
		self:Hide()

		return
	end, SOUND_BACK)
	onButton(self, self.bg, function()
		self:Hide()

		return
	end, SOUND_BACK)

	return
end

function DOACoreActivityMsgBox:OnInit()
	self.window = self._tf:Find("window")
	self.page = self._tf:Find("window/page")
	self.title = self.page:Find("name_mask/name")
	self.owner = self.page:Find("owner")

	setText(self.owner:Find("title"), i18n("collect_page_got"))

	self.ownerLimit = self.page:Find("owner_limit")

	setText(self.ownerLimit:Find("title"), i18n("collect_page_got"))

	self.iconTF = self.page:Find("left/IconTpl")
	self.ownTF = self.page:Find("left/own")
	self.detailTF = self.page:Find("left/detail")
	self.desc = self.page:Find("content/desc")
	self.list = self.page:Find("content/skipable_list")
	self.tpl = self.list:Find("tpl")

	return
end

function DOACoreActivityMsgBox:Show(arg_7_1)
	DOACoreActivityMsgBox.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf, {
		staticBlur = true
	})

	local var_7_0 = Drop.New({
		type = arg_7_1.drop_type,
		id = arg_7_1.drop_id
	})

	updateDrop(self.iconTF, var_7_0)
	UpdateOwnDisplay(self.ownTF, var_7_0)
	changeToScrollText(self.title, var_7_0.cfg.name)
	setText(self.desc, var_7_0.desc)
	setActive(self.owner, false)
	setActive(self.ownerLimit, true)
	setText(self.ownerLimit:Find("Text"), arg_7_1.count .. "/" .. (arg_7_1.count_limit or 0))

	if #arg_7_1.skipable_list > 1 then
		self:setWindowSize(#arg_7_1.skipable_list - 1)
	end

	UIItemList.StaticAlign(self.list, self.tpl, #arg_7_1.skipable_list, function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			local var_8_0 = arg_7_1.skipable_list[arg_8_1 + 1][1]
			local var_8_1 = arg_7_1.skipable_list[arg_8_1 + 1][2]

			changeToScrollText(arg_8_2:Find("mask/title"), arg_7_1.skipable_list[arg_8_1 + 1][3])
			onButton(self, arg_8_2:Find("skip_btn"), function()
				if var_8_0 == DOACoreActivityMsgBox.SKIP_TYPE_SCENE then
					pg.m02:sendNotification(GAME.GO_SCENE, var_8_1[1], var_8_1[2] or {})
				elseif var_8_0 == DOACoreActivityMsgBox.SKIP_TYPE_ACTIVITY then
					pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
						id = var_8_1
					})
				end

				self:Hide()

				return
			end, SFX_PANEL)
			Canvas.ForceUpdateCanvases()
		end

		return
	end)

	return
end

function DOACoreActivityMsgBox:setWindowSize(arg_10_1)
	setSizeDelta(self.window, Vector2(716, 7 + 50 * arg_10_1))

	return
end

function DOACoreActivityMsgBox:Hide()
	if self:isShowing() then
		DOACoreActivityMsgBox.super.Hide(self)
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	end

	return
end

return DOACoreActivityMsgBox
