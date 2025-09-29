-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingExchangeFacilityEnsureView.lua

module("logic.extensions.livingfacilities.view.LivingExchangeFacilityEnsureView", package.seeall)

local M = class("LivingExchangeFacilityEnsureView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._heroItemList = {}
end

function M:buildUI()
	self._btnClose = self:getBtn("living_exchange_facility_dorm_tips_1377244670")
	self._btnCancel = self:getBtn("living_exchange_facility_dorm_tips_-222932111")
	self._btnEnsure = self:getBtn("living_exchange_facility_dorm_tips_-1082397828")
	self._txtTips1 = self:getText("living_exchange_facility_dorm_tips_1337508877")
	self._txtTips2 = self:getText("living_exchange_facility_dorm_tips_-175833603")
	self._goHeroContent = self:getGo("living_exchange_facility_dorm_tips_-663249966")
	self._goFragmentContent = self:getGo("living_exchange_facility_dorm_tips_277176951")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnCancel:AddClickListener(self._onClickBtnCancel, self)
	self._btnEnsure:AddClickListener(self._onClickBtnEnsure, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnEnsure:RemoveClickListener()
end

function M:onEnter()
	self._zoneMO = LivingFacilitiesZoneController.instance:getCurrentZoneMo()
	self._exchangeType = self:getFirstParam()

	table.clear(self._heroItemList)
	self:refreshView()
end

function M:onExit()
	for _, heroItem in ipairs(self._heroItemList) do
		heroItem:destroy()
	end

	table.clear(self._heroItemList)
end

function M:refreshView()
	goutil.setActive(self._txtTips1.gameObject, false)
	goutil.setActive(self._txtTips2.gameObject, false)
	goutil.setActive(self._goHeroContent, false)
	goutil.setActive(self._goFragmentContent, false)

	local type = self._zoneMO:getType()

	if HouseSceneUtil.isDormitoryRoom(type) then
		local members = self._zoneMO:getRoomMember()

		if type == HouseEnum.LivingRoomType.SpecialDormitory then
			local productList = self._zoneMO:getProductList()

			if #members > 0 and #productList > 0 then
				self:_setText1("1." .. lang("tip_living_room_exchange_lang_3"))
				self:_setFragments("2." .. lang("tip_living_room_exchange_lang_6"), productList)
				self:_setHeros("3." .. lang("tip_living_room_exchange_lang_5"), members)
			elseif #members > 0 and #productList == 0 then
				self:_setText1("1." .. lang("tip_living_room_exchange_lang_3"))
				self:_setText2("2." .. lang("tip_living_room_exchange_lang_4"))
				self:_setHeros("3." .. lang("tip_living_room_exchange_lang_5"), members)
			elseif #members == 0 and #productList > 0 then
				self:_setText1("1." .. lang("tip_living_room_exchange_lang_3"))
				self:_setFragments("2." .. lang("tip_living_room_exchange_lang_6"), productList)
			else
				self:_setText1("1." .. lang("tip_living_room_exchange_lang_3"))
				self:_setText2("2." .. lang("tip_living_room_exchange_lang_4"))
			end
		elseif #members > 0 then
			self:_setText1("1." .. lang("tip_living_room_exchange_lang_3"))
			self:_setHeros("2." .. lang("tip_living_room_exchange_lang_5"), members)
		else
			self:_setText1(lang("tip_living_room_exchange_lang_3"))
		end
	else
		self:_setText1(lang("tip_living_room_exchange_lang_3"))
	end
end

function M:_setText1(txtStr)
	goutil.setActive(self._txtTips1.gameObject, true)

	self._txtTips1.text = txtStr
end

function M:_setText2(txtStr)
	goutil.setActive(self._txtTips2.gameObject, true)

	self._txtTips2.text = txtStr
end

function M:_setHeros(txtStr, heroList)
	goutil.setActive(self._goHeroContent, true)

	local txt = goutil.findChildTextComponent(self._goHeroContent, "txt")

	txt.text = txtStr

	local root = goutil.findChild(self._goHeroContent, "items")

	goutil.clearChildren(root)

	self._heroItemList = {}

	for _, heroId in ipairs(heroList) do
		local itemGO = self:getResInstance(ViewlibResPath.HeroHeadItem)

		goutil.addChildToParent(itemGO, root)

		local heroItem = Astral.LuaComponentContainer.Add(itemGO, HeroHeadItem)
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

		if heroMO then
			heroItem:setHeroMO(heroMO)
		end

		table.insert(self._heroItemList, heroItem)
	end
end

function M:_setFragments(txtStr, productList)
	goutil.setActive(self._goFragmentContent, true)

	local txt = goutil.findChildTextComponent(self._goFragmentContent, "txt")

	txt.text = txtStr

	local root = goutil.findChild(self._goFragmentContent, "items")

	goutil.clearChildren(root)

	for _, product in ipairs(productList) do
		local itemGO = self:getResInstance(ResName.Common_Backpack_Item)

		goutil.addChildToParent(itemGO, root)

		local item = Astral.LuaComponentContainer.Add(itemGO, ItemCell)
		local itemData = ItemData.New({
			itemId = product.fragmentId,
			count = product.count
		})

		item:updateData(itemData)
	end
end

function M:_onClickBtnClose()
	self:close()
end

function M:_onClickBtnCancel()
	self:close()
end

function M:_onClickBtnEnsure()
	LivingFacilitiesAgent.instance:sendChangeZoneTypeRequest(self._zoneMO:getId(), self._exchangeType)
	self:close()
end

return M
