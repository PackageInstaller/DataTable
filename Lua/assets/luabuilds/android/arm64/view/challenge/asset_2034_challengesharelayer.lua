local ChallengeShareLayer = class("ChallengeShareLayer", import("..base.BaseUI"))

function ChallengeShareLayer:getUIName()
	return "ChallengeShareUI"
end

function ChallengeShareLayer:init()
	self.painting = self._tf:Find("main/Painting")
	self.shipList = self._tf:Find("main/ship_list")
	self.cardTF = self.shipList:Find("ship_card")
	self.itemList = UIItemList.New(self.shipList, self.cardTF)
	self.wordTF = self._tf:Find("main/word")
	self.touchBtn = self._tf:Find("touch_btn")

	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	return
end

function ChallengeShareLayer:setLevel(arg_3_1)
	self.level = arg_3_1

	return
end

function ChallengeShareLayer:setShipPaintList(arg_4_1)
	self.shipPaintList = arg_4_1

	return
end

function ChallengeShareLayer:setFlagShipPaint(arg_5_1)
	self.flagShipPaint = arg_5_1

	return
end

function ChallengeShareLayer:didEnter()
	onButton(self, self.touchBtn, function()
		if self.isLoading then
			return
		end

		self:closeView()

		return
	end, SFX_PANEL)
	self.itemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			table.insert(self.funcs, function(arg_9_0)
				LoadSpriteAsync("shipYardIcon/" .. self.shipPaintList[arg_8_1 + 1], function(arg_10_0)
					if not IsNil(arg_8_2) then
						setImageSprite(arg_8_2:Find("back/Image"), arg_10_0)
					end

					arg_9_0()

					return
				end)

				return
			end)
		end

		return
	end)
	self:flush()

	return
end

function ChallengeShareLayer:flush()
	self.funcs = {}

	self.itemList:align(#self.shipPaintList)
	table.insert(self.funcs, function(arg_12_0)
		setPaintingPrefabAsync(self.painting, self.flagShipPaint, "chuanwu", arg_12_0)

		return
	end)

	self.isLoading = true

	parallelAsync(self.funcs, function()
		self.isLoading = false

		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeChallenge)

		return
	end)
	setText(self.wordTF:Find("Text"), i18n("challenge_share_progress"))
	setText(self.wordTF:Find("number/Text"), self.level)
	setText(self.wordTF:Find("Text2"), i18n("challenge_share"))

	return
end

function ChallengeShareLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return ChallengeShareLayer
