local NewSlgMainMiniMapComp = class("NewSlgMainMiniMapComp")

function NewSlgMainMiniMapComp:ctor()
	self:getChild("Comp_map"):setVisible(false)
	self:getChild("Comp_map2"):setVisible(false)

	self._compMap = g.core.model.User.newSlgData:getSName() == "S2" and self:getChild("Comp_map2") or self:getChild("Comp_map")

	self._compMap:enableMap()
	self._compMap:setVisible(true)
	self._compMap:initMapParams({
		opacity = 200,
		scale = 2,
		campScale = 0.65,
		closeBuildTouch = true,
		closeName = true,
		offset = cc.p(self:getWidth() / 2, self:getHeight() / 2)
	})

	self._isEnter = false
end

function NewSlgMainMiniMapComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER, handler(self, self._onRcvEnter), self)
	self:newSchedule(handler(self, self._update))
end

function NewSlgMainMiniMapComp:setMap(arg_3_1)
	self._map = arg_3_1
end

function NewSlgMainMiniMapComp:updateView(arg_4_1)
	self._compMap:updateView(arg_4_1)
end

function NewSlgMainMiniMapComp:_update()
	if self._isEnter and self._map then
		local var_5_0 = self._map:getMapNode()

		self._compMap:move({
			pos = cc.p(-var_5_0:getPositionX(), -var_5_0:getPositionY())
		})
	end
end

function NewSlgMainMiniMapComp:_onRcvEnter()
	self._isEnter = true

	self._compMap:updateView()
end

function NewSlgMainMiniMapComp:onUnload()
	return
end

function NewSlgMainMiniMapComp:getMapNode()
	return self._map:getMapNode()
end

return NewSlgMainMiniMapComp
