-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/filter/BagPetTopFilterView.lua

module("logic.extensions.bag.view.filter.BagPetTopFilterView", package.seeall)

local BagPetTopFilterView = class("BagPetTopFilterView")

function BagPetTopFilterView:ctor()
	return
end

function BagPetTopFilterView:initGoParams(filterType, view, btnAttr, btnSort, inputTxt, btnClear)
	self.filterType = filterType
	self._Btn_Attr = btnAttr
	self._sortButton = btnSort
	self._InputC_Search = inputTxt
	self.btnClear = btnClear
	self.view = view
	self._SearchText = nil
end

function BagPetTopFilterView:initCallBack(rankOverCallBack)
	self.rankOverCallBack = rankOverCallBack
	self._SearchText = nil
end

function BagPetTopFilterView:reloadData(petList)
	self.petList = petList

	self:refreshPetList()
end

function BagPetTopFilterView:refreshPetList()
	self._curPetMap = {}

	self:_setCurViewDatas()
	self:rankNow()
end

function BagPetTopFilterView:rankNow()
	local names, opt = BagModel.instance:GetSortParms(function(petMo)
		return false
	end)

	ArraySort.sortOn(self._curViewDatas, names, opt)
	GameUtil.callBack(self.rankOverCallBack, self._curViewDatas)
end

function BagPetTopFilterView:bindEvents()
	if self._Btn_Attr then
		GameUtil.asBtn(self._Btn_Attr):AddClickListener(self._OnClickAttr, self)
	end

	if self.btnClear then
		GameUtil.asBtn(self.btnClear):AddClickListener(self._clearSearch, self)
	end

	if self._sortButton then
		self._sortButton:AddClickListener(self._onClickSort, self)
	end

	if self._InputC_Search then
		self._onInputSearchValueChangedHandler = InputFieldValueChangedHandler.Get(self._InputC_Search.gameObject):AddLuaHandler(function(go, text)
			self:_OnSearchTextChanged(text)
		end)
	end
end

function BagPetTopFilterView:unbindEvents()
	if self._InputC_Search then
		InputFieldValueChangedHandler.Get(self._InputC_Search.gameObject):RemoveLuaHandler(self._onInputSearchValueChangedHandler)
	end

	if self.btnClear then
		GameUtil.asBtn(self.btnClear):RemoveClickListener()
	end

	if self._sortButton then
		self._sortButton:RemoveClickListener()
	end

	if self._Btn_Attr then
		GameUtil.asBtn(self._Btn_Attr):RemoveClickListener()
	end
end

function BagPetTopFilterView:_onClickSort()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._sortButton.gameObject)
	local arr = BagModel.instance:GetSortState()

	UIStateManager.instance:open(ViewName.PetSortPaneView, pos, sizeDelta, self.view, arr, GameUtil.handler(self._RefreshPetSort, self))
end

function BagPetTopFilterView:_RefreshPetSort(idx, onResetCallback)
	BagModel.instance:SetNextSort(idx)
	GameUtil.callBack(onResetCallback, BagModel.instance:GetSortState())
	self:rankNow()
end

function BagPetTopFilterView:_OnClickAttr()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._Btn_Attr.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self.view, self.filterType, pos, sizeDelta, GameUtil.handler(self._updateFilterData, self))
end

function BagPetTopFilterView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	local viewPos = uiCamera:ScreenToViewportPoint(pos)

	if viewPos.x < 0.5 and viewPos.y < 0.5 then
		pos.x = pos.x - 100
		pos.y = pos.y + 120
	end

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function BagPetTopFilterView:_updateFilterData(starList, jobList, rareList)
	self:refreshPetList()
end

function BagPetTopFilterView:_setCurViewDatas()
	self._curViewDatas = {}

	if not self.petList then
		for k, v in pairs(self.petList) do
			self._curPetMap[v.petId] = v

			if self:_onFilter(v) then
				self._curViewDatas[#self._curViewDatas + 1] = v
			end
		end
	end
end

function BagPetTopFilterView:_clearSearch()
	self._InputC_Search.text = ""
end

function BagPetTopFilterView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(self.filterType, cfg, rare, skinId)
end

function BagPetTopFilterView:_onFilter(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)
	local isHit = false

	isHit = self:_isMatch(petCo, pet.rare, pet.curFaceId)

	if not string.nilorempty(self._SearchText) then
		local str = StringUtil.RelpaceEscapeChar(self._SearchText)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return isHit
end

function BagPetTopFilterView:_OnSearchTextChanged(text)
	if text ~= self._SearchText then
		self._SearchText = text

		self:refreshPetList()
	end
end

return BagPetTopFilterView
