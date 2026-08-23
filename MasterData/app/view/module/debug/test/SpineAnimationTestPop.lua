local BattleKnight = require("app.view.battle.BattleKnight")
local SpineAnimationTestPop = class("SpineAnimationTestPop", require("app.fairyGUI.debug.UI_SpineAnimationTestPop"), function()
	return fgui.GComponent:create({
		resName = "SpineAnimationTestPop",
		pkgPath = "ui/debug/debug",
		pkgName = "debug"
	})
end)

function SpineAnimationTestPop:ctor(arg_2_1)
	self._rootNode = nil

	self:initComTest()
end

function SpineAnimationTestPop:onLoad()
	return
end

function SpineAnimationTestPop:onUnload()
	return
end

function SpineAnimationTestPop:receiveCompEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "UI_REBEL_" then
		-- block empty
	end
end

function SpineAnimationTestPop:initComTest()
	local var_6_0 = {
		200000,
		200003,
		200004,
		200005,
		210000,
		210003,
		210004,
		210005
	}
	local var_6_1 = {
		{
			x = -300,
			y = -200
		},
		{
			x = -100,
			y = -200
		},
		{
			x = 100,
			y = -200
		},
		{
			x = 300,
			y = -200
		},
		{
			x = -300,
			y = 100
		},
		{
			x = -100,
			y = 100
		},
		{
			x = 100,
			y = 100
		},
		{
			x = 300,
			y = 100
		}
	}

	for iter_6_0 = 1, #var_6_0 do
		self._spine = BattleKnight.new({
			resId = var_6_0[iter_6_0],
			listener = handler(self, self._onSpineEvent)
		})

		self.m_holdComp:addNode(self._spine)
		self._spine:setPosition(var_6_1[iter_6_0].x, var_6_1[iter_6_0].y)
		self._spine:setAnimation(0, "idle", true)
	end

	self.m_testBtn:addClickListener(handler(self, self._onStartTestClick))
end

function SpineAnimationTestPop:_onStartTestClick()
	g.core.module.ModuleManager:tip("remove cfg")
end

function SpineAnimationTestPop:_onSpineEvent(arg_8_1)
	if arg_8_1.eventData then
		-- block empty
	end

	if arg_8_1.type == "complete" then
		-- block empty
	end
end

return SpineAnimationTestPop
