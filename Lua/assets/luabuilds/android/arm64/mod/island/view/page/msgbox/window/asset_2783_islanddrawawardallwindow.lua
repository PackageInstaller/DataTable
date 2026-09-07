local IslandDrawAwardAllWindow = class("IslandDrawAwardAllWindow", import("Mod.Island.View.page.msgbox.window.IslandBaseMsgboxWindow"))

function IslandDrawAwardAllWindow:getUIName()
	return "IslandDrawAwardAllMsgBox"
end

function IslandDrawAwardAllWindow:OnInit()
	setText(self.rtTitle, i18n("island_draw_reward"))
	onButton(self, self.btnClose, function()
		self:Hide()

		return
	end, SFX_CANCEL)

	return
end

function IslandDrawAwardAllWindow:OnShow()
	IslandDrawAwardAllWindow.super.OnShow(self)
	self:UpdateActivity(self.settings.activity)

	return
end

function IslandDrawAwardAllWindow:UpdateActivity(arg_5_1)
	self.activity = arg_5_1

	eachChild(self.rtRarities, function(arg_6_0, arg_6_1)
		local var_6_0 = self.activity:GetRankList(arg_6_0.name)

		setText(arg_6_0:Find("title/Text"), i18n("island_draw_" .. arg_6_0.name))
		UIItemList.StaticAlign(arg_6_0:Find("container"), arg_6_0:Find("container/tpl"), #var_6_0, function(arg_7_0, arg_7_1, arg_7_2)
			arg_7_1 = arg_7_1 + 1

			if arg_7_0 == UIItemList.EventUpdate then
				local var_7_0, var_7_1 = unpack(var_6_0[arg_7_1])
				local var_7_2 = Drop.New({
					type = pg.island_draw_reward[var_7_0].drop_type,
					id = pg.island_draw_reward[var_7_0].drop_id
				})

				IslandShopDrawAwardPage.ShowDropInfo(var_7_2, arg_7_2:Find("mask/Image"))
				setScrollText(arg_7_2:Find("name/Text"), var_7_2:getName())
				setText(arg_7_2:Find("got/got/Text"), i18n("island_draw_get"))
				setActive(arg_7_2:Find("got"), not var_7_1)
			end

			return
		end)

		return
	end)

	return
end

return IslandDrawAwardAllWindow
