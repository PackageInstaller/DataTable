-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell10.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell10", package.seeall)

local AssistCell10 = class("AssistCell10", BaseAssistCell)

function AssistCell10:ctor(luaComponentContainer)
	AssistCell10.super.ctor(self, luaComponentContainer)

	self._txt5 = MaterialMgr.findGraphicText(self._parentGo, string.format("%s/txt5", self._name))
	self._txt6 = MaterialMgr.findGraphicText(self._parentGo, string.format("%s/txt6", self._name))
	self._txt7 = goutil.findChildTextComponent(self._parentGo, string.format("%s/txt7", self._name))
	self._inputField = Framework.InputFieldAdapter.GetFrom(self._parentGo, string.format("%s/inputField", self._name))
	self._Placeholder = goutil.findChildTextComponent(self._parentGo, string.format("%s/inputField/Placeholder", self._name))
end

function AssistCell10:reset()
	AssistCell10.super.reset(self)
	self._inputField:RemoveOnEndEdit()
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoAssistantRefreshCoin, self._refreshCostShow, self)
end

function AssistCell10:init(data)
	AssistCell10.super.init(self, data)
	self._inputField:AddOnEndEdit(self._onEndEdit, self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoAssistantRefreshCoin, self._refreshCostShow, self)

	self._assistCellData = self._data:getAssistCellData()
	self._donateTimes = 0
	self._realMaxDonateCount = 0
	self._familylvMaxDonateCount = 0

	self:_refreshCostCoin()

	self._inputField.input.text = ""
	self._Placeholder.text = checknumber(self._assistCellData.localDonateCount)

	if self._assistCellData.localDonateCount <= self._realMaxDonateCount then
		self._assistCellData.donateCount = self._assistCellData.localDonateCount or self._realMaxDonateCount
	end

	self._assistCellData.donateTimes = self._donateTimes

	if self._isOpenFamily then
		self._txt7.text = "/" .. self._realMaxDonateCount or "/" .. 0
	end
end

function AssistCell10:_selectAll()
	return
end

function AssistCell10:_cancelAll()
	return
end

function AssistCell10:_onClickAll()
	AssistCell10.super._onClickAll(self)
	self:_dispatchRefreshCostShow()
end

function AssistCell10:_refreshCostCoin()
	self._cfgDonateList = FamilyConfig.instance:getDonateList()

	local coinItemStr = self._cfgDonateList[1].donateResource
	local diamondItemStr = self._cfgDonateList[#self._cfgDonateList].donateResource
	local curHasCoinNum = MaterialMgr.getMatCount(coinItemStr)
	local curHasDiamondNum = MaterialMgr.getMatCount(diamondItemStr)
	local coinMatType, coinId = MaterialMgr.getMatParams(coinItemStr)
	local diamondMatType, diamondId = MaterialMgr.getMatParams(diamondItemStr)

	self._coinMatType, self._coinId = coinMatType, coinId
	self._diamondMatType, self._diamondId = diamondMatType, diamondId
	self._isOpenFamily = FamilyController.instance:checkFamilyOpen()
	self._donateInfo = FamilyModel.instance:getDonateInfo()

	if self._isOpenFamily and self._donateInfo then
		local infos = {}

		if self._donateInfo and self._donateInfo.infos then
			infos = self._donateInfo.infos
		end

		local poolCfg = FamilyConfig.instance:getDonatePoolCfg(checknumber(infos.poolFamilyLevel))

		self._donateTimes = checknumber(infos.donateTimes)

		local familyInfo = FamilyModel.instance:getMyFamilyInfo()
		local level, curVal, needVal, isMaxLv = FamilyConfig.instance:getCurLvProgress(familyInfo.score)
		local curPoolCfg = FamilyConfig.instance:getDonatePoolCfg(level)

		self._familylvMaxDonateCount = curPoolCfg.maxDonateTimes

		local startIndex = self._donateTimes + 1
		local curNeedCoinNum = 0
		local curNeedDiamondNum = 0

		self._realMaxDonateCount = self._familylvMaxDonateCount - self._donateTimes

		if self._assistCellData.localDonateCount <= self._realMaxDonateCount then
			if not self._assistCellData.localDonateCount then
				local tempCount = self._realMaxDonateCount
				local endIndex = self._donateTimes + tempCount

				for i, v in ipairs(self._cfgDonateList) do
					if startIndex <= i and i <= endIndex then
						local matType, id, num = MaterialMgr.getMatParams(v.donateResource)

						if matType == coinMatType and id == coinId then
							curNeedCoinNum = curNeedCoinNum + num
						elseif matType == diamondMatType and id == diamondId then
							curNeedDiamondNum = curNeedDiamondNum + num
						end
					end
				end

				XiaoNuoAssistCostModel.instance:setCoin(self._data:getFuncIndex(), MaterialMgr.createSerName(self._coinMatType, self._coinId), curNeedCoinNum)
				XiaoNuoAssistCostModel.instance:setCoin(self._data:getFuncIndex(), MaterialMgr.createSerName(self._diamondMatType, self._diamondId), curNeedDiamondNum)
				self:_updateCoins(MaterialMgr.createSerName(coinMatType, coinId, curNeedCoinNum), MaterialMgr.createSerName(diamondMatType, diamondId, curNeedDiamondNum))
			end
		end
	else
		self._familylvMaxDonateCount = 0

		XiaoNuoAssistCostModel.instance:setCoin(self._data:getFuncIndex(), MaterialMgr.createSerName(self._coinMatType, self._coinId), 0)
		XiaoNuoAssistCostModel.instance:setCoin(self._data:getFuncIndex(), MaterialMgr.createSerName(self._diamondMatType, self._diamondId), 0)
		self:_updateCoins(MaterialMgr.createSerName(coinMatType, coinId, 0), MaterialMgr.createSerName(diamondMatType, diamondId, 0))
	end
end

function AssistCell10:_onEndEdit(inputStr)
	local num = checknumber(inputStr)

	if num >= 0 and num <= self._familylvMaxDonateCount then
		-- block empty
	else
		FloatWordMgr.instance:show(string.format("最大可捐献%d次", self._familylvMaxDonateCount))

		num = Mathf.Clamp(num, 0, self._familylvMaxDonateCount)
	end

	if string.nilorempty(inputStr) then
		num = self._assistCellData.localDonateCount
	end

	self._assistCellData.donateCount = Mathf.Min(num, self._realMaxDonateCount)
	self._assistCellData.localDonateCount = num
	self._inputField.input.text = ""
	self._Placeholder.text = checknumber(self._assistCellData.localDonateCount)

	self._data:setCellData(self._data._keyInputNum1, num)
	self:_dispatchRefreshCostShow()
end

function AssistCell10:_updateCoins(needCoinStr, needDiamondStr)
	local coinMatType, coinId, coinNum = MaterialMgr.getMatParams(needCoinStr)
	local diamondMatType, diamondId, diamondNum = MaterialMgr.getMatParams(needDiamondStr)
	local curHasCoinNum = MaterialMgr.getMatCount(needCoinStr)
	local curHasDiamondNum = MaterialMgr.getMatCount(needDiamondStr)
	local curNeedCoinNum = XiaoNuoAssistCostModel.instance:getTotalCoin(self._data:getFuncIndex(), MaterialMgr.createSerName(self._coinMatType, self._coinId))
	local curNeedDiamondNum = XiaoNuoAssistCostModel.instance:getTotalCoin(self._data:getFuncIndex(), MaterialMgr.createSerName(self._diamondMatType, self._diamondId))

	if curNeedCoinNum <= curHasCoinNum then
		if not XiaoNuoAssistantModel.CostColor then
			local coinColorStr = ColorConst.Red

			self._txt5.text = string.format("<quad name=%d:%d|icon size=25 width=1 offsetY=-5/> x <color=#%s>%d</color>", coinMatType, coinId, coinColorStr, coinNum)
			self._txt5.text = self._txt5.text .. " "

			if curNeedDiamondNum <= curHasDiamondNum then
				if not XiaoNuoAssistantModel.CostColor then
					local diamondColorStr = ColorConst.Red

					self._txt6.text = string.format("<quad name=%d:%d|icon size=25 width=1 offsetY=-5/> x <color=#%s>%d</color>", diamondMatType, diamondId, diamondColorStr, diamondNum)
					self._txt6.text = self._txt6.text .. " "
				end
			end
		end
	end
end

function AssistCell10:_refreshCostShow(tabId)
	if self._data:getTabIndex() == tabId then
		self:_refreshCostCoin()
	end
end

return AssistCell10
