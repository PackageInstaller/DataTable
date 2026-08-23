local AllianceTrialMapConst = require("app.view.module.allianceTrial.const.AllianceTrialMapConst")
local SpineBase = require("app.view.common.SpineBase")
local BattleKnight = require("app.view.battle.BattleKnight")
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_4 = g.core.const.ConstMgr.SnapShotCacheConst
local var_0_5 = g.core.model.User.snapShotCacheData
local MapConst = require("app.core.ksmap.MapConst")
local var_0_7 = g.core.config.knight_info
local var_0_8 = g.core.config.knight_base_info
local var_0_9 = g.core.model.User.allianceTrialData
local AllianceTrialVisualKnight = class("AllianceTrialVisualKnight", (require("app.core.ksmap.entity.MapVisual")))

function AllianceTrialVisualKnight:ctor(arg_1_1, arg_1_2)
	self._isMonster = false

	local var_1_0 = var_0_9:getMonsterInfoByBindId(arg_1_2)

	if var_1_0 then
		self._resID = var_0_8.get(var_0_7.get(var_1_0.knight_id).res_id).fight_id
		self._isMonster = true
		self._hpMax = var_1_0.monster_group_hp
		self._hp = self._hpMax
		self._monsterId = var_1_0.id

		self:playMonsterAttacker()
	elseif arg_1_1 == AllianceTrialMapConst.IGNORE_SHOW_RES_ID then
		self._resID = ""
	else
		self._resID = arg_1_1
		self._hpMax = 0
	end

	self.m_topRoot = nil
	self.m_nameTxt = nil
	self.m_signImg = nil
	self.m_fightValue = nil
	self._attacking = false

	AllianceTrialVisualKnight.super.ctor(self, self._resID, arg_1_2)
end

function AllianceTrialVisualKnight:playMonsterAttacker()
	if self._hp <= 0 then
		return
	end

	g.core.common.Scheduler:newScheduleOnce(function()
		if self and self._realVisual then
			self:runAction((cc.Sequence:create(cc.CallFunc:create(handler(self, function()
				self:setIsAttacking(true)
				self:playOnceAction(BattleConst.SPINE_ACTION_TYPE.ATTACK)
			end)), cc.DelayTime:create(1), cc.CallFunc:create(handler(self, function()
				self:setIsAttacking(false)
				self:playInnerAction(BattleConst.SPINE_ACTION_TYPE.IDLE)
			end)))))
			self:playMonsterAttacker()
		end
	end, (math.random(5, 15)))
end

function AllianceTrialVisualKnight:isMonster()
	return self._isMonster
end

function AllianceTrialVisualKnight:updateShowMonster(arg_7_1)
	if not self._isMonster or arg_7_1.id == self._monsterId then
		return
	end

	local var_7_0 = var_0_8.get(var_0_7.get(arg_7_1.knight_id).res_id)

	if self._resID ~= var_7_0.fight_id then
		self._resID = var_7_0.fight_id

		if self._realVisual then
			self._realVisual:removeFromParent(true)

			self._realVisual = nil
		end

		self._realVisual = self:_doCreateView()

		self:addChild(self._realVisual)
		self._realVisual:setScaleX(self:_getInnerScaleX())
		self._realVisual:setScaleY(self._innerScale)
	end

	self._hpMax = arg_7_1.monster_group_hp

	self:setHpValue(var_0_9:getMonsterHp(arg_7_1.id))
end

function AllianceTrialVisualKnight:setDescName(arg_8_1)
	if self.m_topRoot then
		if arg_8_1 == nil or arg_8_1 == "" then
			self.m_topRoot:setVisible(false)
		else
			self.m_topRoot:setVisible(true)
			self.m_nameTxt:setString(arg_8_1)

			if self.m_nameTxt:getStringLength() >= 7 then
				self.m_nameTxt:setScaleX(0.8)
			end
		end
	end
end

function AllianceTrialVisualKnight:setSignIcon(arg_9_1)
	if arg_9_1 and self.m_signImg then
		self.m_signImg:setTexture(arg_9_1)
	end
end

function AllianceTrialVisualKnight:setHalfOpacity(arg_10_1)
	if self._isHalfOpacity == arg_10_1 then
		return
	end

	self._isHalfOpacity = arg_10_1

	self._realVisual:setOpacity(self._isHalfOpacity and 100 or 255)
end

function AllianceTrialVisualKnight:setFightValue(arg_11_1)
	if self.m_fightValue and self.m_fightValue then
		self.m_fightValue:setVisible(true)
		self.m_fightValue:setString((g.core.utils.Number.transTextNumFormation(arg_11_1)))
	end
end

function AllianceTrialVisualKnight:playInnerAction(arg_12_1)
	self._realVisual:setAnimation(0, arg_12_1, true)
end

function AllianceTrialVisualKnight:playOnceAction(arg_13_1)
	self._realVisual:setAnimation(0, arg_13_1, false)
end

function AllianceTrialVisualKnight:setIsAttacking(arg_14_1)
	self._attacking = arg_14_1 == true
end

function AllianceTrialVisualKnight:isAttacking()
	return self._attacking
end

function AllianceTrialVisualKnight:playJumpEffect()
	local var_16_0

	var_16_0 = SpineBase.new({
		isLoop = false,
		anim = "play",
		resId = "battle_shunyi",
		path = g.core.common.Path:getEffSpine("battle_shunyi"),
		listener = function(self)
			if self.type == "complete" then
				var_16_0:removeFromParent(true)
			end
		end
	})

	;(nil):setPositionY(self._hitRect.height / 2 - 40)
	self:addChild(var_16_0)
end

function AllianceTrialVisualKnight:addEffectSpine()
	self.m_pheffect = SpineBase.new({
		isLoop = true,
		anim = "play",
		resId = "battle_guanghuan",
		path = g.core.common.Path:getEffSpine("battle_guanghuan")
	})

	self:addChild(self.m_pheffect, -1)
end

function AllianceTrialVisualKnight:removeLightEffectSpine()
	if self.m_pheffect then
		self.m_pheffect:removeFromParent(true)

		self.m_pheffect = nil
	end
end

function AllianceTrialVisualKnight:_doInitData()
	self._elemType = MapConst.RESTYPE.KNIGHT
	self._basePath = g.core.common.Path:getMapKnightPath()
end

function AllianceTrialVisualKnight:_doCreateView()
	if self._resID ~= "" then
		local var_21_0 = {
			isLoop = true,
			resId = self._resID,
			path = self._basePath .. self._resID .. "/" .. self._resID,
			anim = BattleConst.SPINE_ACTION_TYPE.IDLE
		}

		if not self._isMonster then
			local var_21_1 = var_0_5:getSnapShot(var_0_4.SNAP_SHOT_KEY.USER, self._bindID)

			if var_21_1 then
				var_21_0 = g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(var_21_1)
			end
		end

		local var_21_2 = BattleKnight.new(var_21_0)

		var_21_2:setCascadeOpacityEnabled(true)

		return var_21_2
	else
		return AllianceTrialVisualKnight.super._doCreateView(self)
	end
end

function AllianceTrialVisualKnight:_doInitBillboard()
	self._hitRect.width = 80
	self._hitRect.height = 150
	self._hitRect.x = -40
	self._hitRect.y = 0
	self.m_topRoot = cc.Node:create()

	self:addChild(self.m_topRoot)
	self.m_topRoot:setPosition(0, self._hitRect.height)

	local var_22_0 = display.newSprite("ui_cocos/allianceTrial/" .. (self._isMonster and "bg_slmj_titledi.png" or "bg_lz_black.png"), {
		scale9 = true
	})

	var_22_0:setContentSize(cc.size(116, 26))
	var_22_0:setPosition(0, 30)
	var_22_0:setOpacity(204)
	self.m_topRoot:addChild(var_22_0)

	self.m_nameTxt = cc.Label:createWithSystemFont("", "", 18)

	self.m_nameTxt:setTextColor(cc.c3b(242, 242, 242))
	self.m_nameTxt:setWidth(130)
	self.m_nameTxt:setAnchorPoint(0.5, 0.5)
	self.m_nameTxt:setAlignment(1)
	self.m_nameTxt:setPosition(0, 30)
	self.m_topRoot:addChild(self.m_nameTxt)

	if self._isMonster then
		self.m_signImg = cc.Sprite:create("ui_cocos/allianceTrial/pic_symj_zhandou4_boss.png")

		self.m_signImg:setAnchorPoint(0.5, 0.5)
		self.m_signImg:setPosition(-80, 30)
		self.m_topRoot:addChild(self.m_signImg)

		self._hpRoot = display.newNode()

		self.m_topRoot:addChild(self._hpRoot)
		self._hpRoot:setPosition(-57, 10)

		self._bgHp = display.newSprite("ui_cocos/allianceTrial/pic_sl_progressdi.png", {
			scale9 = true,
			capInsets = cc.rect(5, 5, 2, 2)
		})

		self._bgHp:setAnchorPoint(0, 0.5)
		self._bgHp:setPosition(0, 0)
		self._bgHp:setContentSize(cc.size(116, 8))
		self._hpRoot:addChild(self._bgHp)
		self._bgHp:setCascadeColorEnabled(true)
		self._bgHp:setCascadeOpacityEnabled(true)

		local var_22_1 = display.newSprite("ui_cocos/allianceTrial/pic_progress_2.png", {
			scale9 = true,
			capInsets = cc.rect(3, 3, 2, 2)
		})

		var_22_1:setContentSize(cc.size(114, 6))
		var_22_1:setAnchorPoint(0, 0.5)
		var_22_1:setPosition(1, 0)
		self._hpRoot:addChild(var_22_1)

		self._hpBar = var_22_1
		self._hpTxt = cc.Label:createWithTTF("100%", "font/SourceHanSansCN-Regular.otf", 16)

		self._hpTxt:setTextColor(cc.c3b(242, 242, 242))
		self._hpTxt:enableOutline(cc.c3b(50, 50, 50), 1)
		self._hpTxt:setAnchorPoint(0.5, 0.5)
		self._hpTxt:setAlignment(1)
		self._hpTxt:setPosition(58, 0)
		self._hpRoot:addChild(self._hpTxt)
	end

	self.m_topRoot:setVisible(false)
end

function AllianceTrialVisualKnight:setHpMax(arg_23_1)
	self._hpMax = arg_23_1
end

function AllianceTrialVisualKnight:setHpValue(arg_24_1)
	if self._hpMax == 0 then
		self._hpRoot:setVisible(false)

		return
	end

	self._hpRoot:setVisible(true)

	self._hp = arg_24_1

	local var_24_0 = math.clamp(arg_24_1 / self._hpMax, 0, 1)

	self._hpTxt:setString(math.floor(var_24_0 * 100) .. "%")
	self._hpBar:setContentSize(cc.size(114 * var_24_0, 6))
	self:updateGray()
end

function AllianceTrialVisualKnight:setFinalState()
	self:setHpValue(self._hpMax)
end

function AllianceTrialVisualKnight:updateGray()
	if self._realVisual then
		self._realVisual:setGray(self._hp <= 0)
	end
end

return AllianceTrialVisualKnight
