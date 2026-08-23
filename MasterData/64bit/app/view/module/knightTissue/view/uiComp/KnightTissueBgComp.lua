local KnightTissueBgComp = class("KnightTissueBgComp", require("app.fairyGUI.knightTissue.UI_KnightTissueBgComp"))
local var_0_1 = g.core.config.knight_tissue_info
local var_0_2 = g.core.const.ConstMgr.KnightTissueConst
local var_0_3 = 20

function KnightTissueBgComp:updateSubComp()
	self._curPos = self:getPosition()

	local var_1_0 = {}

	for iter_1_0 = 1, var_0_1.getLength() do
		local var_1_1 = var_0_1.indexOf(iter_1_0)

		if self["m_tissueHolder" .. var_1_1.id] then
			local var_1_2 = self["m_tissueHolder" .. var_1_1.id]:getChild("tissueComp")

			if var_1_2 then
				var_1_2:updateView(var_1_1)
			else
				var_1_0[#var_1_0 + 1] = var_1_1
			end
		end
	end

	self._pendingCreate = var_1_0
end

function KnightTissueBgComp:startDeferredCreate()
	self._pendingCreate = nil

	if not self._pendingCreate or #self._pendingCreate == 0 then
		return
	end

	if self._createSchedule then
		self:cancelSchedule(self._createSchedule)

		self._createSchedule = nil
	end

	self._createQueue = self._pendingCreate
	self._createCursor = 1
	self._createSchedule = self:newSchedule(handler(self, self._consumeCreateBatch), 0)
end

function KnightTissueBgComp:_consumeCreateBatch()
	if not self._createQueue then
		if self._createSchedule then
			self:cancelSchedule(self._createSchedule)

			self._createSchedule = nil
		end

		return
	end

	local var_3_0 = math.min(self._createCursor + var_0_3 - 1, #self._createQueue)

	for iter_3_0 = self._createCursor, var_3_0 do
		self:_updateOneTissue(self._createQueue[iter_3_0])
	end

	self._createCursor = var_3_0 + 1

	if self._createCursor > #self._createQueue then
		if self._createSchedule then
			self:cancelSchedule(self._createSchedule)

			self._createSchedule = nil
		end

		self._createQueue = nil
	end
end

function KnightTissueBgComp:updateOneById(arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = var_0_1.get(arg_4_1)

	if not var_4_0 then
		return
	end

	self._curPos = self._curPos or self:getPosition()

	self:_updateOneTissue(var_4_0)
end

function KnightTissueBgComp:_updateOneTissue(arg_5_1)
	if not self["m_tissueHolder" .. arg_5_1.id] then
		return
	end

	local var_5_0 = self["m_tissueHolder" .. arg_5_1.id]:getChild("tissueComp")

	if var_5_0 then
		var_5_0:updateView(arg_5_1)
	else
		local var_5_1 = fgui.UIPackage:createObject("knightTissue", "KnightTissueComp")

		var_5_1:setName("tissueComp")
		self["m_tissueHolder" .. arg_5_1.id]:addChild(var_5_1)
		var_5_1:updateView(arg_5_1)
	end
end

function KnightTissueBgComp:_checkCompIsInShowRectView(arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_1:getPosition()
	local var_6_1 = var_0_2.TISSUE_OUTVIEW_RANGE

	if var_6_0.x >= math.abs(self._curPos.x) - var_0_2.TISSUE_OUTVIEW_RANGE and var_6_0.x <= math.abs(self._curPos.x) + display.width + var_6_1 and var_6_0.y >= math.abs(self._curPos.y) - var_0_2.TISSUE_OUTVIEW_RANGE and var_6_0.y <= math.abs(self._curPos.y) + display.height + var_6_1 then
		return true
	end

	return false
end

return KnightTissueBgComp
