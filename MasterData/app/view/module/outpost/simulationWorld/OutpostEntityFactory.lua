local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostEntityDrop = require("app.view.module.outpost.simulationWorld.entity.OutpostEntityDrop")
local OutpostEntityBossBox = require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBossBox")
local OutpostEntityBullet = require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBullet")
local OutpostEntityKnight = require("app.view.module.outpost.simulationWorld.entity.OutpostEntityKnight")
local OutpostEntityMonster = require("app.view.module.outpost.simulationWorld.entity.OutpostEntityMonster")
local OutpostEntityRoleBoss = require("app.view.module.outpost.simulationWorld.entity.OutpostEntityRoleBoss")

return {
	createKnight = function(self, arg_1_1)
		local var_1_0 = OutpostEntityKnight.new(arg_1_1)

		self:addEntity(var_1_0, arg_1_1)
		self:addTickEntity(var_1_0)

		return var_1_0
	end,
	createMonster = function(self, arg_2_1)
		local var_2_0 = OutpostEntityMonster.new(arg_2_1)

		self:addEntity(var_2_0, arg_2_1)
		self:addTickEntity(var_2_0)

		return var_2_0
	end,
	createBuild = function(self, arg_3_1)
		local var_3_0 = arg_3_1 == var_0_0.BuildType.Main and require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildMain").new() or arg_3_1 == var_0_0.BuildType.Exchange and require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildExchange").new() or arg_3_1 == var_0_0.BuildType.Hospital and require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildHospital").new() or arg_3_1 == var_0_0.BuildType.Restaurant and require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildRestaurant").new() or arg_3_1 == var_0_0.BuildType.Hotel and require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildHotel").new() or arg_3_1 == var_0_0.BuildType.Tavern and require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildTavern").new() or arg_3_1 == var_0_0.BuildType.WeaponShop and require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildWeaponShop").new() or arg_3_1 == var_0_0.BuildType.ArmorShop and require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildArmorShop").new() or arg_3_1 == var_0_0.BuildType.Boss and require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildBoss").new() or arg_3_1 == var_0_0.BuildType.AirWall and require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildAirWall").new() or require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBuildBase").new()

		self:addEntity(var_3_0)

		return var_3_0
	end,
	createBarrier = function(self, arg_4_1)
		local var_4_0 = require("app.view.module.outpost.simulationWorld.entity.OutpostEntityBarrier").new()

		var_4_0.barrierInfo = arg_4_1

		self:addEntity(var_4_0)

		return var_4_0
	end,
	createDoor = function(self, arg_5_1)
		local var_5_0 = require("app.view.module.outpost.simulationWorld.entity.OutpostEntityDoor").new()

		;(nil):setDoorMapCfg(arg_5_1)
		self:addEntity(var_5_0)

		return var_5_0
	end,
	createMask = function(self)
		self:addEntity(nil)

		return (require("app.view.module.outpost.simulationWorld.entity.OutpostEntityMask").new())
	end,
	createDrop = function(self, arg_7_1)
		local var_7_0 = OutpostEntityDrop.new(arg_7_1)

		self:addEntity(var_7_0, arg_7_1)

		return var_7_0
	end,
	createBossBox = function(self, arg_8_1)
		local var_8_0 = OutpostEntityBossBox.new(arg_8_1)

		self:addEntity(var_8_0, arg_8_1)
		self:addSecondTickEntity(var_8_0)

		return var_8_0
	end,
	createBullet = function(self, arg_9_1)
		local var_9_0 = OutpostEntityBullet.new(arg_9_1)

		self:addEntity(var_9_0, arg_9_1)
		self:addTickEntity(var_9_0)

		return var_9_0
	end,
	createBoss = function(self, arg_10_1)
		local var_10_0 = OutpostEntityRoleBoss.new(arg_10_1)

		self:addEntity(var_10_0, arg_10_1)
		self:addTickEntity(var_10_0)

		return var_10_0
	end
}
