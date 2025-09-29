-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/defend/AirWorkLevelTabCell.lua

module("logic.extensions.airworkshop.view.defend.AirWorkLevelTabCell", package.seeall)

local M = class("AirWorkLevelTabCell", CellBaseComponent)
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._roleCompList = {}
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	self._contentGo = goutil.findChild(self._go, "content")
	self._nameTxt = goutil.findChildTextComponent(self._go, "content/unlock/txtLevelName")
	self._selectPosGo = goutil.findChild(self._go, "selectPos")
	self._normalPosGo = goutil.findChild(self._go, "normalPos")
	self._selectPanelGo = goutil.findChild(self._go, "content/unlock/imgSelect")
	self._lockGo = goutil.findChild(self._go, "content/lock")
	self._addGo = goutil.findChild(self._go, "content/unlock/imgAdd")
	self._idTxt = goutil.findChildTextComponent(self._go, "content/unlock/txtID")
	self._useGo = goutil.findChild(self._go, "content/unlock/txtUse")
	self._unlockGo = goutil.findChild(self._go, "content/unlock")
end

function M:setData(levelMo, index, selectIndex)
	self._levelMo = levelMo
	self._index = index
	self.__curSelectIndex = selectIndex

	self:_refreshCell()
end

function M:_refreshCell()
	local unlockCount = AirWorkMapModel.instance:getCurUnlockPlanCount()

	self._isUnlock = unlockCount >= self._index

	if self._levelMo then
		goutil.setActive(self._addGo, false)
		goutil.setActive(self._useGo, self._levelMo:getOnlineStatus())

		self._nameTxt.text = self._levelMo:getMapMO():getName()
	else
		goutil.setActive(self._useGo, false)
		goutil.setActive(self._addGo, self._isUnlock)
	end

	if self._curSelectIndex == self._index then
		Astral.TransformUtil.SetAnchoredPos(self._contentGo.transform, self._selectPosGo.transform.anchoredPosition.x, 0)
		goutil.setActive(self._selectPanelGo, true)
	else
		Astral.TransformUtil.SetAnchoredPos(self._contentGo.transform, self._normalPosGo.transform.anchoredPosition.x, 0)
		goutil.setActive(self._selectPanelGo, false)
	end

	goutil.setActive(self._lockGo, not self._isUnlock)
	goutil.setActive(self._unlockGo, self._isUnlock)
end

function M:_onClickHolidayBtn()
	return
end

return M
