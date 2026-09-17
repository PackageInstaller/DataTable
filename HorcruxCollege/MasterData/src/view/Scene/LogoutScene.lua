LogoutScene = class("LogoutScene", function()
	return cc.Scene:create()
end)

function LogoutScene.createScene(arg_2_0, arg_2_1)
	local var_2_0 = LogoutScene.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function LogoutScene:init(arg_3_1)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
		self:purgeLuaCaches(arg_3_1)
	end)))
end

function LogoutScene:purgeLuaCaches(arg_5_1)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		require("view.Scene.LoginScene")
		cc.Director:getInstance():replaceScene(LoginScene:createScene(arg_5_1))
	end)))
end
