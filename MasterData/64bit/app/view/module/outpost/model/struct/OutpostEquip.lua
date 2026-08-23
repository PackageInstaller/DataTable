local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = g.core.config.outpost_talent_skill_info
local OutpostEquip = class("OutpostEquip")

function OutpostEquip:ctor()
	self._type = var_0_0.EquipType.NONE
	self._id = 0
	self._starLv = 0
	self._quality = 0
	self._sellPrice = 0
	self._talent_ids = {}
	self._cfg = nil
	self._productGoods = nil
	self._owner = nil
end

function OutpostEquip:updateEquipByEquipId(arg_2_1)
	if self._id == arg_2_1 then
		return
	end

	self._productGoods = nil
	self._cfg = g.core.config.outpost_equip_info.get(arg_2_1)
	self._id = arg_2_1
	self._starLv = self._cfg.equip_star
	self._quality = self._cfg.quality
	self._sellPrice = self._cfg.gold

	if var_0_0.EquipType.NONE == self._type then
		self._type = self._cfg.equip_type
	end
end

function OutpostEquip:updateEquipBySvrInfo(arg_3_1)
	self:updateEquipByEquipId(arg_3_1.id)

	self._talent_ids = arg_3_1.talent_ids
end

function OutpostEquip:getEquipType()
	return self._type
end

function g.core.const.ConstMgr.outpostConst:getProfession()
	return self._cfg.profession
end

function OutpostEquip:getQuality()
	return self._quality
end

function OutpostEquip:getStar()
	return self._starLv
end

function OutpostEquip:getPrice()
	return self._sellPrice
end

function OutpostEquip:getStarIndex()
	return self._cfg.consumption_level >= 37 and 15 or 14
end

function OutpostEquip:getCfg()
	return self._cfg
end

function OutpostEquip:_updateBuyGoods()
	self._productGoods = {}

	local var_11_0 = 1
	local var_11_1 = {
		"item_value_"
	}

	var_11_1[2] = 1

	local var_11_2 = table.concat(var_11_1)
	local var_11_3 = table.concat({
		"item_size_",
		var_11_0
	})

	while g.core.config.outpost_equip_info.hasKey(var_11_2) do
		self._productGoods[#self._productGoods + 1] = {
			type = var_0_0.EXCHANGE_ITEM_TYPE,
			value = self._cfg[var_11_2],
			size = self._cfg[var_11_3]
		}
		var_11_0 = var_11_0 + 1
		var_11_2 = table.concat({
			"item_value_",
			var_11_0
		})
		var_11_3 = table.concat({
			"item_size_",
			var_11_0
		})
	end
end

function OutpostEquip:getProductGoods()
	if not self._productGoods then
		self:_updateBuyGoods()
	end

	return self._productGoods
end

function OutpostEquip:setOwner(arg_13_1)
	self._owner = arg_13_1
end

function OutpostEquip:getOwner()
	return self._owner
end

function OutpostEquip:getItemInfo()
	return {
		iconCompName = "BaseItemIcon",
		name = self._cfg.name,
		icon = self._cfg.res,
		quality = self._quality
	}
end

function OutpostEquip:getCfg()
	return self._cfg
end

function OutpostEquip:getTalentCfg()
	return var_0_1.get(self._cfg.talent_skill)
end

function OutpostEquip:isBaseAttrHighThanOtherEquip(arg_18_1)
	if self._cfg.sort ~= arg_18_1:getCfg().sort then
		return self._cfg.sort > arg_18_1:getCfg().sort
	end

	return false
end

return OutpostEquip
