-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/RoguelikeTestMonsterView.lua

module("logic.extensions.hacktool.view.RoguelikeTestMonsterView", package.seeall)

local M = class("RoguelikeTestMonsterView", ViewComponent)

function M:ctor()
	M.super:ctor()

	self._heroIds = {
		2000005,
		2000011,
		2000012,
		2000013
	}
	self._txtRoleAverageInfo = ""
end

function M:buildUI()
	self._btnReturn = self:getBtn("0&title_view_-878360263")
	self._btnUpdateRole = self:getBtn("roguelike_test_monster_-479957066")
	self._btnUpdateMonster = self:getBtn("roguelike_test_monster_1049324008")
	self._btnFight = self:getBtn("roguelike_test_monster_198045752")
	self._inputRoleHp = self:getInput("roguelike_test_monster_14142669")
	self._inputRoleSan = self:getInput("roguelike_test_monster_-208512810")
	self._inputRoleSix = self:getInput("roguelike_test_monster_-924902197")
	self._inputMonsterHp = self:getInput("roguelike_test_monster_-1690172639")
	self._inputMonsterAttack = self:getInput("roguelike_test_monster_515893240")
	self._inputMonsterFight = self:getInput("roguelike_test_monster_-1271324458")
	self._inputMonsterSanAttack = self:getInput("roguelike_test_monster_-818578962")
	self._inputMeetMonsterCount = self:getInput("roguelike_test_monster_1320744643")
	self._txtRoleInfos = self:getText("roguelike_test_monster_-1218248246")
	self._txtMonsterInfos = self:getText("roguelike_test_monster_176910584")
	self._txtMain = self:getText("roguelike_test_monster_-1209627893")
	self._dropMonsterAtk = self:getGo("roguelike_test_monster_-1610128961"):GetComponent(UIComponentType.DropdownApapter)
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnUpdateRole:AddClickListener(self._onClickUpdateRole, self)
	self._btnUpdateMonster:AddClickListener(self._onClickUpdateMonster, self)
	self._btnFight:AddClickListener(self._onClickFight, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnUpdateRole:RemoveClickListener()
	self._btnUpdateMonster:RemoveClickListener()
	self._btnFight:RemoveClickListener()
end

function M:onEnter()
	RogueMgr.instance:setNeedShowDice(false)
	RogueMgr.instance:setWaitTimeScale(0.04)
	self:setEvent(true)
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_MONSTER_HP, self._onMonsterHpRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_ROLE_INFO, self._onRoleInfoUpdate, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_RESULT_FINISH, self._onResultFinish, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_MONSTER_HP, self._onMonsterHpRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_ROLE_INFO, self._onRoleInfoUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_RESULT_FINISH, self._onResultFinish, self)
	end
end

function M:_onClickReturn()
	self:back()
end

function M:_onClickUpdateRole()
	local hp = self._inputRoleHp:GetText()

	if hp == nil or hp == "" then
		hp = 1

		self._inputRoleHp:SetText(hp)
	end

	local san = self._inputRoleSan:GetText()

	if san == nil or san == "" then
		san = 1

		self._inputRoleSan:SetText(san)
	end

	local six = self._inputRoleSix:GetText()

	if six == nil or six == "" then
		six = "1,1,1,1,1,1"

		self._inputRoleSix:SetText(six)
	end

	local sixProp = {}
	local temp = string.split(six, ",")

	for i = 1, #temp do
		table.insert(sixProp, temp[i])
	end

	self:setupHeroTeam(hp, san, sixProp)
end

function M:setupHeroTeam(hp, san, sixProp)
	if RogueMgr.instance:isInRogue() then
		self:updateRoleProp(hp, san, sixProp)

		return
	end

	local tb = {}

	tb.roleIds = {}

	for k, v in pairs(self._heroIds) do
		table.insert(tb.roleIds, v)
	end

	RogueMgr.instance:enter(tb)
	self:updateRoleProp(hp, san, sixProp)
end

function M:updateRoleProp(hp, san, sixProp)
	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()

	for i = 1, #allRoles do
		local prop = allRoles[i].roleProp

		for j = 1, #sixProp do
			prop:setPropertyLevel(j, sixProp[j])
		end

		prop:setHp(tonumber(hp))
		prop:setSan(tonumber(san))
	end

	RogueMgr.instance:getModel():setFirstActiveRoleIndex()
	self:updateRolesInfo()
end

function M:updateRolesInfo()
	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()
	local text = ""

	for i = 1, #allRoles do
		local prop = allRoles[i].roleProp
		local hp = prop:getHp()
		local san = prop:getSan()
		local roleId = prop:getRoleId()

		text = text .. string.format("角色：%d,血量：%d,理智：%d", roleId, hp, san) .. "\n"
	end

	self._txtRoleInfos.text = text
end

function M:_onClickUpdateMonster()
	local hp = self._inputMonsterHp:GetText()

	if hp == nil or hp == "" then
		hp = 1

		self._inputMonsterHp:SetText(hp)
	end

	local attack = self._inputMonsterAttack:GetText()

	if attack == nil or attack == "" then
		attack = 1

		self._inputMonsterAttack:SetText(attack)
	end

	local fight = self._inputMonsterFight:GetText()

	if fight == nil or fight == "" then
		fight = 1

		self._inputMonsterFight:SetText(fight)
	end

	local sanAtk = self._inputMonsterSanAttack:GetText()

	if sanAtk == nil or sanAtk == "" then
		sanAtk = 1

		self._inputMonsterSanAttack:SetText(sanAtk)
	end

	local attackType = tonumber(self._dropMonsterAtk.dropdown.value + 1)
	local monsterId = 1002

	RogueMgr.instance:meetMonster(monsterId)

	local prop = RogueMgr.instance:getModel():getCurMonster().monsterProp

	prop:setHp(tonumber(hp))
	prop:setFighting(tonumber(fight))
	prop:setAttack(tonumber(attack))
	prop:setSanAttack(tonumber(sanAtk))
	prop:setAttackType(tonumber(attackType))
	self:updateMonsterInfo()
end

function M:updateMonsterInfo()
	local prop = RogueMgr.instance:getModel():getCurMonster().monsterProp
	local hp = prop:getHp()
	local fighting = prop:getFighting()
	local attack = prop:getAttack()

	self._txtMonsterInfos.text = string.format("怪物：%d,骰子数：%d,攻击：%d,单轮骰数：%d", prop:getId(), hp, attack, fighting)
end

function M:_onClickFight()
	local fightCount = self._inputMeetMonsterCount:GetText()

	if fightCount == nil or fightCount == "" then
		fightCount = 1

		self._inputMeetMonsterCount:SetText(1)
	end

	self._round = 0
	self._winCount = 0
	self._failCount = 0
	self._averageHp = nil
	self._averageSan = nil
	self._fightCount = tonumber(fightCount)
	self._fightCountdown = self._fightCount

	self:_onClickUpdateRole()
	self:_onClickUpdateMonster()

	self._monsterId = 1002

	RogueMgr.instance:getModel():setCurMonsterId(self._monsterId)
	RogueMgr.instance:enterFight(self._monsterId)

	self._fightCount = self._fightCount - 1

	self:updateMainText()
end

function M:_onMonsterHpRefresh()
	self:updateMonsterInfo()
end

function M:_onRoleInfoUpdate()
	self:updateRolesInfo()
end

function M:_onResultFinish()
	settimer(0.02, self.continueFight, self, false)
end

function M:continueFight()
	if self._fightCount > 0 then
		self:calcRoleAverageInfo()
		self:updateMainText()
		self:_onClickUpdateRole()
		self:_onClickUpdateMonster()
		RogueMgr.instance:enterMonsterFight()

		self._fightCount = self._fightCount - 1
	else
		self:calcRoleAverageInfo()
		self:updateMainText(true)
	end
end

function M:calcRoleAverageInfo()
	local isWin = RogueMgr.instance:getModel():getJudgeResult()

	self._winCount = isWin and self._winCount + 1 or self._winCount
	self._failCount = isWin and self._failCount or self._failCount + 1

	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()
	local text = ""

	for i = 1, #allRoles do
		local prop = allRoles[i].roleProp
		local hp = prop:getHp()
		local san = prop:getSan()

		self._averageHp = self._averageHp == nil and hp or self._averageHp
		self._averageSan = self._averageSan == nil and san or self._averageSan
		self._averageHp = ((self._round - 1) * self._averageHp + (isWin and hp or self._averageHp)) / self._round
		self._averageSan = ((self._round - 1) * self._averageSan + (isWin and san or self._averageSan)) / self._round

		local roleId = prop:getRoleId()

		text = text .. string.format("角色：%d,血量：%d,理智：%d", roleId, self._averageHp, self._averageSan) .. "\n"
	end

	self._txtRoleAverageInfo = text
end

function M:updateMainText(isIgnoreRound)
	if not isIgnoreRound then
		self._round = self._round + 1
	end

	self._txtMain.text = string.format("当前第%d场 胜利 %d : 失败 %d\n %s", self._round, self._winCount, self._failCount, self._txtRoleAverageInfo)
end

return M
