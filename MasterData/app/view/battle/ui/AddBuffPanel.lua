local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_1 = g.core.common.Color
local var_0_2 = load("core.fight.FightComponent")
local var_0_3 = load("core.player.PlayerFactory")
local var_0_4 = load("core.command.CommandComponent")
local var_0_5 = load("core.fight.FightTarget")
local AddBuffPanel = class("AddBuffPanel", function()
	return cc.Node:create()
end)

function AddBuffPanel:ctor()
	self._battleLayer = nil
	self._knightSelectpos = 0

	self:setContentSize(500, 500)

	local var_2_0 = cc.DrawNode:create()

	self:addChild(var_2_0)
	var_2_0:drawSolidRect(cc.p(0, 0), cc.p(500, 500), cc.c4f(0, 0, 0, 0.8))
end

function AddBuffPanel:init(arg_3_1)
	self._battleLayer = arg_3_1
	self._battleField = arg_3_1._battleField

	self:_updateBuffId()
	self:_updateSelfKnightSelect()
	self:_updateEnemyKnightSelect()
end

function AddBuffPanel:_updateBuffId()
	local var_4_0 = ccui.Text:create("请勾选buff施加者武将：", BattleConst.FONT, 18)

	var_4_0:setTextColor(var_0_1.hexToCC3(var_0_1.ui[1]))
	var_4_0:setAnchorPoint(0.5, 0)
	self:addChild(var_4_0)
	var_4_0:setPosition(140, 480)

	local var_4_1 = ccui.TextField:create("buffID:", BattleConst.FONT, 20)

	var_4_1:setPosition(0, 150)
	var_4_1:setAnchorPoint(0, 0)
	self:addChild(var_4_1)

	local var_4_2 = ccui.TextField:create("输入buffID", BattleConst.FONT, 20)

	var_4_2:setPosition(200, 150)
	var_4_2:setAnchorPoint(0.5, 0)
	self:addChild(var_4_2)

	self._buffId = var_4_2

	local var_4_3 = ccui.TextField:create("范围:", BattleConst.FONT, 20)

	var_4_3:setPosition(0, 130)
	var_4_3:setAnchorPoint(0, 0)
	self:addChild(var_4_3)

	local var_4_4 = ccui.TextField:create("输入buff释放范围type", BattleConst.FONT, 20)

	var_4_4:setPosition(200, 130)
	var_4_4:setAnchorPoint(0.5, 0)
	self:addChild(var_4_4)

	self._buffTargeType = var_4_4

	local var_4_5 = ccui.TextField:create("回合:", BattleConst.FONT, 20)

	var_4_5:setPosition(0, 110)
	var_4_5:setAnchorPoint(0, 0)
	self:addChild(var_4_5)

	local var_4_6 = ccui.TextField:create("输入buff持续回合", BattleConst.FONT, 20)

	var_4_6:setPosition(200, 110)
	var_4_6:setAnchorPoint(0.5, 0)
	self:addChild(var_4_6)

	self._buffTime = var_4_6

	local var_4_7 = ccui.TextField:create("层数:", BattleConst.FONT, 20)

	var_4_7:setPosition(0, 90)
	var_4_7:setAnchorPoint(0, 0)
	self:addChild(var_4_7)

	local var_4_8 = ccui.TextField:create("输入buff添加层数", BattleConst.FONT, 20)

	var_4_8:setPosition(200, 90)
	var_4_8:setAnchorPoint(0.5, 0)
	self:addChild(var_4_8)

	self._buffCount = var_4_8

	local var_4_9 = ccui.Button:create()

	var_4_9:setZoomScale(0)
	var_4_9:ignoreContentAdaptWithSize(false)
	var_4_9:setContentSize(250, 72)
	self:addChild(var_4_9)
	var_4_9:setPosition(180, 50)

	local var_4_10 = display.newSprite("battle/common/bg_zdlm_skill04.png")

	var_4_10:setAnchorPoint(0, 0)
	var_4_9:addChild(var_4_10)
	var_4_10:setPosition(0, 0)

	local var_4_11 = ccui.Text:create("点击一键上buff", BattleConst.FONT, 18)

	var_4_11:setTextColor(var_0_1.hexToCC3(var_0_1.ui[1]))
	var_4_11:setAnchorPoint(0.5, 0)
	var_4_9:addChild(var_4_11)
	var_4_11:setPosition(100, 15)
	var_4_9:addClickEventListener(function()
		local var_5_0 = self._battleField._battleData:getKnightByIdAndPos(self._knightSelectpos < 7 and 1 or 2, self._knightSelectpos % 10)
		local var_5_1 = tonumber(self._buffTime:getString())
		local var_5_2 = tonumber(self._buffCount:getString())
		local var_5_3 = self._buffId:getString()

		for iter_5_0, iter_5_1 in ipairs((var_0_5.getVictimTargets({
			range = tonumber(self._buffTargeType:getString()),
			attacker = var_5_0,
			battleData = self._battleField:getBattleData(),
			battleField = self._battleField,
			targets = {}
		}))) do
			local var_5_4 = {
				buffId = tonumber(var_5_3),
				buffTime = var_5_1,
				victim = iter_5_1.victim,
				attacker = var_5_0,
				params = {}
			}
			local var_5_5 = var_0_2.fight(var_0_3.createPlayerCommand({
				identity = 1,
				skillId = 1001,
				id = 1001,
				tp = 1,
				attack_count = self._battleField._attackCount,
				battleField = self._battleField,
				battleData = self._battleField:getBattleData()
			}), self._battleField:getBattleData(), self._battleField)

			for iter_5_2 = 1, var_5_2 do
				var_5_5:addBuff(var_5_4)
			end

			var_5_5:update()

			local var_5_6 = var_0_4.create()

			var_5_6:addFightCommand(var_5_5)
			var_5_6:setDebugAddBuff()
			self._battleLayer:_playAttackAnime(var_5_6:pack())
		end
	end)

	local var_4_12 = ccui.TextField:create("输入目标出手次数", BattleConst.FONT, 20)

	var_4_12:setPosition(400, 90)
	var_4_12:setAnchorPoint(0.5, 0)
	self:addChild(var_4_12)

	self._attackCount = var_4_12

	local var_4_13 = ccui.Button:create()

	var_4_13:setZoomScale(0)
	var_4_13:ignoreContentAdaptWithSize(false)
	var_4_13:setContentSize(250, 72)
	self:addChild(var_4_13)
	var_4_13:setPosition(450, 50)

	local var_4_14 = display.newSprite("battle/common/bg_zdlm_skill04.png")

	var_4_14:setAnchorPoint(0, 0)
	var_4_13:addChild(var_4_14)
	var_4_14:setPosition(0, 0)

	local var_4_15 = ccui.Text:create("点击设置目标出手次数", BattleConst.FONT, 18)

	var_4_15:setTextColor(var_0_1.hexToCC3(var_0_1.ui[1]))
	var_4_15:setAnchorPoint(0.5, 0)
	var_4_13:addChild(var_4_15)
	var_4_15:setPosition(100, 15)
	var_4_13:addClickEventListener(function()
		self._battleLayer:setDebugAttackCount((tonumber(self._attackCount:getString())))
	end)
end

function AddBuffPanel:_refreshCheckBox(arg_7_1)
	self._knightSelectpos = arg_7_1

	self._frontCross1:setVisible(arg_7_1 == 1)
	self._frontCross2:setVisible(arg_7_1 == 2)
	self._frontCross3:setVisible(arg_7_1 == 3)
	self._frontCross4:setVisible(arg_7_1 == 4)
	self._frontCross5:setVisible(arg_7_1 == 5)
	self._frontCross6:setVisible(arg_7_1 == 6)
	self._frontCross7:setVisible(arg_7_1 == 11)
	self._frontCross8:setVisible(arg_7_1 == 12)
	self._frontCross9:setVisible(arg_7_1 == 13)
	self._frontCross10:setVisible(arg_7_1 == 14)
	self._frontCross11:setVisible(arg_7_1 == 15)
	self._frontCross12:setVisible(arg_7_1 == 16)
end

function AddBuffPanel:_updateSelfKnightSelect()
	local var_8_0 = ccui.Button:create()

	var_8_0:setZoomScale(0)
	var_8_0:ignoreContentAdaptWithSize(false)
	var_8_0:setContentSize(108, 28)
	self:addChild(var_8_0)
	var_8_0:setPosition(70, 450)

	local var_8_1 = display.newSprite("battle/common/bg_tubiaodi.png")

	var_8_0:addChild(var_8_1)
	var_8_1:setPosition(12, 18)
	var_8_1:setScale(0.8)

	local var_8_2 = display.newSprite("battle/common/icon_nuqi_1.png")

	var_8_2:setScale(0.48)
	var_8_2:setPosition(12, 18)
	var_8_0:addChild(var_8_2)
	var_8_2:setVisible(false)

	self._frontCross1 = var_8_2

	local var_8_3 = ccui.Text:create("武将1", BattleConst.FONT, 18)

	var_8_3:setTextColor(var_0_1.hexToCC3(var_0_1.ui[1]))
	var_8_3:setAnchorPoint(0, 0)
	var_8_0:addChild(var_8_3)
	var_8_3:setPosition(32, 8)
	var_8_0:addClickEventListener(function()
		self:_refreshCheckBox(1)
	end)

	local var_8_4 = ccui.Button:create()

	var_8_4:setZoomScale(0)
	var_8_4:ignoreContentAdaptWithSize(false)
	var_8_4:setContentSize(108, 28)
	self:addChild(var_8_4)
	var_8_4:setPosition(70, 400)

	local var_8_5 = display.newSprite("battle/common/bg_tubiaodi.png")

	var_8_4:addChild(var_8_5)
	var_8_5:setPosition(12, 18)
	var_8_5:setScale(0.8)

	local var_8_6 = display.newSprite("battle/common/icon_nuqi_1.png")

	var_8_6:setScale(0.48)
	var_8_6:setPosition(12, 18)
	var_8_4:addChild(var_8_6)
	var_8_6:setVisible(false)

	self._frontCross2 = var_8_6

	local var_8_7 = ccui.Text:create("武将2", BattleConst.FONT, 18)

	var_8_7:setTextColor(var_0_1.hexToCC3(var_0_1.ui[1]))
	var_8_7:setAnchorPoint(0, 0)
	var_8_4:addChild(var_8_7)
	var_8_7:setPosition(32, 8)
	var_8_4:addClickEventListener(function()
		self:_refreshCheckBox(2)
	end)

	local var_8_8 = ccui.Button:create()

	var_8_8:setZoomScale(0)
	var_8_8:ignoreContentAdaptWithSize(false)
	var_8_8:setContentSize(108, 28)
	self:addChild(var_8_8)
	var_8_8:setPosition(70, 350)

	local var_8_9 = display.newSprite("battle/common/bg_tubiaodi.png")

	var_8_8:addChild(var_8_9)
	var_8_9:setPosition(12, 18)
	var_8_9:setScale(0.8)

	local var_8_10 = display.newSprite("battle/common/icon_nuqi_1.png")

	var_8_10:setScale(0.48)
	var_8_10:setPosition(12, 18)
	var_8_8:addChild(var_8_10)
	var_8_10:setVisible(false)

	self._frontCross3 = var_8_10

	local var_8_11 = ccui.Text:create("武将3", BattleConst.FONT, 18)

	var_8_11:setTextColor(var_0_1.hexToCC3(var_0_1.ui[1]))
	var_8_11:setAnchorPoint(0, 0)
	var_8_8:addChild(var_8_11)
	var_8_11:setPosition(32, 8)
	var_8_8:addClickEventListener(function()
		self:_refreshCheckBox(3)
	end)

	local var_8_12 = ccui.Button:create()

	var_8_12:setZoomScale(0)
	var_8_12:ignoreContentAdaptWithSize(false)
	var_8_12:setContentSize(108, 28)
	self:addChild(var_8_12)
	var_8_12:setPosition(70, 300)

	local var_8_13 = display.newSprite("battle/common/bg_tubiaodi.png")

	var_8_12:addChild(var_8_13)
	var_8_13:setPosition(12, 18)
	var_8_13:setScale(0.8)

	local var_8_14 = display.newSprite("battle/common/icon_nuqi_1.png")

	var_8_14:setScale(0.48)
	var_8_14:setPosition(12, 18)
	var_8_12:addChild(var_8_14)
	var_8_14:setVisible(false)

	self._frontCross4 = var_8_14

	local var_8_15 = ccui.Text:create("武将4", BattleConst.FONT, 18)

	var_8_15:setTextColor(var_0_1.hexToCC3(var_0_1.ui[1]))
	var_8_15:setAnchorPoint(0, 0)
	var_8_12:addChild(var_8_15)
	var_8_15:setPosition(32, 8)
	var_8_12:addClickEventListener(function()
		self:_refreshCheckBox(4)
	end)

	local var_8_16 = ccui.Button:create()

	var_8_16:setZoomScale(0)
	var_8_16:ignoreContentAdaptWithSize(false)
	var_8_16:setContentSize(108, 28)
	self:addChild(var_8_16)
	var_8_16:setPosition(70, 250)

	local var_8_17 = display.newSprite("battle/common/bg_tubiaodi.png")

	var_8_16:addChild(var_8_17)
	var_8_17:setPosition(12, 18)
	var_8_17:setScale(0.8)

	local var_8_18 = display.newSprite("battle/common/icon_nuqi_1.png")

	var_8_18:setScale(0.48)
	var_8_18:setPosition(12, 18)
	var_8_16:addChild(var_8_18)
	var_8_18:setVisible(false)

	self._frontCross5 = var_8_18

	local var_8_19 = ccui.Text:create("武将5", BattleConst.FONT, 18)

	var_8_19:setTextColor(var_0_1.hexToCC3(var_0_1.ui[1]))
	var_8_19:setAnchorPoint(0, 0)
	var_8_16:addChild(var_8_19)
	var_8_19:setPosition(32, 8)
	var_8_16:addClickEventListener(function()
		self:_refreshCheckBox(5)
	end)

	local var_8_20 = ccui.Button:create()

	var_8_20:setZoomScale(0)
	var_8_20:ignoreContentAdaptWithSize(false)
	var_8_20:setContentSize(108, 28)
	self:addChild(var_8_20)
	var_8_20:setPosition(70, 200)

	local var_8_21 = display.newSprite("battle/common/bg_tubiaodi.png")

	var_8_20:addChild(var_8_21)
	var_8_21:setPosition(12, 18)
	var_8_21:setScale(0.8)

	local var_8_22 = display.newSprite("battle/common/icon_nuqi_1.png")

	var_8_22:setScale(0.48)
	var_8_22:setPosition(12, 18)
	var_8_20:addChild(var_8_22)
	var_8_22:setVisible(false)

	self._frontCross6 = var_8_22

	local var_8_23 = ccui.Text:create("武将6", BattleConst.FONT, 18)

	var_8_23:setTextColor(var_0_1.hexToCC3(var_0_1.ui[1]))
	var_8_23:setAnchorPoint(0, 0)
	var_8_20:addChild(var_8_23)
	var_8_23:setPosition(32, 8)
	var_8_20:addClickEventListener(function()
		self:_refreshCheckBox(6)
	end)
end

function AddBuffPanel:_updateEnemyKnightSelect()
	local var_15_0 = ccui.Button:create()

	var_15_0:setZoomScale(0)
	var_15_0:ignoreContentAdaptWithSize(false)
	var_15_0:setContentSize(108, 28)
	self:addChild(var_15_0)
	var_15_0:setPosition(250, 450)

	local var_15_1 = display.newSprite("battle/common/bg_tubiaodi.png")

	var_15_0:addChild(var_15_1)
	var_15_1:setPosition(12, 18)
	var_15_1:setScale(0.8)

	local var_15_2 = display.newSprite("battle/common/icon_nuqi_1.png")

	var_15_2:setScale(0.48)
	var_15_2:setPosition(12, 18)
	var_15_0:addChild(var_15_2)
	var_15_2:setVisible(false)

	self._frontCross7 = var_15_2

	local var_15_3 = ccui.Text:create("武将7", BattleConst.FONT, 18)

	var_15_3:setTextColor(var_0_1.hexToCC3(var_0_1.ui[1]))
	var_15_3:setAnchorPoint(0, 0)
	var_15_0:addChild(var_15_3)
	var_15_3:setPosition(32, 8)
	var_15_0:addClickEventListener(function()
		self:_refreshCheckBox(11)
	end)

	local var_15_4 = ccui.Button:create()

	var_15_4:setZoomScale(0)
	var_15_4:ignoreContentAdaptWithSize(false)
	var_15_4:setContentSize(108, 28)
	self:addChild(var_15_4)
	var_15_4:setPosition(250, 400)

	local var_15_5 = display.newSprite("battle/common/bg_tubiaodi.png")

	var_15_4:addChild(var_15_5)
	var_15_5:setPosition(12, 18)
	var_15_5:setScale(0.8)

	local var_15_6 = display.newSprite("battle/common/icon_nuqi_1.png")

	var_15_6:setScale(0.48)
	var_15_6:setPosition(12, 18)
	var_15_4:addChild(var_15_6)
	var_15_6:setVisible(false)

	self._frontCross8 = var_15_6

	local var_15_7 = ccui.Text:create("武将8", BattleConst.FONT, 18)

	var_15_7:setTextColor(var_0_1.hexToCC3(var_0_1.ui[1]))
	var_15_7:setAnchorPoint(0, 0)
	var_15_4:addChild(var_15_7)
	var_15_7:setPosition(32, 8)
	var_15_4:addClickEventListener(function()
		self:_refreshCheckBox(12)
	end)

	local var_15_8 = ccui.Button:create()

	var_15_8:setZoomScale(0)
	var_15_8:ignoreContentAdaptWithSize(false)
	var_15_8:setContentSize(108, 28)
	self:addChild(var_15_8)
	var_15_8:setPosition(250, 350)

	local var_15_9 = display.newSprite("battle/common/bg_tubiaodi.png")

	var_15_8:addChild(var_15_9)
	var_15_9:setPosition(12, 18)
	var_15_9:setScale(0.8)

	local var_15_10 = display.newSprite("battle/common/icon_nuqi_1.png")

	var_15_10:setScale(0.48)
	var_15_10:setPosition(12, 18)
	var_15_8:addChild(var_15_10)
	var_15_10:setVisible(false)

	self._frontCross9 = var_15_10

	local var_15_11 = ccui.Text:create("武将9", BattleConst.FONT, 18)

	var_15_11:setTextColor(var_0_1.hexToCC3(var_0_1.ui[1]))
	var_15_11:setAnchorPoint(0, 0)
	var_15_8:addChild(var_15_11)
	var_15_11:setPosition(32, 8)
	var_15_8:addClickEventListener(function()
		self:_refreshCheckBox(13)
	end)

	local var_15_12 = ccui.Button:create()

	var_15_12:setZoomScale(0)
	var_15_12:ignoreContentAdaptWithSize(false)
	var_15_12:setContentSize(108, 28)
	self:addChild(var_15_12)
	var_15_12:setPosition(250, 300)

	local var_15_13 = display.newSprite("battle/common/bg_tubiaodi.png")

	var_15_12:addChild(var_15_13)
	var_15_13:setPosition(12, 18)
	var_15_13:setScale(0.8)

	local var_15_14 = display.newSprite("battle/common/icon_nuqi_1.png")

	var_15_14:setScale(0.48)
	var_15_14:setPosition(12, 18)
	var_15_12:addChild(var_15_14)
	var_15_14:setVisible(false)

	self._frontCross10 = var_15_14

	local var_15_15 = ccui.Text:create("武将10", BattleConst.FONT, 18)

	var_15_15:setTextColor(var_0_1.hexToCC3(var_0_1.ui[1]))
	var_15_15:setAnchorPoint(0, 0)
	var_15_12:addChild(var_15_15)
	var_15_15:setPosition(32, 8)
	var_15_12:addClickEventListener(function()
		self:_refreshCheckBox(14)
	end)

	local var_15_16 = ccui.Button:create()

	var_15_16:setZoomScale(0)
	var_15_16:ignoreContentAdaptWithSize(false)
	var_15_16:setContentSize(108, 28)
	self:addChild(var_15_16)
	var_15_16:setPosition(250, 250)

	local var_15_17 = display.newSprite("battle/common/bg_tubiaodi.png")

	var_15_16:addChild(var_15_17)
	var_15_17:setPosition(12, 18)
	var_15_17:setScale(0.8)

	local var_15_18 = display.newSprite("battle/common/icon_nuqi_1.png")

	var_15_18:setScale(0.48)
	var_15_18:setPosition(12, 18)
	var_15_16:addChild(var_15_18)
	var_15_18:setVisible(false)

	self._frontCross11 = var_15_18

	local var_15_19 = ccui.Text:create("武将11", BattleConst.FONT, 18)

	var_15_19:setTextColor(var_0_1.hexToCC3(var_0_1.ui[1]))
	var_15_19:setAnchorPoint(0, 0)
	var_15_16:addChild(var_15_19)
	var_15_19:setPosition(32, 8)
	var_15_16:addClickEventListener(function()
		self:_refreshCheckBox(15)
	end)

	local var_15_20 = ccui.Button:create()

	var_15_20:setZoomScale(0)
	var_15_20:ignoreContentAdaptWithSize(false)
	var_15_20:setContentSize(108, 28)
	self:addChild(var_15_20)
	var_15_20:setPosition(250, 200)

	local var_15_21 = display.newSprite("battle/common/bg_tubiaodi.png")

	var_15_20:addChild(var_15_21)
	var_15_21:setPosition(12, 18)
	var_15_21:setScale(0.8)

	local var_15_22 = display.newSprite("battle/common/icon_nuqi_1.png")

	var_15_22:setScale(0.48)
	var_15_22:setPosition(12, 18)
	var_15_20:addChild(var_15_22)
	var_15_22:setVisible(false)

	self._frontCross12 = var_15_22

	local var_15_23 = ccui.Text:create("武将12", BattleConst.FONT, 18)

	var_15_23:setTextColor(var_0_1.hexToCC3(var_0_1.ui[1]))
	var_15_23:setAnchorPoint(0, 0)
	var_15_20:addChild(var_15_23)
	var_15_23:setPosition(32, 8)
	var_15_20:addClickEventListener(function()
		self:_refreshCheckBox(16)
	end)
end

return AddBuffPanel
