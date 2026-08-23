local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local var_0_1 = g.core.model.User.newSlgData
local var_0_2 = {
	[g.core.const.ConstMgr.NewSlgConst.BATTLE_PLAYER_TYPE.SELF] = {
		blood = "pic_hzts_progress4_1.png",
		camp = "pic_hzts_progress4_di.png"
	},
	[g.core.const.ConstMgr.NewSlgConst.BATTLE_PLAYER_TYPE.FRIEND] = {
		blood = "pic_hzts_progress4_2.png",
		camp = "pic_hzts_progress4_di.png"
	},
	[g.core.const.ConstMgr.NewSlgConst.BATTLE_PLAYER_TYPE.ENEMY] = {
		blood = "pic_hzts_progress4_4.png",
		camp = "pic_hzts_progress4_di.png"
	},
	[g.core.const.ConstMgr.NewSlgConst.BATTLE_PLAYER_TYPE.NEUTRAL] = {
		blood = "pic_hzts_progress4_3.png",
		camp = "pic_hzts_progress4_di.png"
	}
}
local var_0_3 = {
	[g.core.const.ConstMgr.NewSlgConst.ARMY_TYPE.QI] = "icon_bingzhong1.png",
	[g.core.const.ConstMgr.NewSlgConst.ARMY_TYPE.DUN] = "icon_bingzhong2.png",
	[g.core.const.ConstMgr.NewSlgConst.ARMY_TYPE.GONG] = "icon_bingzhong3.png",
	[g.core.const.ConstMgr.NewSlgConst.ARMY_TYPE.NEUTRAL] = "icon_bingzhong4.png"
}
local NewSlgIconNode = class("NewSlgIconNode", function()
	return cc.Node:create()
end)

function NewSlgIconNode:ctor()
	self._role = nil
	self._head = nil
	self._blood = nil
	self._army = nil
	self._armyBg = nil
	self._curType = var_0_0.BATTLE_PLAYER_TYPE.SELF
	self.battleTeam = nil
	self.roleType = var_0_0.BATTLE_PLAYER_TYPE.SELF
	self._cacheArgs = {
		init = true,
		scale = 1,
		fillRange = 1,
		roleType = var_0_0.BATTLE_PLAYER_TYPE.SELF
	}
	self._authority = 1000
	self._hp = 0
	self._cacheMoveId = nil

	self:_updateView()
end

function NewSlgIconNode:setData(arg_3_1)
	self.battleTeam = arg_3_1.battleTeam
	self.roleType = arg_3_1.roleType
	self._cacheArgs.detailInfo = arg_3_1.deltaInfo
	self._cacheArgs.roleType = arg_3_1.roleType
	self._cacheArgs.axis = arg_3_1.axis
	self._cacheArgs.init = true
	self._authority = arg_3_1.authority

	self:_updateView()
end

function NewSlgIconNode:_updateView()
	if self._role == nil then
		self._role = display.newSprite()

		self:addChild(self._role)
	end

	if self._roleBg == nil then
		self._roleBg = display.newSprite()

		self._roleBg:setSpriteFrame("pic_hzts_rolejijie1.png")
		self._role:addChild(self._roleBg)
	end

	if self._head == nil then
		self._head = display.newSprite()

		self._role:addChild(self._head)
	end

	local var_4_0 = self._cacheArgs.detailInfo or {}

	self:_createHpBar()
	self._progress:setPosition(cc.p(self._role:getContentSize().width / 2, self._role:getContentSize().height / 2))
	self._progress:setPosition(cc.p(self._role:getContentSize().width / 2, self._role:getContentSize().height / 2))

	if var_4_0.cur_troops then
		self._progress:setPercentage(100 * var_4_0.cur_troops / var_4_0.max_troops)
	end

	local var_4_1 = 500210

	if var_4_0.monster_res_id then
		var_4_1 = var_4_0.monster_res_id
	else
		local var_4_2 = var_4_0.character

		if var_4_0.character and var_4_2.tp and var_4_2.tp > 0 and var_4_2.base_id and var_4_2.base_id > 0 then
			var_4_1 = g.core.common.Goods.CFG[var_4_2.tp].get(var_4_2.base_id).res_id
		elseif self._cacheArgs.axis then
			local var_4_3 = g.core.model.User.newSlgData:getMonsterDataByRC(self._cacheArgs.axis.x, self._cacheArgs.axis.y)

			if var_4_3 then
				var_4_1 = g.core.model.User.newSlgData:getMonsterInfoById(var_4_3.monsterId).pic
			end
		end
	end

	self._head:setSpriteFrame(var_4_1 .. ".png")

	if self._bar == nil then
		self._bar = display.newSprite()

		self._role:addChild(self._bar)
	end

	if self._armyBg == nil then
		self._armyBg = display.newSprite("#pic_hzts_bingzhongdi.png")

		self._armyBg:setScale(0.65)
		self._role:addChild(self._armyBg, 998)
	end

	if self._army == nil then
		self._army = display.newSprite()

		self._army:setScale(0.65)
		self._role:addChild(self._army, 999)
	end

	local var_4_4 = var_4_0.troop_type or 1

	if var_4_4 and var_0_3[var_4_4] then
		self._army:setSpriteFrame(var_0_3[var_4_4])
	else
		self._army:setVisible(false)
	end

	local var_4_5 = self._cacheArgs.roleType or 1

	if var_0_2[var_4_5] then
		self._role:setSpriteFrame(var_0_2[var_4_5].camp)
		self._bar:setSpriteFrame(var_0_2[var_4_5].blood)
		self:_createHpBar()
	end

	local var_4_6 = self._role:getContentSize()

	self._bar:setPosition(cc.p(var_4_6.width / 2, var_4_6.height / 2))
	self._head:setPosition(cc.p(var_4_6.width / 2, var_4_6.height / 2))
	self._roleBg:setPosition(cc.p(var_4_6.width / 2, var_4_6.height / 2))
	self._army:setPosition(cc.p(var_4_6.width - 15, 15))
	self._armyBg:setPosition(cc.p(var_4_6.width - 15, 15))

	if self._cacheArgs and self._cacheArgs.scale then
		self._role:setScale(self._cacheArgs.scale)
	end

	if var_4_0 and self._cacheArgs.attackData then
		self:_playAttack()

		self._cacheArgs.attackData = nil
	end
end

function NewSlgIconNode:_playAttack()
	local var_5_0 = self._cacheArgs
	local var_5_1 = self._cacheArgs.attackData
	local var_5_2 = self._cacheArgs.roleType == g.core.const.ConstMgr.NewSlgConst.BATTLE_PLAYER_TYPE.ENEMY and not var_5_1.cityAttack and -1 or 1
	local var_5_3 = 0

	if self._cacheArgs.attackData.direction then
		var_5_3 = require("app.view.module.slg.const.NewSlgFunc").vectorToAngle(var_5_1.direction)
	else
		self:_createHpBar()
	end

	local function var_5_4(arg_6_0)
		return cc.p(arg_6_0.x * math.cos(var_5_3 * math.pi / 180) - arg_6_0.y * math.sin(var_5_3 * math.pi / 180), arg_6_0.x * math.sin(var_5_3 * math.pi / 180) + arg_6_0.y * math.cos(var_5_3 * math.pi / 180))
	end

	local var_5_5 = self._role:getScaleX()

	self._role:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, var_5_4(cc.p(24 * var_5_2, 0))), cc.Spawn:create(cc.MoveTo:create(0.1, var_5_4(cc.p(120 * var_5_2, 0))), (cc.ScaleTo:create(0.1, var_5_5 * 0.63, var_5_5 * 1.2))), cc.CallFunc:create(handler(self, function(arg_7_0)
		arg_7_0._role:setScale(arg_7_0._cacheArgs.scale)

		if arg_7_0._progress then
			arg_7_0._progress:setPercentage(math.max(var_5_0.fillRange, 0) * 100)
		end

		if var_5_1.hitCall then
			var_5_1.hitCall()
		end

		if var_5_1.showDeath then
			arg_7_0:_playDieAni()
		end

		if var_5_1.continueKill then
			print("播放连杀动画")
		end
	end)), cc.Spawn:create(cc.MoveTo:create(0.13, var_5_4(cc.p(100 * var_5_2, 0))), (cc.ScaleTo:create(0.13, var_5_5 * 1.2, var_5_5))), cc.Spawn:create(cc.MoveTo:create(0.06, var_5_4(cc.p(13.5 * var_5_2, 0))), (cc.ScaleTo:create(0.06, var_5_5 * 0.97, var_5_5))), (cc.Spawn:create(cc.MoveTo:create(0.06, cc.p(0, 0)), (cc.ScaleTo:create(0.06, var_5_5, var_5_5))))))
end

function NewSlgIconNode:setHp(arg_8_1, arg_8_2)
	self._cacheArgs.fillRange = arg_8_2 / arg_8_1
	self._cacheArgs.scale = self:getHeadScale(arg_8_2)

	self:_updateView()
end

function NewSlgIconNode:setBattlePosition(arg_9_1)
	self:setPosition(cc.p(self:getBattlePositionX(arg_9_1), 0))
end

function NewSlgIconNode:getBattlePositionX(arg_10_1)
	return arg_10_1 + (arg_10_1 < 0 and -1 or 1) * (50 * (self._cacheArgs.scale or 1))
end

function NewSlgIconNode:attack(arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 ~= nil and arg_11_3 ~= nil then
		self._cacheArgs.fillRange = arg_11_3 / arg_11_2
		self._cacheArgs.scale = self:getHeadScale(arg_11_3)
	end

	self._cacheArgs.attackData = arg_11_1

	self:_updateView()
end

function NewSlgIconNode:getHeadParam(arg_12_1)
	return (self._authority * (var_0_1:getNewSlgParamsValueByKey("show_parameter_1") / var_0_1:getMaxTeamAuthority() / 10000) + 0.5) * (arg_12_1 * (var_0_1:getNewSlgParamsValueByKey("show_parameter_2") / g.core.model.User.newSlgData:getSlgInfo().max_arrmy / 10000) + 0.5)
end

function NewSlgIconNode:getHeadScale(arg_13_1)
	local var_13_0 = self:getHeadParam(arg_13_1)

	if var_13_0 < 0.5 then
		var_13_0 = 0.5
	end

	if var_13_0 > 1 then
		var_13_0 = 1
	end

	return math.sqrt(var_13_0)
end

function NewSlgIconNode:_createHpBar()
	if self._bar then
		self._bar:setVisible(false)
	end

	local var_14_0 = self._cacheArgs.roleType or 1

	if self._curType ~= var_14_0 then
		self._progress:removeFromParent()

		self._progress = nil
	end

	if self._progress == nil then
		self._progress = g.core.common.GlobalFunc.createCircleProgressBar("#" .. var_0_2[var_14_0].blood)
		self._curType = var_14_0

		self._role:addChild(self._progress)
		self._progress:setPosition(cc.p(self._role:getContentSize().width / 2, self._role:getContentSize().height / 2))
		self._progress:setPercentage(100)
	end
end

function NewSlgIconNode:_playDieAni()
	local var_15_0

	var_15_0 = require("app.view.common.SpineBase").new({
		anim = "play",
		isLoop = false,
		resId = "eff_ui_newSlg_dead",
		path = g.core.common.Path:getEffSpine("eff_ui_newSlg_dead"),
		listener = function(self)
			if self.type == "complete" then
				var_15_0:removeFromParent(true)
			end
		end
	})

	;(nil):setScale(self._role:getScale())
	var_15_0:setPosition(cc.p(self._role:getContentSize().width / 2, self._role:getContentSize().height / 2))
	self._role:addChild(var_15_0)
end

return NewSlgIconNode
