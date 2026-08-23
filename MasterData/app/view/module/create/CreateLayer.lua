local CreateConst = require("app.view.module.create.const.CreateConst")
local var_0_1 = g.core.const.ConstMgr.SoundConst
local var_0_2 = 300
local var_0_3 = 1000
local var_0_4 = 0.3
local CreateLayer = class("CreateLayer", require("app.fairyGUI.create.UI_CreateLayer"), function()
	return fgui.GComponent:create({
		resName = "CreateLayer",
		pkgPath = "ui/create/create",
		isFullScreen = true,
		pkgName = "create"
	}, ...)
end)

CreateLayer.SEX = {
	BOY = 1,
	GIRL = 2
}

function CreateLayer:ctor()
	self.m_leftBtn:addClickListener(handler(self, self._onChangeRoleToLeft))
	self.m_rightBtn:addClickListener(handler(self, self._onChangeRoleToToRight))
	self.m_selectBtn:addClickListener(handler(self, self._onSelectedBtnClick))
	self.m_leftBtn:setSound(var_0_1.Sound.CLICK_ENTER)
	self.m_rightBtn:setSound(var_0_1.Sound.CLICK_ENTER)
	self.m_selectBtn:setSound(var_0_1.Sound.ROLE_REATE_CHOOSE)

	self._canTouchKnight = true

	self:initView()
	self:setSelectedRole(CreateLayer.SEX.BOY, nil, true)

	self._centerPosX = self.m_knightGirlSpine:getX()

	self:setCurShowX(self._centerPosX)
	self.m_enterTransition:play()
	self.m_touchComp:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_touchComp:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self.m_touchComp:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
		event_id = g.core.const.ConstMgr.SuperSdkConst.ENTER_CREATE_ROLE
	})
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_ROLE_CREATE_B)
end

function CreateLayer:initView()
	local var_3_0 = self.m_leftBtn:getSize()

	self.m_leftBtn:addEffectSpine({
		isLoop = true,
		name = "eff_ui_create_arrow",
		anim = "play",
		x = var_3_0.width / 2,
		y = var_3_0.height / 2
	})
	self.m_rightBtn:addEffectSpine({
		isLoop = true,
		name = "eff_ui_create_arrow",
		anim = "play",
		x = var_3_0.width / 2,
		y = var_3_0.height / 2
	})
	self.m_moviePlayHolder:addCriSprite({
		fullScreenState = 2,
		movieName = "CjNvZhc_1334x750_6667",
		isLoop = true,
		y = 0,
		moduleName = "create",
		x = 0
	})
	self.m_knightGirlSpine:addEffectSpine({
		anim = "idle2",
		name = "nvzhu_denglu",
		isReverse = false,
		isLoop = true
	})
	self.m_knightBoySpine:addEffectSpine({
		anim = "idle2",
		name = "nanzhu_denglu",
		isLoop = true
	})
end

function CreateLayer:_onChangeRoleToToRight()
	if not self._canTouchKnight then
		return
	end

	if self._selected == CreateConst.BOY then
		self:setSelectedRole(CreateLayer.SEX.GIRL, true)
	else
		self:setSelectedRole(CreateLayer.SEX.BOY, true)
	end
end

function CreateLayer:_onChangeRoleToLeft()
	if not self._canTouchKnight then
		return
	end

	if self._selected == CreateConst.BOY then
		self:setSelectedRole(CreateLayer.SEX.GIRL, false)
	else
		self:setSelectedRole(CreateLayer.SEX.BOY, false)
	end
end

function CreateLayer:setSelectedRole(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1 == 1 then
		self._selected = CreateConst.BOY

		if not arg_6_3 then
			self:_changeRoleAnim(self.m_knightGirlSpine, self.m_knightBoySpine, arg_6_2)
		else
			self.m_knightGirlSpine:setVisible(false)
			self.m_knightBoySpine:setAlpha(1)
			self.m_knightBoySpine:setVisible(true)
		end
	elseif arg_6_1 == 2 then
		self._selected = CreateConst.GIRL

		if not arg_6_3 then
			self:_changeRoleAnim(self.m_knightBoySpine, self.m_knightGirlSpine, arg_6_2)
		else
			self.m_knightGirlSpine:setVisible(true)
			self.m_knightGirlSpine:setAlpha(1)
			self.m_knightBoySpine:setVisible(false)
		end
	end
end

function CreateLayer:_changeRoleAnim(arg_7_1, arg_7_2, arg_7_3)
	self._canTouchKnight = false

	if arg_7_3 then
		arg_7_1:runFGAction((fgui.FMoveBy:create(var_0_4, cc.p(var_0_3, 0))))
		arg_7_2:setVisible(true)
		arg_7_2:setX(self._centerPosX - var_0_3)
		arg_7_2:runFGAction((fgui.FSequence:create(fgui.FMoveBy:create(var_0_4, cc.p(var_0_3, 0)), fgui.FCallFunc:create(handler(self, function()
			self._canTouchKnight = true

			arg_7_1:setVisible(false)
		end)))))
	else
		arg_7_1:runFGAction((fgui.FMoveBy:create(var_0_4, cc.p(-var_0_3, 0))))
		arg_7_2:setVisible(true)
		arg_7_2:setX(self._centerPosX + var_0_3)
		arg_7_2:runFGAction((fgui.FSequence:create(fgui.FMoveBy:create(var_0_4, cc.p(-var_0_3, 0)), fgui.FCallFunc:create(handler(self, function()
			self._canTouchKnight = true

			arg_7_1:setVisible(false)
		end)))))
	end
end

function CreateLayer:_onSelectedBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.create.CreateRolePop").new({
		type = self._selected
	})))
end

function CreateLayer:setCurShowAlpha(arg_11_1)
	if self._selected == CreateConst.BOY then
		self.m_knightBoySpine:setAlpha(arg_11_1)
	elseif self._selected == CreateConst.GIRL then
		self.m_knightGirlSpine:setAlpha(arg_11_1)
	end
end

function CreateLayer:setCurShowX(arg_12_1)
	if self._selected == CreateConst.BOY then
		self.m_knightBoySpine:setX(arg_12_1)
	elseif self._selected == CreateConst.GIRL then
		self.m_knightGirlSpine:setX(arg_12_1)
	end
end

function CreateLayer:_onTouchBegin(arg_13_1)
	if not self._canTouchKnight then
		return
	end

	local var_13_0 = arg_13_1:getInput():getTouch()

	if var_13_0 then
		self._beginX = var_13_0:getLocation().x

		arg_13_1:captureTouch()
	end
end

function CreateLayer:_onTouchMove(arg_14_1)
	if self._beginX then
		self:setCurShowX(arg_14_1:getInput():getTouch():getLocation().x - self._beginX + self._centerPosX)
	end
end

function CreateLayer:_onTouchEnd(arg_15_1)
	if self._beginX then
		local var_15_0 = arg_15_1:getInput():getTouch():getLocation().x - self._beginX

		if math.abs(var_15_0) > var_0_2 then
			if var_15_0 > 0 then
				self:_onChangeRoleToToRight()
			else
				self:_onChangeRoleToLeft()
			end
		else
			self:resetCurShowRole()
		end

		self._beginX = nil
	end
end

function CreateLayer:resetCurShowRole()
	self:setCurShowX(self._centerPosX)
end

function CreateLayer:onUnload()
	self.m_moviePlayHolder:removeAllCriSprite()
end

return CreateLayer
