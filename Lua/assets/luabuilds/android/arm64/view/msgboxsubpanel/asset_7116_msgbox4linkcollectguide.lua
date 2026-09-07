local Msgbox4LinkCollectGuide = class("Msgbox4LinkCollectGuide", import(".MsgboxSubPanel"))

Msgbox4LinkCollectGuide.SHOW_TYPE_NORMAL = 1
Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT = 2
Msgbox4LinkCollectGuide.SKIP_TYPE_SCENE = 2
Msgbox4LinkCollectGuide.SKIP_TYPE_ACTIVITY = 3

function Msgbox4LinkCollectGuide:getUIName()
	return "Msgbox4LinkCollectGuide"
end

function Msgbox4LinkCollectGuide:OnInit()
	self.title = self._tf:Find("name_mask/name")
	self.owner = self._tf:Find("owner")

	setText(self.owner:Find("title"), i18n("collect_page_got"))

	self.ownerLimit = self._tf:Find("owner_limit")

	setText(self.ownerLimit:Find("title"), i18n("collect_page_got"))

	self.iconTF = self._tf:Find("left/IconTpl")
	self.ownTF = self._tf:Find("left/own")
	self.detailTF = self._tf:Find("left/detail")
	self.desc = self._tf:Find("content/desc")
	self.list = self._tf:Find("content/skipable_list")
	self.tpl = self.list:Find("tpl")

	return
end

function Msgbox4LinkCollectGuide:OnRefresh(arg_3_1)
	self:SetWindowSize(Vector2(930, 540))
	setActive(self.viewParent._btnContainer, false)

	local var_3_0 = Drop.New({
		type = arg_3_1.drop_type,
		id = arg_3_1.drop_id
	})

	updateDrop(self.iconTF, var_3_0)
	UpdateOwnDisplay(self.ownTF, var_3_0)
	RegisterDetailButton(self.viewParent, self.detailTF, var_3_0)
	changeToScrollText(self.title, var_3_0.cfg.name)
	setText(self.desc, var_3_0.desc)

	if arg_3_1.show_type == Msgbox4LinkCollectGuide.SHOW_TYPE_NORMAL then
		setActive(self.owner, true)
		setActive(self.ownerLimit, false)
		setText(self.owner:Find("Text"), arg_3_1.count)
	elseif arg_3_1.show_type == Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT then
		setActive(self.owner, false)
		setActive(self.ownerLimit, true)
		setText(self.ownerLimit:Find("Text"), arg_3_1.count .. "/" .. (arg_3_1.count_limit or 0))
	end

	UIItemList.StaticAlign(self.list, self.tpl, #arg_3_1.skipable_list, function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = arg_3_1.skipable_list[arg_4_1 + 1][1]
			local var_4_1 = arg_3_1.skipable_list[arg_4_1 + 1][2]

			changeToScrollText(arg_4_2:Find("mask/title"), arg_3_1.skipable_list[arg_4_1 + 1][3])
			onButton(self, arg_4_2:Find("skip_btn"), function()
				if var_4_0 == Msgbox4LinkCollectGuide.SKIP_TYPE_SCENE then
					pg.m02:sendNotification(GAME.GO_SCENE, var_4_1[1], var_4_1[2] or {})
				elseif var_4_0 == Msgbox4LinkCollectGuide.SKIP_TYPE_ACTIVITY then
					pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
						id = var_4_1
					})
				end

				self.viewParent:hide()

				return
			end, SFX_PANEL)
			Canvas.ForceUpdateCanvases()
		end

		return
	end)

	return
end

return Msgbox4LinkCollectGuide
