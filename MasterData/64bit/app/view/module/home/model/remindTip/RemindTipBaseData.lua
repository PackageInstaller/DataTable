local RemindTipBaseData = class("RemindTipBaseData")

function RemindTipBaseData:ctor(arg_1_1)
	self._uid = arg_1_1.unique_id
	self._cfgId = arg_1_1.id
	self._cfg = g.core.config.tips_info.get(self._cfgId)
	self._expire_time = arg_1_1.expire_time
	self._params = arg_1_1.params or ""
	self._sourceId = arg_1_1.source_id
	self._isNew = false
	self._isTempUid = false
end

function RemindTipBaseData:_initTempUid()
	self._uid = table.concat({
		self._cfgId,
		(g.core.common.ServerTime:getDate())
	}, "_")
	self._isTempUid = true
end

function RemindTipBaseData:isUseTempUid()
	return self._isTempUid
end

function RemindTipBaseData:getUid()
	return self._uid
end

function RemindTipBaseData:getCfgId()
	return self._cfgId
end

function RemindTipBaseData:getCfg()
	return self._cfg
end

function RemindTipBaseData:getCheckKey()
	local var_7_0 = {
		self._cfgId
	}

	var_7_0[#var_7_0 + 1] = self._sourceId
	var_7_0[#var_7_0 + 1] = self._params
	var_7_0[#var_7_0 + 1] = self._expire_time

	return table.concat(var_7_0, "_")
end

function RemindTipBaseData:updateData(arg_8_1)
	self._cfgId = arg_8_1.id
	self._cfg = g.core.config.tips_info.get(self._cfgId)
	self._expire_time = arg_8_1.expire_time
	self._params = arg_8_1.params
end

function RemindTipBaseData:getTipIconId()
	return self._cfg.res
end

function RemindTipBaseData:getSortOrder()
	return self._cfg.order
end

function RemindTipBaseData:getParams()
	return self._params
end

function RemindTipBaseData:getExpireTime()
	return self._expire_time
end

function RemindTipBaseData:isInTime()
	return (self._expire_time or nil) and self._expire_time > g.core.common.ServerTime:getTime()
end

function RemindTipBaseData:setIsNew(arg_14_1)
	self._isNew = arg_14_1
end

function RemindTipBaseData:isNew()
	return self._isNew
end

function RemindTipBaseData:isHide()
	return not g.core.common.ModuleUnlock:isModuleUnlock(self._cfg.function_id)
end

function RemindTipBaseData:getTipStr()
	return self._cfg.text
end

function RemindTipBaseData:getJumpFunc()
	return nil
end

return RemindTipBaseData
