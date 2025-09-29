-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uipool/BattleBuffIcon.lua

module("logic.battle.uipool.BattleBuffIcon", package.seeall)

local BattleBuffIcon = class("BattleBuffIcon", IBattleReusable)
local kPoolRoot = PoolRootUtil.createUIPoolRoot("BattleBuffIconPool")

function BattleBuffIcon:ctor()
	local resMgr = BattleMgr.instance:getResourceMgr()
	local mainGO = resMgr:getInst(BattleResourceName.UIBuffIcon)

	goutil.addChildToParent(mainGO, kPoolRoot)

	self.mainGO = mainGO

	self:buildUI()
end

function BattleBuffIcon:reuse()
	local transform = self.mainGO.transform

	RectTransformUtils.ResetRectTransform(transform)
end

function BattleBuffIcon:reset()
	self:resetUI()
	goutil.addChildToParent(self.mainGO, kPoolRoot)
	self._disapperAnim:Stop()
	AnimationUtils.ResetAnimation(self._disapperAnim)
end

function BattleBuffIcon:destroy()
	self:destroyUI()
	goutil.destroy(self.mainGO)

	self.mainGO = nil
end

function BattleBuffIcon:buildUI()
	self._imgDi = goutil.findChildImageComponent(self.mainGO, "pos/imgBuffDi")
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "pos/imgIcon")
	self._txtRound = goutil.findChildTextComponent(self.mainGO, "pos/txtRound")
	self._imgLayer = goutil.findChildImageComponent(self.mainGO, "pos/imgLayer")
	self._txtLayer = goutil.findChildTextComponent(self.mainGO, "pos/imgLayer/txtLayer")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "pos/click"))
	self._moreBtnGo = goutil.findChild(self.mainGO, "pos/omit")
	self._clickHandler = Handler.New()

	self._btnClick:AddClickListener(self._onClickEvt, self)

	self._disapperAnim = goutil.addComponentOnce(self.mainGO, ComponentType.Animation)
	self._maskGo = goutil.findChild(self.mainGO, "pos/mask")
	self._layerMaskGo = goutil.findChild(self.mainGO, "pos/mask/Image")
end

function BattleBuffIcon:resetUI()
	goutil.setActive(self._maskGo, false)
	self._clickHandler:clear()
	self:setMoreSign(false)
	IconLoader.clearSprite(self._imgIcon)
	IconLoader.clearSprite(self._imgDi)
end

function BattleBuffIcon:destroyUI()
	self._btnClick:RemoveClickListener()
	self._clickHandler:clear()

	self._imgIcon = nil
	self._imgDi = nil
	self._txtRound = nil
	self._btnClick = nil
end

function BattleBuffIcon:setBuffMO(buffMO)
	local buffCO = BuffConfig.instance:getBuffCO(buffMO:getBuffCode())

	IconLoader.setSprite(self._imgIcon, IconType.BuffIcon, buffCO.buffIcon)
	IconLoader.setSprite(self._imgDi, IconType.Skinlib, BuffCOUtil.getBuffIconBgOfTips(buffCO))

	if buffMO:isForever() then
		self._txtRound.text = ""
	else
		self._txtRound.text = buffMO:getRound()
	end

	if buffMO:isLayerBuff() then
		Astral.ColorUtil.SetImageColor(self._imgLayer, BuffCOUtil.isGood(buffCO) and "#2e628d" or "#b04444")
		goutil.setActive(self._imgLayer.gameObject, true)

		self._txtLayer.text = buffMO:getLayer()
	else
		goutil.setActive(self._imgLayer.gameObject, false)
	end
end

function BattleBuffIcon:setMoreSign(status)
	goutil.setActive(self._imgDi.gameObject, not status)
	goutil.setActive(self._imgIcon.gameObject, not status)
	goutil.setActive(self._txtRound.gameObject, not status)
	goutil.setActive(self._moreBtnGo, status)

	if status then
		goutil.setActive(self._imgLayer.gameObject, false)
	end
end

function BattleBuffIcon:setClickListener(callback, callbackSelf)
	self._clickHandler:setListener(callback, callbackSelf)
end

function BattleBuffIcon:_onClickEvt()
	self._clickHandler:call()
end

function BattleBuffIcon:playDisappearAnim()
	self._disapperAnim:Stop()
	AnimationUtils.SetPlaySpeed(self._disapperAnim, BattleTime.timeScale)
	self._disapperAnim:Play("buff_icon_disappear")
end

function BattleBuffIcon:setMask(isMask)
	goutil.setActive(self._maskGo, isMask)

	if isMask then
		goutil.setActive(self._layerMaskGo, self._imgLayer.gameObject.activeSelf)
	end
end

return BattleBuffIcon
