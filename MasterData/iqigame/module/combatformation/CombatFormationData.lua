-- chunkname: @IQIGame\\Module\\CombatFormation\\CombatFormationData.lua

CombatFormationData = {
	haveHelphero = false,
	FormationId = 0,
	isLock = true,
	Box = {}
}

function CombatFormationData.New()
	local o = Clone(CombatFormationData)

	return o
end

function CombatFormationData:Initialize(FormationPOD, isCreateNewWarlockData)
	self.FormationId = FormationPOD.cid
	self.BaseData = CfgFormationTable[self.FormationId]
	self.Box = {}

	for i, v in pairs(FormationPOD.heros) do
		if i ~= 0 then
			self.Box[i] = {}

			if isCreateNewWarlockData then
				local WarlockData = WarlockData.New()
				local data = {
					lv = 1,
					cid = v
				}

				WarlockData:CreateTemporaryData(data)

				self.Box[i].EntityID = WarlockData:GetCurSpineElementEntityID()

				local ItemCfgElementEntityTable = CfgElementEntityTable[self.Box[i].EntityID]

				WarlockData.PrefabPath = ItemCfgElementEntityTable.PrefabName
				self.Box[i].WarlockData = WarlockData
				self.Box[i].islock = true
			else
				if WarlockModule.WarlockDataDic[v] == nil then
					logError("普通上阵上阵 英雄数据中有空   " .. v)
				end

				self.Box[i].WarlockData = WarlockModule.WarlockDataDic[v]
			end
		end
	end

	self.haveHelphero = false

	if FormationPOD.helpHeros then
		for i, v in pairs(FormationPOD.helpHeros) do
			self.Box[i] = {}

			if CombatFormationData.HelpHeroData == nil then
				CombatFormationData.HelpHeroData = WarlockData.New()
			end

			CombatFormationData.HelpHeroData:CreateTemporaryData(v, true)

			self.Box[i].WarlockData = CombatFormationData.HelpHeroData
			self.haveHelphero = true
		end
	end
end

function CombatFormationData:GetCurFomationPeople()
	local index = 0
	local costNum = 0

	for i, v in pairs(self.Box) do
		index = index + 1
	end

	return index, costNum
end

function CombatFormationData:IsFormationFull()
	if self.Box == nil or self.BaseData == nil then
		logError("CombatFormationData:IsFormationFull  self.Box or self.BaseData is nil.")

		return false
	end

	local nowHeroCount = 0

	for _, _ in pairs(self.Box) do
		nowHeroCount = nowHeroCount + 1
	end

	return nowHeroCount >= self.BaseData.MaxHeroCount
end

function CombatFormationData:GetNetBoxData()
	local map = {}

	for i, v in pairs(self.Box) do
		if v.WarlockData.isHelpHeroData == nil and not v.islock then
			map[i] = v.WarlockData.cid
		end
	end

	return map
end

function CombatFormationData:GetElement()
	local _t = {}

	for i, v in pairs(self.Box) do
		if self:IsContent(_t, v.WarlockData.BaseData.Elements) == false then
			table.insert(_t, v.WarlockData.BaseData.Elements)
		end
	end

	return _t
end

function CombatFormationData:GetProfession()
	local _t = {}

	for i, v in pairs(self.Box) do
		if self:IsContent(_t, v.WarlockData.BaseData.Profession) == false then
			table.insert(_t, v.WarlockData.BaseData.Profession)
		end
	end

	return _t
end

function CombatFormationData:IsContent(t, id)
	for i = 1, #t do
		if t[i] == id then
			return true
		end
	end

	return false
end

function CombatFormationData:GetDefaultBaseCid(EquipCid)
	local curItemBaseData

	for i, v in pairsCfg(CfgItemTable) do
		if v.Id == EquipCid then
			curItemBaseData = v

			break
		end
	end

	if curItemBaseData == nil then
		-- block empty
	end

	return curItemBaseData
end

function CombatFormationData:SendStartFight()
	local List = {}

	for i, v in pairs(self.Box) do
		local AttackUnitPOD = {}

		AttackUnitPOD.type = v.WarlockData.TheType
		AttackUnitPOD.val = v.WarlockData.cid
		AttackUnitPOD.pos = i

		if v.WarlockData.TheType ~= CombatFormationModel.WarkLockType.HelpHero then
			AttackUnitPOD.pid = PlayerModule.PlayerInfo.baseInfo.pid
			AttackUnitPOD.serverId = PlayerModule.PlayerInfo.baseInfo.serverId
		else
			AttackUnitPOD.pid = v.WarlockData.pid
			AttackUnitPOD.serverId = v.WarlockData.serverId
		end

		log("英雄类型 " .. AttackUnitPOD.type .. "  玩家ID  " .. AttackUnitPOD.pid .. "  服务器ID  " .. AttackUnitPOD.serverId .. "  cid  " .. AttackUnitPOD.val .. "   位置 " .. i)
		table.insert(List, AttackUnitPOD)
	end

	return List
end

function CombatFormationData:IsCombatFormationContainsHero(heroCid, warkLockType)
	warkLockType = warkLockType ~= nil and warkLockType or 0

	if self.Box ~= nil then
		local warlockData

		for _, data in pairs(self.Box) do
			warlockData = data.WarlockData

			if warlockData and warlockData.cid == heroCid then
				if warkLockType == 0 then
					return true
				elseif warkLockType == CombatFormationModel.WarkLockType.Hero and warlockData.TheType == CombatFormationModel.WarkLockType.Hero then
					return true
				elseif warkLockType == CombatFormationModel.WarkLockType.HelpHero and warlockData.TheType == CombatFormationModel.WarkLockType.HelpHero then
					return true
				end
			end
		end
	end

	return false
end
