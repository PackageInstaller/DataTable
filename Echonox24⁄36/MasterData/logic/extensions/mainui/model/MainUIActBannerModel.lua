-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/model/MainUIActBannerModel.lua

module("logic.extensions.mainui.model.MainUIActBannerModel", package.seeall)

local M = class("MainUIActBannerModel", BaseModel)

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._allList = {}
	self._realShowList = {}

	self:_setAllList()
end

function M:_setAllList()
	self._allList = {}

	local configList = MainUIActBannerConfig.instance:getConfigList()

	for k, v in pairs(configList) do
		if k == 10000 then
			self._defaultMo = MainUIActBannerMo.New()

			self._defaultMo:setBannerMo(v)
		else
			local tempMo = MainUIActBannerMo.New()

			tempMo:setBannerMo(v)

			self._allList[k] = tempMo
		end
	end
end

function M:setRealShowList()
	local tempRealList = {}
	local count = 0

	for k, v in pairs(self._allList) do
		if v:isOpenBanner() then
			count = count + 1
			tempRealList[count] = v
		end
	end

	table.sort(tempRealList, function(a, b)
		if a:getPriority() > b:getPriority() then
			return true
		elseif a:getPriority() == b:getPriority() and a:getId() < b:getId() then
			return true
		end

		return false
	end)

	self._realShowList = tempRealList
end

function M:getRealShowList()
	return self._realShowList
end

function M:getDefaultMo()
	return self._defaultMo
end

M.instance = M.New()

return M
