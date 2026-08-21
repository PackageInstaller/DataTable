require "class"

---@class CoveActionCommon
local CoveActionCommon = class("CoveActionCommon")

function CoveActionCommon:ctor(...)
    self.m_coveSwinRole = {}

end


---实例化
---@return CoveActionCommon CoveActionCommon
function CoveActionCommon.instance()
	if (CoveActionCommon._instance == nil) then
		CoveActionCommon._instance = CoveActionCommon:new()
	end
	return CoveActionCommon._instance
end


function CoveActionCommon:init(coveRoleMgr)
	self.m_coveRoleMgr = coveRoleMgr
end



function CoveActionCommon:PushToWalkCommon(coveRole,completeFun,complete2Fun)

	-- 状态变化时，如果有 statusShow[1] 就显示
	if coveRole.data and coveRole.data.activateCfg and tablex.size(coveRole.data.activateCfg.statusShow) > 0 then
		coveRole:ShowHomeMood(coveRole.data.activateCfg.statusShow[1])
	end

	if coveRole.data.isCreateInRoom  == true then
		coveRole.data.isAppear = true
		if complete2Fun then
			complete2Fun(coveRole)
		end
		-- 到达后，根据 statusShow[2] 决定是否关闭
		-- statusShow[2] == 1: 到达后关闭
		-- statusShow[2] == 2: 持续显示
		coveRole:DoWalkBehavior(true,function()
			if coveRole.data and coveRole.data.activateCfg and tablex.size(coveRole.data.activateCfg.statusShow) > 0 then
				if coveRole.data.activateCfg.statusShow[2] == 1 then
					coveRole:HideHomeMood()
				end
				-- 如果是 2，则持续显示，不关闭
			end
			if completeFun then
				completeFun(coveRole)
			end
		end)
	else
		if coveRole.data.isAppear == nil  or  coveRole.data.isAppear == false then
			coveRole.data.isAppear = true
			-- DoAppearToDestinationBehavior 只是到达初始位置，还没到达最终目的地，所以不在这里关闭
			coveRole:DoAppearToDestinationBehavior(function()
				-- 到达初始位置后，继续走到最终目的地
				coveRole:DoWalkBehavior(true,function()
					-- 到达最终目的地后，根据 statusShow[2] 决定是否关闭
					if coveRole.data and coveRole.data.activateCfg and tablex.size(coveRole.data.activateCfg.statusShow) > 0 then
						if coveRole.data.activateCfg.statusShow[2] == 1 then
							coveRole:HideHomeMood()
						end
						-- 如果是 2，则持续显示，不关闭
					end
					if completeFun then
						completeFun(coveRole)
					end
				end)
			end)
		else
			-- 到达后，根据 statusShow[2] 决定是否关闭
			coveRole:DoWalkBehavior(true,function()
				if coveRole.data and coveRole.data.activateCfg and tablex.size(coveRole.data.activateCfg.statusShow) > 0 then
					if coveRole.data.activateCfg.statusShow[2] == 1 then
						coveRole:HideHomeMood()
					end
					-- 如果是 2，则持续显示，不关闭
				end
				if completeFun then
					completeFun(coveRole)
				end
			end)
		end
	end

end


function CoveActionCommon:PushToChangeRoomCommon(coveRole,completeFun)

	-- 状态变化时，如果有 statusShow[1] 就显示
	if coveRole.data and coveRole.data.activateCfg and tablex.size(coveRole.data.activateCfg.statusShow) > 0 then
		coveRole:ShowHomeMood(coveRole.data.activateCfg.statusShow[1])
	end

	coveRole:doChangeRoomBehaivior(function()
		-- doChangeRoomBehaivior 只是换房间行为，还没到达最终目的地，所以不在这里关闭
		coveRole:DoWalkBehavior(true,function()
			-- 到达最终目的地后，根据 statusShow[2] 决定是否关闭
			if coveRole.data and coveRole.data.activateCfg and tablex.size(coveRole.data.activateCfg.statusShow) > 0 then
				if coveRole.data.activateCfg.statusShow[2] == 1 then
					coveRole:HideHomeMood()
				end
				-- 如果是 2，则持续显示，不关闭
			end
			if completeFun then
				completeFun(coveRole)
			end
		end)
	end)
end


function CoveActionCommon:RemoveFromCommon(coveRole,completeFun1,completeFun2)
	--如果当前角色没有移除 ，并且当前角色是散步角色  ，或者随机角色
	if not coveRole.data.isDispose and (not coveRole.data.isNeedToRemove) then
		if coveRole.data.coveRoleType == CoveRoleType.DesignRandom  or coveRole.data.coveRoleType == CoveRoleType.Random then
			--LuaLogger.es("RemoveFromWalk=======",coveRole.id,coveRole.roomStayStamp - os.time())

			--todofly test  
			-- coveRole.roomStayStamp = os.time() - 10
			if coveRole.roomStayStamp - os.time() > 0 then
				--LuaLogger.es("DoWalkBehavior=====false==")
				coveRole:DoWalkBehavior(false,function()
					if completeFun1 then
						completeFun1(coveRole)
					end
				end)
				return
			end
		end
	end
	coveRole:HideHomeMood()

	if completeFun2 then
		completeFun2(coveRole)
	end
	self.m_coveRoleMgr:ReturnRoleFromStateComplete(coveRole)
end



function CoveActionCommon:PushToLeaveCoveCommon(coveRole,completeFun)

	coveRole.data.isDispose = true
	coveRole.data.isAppear = false
	coveRole:DoRemoveRoleBehavior(function()
		if completeFun then
			completeFun(coveRole)
		end
	end)
end

return CoveActionCommon
