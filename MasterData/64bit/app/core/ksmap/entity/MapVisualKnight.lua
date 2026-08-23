local SpineBase = require("app.view.common.SpineBase")
local BattleConst = require("app.view.battle.const.BattleConst")
local MapConst = import("..MapConst")
local MapVisualKnight = class("MapVisualKnight", (import(".MapVisual")))

function MapVisualKnight:ctor(arg_1_1)
	self.m_billboard = nil
	self.m_nameTxt = nil
	self.m_signBg = nil
	self.m_signImg = nil
	self.m_pheffect = nil
	self._isHalfOpacity = false
	self.m_talkBubbleComp = nil
	self._scheduleBubbleId = nil
	self._taskState = nil
	self._battleTaskIsMain = nil

	MapVisualKnight.super.ctor(self, arg_1_1)
end

function MapVisualKnight:setDescName(arg_2_1)
	if self.m_billboard then
		if arg_2_1 == nil or arg_2_1 == "" then
			self.m_billboard:setVisible(false)
		else
			self.m_billboard:setVisible(true)
			self.m_nameTxt:setString(arg_2_1)

			if self.m_nameTxt:getStringLength() >= 7 then
				self.m_nameTxt:setScaleX(0.8)
			end
		end
	end
end

function MapVisualKnight:setSignIcon(arg_3_1, arg_3_2)
	if arg_3_1 then
		if self.m_signBg and self.m_signImg then
			self.m_signBg:setVisible(true)
			self.m_signImg:setTexture(arg_3_1)

			if arg_3_2 and self.m_missTypeSign then
				self.m_missTypeSign:setVisible(true)
				self.m_missTypeSign:setTexture(arg_3_2)
			else
				self.m_missTypeSign:setVisible(false)
			end
		end
	elseif self.m_signBg then
		self.m_signBg:setVisible(false)
	end
end

function MapVisualKnight:playInnerAction(arg_4_1)
	self._realVisual:setAnimation(0, arg_4_1, true)
end

function MapVisualKnight:playOnceAction(arg_5_1)
	self._realVisual:setAnimation(0, arg_5_1, false)
end

function MapVisualKnight:setHalfOpacity(arg_6_1)
	if self._isHalfOpacity == arg_6_1 then
		return
	end

	self._isHalfOpacity = arg_6_1

	self._realVisual:setOpacity(self._isHalfOpacity and 100 or 255)
end

function MapVisualKnight:playJumpEffect()
	local var_7_0

	var_7_0 = SpineBase.new({
		isLoop = false,
		anim = "play",
		resId = "battle_shunyi",
		path = g.core.common.Path:getEffSpine("battle_shunyi"),
		listener = function(self)
			if self.type == "complete" then
				var_7_0:removeFromParent(true)
			end
		end
	})

	;(nil):setPositionY(self._hitRect.height / 2 - 40)
	self:addChild(var_7_0)
end

function MapVisualKnight:addEffectSpine()
	self.m_pheffect = SpineBase.new({
		anim = "play",
		resId = "battle_guanghuan",
		isLoop = true,
		path = g.core.common.Path:getEffSpine("battle_guanghuan")
	})

	self:addChild(self.m_pheffect, -1)
end

function MapVisualKnight:removeLightEffectSpine()
	if self.m_pheffect then
		self.m_pheffect:removeFromParent(true)

		self.m_pheffect = nil
	end
end

function MapVisualKnight:showTalkBubble(arg_11_1, arg_11_2)
	arg_11_2 = arg_11_2 or 1

	if self._scheduleBubbleId then
		g.core.common.Scheduler:cancelSchedule(self._scheduleBubbleId)

		self._scheduleBubbleId = nil
	end

	if self.m_talkBubbleComp then
		self.m_talkBubbleComp:removeSelf()
	end

	local var_11_0 = fgui.UIPackage:createObject("base_new", "BaseTalkBubbleComp")

	var_11_0:setBobbleStr(arg_11_1)

	local var_11_1 = var_11_0:getChild("talkTxt")

	self.m_talkBubbleComp = var_11_0:popDisplayObject()

	self.m_talkBubbleComp:setPosition(30, 120)
	self:addChild(self.m_talkBubbleComp)

	self._scheduleBubbleId = g.core.common.Scheduler:newScheduleOnce(handler(self, self._onBubbleScheduler), arg_11_2)
end

function MapVisualKnight:_doInitData()
	self._elemType = MapConst.RESTYPE.KNIGHT
	self._basePath = g.core.common.Path:getMapKnightPath()
end

function MapVisualKnight:_doCreateView()
	local var_13_0 = SpineBase.new({
		isLoop = true,
		resId = self._resID,
		path = self._basePath .. self._resID .. "/" .. self._resID,
		anim = BattleConst.SPINE_ACTION_TYPE.IDLE
	})

	var_13_0:setCascadeOpacityEnabled(true)

	return var_13_0
end

function MapVisualKnight:_doRemoveView()
	if self._realVisual then
		self._realVisual:dispose()
	end

	self._realVisual = nil
end

function MapVisualKnight:_doInitBillboard()
	self._hitRect.width = 80
	self._hitRect.height = 150
	self._hitRect.x = -40
	self._hitRect.y = 0
	self.m_billboard = cc.Node:create()

	self:addChild(self.m_billboard)
	self.m_billboard:setPosition(0, self._hitRect.height)

	local var_15_0 = display.newSprite("ui_cocos/biography/bg_lz_black.png", {
		scale9 = true,
		capInsets = cc.rect(5, 5, 2, 2)
	})

	var_15_0:setContentSize(cc.size(116, 52))
	var_15_0:setPosition(0, 30)
	var_15_0:setOpacity(204)
	self.m_billboard:addChild(var_15_0)

	self.m_nameTxt = cc.Label:createWithSystemFont("", "", 18)

	self.m_nameTxt:setTextColor(cc.c3b(242, 242, 242))
	self.m_nameTxt:setWidth(130)
	self.m_nameTxt:setAnchorPoint(0.5, 0.5)
	self.m_nameTxt:setAlignment(1)
	self.m_nameTxt:setPosition(0, 30)
	self.m_billboard:addChild(self.m_nameTxt)

	self.m_signBg = cc.Sprite:create("ui_cocos/biography/pic_lz_qianzhikuang.png")

	self.m_signBg:setPosition(-76, 30)
	self.m_signBg:setLocalZOrder(-1)
	self.m_billboard:addChild(self.m_signBg)

	self.m_signImg = cc.Sprite:create("ui_cocos/biography/icon_lz_gongji.png")

	self.m_signImg:setAnchorPoint(0.5, 0.5)
	self.m_signImg:setPosition(self.m_signBg:getContentSize().width / 2, self.m_signBg:getContentSize().height / 2)
	self.m_signBg:addChild(self.m_signImg)

	self.m_missTypeSign = cc.Sprite:create("ui_cocos/biography/icon_zhuxianbiaoji.png")

	self.m_missTypeSign:setAnchorPoint(0.5, 0.5)
	self.m_missTypeSign:setPosition(self.m_signBg:getContentSize().width / 2 + 70, self.m_signBg:getContentSize().height / 2 + 40)
	self.m_signBg:addChild(self.m_missTypeSign)
	self.m_billboard:setVisible(false)
	self.m_signBg:setVisible(false)
end

function MapVisualKnight:_doUpdateRoleSkin(arg_16_1)
	local var_16_0 = g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(arg_16_1)

	if self._resID ~= var_16_0.resId then
		self:_doRemoveView()

		self._resID = var_16_0.resId
		self._realVisual = self:_doCreateView()

		self:addChild(self._realVisual)
	end

	if var_16_0.skinName then
		local var_16_1 = self._realVisual:getSkeleton()

		if var_16_1 then
			var_16_1:setSkin(var_16_0.skinName)
			var_16_1:setSlotsToSetupPose()
		end
	end

	if not var_16_0.isShowBack then
		if self._backSpine then
			self._realVisual:removeChildAtSlot(g.core.const.ConstMgr.SpineConst.DEFAULT_BACK_SLOT_NAME)

			self._backSpine = nil
		end

		return
	end

	if var_16_0.backName and var_16_0.backName ~= "" and var_16_0.backSkin and var_16_0.backSkin ~= "" then
		self._backSpine = require("app.view.common.SpineBase").new({
			resId = var_16_0.backName,
			path = g.core.common.Path:getMainRoleBackSpinePath(var_16_0.backName)
		})

		self._realVisual:addNodesAtSlots({
			{
				slotStr = g.core.const.ConstMgr.SpineConst.DEFAULT_BACK_SLOT_NAME,
				node = self._backSpine
			}
		})

		local var_16_2 = self._backSpine:getSkeleton()

		if var_16_2 then
			var_16_2:setSkin(var_16_0.backSkin)
			var_16_2:setSlotsToSetupPose()
		end

		self._backSpine:setAnimation(0, "play", true)
	end
end

function MapVisualKnight:_onBubbleScheduler()
	if self.m_talkBubbleComp then
		self.m_talkBubbleComp:removeSelf()

		self.m_talkBubbleComp = nil
	end

	self._scheduleBubbleId = nil
end

return MapVisualKnight
