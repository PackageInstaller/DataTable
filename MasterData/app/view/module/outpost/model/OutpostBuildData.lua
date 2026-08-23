local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostBuildData = class("OutpostBuildData")

function OutpostBuildData:ctor()
	self._buildDic = {}
	self._buildIndex = {
		typeIndex = {}
	}
	self._typeToIdDic = {}

	self:_onActive()
end

function OutpostBuildData:updateBuilds(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = self:getBuild({
			uid = self:_getBuildUid(iter_2_1.tp, (cc.p(iter_2_1.pos_x, iter_2_1.pos_y)))
		})
		local var_2_1 = cc.p(iter_2_1.pos_x, iter_2_1.pos_y)

		if not var_2_0 then
			var_2_0 = self:_createBuildItem(iter_2_1.tp, var_2_1)
		else
			self:changeBuildPos(var_2_0, var_2_1)
		end

		var_2_0:updateBuildBySvr(iter_2_1)
	end
end

function OutpostBuildData:_initBuildTypeCfgIndexDic()
	self._typeToIdDic = {}

	for iter_3_0 = 1, g.core.config.outpost_build_info.getLength() do
		local var_3_0 = g.core.config.outpost_build_info.indexOf(iter_3_0)

		self._typeToIdDic[var_3_0.build_type] = var_3_0.id
	end
end

function OutpostBuildData:_createBuildItem(arg_4_1, arg_4_2)
	if not next(self._typeToIdDic) then
		self:_initBuildTypeCfgIndexDic()
	end

	local var_4_0 = self._typeToIdDic[arg_4_1]
	local var_4_1

	if var_0_0.BuildType.Main == arg_4_1 then
		var_4_1 = require("app.view.module.outpost.model.struct.build.OutpostCityBuild").new(arg_4_1, var_4_0)
	elseif var_0_0.BuildType.Exchange == arg_4_1 then
		var_4_1 = require("app.view.module.outpost.model.struct.build.OutpostExchangeBuild").new(arg_4_1, var_4_0)
	elseif var_0_0.BuildType.Hospital == arg_4_1 then
		var_4_1 = require("app.view.module.outpost.model.struct.build.OutpostHospital").new(arg_4_1, var_4_0)
	elseif var_0_0.BuildType.Restaurant == arg_4_1 then
		var_4_1 = require("app.view.module.outpost.model.struct.build.OutpostRestaurant").new(arg_4_1, var_4_0)
	elseif var_0_0.BuildType.Hotel == arg_4_1 then
		var_4_1 = require("app.view.module.outpost.model.struct.build.OutpostHostel").new(arg_4_1, var_4_0)
	elseif var_0_0.BuildType.Tavern == arg_4_1 then
		var_4_1 = require("app.view.module.outpost.model.struct.build.OutpostTavern").new(arg_4_1, var_4_0)
	elseif var_0_0.BuildType.WeaponShop == arg_4_1 then
		var_4_1 = require("app.view.module.outpost.model.struct.build.OutpostEquipBuild").new(arg_4_1, var_4_0)
	elseif var_0_0.BuildType.ArmorShop == arg_4_1 then
		var_4_1 = require("app.view.module.outpost.model.struct.build.OutpostEquipBuild").new(arg_4_1, var_4_0)
	elseif var_0_0.BuildType.Boss == arg_4_1 then
		var_4_1 = require("app.view.module.outpost.model.struct.build.OutpostBossBuild").new(arg_4_1, var_4_0)
	end

	if arg_4_2 then
		var_4_1:setBuildPos(arg_4_2)
	end

	self._buildDic[var_4_1:getUid()] = var_4_1

	local var_4_2 = self._buildIndex.typeIndex[arg_4_1]

	if not self._buildIndex.typeIndex[arg_4_1] then
		var_4_2 = {}
		self._buildIndex.typeIndex[arg_4_1] = var_4_2
	end

	var_4_2[#var_4_2 + 1] = var_4_1

	if var_0_0.BuildType.Main ~= arg_4_1 then
		local var_4_3 = self:_getBuildByType(var_0_0.BuildType.Main)

		if var_4_3 then
			var_4_1:setLimitLevel(var_4_3:getSubBuildLimitLevel(arg_4_1))
		end
	end

	return var_4_1
end

function OutpostBuildData:_getBuildUid(arg_5_1, arg_5_2)
	return table.concat({
		arg_5_1,
		arg_5_2.x,
		arg_5_2.y
	}, "_")
end

function OutpostBuildData:getBuild(arg_6_1)
	local var_6_0

	if arg_6_1.type and arg_6_1.pos then
		var_6_0 = self:_getBuildByTypeAndPos(arg_6_1.type, arg_6_1.pos)
	elseif arg_6_1.type then
		var_6_0 = self:_getBuildByType(arg_6_1.type, arg_6_1.needCreate)
	elseif arg_6_1.uid then
		var_6_0 = self:_getBuildByUid(arg_6_1.uid)
	elseif arg_6_1.typeList then
		var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(arg_6_1.typeList) do
			var_6_0[#var_6_0 + 1] = self:_getBuildByType(iter_6_1, arg_6_1.needCreate)
		end
	end

	return var_6_0
end

function OutpostBuildData:_getBuildByType(arg_7_1, arg_7_2)
	local var_7_0 = self._buildIndex.typeIndex[arg_7_1]

	if self._buildIndex.typeIndex[arg_7_1] and #var_7_0 == 1 then
		var_7_0 = var_7_0[1]
	elseif not var_7_0 and arg_7_2 then
		var_7_0 = self:_createBuildItem(arg_7_1)
	end

	if var_7_0 and #var_7_0 == 1 then
		return var_7_0[1]
	end

	return var_7_0
end

function OutpostBuildData:_getBuildByTypeAndPos(arg_8_1, arg_8_2)
	return self:_getBuildByUid((self:_getBuildUid(arg_8_1, arg_8_2)))
end

function OutpostBuildData:_getBuildByUid(arg_9_1)
	return self._buildDic[arg_9_1]
end

function OutpostBuildData:getAllBuild()
	return self._buildDic
end

function OutpostBuildData:getMainCity()
	return self:_getBuildByType(var_0_0.BuildType.Main, true)
end

function OutpostBuildData:_onActive()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_BUILD_LEVEL_CHANGED, handler(self, self._onReceivedBuildChangeNotice), self)
end

function OutpostBuildData:exchangeBuildPos(arg_13_1, arg_13_2)
	self:changeBuildPos(arg_13_1, (arg_13_2:getBuildPos()))
	self:changeBuildPos(arg_13_2, (arg_13_1:getBuildPos()))
end

function OutpostBuildData:changeBuildPos(arg_14_1, arg_14_2)
	if arg_14_1:isSamePos(arg_14_2) then
		return
	end

	self._buildDic[arg_14_1:getUid()] = nil

	arg_14_1:setBuildPos(arg_14_2)

	self._buildDic[arg_14_1:getUid()] = arg_14_1
end

function OutpostBuildData:_onReceivedBuildChangeNotice(arg_15_1, arg_15_2, arg_15_3)
	if not self._buildDic then
		g.core.event.EventManager:removeListenerWithTarget(self)

		return
	end

	local var_15_0

	if var_0_0.BuildType.Main == arg_15_3.type then
		var_15_0 = self:getMainCity()
	end

	for iter_15_0, iter_15_1 in pairs(self._buildDic) do
		if iter_15_1:getUid() ~= arg_15_3.uid then
			if var_15_0 then
				iter_15_1:setLimitLevel((var_15_0:getSubBuildLimitLevel((iter_15_1:getBuildType()))))
			end

			iter_15_1:onReceivedLevelChangeNotice(arg_15_3)
		end
	end
end

function OutpostBuildData:getMainCityLimitsInfo()
	local var_16_0 = {}
	local var_16_1 = self:getMainCity()
	local var_16_2 = var_16_1:getBuildLimitsByCfg(var_16_1:getNextCfg())

	for iter_16_0 = var_0_0.BuildType.Exchange, var_0_0.BuildType.Boss do
		local var_16_3 = self:_getBuildByType(iter_16_0)
		local var_16_4

		if not var_16_3:isLockBuild() then
			local var_16_5 = var_16_3:getBuildCfg()

			var_16_4 = {
				name = var_16_3:getBuildName(),
				res = var_16_5.mini_res,
				curLv = var_16_1:getSubBuildLimitLevel(iter_16_0),
				nextLv = var_16_1:getSubBuildLimitLevel(iter_16_0, var_16_2),
				id = var_16_5.id
			}
		elseif var_16_3:canUnlock() then
			local var_16_6 = var_16_3:getBuildCfg()

			var_16_4 = {
				isNew = true,
				curLv = 0,
				name = var_16_3:getBuildName(),
				res = var_16_6.mini_res,
				nextLv = var_16_1:getSubBuildLimitLevel(iter_16_0, var_16_2),
				id = var_16_6.id
			}
		end

		if var_16_4 and var_16_4.curLv ~= var_16_4.nextLv then
			var_16_0[#var_16_0 + 1] = var_16_4
		end
	end

	return var_16_0
end

function OutpostBuildData:isConsumptionBuild(arg_17_1)
	return ({
		[var_0_0.BuildType.Hospital] = true,
		[var_0_0.BuildType.Hotel] = true,
		[var_0_0.BuildType.Tavern] = true,
		[var_0_0.BuildType.Restaurant] = true
	})[arg_17_1]
end

function OutpostBuildData:isInConsumptionBuilding(arg_18_1)
	local var_18_0 = false
	local var_18_1

	for iter_18_0, iter_18_1 in ipairs({
		var_0_0.BuildType.Hospital,
		var_0_0.BuildType.Hotel,
		var_0_0.BuildType.Tavern,
		var_0_0.BuildType.Restaurant
	}) do
		local var_18_2 = self:_getBuildByType(iter_18_1)

		if var_18_2:isInBuilding(arg_18_1) then
			var_18_0 = true
			var_18_1 = var_18_2

			break
		end
	end

	return var_18_0, var_18_1
end

function OutpostBuildData:unlockBuild(arg_19_1)
	if arg_19_1.build then
		local var_19_0 = self:getBuild({
			type = arg_19_1.build.tp
		})

		var_19_0:unlockBuild()
		var_19_0:updateBuildBySvr(arg_19_1.build)
		self:changeBuildPos(var_19_0, (cc.p(arg_19_1.build.pos_x, arg_19_1.build.pos_y)))
	elseif arg_19_1.build_tp then
		self:getBuild({
			type = arg_19_1.build_tp
		}):unlockBuild()
	end
end

function OutpostBuildData:onS2COutpostBuildLevelUp(arg_20_1)
	if arg_20_1.build then
		local var_20_0 = self:getBuild({
			type = arg_20_1.build.tp
		})

		var_20_0:levelUp()
		var_20_0:updateBuildBySvr(arg_20_1.build, self:isConsumptionBuild(arg_20_1.build.tp))
		self:changeBuildPos(var_20_0, (cc.p(arg_20_1.build.pos_x, arg_20_1.build.pos_y)))
	elseif arg_20_1.build_tp then
		self:getBuild({
			type = arg_20_1.build_tp
		}):levelUp()
	end
end

function OutpostBuildData:onS2COutpostBuildUse(arg_21_1)
	self:getBuild({
		type = arg_21_1.build_tp
	}):onKnightUseConsumption(arg_21_1)
end

function OutpostBuildData:onS2COutpostBuildUseLeave(arg_22_1)
	self:getBuild({
		type = arg_22_1.build_tp
	}):onKnightOutFromBuild(arg_22_1.knight.knight_id)
end

function OutpostBuildData:onS2COutpostBuildOrderProcess(arg_23_1)
	self:_getBuildByType(arg_23_1.build_tp):updateBuildOrder(arg_23_1.target_id, arg_23_1)
end

function OutpostBuildData:onS2COutpostBuildChangeOrder(arg_24_1)
	arg_24_1.target_num = arg_24_1.order_num

	self:_getBuildByType(arg_24_1.build_tp):updateBuildOrder(arg_24_1.order_id, arg_24_1, true)
end

function OutpostBuildData:onS2COutpostCallBoss(arg_25_1)
	return
end

function OutpostBuildData:onS2COutpostBattleFinish(arg_26_1)
	local var_26_0 = g.core.model.User.outpostData:getStatusByIdAndKey(var_0_0.BuildUnlockType.KILL_BOSS, arg_26_1).status

	for iter_26_0, iter_26_1 in pairs(self._buildDic) do
		iter_26_1:onBossDead(arg_26_1, var_26_0)
	end
end

function OutpostBuildData:onS2COutpostGetTaskAward(arg_27_1)
	local var_27_0 = {
		task_id = arg_27_1.task_id
	}

	if var_0_0.TASK_TYPE.MAIN ~= arg_27_1.task_tp then
		return
	end

	for iter_27_0, iter_27_1 in pairs(self._buildDic) do
		iter_27_1:onTaskChanged(var_27_0)
	end
end

function OutpostBuildData:onS2COutpostSyncTask(arg_28_1)
	if var_0_0.TASK_TYPE.MAIN ~= arg_28_1.task_type then
		return
	end

	for iter_28_0, iter_28_1 in ipairs(arg_28_1.actions) do
		for iter_28_2, iter_28_3 in pairs(self._buildDic) do
			iter_28_3:onTaskChanged(iter_28_1)
		end
	end
end

function OutpostBuildData:onS2COpObject(arg_29_1)
	for iter_29_0, iter_29_1 in ipairs((self:getBuild({
		typeList = {
			var_0_0.BuildType.Hospital,
			var_0_0.BuildType.Restaurant,
			var_0_0.BuildType.Hotel,
			var_0_0.BuildType.Tavern
		}
	}))) do
		iter_29_1:onCostItemChanged()
	end
end

return OutpostBuildData
