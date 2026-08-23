local StoryRoleShowLayer = class("StoryRoleShowLayer", require("app.view.module.story.StoryStep"), require("app.fairyGUI.story.UI_StoryRoleShowLayer"), function()
	return fgui.GComponent:create({
		resName = "StoryRoleShowLayer",
		pkgPath = "ui/story/story",
		isFullScreen = true,
		pkgName = "story"
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.StoryConst

function StoryRoleShowLayer:ctor(arg_2_1)
	local var_2_0 = g.core.model.User.storyData:getEditRoleData(arg_2_1.params.role)

	var_2_0.role = arg_2_1.params.role

	self:_initView(var_2_0)
	self:_showRole(var_2_0)
end

function StoryRoleShowLayer:_initView(arg_3_1)
	self.m_roleName:setText("立绘: " .. arg_3_1.name)

	arg_3_1.maskParams = arg_3_1.maskParams or {}

	self.m_transitionText:setText("蒙版方式: " .. (arg_3_1.maskParams.name or "无"))
end

function StoryRoleShowLayer:_showRole(arg_4_1)
	local var_4_0 = fgui.UIPackage:createObject("story", "StoryDialogKnightComp", self)

	var_4_0.inTop = (tonumber(arg_4_1.top) or 0) == 1

	local var_4_1 = tonumber(arg_4_1.x) or display.width / 2
	local var_4_2 = self:formatY(tonumber(arg_4_1.y) or display.height / 2)

	var_4_0:setPosition(var_4_1, var_4_2)

	local var_4_3 = tonumber(arg_4_1.scale) or 1

	var_4_0:setScale(var_4_3, var_4_3)
	var_4_0:setSortingOrder((arg_4_1.inTop or nil) and (var_0_1.TopZOrder or math.abs(var_4_2)))
	self:addChild(var_4_0)
	var_4_0:update(arg_4_1)
end

return StoryRoleShowLayer
