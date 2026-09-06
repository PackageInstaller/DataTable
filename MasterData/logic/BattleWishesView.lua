-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaysportswish/view/BattleWishesView.lua

module("logic.extensions.birthdaysportswish.view.BattleWishesView", package.seeall)

local BattleWishesView = class("BattleWishesView", ViewComponent)

function BattleWishesView:ctor()
	BattleWishesView.super.ctor(self)
end

function BattleWishesView:unbindEvents()
	BattleWishesView.super.unbindEvents(self)
end

function BattleWishesView:bindEvents()
	BattleWishesView.super.bindEvents(self)
end

function BattleWishesView:buildUI()
	BattleWishesView.super.buildUI(self)

	self._txtEffect = self:getTxt("info/effect/txtEffect")
	self._petTableView = self:getGo("info/petView")
	self._petTableCell = self:getGo("info/pet")
	self._petScrollerList = ScrollerList.create(self._petTableView, self._petTableCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._jumptoTableView = self:getGo("jump/jumpView")
	self._jumptoTableCell = self:getGo("jump/jumpCell")
	self._jumptoScrollerList = ScrollerList.create(self._jumptoTableView, self._jumptoTableCell, GameUtil.handler(self._updateJumpToCell, self), GameUtil.handler(self._clearJumpToCell, self))
end

function BattleWishesView:onExit()
	BattleWishesView.super.onExit(self)
	self._jumptoScrollerList:dispose()
	self._petScrollerList:dispose()
end

function BattleWishesView:onEnter()
	BattleWishesView.super.onEnter(self)

	local actId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.BIRTHDAY_SPORTS_WISHES)
	local isOpen = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.BIRTHDAY_SPORTS_WISHES, actId)

	if not isOpen then
		FloatWordMgr.instance:show("此活动未在时间内")
		self:close()

		return
	end

	self._buffCfgs = BirthdaySportsWishConfig.instance:getBuffCfgsByActId(actId)
	self._jumptoCfgs = BirthdaySportsWishConfig.instance:getJumpToCfgs(actId)

	self:_initView(self._buffCfgs)
	self:_reloadPetData(self._buffCfgs)
	self:_reloadJumpToData(self._jumptoCfgs)
end

function BattleWishesView:_initView(cfgs)
	self._txtEffect.text = cfgs.buffDesc
end

function BattleWishesView:_reloadPetData(cfgs)
	local petIds = string.split(cfgs.petId, ";")

	self._petScrollerList:reloadData(petIds)
	self._petScrollerList:refresh()
end

function BattleWishesView:_reloadJumpToData(cfgs)
	self._jumptoScrollerList:reloadData(cfgs)
	self._jumptoScrollerList:refresh()
end

function BattleWishesView:_updatePetCell(view, goCell, data, tag)
	local cell = self:_clearPetCell(goCell)
	local raceId = data
	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, cell.go)

	if proxy then
		-- block empty
	end
end

function BattleWishesView:_updateJumpToCell(view, goCell, data, tag)
	local cell = self:_clearJumpToCell(goCell)

	cell.txtJumpTo.text = data.name
	cell.txtDesc.text = data.desc

	GameUtil.addClickHandler(cell.btnJumpTo, GameUtil.handler(self._onClickJumpTo, self, data))
end

function BattleWishesView:_clearPetCell(goCell)
	local cell = {}

	cell.go = goCell

	MaterialMgr.resetAll(cell.go)

	return cell
end

function BattleWishesView:_clearJumpToCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.btnJumpTo = goutil.findChildButtonComponent(cell.go, "btnGoto")
	cell.txtJumpTo = goutil.findChildTextComponent(cell.go, "txtTitle")
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")

	GameUtil.rmClickHandler(cell.btnJumpTo)

	return cell
end

function BattleWishesView:_onClickJumpTo(data)
	if not string.nilorempty(data.jumpTo) then
		GotoMgr.gotoByString(data.jumpTo)
	end
end

return BattleWishesView
