local BaseMapComp = class("BaseMapComp")

function BaseMapComp:ctor()
	self:_initComp()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))

	self._uiComps = {}
	self._switchLoader = nil
end

function BaseMapComp:onLoad()
	self:cancelAllSchedule()
	self:newSchedule(handler(self, self._update))
end

function BaseMapComp:onUnload()
	for iter_3_0, iter_3_1 in pairs(self._uiComps) do
		iter_3_1:removeFromParent()
	end

	self._uiComps = {}
end

function BaseMapComp:setMapUI(arg_4_1)
	self._mapUI = arg_4_1
end

function BaseMapComp:hideMapUI()
	for iter_5_0, iter_5_1 in pairs(self._uiComps) do
		iter_5_1:setVisible(false)
	end
end

function BaseMapComp:showTipsUI(arg_6_1, arg_6_2, arg_6_3)
	if not self._mapUI then
		return
	end

	local var_6_0 = arg_6_3.winPos
	local var_6_1 = arg_6_1 .. "_" .. arg_6_2

	if not self._uiComps[arg_6_1 .. "_" .. arg_6_2] then
		local var_6_2 = fgui.UIPackage:createObject(arg_6_1, arg_6_2, self)

		var_6_2:setPivot(0.5, 0.5, true)
		self._mapUI:addChild(var_6_2)

		self._uiComps[var_6_1] = var_6_2
	end

	self._uiComps[var_6_1]:getTransition("enter"):play()
	self._uiComps[var_6_1]:setVisible(true)

	local var_6_3 = self._uiComps[var_6_1]:getWidth()
	local var_6_4 = self._uiComps[var_6_1]:getHeight()
	local var_6_5 = display.height

	if var_6_0.y - var_6_4 / 2 < 0 then
		var_6_0.y = var_6_0.y + var_6_4 / 2
	elseif var_6_5 < var_6_0.y + var_6_4 / 2 then
		var_6_0.y = var_6_0.y - var_6_4 / 2
	end

	if var_6_0.y - var_6_4 / 2 < 0 then
		var_6_0.y = var_6_4 / 2 + 40
	elseif var_6_5 < var_6_0.y + var_6_4 / 2 then
		var_6_0.y = var_6_5 - var_6_4 / 2 - 20
	end

	var_6_0.x = var_6_0.x > display.width / 2 and var_6_0.x - var_6_3 / 2 - 80 or var_6_0.x + var_6_3 / 2 + 80

	self._uiComps[var_6_1]:setPosition(var_6_0)

	if self._uiComps[var_6_1].updateView then
		self._uiComps[var_6_1]:updateView(arg_6_3)
	end
end

function BaseMapComp:_initComp()
	print("BaseMapComp-->")

	self._compMap = self:getChild("Comp_map")
	self._switchLoader = self:getChild("switchLoader")

	print(self._compMap)
	print(self._switchLoader)
end

function BaseMapComp:initTileMap(arg_8_1)
	self._mapNode = arg_8_1.new(self)

	self._compMap:addNode(self._mapNode)
	self._compMap:setPosition(0, cc.Director:getInstance():getWinSize().height)
end

function BaseMapComp:setCustomScale(arg_9_1)
	self._compMap:setScale(arg_9_1)
	self._mapNode:setCustomScale(arg_9_1)
end

function BaseMapComp:jumpToVirtualPos(arg_10_1, arg_10_2)
	self._mapNode:jumpToVirtualPos(arg_10_1, nil, arg_10_2)
end

function BaseMapComp:selectCell(arg_11_1, arg_11_2)
	self._mapNode:selectCell(arg_11_1, arg_11_2)
end

function BaseMapComp:getMapNode()
	return self._mapNode
end

function BaseMapComp:setArrowComp(arg_13_1)
	self._mapNode:setArrowComp(arg_13_1)
end

function BaseMapComp:onClickArrowComp()
	self._mapNode:onClickArrowComp()
end

function BaseMapComp:_update(arg_15_1)
	self._mapNode:update(arg_15_1)
end

function BaseMapComp:_onTouchBegin(arg_16_1)
	arg_16_1:captureTouch()

	local var_16_0 = arg_16_1:getInput():getTouch()

	if not var_16_0 then
		return
	end

	local var_16_1 = var_16_0:getLocation()

	self:dispatchCompEvent("BaseMapComp_onTouchBegin")
	self._mapNode:onTouchBegin(var_16_1.x, var_16_1.y)
	self:hideMapUI()
end

function BaseMapComp:_onTouchMove(arg_17_1)
	local var_17_0 = arg_17_1:getInput():getTouch()

	if not var_17_0 then
		return
	end

	local var_17_1 = var_17_0:getLocation()

	self:dispatchCompEvent("BaseMapComp_onTouchMove")
	self._mapNode:onTouchMove(var_17_1.x, var_17_1.y)
end

function BaseMapComp:_onTouchEnd(arg_18_1)
	local var_18_0 = arg_18_1:getInput():getTouch()

	if not var_18_0 then
		return
	end

	local var_18_1 = var_18_0:getLocation()

	self:dispatchCompEvent("BaseMapComp_onTouchEnd")
	self._mapNode:onTouchEnd(var_18_1.x, var_18_1.y)
end

function BaseMapComp:jumpToPos(arg_19_1, arg_19_2)
	self._mapNode:jumpToPos(arg_19_1, nil, arg_19_2)
end

function BaseMapComp:jumpToPosFinish(arg_20_1, arg_20_2)
	self._mapNode:jumpToPosFinish(arg_20_1, nil, arg_20_2)
end

function BaseMapComp:getFguiSpriteFrame(arg_21_1)
	self._switchLoader = self:getChild("switchLoader")

	self._switchLoader:setLoadAsync(false)
	self._switchLoader:setURL(arg_21_1)

	return self._switchLoader:getContentSprite():getSpriteFrame()
end

function BaseMapComp:showManorTip(arg_22_1)
	return
end

return BaseMapComp
