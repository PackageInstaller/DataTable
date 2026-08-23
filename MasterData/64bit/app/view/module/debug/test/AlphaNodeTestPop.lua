local AlphaNodeTestPop = class("AlphaNodeTestPop", require("app.fairyGUI.debug.UI_ComTestPop"), function()
	return fgui.GComponent:create({
		pkgName = "debug",
		pkgPath = "ui/debug/debug",
		resName = "ComTestPop"
	})
end)

function AlphaNodeTestPop:ctor(arg_2_1)
	self._rootNode = nil

	self:initComTest()
end

function AlphaNodeTestPop:onLoad()
	self:_initRegisterMSG()
	self:scheduleUpdate()
end

function AlphaNodeTestPop:onUnload()
	self:unscheduleUpdate()
end

function AlphaNodeTestPop:receiveCompEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "UI_REBEL_" then
		-- block empty
	end
end

function AlphaNodeTestPop:onScheduleUpdate(arg_6_1)
	return
end

function AlphaNodeTestPop:initComTest()
	self:_initComData()
	self:_initComUI()
end

function AlphaNodeTestPop:_initComData()
	self:_buildComElem()
end

function AlphaNodeTestPop:_initComUI()
	self.m_testBtn:addClickListener(handler(self, self._onStartTestClick))
end

function AlphaNodeTestPop:_initRegisterMSG()
	return
end

function AlphaNodeTestPop:_buildComElem()
	self:_buildScreenElem()
end

function AlphaNodeTestPop:_onStartTestClick()
	self:_testScreen()
end

function AlphaNodeTestPop:_buildAlphaNodeElem()
	print("display.width = ", display.width, "  display.height = ", display.height)

	local var_13_0 = cc.LayerColor:create(cc.c4b(255, 255, 255, 255), display.width, display.height)

	var_13_0:setPosition(-display.width / 2, -display.height / 2)
	self:addNode(var_13_0, -10)

	local var_13_1 = cc.LayerColor:create(cc.c4b(0, 250, 0, 255), 900, 500)

	var_13_1:setPosition(-900 / 2, -500 / 2)
	self:addNode(var_13_1, -2)

	local var_13_2 = cc.AlphaNode:create()
	local var_13_3 = {
		y = -20,
		width = 0,
		height = 40
	}

	var_13_3.x = -0

	var_13_2:showChangingVertRect(var_13_3, 230)
	self.m_holdComp:addNode(var_13_2)

	self._rootNode = var_13_2

	local var_13_4 = cc.Sprite:create("pic/bio/dongxi_9.png")

	var_13_4:setPosition(-900 / 2, -500 / 2)
	self._rootNode:addChild(var_13_4)

	local var_13_5 = cc.Sprite:create("pic/bio/dongxi_9.png")

	var_13_5:setPosition(900 / 2, 500 / 2)
	self._rootNode:addChild(var_13_5)

	local var_13_6 = require("app.view.common.SpineBase").new({
		path = "battle/knight_spine/400050/400050",
		anim = "idle",
		resId = "400050",
		isLoop = true
	})

	var_13_6:setPosition(0, 0)
	self._rootNode:addChild(var_13_6)
end

function AlphaNodeTestPop:_testAlphaNode()
	self:_captchAlphaNode()

	local var_14_0, var_14_1 = self._rootNode:getPosition()

	print("_rootNode .x == ", var_14_0)
	self._rootNode:setPosition(var_14_0 + 200, var_14_1)
end

function AlphaNodeTestPop:_captchAlphaNode()
	local var_15_0 = cc.utils:captureNodeCC(g.core.layer.LayerManager:getRunningScene())
	local var_15_1 = cc.Texture2D:new()

	var_15_1:initWithImage(var_15_0)
	var_15_0:saveToFile("hyANode1.png")
	var_15_0:release()

	local var_15_2 = cc.Sprite:createWithTexture(var_15_1)

	dump((var_15_2:getTexture():getContentSize()))
	self:addNode(var_15_2, -1)
end

function AlphaNodeTestPop:_buildScreenElem()
	local var_16_0 = cc.LayerColor:create(cc.c4b(255, 255, 255, 255), display.width, display.height)

	var_16_0:setPosition(-display.width / 2, -display.height / 2)
	self:addNode(var_16_0, -10)

	local var_16_1 = cc.LayerColor:create(cc.c4b(0, 250, 0, 255), 900, 500)

	var_16_1:setPosition(-900 / 2, -500 / 2)
	self:addNode(var_16_1, -2)

	local var_16_2 = {}

	var_16_2.resId = 500110
	var_16_2.isAlphaNode = true
	var_16_2.isReverse = true
	var_16_2.ignorePosByCfg = true

	local var_16_3 = require("app.view.common.DrawKnight").new(var_16_2)

	var_16_3:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-100, 0, 200, 0), 100)
	self.m_holdComp:addChild(var_16_3)

	self._rootNode = var_16_3

	local var_16_4 = self._rootNode:displayObject()
	local var_16_5 = cc.Sprite:create("pic/bio/dongxi_9.png")

	var_16_5:setPosition(-900 / 2, -500 / 2)
	var_16_4:addChild(var_16_5)

	local var_16_6 = cc.Sprite:create("pic/bio/dongxi_9.png")

	var_16_6:setPosition(-900 / 2, 500 / 2)
	var_16_4:addChild(var_16_6)

	local var_16_7 = cc.BlurNode:create(cc.size(400, 400), 10)

	var_16_7:setPosition(-200, -200)
	self.m_holdComp:addNode(var_16_7)
end

function AlphaNodeTestPop:_testScreen()
	self:_captchScreen()

	local var_17_0 = self._rootNode:getPosition()

	self._rootNode:setPosition(var_17_0.x + 200, var_17_0.y)
end

function AlphaNodeTestPop:_captchScreen()
	local var_18_0 = cc.utils:captureNodeCC(g.core.layer.LayerManager:getRunningScene())
	local var_18_1 = cc.Texture2D:new()

	var_18_1:initWithImage(var_18_0)
	var_18_0:saveToFile("hyScreen1.png")
	var_18_0:release()

	local var_18_2 = cc.Sprite:createWithTexture(var_18_1)

	dump((var_18_2:getTexture():getContentSize()))
	self:addNode(var_18_2, -1)
end

function AlphaNodeTestPop:_buildRichTextElem()
	self.m_rtxt:setText("dafwafajcajfjkjwafjewjfwjkfjsafewajrkwajrjawwajflkajwgjwakjg<a href='上传'>fafaeserhresjflkjaejfwajjwatjewjtjewatjwatjwajt</a>")
end

function AlphaNodeTestPop:_onRichTextClick()
	self._strIdx = self._strIdx and self._strIdx < 4 and self._strIdx + 1 or 1

	self.m_rtxt:setText(({
		"000你的是请阿飞分为五级二零客机我服务经费微积分v访问妇女我发界外球疯狂我就放弃微风威锋网假期<a href='上传'>查询</a>",
		"111你的是请阿飞分为五级二零客机我服务经费微积分v访问妇女我发界外球疯狂我就放弃微风威锋网假期期间服务带我去服务器",
		"222你的是请阿飞分为五级外球疯狂我就放弃微风威锋网假期<a href='上传'>hawfhwhdwqhdqwhdhwqjdwqjdwqjewqjewqjwqhrhwqeqqjrq</a>二零客机我服务经费微积分v访问妇女我发界",
		"333你的是请阿飞分为五级二零客机我服务经费微积分v访问妇女我发界外球22年球季期间放弃就放弃及服务气氛较为强劲"
	})[self._strIdx])
end

local var_0_1 = -50

function AlphaNodeTestPop:_testMoveNode()
	local var_21_0 = self.m_holdComp:getPosition()

	if var_21_0.x < -900 or var_21_0.x > 1900 then
		var_0_1 = var_0_1 * -1
	end

	var_21_0.x = var_21_0.x + var_0_1

	self.m_holdComp:setPosition(var_21_0)
end

function AlphaNodeTestPop:_buildBaseElem()
	local var_22_0 = cc.LayerColor:create(cc.c4b(255, 255, 255, 255), display.width, display.height)

	var_22_0:setPosition(-display.width / 2, -display.height / 2)
	self.m_holdComp:addNode(var_22_0)

	local var_22_1 = cc.LayerColor:create(cc.c4b(18, 200, 16, 255), 1200, 500)

	var_22_1:setPosition(-600, -250)
	self.m_holdComp:addNode(var_22_1)

	local var_22_2 = cc.Node:create()

	self.m_holdComp:addNode(var_22_2)

	self._rootNode = var_22_2

	var_22_2:setPosition(0, 0)
	self._rootNode:addChild((cc.Sprite:create("pic/bio/dongxi_9.png")))

	local var_22_3 = cc.AlphaNode:create()

	self.m_holdComp:addNode(var_22_3)
	var_22_3:setPosition(-30, 20)
	var_22_3:addChild((cc.Sprite:create("pic/bio/dongxi_9.png")))

	local var_22_4 = cc.Sprite:create("pic/bio/dongxi_9.png")

	var_22_4:setPosition(-display.width / 2, -display.height / 2)
	var_22_3:addChild(var_22_4)

	local var_22_5 = cc.Sprite:create("pic/bio/dongxi_9.png")

	var_22_5:setPosition(-display.width / 2, display.height / 2)
	var_22_3:addChild(var_22_5)

	local var_22_6 = cc.Sprite:create("pic/bio/dongxi_9.png")

	var_22_6:setPosition(display.width / 2, display.height / 2)
	var_22_3:addChild(var_22_6)

	local var_22_7 = cc.Sprite:create("pic/bio/dongxi_9.png")

	var_22_7:setPosition(display.width / 2, -display.height / 2)
	var_22_3:addChild(var_22_7)

	self._rootNode = var_22_3
end

function AlphaNodeTestPop:_buildDrawKnightElem()
	local var_23_0 = cc.LayerColor:create(cc.c4b(255, 255, 255, 255), display.width, display.height)

	var_23_0:setPosition(-display.width / 2, -display.height / 2)
	self:addNode(var_23_0, -10)

	local var_23_2 = {}

	var_23_2.resId = 500110
	var_23_2.isAlphaNode = true
	var_23_2.ignorePosByCfg = true

	local var_23_3 = require("app.view.common.DrawKnight").new(var_23_2)

	self.m_holdComp:addChild(var_23_3)

	local var_23_4 = cc.Sprite:create("icon/advance_material/253.png")

	var_23_4:setScale(0.2)
	var_23_4:setPosition(200, 0)
	var_23_3._knightSpine._nodeRoot:addChild(var_23_4)
	var_23_3:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON)
end

return AlphaNodeTestPop
