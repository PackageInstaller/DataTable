local var_0_0 = g.core.model.User.geneData
local var_0_1 = g.core.const.ConstMgr.GeneConst
local var_0_2 = g.core.const.ConstMgr.SoundConst
local GeneSequenceMainComp = class("GeneSequenceMainComp", require("app.fairyGUI.gene.UI_GeneSequenceMainComp"))

function GeneSequenceMainComp:ctor()
	self._geneId = 0
	self._fragsInfo = nil

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function GeneSequenceMainComp:setGeneInfo(arg_2_1)
	self._geneId = arg_2_1
	self._geneLen = var_0_0:getGeneLen(self._geneId)

	self.m_sizeController:setSelectedIndex(self._geneLen == 7 and 1 or 0)

	self._gridSize = var_0_1.GRID_SIZE[self._geneLen]
	self._fragsInfo = var_0_0:getGeneFragmentById(self._geneId)

	self:_loadGeneFragment()
end

function GeneSequenceMainComp:_loadGeneFragment()
	self:removeChildren()

	for iter_3_0 = 1, self._geneLen do
		for iter_3_1 = 1, self._geneLen do
			if self._fragsInfo[iter_3_0][iter_3_1].id and self._fragsInfo[iter_3_0][iter_3_1].id > 0 then
				local var_3_0 = fgui.UIPackage:createObject("gene", "GeneFragmentComp")

				var_3_0:setInfo({
					geneId = self._geneId,
					id = self._fragsInfo[iter_3_0][iter_3_1].id,
					x = iter_3_0,
					y = iter_3_1
				})
				var_3_0:setSortingOrder(1)
				self:addChild(var_3_0)
			end
		end
	end
end

function GeneSequenceMainComp:checkWeakGuide()
	self:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
			key = "GENE_DRAG_GUIDE",
			objects = {
				(self:getFragmentComp(var_0_1.GUIDE_GRID.x, var_0_1.GUIDE_GRID.y))
			}
		})
	end, 0.3)
end

function GeneSequenceMainComp:_onTouchBegin(arg_6_1)
	self._selectFrag = nil
	self._dragDistance = 0

	arg_6_1:captureTouch()

	local var_6_0 = arg_6_1:getInput():getTouch()

	if var_6_0 then
		local var_6_1 = var_6_0:getLocation()

		self._beginPos = var_6_1

		local var_6_2 = self:displayObject():convertToNodeSpace(var_6_1)

		var_6_2.y = self:getHeight() - var_6_2.y

		if var_0_0:getSwapInfo() ~= nil then
			return
		end

		local var_6_3 = self:_getIdxPos(var_6_2)

		if var_6_3 then
			self._selectFrag = self:getFragmentComp(var_6_3.x, var_6_3.y)
		end

		if self._selectFrag then
			if self._fragsInfo[var_6_3.x][var_6_3.y].activated then
				self._selectFrag:setPlaceState(1)
			end

			self._selectedPos = self._selectFrag:getPosition()
		else
			self._selectedPos = nil
		end
	end
end

function GeneSequenceMainComp:_onTouchMove(arg_7_1)
	local var_7_0 = arg_7_1:getInput():getTouch()

	if var_7_0 then
		local var_7_1 = var_7_0:getLocation()

		self._dragDistance = math.max(self._dragDistance, (math.max(math.abs(var_7_1.x - self._beginPos.x), math.abs(var_7_1.y - self._beginPos.y))))

		local var_7_2 = self:displayObject():convertToNodeSpace(var_7_1)

		var_7_2.y = self:getHeight() - var_7_2.y

		if self._selectFrag then
			local var_7_3 = self._selectFrag:getInfo()

			if not self._fragsInfo[var_7_3.x][var_7_3.y].activated and self._dragDistance >= 5 then
				self._selectFrag = nil

				return
			end

			if self._dragDistance < 5 then
				return
			end

			self._selectFrag:setSortingOrder(2)
			self._selectFrag:setPosition(var_7_2)

			local var_7_4 = self:_getIdxPos(var_7_2)

			if var_7_4 then
				if self._fragsInfo[var_7_4.x][var_7_4.y] then
					if self._fragsInfo[var_7_4.x][var_7_4.y].activated then
						self._selectFrag:setPlaceState(2)
					else
						self._selectFrag:setPlaceState(3)
					end
				else
					self._selectFrag:setPlaceState(3)
				end
			else
				self._selectFrag:setPlaceState(0)
			end
		end
	end
end

function GeneSequenceMainComp:_onTouchEnd(arg_8_1)
	local var_8_0 = arg_8_1:getInput():getTouch()

	if var_8_0 then
		local var_8_1 = self:displayObject():convertToNodeSpace((var_8_0:getLocation()))

		var_8_1.y = self:getHeight() - var_8_1.y

		if self._selectFrag then
			self._selectFrag:setSortingOrder(1)

			local var_8_2 = self:_getIdxPos(var_8_1)

			if var_8_2 then
				local var_8_3 = self:getFragmentComp(var_8_2.x, var_8_2.y)

				if self._fragsInfo[var_8_2.x][var_8_2.y].activated and var_8_3 ~= self._selectFrag then
					local var_8_4 = self._selectFrag:getInfo()
					local var_8_5 = var_8_3:getInfo()
					local var_8_6 = {
						comp1 = self._selectFrag,
						id1 = var_8_4.id,
						x1 = var_8_4.x,
						y1 = var_8_4.y,
						comp2 = var_8_3,
						id2 = var_8_5.id,
						x2 = var_8_5.x,
						y2 = var_8_5.y
					}

					var_0_0:setSwapInfo(var_8_6)
					var_0_0:setPreGeneAttr((var_0_0:getGeneAttr(self._geneId)))
					var_8_6.comp1:setInfo({
						geneId = self._geneId,
						id = var_8_6.id1,
						x = var_8_6.x2,
						y = var_8_6.y2
					})
					var_8_6.comp2:setInfo({
						geneId = self._geneId,
						id = var_8_6.id2,
						x = var_8_6.x1,
						y = var_8_6.y1
					})
					var_0_0:setSwapInfo(nil)
					g.core.network.GameNetProxy:send_C2S_Gene_ChangePosition({
						base_id1 = var_8_6.id1,
						base_id2 = var_8_6.id2
					})
				else
					self._selectFrag:setPosition(self._selectedPos)
				end
			else
				self._selectFrag:setPosition(self._selectedPos)
			end

			self._selectFrag:setPlaceState(0)

			if self._dragDistance < 5 then
				self._selectFrag:showInfoPop()
			end
		end
	end

	self._selectFrag = nil
end

function GeneSequenceMainComp:_getIdxPos(arg_9_1)
	return (arg_9_1.x > 0 and arg_9_1.x < self._gridSize.W * self._geneLen and arg_9_1.y > 0 and arg_9_1.y < self._gridSize.H * self._geneLen or nil) and {
		x = math.ceil(arg_9_1.x / self._gridSize.W),
		y = math.ceil(arg_9_1.y / self._gridSize.H)
	}
end

function GeneSequenceMainComp:getFragmentComp(arg_10_1, arg_10_2)
	return self:getChild("frag" .. arg_10_1 .. "_" .. arg_10_2)
end

function GeneSequenceMainComp:activateSegment(arg_11_1)
	local var_11_0 = true

	for iter_11_0, iter_11_1 in pairs((var_0_0:getLinkedFrags(self._geneId, arg_11_1))) do
		if var_0_0:getFragActivatedState(self._geneId, iter_11_1.x, iter_11_1.y) >= 2 then
			self:getChild(iter_11_0):playLightAni()

			var_11_0 = false
		end
	end

	if var_11_0 then
		local var_11_1 = var_0_0:getFragPos(self._geneId, arg_11_1)

		if var_11_1 then
			self:getChild("frag" .. var_11_1.x .. "_" .. var_11_1.y):playLightAni()
		end
	end

	for iter_11_2, iter_11_3 in ipairs((self:getChildren())) do
		iter_11_3:updateLinkVisible()
		iter_11_3:updateEffectState()
	end

	if self._selectFrag then
		self._selectFrag = nil
	end
end

function GeneSequenceMainComp:fragmentChangePosition(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs((self:getChildren())) do
		iter_12_1:updateLinkVisible()
		iter_12_1:updateEffectState()
	end

	local var_12_0 = false

	for iter_12_2, iter_12_3 in pairs(arg_12_1) do
		if var_0_0:getFragActivatedState(self._geneId, iter_12_3.x, iter_12_3.y) >= 2 then
			var_12_0 = true
		end
	end

	if var_12_0 then
		g.core.sound.SoundManager:playSound(var_0_2.Sound.UI_EVENT_TB_CONNECT)
	else
		g.core.sound.SoundManager:playSound(var_0_2.Sound.UI_EVENT_TB_EXCHANGE)
	end
end

return GeneSequenceMainComp
