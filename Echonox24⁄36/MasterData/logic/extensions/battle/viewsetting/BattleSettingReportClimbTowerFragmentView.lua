-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsetting/BattleSettingReportClimbTowerFragmentView.lua

module("logic.extensions.battle.viewsetting.BattleSettingReportClimbTowerFragmentView", package.seeall)

local M = class("BattleSettingReportClimbTowerFragmentView", StaticFragmentView)

function M:buildUI()
	self._winCondition = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "element2/descScroll"), BattleSettingWinConditionView)
	self._loseCondition = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "element3/descScroll"), BattleSettingWinConditionView)
	self._goNoBuffMark = goutil.findChild(self.mainGO, "rightContent/empty")
	self._trBlueBuffRoot = goutil.findChildComponent(self.mainGO, "rightContent/buffScroll/viewPort/content2/blueBuff", UIComponentType.RectTransform)
	self._trRedBuffRoot = goutil.findChildComponent(self.mainGO, "rightContent/buffScroll/viewPort/content2/redBuff", UIComponentType.RectTransform)

	goutil.setActive(self._trBlueBuffRoot.gameObject, true)
	goutil.setActive(self._trRedBuffRoot.gameObject, true)
end

function M:destroyUI()
	self._winCondition = nil
	self._loseCondition = nil
	self._trBlueBuffRoot = nil
	self._trRedBuffRoot = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self:_updateBaseView()

	local isLevelBattle = OOPUtil.isInstanceOf(BattleMgr.instance:getActiveBattleFlow(), LevelBattleFlowBase)

	if isLevelBattle then
		self:_updateAsLevelBattle()
	else
		self:_updateAsEmpty()
	end
end

function M:onExit()
	return
end

function M:_updateBaseView()
	self:_refreshBuff()
end

function M:_updateAsLevelBattle()
	local winCondition = BattleMgr.instance:getWinCondition()

	self._winCondition:setConditionStr(winCondition:getWinConditionDescription())
	self._loseCondition:setConditionStr(winCondition:getLoseConditionDescription())
end

function M:_updateAsEmpty()
	if enableWarnLog then
		printWarn("BattleSettingReportFragmentView::unhandle battle flow type")
	end

	self._winCondition:setConditionStr("NONE")
	self._loseCondition:setConditionStr("NONE")
end

function M:_refreshBuff()
	local dungeonId = BattleEnterUtil.getCurrentDungeonCode()
	local dungeonMo = DungeonModel.instance:getDungeonMoById(dungeonId)
	local dungeonTyp = dungeonMo:getType()
	local blueBuff = {}
	local redBuff = {}

	if dungeonTyp == DungeonExtension_pb.DungeonType.DARK_TOWER and dungeonMo then
		local towerCfgId = dungeonMo:getTowerCfgId()
		local darkCO = ClimbingTowerConfig.instance:getDarkTowerCO(towerCfgId)

		if darkCO then
			blueBuff = darkCO:getEffectDetailLstPros()
			redBuff = darkCO:getEffectDetailLstCons()
		end
	end

	goutil.setActive(self._goNoBuffMark, #blueBuff <= 0 and #redBuff <= 0)

	while self._trBlueBuffRoot.childCount < #blueBuff do
		local templateGo = self._trBlueBuffRoot:GetChild(0).gameObject

		if templateGo then
			goutil.cloneAndSetParent(templateGo, self._trBlueBuffRoot)
		else
			printError("无法找到蓝色buff模板go")

			break
		end
	end

	for i = 0, self._trBlueBuffRoot.childCount - 1 do
		local tmpGo = self._trBlueBuffRoot:GetChild(i).gameObject
		local show = i < #blueBuff

		goutil.setActive(tmpGo, show)

		if show then
			local data = blueBuff[i + 1]
			local txtBuff = goutil.findChildComponent(tmpGo, "txtBlueBuff", UIComponentType.TextMeshProUGUI)

			txtBuff.text = data.desc
		end
	end

	while self._trRedBuffRoot.childCount < #redBuff do
		local templateGo = self._trRedBuffRoot:GetChild(0).gameObject

		if templateGo then
			goutil.cloneAndSetParent(templateGo, self._trRedBuffRoot)
		else
			printError("无法找到红色buff模板go")

			break
		end
	end

	for i = 0, self._trRedBuffRoot.childCount - 1 do
		local tmpGo = self._trRedBuffRoot:GetChild(i).gameObject
		local show = i < #redBuff

		goutil.setActive(tmpGo, show)

		if show then
			local data = redBuff[i + 1]
			local txtBuff = goutil.findChildComponent(tmpGo, "txtRedBuff", UIComponentType.TextMeshProUGUI)

			txtBuff.text = data.desc
		end
	end
end

return M
