local Loader = require("app.core.utils.Loader")
local NewSlgBaseData = class("NewSlgBaseData", require("app.core.model.BaseData"))

function NewSlgBaseData:ctor()
	self:resetInitData()
end

function NewSlgBaseData:resetInitData()
	if self._newSlgData then
		self._newSlgData:resetInitData()
	end

	self._cacheNewSlgData = self._newSlgData
	self.shareCityTime = 0
	self.shareFarmTime = 0
	self._newSlgData = nil
	self._delayQueue = {}
end

function NewSlgBaseData:getSName()
	return self._newSlgData and self._newSlgData:getSName() or ""
end

function NewSlgBaseData:getSlgInfo()
	return self._newSlgData and self._newSlgData:getSlgInfo() or nil
end

function NewSlgBaseData:getSeasonId()
	return self._newSlgData and self._newSlgData:getSeasonId() or 0
end

function NewSlgBaseData:setFirstEnterTime(arg_6_1)
	self._newSlgData:setFirstEnterTime(arg_6_1)
end

function NewSlgBaseData:isUnlock()
	return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG)
end

function NewSlgBaseData:isOpen()
	return self._newSlgData and self._newSlgData:isOpen()
end

function NewSlgBaseData:isForecasting()
	return self._newSlgData and self._newSlgData:isForecasting()
end

function NewSlgBaseData:isPlaying()
	return self._newSlgData and self._newSlgData:isPlaying()
end

function NewSlgBaseData:isPlayingState()
	return self._newSlgData and self._newSlgData:isPlayingState()
end

function NewSlgBaseData:isSettle()
	return self._newSlgData and self._newSlgData:isSettle()
end

function NewSlgBaseData:isEnding()
	return self._newSlgData and self._newSlgData:isEnding()
end

function NewSlgBaseData:getForecastTime()
	if self._newSlgData then
		local var_14_0, var_14_1 = self._newSlgData:getForecastTime()

		return var_14_0, var_14_1
	end

	return 0, ""
end

function NewSlgBaseData:getActEndTime()
	return self._newSlgData and self._newSlgData:getActEndTime() or 0
end

function NewSlgBaseData:getActStartTime()
	return self._newSlgData and self._newSlgData:getActStartTime() or 0
end

function NewSlgBaseData:getActPreTime()
	return self._newSlgData and self._newSlgData:getActPreTime() or 0
end

function NewSlgBaseData:getActShowEndTime()
	return self._newSlgData and self._newSlgData:getActShowEndTime() or 0
end

function NewSlgBaseData:getActShowTime()
	return self._newSlgData and self._newSlgData:getActShowTime() or 0
end

function NewSlgBaseData:getSettleStartTime()
	return self._newSlgData and self._newSlgData:getSettleStartTime() or 0
end

function NewSlgBaseData:isNewSlgLastDay()
	return self._newSlgData and self._newSlgData:isNewSlgLastDay()
end

function NewSlgBaseData:getOpenDays()
	return self._newSlgData and self._newSlgData:getOpenDays() or 99999
end

function NewSlgBaseData:getEndStrategyTime()
	if self._newSlgData then
		return self._newSlgData:getEndStrategyTime()
	end

	return 0
end

function NewSlgBaseData:getDeclaredCityMaxCnt()
	if self._newSlgData then
		return self._newSlgData:getDeclaredCityMaxCnt()
	end

	return 0
end

function NewSlgBaseData:getMapPath(arg_25_1, arg_25_2)
	return self._newSlgData:getMapPath(arg_25_1, arg_25_2)
end

function NewSlgBaseData:getCsvPath(arg_26_1)
	return self._newSlgData:getCsvPath(arg_26_1)
end

function NewSlgBaseData:initComponents()
	self._newSlgData:initComponents()
end

function NewSlgBaseData:initMapInfo()
	self._newSlgData:initMapInfo()
end

function NewSlgBaseData:getMonsterCvsData()
	return self._newSlgData:getMonsterCvsData()
end

function NewSlgBaseData:isWater(arg_30_1, arg_30_2)
	return self._newSlgData:isWater(arg_30_1, arg_30_2)
end

function NewSlgBaseData:isBarrier(arg_31_1, arg_31_2)
	return self._newSlgData:isBarrier(arg_31_1, arg_31_2)
end

function NewSlgBaseData:isProvinceCanPass(arg_32_1, arg_32_2)
	return self._newSlgData:isProvinceCanPass(arg_32_1, arg_32_2)
end

function NewSlgBaseData:getBarrierGIDByRC(arg_33_1, arg_33_2)
	return self._newSlgData:getBarrierGIDByRC(arg_33_1, arg_33_2)
end

function NewSlgBaseData:getProvinceGIdByRC(arg_34_1, arg_34_2)
	return self._newSlgData:getProvinceGIdByRC(arg_34_1, arg_34_2)
end

function NewSlgBaseData:getSelfProvinceGId()
	return self._newSlgData:getSelfProvinceGId()
end

function NewSlgBaseData:getSelfProvincePID()
	return self._newSlgData:getSelfProvincePID()
end

function NewSlgBaseData:getComponentsByGID(arg_37_1)
	return self._newSlgData:getComponentsByGID(arg_37_1)
end

function NewSlgBaseData:getBossComponentById(arg_38_1)
	return self._newSlgData:getBossComponentById(arg_38_1)
end

function NewSlgBaseData:getCityComponentById(arg_39_1)
	return self._newSlgData:getCityComponentById(arg_39_1)
end

function NewSlgBaseData:getChariotComponentById(arg_40_1, arg_40_2)
	return self._newSlgData:getChariotComponentById(arg_40_1, arg_40_2)
end

function NewSlgBaseData:getGateComponentsById(arg_41_1)
	return self._newSlgData:getGateComponentsById(arg_41_1)
end

function NewSlgBaseData:getObjectDataByType(arg_42_1)
	return self._newSlgData:getObjectDataByType(arg_42_1)
end

function NewSlgBaseData:getObjectDataByRC(arg_43_1, arg_43_2)
	return self._newSlgData:getObjectDataByRC(arg_43_1, arg_43_2)
end

function NewSlgBaseData:getFarmComponentById(arg_44_1)
	return self._newSlgData:getFarmComponentById(arg_44_1)
end

function NewSlgBaseData:getMonsterGIDByRC(arg_45_1, arg_45_2)
	return self._newSlgData:getMonsterGIDByRC(arg_45_1, arg_45_2)
end

function NewSlgBaseData:getTeamBossInfoByRC(arg_46_1, arg_46_2)
	return self._newSlgData:getTeamBossInfoByRC(arg_46_1, arg_46_2)
end

function NewSlgBaseData:getCityInfoByRC(arg_47_1, arg_47_2)
	return self._newSlgData:getCityInfoByRC(arg_47_1, arg_47_2)
end

function NewSlgBaseData:useFarmToken(arg_48_1)
	return self._newSlgData:useFarmToken(arg_48_1)
end

function NewSlgBaseData:getChariotInfoByRC(arg_49_1, arg_49_2)
	return self._newSlgData:getChariotInfoByRC(arg_49_1, arg_49_2)
end

function NewSlgBaseData:getGateInfoByRC(arg_50_1, arg_50_2)
	return self._newSlgData:getGateInfoByRC(arg_50_1, arg_50_2)
end

function NewSlgBaseData:getCheckPointState(arg_51_1)
	return self._newSlgData:getCheckPointState(arg_51_1)
end

function NewSlgBaseData:getCanChallengeProvinceGIDArr(arg_52_1, arg_52_2)
	return self._newSlgData:getCanChallengeProvinceGIDArr(arg_52_1, arg_52_2)
end

function NewSlgBaseData:canChallengeProvinceByProvinceGID(arg_53_1, arg_53_2)
	return self._newSlgData:canChallengeProvinceByProvinceGID(arg_53_1, arg_53_2)
end

function NewSlgBaseData:getComponentCfg(arg_54_1)
	return self._newSlgData:getComponentCfg(arg_54_1)
end

function NewSlgBaseData:getTerrainCfg(arg_55_1)
	return self._newSlgData:getTerrainCfg(arg_55_1)
end

function NewSlgBaseData:getProvinceCfgByGID(arg_56_1)
	return self._newSlgData:getProvinceCfgByGID(arg_56_1)
end

function NewSlgBaseData:getProvinceIdArrByType(arg_57_1)
	return self._newSlgData:getProvinceIdArrByType(arg_57_1)
end

function NewSlgBaseData:getProvinceLinkIds()
	return self._newSlgData:getProvinceLinkIds()
end

function NewSlgBaseData:isInProvinceLinkIds(arg_59_1)
	return self._newSlgData:isInProvinceLinkIds(arg_59_1)
end

function NewSlgBaseData:getProvinceCfgById(arg_60_1)
	return self._newSlgData:getProvinceCfgById(arg_60_1)
end

function NewSlgBaseData:getCityInfoById(arg_61_1)
	return self._newSlgData:getCityInfoById(arg_61_1)
end

function NewSlgBaseData:getBossInfoById(arg_62_1)
	return self._newSlgData:getBossInfoById(arg_62_1)
end

function NewSlgBaseData:getMonsterInfoByGID(arg_63_1)
	return self._newSlgData:getMonsterInfoByGID(arg_63_1)
end

function NewSlgBaseData:getMonsterInfoById(arg_64_1)
	return self._newSlgData:getMonsterInfoById(arg_64_1)
end

function NewSlgBaseData:getCheckpointInfo(arg_65_1)
	return self._newSlgData:getCheckpointInfo(arg_65_1)
end

function NewSlgBaseData:getCheckPointInfoById(arg_66_1)
	return self._newSlgData:getCheckPointInfoById(arg_66_1)
end

function NewSlgBaseData:getMainQuestInfoById(arg_67_1)
	return self._newSlgData:getMainQuestInfoById(arg_67_1)
end

function NewSlgBaseData:getCityQuestInfoById(arg_68_1)
	return self._newSlgData:getCityQuestInfoById(arg_68_1)
end

function NewSlgBaseData:getSearchMonster1(arg_69_1, arg_69_2)
	return self._newSlgData:getSearchMonster1(arg_69_1, arg_69_2)
end

function NewSlgBaseData:getSearchMonsterMulti(arg_70_1, arg_70_2, arg_70_3)
	return self._newSlgData:getSearchMonsterMulti(arg_70_1, arg_70_2, arg_70_3)
end

function NewSlgBaseData:getSearchMonster2(arg_71_1, arg_71_2)
	return self._newSlgData:getSearchMonster2(arg_71_1, arg_71_2)
end

function NewSlgBaseData:getCurAttackTargetIds()
	return self._newSlgData:getCurAttackTargetIds()
end

function NewSlgBaseData:searchCanChallengeMonster(arg_73_1, arg_73_2)
	return self._newSlgData:searchCanChallengeMonster(arg_73_1, arg_73_2)
end

function NewSlgBaseData:getSearchTeamBoss1(arg_74_1, arg_74_2)
	return self._newSlgData:getSearchTeamBoss1(arg_74_1, arg_74_2)
end

function NewSlgBaseData:getSearchTeamBossMulti(arg_75_1, arg_75_2, arg_75_3)
	return self._newSlgData:getSearchTeamBossMulti(arg_75_1, arg_75_2, arg_75_3)
end

function NewSlgBaseData:getSearchTeamBoss2(arg_76_1, arg_76_2)
	return self._newSlgData:getSearchTeamBoss2(arg_76_1, arg_76_2)
end

function NewSlgBaseData:searchCanChallengeBoss(arg_77_1, arg_77_2)
	return self._newSlgData:searchCanChallengeBoss(arg_77_1, arg_77_2)
end

function NewSlgBaseData:isGateCanPass(arg_78_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isGateCanPass(arg_78_1)
end

function NewSlgBaseData:getDestTargetInfo(arg_79_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getDestTargetInfo(arg_79_1)
end

function NewSlgBaseData:setAStar(arg_80_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:setAStar(arg_80_1)
end

function NewSlgBaseData:getAStar()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getAStar()
end

function NewSlgBaseData:resetAStar()
	if not self._newSlgData then
		return
	end

	self._newSlgData:resetAStar()
end

function NewSlgBaseData:getPath(arg_83_1, arg_83_2, arg_83_3, arg_83_4)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getPath(arg_83_1, arg_83_2, arg_83_3, arg_83_4)
end

function NewSlgBaseData:clearPathCache()
	if not self._newSlgData then
		return
	end

	self._newSlgData:clearPathCache()
end

function NewSlgBaseData:getPathByTmpl(arg_85_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getPathByTmpl(arg_85_1)
end

function NewSlgBaseData:getNewSlgParamsCfg()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getNewSlgParamsCfg()
end

function NewSlgBaseData:getNewSlgParamsValueById(arg_87_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getNewSlgParamsValueById(arg_87_1)
end

function NewSlgBaseData:getNewSlgParamsValueByKey(arg_88_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getNewSlgParamsValueByKey(arg_88_1)
end

function NewSlgBaseData:loadCache(arg_89_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:loadCache(arg_89_1)
end

function NewSlgBaseData:saveCache(arg_90_1, arg_90_2)
	if not self._newSlgData then
		return
	end

	self._newSlgData:saveCache(arg_90_1, arg_90_2)
end

function NewSlgBaseData:loadCacheWithActId(arg_91_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:loadCacheWithActId(arg_91_1)
end

function NewSlgBaseData:saveCacheWithActId(arg_92_1, arg_92_2)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:saveCacheWithActId(arg_92_1, arg_92_2)
end

function NewSlgBaseData:setRankData(arg_93_1, arg_93_2)
	if not self._newSlgData then
		return
	end

	self._newSlgData:setRankData(arg_93_1, arg_93_2)
end

function NewSlgBaseData:getRankData(arg_94_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getRankData(arg_94_1)
end

function NewSlgBaseData:updateCrossRedPoint(arg_95_1)
	if self._newSlgData then
		self._newSlgData:updateCrossRedPoint(arg_95_1)
	else
		table.insert(self._delayQueue, {
			func = handler(self, function(arg_96_0)
				arg_96_0._newSlgData:updateCrossRedPoint(arg_95_1)
			end)
		})
	end
end

function NewSlgBaseData:setActInfo(arg_97_1)
	if arg_97_1 == 1 then
		g.core.model.User:delayLoadData("newSlg1Data", "app.view.module.slg.model.NewSlgData")

		self._newSlgData = g.core.model.User.newSlg1Data
	elseif arg_97_1 == 2 then
		g.core.model.User:delayLoadData("newSlg2Data", "app.view.module.slg.model.NewSlg2Data")

		self._newSlgData = g.core.model.User.newSlg2Data
	end

	self._newSlgData:resetInitData()
	self._newSlgData:setActInfo(arg_97_1)
	self:delayExecute()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NEW_SLG_RESET_SEASON)
end

function NewSlgBaseData:updateRedData(arg_98_1)
	self._activityInfo = arg_98_1.act_info or nil

	if not self._activityInfo or self._activityInfo.id <= 0 then
		return
	end

	local var_98_0

	if self._activityInfo then
		var_98_0 = self._activityInfo.sub_id or 0

		if var_98_0 <= 0 then
			return
		end
	end

	self:setActInfo(var_98_0)
	self._newSlgData:updateRedData(arg_98_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.SLG_RED_REFRESH_EVENT)

	if g.core.model.User.allianceData:getAllianceId() ~= 0 then
		g.core.network.GameNetProxy:send_C2S_NewSlg_GetAllianceInfo({
			user_id = g.core.model.User:getId()
		})
	end
end

function NewSlgBaseData:exitSlg()
	if not self._newSlgData then
		return
	end

	self._newSlgData:exitSlg()
end

function NewSlgBaseData:enterSlg(arg_100_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:enterSlg(arg_100_1)
end

function NewSlgBaseData:updateBaseData(arg_101_1)
	if self._newSlgData then
		self._newSlgData:updateBaseData(arg_101_1)
	end
end

function NewSlgBaseData:genMonsterData(arg_102_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:genMonsterData(arg_102_1)
end

function NewSlgBaseData:notifyUsersData(arg_103_1)
	if not self._newSlgData then
		return
	end

	if arg_103_1.delete then
		self._newSlgData:deleteUserData(arg_103_1)
	else
		return self._newSlgData:updateUsersData({
			arg_103_1
		})
	end
end

function NewSlgBaseData:updateUsersData(arg_104_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:updateUsersData(arg_104_1)
end

function NewSlgBaseData:updateUserAsSvrSnapShot(arg_105_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:updateUserAsSvrSnapShot(arg_105_1)
end

function NewSlgBaseData:getMyUserData()
	return self._newSlgData:getMyUserData()
end

function NewSlgBaseData:getUsersData()
	return self._newSlgData:getUsersData()
end

function NewSlgBaseData:isCityPopTime()
	return self._newSlgData:isCityPopTime()
end

function NewSlgBaseData:onS2CGetServerInfo(arg_109_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:onS2CGetServerInfo(arg_109_1)
end

function NewSlgBaseData:getServerList()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getServerList()
end

function NewSlgBaseData:getUserDataByUid(arg_111_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getUserDataByUid(arg_111_1)
end

function NewSlgBaseData:updateMonstersData(arg_112_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:updateMonstersData(arg_112_1)
end

function NewSlgBaseData:getMonsterDataByRC(arg_113_1, arg_113_2)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getMonsterDataByRC(arg_113_1, arg_113_2)
end

function NewSlgBaseData:setMonsterData(arg_114_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:setMonsterData(arg_114_1)
end

function NewSlgBaseData:isSameProvinceGID(arg_115_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isSameProvinceGID(arg_115_1)
end

function NewSlgBaseData:isMonsterCanChallengeBySameProvinceGID(arg_116_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isMonsterCanChallengeBySameProvinceGID(arg_116_1)
end

function NewSlgBaseData:getMaxMonsterLv()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getMaxMonsterLv()
end

function NewSlgBaseData:getLeftMonsterFightCount()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getLeftMonsterFightCount()
end

function NewSlgBaseData:getLastMoveHomeTime()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getLastMoveHomeTime()
end

function NewSlgBaseData:canMoveToBornProvince(arg_120_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:canMoveToBornProvince(arg_120_1)
end

function NewSlgBaseData:isSelfInBornProvinces()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isSelfInBornProvinces()
end

function NewSlgBaseData:getMoveHomeCDTime()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getMoveHomeCDTime()
end

function NewSlgBaseData:getMoveHomeFreeTime()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getMoveHomeFreeTime()
end

function NewSlgBaseData:onRecvMoveHome(arg_124_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:onRecvMoveHome(arg_124_1)
end

function NewSlgBaseData:checkPlayMoveHomeEff()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:checkPlayMoveHomeEff()
end

function NewSlgBaseData:onRecvMoveHomeToBornProvince(arg_126_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:onRecvMoveHomeToBornProvince(arg_126_1)
end

function NewSlgBaseData:onRecvMonsterMarch(arg_127_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:onRecvMonsterMarch(arg_127_1)
end

function NewSlgBaseData:updateMarchRoutes(arg_128_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:updateMarchRoutes(arg_128_1)
end

function NewSlgBaseData:notifyMarchRoute(arg_129_1)
	if self._newSlgData then
		self._newSlgData:notifyMarchRoute(arg_129_1)
	end
end

function NewSlgBaseData:createBossRobotRoute(arg_130_1, arg_130_2, arg_130_3, arg_130_4, arg_130_5, arg_130_6, arg_130_7)
	if not self._newSlgData then
		return
	end

	self._newSlgData:createBossRobotRoute(arg_130_1, arg_130_2, arg_130_3, arg_130_4, arg_130_5, arg_130_6, arg_130_7)
end

function NewSlgBaseData:setRefreshMarch(arg_131_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:setRefreshMarch(arg_131_1)
end

function NewSlgBaseData:getRefreshMarch()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getRefreshMarch()
end

function NewSlgBaseData:getMarchUnit()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getMarchUnit()
end

function NewSlgBaseData:deleteMarchUnit(arg_134_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:deleteMarchUnit(arg_134_1)
end

function NewSlgBaseData:setMarchUnitEnd(arg_135_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:setMarchUnitEnd(arg_135_1)
end

function NewSlgBaseData:getAllianceData()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getAllianceData()
end

function NewSlgBaseData:getOccupiedCities()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getOccupiedCities()
end

function NewSlgBaseData:updateMyTeamData(arg_138_1)
	if self._newSlgData then
		self._newSlgData:updateMyTeamData(arg_138_1)
	end
end

function NewSlgBaseData:formatTeamCharactersByTeam(arg_139_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:formatTeamCharactersByTeam(arg_139_1)
end

function NewSlgBaseData:formatTeamCharacters(arg_140_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:formatTeamCharacters(arg_140_1)
end

function NewSlgBaseData:correctTeamTroopLevel(arg_141_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:correctTeamTroopLevel(arg_141_1)
end

function NewSlgBaseData:getMyTeamMap()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getMyTeamMap()
end

function NewSlgBaseData:getMyTeamByIndex(arg_143_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getMyTeamByIndex(arg_143_1)
end

function NewSlgBaseData:getMyTeamByArmyType(arg_144_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getMyTeamByArmyType(arg_144_1)
end

function NewSlgBaseData:isAllTeamIdle()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isAllTeamIdle()
end

function NewSlgBaseData:isTeamIdle(arg_146_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isTeamIdle(arg_146_1)
end

function NewSlgBaseData:isTeamMove(arg_147_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isTeamMove(arg_147_1)
end

function NewSlgBaseData:isTeamReturn(arg_148_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isTeamReturn(arg_148_1)
end

function NewSlgBaseData:getArmyRestInfoByType(arg_149_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getArmyRestInfoByType(arg_149_1)
end

function NewSlgBaseData:getTeamAuthorityCfgByType(arg_150_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getTeamAuthorityCfgByType(arg_150_1)
end

function NewSlgBaseData:geTeamItemList(arg_151_1, arg_151_2)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:geTeamItemList(arg_151_1, arg_151_2)
end

function NewSlgBaseData:getInitTeamData(arg_152_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getInitTeamData(arg_152_1)
end

function NewSlgBaseData:getTeamAuthority(arg_153_1, arg_153_2)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getTeamAuthority(arg_153_1, arg_153_2)
end

function NewSlgBaseData:getItemAuthorityByTypeAndBId(arg_154_1, arg_154_2)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getItemAuthorityByTypeAndBId(arg_154_1, arg_154_2)
end

function NewSlgBaseData:getItemAuthorityByCharacter(arg_155_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getItemAuthorityByCharacter(arg_155_1)
end

function NewSlgBaseData:getTeamAuthorityByTeam(arg_156_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getTeamAuthorityByTeam(arg_156_1)
end

function NewSlgBaseData:getMyTeamAuthorityByIndex(arg_157_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getMyTeamAuthorityByIndex(arg_157_1)
end

function NewSlgBaseData:getMyTeamAllAuthority()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getMyTeamAllAuthority()
end

function NewSlgBaseData:getTeamMoveToChariot(arg_159_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getTeamMoveToChariot(arg_159_1)
end

function NewSlgBaseData:getTeamMoveStatusByIndex(arg_160_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getTeamMoveStatusByIndex(arg_160_1)
end

function NewSlgBaseData:getReachDestLeftTime(arg_161_1, arg_161_2, arg_161_3, arg_161_4)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getReachDestLeftTime(arg_161_1, arg_161_2, arg_161_3, arg_161_4)
end

function NewSlgBaseData:isReachDest(arg_162_1, arg_162_2, arg_162_3, arg_162_4)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isReachDest(arg_162_1, arg_162_2, arg_162_3, arg_162_4)
end

function NewSlgBaseData:getLeftMarchTimeWithoutReturn(arg_163_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getLeftMarchTimeWithoutReturn(arg_163_1)
end

function NewSlgBaseData:calMoveLeftTime(arg_164_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:calMoveLeftTime(arg_164_1)
end

function NewSlgBaseData:getTeamStateByTeam(arg_165_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getTeamStateByTeam(arg_165_1)
end

function NewSlgBaseData:getMyPrivilegePer()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getMyPrivilegePer()
end

function NewSlgBaseData:getMaxTeamAuthority()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getMaxTeamAuthority()
end

function NewSlgBaseData:getCommonPassCardActId()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCommonPassCardActId()
end

function NewSlgBaseData:getArmyCtrlByType(arg_169_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getArmyCtrlByType(arg_169_1)
end

function NewSlgBaseData:getDebuffArmyCtrlByType(arg_170_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getDebuffArmyCtrlByType(arg_170_1)
end

function NewSlgBaseData:clearBattleReportTimer()
	if not self._newSlgData then
		return
	end

	self._newSlgData:clearBattleReportTimer()
end

function NewSlgBaseData:saveBattleReport(arg_172_1, arg_172_2, arg_172_3)
	if not self._newSlgData then
		return
	end

	self._newSlgData:saveBattleReport(arg_172_1, arg_172_2, arg_172_3)
end

function NewSlgBaseData:addReportExtraData(arg_173_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:addReportExtraData(arg_173_1)
end

function NewSlgBaseData:getBattleReportKey(arg_174_1, arg_174_2, arg_174_3)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getBattleReportKey(arg_174_1, arg_174_2, arg_174_3)
end

function NewSlgBaseData:exportRealBattleData(arg_175_1, arg_175_2)
	if not self._newSlgData then
		return
	end

	self._newSlgData:exportRealBattleData(arg_175_1, arg_175_2)
end

function NewSlgBaseData:getBattleReportData(arg_176_1, arg_176_2, arg_176_3)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getBattleReportData(arg_176_1, arg_176_2, arg_176_3)
end

function NewSlgBaseData:updateBattleMonsterReport(arg_177_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:updateBattleMonsterReport(arg_177_1)
end

function NewSlgBaseData:getBattleWinPercent(arg_178_1, arg_178_2, arg_178_3, arg_178_4, arg_178_5)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getBattleWinPercent(arg_178_1, arg_178_2, arg_178_3, arg_178_4, arg_178_5)
end

function NewSlgBaseData:getAuthorityGroupId()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getAuthorityGroupId()
end

function NewSlgBaseData:getMainCityGroupId()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getMainCityGroupId()
end

function NewSlgBaseData:getBarrackGroupId()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getBarrackGroupId()
end

function NewSlgBaseData:getSupplyGroupId()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getSupplyGroupId()
end

function NewSlgBaseData:updateCityChariots(arg_183_1, arg_183_2)
	if not self._newSlgData then
		return
	end

	self._newSlgData:updateCityChariots(arg_183_1, arg_183_2)
end

function NewSlgBaseData:getCityChariots(arg_184_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCityChariots(arg_184_1)
end

function NewSlgBaseData:getNearPos(arg_185_1, arg_185_2)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getNearPos(arg_185_1, arg_185_2)
end

function NewSlgBaseData:getCityFloatInfo()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCityFloatInfo()
end

function NewSlgBaseData:reqCityBattleEnd(arg_187_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:reqCityBattleEnd(arg_187_1)
end

function NewSlgBaseData:updateCitySerData(arg_188_1, arg_188_2)
	if self._newSlgData then
		self._newSlgData:updateCitySerData(arg_188_1, arg_188_2)
	end
end

function NewSlgBaseData:getCitySerData(arg_189_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCitySerData(arg_189_1)
end

function NewSlgBaseData:getLastCityInfo()
	if not self._newSlgData then
		if self._cacheNewSlgData then
			return self._cacheNewSlgData:getLastCityInfo()
		end

		return
	end

	return self._newSlgData:getLastCityInfo()
end

function NewSlgBaseData:getInfiniteCityInfo()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getInfiniteCityInfo()
end

function NewSlgBaseData:isLastCity(arg_192_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isLastCity(arg_192_1)
end

function NewSlgBaseData:isInfiniteCity(arg_193_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isInfiniteCity(arg_193_1)
end

function NewSlgBaseData:isNormalCity(arg_194_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isNormalCity(arg_194_1)
end

function NewSlgBaseData:getCityIdsByPID(arg_195_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCityIdsByPID(arg_195_1)
end

function NewSlgBaseData:isCityOccupied(arg_196_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isCityOccupied(arg_196_1)
end

function NewSlgBaseData:getAssistTroopNum(arg_197_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getAssistTroopNum(arg_197_1)
end

function NewSlgBaseData:isCityAssisted(arg_198_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isCityAssisted(arg_198_1)
end

function NewSlgBaseData:getAssistCities()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getAssistCities()
end

function NewSlgBaseData:setAssistCities(arg_200_1)
	if self._newSlgData then
		self._newSlgData:setAssistCities(arg_200_1)
	end
end

function NewSlgBaseData:getCityOccupyAlliance(arg_201_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCityOccupyAlliance(arg_201_1)
end

function NewSlgBaseData:isCityDeclared(arg_202_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isCityDeclared(arg_202_1)
end

function NewSlgBaseData:isCityCanDeclare(arg_203_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isCityCanDeclare(arg_203_1)
end

function NewSlgBaseData:getCityOccupyAllianceId(arg_204_1)
	return self._newSlgData:getCityOccupyAllianceId(arg_204_1)
end

function NewSlgBaseData:setCityDeclarations(arg_205_1)
	if self._newSlgData then
		self._newSlgData:setCityDeclarations(arg_205_1)
	end
end

function NewSlgBaseData:getCityDeclaration(arg_206_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCityDeclaration(arg_206_1)
end

function NewSlgBaseData:setCityDeclaration(arg_207_1, arg_207_2)
	if not self._newSlgData then
		return
	end

	self._newSlgData:setCityDeclaration(arg_207_1, arg_207_2)
end

function NewSlgBaseData:getNextIdWithoutJudge()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getNextIdWithoutJudge()
end

function NewSlgBaseData:getNextAttackCityIds()
	return self._newSlgData and self._newSlgData:getNextAttackCityIds() or {}
end

function NewSlgBaseData:isCityDayUnlock(arg_210_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isCityDayUnlock(arg_210_1)
end

function NewSlgBaseData:isCityPointUnlock(arg_211_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isCityPointUnlock(arg_211_1)
end

function NewSlgBaseData:getDailyGatherTimeStr()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getDailyGatherTimeStr()
end

function NewSlgBaseData:isChariotAboutAttackTime(arg_213_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isChariotAboutAttackTime(arg_213_1)
end

function NewSlgBaseData:isChariotGatherTime()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isChariotGatherTime()
end

function NewSlgBaseData:getChariotGatherTotalTime()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getChariotGatherTotalTime()
end

function NewSlgBaseData:isChariotMoveTime()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isChariotMoveTime()
end

function NewSlgBaseData:getChariotGatherStartTime()
	return self._newSlgData and self._newSlgData:getChariotGatherStartTime() or 0
end

function NewSlgBaseData:getChariotGatherEndTime()
	return self._newSlgData and self._newSlgData:getChariotGatherEndTime() or 0
end

function NewSlgBaseData:getChariotMoveTimeStartTime()
	return self._newSlgData and self._newSlgData:getChariotMoveTimeStartTime() or 0
end

function NewSlgBaseData:getChariotMoveTimeEndTime()
	return self._newSlgData and self._newSlgData:getChariotMoveTimeEndTime() or 0
end

function NewSlgBaseData:getChariotMoveTotalTime()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getChariotMoveTotalTime()
end

function NewSlgBaseData:getCityBattleStartTime()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCityBattleStartTime()
end

function NewSlgBaseData:getCityBattleEndTime()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCityBattleEndTime()
end

function NewSlgBaseData:isCityBattleTime()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isCityBattleTime()
end

function NewSlgBaseData:isInCityBattleFinishTime()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isInCityBattleFinishTime()
end

function NewSlgBaseData:getCityPeriod()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCityPeriod()
end

function NewSlgBaseData:getChariotBelongAlliance(arg_227_1, arg_227_2)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getChariotBelongAlliance(arg_227_1, arg_227_2)
end

function NewSlgBaseData:getChariotShowState(arg_228_1, arg_228_2)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getChariotShowState(arg_228_1, arg_228_2)
end

function NewSlgBaseData:getChariotAuthority(arg_229_1, arg_229_2)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getChariotAuthority(arg_229_1, arg_229_2)
end

function NewSlgBaseData:getCityDefNum(arg_230_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCityDefNum(arg_230_1)
end

function NewSlgBaseData:getCityNpcDefNum(arg_231_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCityNpcDefNum(arg_231_1)
end

function NewSlgBaseData:getCityMaxRealDefNum(arg_232_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCityMaxRealDefNum(arg_232_1)
end

function NewSlgBaseData:getChariotGatherNum(arg_233_1, arg_233_2)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getChariotGatherNum(arg_233_1, arg_233_2)
end

function NewSlgBaseData:getChariotGatherMaxNum(arg_234_1, arg_234_2)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getChariotGatherMaxNum(arg_234_1, arg_234_2)
end

function NewSlgBaseData:getCurrentOccupiedCityLevel()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCurrentOccupiedCityLevel()
end

function NewSlgBaseData:getCurrentBattleData()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCurrentBattleData()
end

function NewSlgBaseData:isInAttackCityProcess()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isInAttackCityProcess()
end

function NewSlgBaseData:isCityFighting(arg_238_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isCityFighting(arg_238_1)
end

function NewSlgBaseData:canCityClick(arg_239_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:canCityClick(arg_239_1)
end

function NewSlgBaseData:isCityCanGather(arg_240_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isCityCanGather(arg_240_1)
end

function NewSlgBaseData:updateBossAuthority(arg_241_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:updateBossAuthority(arg_241_1)
end

function NewSlgBaseData:getBossTotalAuthority(arg_242_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getBossTotalAuthority(arg_242_1)
end

function NewSlgBaseData:isBossFighting(arg_243_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isBossFighting(arg_243_1)
end

function NewSlgBaseData:reqBossTeamKickOut(arg_244_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:reqBossTeamKickOut(arg_244_1)
end

function NewSlgBaseData:reqBossTeamTransferLeader(arg_245_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:reqBossTeamTransferLeader(arg_245_1)
end

function NewSlgBaseData:reqBossTeamLeave(arg_246_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:reqBossTeamLeave(arg_246_1)
end

function NewSlgBaseData:reqBossTeamInfoDeal(arg_247_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:reqBossTeamInfoDeal(arg_247_1)
end

function NewSlgBaseData:reqBossUserStateNotify(arg_248_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:reqBossUserStateNotify(arg_248_1)
end

function NewSlgBaseData:reqBossTeamJoinNotify(arg_249_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:reqBossTeamJoinNotify(arg_249_1)
end

function NewSlgBaseData:reqBossBattleStartNotify(arg_250_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:reqBossBattleStartNotify(arg_250_1)
end

function NewSlgBaseData:reqBossBattleFinishNotify(arg_251_1)
	if self._newSlgData then
		self._newSlgData:reqBossBattleFinishNotify(arg_251_1)
	end
end

function NewSlgBaseData:setBossChallengedLevel(arg_252_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:setBossChallengedLevel(arg_252_1)
end

function NewSlgBaseData:getBossChallengedLevel()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getBossChallengedLevel()
end

function NewSlgBaseData:reqSLGEnterByBoss(arg_254_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:reqSLGEnterByBoss(arg_254_1)
end

function NewSlgBaseData:dealBossTeamUserSort(arg_255_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:dealBossTeamUserSort(arg_255_1)
end

function NewSlgBaseData:updateBossTeamsInfoSerData(arg_256_1, arg_256_2)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:updateBossTeamsInfoSerData(arg_256_1, arg_256_2)
end

function NewSlgBaseData:getBossTeamInfo(arg_257_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getBossTeamInfo(arg_257_1)
end

function NewSlgBaseData:isSelfInBossTeam(arg_258_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isSelfInBossTeam(arg_258_1)
end

function NewSlgBaseData:clearBossTeam(arg_259_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:clearBossTeam(arg_259_1)
end

function NewSlgBaseData:getBossChallengeTime()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getBossChallengeTime()
end

function NewSlgBaseData:getBossChallengeAssistTime()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getBossChallengeAssistTime()
end

function NewSlgBaseData:getBossTeamGatherTotalTime()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getBossTeamGatherTotalTime()
end

function NewSlgBaseData:getPrivateContentArrWithoutShow()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getPrivateContentArrWithoutShow()
end

function NewSlgBaseData:setPrivateContentData(arg_264_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:setPrivateContentData(arg_264_1)
end

function NewSlgBaseData:getPrivateContentArr()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getPrivateContentArr()
end

function NewSlgBaseData:getPrivateContentData(arg_266_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getPrivateContentData(arg_266_1)
end

function NewSlgBaseData:dealContentIsShow(arg_267_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:dealContentIsShow(arg_267_1)
end

function NewSlgBaseData:isBossTeamInvitedShow(arg_268_1, arg_268_2)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isBossTeamInvitedShow(arg_268_1, arg_268_2)
end

function NewSlgBaseData:getInvitedDataByBossId(arg_269_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getInvitedDataByBossId(arg_269_1)
end

function NewSlgBaseData:decodeInviteContent(arg_270_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:decodeInviteContent(arg_270_1)
end

function NewSlgBaseData:encodeInviteContent(arg_271_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:encodeInviteContent(arg_271_1)
end

function NewSlgBaseData:getCanChallengeBossIds(arg_272_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCanChallengeBossIds(arg_272_1)
end

function NewSlgBaseData:getCanChallengeBossIdsByLevel(arg_273_1, arg_273_2)
	if not self._newSlgData then
		return
	end

	local var_273_0, var_273_1 = self._newSlgData:getCanChallengeBossIdsByLevel(arg_273_1, arg_273_2)

	return var_273_0, var_273_1
end

function NewSlgBaseData:getCityQuestTabArr()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCityQuestTabArr()
end

function NewSlgBaseData:getCityQuestArrByLevel(arg_275_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCityQuestArrByLevel(arg_275_1)
end

function NewSlgBaseData:getCityQuestProgress(arg_276_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCityQuestProgress(arg_276_1)
end

function NewSlgBaseData:isCityQuestAwarded(arg_277_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isCityQuestAwarded(arg_277_1)
end

function NewSlgBaseData:updateCityQuestProgressSerData(arg_278_1, arg_278_2)
	if self._newSlgData then
		self._newSlgData:updateCityQuestProgressSerData(arg_278_1, arg_278_2)
	end
end

function NewSlgBaseData:updateCityQuestAwarded(arg_279_1, arg_279_2)
	if not self._newSlgData then
		return
	end

	self._newSlgData:updateCityQuestAwarded(arg_279_1, arg_279_2)
end

function NewSlgBaseData:isAllCityQuestAwardedByLevel(arg_280_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isAllCityQuestAwardedByLevel(arg_280_1)
end

function NewSlgBaseData:dealCityQuestArrByLevel(arg_281_1, arg_281_2)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:dealCityQuestArrByLevel(arg_281_1, arg_281_2)
end

function NewSlgBaseData:canAchieveCityQuest(arg_282_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:canAchieveCityQuest(arg_282_1)
end

function NewSlgBaseData:updateCheckPointTask(arg_283_1, arg_283_2)
	if not self._newSlgData then
		return
	end

	self._newSlgData:updateCheckPointTask(arg_283_1, arg_283_2)
end

function NewSlgBaseData:getCheckPointProgressByGroup(arg_284_1)
	return self._newSlgData:getCheckPointProgressByGroup(arg_284_1)
end

function NewSlgBaseData:getCheckPointTaskCurVArr(arg_285_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCheckPointTaskCurVArr(arg_285_1)
end

function NewSlgBaseData:getCheckPointConditionState(arg_286_1, arg_286_2)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCheckPointConditionState(arg_286_1, arg_286_2)
end

function NewSlgBaseData:updateMainQuestDataById(arg_287_1)
	self._newSlgData:updateMainQuestDataById(arg_287_1)
end

function NewSlgBaseData:updateUnitMainQuest(arg_288_1)
	if self._newSlgData then
		self._newSlgData:updateUnitMainQuest(arg_288_1)
	end
end

function NewSlgBaseData:updateAchievementSelfTaskData(arg_289_1, arg_289_2)
	if self._newSlgData then
		self._newSlgData:updateAchievementSelfTaskData(arg_289_1, arg_289_2)
	end
end

function NewSlgBaseData:getAchievementSelfTaskData(arg_290_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getAchievementSelfTaskData(arg_290_1)
end

function NewSlgBaseData:getCurMainQuest()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCurMainQuest()
end

function NewSlgBaseData:getMainQuestArr()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getMainQuestArr()
end

function NewSlgBaseData:getMainQuestGoal(arg_293_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getMainQuestGoal(arg_293_1)
end

function NewSlgBaseData:getNewSlgCurrentRankReward(arg_294_1, arg_294_2)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getNewSlgCurrentRankReward(arg_294_1, arg_294_2)
end

function NewSlgBaseData:getRankAwardByTypeAndValueAndRank(arg_295_1, arg_295_2, arg_295_3)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getRankAwardByTypeAndValueAndRank(arg_295_1, arg_295_2, arg_295_3)
end

function NewSlgBaseData:getNewSlgMyPathCity()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getNewSlgMyPathCity()
end

function NewSlgBaseData:getNewSlgCity()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getNewSlgCity()
end

function NewSlgBaseData:getLastCityOpenTime()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getLastCityOpenTime()
end

function NewSlgBaseData:getIsGotPreviewReward(arg_299_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getIsGotPreviewReward(arg_299_1)
end

function NewSlgBaseData:setIsGotPreviewReward(arg_300_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:setIsGotPreviewReward(arg_300_1)
end

function NewSlgBaseData:getMainQuestTaskSerDataById(arg_301_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getMainQuestTaskSerDataById(arg_301_1)
end

function NewSlgBaseData:checkIsGotTaskAwardById(arg_302_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:checkIsGotTaskAwardById(arg_302_1)
end

function NewSlgBaseData:checkTaskCanGetAwardById(arg_303_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:checkTaskCanGetAwardById(arg_303_1)
end

function NewSlgBaseData:checkTaskFinishById(arg_304_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:checkTaskFinishById(arg_304_1)
end

function NewSlgBaseData:setJumpPos(arg_305_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:setJumpPos(arg_305_1)
end

function NewSlgBaseData:getJumpPos()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getJumpPos()
end

function NewSlgBaseData:onS2CNewSlgGetReportList(arg_307_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:onS2CNewSlgGetReportList(arg_307_1)
end

function NewSlgBaseData:onS2CNewSlgGetReport(arg_308_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:onS2CNewSlgGetReport(arg_308_1)
end

function NewSlgBaseData:recordBattleReport(arg_309_1)
	if self._newSlgData then
		self._newSlgData:recordBattleReport(arg_309_1)
	end
end

function NewSlgBaseData:getBattleReportById(arg_310_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getBattleReportById(arg_310_1)
end

function NewSlgBaseData:getNewBattleReportList()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getNewBattleReportList()
end

function NewSlgBaseData:isShowNewReportPoint()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isShowNewReportPoint()
end

function NewSlgBaseData:oneNewBattleEnd()
	if not self._newSlgData then
		return
	end

	self._newSlgData:oneNewBattleEnd()
end

function NewSlgBaseData:checkNewBattleReportCnt(arg_314_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:checkNewBattleReportCnt(arg_314_1)
end

function NewSlgBaseData:isViewedBattleReport(arg_315_1)
	if not self._newSlgData then
		return
	end

	return self._newSlgData:isViewedBattleReport(arg_315_1)
end

function NewSlgBaseData:viewedBattleReport(arg_316_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:viewedBattleReport(arg_316_1)
end

function NewSlgBaseData:getCampaignStr()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCampaignStr()
end

function NewSlgBaseData:cacheTeamData(arg_318_1)
	if not self._newSlgData then
		return
	end

	self._newSlgData:cacheTeamData(arg_318_1)
end

function NewSlgBaseData:getCacheTeamData()
	if not self._newSlgData then
		return
	end

	return self._newSlgData:getCacheTeamData()
end

function NewSlgBaseData:checkNewSlgCityGather()
	return self._newSlgData and self._newSlgData:checkNewSlgCityGather()
end

function NewSlgBaseData:checkNewSlgCityGatherOutMap()
	return self._newSlgData and self._newSlgData:checkNewSlgCityGatherOutMap()
end

function NewSlgBaseData:isHaveCheckPointPassed(arg_322_1)
	return self._newSlgData and self._newSlgData:isHaveCheckPointPassed(arg_322_1)
end

function NewSlgBaseData:updateMoveTargetRightNow(arg_323_1)
	self._newSlgData:updateMoveTargetRightNow(arg_323_1)
end

function NewSlgBaseData:checkHasTeamInvite(arg_324_1)
	return self._newSlgData and self._newSlgData:checkHasTeamInvite(arg_324_1)
end

function NewSlgBaseData:setOpenSearch()
	self._newSlgData:setOpenSearch()
end

function NewSlgBaseData:isNeedOpenSearch()
	return self._newSlgData:isNeedOpenSearch()
end

function NewSlgBaseData:setOpenTeamBattle()
	self._newSlgData:setOpenTeamBattle()
end

function NewSlgBaseData:isNeedOpenTeamBattle()
	return self._newSlgData:isNeedOpenTeamBattle()
end

function NewSlgBaseData:isMyTarget(arg_329_1)
	return self._newSlgData:isMyTarget(arg_329_1)
end

function NewSlgBaseData:hasNewBattleReport()
	return self._newSlgData:hasNewBattleReport()
end

function NewSlgBaseData:saveMyOldFightValue()
	self._newSlgData:saveMyOldFightValue()
end

function NewSlgBaseData:getFightValueChange()
	return self._newSlgData:getFightValueChange()
end

function NewSlgBaseData:setClearSpriteFrameCache(arg_333_1)
	self._newSlgData:setClearSpriteFrameCache(arg_333_1)
end

function NewSlgBaseData:isClearSpriteFrameCache()
	return self._newSlgData:isClearSpriteFrameCache()
end

function NewSlgBaseData:getScoreAddition()
	return self._newSlgData:getScoreAddition()
end

function NewSlgBaseData:getResAddition(arg_336_1)
	return self._newSlgData:getResAddition(arg_336_1)
end

function NewSlgBaseData:reqObtainAchievementReward(arg_337_1)
	self._newSlgData:reqObtainAchievementReward(arg_337_1)
end

function NewSlgBaseData:isCityInShare(arg_338_1)
	return self._newSlgData:isCityInShare(arg_338_1)
end

function NewSlgBaseData:updateCityGatherNum(arg_339_1, arg_339_2)
	if self._newSlgData then
		self._newSlgData:updateCityGatherNum(arg_339_1, arg_339_2)
	end
end

function NewSlgBaseData:updateCitySimpleData(arg_340_1)
	self._newSlgData:updateCitySimpleData(arg_340_1)
end

function NewSlgBaseData:getAchievementKey(arg_341_1)
	return self._newSlgData:getAchievementKey(arg_341_1)
end

function NewSlgBaseData:getAchievementDataArrByType(arg_342_1)
	return self._newSlgData:getAchievementDataArrByType(arg_342_1)
end

function NewSlgBaseData:getAchievementInfoById(arg_343_1)
	return self._newSlgData:getAchievementInfoById(arg_343_1)
end

function NewSlgBaseData:getCurAchievementTask(arg_344_1, arg_344_2)
	return self._newSlgData:getCurAchievementTask(arg_344_1, arg_344_2)
end

function NewSlgBaseData:getBuildInfoById(arg_345_1)
	return self._newSlgData:getBuildInfoById(arg_345_1)
end

function NewSlgBaseData:getBuildInfoArrByTempId(arg_346_1)
	return self._newSlgData:getBuildInfoArrByTempId(arg_346_1)
end

function NewSlgBaseData:getBuildInfoByTempIdAndLevelIdx(arg_347_1, arg_347_2)
	return self._newSlgData:getBuildInfoByTempIdAndLevelIdx(arg_347_1, arg_347_2)
end

function NewSlgBaseData:updateCityOccupyAlliance(arg_348_1, arg_348_2)
	self._newSlgData:updateCityOccupyAlliance(arg_348_1, arg_348_2)
end

function NewSlgBaseData:updateBuildData(arg_349_1, arg_349_2)
	self._newSlgData:updateBuildData(arg_349_1, arg_349_2)
end

function NewSlgBaseData:updateCityOccupierId(arg_350_1, arg_350_2)
	if self._newSlgData then
		self._newSlgData:updateCityOccupierId(arg_350_1, arg_350_2)
	end
end

function NewSlgBaseData:updateCityDeclaredAlliance(arg_351_1, arg_351_2)
	if self._newSlgData then
		self._newSlgData:updateCityDeclaredAlliance(arg_351_1, arg_351_2)
	end
end

function NewSlgBaseData:setCityDeclaredSelfAlliance()
	self._newSlgData:setCityDeclaredSelfAlliance()
end

function NewSlgBaseData:updateSelfDeclareCities(arg_353_1, arg_353_2)
	if self._newSlgData then
		self._newSlgData:updateSelfDeclareCities(arg_353_1, arg_353_2)
	end
end

function NewSlgBaseData:setScoreAddition(arg_354_1)
	self._newSlgData:setScoreAddition(arg_354_1)
end

function NewSlgBaseData:updateResAddition(arg_355_1, arg_355_2)
	self._newSlgData:updateResAddition(arg_355_1, arg_355_2)
end

function NewSlgBaseData:getGiveUpCities()
	return self._newSlgData:getGiveUpCities()
end

function NewSlgBaseData:setGiveUpCities(arg_357_1)
	self._newSlgData:setGiveUpCities(arg_357_1)
end

function NewSlgBaseData:getBeginCityId()
	return self._newSlgData:getBeginCityId()
end

function NewSlgBaseData:getCanDeclareCities()
	return self._newSlgData:getCanDeclareCities()
end

function NewSlgBaseData:getAdjacentCities(arg_360_1)
	return self._newSlgData:getAdjacentCities(arg_360_1)
end

function NewSlgBaseData:getAdjacentOccupiedCities(arg_361_1)
	return self._newSlgData:getAdjacentOccupiedCities(arg_361_1)
end

function NewSlgBaseData:getSelfAdjacentOccupyCities(arg_362_1)
	return self._newSlgData:getSelfAdjacentOccupyCities(arg_362_1)
end

function NewSlgBaseData:isS2CityUnlock(arg_363_1)
	return self._newSlgData:isS2CityUnlock(arg_363_1)
end

function NewSlgBaseData:getCityDeclaredAlliances(arg_364_1)
	return self._newSlgData:getCityDeclaredAlliances(arg_364_1)
end

function NewSlgBaseData:getSelfGatherNum(arg_365_1)
	return self._newSlgData:getSelfGatherNum(arg_365_1)
end

function NewSlgBaseData:getOtherGatherNum(arg_366_1)
	return self._newSlgData:getOtherGatherNum(arg_366_1)
end

function NewSlgBaseData:isCityInSelfBorn(arg_367_1)
	return self._newSlgData:isCityInSelfBorn(arg_367_1)
end

function NewSlgBaseData:getBuildDataById(arg_368_1)
	return self._newSlgData:getBuildDataById(arg_368_1)
end

function NewSlgBaseData:getAssistAuthority(arg_369_1)
	return self._newSlgData:getAssistAuthority(arg_369_1)
end

function NewSlgBaseData:hasBoxCanUse()
	return self._newSlgData and self._newSlgData:hasBoxCanUse()
end

function NewSlgBaseData:getSelfDeclaredCities()
	return self._newSlgData:getSelfDeclaredCities()
end

function NewSlgBaseData:isCityGather(arg_372_1)
	return self._newSlgData:isCityGather(arg_372_1)
end

function NewSlgBaseData:checkSendCrossPointMsg()
	if self._newSlgData then
		self._newSlgData:checkSendCrossPointMsg()
	end
end

function NewSlgBaseData:isCanDeclaredCity()
	return self._newSlgData and self._newSlgData:isCanDeclaredCity()
end

function NewSlgBaseData:_deleteDeclareCity(arg_375_1)
	self._newSlgData:_deleteDeclareCity(arg_375_1)
end

function NewSlgBaseData:hasAchievementRed(arg_376_1)
	return self._newSlgData and self._newSlgData:hasAchievementRed(arg_376_1)
end

function NewSlgBaseData:setCityResultServerData(arg_377_1)
	if self._newSlgData then
		self._newSlgData.cityResultServerData = arg_377_1
	end
end

function NewSlgBaseData:getCityResultServerData()
	return (self._newSlgData or nil) and (self._newSlgData.cityResultServerData or nil)
end

function NewSlgBaseData:delayExecute()
	while #self._delayQueue > 0 do
		table.remove(self._delayQueue, 1).func()
	end
end

function NewSlgBaseData:getMonsterCfgArrByType(arg_380_1)
	return self._newSlgData and self._newSlgData:getMonsterCfgArrByType(arg_380_1)
end

function NewSlgBaseData:getMonsterMaxLevel()
	return self._newSlgData and self._newSlgData:getMonsterMaxLevel()
end

function NewSlgBaseData:getBossMaxLevel()
	return self._newSlgData and self._newSlgData:getBossMaxLevel()
end

function NewSlgBaseData:isFarmRentLimit()
	return self._newSlgData and self._newSlgData:isFarmRentLimit()
end

function NewSlgBaseData:canGetFarmRentAwards()
	return self._newSlgData and self._newSlgData:canGetFarmRentAwards()
end

function NewSlgBaseData:hasGetFarmRentAwards()
	return self._newSlgData and self._newSlgData:hasGetFarmRentAwards()
end

function NewSlgBaseData:canGetFarmOccupyAwards()
	return self._newSlgData and self._newSlgData:canGetFarmOccupyAwards()
end

function NewSlgBaseData:updateFarmAward(arg_387_1)
	return self._newSlgData and self._newSlgData:updateFarmAward(arg_387_1)
end

function NewSlgBaseData:canGetFarmAward()
	return self._newSlgData and self._newSlgData:canGetFarmAward()
end

function NewSlgBaseData:getMapId()
	return self._newSlgData and self._newSlgData:getMapId()
end

function NewSlgBaseData:updateFirstKillAward(arg_390_1)
	return self._newSlgData and self._newSlgData:updateFirstKillAward(arg_390_1)
end

function NewSlgBaseData:updateFirstKillInfo(arg_391_1)
	return self._newSlgData and self._newSlgData:updateFirstKillInfo(arg_391_1)
end

function NewSlgBaseData:hasGetFirstKillAwardById(arg_392_1)
	return self._newSlgData and self._newSlgData:hasGetFirstKillAwardById(arg_392_1)
end

function NewSlgBaseData:canGetFirstKillAwardById(arg_393_1, arg_393_2)
	return self._newSlgData and self._newSlgData:canGetFirstKillAwardById(arg_393_1, arg_393_2)
end

function NewSlgBaseData:canGetFirstKillAwardByType(arg_394_1)
	return self._newSlgData and self._newSlgData:canGetFirstKillAwardByType(arg_394_1)
end

function NewSlgBaseData:canGetFirstKillAward()
	return self._newSlgData and self._newSlgData:canGetFirstKillAward()
end

function NewSlgBaseData:getBountyTaskState(arg_396_1)
	return self._newSlgData and self._newSlgData:getBountyTaskState(arg_396_1)
end

function NewSlgBaseData:canGetBountyTaskAward()
	return self._newSlgData and self._newSlgData:canGetBountyTaskAward()
end

function NewSlgBaseData:getIgnoreBountyTaskTip()
	return self._newSlgData and self._newSlgData:getIgnoreBountyTaskTip()
end

function NewSlgBaseData:setIgnoreBountyTaskTip(arg_399_1)
	return self._newSlgData and self._newSlgData:setIgnoreBountyTaskTip(arg_399_1)
end

function NewSlgBaseData:getIgnoreRefreshTip()
	return self._newSlgData and self._newSlgData:getIgnoreRefreshTip()
end

function NewSlgBaseData:setIgnoreRefreshTip(arg_401_1)
	return self._newSlgData and self._newSlgData:setIgnoreRefreshTip(arg_401_1)
end

function NewSlgBaseData:getBountyTaskRefreshTimes()
	return self._newSlgData and self._newSlgData:getBountyTaskRefreshTimes()
end

function NewSlgBaseData:hasBossTotalAuthority(arg_403_1)
	return self._newSlgData and self._newSlgData:hasBossTotalAuthority(arg_403_1)
end

function NewSlgBaseData:updateBountyTask(arg_404_1)
	return self._newSlgData and self._newSlgData:updateBountyTask(arg_404_1)
end

function NewSlgBaseData:updateBountyInfo(arg_405_1)
	return self._newSlgData and self._newSlgData:updateBountyInfo(arg_405_1)
end

function NewSlgBaseData:getSelfOccupyFarmNum()
	return self._newSlgData and self._newSlgData:getSelfOccupyFarmNum()
end

function NewSlgBaseData:reqBossAuthority()
	return self._newSlgData and self._newSlgData:reqBossAuthority()
end

function NewSlgBaseData:getDistanceArr()
	return self._newSlgData and self._newSlgData:getDistanceArr()
end

function NewSlgBaseData:getOccingFarmArr()
	return self._newSlgData and self._newSlgData:getOccingFarmArr()
end

function NewSlgBaseData:getAtkingFarmArr()
	return self._newSlgData and self._newSlgData:getAtkingFarmArr()
end

function NewSlgBaseData:isProtecting(arg_411_1)
	return self._newSlgData and self._newSlgData:isProtecting(arg_411_1)
end

function NewSlgBaseData:isOccupying(arg_412_1)
	return self._newSlgData and self._newSlgData:isOccupying(arg_412_1)
end

function NewSlgBaseData:getLeftFood(arg_413_1)
	return self._newSlgData and self._newSlgData:getLeftFood(arg_413_1)
end

function NewSlgBaseData:getAuthorityDecreaseNum()
	return self._newSlgData and self._newSlgData:getAuthorityDecreaseNum(...)
end

function NewSlgBaseData:getGraph()
	return self._newSlgData and self._newSlgData:getGraph()
end

function NewSlgBaseData:getFarmDataById(arg_416_1)
	return self._newSlgData and self._newSlgData:getFarmDataById(arg_416_1)
end

function NewSlgBaseData:updateFarmUnitSerData(arg_417_1)
	return self._newSlgData and self._newSlgData:updateFarmUnitSerData(arg_417_1)
end

function NewSlgBaseData:updateFarmSerData(arg_418_1, arg_418_2)
	return self._newSlgData and self._newSlgData:updateFarmSerData(arg_418_1, arg_418_2)
end

function NewSlgBaseData:getChariotBelongAlliances(arg_419_1, arg_419_2)
	return self._newSlgData and self._newSlgData:updateFarmSerData(arg_419_1, arg_419_2)
end

function NewSlgBaseData:checkTrialCanBattle()
	return self._newSlgData and self._newSlgData:checkTrialCanBattle()
end

function NewSlgBaseData:checkCityForceAwardGot()
	return self._newSlgData and self._newSlgData:checkCityForceAwardGot()
end

function NewSlgBaseData:checkCanGetCityForceAward()
	return self._newSlgData and self._newSlgData:checkCanGetCityForceAward()
end

function NewSlgBaseData:checkIsMyOccupy(arg_423_1)
	return self._newSlgData and self._newSlgData:checkIsMyOccupy(arg_423_1)
end

function NewSlgBaseData:isMyForce(arg_424_1)
	return self._newSlgData and self._newSlgData:isMyForce(arg_424_1)
end

function NewSlgBaseData:isDrillOpen()
	return self._newSlgData and self._newSlgData:isDrillOpen()
end

function NewSlgBaseData:isTrailSettleTime()
	return self._newSlgData and self._newSlgData:isTrailSettleTime()
end

function NewSlgBaseData:isTrialTimeEnough()
	return self._newSlgData and self._newSlgData:isTrialTimeEnough()
end

function NewSlgBaseData:isMainAlliance(arg_428_1)
	return self._newSlgData and self._newSlgData:isMainAlliance(arg_428_1)
end

function NewSlgBaseData:isOwnMainAlliance()
	return self._newSlgData and self._newSlgData:isOwnMainAlliance()
end

function NewSlgBaseData:getAuthorityScale()
	return self._newSlgData and self._newSlgData:getAuthorityScale()
end

function NewSlgBaseData:getTrialSettleData()
	return self._newSlgData and self._newSlgData:getTrialSettleData()
end

function NewSlgBaseData:getResAddition(arg_432_1)
	return self._newSlgData and self._newSlgData:getResAddition(arg_432_1)
end

function NewSlgBaseData:getDrillResAddPidByLevel(arg_433_1)
	return self._newSlgData and self._newSlgData:getDrillResAddPidByLevel(arg_433_1)
end

function NewSlgBaseData:getDrillRefreshBattleTime(arg_434_1, arg_434_2)
	return self._newSlgData and self._newSlgData:getDrillRefreshBattleTime(arg_434_1, arg_434_2)
end

function NewSlgBaseData:getDrillBattleTime(arg_435_1, arg_435_2)
	return self._newSlgData and self._newSlgData:getDrillBattleTime(arg_435_1, arg_435_2)
end

function NewSlgBaseData:getParticipationCityTime()
	return self._newSlgData and self._newSlgData:getParticipationCityTime()
end

function NewSlgBaseData:getLastGetProvinceRankAwardTime()
	return self._newSlgData and self._newSlgData:getLastGetProvinceRankAwardTime()
end

function NewSlgBaseData:getModifyNum()
	return self._newSlgData and self._newSlgData:getModifyNum()
end

function NewSlgBaseData:getTrailStartTime()
	return self._newSlgData and self._newSlgData:getTrailStartTime()
end

function NewSlgBaseData:getTrailNewRoundTime()
	return self._newSlgData and self._newSlgData:getTrailNewRoundTime()
end

function NewSlgBaseData:getTrailSettleTime()
	return self._newSlgData and self._newSlgData:getTrailSettleTime()
end

function NewSlgBaseData:getTrialLevel()
	return self._newSlgData and self._newSlgData:getTrialLevel()
end

function NewSlgBaseData:getTrialRound()
	return self._newSlgData and self._newSlgData:getTrialRound()
end

function NewSlgBaseData:getMainAllianceData()
	return self._newSlgData and self._newSlgData:getMainAllianceData()
end

function NewSlgBaseData:getCityForceIdByAllianceId(arg_445_1)
	return self._newSlgData and self._newSlgData:getCityForceIdByAllianceId(arg_445_1)
end

function NewSlgBaseData:getForceByAllianceId(arg_446_1)
	return self._newSlgData and self._newSlgData:getForceByAllianceId(arg_446_1)
end

function NewSlgBaseData:getMyForceData()
	return self._newSlgData and self._newSlgData:getMyForceData()
end

function NewSlgBaseData:getMyForceId()
	return self._newSlgData and self._newSlgData:getMyForceId()
end

function NewSlgBaseData:convertForceDetail(arg_449_1)
	return self._newSlgData and self._newSlgData:convertForceDetail(arg_449_1)
end

function NewSlgBaseData:updateS3ProvinceRankAward(arg_450_1)
	return self._newSlgData and self._newSlgData:updateS3ProvinceRankAward(arg_450_1)
end

function NewSlgBaseData:updateS3TrialData(arg_451_1)
	return self._newSlgData and self._newSlgData:updateS3TrialData(arg_451_1)
end

function NewSlgBaseData:updateS3DrillBattleData(arg_452_1)
	return self._newSlgData and self._newSlgData:updateS3DrillBattleData(arg_452_1)
end

function NewSlgBaseData:updateS3DrillData(arg_453_1)
	return self._newSlgData and self._newSlgData:updateS3DrillData(arg_453_1)
end

function NewSlgBaseData:updateS3HallData(arg_454_1)
	return self._newSlgData and self._newSlgData:updateS3HallData(arg_454_1)
end

function NewSlgBaseData:updateMainAllianceData(arg_455_1)
	return self._newSlgData and self._newSlgData:updateMainAllianceData(arg_455_1)
end

function NewSlgBaseData:updateS3ForceData(arg_456_1)
	return self._newSlgData and self._newSlgData:updateS3ForceData(arg_456_1)
end

function NewSlgBaseData:checkIsMyOccupy(arg_457_1)
	return self._newSlgData and self._newSlgData:checkIsMyOccupy(arg_457_1)
end

function NewSlgBaseData:isFarmOpen()
	return self._newSlgData and self._newSlgData:isFarmOpen()
end

function NewSlgBaseData:getBountyTasks()
	return self._newSlgData and self._newSlgData:getBountyTasks()
end

function NewSlgBaseData:getFarmInfoById(arg_460_1)
	return self._newSlgData and self._newSlgData:getFarmInfoById(arg_460_1)
end

function NewSlgBaseData:getNextResetFoodSec(arg_461_1)
	return self._newSlgData and self._newSlgData:getNextResetFoodSec(arg_461_1)
end

function NewSlgBaseData:isFarmLandOpen(arg_462_1)
	if self._newSlgData then
		return self._newSlgData:isFarmLandOpen(arg_462_1)
	end
end

function NewSlgBaseData:isFarmPeriod()
	if self._newSlgData then
		return self._newSlgData:isFarmPeriod()
	end
end

function NewSlgBaseData:getFarmMaxLimit()
	if self._newSlgData then
		return self._newSlgData:getFarmMaxLimit()
	end
end

function NewSlgBaseData:getFarmAwardDecreasePer()
	if self._newSlgData then
		return self._newSlgData:getFarmAwardDecreasePer()
	end
end

function NewSlgBaseData:getFarmCost(arg_466_1)
	if self._newSlgData then
		return self._newSlgData:getFarmCost(arg_466_1)
	end
end

function NewSlgBaseData:hasTeamFarm(arg_467_1)
	if self._newSlgData then
		return self._newSlgData:hasTeamFarm(arg_467_1)
	end
end

function NewSlgBaseData:updateFarmUnitQuit(arg_468_1)
	if self._newSlgData then
		return self._newSlgData:updateFarmUnitQuit(arg_468_1)
	end
end

function NewSlgBaseData:getFarmArrBelongCity()
	if self._newSlgData then
		return self._newSlgData:getFarmArrBelongCity(...)
	end
end

function NewSlgBaseData:updateFarmSerData()
	if self._newSlgData then
		return self._newSlgData:updateFarmSerData(...)
	end
end

function NewSlgBaseData:updateBattleFarmReport()
	if self._newSlgData then
		return self._newSlgData:updateBattleFarmReport(...)
	end
end

function NewSlgBaseData:searchFarmNearestByLevel()
	if self._newSlgData then
		return self._newSlgData:searchFarmNearestByLevel(...)
	end
end

function NewSlgBaseData:getFarmMaxLevel()
	if self._newSlgData then
		return self._newSlgData:getFarmMaxLevel(...)
	end
end

function NewSlgBaseData:getCurDayFarmRewardCount()
	if self._newSlgData then
		return self._newSlgData:getCurDayFarmRewardCount(...)
	end
end

function NewSlgBaseData:getCurDayFarmKillScore()
	if self._newSlgData then
		return self._newSlgData:getCurDayFarmKillScore(...)
	end
end

function NewSlgBaseData:isCanAttackFarm()
	if self._newSlgData then
		return self._newSlgData:isCanAttackFarm(...)
	end
end

function NewSlgBaseData:cacheAllianceCities()
	if self._newSlgData then
		return self._newSlgData:cacheAllianceCities(...)
	end
end

function NewSlgBaseData:updateFarmAward()
	if self._newSlgData then
		return self._newSlgData:updateFarmAward(...)
	end
end

function NewSlgBaseData:getSeasonTask()
	if self._newSlgData then
		return self._newSlgData:getSeasonTask(...)
	end
end

function NewSlgBaseData:updateTaskSeasonData()
	if self._newSlgData then
		return self._newSlgData:updateTaskSeasonData(...)
	end
end

function NewSlgBaseData:updatePassCardData()
	if self._newSlgData then
		return self._newSlgData:updatePassCardData(...)
	end
end

function NewSlgBaseData:rewardTaskSeasonData()
	if self._newSlgData then
		return self._newSlgData:rewardTaskSeasonData(...)
	end
end

function NewSlgBaseData:getSeasonTaskAddition()
	if self._newSlgData then
		return self._newSlgData:getSeasonTaskAddition(...)
	end
end

function NewSlgBaseData:getAndUpdateItemNumAfterAddition()
	if self._newSlgData then
		return self._newSlgData:getAndUpdateItemNumAfterAddition(...)
	end
end

function NewSlgBaseData:isHasSeasonTaskAward()
	if self._newSlgData then
		return self._newSlgData:isHasSeasonTaskAward(...)
	end
end

function NewSlgBaseData:getCityAuthorityDecreaseNumAndScoreDecrease()
	if self._newSlgData then
		return self._newSlgData:getCityAuthorityDecreaseNumAndScoreDecrease(...)
	end
end

function NewSlgBaseData:getMaxCanDeclareCityLevel()
	if self._newSlgData then
		return self._newSlgData:getMaxCanDeclareCityLevel(...)
	end
end

function NewSlgBaseData:getCurTeamCnt()
	if self._newSlgData then
		return self._newSlgData:getCurTeamCnt()
	end
end

function NewSlgBaseData:getMaxTeamCnt()
	if self._newSlgData then
		return self._newSlgData:getMaxTeamCnt()
	end
end

function NewSlgBaseData:getTeamElementTypeAndAffectValue()
	if self._newSlgData then
		return self._newSlgData:getTeamElementTypeAndAffectValue(...)
	end
end

function NewSlgBaseData:onUpdateAllianceStrategy()
	if self._newSlgData then
		self._newSlgData:onUpdateAllianceStrategy(...)
	end
end

function NewSlgBaseData:updateAllianceSerData()
	if self._newSlgData then
		self._newSlgData:updateAllianceSerData(...)
	end
end

function NewSlgBaseData:updateCityElement()
	if self._newSlgData then
		self._newSlgData:updateCityElement(...)
	end
end

function NewSlgBaseData:getExtTeamPassCardPayType()
	if self._newSlgData then
		return self._newSlgData:getExtTeamPassCardPayType(...)
	end

	return 0
end

function NewSlgBaseData:getTeamUnlockLevelBySourceAndIndex()
	if self._newSlgData then
		return self._newSlgData:getTeamUnlockLevelBySourceAndIndex(...)
	end

	return false, 0
end

function NewSlgBaseData:getTeamUnlockLevelByIndex()
	if self._newSlgData then
		return self._newSlgData:getTeamUnlockLevelByIndex(...)
	end

	return false, 0
end

function NewSlgBaseData:getUnlockPassCardTeamNum()
	if self._newSlgData then
		return self._newSlgData:getUnlockPassCardTeamNum(...)
	end

	return 0
end

function NewSlgBaseData:isShowStrategy()
	if self._newSlgData then
		return self._newSlgData:isShowStrategy(...)
	end

	return 0
end

return NewSlgBaseData
