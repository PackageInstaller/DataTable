local var_0_1 = g.core.const.ConstMgr.RedCliffConst
local RedCliffEditorStruct = class("RedCliffEditorStruct")

function RedCliffEditorStruct:ctor(arg_1_1)
	self._cfg = arg_1_1.cfg
	self._vertexCoord = arg_1_1.pos
	self._leftVertex = self._vertexCoord
	self._rightVertex = self._vertexCoord
	self._editorId = arg_1_1.editorId

	self:_genOccupyCoord()

	self._player = nil
	self._buffTime = 0
	self._isFertile = false
end

function RedCliffEditorStruct:isHighZOrder(arg_2_1)
	if self:getEditorType() == var_0_1.EDITOR_TYPE.BIG then
		if arg_2_1.x * (self._cfg.height / self._cfg.width) < arg_2_1.y then
			return true
		else
			return false
		end
	end

	return self._vertexCoord.y - 1 < arg_2_1.y
end

function RedCliffEditorStruct:getEditorId()
	return self._editorId
end

function RedCliffEditorStruct:getComponentInfo()
	return self._cfg
end

function RedCliffEditorStruct:getVertexCoord()
	return self._vertexCoord
end

function RedCliffEditorStruct:getOccupyCoord()
	return self._occupyCoord
end

function RedCliffEditorStruct:getNearCoord()
	return cc.pAdd(self._vertexCoord, cc.p(1, 1))
end

function RedCliffEditorStruct:getBaseScore()
	if self._cfg.output_type_1 == var_0_1.OUTPUT_TYPE.SCORE then
		return self._cfg.output_value_1
	end

	if self._cfg.output_type_2 == var_0_1.OUTPUT_TYPE.SCORE then
		return self._cfg.output_value_2
	end

	return 0
end

function RedCliffEditorStruct:getFertileScore()
	if self._cfg.event_type == 1 then
		return self._cfg.event_value
	end

	return 0
end

function RedCliffEditorStruct:getFinalOutput()
	return self:getBaseScore() + (self:isFertile() and self:getFertileScore() or 0)
end

function RedCliffEditorStruct:getReduceHp()
	if self._cfg then
		if self._cfg.output_type_1 == var_0_1.OUTPUT_TYPE.HP then
			return self._cfg.output_value_1 / 10
		end

		if self._cfg.output_type_2 == var_0_1.OUTPUT_TYPE.HP then
			return self._cfg.output_value_2 / 10
		end
	end

	return 0
end

function RedCliffEditorStruct:getHpLimit()
	return (1 - self._cfg.hp_loss_limit / 1000) * 100
end

function RedCliffEditorStruct:getPlayer()
	return self._player
end

function RedCliffEditorStruct:getPlayerUserId()
	return self._player and self._player:getUserId() or 0
end

function RedCliffEditorStruct:getComponentId()
	return (self._cfg or nil) and (self._cfg.id or 0)
end

function RedCliffEditorStruct:getEditorName()
	return (self._cfg or nil) and (self._cfg.name or "")
end

function RedCliffEditorStruct:isBarrier()
	return not checkbool(self._cfg)
end

function RedCliffEditorStruct:canStandOn()
	return checkbool(var_0_1.NOT_BARRIER_ID[self._editorId])
end

function RedCliffEditorStruct:_genOccupyCoord()
	self._occupyCoord = {}

	if not self._cfg then
		self._occupyCoord[1] = self._vertexCoord

		return
	end

	local var_19_0 = self._cfg.width

	for iter_19_0 = 0, self._cfg.width - 1 do
		for iter_19_1 = 0, self._cfg.height - 1 do
			table.insert(self._occupyCoord, cc.p(self._vertexCoord.x - iter_19_0, self._vertexCoord.y - iter_19_1))
		end
	end

	self._leftVertex = cc.pSub(self._leftVertex, cc.p(var_19_0, 0))
	self._rightVertex = cc.pSub(self._leftVertex, cc.p(self._cfg.height, 0))
end

function RedCliffEditorStruct:getLeftRightVertex()
	return self._leftVertex, self._rightVertex
end

function RedCliffEditorStruct:isReborn()
	return self._cfg and self._cfg.type == var_0_1.EDITOR_TYPE.REBORN
end

function RedCliffEditorStruct:isSmall()
	return self._cfg and self._cfg.type == var_0_1.EDITOR_TYPE.SMALL
end

function RedCliffEditorStruct:isMid()
	return self._cfg and self._cfg.type == var_0_1.EDITOR_TYPE.MID
end

function RedCliffEditorStruct:isHuge()
	return self._cfg and self._cfg.type == var_0_1.EDITOR_TYPE.HUGE
end

function RedCliffEditorStruct:getEditorType()
	return (self._cfg or nil) and (self._cfg.type or 0)
end

function RedCliffEditorStruct:isFertile()
	return self._isFertile
end

function RedCliffEditorStruct:setPlayer(arg_27_1)
	self._player = arg_27_1
end

function RedCliffEditorStruct:setFertile(arg_28_1)
	self._isFertile = arg_28_1
end

return RedCliffEditorStruct
