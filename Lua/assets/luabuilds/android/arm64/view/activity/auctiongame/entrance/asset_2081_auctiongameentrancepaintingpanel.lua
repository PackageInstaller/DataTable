local AuctionGameEntrancePaintingPanel = class("AuctionGameEntrancePaintingPanel", import("view.base.BasePanel"))

function AuctionGameEntrancePaintingPanel:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameEntrancePaintingPanel.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameEntrancePaintingPanel:Init()
	self.paintingDefaultAngle = self.uiPaintingTf.localEulerAngles

	self:SwitchDisplayPanel(true)

	self.paintingEventCom = GetComponent(self._tf, typeof(DftAniEvent))

	onButton(self, self.uiDisplayBtn, function()
		seriesAsync({
			function(arg_4_0)
				self:SwitchDisplayPanel(true)
				self.paintingEventCom:SetEndEvent(arg_4_0)
				quickPlayAnimation(self._tf, "Anim_AuctionGameEntranceUI_leftPanel_in")

				return
			end
		}, function()
			return
		end)

		return
	end)
	onButton(self, self.uiCollapseBtn, function()
		seriesAsync({
			function(arg_7_0)
				self.paintingEventCom:SetEndEvent(arg_7_0)
				quickPlayAnimation(self._tf, "Anim_AuctionGameEntranceUI_leftPanel_out")

				return
			end
		}, function()
			self:SwitchDisplayPanel(false)

			return
		end)

		return
	end)

	return
end

function AuctionGameEntrancePaintingPanel:didEnter()
	self.shipVO = getProxy(BayProxy):GetShipPhantom(getProxy(PlayerProxy):getRawData():GetShipPhantomMarks()[1])

	self:RefreshPainting()

	return
end

function AuctionGameEntrancePaintingPanel:RefreshPainting()
	setPaintingPrefabAsync(self.uiPaintingTf, self:GetPaintingName(), "biandui", nil, {
		skinID = self.shipVO:getSkinId(),
		rotateZ = self.paintingDefaultAngle.z
	})

	return
end

function AuctionGameEntrancePaintingPanel:SwitchDisplayPanel(arg_11_1)
	setActive(self.uiDisplayBtn, not arg_11_1)
	setActive(self.uiPaintingPanel, arg_11_1)

	return
end

function AuctionGameEntrancePaintingPanel:GetPaintingName()
	return (self.shipVO:getPainting())
end

function AuctionGameEntrancePaintingPanel:willExit()
	self:detach()
	self.paintingEventCom:SetEndEvent(nil)
	retPaintingPrefab(self.uiPaintingTf, self:GetPaintingName())

	return
end

return AuctionGameEntrancePaintingPanel
