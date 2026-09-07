local CrusingWindowLayer2 = class("CrusingWindowLayer2", import("view.activity.CrusingWindowLayer"))

function CrusingWindowLayer2:getUIName()
	return "CrusingWindowUI2"
end

function CrusingWindowLayer2:init()
	setImageSprite(self._tf:Find("panel"), self.windowSprite, true)

	self.rtBg = self._tf:Find("bg")
	self.btnGo = self._tf:Find("panel/btn_go")

	setText(self.btnGo:Find("Text"), i18n("cruise_tip_skin"))

	self.itemContent = self._tf:Find("panel/content")

	local var_2_0 = pg.battlepass_event_pt[getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING).id].equip_skin or {}

	self.itemList = UIItemList.New(self.itemContent, self.itemContent:GetChild(0))

	self.itemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1

		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = Drop.Create(var_2_0[arg_3_1])

			updateDrop(arg_3_2:Find("IconTpl"), var_3_0)
			onButton(self, arg_3_2, function()
				self:emit(CrusingWindowLayer2.ON_DROP, var_3_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.itemList:align(#var_2_0)

	return
end

function CrusingWindowLayer2:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	onButton(self, self.rtBg, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnGo, function()
		self:emit(CrusingWindowMediator.GO_CRUSING)

		return
	end, SFX_CONFIRM)

	return
end

return CrusingWindowLayer2
