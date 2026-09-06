-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessFmtRightView.lua

module("logic.extensions.autochess.view.AutochessFmtRightView", package.seeall)

local AutochessFmtRightView = class("AutochessFmtRightView", FormationRightView)

function AutochessFmtRightView:onEnter()
	goutil.setActive(self._tableCell, false)

	self._petInfoList = AutochessModel.instance:getPetInfoList()

	AutochessFmtRightView.super.onEnter(self)
	self.addGEvent(self, AutoChessAgent.ACNotifyAfterPetChangedRes, self._onACNotifyAfterPetChangedRes, self)
end

function AutochessFmtRightView:updateForbit(data)
	return
end

function AutochessFmtRightView:_getCurFormation()
	return AutochessModel.instance:getCurrFormation()
end

function AutochessFmtRightView:_initAllPetList()
	self._allPetList = AutochessModel.instance:getPetList()
end

function AutochessFmtRightView:_onACNotifyAfterPetChangedRes()
	self:onRefreshPetLis()
end

function AutochessFmtRightView:onFilter(pet)
	return true
end

function AutochessFmtRightView:_updateCell(view, cell, data)
	AutochessFmtRightView.super._updateCell(self, view, cell, data)

	local goExtpart = goutil.findChild(cell.gameObject, "extpart")
	local goStar = goutil.findChild(cell.gameObject, "extpart/star")

	goExtpart.transform:SetAsLastSibling()

	local starts = {}
	local star = self._petInfoList[data.raceId]

	for i = 1, AutochessController.MaxStarNum do
		starts[i] = goutil.findChild(goStar, "star" .. i)

		goutil.setActive(starts[i], i <= star)
	end
end

function AutochessFmtRightView:setCurViewDatas()
	self._petInfoList = AutochessModel.instance:getPetInfoList()

	AutochessFmtRightView.super.setCurViewDatas(self)
end

function AutochessFmtRightView:_clearTableview(cell)
	AutochessFmtRightView.super._clearTableview(self)
end

return AutochessFmtRightView
