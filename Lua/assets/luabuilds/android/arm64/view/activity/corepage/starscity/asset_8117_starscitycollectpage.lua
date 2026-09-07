local StarsCityCollectPage = class("StarsCityCollectPage", import("view.activity.CorePage.EscapeManor.EscapeManorCollectPage"))

function StarsCityCollectPage:OnInit()
	StarsCityCollectPage.super.OnInit(self)

	self.msgBox = StarsCityCollectMsgBox.New(self._tf, self.event)

	return
end

function StarsCityCollectPage:AddSpecialBtnListener()
	local var_2_0 = self.activity:getConfig("config_client")

	self.furnitureThemeBtn = self.btnList:Find("furniture_theme")

	if self.furnitureThemeBtn and var_2_0.furniture_theme_link then
		onButton(self, self.furnitureThemeBtn, function()
			self:DoSkip(var_2_0.furniture_theme_link[1], var_2_0.furniture_theme_link[2])

			return
		end, SFX_PANEL)
	end

	self.medalBtn = self.btnList:Find("medal")

	if self.medalBtn and var_2_0.medal_link then
		onButton(self, self.medalBtn, function()
			self:DoSkip(var_2_0.medal_link[1], var_2_0.medal_link[2])

			return
		end, SFX_PANEL)
	end

	self.equipSkinBoxBtn = self.btnList:Find("equip_skin_box")

	if self.equipSkinBoxBtn and var_2_0.equipskin_box_link then
		local var_2_1 = Drop.New({
			type = var_2_0.equipskin_box_link.drop_type,
			id = var_2_0.equipskin_box_link.drop_id
		}):getOwnedCount()

		onButton(self, self.equipSkinBoxBtn, function()
			self.msgBox:ExecuteAction("Show", {
				drop_type = var_2_0.equipskin_box_link.drop_type,
				drop_id = var_2_0.equipskin_box_link.drop_id,
				count = var_2_1,
				skipable_list = var_2_0.equipskin_box_link.list
			})

			return
		end, SFX_PANEL)
	end

	return
end

return StarsCityCollectPage
