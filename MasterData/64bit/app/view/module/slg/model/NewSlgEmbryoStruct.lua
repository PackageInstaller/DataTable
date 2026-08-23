local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.common.Path
local NewSlgEmbryoStruct = class("NewSlgEmbryoStruct")

function NewSlgEmbryoStruct:ctor(arg_1_1)
	self._cfg = nil
	self._pos = 0
	self._embryoStruct = nil
	self._isRecommend = false
end

function NewSlgEmbryoStruct:setCfg(arg_2_1)
	self._cfg = arg_2_1
end

function NewSlgEmbryoStruct:getCfg()
	return self._cfg
end

function NewSlgEmbryoStruct:getAuthorityNum()
	return self._cfg.authority
end

function NewSlgEmbryoStruct:getType()
	return self._cfg.type
end

function NewSlgEmbryoStruct:getId()
	return self._cfg.id
end

function NewSlgEmbryoStruct:getAdvId()
	return self._cfg.advance_id
end

function NewSlgEmbryoStruct:getSid()
	return g.core.common.GlobalFunc.getSerIdByTypeAndStruct(self:getType(), self:getEmbryoStruct())
end

function NewSlgEmbryoStruct:getStar()
	if self._embryoStruct and self._embryoStruct.getStar then
		return self._embryoStruct:getStar()
	end

	return 0
end

function NewSlgEmbryoStruct:setPos(arg_10_1)
	self._pos = arg_10_1
end

function NewSlgEmbryoStruct:getPos()
	return self._pos
end

function NewSlgEmbryoStruct:setEmbryoStruct(arg_12_1)
	self._embryoStruct = arg_12_1
end

function NewSlgEmbryoStruct:getEmbryoStruct()
	return self._embryoStruct
end

function NewSlgEmbryoStruct:getName()
	return self._embryoStruct:getName()
end

function NewSlgEmbryoStruct:getQuality()
	return self._embryoStruct:getQuality()
end

function NewSlgEmbryoStruct:getResId()
	local var_16_0 = self:getType()
	local var_16_1 = self:getAdvId()

	if var_16_0 == var_0_0.TYPE_KNIGHT then
		var_16_1 = g.core.config.knight_base_info.get(var_16_1).painted_id
	elseif var_16_0 == var_0_0.TYPE_PET then
		var_16_1 = g.core.config.pet_info.get(var_16_1).resource
	elseif var_16_0 == var_0_0.TYPE_UNITETOKEN then
		var_16_1 = g.core.config.unite_token_info.get(var_16_1).res_id
	elseif var_16_0 == var_0_0.TYPE_ARTIFACT then
		var_16_1 = g.core.config.artifact_info.get(var_16_1).res_id
	end

	return var_16_1
end

function NewSlgEmbryoStruct:getPicRes()
	local var_17_0 = self:getType()
	local var_17_1 = self:getAdvId()

	if var_17_0 == var_0_0.TYPE_KNIGHT then
		var_17_1 = g.core.config.knight_base_info.get(var_17_1).painted_id

		return var_0_1:getKnightBookPicRes(var_17_1)
	elseif var_17_0 == var_0_0.TYPE_PET then
		var_17_1 = g.core.config.pet_info.get(var_17_1).resource

		return var_0_1:getPetPictorialBook(var_17_1)
	elseif var_17_0 == var_0_0.TYPE_UNITETOKEN then
		var_17_1 = g.core.config.unite_token_info.get(var_17_1).res_id

		return var_0_1:getUniteTokenCardImg(var_17_1)
	elseif var_17_0 == var_0_0.TYPE_ARTIFACT then
		var_17_1 = g.core.config.artifact_info.get(var_17_1).res_id

		return var_0_1:getArtifactRebornImg(var_17_1)
	elseif var_17_0 == var_0_0.TYPE_SUCCUBA then
		return var_0_1:getSuccubaImg(g.core.config.succuba_info.get(var_17_1).advance_id)
	end

	return ""
end

function NewSlgEmbryoStruct:getHeadIcon()
	return var_0_1:getIconByTypeValue(self:getType(), self:getAdvId())
end

function NewSlgEmbryoStruct:getStarType()
	local var_19_0 = self:getType()

	if var_19_0 == var_0_0.TYPE_MAGIC and self:getQuality() < g.core.const.ConstMgr.QUALITY_TYPE.CANGGOLD then
		return 2
	elseif var_19_0 == var_0_0.TYPE_ARMS then
		return 1
	end

	return 0
end

function NewSlgEmbryoStruct:setRecommend(arg_20_1)
	self._isRecommend = arg_20_1
end

function NewSlgEmbryoStruct:getMaxStarLevel()
	return self._embryoStruct:getMaxStarLevel(self:getAdvId())
end

function NewSlgEmbryoStruct:isOwn()
	return self._embryoStruct:isOwn()
end

function NewSlgEmbryoStruct:isLineUp()
	return self._pos > 0
end

function NewSlgEmbryoStruct:isRecommend()
	local var_24_0 = self._isRecommend

	if self._isRecommend then
		var_24_0 = self:isOwn()
		var_24_0 = var_24_0 and not self:isLineUp()
	end

	return var_24_0
end

return NewSlgEmbryoStruct
