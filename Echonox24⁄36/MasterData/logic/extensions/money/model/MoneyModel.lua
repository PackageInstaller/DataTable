-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/money/model/MoneyModel.lua

module("logic.extensions.money.model.MoneyModel", package.seeall)

local CurrencyCodeEnum = CommEnum.CurrencyCodeEnum
local M = class("MoneyModel", BaseModel)

function M:ctor()
	M.super.ctor(self)

	self._updateParamsMap = {}
end

function M:onInit()
	self._updateParamsMap[CurrencyCodeEnum.TlCode] = {
		updateFunc = self.getUpdateParamsEnergy
	}
	self._updateParamsMap[CurrencyCodeEnum.ProtomerModulePointCode] = {
		updateFunc = self.getUpdateParamsProtomerModelPoint
	}
	self._updateParamsMap[CurrencyCodeEnum.AirStudioChallengeNum] = {
		updateFunc = self.getUpdateParamsAirStudioChallengeNum
	}
	self._updateParamsMap[CurrencyCodeEnum.RoguelikeCoinCode] = {
		updateFunc = self.getUpdateParamsRoguelikeCoin
	}
end

function M:getMoneyUpdateParams(code)
	if code == CurrencyCodeEnum.CustomCode then
		return 0
	end

	local updateInfo = self._updateParamsMap[code]
	local updateFunc = updateInfo and updateInfo.updateFunc or self.getUpdateParamsDefault

	return updateFunc(self, code)
end

function M:getUpdateParamsDefault(code)
	local num = ItemModel.instance:getItemCountByItemId(code)

	return num
end

function M:getUpdateParamsEnergy(code)
	local itemCount = ItemModel.instance:getItemCountByItemId(code)
	local maxValue = PlayerModel.instance:getEnergyLimit()
	local maxValueCfg = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.EnergyMax)
	local numStr

	if maxValue and maxValue <= itemCount then
		numStr = string.format("<color=%s>%s</color><color=%s>/%s</color>", MoneyUtil.CurEnergyReachMaxColor, itemCount, MoneyUtil.MaxEnergyColor, maxValue)
	else
		numStr = string.format("<color=%s>%s</color><color=%s>/%s</color>", MoneyUtil.CurEnergyNormalColor, itemCount, MoneyUtil.MaxEnergyColor, maxValue)
	end

	return numStr
end

function M:getUpdateParamsProtomerModelPoint(code)
	local curSelectProtomerId = ProtomerModel.instance:getCurSelectProtomerId()
	local protomerInfoMo = ProtomerModel.instance:getProtomerInfo(curSelectProtomerId)

	return protomerInfoMo and protomerInfoMo:getModulePoint() or 0
end

function M:getUpdateParamsAirStudioChallengeNum(code)
	local maxNum = AirWorkShopConfig.instance:getMaxChallengeNum()
	local curNum = AirWorkShopChallengeModel.instance:getCurChallengeNum()

	return string.format("%s/%s", curNum, maxNum)
end

function M:getUpdateParamsRoguelikeCoin(code)
	return RoguelikeModel.instance:getGold()
end

M.instance = M.New()

return M
