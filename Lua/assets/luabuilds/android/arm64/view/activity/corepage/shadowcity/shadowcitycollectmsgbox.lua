local ShadowCityCollectMsgBox = class("ShadowCityCollectMsgBox", import("view.activity.CorePage.DOA.DOACoreActivityMsgBox"))

function ShadowCityCollectMsgBox:getUIName()
	return "ShadowCityCollectMsgBox"
end

function ShadowCityCollectMsgBox:OnInit()
	ShadowCityCollectMsgBox.super.OnInit(self)
	setText(self.window:Find("top/title"), i18n("island_get_way"))

	return
end

function ShadowCityCollectMsgBox:Show(arg_3_1)
	ShadowCityCollectMsgBox.super.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf, {
		staticBlur = true
	})

	local var_3_0 = Drop.New({
		type = arg_3_1.drop_type,
		id = arg_3_1.drop_id
	})

	updateDrop(self.iconTF, var_3_0)
	UpdateOwnDisplay(self.ownTF, var_3_0)
	changeToScrollText(self.title, var_3_0.cfg.name)
	setText(self.desc, var_3_0.desc)
	setActive(self.owner, false)
	setActive(self.ownerLimit, true)
	setText(self.ownerLimit:Find("Text"), arg_3_1.count .. "/" .. (arg_3_1.count_limit or 0))
	self:setWindowSize(#arg_3_1.skipable_list - 1)
	UIItemList.StaticAlign(self.list, self.tpl, #arg_3_1.skipable_list, function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = arg_3_1.skipable_list[arg_4_1 + 1][1]
			local var_4_1 = arg_3_1.skipable_list[arg_4_1 + 1][2]

			changeToScrollText(arg_4_2:Find("mask/title"), arg_3_1.skipable_list[arg_4_1 + 1][3])

			local var_4_2 = arg_4_2:Find("skip_btn")

			setText(var_4_2:Find("text"), i18n("task_go"))
			onButton(self, var_4_2, function()
				if var_4_0 == ShadowCityCollectMsgBox.SKIP_TYPE_SCENE then
					pg.m02:sendNotification(GAME.GO_SCENE, var_4_1[1], var_4_1[2] or {})
				elseif var_4_0 == ShadowCityCollectMsgBox.SKIP_TYPE_ACTIVITY then
					pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
						id = var_4_1
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

function ShadowCityCollectMsgBox:setWindowSize(arg_6_1)
	setSizeDelta(self.window:Find("bg"), Vector2(769, 440 + 50 * arg_6_1))

	return
end

return ShadowCityCollectMsgBox
