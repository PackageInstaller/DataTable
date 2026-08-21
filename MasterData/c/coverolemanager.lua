require "class"

---@class CoveRoleManager
local CoveRoleManager = class("CoveRoleManager")
local CoveRole = require "CoveRole"
local CoveMonster = require "CoveMonster"
local workScheduleCfg = Config.GetConfigInfo("homework3")
local workTimeCfg = Config.GetConfigInfo("workTime")

local CoveActionCommon = require "CoveActionCommon"
local CoveWalkManager = require "CoveWalkManager"
local CoveWorkManager = require "CoveWorkManager"
---游泳接管
local CoveSwinManager = require "CoveSwinManager"


local idTmep = 0
local GetUID = function()
	idTmep = idTmep + 1
	return idTmep
end

function CoveRoleManager:ctor(...)
	LuaLogger.ds("CoveRoleManager ctor")
	---@type CoveManager
	self._coveMgr = nil

	self._roleList = {} --场景中角色列表 type CoveRole
	self._randomRoleNum = 0 --随机角色数量

	self.tempDispatchRoleList = {} --派遣角色列表

	self.m_coveActionCommon = CoveActionCommon.instance()
	self.m_coveActionCommon:init(self)
	self.m_coveWalkManager = CoveWalkManager.instance()
	self.m_coveWalkManager:init(self,self.m_coveActionCommon)

	self.m_coveWorkManager = CoveWorkManager.instance()
	self.m_coveWorkManager:init(self,self.m_coveActionCommon)


	self.m_coveSwinManager = CoveSwinManager.instance()
	self.m_coveSwinManager:init(self,self.m_coveActionCommon)

	self.m_createRolesRun = false

	self.coveMap = {}
	-- 保存上一次的角色列表数据，用于对比是否发生变化
	self._lastRoleListData = nil
	GameMsgMgr:regEvent(GameMsgType.RoleDisposeChange, self, self.onRoleDisposeChange)
	GameMsgMgr:regEvent(GameMsgType.RoleWalkChange, self, self.onRoleWalkChange)
end

---实例化
---@return CoveRoleManager CoveRoleManager
function CoveRoleManager.instance()
	if (CoveRoleManager._instance == nil) then
		CoveRoleManager._instance = CoveRoleManager:new()
	end
	return CoveRoleManager._instance
end

function CoveRoleManager:init(coveMgr)
	---@type CoveManager
	self._coveMgr = coveMgr
	self.isInit = false

end

function CoveRoleManager:onInit()
	if self.isInit then
		return
	end
	self.totalWorkRoleNum = 0
	self.totalWalkRoleNum = 0
	self.isInit = true

	self:SetCoveRoles(true)
	GameMsgMgr:regEvent(GameMsgType.RefreshEventMsg, self, self.refreshAllEventMsg)


	CoveBattleMgr.instance():InitBattle()
end



---@class CoveRoleData
---@field mgr CoveRoleManager
---@field roomMgr CoveRoomManager
---@field roleData HeroInfo
---@field room CoveRoom
---@field coveRoleType CoveRoleType
---@field isPreRole boolean
---@field homeWorkIndex integer 工作部署位置
---@field preCreateTime number
---@field lifeTime number

---@class CreateCoveRoleData
---@field roleData HeroInfo 角色数据
---@field room CoveRoom 房间数据
---@field coveRoleType CoveRoleType 是否为工作角色
---@field isPreRole boolean 是否为上次登陆的角色
---@field homeWorkIndex integer 工作部署位置


---创建家园角色
---@param createCoveRoleData CreateCoveRoleData 角色数据
---@return CoveRoleData
function CoveRoleManager:createCoveRole(coveRole,createCoveRoleData)
	--预生产时间和生命周期时间随机

	local timeStamp = os.time()

	local preCreateTime = 0
	local lifeTime = -1
	if createCoveRoleData.coveRoleType == CoveRoleType.Random then
		if not createCoveRoleData.isPreRole then
			local homeCharacterPreTime = Config.GetConfigInfo("homeCharacterPreTime")
			preCreateTime = math.random(homeCharacterPreTime[1], homeCharacterPreTime[2])
			--preCreateTime = math.random(40, 40)
		end
		local homeCharacterStayTime = Config.GetConfigInfo("homeCharacterStayTime")
		lifeTime = math.random(homeCharacterStayTime[1], homeCharacterStayTime[2])
		-- lifeTime = math.random(60, 80)
	end

	--preCreateTime = 0
	local data = {
		mgr = self,
		roomMgr = self._coveMgr:getRoomMgr(),
		roleData = createCoveRoleData.roleData,
		room = createCoveRoleData.room,
		coveRoleType = createCoveRoleData.coveRoleType,
		isPreRole = createCoveRoleData.isPreRole,
		homeWorkIndex = createCoveRoleData.homeWorkIndex,
		isEnterSwinRoom = createCoveRoleData.isEnterSwinRoom,
		isRandomRole = createCoveRoleData.isRandomRole,
		preCreateTime = timeStamp + preCreateTime,
		lifeTime = timeStamp + lifeTime + preCreateTime,
		isNeedToRemoveFirst = createCoveRoleData.isNeedToRemoveFirst,
		isCreateInRoom = createCoveRoleData.isCreateInRoom,
		constructId = createCoveRoleData.constructId,
		workConstructId = createCoveRoleData.workConstructId,
		isBattleRole = createCoveRoleData.isBattleRole,
		coveRole = coveRole,
		--加一个状态切换使用的黑板
		blackboard = {},
	}
	return data
end


function CoveRoleManager:SetCoveRoles(isInit, callback)

	--刷新当前角色状态
	self:NewUpdateNewRoles(true)

	self:startStateUpdate()

end


----------------------添加新角色   Begin

-----------------------------刷新当前的角色Begin
---刷新当前所有角色，包括建造工作的 ，以及散步的

---判断角色是否在场景中
---@param id integer 角色表id
---@return boolean
function CoveRoleManager:isHasRoleInCove(id)
	--角色只要在场景中就算(包括处于离开港口行为的角色)
	for _, roleStateData in ipairs(self._roleList) do
		if (id == roleStateData.roleData.id) then
			return true
		end
	end
	return false
end


----所有工作的角色创建,这边如果当前存在此角色 ，则暂时不创建
function CoveRoleManager:NewUpdateConstructionRoles(isInit)
	local constructionMap = Me:getConstructionMapData()

	--LuaLogger.ds(" NewUpdateConstructionRoles == constructionMap=== " , tablex.dump(constructionMap))

	for constructId, homeBulidInfo in pairs(constructionMap) do
		--获取当前部署的角色列表
		if homeBulidInfo.disposeHeroList then
			--如果当前是指挥室
			if constructId == GE.CoustructionEnum.CommandRoom or constructId == GE.CoustructionEnum.PatrolRoom then
				for index, roleId in pairs(homeBulidInfo.disposeHeroList) do

					if roleId ~= 0 then
						if self:isHasRoleInCove(roleId) then
							--如果当前场上存在此角色 
							local roleStateData = self:getRoleDataWithId2(roleId)
							if roleStateData.coveRole ~= nil and (roleStateData.isNeedToRemove == false  or roleStateData.isNeedToRemove == nil) then
								
								if roleStateData.coveRoleType ~= CoveRoleType.HomeWork and  roleStateData.workConstructId ~= constructId then
									LuaLogger.ds("当前角色在场景中 ，不是工作中 ，直接切换到工作状态")
									local room = self._coveMgr:getRoomMgr():getRoom(constructId)
									roleStateData.workConstructId = constructId
									roleStateData.constructId = constructId
									roleStateData.homeWorkIndex = index
									roleStateData.coveRoleType = CoveRoleType.HomeWork
									roleStateData.room = room
									roleStateData.isCreateInRoom = isInit
									roleStateData.isRandomRole = false

								end
								
							end

						else
							--如果当前场上不存在此角色 ，因为是工作角色 所以直接创建
							local roleServerData = Me:getPlayerHero(roleId)
							local room = self._coveMgr:getRoomMgr():getRoom(constructId)

							if roleServerData and room then
								---@type CreateCoveRoleData
								local data = {
									roleData = roleServerData,
									coveRoleType = CoveRoleType.HomeWork,
									room = room,
									isPreRole = false,
									homeWorkIndex = index,
									isCreateInRoom = isInit,
									constructId = constructId,
									workConstructId = constructId,
								}
								self:addRoleStateData(self:createCoveRole(nil,data))
							end
						end
					end
				end
			else
				local pos = self:getHomeCurWorkPos()

				for index, roleId in pairs(homeBulidInfo.disposeHeroList) do
					if index == pos then
						if roleId ~= 0 then
							
							local roleServerData = Me:getPlayerHero(roleId)
							local room = self._coveMgr:getRoomMgr():getRoom(constructId)

							if self:isHasRoleInCove(roleId) then
								local roleStateData = self:getRoleDataWithId2(roleId)
								if roleStateData.coveRole ~= nil and (roleStateData.isNeedToRemove == false  or roleStateData.isNeedToRemove == nil) then
									if roleStateData.coveRoleType ~= CoveRoleType.HomeWork and  roleStateData.workConstructId ~= constructId then
										local room = self._coveMgr:getRoomMgr():getRoom(constructId)
										roleStateData.constructId = constructId
										roleStateData.workConstructId = constructId
										roleStateData.homeWorkIndex = pos
										roleStateData.coveRoleType = CoveRoleType.HomeWork
										roleStateData.room = room
										roleStateData.isRandomRole = false
										roleStateData.isCreateInRoom = isInit
									end
								end
							else
								if roleServerData and room then
									---@type CreateCoveRoleData
									local data = {
										roleData = roleServerData,
										room = room,
										coveRoleType = CoveRoleType.HomeWork,
										isPreRole = false,
										homeWorkIndex = pos,
										isCreateInRoom = isInit,
										constructId = constructId,
										workConstructId = constructId,
									}
									self:addRoleStateData(self:createCoveRole(nil,data))
								end
							end
							
						end

					else
						if roleId ~= 0 then
							if self:isHasRoleInCove(roleId) then
								local roleStateData = self:getRoleDataWithId2(roleId)								
								if roleStateData.coveRole == nil then
									self:removeRoleStateData(roleStateData)
								else
									roleStateData.isNeedToRemove = true
								end
							end
						end
					end
				end
			end
		end
	end
end

---当前指定走路的角色
function CoveRoleManager:NewUpdateWalkRoles(isInit)
	--添加走路角色Begin
	local nowWalkRoleList = Me:getWalkHeroList()
	--LuaLogger.ds(" NewUpdateWalkRoles == nowWalkRoleList=== " , tablex.dump(nowWalkRoleList))

	self.totalWalkRoleNum = #nowWalkRoleList
	for _, roleId in pairs(nowWalkRoleList) do
		if roleId ~= 0 then
			local roleServerData = Me:getPlayerHero(roleId)
			local room = self._coveMgr:getRoomMgr():getRandomRoom(roleId, 0)
			if (not self:isHasRoleInCove(roleId)) and roleServerData and room then
				---@type CreateCoveRoleData
				local data = {
					roleData = roleServerData,
					room = room,
					coveRoleType = CoveRoleType.DesignRandom,
					isPreRole = false,
					homeWorkIndex = -1,
					isCreateInRoom = isInit,
				}

				self:addRoleStateData(self:createCoveRole(nil,data))
			elseif self:isHasRoleInCove(roleId) then
				local roleStateData = self:getRoleDataWithId2(roleId)
				if roleStateData then
					if roleStateData.coveRoleType == CoveRoleType.Random then

						--LuaLogger.es("当前随机角色换状态到指定散步角色",roleId)
						roleStateData.isRandomRole = false
						roleStateData.coveRoleType = CoveRoleType.DesignRandom
					end
				end
			end
		end
	end
	--添加走路角色End
end

function CoveRoleManager:NewUpdateRandomWalkRoles(isInit)
	---设置上次下线前已有的角色，直接显示Begin
	self._randomRoleNum = 0
	local nowWalkRoleList = Me:getWalkHeroList()

	--LuaLogger.es(" NewUpdateRandomWalkRoles === nowWalkRoleList=== " , #nowWalkRoleList)
	for _, roleId in pairs(nowWalkRoleList) do
		if roleId == 0 then
			self._randomRoleNum = self._randomRoleNum + 1
		end
	end


	local rolePreRoom = Me:getRolePreRoom()
	--LuaLogger.ds("NewUpdateRandomWalkRoles === rolePreRoom=== " ,self._randomRoleNum, tablex.dump(rolePreRoom))
	--统计当前能添加的角色数量
	local addPreRoleNum = 0
	for roleId, constructId in pairs(rolePreRoom) do
		if (not self:isHasRoleInCove(roleId)) and addPreRoleNum < self._randomRoleNum then
			local roleServerData = Me:getPlayerHero(roleId)
			local room = self._coveMgr:getRoomMgr():getRoom(constructId)
			--LuaLogger.ds("NewUpdateRandomWalkRoles === room=== " , room.id)
			if roleServerData and room then
				---@type CreateCoveRoleData
				local data = {
					roleData = roleServerData,
					room = room,
					isRandomRole = true,
					coveRoleType = CoveRoleType.Random,
					isPreRole = true,
					homeWorkIndex = -1,
					isCreateInRoom = isInit,
				}
				addPreRoleNum = addPreRoleNum + 1
				self:addRoleStateData(self:createCoveRole(nil,data))
			end
		end
	end

	self:UpdateRolesWithHeroAction()
end

function CoveRoleManager:UpdateRolesWithHeroAction()
	---判断当前人数够不够 ，如果不够  ，则添加人

	self._randomRoleNum = 0
	local nowWalkRoleList = Me:getWalkHeroList()
	-- LuaLogger.ds("addRoleNum 1 ======",tablex.dump(nowWalkRoleList))
	for _, roleId in pairs(nowWalkRoleList) do
		if roleId == 0 then
			self._randomRoleNum = self._randomRoleNum + 1
		end
	end
	local addRoleNum = self._randomRoleNum
	-- LuaLogger.ds("addRoleNum 1 ======",addRoleNum)
	--统计需要补齐的人数
	for _, roleStateData in ipairs(self._roleList) do
		if roleStateData.coveRoleType == CoveRoleType.Random then
			addRoleNum = addRoleNum - 1
		end
	end
	-- LuaLogger.ds("addRoleNum 2 ======",addRoleNum)
	if addRoleNum <= 0 then
		return
	end
	local usableRoleList = self:getUsableRole(addRoleNum)
	-- LuaLogger.ds("addRoleNum 3 ======",#usableRoleList)
	if #usableRoleList == 0 then
		return
	end

	-- LuaLogger.ds("UpdateRolesWithHeroAction    addRoleNum ======",addRoleNum,#usableRoleList)
	if addRoleNum > 0 then
		addRoleNum = math.min(addRoleNum,#usableRoleList)
		local addRoleIds = {}
		for k, v in pairs(usableRoleList) do
			if #addRoleIds < addRoleNum then
				table.insert(addRoleIds,{heroId = v.id,actionId = 0})
			end
		end
		self:fillNewRandomRole(addRoleIds)
	end
end

function CoveRoleManager:fillNewRandomRole(addRoleIds)
	for _, addRoleData in pairs(addRoleIds) do
		local heroId = addRoleData.heroId
		if self:isHasRoleInCove(heroId) then
			LuaLogger.ds("防止重复添加随机角色，跳过已存在的 heroId: " .. heroId)
			goto continue
		end

		local roleServerData = Me:getPlayerHero(addRoleData.heroId)
		local room = self._coveMgr:getRoomMgr():getRandomRoom(roleServerData.id, 0)

		if roleServerData and room then
			---@type CreateCoveRoleData
			local data = {
				roleData = roleServerData,
				room = room,
				isPreRole = false,
				homeWorkIndex = -1,
				isRandomRole = true,
				coveRoleType = CoveRoleType.Random,
			}
			self:addRoleStateData(self:createCoveRole(nil,data))
		end
		::continue::
	end

	if tablex.size(addRoleIds) > 0 then
		self:onRoleListChange()
	end
end


---获取可用角色
---@param num integer 需要的角色数量
function CoveRoleManager:getUsableRole(num)
	local list = {}
	local tempList = {}
	local heroList = ClientData:GetRoleList()
	-- 排除已经在场景里的角色
	-- 排除派遣中的角色
	for k, v in pairs(heroList) do
		local roleConfig = Config.GetCharacterInfo(v.id)
		---加入一个条件 只有大于R级的英雄才显示
		if self:roleCanCreate(v.id) and (not Me:roleInWorking(v.id)) and (not self:isHasRoleInCove(v.id)) and roleConfig.rank > GE.HeroRankStar.R then
			table.insert(tempList, v)
		end
	end
	--随机抽取
	num = math.min(num, #tempList)

	for i = 1, num do
		local index = math.random(1, #tempList)
		table.insert(list, tempList[index])
		table.remove(tempList, index)
	end
	return list
end

function CoveRoleManager:NewUpdateNewRoles(isInit)
	--当前工作的角色
	self:NewUpdateConstructionRoles(isInit)
	
	--当前设定的走路角色 
	self:NewUpdateWalkRoles(isInit)
	--填充当前随机的角色 
	self:NewUpdateRandomWalkRoles(isInit)

	self:UpdataAllHeroAction(function()
		self:CreateNewRoles()
	end)


	
end

-----------------------------刷新当前的角色End


function CoveRoleManager:UpdataAllHeroAction(callBack)
	local tab = {}

	for _, roleStateData in pairs(self._roleList) do
		if roleStateData.serverActionInfo ~= nil then
			goto continue
		end
		local heroId = roleStateData.roleData.id
		if CoveBattleMgr.instance():IsBattleCharacterById(heroId) then
			goto continue
		end
		table.insert(tab, {heroId = heroId})
		::continue::
	end

	if #tab <= 0 then
		---当前不存在角色  ，直接回调
		if callBack then
			callBack()
		end
		return
	end

	local data = {heroActions = tab}

	--网络请求兼容处理：防止本次请求超时或网络异常导致流程卡死
	--isReqFinished 保证"超时兜底"和"网络正常返回"这两条路径只会有一条生效
	local reqState = {isReqFinished = false}

	--记录本次请求涉及角色的原始行为快照，请求超时/失败时整体回滚为原来的行为
	local snapshotList = {}
	for _, item in ipairs(tab) do
		local roleStateData = self:getRoleDataWithId2(item.heroId)
		if roleStateData then
			table.insert(snapshotList, {
				roleStateData = roleStateData,
				serverActionInfo = roleStateData.serverActionInfo,
				activateCfg = roleStateData.activateCfg,
				room = roleStateData.room,
				isEnterSwinRoom = roleStateData.isEnterSwinRoom,
				homeWorkIndex = roleStateData.homeWorkIndex,
			})
		end
	end

	--将本次请求涉及的所有角色行为整体回滚为原来(请求发出前)的状态
	local function rollbackToOriginAction()
		for _, snapshot in ipairs(snapshotList) do
			local roleStateData = snapshot.roleStateData
			roleStateData.serverActionInfo = snapshot.serverActionInfo
			roleStateData.activateCfg = snapshot.activateCfg
			roleStateData.room = snapshot.room
			roleStateData.isEnterSwinRoom = snapshot.isEnterSwinRoom
			roleStateData.homeWorkIndex = snapshot.homeWorkIndex
		end
	end

	--3秒超时兜底：网络还没返回时，将本次涉及角色的行为整体回滚为原来的行为，
	--标记本次请求已完成并继续下一步；如果之后网络才返回，不再重新指向角色行为
	DLuaTimer:DoAfter(3, function()
		if reqState.isReqFinished then
			return
		end
		reqState.isReqFinished = true

		LuaLogger.es("UpdataAllHeroAction ReportHeroHomeActionCompletedReq 请求超时，回滚角色行为为原来状态，继续下一步")
		rollbackToOriginAction()

		if callBack then
			callBack()
		end
	end)

	-- LuaLogger.es("ReportHeroHomeActionCompletedReq 1111111=====UpdataAllHeroAction ===2222====")
	self:ReportHeroHomeActionCompletedReq(data,function(data)
		--已经被超时兜底处理过，本次延迟返回的结果不再生效，避免重复指向角色行为
		if reqState.isReqFinished then
			LuaLogger.es("UpdataAllHeroAction ReportHeroHomeActionCompletedReq 已超时兜底完成，忽略延迟返回的结果")
			return
		end
		reqState.isReqFinished = true

		if data.ret == 0 then

			for i,v in ipairs(data.infos) do
				if v.actionId == 0 then
					local roleStateData = self:getRoleDataWithId(v.heroId,false)
					--LuaLogger.ds("当前角色添加后服务器判断已经下场  ，直接删除  ，因为此时还没有创建")
					self:removeRoleStateData(roleStateData)
				else
					local roleStateData = self:getRoleDataWithId2(v.heroId)
					if roleStateData == nil then
						LuaLogger.es("roleStateData 数据错误 heroId:" .. v.heroId)
						goto continue
					end

					if roleStateData.room == nil then
						LuaLogger.es("roleStateData 房间数据错误 heroId:" .. v.heroId)
						goto continue	
					end


					roleStateData.serverActionInfo = v
					local activateCfg = Config.GetHomeActivateCfg(v.actionId)

					roleStateData.activateCfg = activateCfg

					local lastRoomId = roleStateData.room.id

					local newRoomId = activateCfg.param
					roleStateData.isEnterSwinRoom = false
					if newRoomId == 10015 then
						roleStateData.isEnterSwinRoom = true
					end
					--LuaLogger.ds(" ReportHeroHomeActionCompletedReq v.actionId   newRoomId    lastRoomId =====",v.actionId,newRoomId,lastRoomId)
					--这边多加一个判断 ，是否房间已经改变
					if newRoomId ~= lastRoomId then
						local newRoom = self._coveMgr:getRoomMgr():getRoomWithRoomId(v.heroId, newRoomId)
						if newRoom then
							roleStateData.room = newRoom

							--LuaLogger.es("根据服务器状态改变了房间    lastRoomId =====",roleStateData.room.id)
							roleStateData.homeWorkIndex = self:GetWomeWorkPos(newRoomId)
						end
					end
					
				end
				::continue::

				
			end
		else
			--协议返回失败，整体回滚本次涉及角色的行为为原来的状态
			LuaLogger.es("UpdataAllHeroAction ReportHeroHomeActionCompletedReq 协议返回失败，回滚角色行为为原来状态，ret:", data.ret)
			rollbackToOriginAction()
		end
		if callBack then
			callBack()
		end
	end)

end
----------------------添加新角色   end


-----创建角色逻辑Begin
function CoveRoleManager:getRoleDataWithId(roleId,isNeedCreate)
	for _, roleStateData in pairs(self._roleList) do
		if roleStateData.roleData.id == roleId then
			if isNeedCreate == true then
				if roleStateData.coveRole ~= nil then
					return roleStateData
				end
			else
				if roleStateData.coveRole == nil then
					return roleStateData
				end
			end
		end
	end
	return nil
end


function CoveRoleManager:getRoleDataWithId2(roleId)
	for _, roleStateData in pairs(self._roleList) do
		if roleStateData.roleData.id == roleId then
			return roleStateData
		end
	end
	return nil
end





function CoveRoleManager:GetCanCreateRoles()

	local workRoleCanCreate = {}
	local walkAssignRoleCanCreate = {}
	local walkRandomRoleCanCreate = {}
	local timeStamp = os.time()
	local walkRoleTotalNum = 0
	for _, roleStateData in pairs(self._roleList) do
		if roleStateData.coveRole == nil then

			if roleStateData.serverActionInfo ~= nil then

				--当前工作的没有创建的
				if roleStateData.coveRoleType == CoveRoleType.HomeWork then
					--当前场上有没有此角色已经创建好的
					if not self:getRoleDataWithId(roleStateData.roleData.id,true) then
						table.insert(workRoleCanCreate,roleStateData)
					end
				elseif roleStateData.coveRoleType == CoveRoleType.DesignRandom then
					if not self:getRoleDataWithId(roleStateData.roleData.id,true) then
						table.insert(walkAssignRoleCanCreate,roleStateData)
					end
				elseif roleStateData.coveRoleType == CoveRoleType.Random then
					if not self:getRoleDataWithId(roleStateData.roleData.id,true) then
						if roleStateData.preCreateTime ~= nil and roleStateData.preCreateTime <= timeStamp then
							table.insert(walkRandomRoleCanCreate,roleStateData)
						end
					end
				end
			end
		else
			if roleStateData.coveRoleType == CoveRoleType.Random or roleStateData.coveRoleType == CoveRoleType.DesignRandom then
				walkRoleTotalNum = walkRoleTotalNum + 1
			end

		end
	end
	

	if #workRoleCanCreate > 0 then
		return workRoleCanCreate[1]
	end
	--这边多加一个判断 ，保证场景中散步中最多只有nowWalkRoleList这么多人

	local nowWalkRoleList = Me:getWalkHeroList()

	--LuaLogger.ds("GetCanCreateRoles ==== walkRoleTotalNum  ======",walkRoleTotalNum,#nowWalkRoleList)
	if #walkAssignRoleCanCreate > 0 then
		return walkAssignRoleCanCreate[1]
	end
	
	if #walkRandomRoleCanCreate > 0 then
		return walkRandomRoleCanCreate[1]
	end
	return nil
end

--新做一个创建角色
function CoveRoleManager:CreateNewRoles()
	if self.m_createRolesRun then
		return
	end
	self.m_createRolesRun = true
	
	local roleStateData = self:GetCanCreateRoles()
	if roleStateData ~= nil then
		self:createSingleRole(roleStateData)
		self.m_createRolesRun = true
		local delayTime = 10
		local roleStateData2 = self:GetCanCreateRoles()
		if roleStateData2 ~= nil then
			if roleStateData2.isCreateInRoom == true then
				delayTime = 1
			end
		end
		DLuaTimer:DoAfter(delayTime, function()
			self.m_createRolesRun = false
			self:CreateNewRoles()
		end)
	else
		self.m_createRolesRun = false
	end
end


function CoveRoleManager:createSingleRole(data)

	data.uid = GetUID()
	---@type CoveRole
	local role = CoveRole:new(data)
	if CoveBattleMgr.instance():IsBattle() then
		CoveBattleMgr.instance():CheckRoleUID(role)
	end


	role:createRole(function()
		self:SetRoleState(role)
	end)
	local roleStateData = self:getRoleDataWithId(role.id,false)
	if roleStateData == nil then
		self:addRoleStateData(data)
		roleStateData = data
	end
	if roleStateData.coveRole ~= nil then
		local ss = "创建角色已经存在 id:" .. role:GetID() .. " uid:" .. role:GetUID() .. "/n"
		for k, v in pairs(self._roleList) do
			if v.coveRole ~= nil then
				local path = ""
				if v.coveRole.modelLoadFinish then
					path = DLuaUtil.GetHierarchyPath(v.coveRole._roleObj.transform)
				end
				ss = ss .. "id:" .. tostring(v.roleData.id)  .. " uid:" .. role:GetUID() .. " isCareate" .. tostring(v.coveRole ~= nil) .. "modelPath:" .. path .. "\n"
			else
				ss = ss .. "id:" .. tostring(v.roleData.id) .. " uid:" .. role:GetUID() .. "\n"
			end
		end
		LuaLogger.es(ss)
	end
		
	roleStateData.coveRole = role
	self.coveMap[data.uid] = role
	return role
end


---生成完成某角色，给角色设置相应的状态
---@param role CoveRole
function CoveRoleManager:SetRoleState(role)

	if CoveBattleMgr.instance():IsBattle() then
		CoveBattleMgr.instance():CheckRoleUID(role)
	end
	if CoveBattleMgr.instance():IsBattleCharacterById(role:GetID()) then
		return
	end

	if role.coveRoleType == CoveRoleType.HomeWork then
		if role.isEnterSwinRoom == true then
			self.m_coveSwinManager:PushToSwin(role)
		else
			self.m_coveWorkManager:PushToWork(role)
		end
	else
		if role.isEnterSwinRoom == true then
			self.m_coveSwinManager:PushToSwin(role)
		else
			self.m_coveWalkManager:PushToWalk(role)
		end
	end


end


function CoveRoleManager:SetRoleStateChangeRoom(role)
	if role.coveRoleType == CoveRoleType.HomeWork then
		if role.isEnterSwinRoom == true then
			self.m_coveSwinManager:PushToSwinChangeRoom(role)
		else
			self.m_coveWorkManager:PushToWorkChangeRoom(role)
		end
	else
		if role.isEnterSwinRoom == true then
			self.m_coveSwinManager:PushToSwinChangeRoom(role)
		else
			self.m_coveWalkManager:PushToWalkChangeRoom(role)
		end
	end
end

--当前某个角色状态完成 ，重新生成角色状态
function CoveRoleManager:ReturnRoleFromStateComplete(role)

	if role.data.isDispose then
		self:removeRole(role)

		DLuaTimer:DoAfter(2, function()
			self:UpdateRolesWithHeroAction()
			self:CreateNewRoles()
		end)
		return
	end

	if role.forceToActionCallBack ~= nil then
		role.forceToActionCallBack()
		role.forceToActionCallBack = nil
		return
	end



	--如果角色已经删除 ，不进行下面的刷新
	if not self:isRoleInCove(role.id) then
		--LuaLogger.ds("isRoleInCove  =======" ,role.id)
		return
	end
	local roleStateData = self:getRoleDataWithId(role.id,true)
	--如果角色已经标记为移除了 ，走移除逻辑
	if roleStateData.isNeedToRemove then
		--LuaLogger.ds("执行移除命令" ,role.id)
		self.m_coveWalkManager:PushToWalkLeaveCove(roleStateData.coveRole)
	else
		local tab = {}
		--table.insert(tab, {heroId = role.id,actionId = 401})
		table.insert(tab, {heroId = role.id})

		--网络请求兼容处理：防止本次请求超时或网络异常导致角色卡死
		--isReqFinished 保证"超时兜底"和"网络正常返回"这两条路径只会有一条生效
		local reqState = {isReqFinished = false}

		--记录当前角色行为的原始快照，请求超时/失败时回滚为原来的行为
		local snapshot = {
			serverActionInfo = roleStateData.serverActionInfo,
			activateCfg = roleStateData.activateCfg,
			isEnterSwinRoom = roleStateData.isEnterSwinRoom,
			roleIsEnterSwinRoom = role.isEnterSwinRoom,
			homeWorkIndex = role.data.homeWorkIndex,
			changeRoomData = role.data.blackboard and role.data.blackboard.changeRoomData,
		}

		--将角色行为回滚为原来的状态，并让角色按原有行为继续执行，避免卡死
		local function rollbackToOriginAction()
			roleStateData.serverActionInfo = snapshot.serverActionInfo
			roleStateData.activateCfg = snapshot.activateCfg
			roleStateData.isEnterSwinRoom = snapshot.isEnterSwinRoom
			role.isEnterSwinRoom = snapshot.roleIsEnterSwinRoom
			role.data.homeWorkIndex = snapshot.homeWorkIndex
			if role.data.blackboard then
				role.data.blackboard.changeRoomData = snapshot.changeRoomData
			end
			self:SetRoleState(role)
		end

		--3秒超时兜底：网络还没返回时，将角色行为回滚为原来的状态，继续执行原行为
		DLuaTimer:DoAfter(3, function()
			if reqState.isReqFinished then
				return
			end
			reqState.isReqFinished = true

			LuaLogger.ds("ReturnRoleFromStateComplete ReportHeroHomeActionCompletedReq 请求超时，回滚角色行为为原来状态，roleId:", role.id)
			rollbackToOriginAction()
		end)

		--LuaLogger.es("ReportHeroHomeActionCompletedReq 222222=====UpdataAllHeroAction ===2222====")
		self:ReportHeroHomeActionCompletedReq({heroActions = tab},function(data)
			--已经被超时兜底处理过，本次延迟返回的结果不再生效，避免重复指向角色行为
			if reqState.isReqFinished then
				LuaLogger.ds("ReturnRoleFromStateComplete ReportHeroHomeActionCompletedReq 已超时兜底完成，忽略延迟返回的结果，roleId:", role.id)
				return
			end
			reqState.isReqFinished = true

			if data.ret == 0 then
				for i,v in ipairs(data.infos) do
					-- LuaLogger.es("ReturnRoleFromStateComplete ==== ReportHeroHomeActionCompletedReq", v.heroId, v.actionId)
					local actionId = v.actionId
					if actionId == 0 then
						LuaLogger.es("状态有错误 roleId:" .. tostring(v.heroId))
						actionId = 9001
					end
					local roleStateData = self:getRoleDataWithId(v.heroId,true)
					if roleStateData ~= nil then
						roleStateData.serverActionInfo = v
						
						local activateCfg = Config.GetHomeActivateCfg(actionId)
						roleStateData.activateCfg = activateCfg
						--LuaLogger.es("activateCfg = ",tablex.dump(activateCfg))
						if activateCfg then

							if activateCfg.activateType == HomeActionType.GetoffWork then 
								self.m_coveWalkManager:PushToWalkLeaveCove(role)
							else

								if role.data.isDispose then
									self:removeRole(role)

									self:onRoleListChange()
									DLuaTimer:DoAfter(2, function() self:UpdateRolesWithHeroAction() end)
								else
									local lastRoomId = 0
									local lastRoom = role:getRoom()
									if lastRoom then
										lastRoomId = lastRoom.id
									end
									local newRoomId = activateCfg.param
									role.isEnterSwinRoom = false
									roleStateData.isEnterSwinRoom = false
									if newRoomId == 10015 then
										role.isEnterSwinRoom = true
										roleStateData.isEnterSwinRoom = true
									end


									--这边多加一个判断 ，是否房间已经改变
									if newRoomId ~= lastRoomId then
										local newRoom = self._coveMgr:getRoomMgr():getRoomWithRoomId(role.id,newRoomId)--self._coveMgr:getRoomMgr():getRandomRoom(role.id, lastRoomId)
										if newRoom then

											
											role.data.homeWorkIndex = self:GetWomeWorkPos(newRoomId)
											role:setRoom(newRoom)

											role:clearShowTimer()
											--LuaLogger.ds("role.data.homeWorkIndex ====",role.data.homeWorkIndex,lastRoomId,newRoomId)
											role.data.blackboard.changeRoomData = {lastRoomId = lastRoomId,newRoomId = newRoomId}


											self:SetRoleStateChangeRoom(role)
											
										end
									else
										self:SetRoleState(role)
									end
								end
							end
						else
							LuaLogger.es("状态有错误")
						end
					else
						LuaLogger.ds("当前角色不存在 roleId:" .. tostring(v.heroId))
					end

				end

			else
				--协议返回失败，回滚角色行为为原来的状态
				LuaLogger.ds("ReturnRoleFromStateComplete ReportHeroHomeActionCompletedReq 协议返回失败，回滚角色行为为原来状态，roleId:", role.id, "ret:", data.ret)
				rollbackToOriginAction()
			end
		end)
	end
end



--角色列表数量发生变化时上报服务器
--通过数据对比，只有数据真正变化时才发送请求
function CoveRoleManager:onRoleListChange(callBackFun)
	local roleIdList = {}
	local constructIdList = {}
	for _, roleStateData in ipairs(self._roleList) do
		if roleStateData.coveRoleType == CoveRoleType.Random then
			local workOrwalkState = self:getRoleInWorkOrWalkState(roleStateData.roleData.id)
			if workOrwalkState  == 0 then
				table.insert(roleIdList, roleStateData.roleData.id)
				table.insert(constructIdList, 10001)--roleStateData.room.id
			end
		end
	end
	local data = {
		roleIdList = roleIdList,
		constructIdList = constructIdList
	}
	
	-- 对比数据是否发生变化
	local dataChanged = false
	if self._lastRoleListData == nil then
		-- 第一次调用，需要发送请求
		dataChanged = true
	else
		-- 对比 roleIdList 和 constructIdList 是否相同
		local lastRoleIdList = self._lastRoleListData.roleIdList or {}
		local lastConstructIdList = self._lastRoleListData.constructIdList or {}
		
		-- 检查数组长度是否相同
		if #roleIdList ~= #lastRoleIdList or #constructIdList ~= #lastConstructIdList then
			dataChanged = true
		else
			-- 检查数组内容是否相同
			for i = 1, #roleIdList do
				if roleIdList[i] ~= lastRoleIdList[i] or constructIdList[i] ~= lastConstructIdList[i] then
					dataChanged = true
					break
				end
			end
		end
	end
	
	-- 只有数据发生变化时才发送请求
	if dataChanged then
		-- 保存当前数据作为下一次对比的基准
		self._lastRoleListData = {
			roleIdList = {},
			constructIdList = {}
		}
		-- 深拷贝数组
		for i = 1, #roleIdList do
			table.insert(self._lastRoleListData.roleIdList, roleIdList[i])
			table.insert(self._lastRoleListData.constructIdList, constructIdList[i])
		end
		
		--LuaLogger.es("CoveRoleManager:onRoleListChange()=====",tablex.dump(data))
		if Me then
			Me:setHomeShowRoleReq(data,function()
				--LuaLogger.ds("CoveRoleManager:onRoleListChange()==22222===",tablex.dump(data))
				if callBackFun then
					callBackFun()
				end
			end)
		end
	else
		-- 数据没有变化，直接执行回调（如果有）
		if callBackFun then
			callBackFun()
		end
	end
end


----但会当前任务状态  1表示在工作  2 表示指定散步 ，0 表示正常状态
function CoveRoleManager:getRoleInWorkOrWalkState(pRoleId)
	local constructionMap = Me:getConstructionMapData()

	for constructId, homeBulidInfo in pairs(constructionMap) do
		--获取当前部署的角色列表
		if homeBulidInfo.disposeHeroList then
			--如果当前是指挥室
			if constructId == GE.CoustructionEnum.CommandRoom or constructId == GE.CoustructionEnum.PatrolRoom then
				for index, roleId in pairs(homeBulidInfo.disposeHeroList) do

					if roleId ~= 0 then
						if pRoleId == roleId then
							return 1	
						end
					end
				end
			else
				local pos = self:getHomeCurWorkPos()

				for index, roleId in pairs(homeBulidInfo.disposeHeroList) do
					if index == pos then
						if roleId ~= 0 then
							if pRoleId == roleId then
								return 1	
							end
						end
					end
				end
			end
		end
	end

	--添加走路角色Begin
	local nowWalkRoleList = Me:getWalkHeroList()

	self.totalWalkRoleNum = #nowWalkRoleList
	for _, roleId in pairs(nowWalkRoleList) do
		if roleId ~= 0 then
			if pRoleId == roleId then
				return 2	
			end
		end
	end
	return 0
end

--角色可创建
function CoveRoleManager:roleCanCreate(roleId)
	--角色已经在场景中
	if self:isRoleInCove(roleId) then
		return false
	end

	--角色处于派遣状态
	if Me:roleInDispatch(roleId) then
		return false
	end

	return true
end


---判断角色是否在场景中
---@param id integer 角色表id
---@return boolean
function CoveRoleManager:isRoleInCove(id)
	--角色只要在场景中就算(包括处于离开港口行为的角色)
	for _, roleStateData in ipairs(self._roleList) do
		if (id == roleStateData.roleData.id) then
			return true
		end
	end
	return false
end

--获取角色
---@param id integer 角色表id
---@return CoveRole|nil
function CoveRoleManager:getRole(id)


	for _, roleStateData in ipairs(self._roleList) do
		if (roleStateData.coveRole and roleStateData.coveRole.id == id) then
			return roleStateData.coveRole
		end
	end
	return nil
end


function CoveRoleManager:GetRoleDatasWithId(roleId)

	for _, roleStateData in ipairs(self._roleList) do
		if (roleStateData.roleData.id and roleStateData.roleData.id == roleId) then
			return roleStateData
		end
	end
	return nil
end

function CoveRoleManager:onRoleWalkChange()
	
	local nowWalkRoleList = Me:getWalkHeroList()

	--LuaLogger.ds("移除散步的角色  nowWalkRoleList == ",tablex.dump(nowWalkRoleList))

	for roleIndex  = tablex.size(self._roleList), 1, -1 do
		local  roleStateData = self._roleList[roleIndex]
		local role = roleStateData.coveRole
		--如果是指定散步角色  ，但是不存在了 ， 标记为删除
		if roleStateData.coveRoleType == CoveRoleType.DesignRandom then
			local isExist = false
			for _, roleId in pairs(nowWalkRoleList) do
				if roleId == roleStateData.roleData.id and (roleStateData.isNeedToRemove == false  or roleStateData.isNeedToRemove == nil) then
					isExist = true
					break
				end
			end
			if isExist == false then
				--LuaLogger.es("移除散步的角色  isExist",isExist,roleStateData.roleData.id,roleStateData.coveRoleType)
				--如果是散步界面指定的  ，不在列表中移除
				if roleStateData.coveRole ~= nil then
					roleStateData.isNeedToRemove = true
					LuaLogger.ds("移除散步的角色  已创建   ，等待移除")
				else
					self:removeRoleStateData(roleStateData)
					LuaLogger.ds("移除散步的角色  未创建   ,直接移除")
				end
			end

		end
	end

	--人数清理

	self._randomRoleNum = 0
	for _, roleId in pairs(nowWalkRoleList) do
		if roleId == 0 then
			self._randomRoleNum = self._randomRoleNum + 1
		end
	end

	local  curRandomRoleIds = {}
	for index, role in pairs(self._roleList) do
		local  roleStateData = self._roleList[index]
		--LuaLogger.ds("因为超过上限 移除角xxx == " ,roleStateData.roleData.id,roleStateData.isRandomRole,roleStateData.coveRole,roleStateData.isNeedToRemove)
		if roleStateData.isRandomRole == true and  roleStateData.coveRole ~= nil and (roleStateData.isNeedToRemove == false  or roleStateData.isNeedToRemove == nil) then
			table.insert(curRandomRoleIds,roleStateData.roleData.id)
		end
	end

	--LuaLogger.es("因为超过上限 移除角色 curRandomRoleIds == " ,self._randomRoleNum,tablex.dump(curRandomRoleIds))
	--防止while循环
	if tablex.size(curRandomRoleIds) > 0 then
		for index = 1, 10 do
			if tablex.size(curRandomRoleIds) >  self._randomRoleNum then
				local currRandomRoleId = table.remove(curRandomRoleIds,1)
				local roleStateData = self:getRoleDataWithId(currRandomRoleId,true)
				if roleStateData and (roleStateData.isNeedToRemove == false  or roleStateData.isNeedToRemove == nil) then
					--LuaLogger.ds("因为超过上限 移除角色  " ,roleStateData.roleData.id)

					if roleStateData.coveRole ~= nil then
						roleStateData.isNeedToRemove = true
						--LuaLogger.ds("因为超过上限 移除散步的角色  已创建   ，等待移除",roleStateData.roleData.id)
					else
						self:removeRoleStateData(roleStateData)
						--LuaLogger.ds("因为超过上限 移除散步的角色  未创建   ，等待移除",roleStateData.roleData.id)
					end
				end
			end
		end
	end
	

	self:NewUpdateNewRoles(false)
end

---角色部署变化
--
function CoveRoleManager:onRoleDisposeChange()
	self:NewUpdateNewRoles(false)
end

---将角色状态数据加入场景角色列表（公有方法）
---@param roleStateData CoveRoleData 要加入的角色状态数据
function CoveRoleManager:addRoleStateData(roleStateData)
	if roleStateData and roleStateData.roleData and roleStateData.roleData.id then
		if self:isHasRoleInCove(roleStateData.roleData.id) then
			LuaLogger.ds("防止重复添加角色，跳过已存在的 roleId: " .. roleStateData.roleData.id)
			return
		end
	end
	table.insert(self._roleList, roleStateData)
end

---移除单个角色
---@param role CoveRole
function CoveRoleManager:removeRole(role)
	for i = #self._roleList, 1, -1 do
		if (self._roleList[i].coveRole and self._roleList[i].coveRole == role) then
			if self._roleList[i].coveRole then
				table.remove(self._roleList, i)
			else
				LuaLogger.ds("移除 时有相同的 ，移除未创建的",role.id)
			end
		end
	end
	local uid = role.uid
	role:clearSelf()
	self:onRoleListChange()
	self.coveMap[uid] = nil
end


function CoveRoleManager:removeRoleStateData(roleStateData)
	for i = #self._roleList, 1, -1 do
		if (self._roleList[i] == roleStateData) then
			table.remove(self._roleList, i)
			LuaLogger.ds("移除roleStateData ====",roleStateData.roleData.id )
		end
	end
	self:onRoleListChange()
end

--移除所有角色
function CoveRoleManager:removeAllRole()
	for _, roleStateData in ipairs(self._roleList) do
		if roleStateData.coveRole then
			local cove = roleStateData.coveRole
			self.coveMap[cove:GetUID()] = nil
			roleStateData.coveRole:clearSelf()
		end
	end
	self._roleList = {}
end

function CoveRoleManager:GetWomeWorkPos(roomId)
	local constructionMap = Me:getConstructionMapData()
	for constructId, homeBulidInfo in pairs(constructionMap) do

		--LuaLogger.es("homeBulidInfo.disposeHeroList  ",roomId,constructId,tablex.dump(homeBulidInfo.disposeHeroList))
		--获取当前部署的角色列表
		if homeBulidInfo.disposeHeroList then
			--如果当前是指挥室
			if constructId == roomId then
				for pos, roleId in pairs(homeBulidInfo.disposeHeroList) do

					if roleId == 0 then
						--LuaLogger.es("homeBulidInfo.GetWomeWorkPos  ",roomId,constructId,tablex.dump(homeBulidInfo.disposeHeroList),pos)
						return pos
					end
				end
			end
		end
	end
	--LuaLogger.es("CoveRoleManager:GetWomeWorkPos(roomId) ====找不到位置 ,返回-1")
	return 1
end
function CoveRoleManager:startStateUpdate()
	self.roleStateTimer = DLuaTimer:DoRepeatForever(5, function()
		self:roleStateUpdate()
	end)
end



---角色状态更新update
function CoveRoleManager:roleStateUpdate()

	self:NewUpdateNewRoles(false)


	--角色生命周期结束离开港口

	local timeStamp = os.time()

	for index, role in pairs(self._roleList) do
		local  roleStateData = self._roleList[index]
		if roleStateData.isRandomRole == true and roleStateData.coveRole ~= nil then
			if roleStateData.lifeTime <= timeStamp and role.lifeEndStamp ~= -1 then
				roleStateData.isNeedToRemove = true
			end
		end
	end


	self:UpdateReportHeroHomeActionCompletedReqMessage()
	
end




--获取当前班表的index
---@return integer
function CoveRoleManager:getRoleScheduleIndex()
	local timeStamp = os.time()
	local index = math.floor(timeStamp / 86400) % 3
	return index + 1
end

--获取当前时间处于工作状态的位置
---@return integer
function CoveRoleManager:getHomeCurWorkPos()
	local index = self:getRoleScheduleIndex()
	local workCfg = workScheduleCfg[index]
	local startTime = workTimeCfg[1]
	local endTime = workTimeCfg[2]
	local curHour = tonumber(os.date("%H"))
	local value = 2
	if curHour >= startTime and curHour < endTime then
		value = 1
	end
	for i = 1, 3 do
		if workCfg[i] == value then
			return i
		end
	end
end

-----------------------派遣-----------------------

function CoveRoleManager:disPatchEndRecover()
	self:NewUpdateNewRoles(false)
end

function CoveRoleManager:refreshAllEventMsg()
	for _, role in ipairs(self._roleList) do
		if role.coveRole ~= nil then
			role.coveRole:refreshEventMsg()
		end
	end
end

function CoveRoleManager:getRandom()
	return self._coveMgr:getRandom()
end

function CoveRoleManager:clear()
	if self.roleStateTimer then
		DLuaTimer:RemoveTimer(self.roleStateTimer)
	end
	-- 清理保存的数据
	self._lastRoleListData = nil
	idTmep = 0
	self:removeAllRole()
	self:DeleteAllCove()

	Me:ReportHomelandEnterExitReq(false)
	GameMsgMgr:unRegEvent(GameMsgType.RefreshEventMsg, self, self.refreshAllEventMsg)

	CoveBattleMgr.instance():UpdateCoveProperty()
end

function CoveRoleManager:GetAllCoveTab()
	return self.coveMap
end

function CoveRoleManager:DeleteAllCove()
	if self.coveMap == nil then
		return
	end
	for k, v in pairs(self.coveMap) do
		if v ~= nil and not v:IsDestroy() then
			v:Destroy()
		end
	end
	self.coveMap = {}
end


---@return CoveBase
function CoveRoleManager:GetRoleBuyUid(uid)
	if self.coveMap == nil then
		return nil
	end
	return self.coveMap[uid]
end


function CoveRoleManager:createMonster(data)
	data.uid = GetUID()
	---@type CoveMonster
	local role = CoveMonster:new(data)

	role:createRole(function()
		LuaLogger.ds("创建怪物完成")
	end)

	self.coveMap[data.uid] = role
	return role
end

---@param cove CoveBase
function CoveRoleManager:RemoveMonster(cove)
	local uid = cove:GetUID()
	self.coveMap[uid] = nil
	cove:Destroy()
end



function CoveRoleManager:ShowRoleHomeMood(roleObj)

	for _, roleStateData in ipairs(self._roleList) do
		if (roleStateData.coveRole ~= nil and roleStateData.coveRole._roleCont ~= nil) then
			if roleStateData.coveRole._roleCont.gameObject == roleObj.gameObject then
				if roleStateData.coveRole.data and roleStateData.coveRole.data.activateCfg and tablex.size(roleStateData.coveRole.data.activateCfg.statusShow) > 0 then
					roleStateData.coveRole:ShowHomeMood(roleStateData.coveRole.data.activateCfg.statusShow[1])
				end
			end
			
		end
	end
	return nil
end


function CoveRoleManager:SetRoleShowState(state)
	for _, roleStateData in ipairs(self._roleList) do
		if (roleStateData.coveRole ~= nil) then
			roleStateData.coveRole.modelObj:SetActive(state)
		end
	end
end


---上报家园英雄完成行为
---@param data ReportHeroHomeActionCompletedReq
---@param callback function?
function CoveRoleManager:ReportHeroHomeActionCompletedReq(data, callback)

	self.ReportHeroHomeActionCompletedReqMessageData = self.ReportHeroHomeActionCompletedReqMessageData or {}
	local messageData = self.ReportHeroHomeActionCompletedReqMessageData

	if messageData.isSending then
		messageData.messageInfo = messageData.messageInfo or {}
		local param = {
			data = data,
			callback = callback,
		}
		table.insert(messageData.messageInfo, param)
		return
	end
	messageData.isSending = true
	Me:ReportHeroHomeActionCompletedReq(data,function(data) 
		--DLuaTimer:DoAfter(3.5, function()
				self:OnReportHeroHomeActionCompletedReqCallback()
				callback(data)
				
		--end)
	end)
end

function CoveRoleManager:OnReportHeroHomeActionCompletedReqCallback()
	local messageData = self.ReportHeroHomeActionCompletedReqMessageData
	messageData.isSending = false

	DLuaTimer:DoAfter(0.1, function()
		self:UpdateReportHeroHomeActionCompletedReqMessage()
	end)
end

function CoveRoleManager:UpdateReportHeroHomeActionCompletedReqMessage()
	local messageData = self.ReportHeroHomeActionCompletedReqMessageData
	if messageData == nil or messageData.isSending then
		return
	end
	local messageInfo = messageData.messageInfo
	if messageInfo == nil or #messageInfo == 0 then		
		return
	end
	local param = messageInfo[1]
	table.remove(messageInfo, 1)
	self:ReportHeroHomeActionCompletedReq(param.data, param.callback)
end

return CoveRoleManager