-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bindmobile/model/BindMobileModel.lua

module("logic.extensions.bindmobile.model.BindMobileModel", package.seeall)

local BindMobileModel = class("BindMobileModel", BaseModel)

function BindMobileModel:onInit()
	self:onReset()
end

function BindMobileModel:onReset()
	self._info = nil
	self._bindCode = nil
end

function BindMobileModel:getInfo()
	return self._info
end

function BindMobileModel:clearInfoResult()
	if self._info then
		self._info.result = nil
	end
end

function BindMobileModel:getBindCodeInfo()
	return self._bindCode
end

function BindMobileModel:onGetInfo(msg)
	self._info = GameUtil.pbToTable(msg)
end

function BindMobileModel:onGetBindCode(msg)
	self._bindCode = GameUtil.pbToTable(msg)

	if self._info then
		self._info.sendCaptchaCdTimeMillis = checknumber(self._bindCode.sendCaptchaCdTimeMillis)

		if self._bindCode.result then
			self._info.result = self._bindCode.result
		end
	end
end

function BindMobileModel:onBindCode(msg)
	local pb = GameUtil.pbToTable(msg)

	if self._info and pb and pb.result then
		self._info.result = pb.result
	end
end

BindMobileModel.instance = BindMobileModel.New()

return BindMobileModel
