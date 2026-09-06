-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/AssociatePetTipView.lua

module("logic.extensions.handbook.view.AssociatePetTipView", package.seeall)

local AssociatePetTipView = class("AssociatePetTipView", ViewComponent)

function AssociatePetTipView:ctor()
	AssociatePetTipView.super.ctor(self)
end

function AssociatePetTipView:buildUI()
	AssociatePetTipView.super.buildUI(self)

	self._Nego_Content = goutil.findChild(self.mainGO, "Nego_Content")
	self._adjustPosition = self._Nego_Content:GetComponent(ComponentType.UIAdjustPosition)
	self.scrollerGo = goutil.findChild(self._Nego_Content, "tableview")
	self.cellGo = goutil.findChild(self._Nego_Content, "cell")
	self.scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function AssociatePetTipView:bindEvents()
	AssociatePetTipView.super.bindEvents(self)
end

function AssociatePetTipView:unbindEvents()
	AssociatePetTipView.super.unbindEvents(self)
end

function AssociatePetTipView:onEnter()
	AssociatePetTipView.super.onEnter(self)

	local data = self._viewPresentor._openParam[1]
	local pos = self._viewPresentor._openParam[2]

	if not self._viewPresentor._openParam[3] then
		if pos then
			Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
			self._adjustPosition:AdjustScreenPosition(pos, self._viewPresentor._openParam[3][1], self._viewPresentor._openParam[3][2])
		else
			self._touchPosition = UGUIToolHelper.GetTouchPosition()

			self._adjustPosition:AdjustScreenPosition(self._touchPosition)
		end

		self:_initPets(data)
	end
end

function AssociatePetTipView:onExit()
	AssociatePetTipView.super.onExit(self)

	self._touchPosition = nil
end

function AssociatePetTipView:onExitFinished()
	AssociatePetTipView.super.onExitFinished(self)
	self.scrollList:dispose()
end

function AssociatePetTipView:_refreshView()
	local data = self._viewPresentor._openParam[1]

	self:_initPets(data)
end

function AssociatePetTipView:_initPets(list)
	self.scrollList:reloadData(list)
end

function AssociatePetTipView:_updateCell(view, cell, data, tag)
	local head = goutil.findChild(cell, "head")
	local noGet = goutil.findChild(cell, "state")
	local attr = goutil.findChild(cell, "attr")
	local imgAttr = goutil.findChildComponent(cell, "attr/icon", "UIImageSpriteChange")
	local name = goutil.findChildTextComponent(cell, "name")

	name.text = data.name

	MaterialMgr.setCell(MatType.Pet, data.raceId, head)
	goutil.setActive(noGet, not BagModel.instance:isExistRaceId(data.raceId))

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(data.raceId)

	race = math.fmod(race, 10)

	local targetValue = race - 1

	imgAttr:SetState(targetValue)
	GameUtil.asBtn(attr):RemoveClickListener()
	GameUtil.asBtn(attr):AddClickListener(function()
		CommonTipsMgr.instance:openMaterialTips(attr, MatType.Race, race)
	end)
end

function AssociatePetTipView:clearCell(cell)
	local head = goutil.findChild(cell, "head")

	MaterialMgr.resetAll(head)
end

return AssociatePetTipView
