local ArmatureEffectScene = class("ArmatureEffectScene", function()
	return cc.Scene:create()
end)

function ArmatureEffectScene:create()
	local var_2_0 = ArmatureEffectScene.new()

	var_2_0:init()

	return var_2_0
end

function ArmatureEffectScene:init()
	require("data.constants")
	require("controller.helper")
	require("controller.global_func")
	require("view.Layer.TalkLayer")
	require("data.language_constants")

	local armature_effect_conf = require("devtools.armature_effect_conf")

	if armature_effect_conf.bg then
		local var_3_1 = ccui.ImageView:create(armature_effect_conf.bg)

		var_3_1:setPositionX(self:getContentSize().width / 2)
		var_3_1:setPositionY(self:getContentSize().height / 2)
		self:addChild(var_3_1)
	end

	local armature_manager = require("controller.armature_manager")
	local var_3_3 = {}

	for iter_3_0, iter_3_1 in pairs(armature_effect_conf.conf) do
		if iter_3_1.type == "particle" then
			local var_3_4 = cc.ParticleSystemQuad:create(iter_3_1.path)

			var_3_4:setAutoRemoveOnFinish(true)
			var_3_4:setPosition(cc.p(iter_3_1.posx or 320, iter_3_1.posy or self:getContentSize().height / 2))
			self:addChild(var_3_4, iter_3_1.zorder)
		else
			armature_manager:setTestData(iter_3_1.name, iter_3_1)

			local var_3_6 = armature_manager:createAndPlayArmature(iter_3_1.name)

			var_3_6.name = iter_3_1.name

			if iter_3_1.posx then
				var_3_6:setPositionX(iter_3_1.posx)
			end

			if iter_3_1.posxy then
				var_3_6:setPositionY(iter_3_1.posy)
			end

			self:addChild(var_3_6, iter_3_1.zorder)
			table.insert(var_3_3, var_3_6)
		end
	end

	local var_3_7 = ccui.Layout:create()

	var_3_7:setTouchEnabled(true)
	var_3_7:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_7:setAnchorPoint(cc.p(0, 0))
	var_3_7:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_3_7:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_3_7:setBackGroundColor(cc.c3b(2, 5, 24))
	self:addChild(var_3_7, 1000000)
	var_3_7:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		for iter_4_0, iter_4_1 in pairs(var_3_3) do
			armature_manager:reStartAnim(iter_4_1, iter_4_1.name)
		end
	end)
end

return ArmatureEffectScene
