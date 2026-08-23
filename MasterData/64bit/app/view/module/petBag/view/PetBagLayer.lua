local var_0_0 = g.core.model.User.petsData
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.const.ConstMgr
local PetBagLayer = class("PetBagLayer", require("app.fairyGUI.petBag.UI_PetBagLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/petBag/petBag",
		resName = "PetBagLayer",
		pkgName = "petBag"
	})
end)

function PetBagLayer:ctor()
	self._allPetList = {}
	self._canOwnPetList = {}
	self._notOwnPetList = {}
	self._petInfoDict = {
		emptyCardNum = 0,
		isEmpty = true,
		notOwnCardStartIndex = 0,
		notOwnNum = 0,
		petNum = 0,
		ownNum = 0,
		canComposeCardStartIndex = 0,
		lineIndex = 0
	}
	self._rawNum = self.m_cardList:getColumnCount()

	self:_initView()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(var_0_2.FUNCTION_TYPE.PET_BAG)
end

function PetBagLayer:_initView()
	self:addBg("bg/knightbag/pic_yht_beibao.jpg")
	self.m_topBarComp:setResInfoById(188)
	self.m_cardList:setVirtual()
	self.m_cardList:doFairyBatching(false)
	self.m_cardList:setItemProvider(handler(self, self._setCardListItemProvider))
	self.m_cardList:setItemRenderer(handler(self, self._onCardItemRenderer))
	self.m_rebornBtn:addClickListener(handler(self, self._onRebornBtnClicked))
	self.m_sellBtn:addClickListener(handler(self, self._onSellBtnClicked))
	self.m_petBookBtn:addClickListener(handler(self, self._onPetBookClicked))
	self.m_lineUpBtn:addClickListener(handler(self, self._onLineUpClicked))
end

function PetBagLayer:_updateView()
	self:_updatePetLists()
	self:_setPetInfoDict()
	self.m_numText:setText(self._petInfoDict.ownNum)
	self.m_maxNumText:setText("/" .. self._petInfoDict.petNum)
	self.m_cardList:setNumItems(self._petInfoDict.cardNum)
	self.m_cardList:transitionShowCells("listCardAUiScaleIn", 0.1)
	self.m_cardList:scrollToView(0)
end

function PetBagLayer:_setCardListItemProvider(arg_5_1)
	local var_5_1 = self._petInfoDict

	return (arg_5_1 < self._petInfoDict.ownNum or arg_5_1 >= var_5_1.notOwnCardStartIndex) and "ui://petBag/BasePetCardComp" or arg_5_1 == var_5_1.lineIndex and "ui://petBag/PetBagLineCell" or arg_5_1 > var_5_1.lineIndex and arg_5_1 < var_5_1.notOwnCardStartIndex and "ui://petBag/PetBagEmptyLineCell" or "ui://petBag/PetBagEmptyCardCell"
end

function PetBagLayer:_onCardItemRenderer(arg_6_1, arg_6_2)
	local var_6_0

	if arg_6_1 < self._petInfoDict.ownNum then
		var_6_0 = self._canOwnPetList[arg_6_1 + 1]
	elseif arg_6_1 >= self._petInfoDict.notOwnCardStartIndex then
		var_6_0 = self._notOwnPetList[arg_6_1 - self._petInfoDict.notOwnCardStartIndex + 1]
	end

	if var_6_0 then
		arg_6_2:updateCell(var_6_0)
	end
end

function PetBagLayer:_onRebornBtnClicked()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_2.FUNCTION_TYPE.REBORN) then
		var_0_1:pushModule(g.view.entrance.REBORN, {
			index = require("app.view.module.reborn.const.RebornConst").SELECT_INDEX_MAP.PET,
			title = g.core.lang:get(103034)
		})
	end
end

function PetBagLayer:_onSellBtnClicked()
	g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.FragSellPop").new(var_0_0:getCanSellPetFragDataArr(), {
		fragNameId = 205538,
		qualityArr = g.core.const.ConstMgr.QUALITY_TYPE.SELL_POP_QUALITY_ARRAY[g.core.const.ConstMgr.QUALITY_TYPE.NEW_QUALITY_CTRL.PET],
		title = g.core.lang:get(103039),
		emptyTitle = g.core.lang:get(103038)
	})))
end

function PetBagLayer:_onPetBookClicked()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_2.FUNCTION_TYPE.HOME_LAND_MAIN) and g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_2.FUNCTION_TYPE.HOME_LAND_SHOWROOM) and g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_2.FUNCTION_TYPE.PET_HANDBOOK) then
		var_0_1:pushModule(g.view.entrance.PET_BOOK)
	end
end

function PetBagLayer:_onLineUpClicked()
	var_0_1:pushModule(g.view.entrance.FORMATION, {
		title = g.core.lang:get(103034)
	})
end

function PetBagLayer:_onFragmentCompose(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self:_updatePetLists()
	self:_setPetInfoDict()
	self:_updateView()

	if not arg_11_4.id then
		return
	end

	var_0_1:pushPopup(require("app.view.base.infoPop.PetShowTimePop").new({
		justShow = true,
		awards = {
			{
				isNew = true,
				value = arg_11_4.id
			}
		}
	}), {
		withoutAni = true
	})
end

function PetBagLayer:_updatePetLists()
	self._canOwnPetList = var_0_0:getPetArrByFilter(function(arg_13_0)
		return arg_13_0:isComposeEnable() or arg_13_0:isOwn()
	end) or {}

	if #self._canOwnPetList > 1 then
		table.sort(self._canOwnPetList, var_0_0:getSortFunc())
	end

	self._notOwnPetList = var_0_0:getPetArrByFilter(function(arg_14_0)
		return not arg_14_0:isComposeEnable() and not arg_14_0:isOwn()
	end)

	if #self._notOwnPetList > 1 then
		table.sort(self._notOwnPetList, var_0_0:getSortFunc())
	end

	self._allPetList = var_0_0:getPetArrByFilter() or {}

	if #self._allPetList then
		table.sort(self._allPetList, var_0_0:getSortFunc())
	end
end

function PetBagLayer:_setPetInfoDict()
	self._petInfoDict.ownNum = #self._canOwnPetList
	self._petInfoDict.petNum = #self._allPetList
	self._petInfoDict.isEmpty = self._petInfoDict.ownNum == 0
	self._petInfoDict.emptyCardNum = self._rawNum - self._petInfoDict.ownNum % self._rawNum

	if self._petInfoDict.emptyCardNum == self._rawNum then
		self._petInfoDict.emptyCardNum = 0
	end

	self._petInfoDict.lineIndex = self._petInfoDict.ownNum + self._petInfoDict.emptyCardNum
	self._petInfoDict.notOwnCardStartIndex = self._petInfoDict.lineIndex + self._rawNum
	self._petInfoDict.notOwnNum = self._petInfoDict.petNum - self._petInfoDict.ownNum
	self._petInfoDict.cardNum = self._petInfoDict.notOwnNum > 0 and self._petInfoDict.notOwnCardStartIndex + self._petInfoDict.notOwnNum or self._petInfoDict.ownNum
end

function PetBagLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRAGMENT_COMPOSE, handler(self, self._onFragmentCompose), self)
	self:_updateView()
end

function PetBagLayer:onUnload()
	for iter_17_0, iter_17_1 in pairs(self._allPetList) do
		if iter_17_1:isOwn() then
			iter_17_1:setIsNewPet()
		end
	end

	self._allPetList = {}
end

return PetBagLayer
