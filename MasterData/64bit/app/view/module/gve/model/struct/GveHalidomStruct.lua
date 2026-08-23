local var_0_0 = g.core.config.gve_equipment_info
local GveHalidomStruct = class("GveHalidomStruct")

function GveHalidomStruct:ctor(arg_1_1, arg_1_2)
	self:initData()
	self:updateData(arg_1_1, arg_1_2)
end

function GveHalidomStruct:initData()
	self._branch = 0
	self._isEquip = false
	self._id = 0
	self._position = 0
	self._cfg = {}
	self._num = 0
	self._level = 0
end

function GveHalidomStruct:updateData(arg_3_1, arg_3_2)
	self._isEquip = arg_3_2

	if self._isEquip then
		self._id = arg_3_1.num
		self._num = 1
	else
		self._id = arg_3_1.id
		self._num = arg_3_1.num
	end

	self._cfg = var_0_0.get(self._id)
	self._position = self._cfg.location
	self._branch = self._cfg.job
	self._level = self._cfg.level
end

function GveHalidomStruct:getId()
	return self._id
end

function GveHalidomStruct:getBranch()
	return self._branch
end

function GveHalidomStruct:getNum()
	return self._num
end

function GveHalidomStruct:getPosition()
	return self._position
end

function GveHalidomStruct:getIsEquip()
	return self._isEquip
end

function GveHalidomStruct:getPreLevel()
	return self._cfg.pre_level
end

function GveHalidomStruct:getLevel()
	return self._level
end

function GveHalidomStruct:getPrice()
	return self._cfg.price
end

function GveHalidomStruct:getIcon()
	return self._cfg.icon
end

function GveHalidomStruct:getRecyclePrice()
	return self._cfg.recycle
end

function GveHalidomStruct:getName()
	return self._cfg.name
end

function GveHalidomStruct:getCfg()
	return self._cfg
end

function GveHalidomStruct:getNeedTaskLevel()
	return self._cfg.need_task_level
end

function GveHalidomStruct:getBackIcon()
	return self._cfg.icon_back
end

function GveHalidomStruct:setNum(arg_18_1)
	self._num = arg_18_1
end

return GveHalidomStruct
