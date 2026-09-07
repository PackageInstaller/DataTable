local CombatPreviewLayer = class("CombatPreviewLayer", import("view.base.BaseSubView"))
local var_0_3 = Vector3(0, 1, 40)

function CombatPreviewLayer:getUIName()
	return "CombatPreviewUI"
end

function CombatPreviewLayer:OnInit()
	self.OverlayMain = pg.UIMgr.GetInstance().OverlayMain

	setParent(self._go, self.OverlayMain)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.preview = self._tf:Find("preview")
	self.uiLayer = self._tf:Find("preview/ui")
	self.sea = self._tf:Find("preview/sea")
	self.rawImage = self.sea:GetComponent("RawImage")

	setText(self.preview:Find("bg/title/Image"), i18n("word_preview"))
	onButton(self, self.preview, function()
		self.callBack()

		return
	end, SFX_PANEL)

	return
end

function CombatPreviewLayer:Show(arg_4_1, arg_4_2)
	self.callBack = arg_4_2

	local var_4_0 = pg.item_data_battleui[arg_4_1].key
	local var_4_1 = "CombatUI" .. pg.item_data_battleui[arg_4_1].key
	local var_4_2 = "CombatHPBar" .. pg.item_data_battleui[arg_4_1].key
	local var_4_3
	local var_4_4
	local var_4_5

	seriesAsync({
		function(arg_5_0)
			PoolMgr.GetInstance():GetUI(var_4_2, true, function(arg_6_0)
				var_4_4 = arg_6_0

				arg_5_0()

				return
			end)

			return
		end,
		function(arg_7_0)
			PoolMgr.GetInstance():GetUI(var_4_2, true, function(arg_8_0)
				var_4_5 = arg_8_0

				arg_7_0()

				return
			end)

			return
		end,
		function(arg_9_0)
			PoolMgr.GetInstance():GetUI(var_4_1, true, function(arg_10_0)
				var_4_3 = arg_10_0

				arg_9_0()

				return
			end)

			return
		end
	}, function()
		var_4_3.transform:SetParent(self.uiLayer, false)
		var_4_4.transform:SetParent(self.uiLayer, false)
		var_4_5.transform:SetParent(self.uiLayer, false)

		var_4_3.transform.localScale = Vector3(self.sea.rect.width / 0, self.sea.rect.height / 1080, 1)
		self.previewer = CombatUIPreviewer.New(self.rawImage)

		self.previewer:setDisplayWeapon({
			100
		})
		self.previewer:setCombatUI(var_4_3, var_4_4, var_4_5, var_4_0)
		self.previewer:load(40000, Ship.New({
			id = 100001,
			configId = 100001,
			skin_id = 100000
		}), Ship.New({
			id = 100011,
			configId = 100011,
			skin_id = 100010
		}), {}, function()
			return
		end)

		return
	end)

	return
end

function CombatPreviewLayer:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.previewer then
		self.previewer:clear()

		self.previewer = nil
	end

	return
end

return CombatPreviewLayer
