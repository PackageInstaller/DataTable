local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.common.Goods
local PetInfoLvUpComp = class("PetInfoLvUpComp", require("app.fairyGUI.pet.UI_PetInfoLvUpComp"))

function PetInfoLvUpComp:ctor()
	self._petStruct = nil
	self._expItemArr = {}

	self:_initExpItemArr()
	self.m_lvUpTitleLbl:addClickListener(handler(self, self._onClickLvUpTitle))
	self.m_upBtn_1:addClickListener(handler(self, self._onClickLevelUpBtn))
	self.m_upBtn_10:addClickListener(handler(self, self._onClickLevelUpBtn))
	self.m_propList:setVirtual()
	self.m_propList:setItemRenderer(handler(self, self._onPropListRenderer))
	self.m_propList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickPropListItem))
end

function PetInfoLvUpComp:updateComp(arg_2_1)
	self._petStruct = arg_2_1

	self:_updateExpItemNum()
	self.m_propList:setNumItems(#self._expItemArr)
end

function PetInfoLvUpComp:_onPropListRenderer(arg_3_1, arg_3_2)
	local var_3_0 = self._expItemArr[arg_3_1 + 1]

	var_3_0.scaleIndex = 3

	arg_3_2:updateIcon(var_3_0)
	arg_3_2:setCompGray(var_3_0.size == 0)
end

function PetInfoLvUpComp:_onClickPropListItem(arg_4_1)
	self:_openGotoPop(arg_4_1:getDataValue() + 1)
end

function PetInfoLvUpComp:_onClickLvUpTitle()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.pet.view.infoPop.PetLvAttrPop").new(self._petStruct), {
		touchDisappear = true
	})
end

function PetInfoLvUpComp:_onClickLevelUpBtn(arg_6_1)
	if not self:_canLevelUp() then
		return
	end

	local var_6_0 = g.core.network.GameNetProxy
	local var_6_1 = 1
	local var_6_2

	if arg_6_1:getSender() == self.m_upBtn_10 then
		var_6_1 = 10
		var_6_2 = {}
	end

	var_6_2.id = self._petStruct:getSid()
	var_6_2.level = var_6_1

	var_6_0:send_C2S_Pet_OneKey_LevelUp(var_6_2)
end

function PetInfoLvUpComp:_canLevelUp()
	if not self._petStruct then
		return false
	elseif self._petStruct:isCurMaxLevel() then
		g.core.module.ModuleManager:tip(g.core.lang:get(203001))

		return false
	elseif not self:_isThereExpItem() then
		self:_openGotoPop(1)

		return false
	end

	return true
end

function PetInfoLvUpComp:_initExpItemArr()
	for iter_8_0, iter_8_1 in ipairs((g.core.model.User.itemsData:getPetExpItemData())) do
		table.insert(self._expItemArr, {
			type = var_0_1.TYPE_ITEM,
			value = iter_8_1.id,
			size = iter_8_1.num
		})
	end
end

function PetInfoLvUpComp:_updateExpItemNum()
	for iter_9_0, iter_9_1 in ipairs(self._expItemArr) do
		iter_9_1.size = g.core.model.User.bagData:getCountById(var_0_0.BAG_TYPE.ITEM, iter_9_1.value)
	end
end

function PetInfoLvUpComp:_isThereExpItem()
	for iter_10_0, iter_10_1 in ipairs(self._expItemArr) do
		if iter_10_1.size > 0 then
			return true
		end
	end

	return false
end

function PetInfoLvUpComp:_openGotoPop(arg_11_1)
	g.view.entrance.ModuleGotoProxy:gotoModuleBySource((clone(self._expItemArr[arg_11_1])))
end

return PetInfoLvUpComp
