local CrusingWindowLayer = class("CrusingWindowLayer", import("view.base.BaseUI"))

function CrusingWindowLayer:getUIName()
	return "CrusingWindowUI"
end

function CrusingWindowLayer:preload(arg_2_1)
	GetSpriteFromAtlasAsync("crusingwindow/map_20" .. pg.battlepass_event_pt[getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING).id].map_name, "", function(arg_3_0)
		self.windowSprite = arg_3_0

		arg_2_1()

		return
	end)

	return
end

function CrusingWindowLayer:init()
	setImageSprite(self._tf:Find("panel"), self.windowSprite, true)

	self.rtBg = self._tf:Find("bg")
	self.btnBack = self._tf:Find("panel/btn_back")
	self.btnGo = self._tf:Find("panel/btn_go")
	self.itemContent = self._tf:Find("panel/content")

	local var_4_0 = pg.battlepass_event_pt[getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING).id].equip_skin or {}

	self.itemList = UIItemList.New(self.itemContent, self.itemContent:GetChild(0))

	self.itemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0 = {}

			var_5_0.type, var_5_0.id, var_5_0.count = unpack(var_4_0[arg_5_1])

			updateDrop(arg_5_2, var_5_0)
			onButton(self, arg_5_2, function()
				self:emit(CrusingWindowLayer.ON_DROP, var_5_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.itemList:align(#var_4_0)

	return
end

function CrusingWindowLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	onButton(self, self.rtBg, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnBack, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnGo, function()
		self:emit(CrusingWindowMediator.GO_CRUSING)

		return
	end, SFX_CONFIRM)

	return
end

function CrusingWindowLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return CrusingWindowLayer
