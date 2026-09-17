local var_0_0 = {}
local assets_manager = require("controller.updatemodule.assets_manager")
local var_0_2 = {
	old = {
		wait = "mainScenebg/login/loginwait.png",
		bg = "mainScenebg/login/default.jpg",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/loginlight.png"
	},
	default = {
		wait = "mainScenebg/login/wait3.png",
		bg = "mainScenebg/login/bg1/bg1.jpg",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light7.png"
	},
	liuli = {
		bg = "mainScenebg/login/bg6.jpg",
		wait = "mainScenebg/login/light6.png",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/wait6.png",
		bgm = "liuli"
	},
	kamila = {
		wait = "mainScenebg/login/wait1.png",
		bg = "mainScenebg/login/default.jpg",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/ligh1.png"
	},
	halloween = {
		wait = "mainScenebg/login/wait3.png",
		bg = "mainScenebg/login/default.jpg",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light7.png"
	},
	bianhua = {
		wait = "mainScenebg/login/wait3.png",
		bg = "mainScenebg/login/bianhua_bg1.png",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light7.png"
	},
	springfestival = {
		wait = "mainScenebg/login/wait3.png",
		bg = "mainScenebg/login/bianhua_bg1.png",
		logo = "mainScenebg/login/logo2.png",
		light = "mainScenebg/login/light7.png"
	},
	laila = {
		wait = "mainScenebg/login/wait4.png",
		bg = "mainScenebg/login/bg1/bg1.jpg",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light2.png"
	},
	awl = {
		wait = "mainScenebg/login/wait4.png",
		bg = "mainScenebg/login/awl.png",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light2.png"
	},
	summer = {
		wait = "mainScenebg/login/wait4.png",
		bg = "mainScenebg/login/bg1/bg1.jpg",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light4.png"
	},
	anniversary = {
		wait = "mainScenebg/login/wait6.png",
		bg = "mainScenebg/login/anniversary.png",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light6.png"
	},
	shark = {
		wait = "mainScenebg/login/wait4.png",
		bg = "mainScenebg/login/shark.png",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light4.png"
	},
	anniversary2 = {
		wait = "mainScenebg/login/wait6.png",
		bg = "mainScenebg/login/anniversary.png",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light6.png"
	},
	umaru = {
		wait = "mainScenebg/login/wait4.png",
		bg = "mainScenebg/login/umaru.png",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light6.png"
	},
	christmas = {
		wait = "mainScenebg/login/wait4.png",
		bg = "mainScenebg/login/christmas.png",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light6.png"
	},
	yuandan = {
		wait = "mainScenebg/login/wait4.png",
		bg = "mainScenebg/login/christmas.png",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light6.png"
	},
	spring2021 = {
		wait = "mainScenebg/login/wait4.png",
		bg = "mainScenebg/login/christmas.png",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light6.png"
	},
	stable = {
		wait = "mainScenebg/login/wait3.png",
		bg = "mainScenebg/login/default.jpg",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light7.png"
	},
	summer2021 = {
		wait = "mainScenebg/login/wait4.png",
		bg = "mainScenebg/login/summer2021.png",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light4.png"
	},
	anniversary2021 = {
		wait = "mainScenebg/login/wait3.png",
		bg = "mainScenebg/login/default.jpg",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light7.png"
	},
	christmas2021 = {
		wait = "mainScenebg/login/wait3.png",
		bg = "mainScenebg/login/default.jpg",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light7.png"
	},
	spring2022 = {
		wait = "mainScenebg/login/wait4.png",
		bg = "mainScenebg/login/christmas.png",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light6.png"
	},
	taptap = {
		wait = "mainScenebg/login/wait4.png",
		bg = "mainScenebg/login/christmas.png",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light6.png"
	},
	spring2024 = {
		wait = "mainScenebg/login/wait4.png",
		bg = "mainScenebg/login/bg1/bg1.jpg",
		logo = "mainScenebg/login/logo.png",
		light = "mainScenebg/login/light2.png"
	}
}
local var_0_3 = {
	old = function()
		local var_1_0 = cc.Sprite:create(var_0_2.old.logo)

		var_1_0:setPosition(cc.p(var_1_0:getContentSize().width / 2 + 10, GameDisplay.height - var_1_0:getContentSize().height / 2 - 10))

		local var_1_1 = cc.Sprite:create(var_0_2.old.bg)

		var_1_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))

		return var_1_0, var_1_1, {
			waitpath = var_0_2.old.wait,
			lightpath = var_0_2.old.light
		}
	end,
	liuli = function()
		local var_2_0 = cc.Sprite:create(var_0_2.liuli.logo)

		var_2_0:setPosition(cc.p(var_2_0:getContentSize().width / 2 + 10, GameDisplay.height - var_2_0:getContentSize().height / 2 - 10))

		local var_2_1 = cc.Sprite:create(var_0_2.liuli.bg)

		var_2_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))

		return var_2_0, var_2_1, {
			waitpath = var_0_2.liuli.wait,
			lightpath = var_0_2.liuli.light
		}, var_0_2.liuli.bgm
	end,
	kamila = function()
		local var_3_0 = cc.Sprite:create(var_0_2.kamila.logo)

		var_3_0:setPosition(cc.p(var_3_0:getContentSize().width / 2 + 10, GameDisplay.height - var_3_0:getContentSize().height / 2 - 10))

		local var_3_1 = cc.Node:create()

		var_3_1:setPosition(cc.p(0, 0))

		local var_3_2 = l2d.LAppView:createDrawNode()

		var_3_2:showAllModel(false)
		var_3_2:setTouchEnabled(false)
		var_3_2:setDrawModel("14130")
		require("controller.l2d_manager"):addModel("14130", "live2d/14130/", LIVE2D_MODEL)
		var_3_1:addChild(var_3_2)

		return var_3_0, var_3_1, {
			waitpath = var_0_2.kamila.wait,
			lightpath = var_0_2.kamila.light
		}
	end,
	taptap = function()
		local var_4_0 = cc.Sprite:create(var_0_2.taptap.logo)

		var_4_0:setPosition(cc.p(var_4_0:getContentSize().width / 2 + 10, GameDisplay.height - var_4_0:getContentSize().height / 2 - 10))

		local var_4_1 = cc.Node:create()

		var_4_1:setPosition(cc.p(0, 0))

		local l2d_manager = require("controller.l2d_manager")
		local var_4_3 = l2d.LAppView:createDrawNode()

		var_4_3:showAllModel(false)
		var_4_3:setTouchEnabled(false)
		var_4_3:setDrawModel("106321")
		l2d_manager:addModel("106321", "live2d/106321/", "106321.model3.json")
		var_4_1:addChild(var_4_3)
		l2d_manager:doModelMotion("106321", "begin", 0)

		return var_4_0, var_4_1, {
			waitpath = var_0_2.taptap.wait,
			lightpath = var_0_2.taptap.light
		}
	end,
	halloween = function()
		local var_5_0 = cc.Sprite:create(var_0_2.halloween.logo)

		var_5_0:setPosition(cc.p(var_5_0:getContentSize().width / 2 + 10, GameDisplay.height - var_5_0:getContentSize().height / 2 - 10))

		local var_5_1 = cc.Node:create()

		var_5_1:setPosition(cc.p(0, 0))

		local var_5_2 = l2d.LAppView:createDrawNode()

		var_5_2:showAllModel(false)
		var_5_2:setTouchEnabled(false)
		var_5_2:setDrawModel("12970")
		require("controller.l2d_manager"):addModel("12970", "live2d/12970/", LIVE2D_MODEL)
		var_5_1:addChild(var_5_2)

		local var_5_3 = ccui.ImageView:create("mainScenebg/l2d_cloud_laila.png")

		var_5_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_5_3:setPosition(cc.p(320, GameDisplay.height + 455 - GameDisplay.fix_y))
		var_5_3:setScale(3)
		var_5_3:setName("laila_img")
		var_5_1:addChild(var_5_3, 0)

		local var_5_4 = {
			rotation = var_5_3:getRotation()
		}
		local var_5_5 = require("fight.tween").new(60, var_5_4, {
			rotation = var_5_3:getRotation() + 360
		}, "linear")

		var_5_3:scheduleUpdateWithPriorityLua(function(arg_6_0)
			if var_5_5:update(arg_6_0) then
				var_5_3:setRotation(var_5_4.rotation)
				var_5_5:reset()
			else
				var_5_3:setRotation(var_5_4.rotation)
			end
		end, 0)

		return var_5_0, var_5_1, {
			waitpath = var_0_2.halloween.wait,
			lightpath = var_0_2.halloween.light
		}
	end,
	bianhua = function()
		local var_7_0 = cc.Sprite:create(var_0_2.bianhua.logo)

		var_7_0:setPosition(cc.p(var_7_0:getContentSize().width / 2 + 10, GameDisplay.height - var_7_0:getContentSize().height / 2 - 10))

		local var_7_1 = cc.Sprite:create(var_0_2.bianhua.bg)

		var_7_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))

		local var_7_2 = cc.ParticleSystemQuad:create("effect/particle_bianhua_mainsence_1.plist")

		var_7_2:setPosition(cc.p(var_7_1:getContentSize().width, GameDisplay.fix_y))
		var_7_2:setScaleX(-1)
		var_7_1:addChild(var_7_2, 1)

		local spinecache_manager = require("controller.spinecache_manager")
		local var_7_4 = "spine/test/bianhualogin.json"
		local var_7_5 = "spine/test/bianhualogin.atlas"
		local var_7_6 = spinecache_manager:addSpineData("spine/test/bianhualogin.json", "spine/test/bianhualogin.atlas")

		var_7_6:retain()

		local var_7_7 = sp.SkeletonAnimation:create(var_7_6:getData())

		var_7_7:setPositionY(-(var_7_1:getContentSize().height - GameDisplay.height) / 2)
		var_7_1:addChild(var_7_7, 2)
		var_7_7:setAnimation(0, "idle", true)

		local var_7_8 = cc.Sprite:create("mainScenebg/login/bianhua_bg2.png")

		var_7_8:setPosition(cc.p(var_7_1:getContentSize().width / 2, var_7_1:getContentSize().height / 2))
		var_7_1:addChild(var_7_8, 3)
		var_7_1:registerScriptHandler(function(arg_8_0)
			if arg_8_0 == "exit" then
				var_7_6:release()
				spinecache_manager:removeSpineDataForKey(var_7_4, var_7_5)
			end
		end)

		return var_7_0, var_7_1, {
			waitpath = var_0_2.bianhua.wait,
			lightpath = var_0_2.bianhua.light
		}
	end,
	springfestival = function()
		local var_9_0 = cc.Sprite:create(var_0_2.springfestival.logo)

		var_9_0:setScale(0.35)
		var_9_0:setPosition(cc.p(var_9_0:getContentSize().width * 0.35 / 2 + 10, GameDisplay.height - var_9_0:getContentSize().height * 0.35 / 2 - 10))

		local var_9_1 = cc.Sprite:create(var_0_2.springfestival.bg)

		var_9_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))

		local spinecache_manager = require("controller.spinecache_manager")
		local var_9_3 = "spine/test/spring.json"
		local var_9_4 = "spine/test/spring.atlas"
		local var_9_5 = spinecache_manager:addSpineData("spine/test/spring.json", "spine/test/spring.atlas")

		var_9_5:retain()

		local var_9_6 = sp.SkeletonAnimation:create(var_9_5:getData())

		var_9_6:setPositionX(0)
		var_9_6:setPositionY(30)
		var_9_6:setScale(0.88, 0.88)
		var_9_1:addChild(var_9_6, 2)
		var_9_6:setAnimation(0, "zz", true)
		var_9_1:registerScriptHandler(function(arg_10_0)
			if arg_10_0 == "exit" then
				var_9_5:release()
				spinecache_manager:removeSpineDataForKey(var_9_3, var_9_4)
			end
		end)

		return var_9_0, var_9_1, {
			waitpath = var_0_2.springfestival.wait,
			lightpath = var_0_2.springfestival.light
		}
	end,
	default = function()
		local var_11_0 = cc.Sprite:create(var_0_2.default.logo)

		var_11_0:setPosition(cc.p(var_11_0:getContentSize().width / 2 + 10, GameDisplay.height - var_11_0:getContentSize().height / 2 - 10))

		local var_11_1 = cc.Node:create()

		var_11_1:setPosition(cc.p(0, 0))

		local var_11_2 = cc.Sprite:create("mainScenebg/login/bg1/bg1.png")

		var_11_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_11_2:setPosition(cc.p(GameDisplay.cx, GameDisplay.height - 950))
		var_11_1:addChild(var_11_2, 2)

		local var_11_3 = cc.Sprite:create("mainScenebg/login/bg1/bg1-1.png")

		var_11_3:setPosition(cc.p(var_11_2:getContentSize().width / 2, 1236))
		var_11_2:addChild(var_11_3)

		local var_11_4 = cc.Sprite:create("mainScenebg/login/bg1/bg2.png")

		var_11_4:setAnchorPoint(cc.p(0.5, 1))
		var_11_4:setPosition(cc.p(GameDisplay.cx, GameDisplay.height))
		var_11_1:addChild(var_11_4)

		local var_11_5 = cc.Sprite:create("mainScenebg/login/bg1/stage.png")

		var_11_5:setAnchorPoint(cc.p(0.5, 0))
		var_11_5:setPosition(cc.p(GameDisplay.cx, 0))
		var_11_1:addChild(var_11_5, 3)
		cc.SpriteFrameCache:getInstance():addSpriteFrames("mainScenebg/login/bg1/effect_loginin0.plist")
		cc.SpriteFrameCache:getInstance():addSpriteFrames("mainScenebg/login/bg1/effect_loginin1.plist")
		ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("mainScenebg/login/bg1/effect_loginin.ExportJson")

		local var_11_6 = ccs.Armature:create("effect_loginin")

		var_11_6:setPosition(cc.p(GameDisplay.cx - 40, 0 + 350))
		var_11_1:addChild(var_11_6, 4)
		var_11_6:getAnimation():play("effect_loginin_role")
		ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("mainScenebg/login/bg1/effect_loginin_star.ExportJson")

		local var_11_7 = ccs.Armature:create("effect_loginin_star")

		var_11_7:setPosition(cc.p(GameDisplay.cx - 50, GameDisplay.height - 250))
		var_11_1:addChild(var_11_7, 1)

		local var_11_8 = ccs.Armature:create("effect_loginin_star")

		var_11_8:setPosition(cc.p(GameDisplay.cx + 50, GameDisplay.height - 400))
		var_11_1:addChild(var_11_8, 1)
		var_11_7:getAnimation():play("effect_loginin_star", -1, 1)
		var_11_8:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
			var_11_8:getAnimation():play("effect_loginin_star", -1, 1)
		end)))
		var_11_1:registerScriptHandler(function(arg_13_0)
			if arg_13_0 == "exit" then
				require("controller.l2utils"):performWithDelay(function()
					ccs.ArmatureDataManager:getInstance():removeArmatureFileInfo("mainScenebg/login/bg1/effect_loginin.ExportJson")
					ccs.ArmatureDataManager:getInstance():removeArmatureFileInfo("mainScenebg/login/bg1/effect_loginin_star.ExportJson")
					cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile("mainScenebg/login/bg1/effect_loginin0.plist")
					cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile("mainScenebg/login/bg1/effect_loginin1.plist")
					cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile("mainScenebg/login/bg1/effect_loginin_star0.plist")
					cc.Director:getInstance():getTextureCache():removeTextureForKey("mainScenebg/login/bg1/effect_loginin0.png")
					cc.Director:getInstance():getTextureCache():removeTextureForKey("mainScenebg/login/bg1/effect_loginin1.png")
					cc.Director:getInstance():getTextureCache():removeTextureForKey("mainScenebg/login/bg1/effect_loginin_star0.png")
				end, 0.5)
			end
		end)

		return var_11_0, var_11_1, {
			waitpath = var_0_2.default.wait,
			lightpath = var_0_2.default.light
		}
	end,
	defaultgray = function()
		local var_15_0 = cc.Sprite:create(var_0_2.default.logo)

		var_15_0:setPosition(cc.p(var_15_0:getContentSize().width / 2 + 10, GameDisplay.height - var_15_0:getContentSize().height / 2 - 10))

		local var_15_1 = cc.Node:create()

		var_15_1:setPosition(cc.p(0, 0))

		local var_15_2 = cc.Sprite:create("mainScenebg/login/bg1/bg1.png")

		var_15_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_15_2:setPosition(cc.p(GameDisplay.cx, GameDisplay.height - 950))
		var_15_1:addChild(var_15_2, 2)

		local var_15_3 = cc.Sprite:create("mainScenebg/login/bg1/bg1-1.png")

		var_15_3:setPosition(cc.p(var_15_2:getContentSize().width / 2, 1236))
		var_15_2:addChild(var_15_3)

		local var_15_4 = cc.Sprite:create("mainScenebg/login/bg1/bg2.png")

		var_15_4:setAnchorPoint(cc.p(0.5, 1))
		var_15_4:setPosition(cc.p(GameDisplay.cx, GameDisplay.height))
		var_15_1:addChild(var_15_4)

		local var_15_5 = cc.Sprite:create("mainScenebg/login/bg1/stage.png")

		var_15_5:setAnchorPoint(cc.p(0.5, 0))
		var_15_5:setPosition(cc.p(GameDisplay.cx, 0))
		var_15_1:addChild(var_15_5, 3)
		cc.SpriteFrameCache:getInstance():addSpriteFrames("mainScenebg/login/bg1/effect_loginin0.plist")
		cc.SpriteFrameCache:getInstance():addSpriteFrames("mainScenebg/login/bg1/effect_loginin1.plist")
		ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("mainScenebg/login/bg1/effect_loginin.ExportJson")

		local var_15_6 = ccs.Armature:create("effect_loginin")

		var_15_6:setPosition(cc.p(GameDisplay.cx - 40, 0 + 350))
		var_15_1:addChild(var_15_6, 4)
		var_15_6:getAnimation():play("effect_loginin_role")
		ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("mainScenebg/login/bg1/effect_loginin_star.ExportJson")

		local var_15_7 = ccs.Armature:create("effect_loginin_star")

		var_15_7:setPosition(cc.p(GameDisplay.cx - 50, GameDisplay.height - 250))
		var_15_1:addChild(var_15_7, 1)

		local var_15_8 = ccs.Armature:create("effect_loginin_star")

		var_15_8:setPosition(cc.p(GameDisplay.cx + 50, GameDisplay.height - 400))
		var_15_1:addChild(var_15_8, 1)
		var_15_7:getAnimation():play("effect_loginin_star", -1, 1)
		var_15_8:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
			var_15_8:getAnimation():play("effect_loginin_star", -1, 1)
		end)))
		require("controller.l2utils"):shaderNode(var_15_1, true)
		var_15_1:registerScriptHandler(function(arg_17_0)
			if arg_17_0 == "exit" then
				require("controller.l2utils"):performWithDelay(function()
					ccs.ArmatureDataManager:getInstance():removeArmatureFileInfo("mainScenebg/login/bg1/effect_loginin.ExportJson")
					ccs.ArmatureDataManager:getInstance():removeArmatureFileInfo("mainScenebg/login/bg1/effect_loginin_star.ExportJson")
					cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile("mainScenebg/login/bg1/effect_loginin0.plist")
					cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile("mainScenebg/login/bg1/effect_loginin1.plist")
					cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile("mainScenebg/login/bg1/effect_loginin_star0.plist")
					cc.Director:getInstance():getTextureCache():removeTextureForKey("mainScenebg/login/bg1/effect_loginin0.png")
					cc.Director:getInstance():getTextureCache():removeTextureForKey("mainScenebg/login/bg1/effect_loginin1.png")
					cc.Director:getInstance():getTextureCache():removeTextureForKey("mainScenebg/login/bg1/effect_loginin_star0.png")
				end, 0.5)
			end
		end)

		return var_15_0, var_15_1, {
			waitpath = var_0_2.default.wait,
			lightpath = var_0_2.default.light
		}
	end,
	laila = function()
		local var_19_0 = cc.Sprite:create(var_0_2.laila.logo)

		var_19_0:setPosition(cc.p(var_19_0:getContentSize().width / 2 + 10, GameDisplay.height - var_19_0:getContentSize().height / 2 - 10))

		local var_19_1 = cc.Node:create()

		var_19_1:setPosition(cc.p(0, 0))

		local spinecache_manager = require("controller.spinecache_manager")
		local var_19_3 = "mainScenebg/login/laila/laila.json"
		local var_19_4 = "mainScenebg/login/laila/laila.atlas"
		local var_19_5 = spinecache_manager:addSpineData("mainScenebg/login/laila/laila.json", "mainScenebg/login/laila/laila.atlas")

		var_19_5:retain()

		local var_19_6 = sp.SkeletonAnimation:create(var_19_5:getData())

		var_19_6:setPosition((GameDisplay.width - 952) / 2, 0)
		var_19_1:addChild(var_19_6, 2)
		var_19_6:setAnimation(0, "idle", true)
		var_19_1:registerScriptHandler(function(arg_20_0)
			if arg_20_0 == "exit" then
				var_19_5:release()
				spinecache_manager:removeSpineDataForKey(var_19_3, var_19_4)
			end
		end)

		return var_19_0, var_19_1, {
			waitpath = var_0_2.laila.wait,
			lightpath = var_0_2.laila.light
		}
	end,
	awl = function()
		local var_21_0 = cc.Sprite:create(var_0_2.awl.logo)

		var_21_0:setPosition(cc.p(var_21_0:getContentSize().width / 2 + 10, GameDisplay.height - var_21_0:getContentSize().height / 2 - 10))

		local var_21_1 = cc.Sprite:create(var_0_2.awl.bg)

		var_21_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))

		return var_21_0, var_21_1, {
			waitpath = var_0_2.awl.wait,
			lightpath = var_0_2.awl.light
		}
	end,
	summer = function()
		local var_22_0 = cc.Sprite:create(var_0_2.summer.logo)

		var_22_0:setPosition(cc.p(var_22_0:getContentSize().width / 2 + 10, GameDisplay.height - var_22_0:getContentSize().height / 2 - 10))

		local var_22_1 = cc.Node:create()

		var_22_1:setPosition(cc.p(0, 0))

		local spinecache_manager = require("controller.spinecache_manager")
		local var_22_3 = "mainScenebg/login/summer/summer.json"
		local var_22_4 = "mainScenebg/login/summer/summer.atlas"
		local var_22_5 = spinecache_manager:addSpineData("mainScenebg/login/summer/summer.json", "mainScenebg/login/summer/summer.atlas")

		var_22_5:retain()

		local var_22_6 = sp.SkeletonAnimation:create(var_22_5:getData())

		var_22_6:setPosition(cc.p(0, GameDisplay.cy - 650))
		var_22_1:addChild(var_22_6, 2)
		var_22_6:setAnimation(0, "idle", true)
		var_22_1:registerScriptHandler(function(arg_23_0)
			if arg_23_0 == "exit" then
				var_22_5:release()
				spinecache_manager:removeSpineDataForKey(var_22_3, var_22_4)
			end
		end)

		return var_22_0, var_22_1, {
			waitpath = var_0_2.summer.wait,
			lightpath = var_0_2.summer.light
		}, "sound/summer"
	end,
	anniversary = function()
		local var_24_0 = cc.Sprite:create(var_0_2.anniversary.logo)

		var_24_0:setPosition(cc.p(var_24_0:getContentSize().width / 2 + 10, GameDisplay.height - var_24_0:getContentSize().height / 2 - 10))

		local var_24_1 = cc.Sprite:create(var_0_2.anniversary.bg)

		var_24_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))

		return var_24_0, var_24_1, {
			waitpath = var_0_2.anniversary.wait,
			lightpath = var_0_2.anniversary.light
		}, var_0_2.anniversary.bgm
	end,
	shark = function()
		local var_25_0 = cc.Sprite:create(var_0_2.shark.logo)

		var_25_0:setPosition(cc.p(var_25_0:getContentSize().width / 2 + 10, GameDisplay.height - var_25_0:getContentSize().height / 2 - 10))

		local var_25_1 = cc.Sprite:create(var_0_2.shark.bg)

		var_25_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))

		return var_25_0, var_25_1, {
			waitpath = var_0_2.shark.wait,
			lightpath = var_0_2.shark.light
		}, "sound/summer"
	end,
	anniversary2 = function()
		local var_26_0 = cc.Sprite:create(var_0_2.anniversary2.logo)

		var_26_0:setPosition(cc.p(var_26_0:getContentSize().width / 2 + 10, GameDisplay.height - var_26_0:getContentSize().height / 2 - 10))

		local var_26_1 = cc.Node:create()

		var_26_1:setPosition(cc.p(0, 0))

		local spinecache_manager = require("controller.spinecache_manager")
		local var_26_3 = "mainScenebg/login/anniversary2/5.json"
		local var_26_4 = "mainScenebg/login/anniversary2/5.atlas"
		local var_26_5 = spinecache_manager:addSpineData("mainScenebg/login/anniversary2/5.json", "mainScenebg/login/anniversary2/5.atlas")

		var_26_5:retain()

		local var_26_6 = sp.SkeletonAnimation:create(var_26_5:getData())

		var_26_6:setPosition(GameDisplay.width / 2, 0)
		var_26_1:addChild(var_26_6, 2)
		var_26_6:setAnimation(0, "1", true)
		var_26_1:registerScriptHandler(function(arg_27_0)
			if arg_27_0 == "exit" then
				var_26_5:release()
				spinecache_manager:removeSpineDataForKey(var_26_3, var_26_4)
			end
		end)

		return var_26_0, var_26_1, {
			waitpath = var_0_2.anniversary2.wait,
			lightpath = var_0_2.anniversary2.light
		}
	end,
	umaru = function()
		local var_28_0 = cc.Sprite:create(var_0_2.umaru.logo)

		var_28_0:setPosition(cc.p(GameDisplay.width - var_28_0:getContentSize().width / 2 - 10, GameDisplay.height - 105 - var_28_0:getContentSize().height / 2))

		local var_28_1 = cc.Node:create()

		var_28_1:setPosition(cc.p(0, 0))

		local spinecache_manager = require("controller.spinecache_manager")
		local var_28_3 = "mainScenebg/login/umaru/loading.json"
		local var_28_4 = "mainScenebg/login/umaru/loading.atlas"
		local var_28_5 = spinecache_manager:addSpineData("mainScenebg/login/umaru/loading.json", "mainScenebg/login/umaru/loading.atlas")

		var_28_5:retain()

		local var_28_6 = sp.SkeletonAnimation:create(var_28_5:getData())

		var_28_6:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 766.5))
		var_28_1:addChild(var_28_6, 2)
		var_28_6:setAnimation(0, "loading", true)
		var_28_1:registerScriptHandler(function(arg_29_0)
			if arg_29_0 == "exit" then
				var_28_5:release()
				spinecache_manager:removeSpineDataForKey(var_28_3, var_28_4)
			end
		end)

		return var_28_0, var_28_1, {
			waitpath = var_0_2.umaru.wait,
			lightpath = var_0_2.umaru.light
		}, var_0_2.umaru.bgm
	end,
	lailagray = function()
		local var_30_0 = cc.Sprite:create(var_0_2.laila.logo)

		var_30_0:setPosition(cc.p(var_30_0:getContentSize().width / 2 + 10, GameDisplay.height - var_30_0:getContentSize().height / 2 - 10))

		local var_30_1 = cc.Node:create()

		var_30_1:setPosition(cc.p(0, 0))

		local spinecache_manager = require("controller.spinecache_manager")
		local var_30_3 = "mainScenebg/login/laila/laila.json"
		local var_30_4 = "mainScenebg/login/laila/laila.atlas"
		local var_30_5 = spinecache_manager:addSpineData("mainScenebg/login/laila/laila.json", "mainScenebg/login/laila/laila.atlas")

		var_30_5:retain()

		local var_30_6 = sp.SkeletonAnimation:create(var_30_5:getData())

		var_30_6:setPosition((GameDisplay.width - 952) / 2, 0)
		var_30_1:addChild(var_30_6, 2)
		var_30_6:setAnimation(0, "idle", true)
		require("controller.l2utils"):shaderNode(var_30_1, true)
		var_30_1:registerScriptHandler(function(arg_31_0)
			if arg_31_0 == "exit" then
				var_30_5:release()
				spinecache_manager:removeSpineDataForKey(var_30_3, var_30_4)
			end
		end)

		return var_30_0, var_30_1, {
			waitpath = var_0_2.laila.wait,
			lightpath = var_0_2.laila.light
		}
	end,
	christmas = function()
		local var_32_0 = cc.Sprite:create(var_0_2.christmas.logo)

		var_32_0:setPosition(cc.p(var_32_0:getContentSize().width / 2 + 10, GameDisplay.height - var_32_0:getContentSize().height / 2 - 10))

		local var_32_1 = cc.Sprite:create(var_0_2.christmas.bg)

		var_32_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))

		local var_32_2 = cc.ParticleSystemQuad:create("effect/particle/christmas_snow.plist")

		var_32_2:setPosition(cc.p(GameDisplay.cx, GameDisplay.height * 0.8))
		var_32_1:addChild(var_32_2, 999)

		return var_32_0, var_32_1, {
			waitpath = var_0_2.christmas.wait,
			lightpath = var_0_2.christmas.light
		}
	end,
	yuandan = function()
		local var_33_0 = cc.Sprite:create(var_0_2.yuandan.logo)

		var_33_0:setPosition(cc.p(GameDisplay.width - var_33_0:getContentSize().width / 2 - 10, GameDisplay.height - 105 - var_33_0:getContentSize().height / 2))

		local var_33_1 = cc.Node:create()

		var_33_1:setPosition(cc.p(0, 0))

		local spinecache_manager = require("controller.spinecache_manager")
		local var_33_3 = "mainScenebg/login/yuandan/yuandankv.json"
		local var_33_4 = "mainScenebg/login/yuandan/yuandankv.atlas"
		local var_33_5 = spinecache_manager:addSpineData("mainScenebg/login/yuandan/yuandankv.json", "mainScenebg/login/yuandan/yuandankv.atlas")

		var_33_5:retain()

		local var_33_6 = sp.SkeletonAnimation:create(var_33_5:getData())

		var_33_6:setPosition(cc.p(GameDisplay.cx - 12, GameDisplay.cy - 694))
		var_33_1:addChild(var_33_6, 2)
		var_33_6:setAnimation(0, "yuandankv", true)
		var_33_1:registerScriptHandler(function(arg_34_0)
			if arg_34_0 == "exit" then
				var_33_5:release()
				spinecache_manager:removeSpineDataForKey(var_33_3, var_33_4)
			end
		end)

		local var_33_7 = cc.ParticleSystemQuad:create("effect/particle/christmas_snow.plist")

		var_33_7:setPosition(cc.p(GameDisplay.cx, GameDisplay.height * 0.8))
		var_33_1:addChild(var_33_7, 999)

		return var_33_0, var_33_1, {
			waitpath = var_0_2.yuandan.wait,
			lightpath = var_0_2.yuandan.light
		}, var_0_2.yuandan.bgm
	end,
	spring2021 = function()
		local var_35_0 = cc.Sprite:create(var_0_2.spring2021.logo)

		var_35_0:setPosition(cc.p(GameDisplay.width - var_35_0:getContentSize().width / 2 - 10, GameDisplay.height - 105 - var_35_0:getContentSize().height / 2))

		local var_35_1 = cc.Node:create()

		var_35_1:setPosition(cc.p(0, 0))

		local spinecache_manager = require("controller.spinecache_manager")
		local var_35_3 = "mainScenebg/login/spring/2021kv.json"
		local var_35_4 = "mainScenebg/login/spring/2021kv.atlas"
		local var_35_5 = spinecache_manager:addSpineData("mainScenebg/login/spring/2021kv.json", "mainScenebg/login/spring/2021kv.atlas")

		var_35_5:retain()

		local var_35_6 = sp.SkeletonAnimation:create(var_35_5:getData())

		var_35_6:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
		var_35_1:addChild(var_35_6, 2)
		var_35_6:setAnimation(0, "2021kv", true)
		var_35_1:registerScriptHandler(function(arg_36_0)
			if arg_36_0 == "exit" then
				var_35_5:release()
				spinecache_manager:removeSpineDataForKey(var_35_3, var_35_4)
			end
		end)

		return var_35_0, var_35_1, {
			waitpath = var_0_2.spring2021.wait,
			lightpath = var_0_2.spring2021.light
		}, var_0_2.spring2021.bgm
	end,
	stable = function()
		local var_37_0 = cc.Sprite:create(var_0_2.stable.logo)

		var_37_0:setPosition(cc.p(var_37_0:getContentSize().width / 2 + 10, GameDisplay.height - var_37_0:getContentSize().height / 2 - 10))

		local var_37_1 = cc.Node:create()

		var_37_1:setPosition(cc.p(0, 0))

		local spinecache_manager = require("controller.spinecache_manager")
		local var_37_3 = "mainScenebg/login/stable/stable.json"
		local var_37_4 = "mainScenebg/login/stable/stable.atlas"
		local var_37_5 = spinecache_manager:addSpineData("mainScenebg/login/stable/stable.json", "mainScenebg/login/stable/stable.atlas")

		var_37_5:retain()

		local var_37_6 = sp.SkeletonAnimation:create(var_37_5:getData())

		var_37_6:setScale(1.05, 1.05)
		var_37_6:setPosition(cc.p(GameDisplay.cx + 5, GameDisplay.cy - 669))
		var_37_1:addChild(var_37_6, 2)
		var_37_6:setAnimation(0, "idle", true)
		var_37_1:registerScriptHandler(function(arg_38_0)
			if arg_38_0 == "exit" then
				var_37_5:release()
				spinecache_manager:removeSpineDataForKey(var_37_3, var_37_4)
			end
		end)

		return var_37_0, var_37_1, {
			waitpath = var_0_2.stable.wait,
			lightpath = var_0_2.stable.light
		}, var_0_2.stable.bgm
	end,
	summer2021 = function()
		local var_39_0 = cc.Sprite:create(var_0_2.summer2021.logo)

		var_39_0:setPosition(cc.p(var_39_0:getContentSize().width / 2 + 10, GameDisplay.height - var_39_0:getContentSize().height / 2 - 10))

		local var_39_1 = cc.Sprite:create(var_0_2.summer2021.bg)

		var_39_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))

		return var_39_0, var_39_1, {
			waitpath = var_0_2.summer2021.wait,
			lightpath = var_0_2.summer2021.light
		}, "sound/summer"
	end,
	anniversary2021 = function()
		local var_40_0 = var_0_2.anniversary2021
		local var_40_1 = cc.Sprite:create(var_0_2.anniversary2021.logo)

		var_40_1:setPosition(cc.p(var_40_1:getContentSize().width / 2 + 10, GameDisplay.height - var_40_1:getContentSize().height / 2 - 10))

		local var_40_2 = cc.Node:create()

		var_40_2:setPosition(cc.p(0, 0))

		local spinecache_manager = require("controller.spinecache_manager")
		local var_40_4 = "mainScenebg/login/anniversary2021/103955_kv.json"
		local var_40_5 = "mainScenebg/login/anniversary2021/103955_kv.atlas"
		local var_40_6

		if not cc.FileUtils:getInstance():isFileExist("mainScenebg/login/anniversary2021/103955_kv.json") then
			var_40_4 = "mainScenebg/login/laila/laila.json"
			var_40_5 = "mainScenebg/login/laila/laila.atlas"
			var_40_6 = spinecache_manager:addSpineData("mainScenebg/login/laila/laila.json", "mainScenebg/login/laila/laila.atlas")

			var_40_6:retain()

			local var_40_7 = sp.SkeletonAnimation:create(var_40_6:getData())

			var_40_7:setPosition((GameDisplay.width - 952) / 2, 0)
			var_40_2:addChild(var_40_7, 2)
			var_40_7:setAnimation(0, "idle", true)
		else
			var_40_6 = spinecache_manager:addSpineData(var_40_4, var_40_5)

			var_40_6:retain()

			local var_40_8 = sp.SkeletonAnimation:create(var_40_6:getData())

			var_40_8:setScale(1.05, 1.05)
			var_40_8:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 500))
			var_40_2:addChild(var_40_8, 2)
			var_40_8:setAnimation(0, "idle", true)
		end

		var_40_2:registerScriptHandler(function(arg_41_0)
			if arg_41_0 == "exit" then
				var_40_6:release()
				spinecache_manager:removeSpineDataForKey(var_40_4, var_40_5)
			end
		end)

		return var_40_1, var_40_2, {
			waitpath = var_40_0.wait,
			lightpath = var_40_0.light
		}, var_40_0.bgm
	end,
	christmas2021 = function()
		local var_42_0 = cc.Sprite:create(var_0_2.christmas2021.logo)

		var_42_0:setPosition(cc.p(var_42_0:getContentSize().width / 2 + 10, GameDisplay.height - var_42_0:getContentSize().height / 2 - 10))

		local var_42_1 = cc.Node:create()

		var_42_1:setPosition(cc.p(0, 0))

		local spinecache_manager = require("controller.spinecache_manager")
		local var_42_3 = "mainScenebg/login/christmas2021/shengdankv.json"
		local var_42_4 = "mainScenebg/login/christmas2021/shengdankv.atlas"
		local var_42_5 = spinecache_manager:addSpineData("mainScenebg/login/christmas2021/shengdankv.json", "mainScenebg/login/christmas2021/shengdankv.atlas")

		var_42_5:retain()

		local var_42_6 = sp.SkeletonAnimation:create(var_42_5:getData())

		var_42_6:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 694))
		var_42_1:addChild(var_42_6, 2)
		var_42_6:setAnimation(0, "idle", true)
		var_42_1:registerScriptHandler(function(arg_43_0)
			if arg_43_0 == "exit" then
				var_42_5:release()
				spinecache_manager:removeSpineDataForKey(var_42_3, var_42_4)
			end
		end)

		return var_42_0, var_42_1, {
			waitpath = var_0_2.christmas2021.wait,
			lightpath = var_0_2.christmas2021.light
		}, var_0_2.christmas2021.bgm
	end,
	spring2022 = function()
		local var_44_0 = cc.Sprite:create(var_0_2.spring2022.logo)

		var_44_0:setPosition(cc.p(var_44_0:getContentSize().width / 2 + 10, GameDisplay.height - var_44_0:getContentSize().height / 2 - 10))

		local var_44_1 = cc.Node:create()

		var_44_1:setPosition(cc.p(0, 0))

		local spinecache_manager = require("controller.spinecache_manager")
		local var_44_3 = "mainScenebg/login/spring/2022chunjiekv.json"
		local var_44_4 = "mainScenebg/login/spring/2022chunjiekv.atlas"
		local var_44_5 = spinecache_manager:addSpineData("mainScenebg/login/spring/2022chunjiekv.json", "mainScenebg/login/spring/2022chunjiekv.atlas")

		var_44_5:retain()

		local var_44_6 = sp.SkeletonAnimation:create(var_44_5:getData())

		var_44_6:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 694))
		var_44_1:addChild(var_44_6, 2)
		var_44_6:setAnimation(0, "idle", true)
		var_44_1:registerScriptHandler(function(arg_45_0)
			if arg_45_0 == "exit" then
				var_44_5:release()
				spinecache_manager:removeSpineDataForKey(var_44_3, var_44_4)
			end
		end)

		return var_44_0, var_44_1, {
			waitpath = var_0_2.spring2022.wait,
			lightpath = var_0_2.spring2022.light
		}, var_0_2.spring2022.bgm
	end,
	spring2024 = function()
		local var_46_0 = cc.Sprite:create(var_0_2.spring2024.logo)

		var_46_0:setPosition(cc.p(var_46_0:getContentSize().width / 2 + 10, GameDisplay.height - var_46_0:getContentSize().height / 2 - 10))

		local var_46_1 = cc.Node:create()

		var_46_1:setPosition(cc.p(0, 0))

		local spinecache_manager = require("controller.spinecache_manager")
		local var_46_3 = "mainScenebg/login/spring/111590_1.json"
		local var_46_4 = "mainScenebg/login/spring/111590_1.atlas"
		local var_46_5 = spinecache_manager:addSpineData("mainScenebg/login/spring/111590_1.json", "mainScenebg/login/spring/111590_1.atlas")

		var_46_5:retain()

		local var_46_6 = sp.SkeletonAnimation:create(var_46_5:getData())

		var_46_6:setPosition(cc.p(GameDisplay.cx, 0))
		var_46_1:addChild(var_46_6, 2)
		var_46_6:setAnimation(0, "idle", true)
		var_46_1:registerScriptHandler(function(arg_47_0)
			if arg_47_0 == "exit" then
				var_46_5:release()
				spinecache_manager:removeSpineDataForKey(var_46_3, var_46_4)
			end
		end)

		return var_46_0, var_46_1, {
			waitpath = var_0_2.spring2024.wait,
			lightpath = var_0_2.spring2024.light
		}, var_0_2.spring2024.bgm
	end
}

function var_0_0.getLoginBg(arg_48_0)
	return (var_0_3[assets_manager.loginimg or "laila"] or var_0_3.laila)()
end

return var_0_0
