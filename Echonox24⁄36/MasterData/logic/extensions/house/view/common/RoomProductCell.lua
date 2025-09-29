-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/common/RoomProductCell.lua

module("logic.extensions.house.view.common.RoomProductCell", package.seeall)

local M = class("RoomProductCell")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	self:_buildUI()
end

function M:OnDestroy()
	self:unbindEvents()

	self._clickMaterialCallback = nil
	self._clickMaterialHandler = nil
	self._btnAddCallback = nil
	self._btnAddHandler = nil
	self._btnSpeedUpCallback = nil
	self._btnSpeedUpHandler = nil
	self._btnGetCallback = nil
	self._btnGetHandler = nil
	self._btnExchangeCallback = nil
	self._btnExchangeHandler = nil
end

function M:_buildUI()
	self._goNormalRoot = goutil.findChild(self._mainGO, "normal")
	self._goLockRoot = goutil.findChild(self._mainGO, "lock")
	self._txtLock = goutil.findChildTextComponent(self._goLockRoot, "Text")
	self._txtLock.text = ""
	self._txtStore = goutil.findChildTextComponent(self._goNormalRoot, "txtNum1")
	self._txtStore.text = ""
	self._goMaterialRoot = goutil.findChild(self._goNormalRoot, "normal")
	self._txtMaterialName = goutil.findChildTextComponent(self._goMaterialRoot, "txtName")
	self._txtMaterialName.text = ""
	self._imgIcon = goutil.findChildImageComponent(self._goMaterialRoot, "imgIcon")
	self._imgQuality = goutil.findChildImageComponent(self._goMaterialRoot, "imgQuality")
	self._goNoPlanRoot = goutil.findChild(self._goNormalRoot, "none")
	self._goProgressRoot = goutil.findChild(self._goNormalRoot, "time")
	self._imgProgress = goutil.findChildImageComponent(self._goProgressRoot, "imgSlider")
	self._txtRemainTime = goutil.findChildTextComponent(self._goNormalRoot, "txtTime")
	self._txtRemainTime.text = ""
	self._btnAdd = UIComponentType.ButtonAdapter(goutil.findChild(self._goNormalRoot, "btnAdded"))

	goutil.setActive(self._btnAdd.gameObject, false)

	self._btnSpeedUp = UIComponentType.ButtonAdapter(goutil.findChild(self._goNormalRoot, "btnSpeedUp"))

	goutil.setActive(self._btnSpeedUp.gameObject, false)

	self._btnGet = UIComponentType.ButtonAdapter(goutil.findChild(self._goNormalRoot, "btnGet"))

	goutil.setActive(self._btnGet.gameObject, false)

	self._goDoing = goutil.findChild(self._goNormalRoot, "doing")
	self._btnExchange = UIComponentType.ButtonAdapter(goutil.findChild(self._goNormalRoot, "btnExchange"))

	goutil.setActive(self._btnExchange.gameObject, false)
	self:bindEvents()
end

function M:bindEvents()
	self._btnAdd:AddClickListener(self._onClickBtnAdd, self)
	self._btnSpeedUp:AddClickListener(self._onClickBtnSpeedUp, self)
	self._btnGet:AddClickListener(self._onClickBtnGet, self)
	self._btnExchange:AddClickListener(self._onClickBtnExchange, self)
end

function M:unbindEvents()
	self._btnAdd:RemoveClickListener()
	self._btnSpeedUp:RemoveClickListener()
	self._btnGet:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
end

function M:setClickMaterialCallback(callback, handler)
	self._clickMaterialCallback = callback
	self._clickMaterialHandler = handler
end

function M:setBtnAddCallback(callback, handler)
	self._btnAddCallback = callback
	self._btnAddHandler = handler
end

function M:setBtnSpeedUpCallback(callback, handler)
	self._btnSpeedUpCallback = callback
	self._btnSpeedUpHandler = handler
end

function M:setBtnGetCallback(callback, handler)
	self._btnGetCallback = callback
	self._btnGetHandler = handler
end

function M:setBtnExchangeCallback(callback, handler)
	self._btnExchangeCallback = callback
	self._btnExchangeHandler = handler
end

function M:setLock(isLock)
	goutil.setActive(self._goNormalRoot, not isLock)
	goutil.setActive(self._goLockRoot, isLock)
end

function M:setNoPlan(isNoPlan)
	goutil.setActive(self._goNoPlanRoot, isNoPlan)
	goutil.setActive(self._goMaterialRoot, not isNoPlan)
	goutil.setActive(self._goProgressRoot, not isNoPlan)
	goutil.setActive(self._btnAdd.gameObject, isNoPlan)
end

function M:setBtnSpeedUpVisible(visible)
	goutil.setActive(self._btnSpeedUp.gameObject, visible)
end

function M:setBtnGetVisible(visible)
	goutil.setActive(self._btnGet.gameObject, visible)
end

function M:setDoing(visible)
	goutil.setActive(self._goDoing, visible)
end

function M:setBtnExchangeVisible(visible)
	goutil.setActive(self._btnExchange.gameObject, visible)
end

function M:setLockText(lockStr)
	self._txtLock.text = lockStr
end

function M:setStore(curNum, totalNum)
	local colorStr = totalNum <= curNum and "#BF4146" or "#FFFFFF"

	self._txtStore.text = string.format("<color=%s>%s</color>/%s", colorStr, curNum, totalNum)
end

function M:setMaterial(itemId)
	if itemId then
		goutil.setActive(self._goMaterialRoot, true)

		local itemData = ItemData.New({
			itemId = itemId
		})

		IconLoader.setSpriteByItemType(self._imgIcon, itemData:getType(), itemData:getIcon())
		IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_Room, CommEnum.Quality2HouseProductBg[itemData:getQuality()])

		self._txtMaterialName.text = itemData:getName()
	else
		goutil.setActive(self._goMaterialRoot, false)
	end
end

function M:setProgress(progress, remainTime)
	self._imgProgress.fillAmount = progress

	if remainTime < 0 then
		self._txtRemainTime.text = ""
	else
		local timeStr = TimeUtil.instance:numberToTime(remainTime, "h:m:s")

		self._txtRemainTime.text = timeStr

		local colorStr = remainTime == 0 and "#BF4146" or "#FFFFFF"

		self._txtRemainTime.color = parsecolor(colorStr)
	end
end

function M:_onClickMaterialItem()
	if self._clickMaterialCallback then
		self._clickMaterialCallback(self._clickMaterialHandler, self)
	end
end

function M:_onClickBtnAdd()
	if self._btnAddCallback then
		self._btnAddCallback(self._btnAddHandler, self)
	end
end

function M:_onClickBtnSpeedUp()
	if self._btnSpeedUpCallback then
		self._btnSpeedUpCallback(self._btnSpeedUpHandler, self)
	end
end

function M:_onClickBtnGet()
	if self._btnGetCallback then
		self._btnGetCallback(self._btnGetHandler, self)
	end
end

function M:_onClickBtnExchange()
	if self._btnExchangeCallback then
		self._btnExchangeCallback(self._btnExchangeHandler, self)
	end
end

return M
