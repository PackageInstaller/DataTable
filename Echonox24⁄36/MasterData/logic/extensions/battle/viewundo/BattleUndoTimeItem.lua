-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewundo/BattleUndoTimeItem.lua

module("logic.extensions.battle.viewundo.BattleUndoTimeItem", package.seeall)

local BattleUndoTimeItem = class("BattleUndoTimeItem", ReusableLuaBehavior)

function BattleUndoTimeItem:buildUI()
	self._transform = self.mainGO.transform
	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._canvasGroupText = goutil.addComponentOnce(goutil.findChild(self.mainGO, "txtTime"), ComponentType.CanvasGroup)
	self._goImgDi = goutil.findChild(self.mainGO, "imgDi")
	self._goClick = goutil.findChild(self.mainGO, "click")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "txtTime")
	self._transformTime = self._txtTime.transform
	self._animation = goutil.addComponentOnce(self.mainGO, ComponentType.Animation)
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "click"))
	self._btnGuidClick = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "guidClick"))

	self._btnClick:AddClickListener(self._onClick, self)
	self._btnGuidClick:AddClickListener(self._onGuidClick, self)

	self._clickHandler = Handler.New()
	self._index = false
	self._undoMO = false
	self._enableSwitchButton = false
end

function BattleUndoTimeItem:destroyUI()
	self._btnClick:RemoveClickListener()
	self._btnGuidClick:RemoveClickListener()

	self._transform = false
	self._canvasGroup = false
	self._canvasGroupText = false
	self._goImgDi = false
	self._goClick = false
	self._txtTime = false
	self._transformTime = false
	self._animation = false
	self._btnClick = false
	self._btnGuidClick = false
	self._clickHandler = false
	self._index = false
	self._undoMO = false
end

function BattleUndoTimeItem:onEnter()
	self:setSelected(false)
end

function BattleUndoTimeItem:onExit()
	return
end

function BattleUndoTimeItem:setIndex(index)
	self._index = index
end

function BattleUndoTimeItem:getIndex()
	return self._index
end

function BattleUndoTimeItem:getPosition()
	return Astral.TransformUtil.GetAnchoredPos(self._transform, 0, 0)
end

function BattleUndoTimeItem:setSelected(isSelected)
	if isSelected then
		self._canvasGroupText.alpha = 1

		goutil.setActive(self._goImgDi, false)
		TransformUtils.SetLocalScale(self._transformTime, 0.36, 0.36, 0.36)

		if self._enableSwitchButton then
			goutil.setActive(self._goClick, true)
		end
	else
		self._canvasGroupText.alpha = 0.2

		goutil.setActive(self._goImgDi, true)
		TransformUtils.SetLocalScale(self._transformTime, 0.28, 0.28, 0.28)

		if self._enableSwitchButton then
			goutil.setActive(self._goClick, false)
		end
	end
end

function BattleUndoTimeItem:setVisible(visible)
	self._canvasGroup.alpha = visible and 1 or 0
end

function BattleUndoTimeItem:setEnableSwitchButton(enable)
	self._enableSwitchButton = enable
end

function BattleUndoTimeItem:setUndoMO(undoMO)
	self._undoMO = undoMO

	local round = undoMO:getRound()

	self._canvasGroupText.alpha = 1
	self._txtTime.text = string.format("%s:00", round)
end

function BattleUndoTimeItem:getUndoMO()
	return self._undoMO
end

function BattleUndoTimeItem:setClickListener(callback, callbackSelf)
	self._clickHandler:setListener(callback, callbackSelf)
end

function BattleUndoTimeItem:playOpenAnimation(immediately)
	AnimationUtils.SetPlaySpeed(self._animation, immediately and 100 or 1)
	self._animation:Play("time_item_huihe_open")
end

function BattleUndoTimeItem:playCloseAnimation()
	AnimationUtils.SetPlaySpeed(self._animation, 1)
	self._animation:Play("time_item_huihe_close")
end

function BattleUndoTimeItem:_onClick()
	self._clickHandler:call(self, true)
end

function BattleUndoTimeItem:_onGuidClick()
	self._clickHandler:call(self)
end

return BattleUndoTimeItem
