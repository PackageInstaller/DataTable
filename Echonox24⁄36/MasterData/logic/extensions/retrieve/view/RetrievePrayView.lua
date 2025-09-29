-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrievePrayView.lua

module("logic.extensions.retrieve.view.RetrievePrayView", package.seeall)

local M = class("RetrievePrayView", ViewComponent)

function M:ctor()
	self._heroId = nil
	self._heroCO = nil
	self._heroData = nil
end

function M:buildUI()
	self._panelMainGo = self:getGo("retrieve_main_view_587430720")
	self._panelPrayGo = self:getGo("retrieve_main_view_-1260022511")
	self._roleCombatCell = Astral.SimpleLuaComponentContainer.Add(self:getGo("2&role_combat_-1916846192"), RoleCombatCell)
	self._txtSelectTipsGo = self:getGo("retrieve_main_view_-1554996632")
	self._wishLeftGo = self:getGo("retrieve_main_view_1500602055")
	self._wishRightGo = self:getGo("16&role_model_preview_detail_2003533041")
	self._detailComp = Astral.SimpleLuaComponentContainer.Add(self._wishRightGo, CharacterDetailComp)
	self._txtWishDesc = self:getUIComponent("retrieve_main_view_386998793", UIComponentType.TextMeshProUGUI)
	self._btnExplain = self:getBtn("retrieve_main_view_153094136")
	self._imgOpenGo = self:getGo("retrieve_main_view_1743309208")
	self._imgCloseGo = self:getGo("retrieve_main_view_-734475307")

	goutil.setActive(self._imgOpenGo, true)
	goutil.setActive(self._imgCloseGo, false)

	self._btnConfirm = self:getBtn("9&btn_middle_-31477526")
	self._txtSelectGo = self:getGo("retrieve_main_view_371071524")
	self._btnLast = self:getBtn("retrieve_main_view_264246138")
	self._btnNext = self:getBtn("retrieve_main_view_645086716")

	self:_initQuality()
end

function M:_initQuality()
	self._quality2Go = {
		[GameEnum.QualityEnum.S] = {
			self:getGo("retrieve_main_view_-1960546774"),
			self:getGo("retrieve_main_view_209595132")
		},
		[GameEnum.QualityEnum.A] = {
			self:getGo("retrieve_main_view_-1996018224"),
			self:getGo("retrieve_main_view_1537885791")
		},
		[GameEnum.QualityEnum.B] = {
			self:getGo("retrieve_main_view_1840145083"),
			self:getGo("retrieve_main_view_2079610869")
		},
		[GameEnum.QualityEnum.C] = {
			self:getGo("retrieve_main_view_1640346438"),
			self:getGo("retrieve_main_view_-1396206375")
		}
	}
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnExplain:AddClickListener(self._onClickExplain, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnLast:AddClickListener(self._onClickLast, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	RetrieveDispatcher:addEventListener(RetrieveEventType.LOTTERY_PICK_ITEM, self._onHandlePickItem, self)
end

function M:unbindEvents()
	self._btnExplain:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnLast:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	RetrieveDispatcher:removeEventListener(RetrieveEventType.LOTTERY_PICK_ITEM, self._onHandlePickItem, self)
end

function M:onEnter()
	return
end

function M:setPrayState(active)
	goutil.setActive(self._txtSelectTipsGo, active)
	goutil.setActive(self._wishLeftGo, not active)
	goutil.setActive(self._wishRightGo, not active)
	goutil.setActive(self._btnLast.gameObject, not active)
	goutil.setActive(self._btnNext.gameObject, not active)
end

function M:showPrayHeroInfo(heroId, lotteryData, callBack, callbackHandle)
	self._curPicked = heroId
	self._callback = callBack
	self._callbackHandle = callbackHandle
	self._lotteryData = lotteryData
	self._heroCodes = self._lotteryData:getCharacterCode()
	self._curHeroIndex = 1

	for i = 1, #self._heroCodes do
		if self._heroCodes[i] == heroId then
			self._curHeroIndex = i

			break
		end
	end

	self:refreshWishHero(heroId)
end

function M:refreshWishHero(heroId, loadHero)
	self:_onRefreshSelectState(heroId)
	RetrieveController.instance:activeWishCamera(self._curHeroIndex)

	self._heroId = heroId
	self._isExplain = false
	self._heroCO = CharacterConfig.instance:getCfgInfoByID(self._heroId)

	if self._heroCO == nil then
		printError("hero not found, id = " .. self._heroId)

		return
	end

	self._heroData = CharacterUtil.getPreviewHeroData(self._heroId)

	self:_refreshView()

	if #self._heroCodes == 1 then
		goutil.setActive(self._btnLast.gameObject, false)
		goutil.setActive(self._btnNext.gameObject, false)
	elseif #self._heroCodes == 2 then
		goutil.setActive(self._btnLast.gameObject, self._curHeroIndex ~= 1)
		goutil.setActive(self._btnNext.gameObject, self._curHeroIndex ~= 2)
	elseif #self._heroCodes == 3 then
		goutil.setActive(self._btnLast.gameObject, self._curHeroIndex ~= 1)
		goutil.setActive(self._btnNext.gameObject, self._curHeroIndex ~= 3)
	end

	if loadHero then
		RetrieveController.instance:showHeroByHeroId(heroId)
	end
end

function M:_refreshView()
	self:_refreshHeroInfo()
	self:_refreshWishDesc()
	CharacterPreviewModel.instance:setShowType(CharacterPreviewModel.PreviewType.MaxLevel)
	self._detailComp:setData(self._heroId, self._heroCO, self._heroData)
end

function M:_refreshHeroInfo()
	self._roleCombatCell:updateHeroData(self._heroData)

	local heroQuality = self._heroData:getQuality()

	for quality, goList in pairs(self._quality2Go) do
		local active = quality == heroQuality

		for _, go in ipairs(goList) do
			goutil.setActive(go, active)
		end
	end
end

function M:_refreshWishDesc()
	if self._isExplain then
		self._txtWishDesc.text = self._lotteryData:getSimpleWishDesc() .. self._lotteryData:getWishDesc()
	else
		self._txtWishDesc.text = self._lotteryData:getSimpleWishDesc()
	end
end

function M:_onClickConfirm()
	if self._lotteryData then
		if self._curPicked == 0 then
			FloatWordMgr.instance:show(lang("tip_wish_select_empty"))

			return
		end

		local lastPickItemId = self._lotteryData:getPicked()

		if self._curPicked == lastPickItemId then
			return
		end

		local poolCode = self._lotteryData:getPoolId()

		RetrieveAgent.instance:sendPickLotteryItemRequest(poolCode, self._curPicked)
	end

	if self._callback then
		self._callback(self._callbackHandle, self._curPicked)
	end
end

function M:_onHandlePickItem(evt, pool, item)
	if self._lotteryData then
		self._lotteryData:setPicked(item)
		self:_onRefreshSelectState(item)
	end
end

function M:_onRefreshSelectState(heroId)
	if self._lotteryData then
		local lastPickItemId = self._lotteryData:getPicked()

		goutil.setActive(self._btnConfirm.gameObject, heroId ~= lastPickItemId)
		goutil.setActive(self._txtSelectGo, heroId == lastPickItemId)
	end
end

function M:_onClickLast()
	if self._curHeroIndex > 1 then
		self._curHeroIndex = self._curHeroIndex - 1

		local heroId = self._heroCodes[self._curHeroIndex]

		self._curPicked = heroId

		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_shoumiren_character)
		self:refreshWishHero(heroId, true)
	end
end

function M:_onClickNext()
	if self._curHeroIndex < #self._heroCodes then
		self._curHeroIndex = self._curHeroIndex + 1

		local heroId = self._heroCodes[self._curHeroIndex]

		self._curPicked = heroId

		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_shoumiren_character)
		self:refreshWishHero(heroId, true)
	end
end

function M:_onClickExplain()
	self._isExplain = not self._isExplain

	self:_refreshWishDesc()
	goutil.setActive(self._imgOpenGo, not self._isExplain)
	goutil.setActive(self._imgCloseGo, self._isExplain)
end

function M:onExit()
	return
end

return M
