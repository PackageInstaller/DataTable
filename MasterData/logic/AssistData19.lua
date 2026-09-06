-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/data/AssistData19.lua

module("logic.extensions.xiaonuoassistant.view.data.AssistData19", package.seeall)

local AssistData19 = class("AssistData19", BaseAssistData)

AssistData19.MaxNum = 10
AssistData19.MaxBuyNum = 5

function AssistData19:init()
	for i = 1, AssistData19.MaxNum do
		self["selectIndex" .. i] = i
		self["keySelectNum" .. i] = "keySelectNum" .. i
	end

	self.cfgs = TimeWheelController.instance:getExchangeCfgsList()
end

function AssistData19:setSelectAll(isOn)
	self:setOpenData(isOn)
end

function AssistData19:getSendCallbackList()
	if self:getOpenData() then
		local sendMo = self:getSendMo()

		XiaoNuoAssistCostModel.instance:clearCoin(self:getFuncIndex(), GameEnum.GoldType.PixieDust)
		XiaoNuoAssistCostModel.instance:clearCoin(self:getFuncIndex(), GameEnum.GoldType.TimeWheelOverflow)

		for i = 1, AssistData19.MaxNum do
			local key = "selectIndex" .. i

			if self:getCellSelect(self[key]) then
				local cfg = self.cfgs[i]
				local isLimit = cfg.limitType ~= "none"
				local buyTimes = isLimit and PayShopModel.instance:getMibaoBuyTimesById(cfg.id) or 0

				if isLimit then
					if not cfg.limitTimes then
						local maxBuyTimes = AssistData19.MaxBuyNum
						local leftTimes = Mathf.Max(0, maxBuyTimes - buyTimes)
						local selectNum = self:getSelectNum(i)
						local realNum = Mathf.Min(leftTimes, selectNum)

						if realNum > 0 then
							local coinStr, selectTotalPrice = self:getTotalPrice(i)

							XiaoNuoAssistCostModel.instance:addCoin(self:getFuncIndex(), coinStr, selectTotalPrice)

							local costTotalCoins = XiaoNuoAssistCostModel.instance:getTotalCoin(self:getFuncIndex(), coinStr)
							local totalCoins = MaterialMgr.getMatCount(coinStr)

							if costTotalCoins <= totalCoins then
								local id = self.cfgs[i].id

								local function callback()
									printInfo("test 溯源商店", id, realNum)
									PayShopController.instance:buyShopItem(id, realNum)
								end

								table.insert(sendMo.callbackList, callback)
							end
						end
					end
				end
			end
		end

		return sendMo
	end
end

function AssistData19:getTotalPrice(index)
	local cfg = self.cfgs[index]
	local selectNum = self:getSelectNum(index)
	local matType, id, unitPrice = MaterialMgr.getMatParams(cfg.originalGoodsId)
	local str = matType .. ":" .. id

	return str, selectNum * unitPrice
end

function AssistData19:getSelectNum(index)
	return self:getCellDataToNumber(self["keySelectNum" .. index])
end

function AssistData19:setSelectNum(index, num)
	self:setCellData(self["keySelectNum" .. index], num)
end

function AssistData19:getCostCoins()
	local curCostPixieDust = 0
	local curCostTimeWheelOverflow = 0

	for i = 1, AssistData19.MaxNum do
		if self:getCellSelect(i) then
			local cfg = self.cfgs[i]
			local isLimit = cfg.limitType ~= "none"
			local buyTimes = isLimit and PayShopModel.instance:getMibaoBuyTimesById(cfg.id) or 0

			if isLimit then
				if not cfg.limitTimes then
					local maxBuyTimes = AssistData19.MaxBuyNum
					local leftTimes = Mathf.Max(0, maxBuyTimes - buyTimes)
					local selectNum = self:getSelectNum(i)
					local realNum = Mathf.Min(leftTimes, selectNum)
					local matType, id, unitPrice = MaterialMgr.getMatParams(cfg.originalGoodsId)
					local str = matType .. ":" .. id

					if str == GameEnum.GoldType.PixieDust then
						curCostPixieDust = curCostPixieDust + realNum * unitPrice
					elseif str == GameEnum.GoldType.TimeWheelOverflow then
						curCostTimeWheelOverflow = curCostTimeWheelOverflow + realNum * unitPrice
					end
				end
			end
		end
	end

	return curCostPixieDust, curCostTimeWheelOverflow
end

return AssistData19
