local SculptureAwardInfoPage = class("SculptureAwardInfoPage", import("view.base.BaseSubView"))

function SculptureAwardInfoPage:getUIName()
	return "SculptureAwardInfoUI"
end

function SculptureAwardInfoPage:OnLoaded()
	self.uilist = UIItemList.New(self._tf:Find("frame/scrollrect/content"), self._tf:Find("frame/scrollrect/content/tpl"))

	return
end

function SculptureAwardInfoPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function SculptureAwardInfoPage:Show(arg_5_1)
	SculptureAwardInfoPage.super.Show(self)

	self.activity = arg_5_1

	self:UpdateList()
	setText(self._tf:Find("frame/tip"), i18n("sculpture_close_tip"))

	return
end

function SculptureAwardInfoPage:UpdateList()
	local var_6_0 = self.activity:getConfig("config_data")

	self.uilist:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self:UpdateCard(var_6_0[arg_7_1 + 1], arg_7_2)
		end

		return
	end)
	self.uilist:align(#var_6_0)

	return
end

function SculptureAwardInfoPage:UpdateCard(arg_8_1, arg_8_2)
	local var_8_0 = self.activity:GetAwards(arg_8_1)
	local var_8_1 = arg_8_2:Find("icon/mask/image"):GetComponent(typeof(Image))

	LoadSpriteAtlasAsync("SculptureRole/" .. self.activity:GetResorceName(arg_8_1) .. "_normal", nil, function(arg_9_0)
		if self.exited then
			return
		end

		var_8_1.sprite = arg_9_0

		var_8_1:SetNativeSize()

		return
	end)
	setText(arg_8_2:Find("Text"), HXSet.hxLan(self.activity:GetAwardDesc(arg_8_1)))

	local var_8_2 = UIItemList.New(arg_8_2:Find("awards"), arg_8_2:Find("awards/tpl"))

	var_8_2:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = {
				type = var_8_0[arg_10_1 + 1][1],
				id = var_8_0[arg_10_1 + 1][2],
				count = var_8_0[arg_10_1 + 1][3]
			}

			updateDrop(arg_10_2, var_10_0)
			onButton(self, arg_10_2, function()
				self:emit(BaseUI.ON_DROP, var_10_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_8_2:align(#var_8_0)
	setActive(arg_8_2:Find("mask"), self.activity:GetSculptureState(arg_8_1) == SculptureActivity.STATE_FINSIH)

	return
end

function SculptureAwardInfoPage:OnDestroy()
	return
end

return SculptureAwardInfoPage
