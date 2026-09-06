-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/cell/AssistCell16.lua

module("logic.extensions.xiaonuoassistant.view.cell.AssistCell16", package.seeall)

local AssistCell16 = class("AssistCell16", BaseAssistCell)

AssistCell16.Diamond = "105:2"
AssistCell16.GodGem = "204:2"

function AssistCell16:ctor(luaComponentContainer)
	AssistCell16.super.ctor(self, luaComponentContainer)

	self._btn1 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn1", self._name))
	self._btn2 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn2", self._name))
	self._btn3 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn3", self._name))
	self._btn4 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn4", self._name))
	self._btn5 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn5", self._name))
	self._btn6 = Framework.ButtonAdapter.GetFrom(self._parentGo, string.format("%s/btn6", self._name))
	self._markbtn1 = goutil.findChild(self._parentGo, string.format("%s/btn1/Background/Checkmark", self._name))
	self._markbtn2 = goutil.findChild(self._parentGo, string.format("%s/btn2/Background/Checkmark", self._name))
	self._markbtn3 = goutil.findChild(self._parentGo, string.format("%s/btn3/Background/Checkmark", self._name))
	self._markbtn4 = goutil.findChild(self._parentGo, string.format("%s/btn4/Background/Checkmark", self._name))
	self._markbtn5 = goutil.findChild(self._parentGo, string.format("%s/btn5/Background/Checkmark", self._name))
	self._markbtn6 = goutil.findChild(self._parentGo, string.format("%s/btn6/Background/Checkmark", self._name))
	self._txtLabel1 = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn1/Label", self._name))
	self._txtLabel2 = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn2/Label", self._name))
	self._txtLabel3 = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn3/Label", self._name))
	self._txtLabel4 = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn4/Label", self._name))
	self._txtLabel5 = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn5/Label", self._name))
	self._txtLabel6 = goutil.findChildTextComponent(self._parentGo, string.format("%s/btn6/Label", self._name))
	self._txt3 = MaterialMgr.findGraphicText(self._parentGo, string.format("%s/txt3", self._name))
	self._txt4 = MaterialMgr.findGraphicText(self._parentGo, string.format("%s/txt4", self._name))
end

function AssistCell16:reset()
	self._btn1:RemoveClickListener()
	self._btn2:RemoveClickListener()
	self._btn3:RemoveClickListener()
	self._btn4:RemoveClickListener()
	self._btn5:RemoveClickListener()
	self._btn6:RemoveClickListener()
end

function AssistCell16:init(data)
	AssistCell16.super.init(self, data)
	self._btn1:AddClickListener(self._onClickBtn1, self)
	self._btn2:AddClickListener(self._onClickBtn2, self)
	self._btn3:AddClickListener(self._onClickBtn3, self)
	self._btn4:AddClickListener(self._onClickBtn4, self)
	self._btn5:AddClickListener(self._onClickBtn5, self)
	self._btn6:AddClickListener(self._onClickBtn6, self)
	self:_setBtnIsOn1(self._data:getCellSelect(self._data.selectIndex1))
	self:_setBtnIsOn2(self._data:getCellSelect(self._data.selectIndex2))
	self:_setBtnIsOn3(self._data:getCellSelect(self._data.selectIndex3))
	self:_setBtnIsOn4(self._data:getCellSelect(self._data.selectIndex4))
	self:_setBtnIsOn5(self._data:getCellSelect(self._data.selectIndex5))
	self:_setBtnIsOn6(self._data:getCellSelect(self._data.selectIndex6))

	self._assistCellData = self._data:getAssistCellData()

	local cfg = self._data:getCfg()

	self._txt3.text = "<quad name=105:2|icon size=25 width=1 offsetY=-5/> * 0"
	self._txt4.text = "<quad name=204:2|icon size=25 width=1 offsetY=-5/> * 0"
	self._curHasDiamondNum = MaterialMgr.getMatCount(AssistCell16.Diamond)
	self._curHasGodGemNum = MaterialMgr.getMatCount(AssistCell16.GodGem)

	self:_updateAllCost()
	printInfo("test AssistCell16:init AssistCell16.ShopDefineIds", unpack(self._assistCellData.ShopDefineIds))
end

function AssistCell16:_selectAll()
	self._data:setCellSelect(self._data.selectIndex1, true)
	self._data:setCellSelect(self._data.selectIndex2, true)
	self._data:setCellSelect(self._data.selectIndex3, true)
	self._data:setCellSelect(self._data.selectIndex4, true)
	self._data:setCellSelect(self._data.selectIndex5, true)
	self._data:setCellSelect(self._data.selectIndex6, true)
	self:_setBtnIsOn1(true)
	self:_setBtnIsOn2(true)
	self:_setBtnIsOn3(true)
	self:_setBtnIsOn4(true)
	self:_setBtnIsOn5(true)
	self:_setBtnIsOn6(true)
	self:_updateAllCost()
end

function AssistCell16:_cancelAll()
	return
end

function AssistCell16:_onClickBtn1()
	local isOn = self._data:getCellSelect(self._data.selectIndex1)

	self._data:setCellSelect(self._data.selectIndex1, not isOn)
	self:_setBtnIsOn1(not isOn)
	self:_updateAllCost()
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell16:_onClickBtn2()
	local isOn = self._data:getCellSelect(self._data.selectIndex2)

	self._data:setCellSelect(self._data.selectIndex2, not isOn)
	self:_setBtnIsOn2(not isOn)
	self:_updateAllCost()
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell16:_onClickBtn3()
	local isOn = self._data:getCellSelect(self._data.selectIndex3)

	self._data:setCellSelect(self._data.selectIndex3, not isOn)
	self:_setBtnIsOn3(not isOn)
	self:_updateAllCost()
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell16:_onClickBtn4()
	local isOn = self._data:getCellSelect(self._data.selectIndex4)

	self._data:setCellSelect(self._data.selectIndex4, not isOn)
	self:_setBtnIsOn4(not isOn)
	self:_updateAllCost()
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell16:_onClickBtn5()
	local isOn = self._data:getCellSelect(self._data.selectIndex5)

	self._data:setCellSelect(self._data.selectIndex5, not isOn)
	self:_setBtnIsOn5(not isOn)
	self:_updateAllCost()
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell16:_onClickBtn6()
	local isOn = self._data:getCellSelect(self._data.selectIndex6)

	self._data:setCellSelect(self._data.selectIndex6, not isOn)
	self:_setBtnIsOn6(not isOn)
	self:_updateAllCost()
	GlobalDispatcher:dispatch(GlobalNotify.XiaoNuoAssistantClick)
end

function AssistCell16:_setBtnIsOn1(isOn)
	goutil.setActive(self._markbtn1, isOn)
end

function AssistCell16:_setBtnIsOn2(isOn)
	goutil.setActive(self._markbtn2, isOn)
end

function AssistCell16:_setBtnIsOn3(isOn)
	goutil.setActive(self._markbtn3, isOn)
end

function AssistCell16:_setBtnIsOn4(isOn)
	goutil.setActive(self._markbtn4, isOn)
end

function AssistCell16:_setBtnIsOn5(isOn)
	goutil.setActive(self._markbtn5, isOn)
end

function AssistCell16:_setBtnIsOn6(isOn)
	goutil.setActive(self._markbtn6, isOn)
end

function AssistCell16:_updateCostDiamondNum()
	self._curCostDiamondNum = 0
	self._curCostGodGemNum = 0

	local newCurCostDiamondNum = 0
	local newCurCostGemDiamondNum = 0

	if self._data:getCellSelect(self._data.selectIndex1) then
		local shopDefineId = self._assistCellData.ShopDefineIds[1]
		local maxBuyCount = self:_getMaxBuyCount(shopDefineId)
		local singlePrice = self:_getDiscountPrice(shopDefineId)
		local totalPrice = singlePrice * maxBuyCount

		newCurCostDiamondNum = newCurCostDiamondNum + totalPrice
	end

	if self._data:getCellSelect(self._data.selectIndex2) then
		local shopDefineId = self._assistCellData.ShopDefineIds[2]
		local maxBuyCount = self:_getMaxBuyCount(shopDefineId)
		local singlePrice = self:_getDiscountPrice(shopDefineId)
		local totalPrice = singlePrice * maxBuyCount

		newCurCostDiamondNum = newCurCostDiamondNum + totalPrice
	end

	if self._data:getCellSelect(self._data.selectIndex3) then
		local shopDefineId = self._assistCellData.ShopDefineIds[3]
		local maxBuyCount = self:_getMaxBuyCount(shopDefineId)
		local singlePrice = self:_getDiscountPrice(shopDefineId)
		local totalPrice = singlePrice * maxBuyCount

		newCurCostDiamondNum = newCurCostDiamondNum + totalPrice
	end

	if self._data:getCellSelect(self._data.selectIndex4) then
		local shopDefineId = self._assistCellData.ShopDefineIds[4]
		local maxBuyCount = self:_getMaxBuyCount(shopDefineId)
		local singlePrice = self:_getDiscountPrice(shopDefineId)
		local totalPrice = singlePrice * maxBuyCount

		newCurCostDiamondNum = newCurCostDiamondNum + totalPrice
	end

	if self._data:getCellSelect(self._data.selectIndex5) then
		local shopDefineId = self._assistCellData.ShopDefineIds[5]
		local maxBuyCount = self:_getMaxBuyCount(shopDefineId)
		local singlePrice = self:_getDiscountPrice(shopDefineId)
		local totalPrice = singlePrice * maxBuyCount

		newCurCostDiamondNum = newCurCostDiamondNum + totalPrice
	end

	self._curCostDiamondNum = newCurCostDiamondNum

	if self._data:getCellSelect(self._data.selectIndex6) then
		local shopDefineId = self._assistCellData.ShopDefineIds[6]
		local maxBuyCount = self:_getMaxBuyCount(shopDefineId)
		local singlePrice = self:_getDiscountPrice(shopDefineId)
		local totalPrice = singlePrice * maxBuyCount

		newCurCostGemDiamondNum = newCurCostGemDiamondNum + totalPrice
	end

	self._curCostGodGemNum = newCurCostGemDiamondNum
end

function AssistCell16:_getDiscountPrice(shopDefineId)
	return self._data:getDiscountPrice(shopDefineId)
end

function AssistCell16:_getMaxBuyCount(shopDefineId)
	return self._data:getMaxBuyCount(shopDefineId)
end

function AssistCell16:_updateAllCost()
	self:_updateCostDiamondNum()
	self:_updateTotalDiamondShow()
end

function AssistCell16:_updateTotalDiamondShow()
	printInfo("test AssistCell16:_updateTotalDiamondShow", self._curCostDiamondNum, self._curCostGodGemNum)
	XiaoNuoAssistCostModel.instance:setCoin(self._data:getFuncIndex(), AssistCell16.Diamond, self._curCostDiamondNum)
	XiaoNuoAssistCostModel.instance:setCoin(self._data:getFuncIndex(), AssistCell16.GodGem, self._curCostGodGemNum)

	local costTotalDiamond = XiaoNuoAssistCostModel.instance:getTotalCoin(self._data:getFuncIndex(), AssistCell16.Diamond)
	local costTotalGodGem = XiaoNuoAssistCostModel.instance:getTotalCoin(self._data:getFuncIndex(), AssistCell16.GodGem)

	if costTotalDiamond <= self._curHasDiamondNum then
		if not XiaoNuoAssistantModel.CostColor then
			local diamondColorStr = ColorConst.Red

			if costTotalGodGem <= self._curHasGodGemNum then
				if not XiaoNuoAssistantModel.CostColor then
					local godGemColorStr = ColorConst.Red

					self._txt3.text = string.format("<quad name=%s|icon size=25 width=1 offsetY=-5/> x <color=#%s>%d</color>", AssistCell16.Diamond, diamondColorStr, self._curCostDiamondNum)
					self._txt3.text = self._txt3.text .. " "
					self._txt4.text = string.format("<quad name=%s|icon size=25 width=1 offsetY=-5/> x <color=#%s>%d</color>", AssistCell16.GodGem, godGemColorStr, self._curCostGodGemNum)
					self._txt4.text = self._txt4.text .. " "
				end
			end
		end
	end
end

return AssistCell16
