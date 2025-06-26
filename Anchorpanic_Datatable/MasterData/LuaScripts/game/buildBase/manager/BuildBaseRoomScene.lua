module("game.buildBase.BuildBaseRoomScene", Class.impl(map.MapBaseController))

-- 构造函数
function ctor(self)
	super.ctor(self)
	
end

function reLogin(self)
    super.reLogin(self)
    self:clearMap()
end

-- 地图类型
function getMapType(self)
    return MAP_TYPE.BUILDBASEROOM
end


-- 开始加载前
function beforeLoad(self)
	UIFactory:startForcibly()
end

-- 加载场景完的调用
function enterMap(self)
    super.enterMap(self)
    
    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE,self.UpadateSceneLive,self)

    if self.mBuildBaseRoomUI == nil then
        self.mBuildBaseRoomUI = buildBase.BuildBaseRoomUI.new()
        self.mBuildBaseRoomUI:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPanelHandler, self)
    end
    self.mBuildBaseRoomUI:open(self.m_RoomConfigData)

    local point = gs.GameObject.Find("FindPoint")
    if point then 
    	self.m_ActionPos = point.transform.position
    end

    self:UpadateSceneLive()
end

--更新站员
function UpadateSceneLive(self)
	local buildBaseMsgVo = buildBase.BuildBaseManager:getBuildBaseData(self.m_RoomId)
	if not buildBaseMsgVo then return end

	self:clearLiveModel()

	local heroList = buildBaseMsgVo.heroList
	if table.empty(heroList) then 
		UIFactory:closeForcibly()
		return
	end

	if self.m_RoomConfigData.liveType == buildBase.RoomLiveType.ManyLive then 
		local createIndex = 0
		for k,liveId in pairs(heroList) do
			local config = hero.HeroCuteManager:getHeroCuteConfigVo(liveId)
    		if config then
				local live = self:createLive(liveId,100 - k,function ()
					createIndex = createIndex + 1
					if createIndex >= #heroList then 
						self:setLivePatrol()
						UIFactory:closeForcibly()
					end
				end)
				if live then
					live:setNeedAI(true)
				end
			else
				logError("不是Q版站员========" .. liveId)
				UIFactory:closeForcibly()
			end
		end

	elseif self.m_RoomConfigData.liveType == buildBase.RoomLiveType.SingleLive then
		self:createLive(heroList[1],100,function ()
			if self.m_ActionPos then
				self.m_LiveDic[heroList[1]]:setPosition(self.m_ActionPos)
			end
			self:playAcitonWithBuild(heroList[1])

			UIFactory:closeForcibly()
		end)
	end
end

--生成站员
function createLive(self,liveId,priority,finishCall)
    if self.m_LiveDic[liveId] ~= nil then
    	logWarn("该站员已经被创建过了 id = " .. liveId)
    	return
    end
    
    if gs.Application.isEditor then
   		buildBase.BuildBaseQLive = require("game/buildBase/manager/BuildBaseQLive")
   	end
   	
    local live = buildBase.BuildBaseQLive.new()
    self.m_LiveDic[liveId] = live
    table.insert(self.m_LiveList,live)

    live:setModelID(liveId,priority,finishCall)
    return live
end

function clearLiveModel(self)
	if not self.m_LiveList then return end 
	
    for k,v in pairs(self.m_LiveList) do
		v:onRecover()
	end
	self.m_LiveDic = {}
	self.m_LiveList = {}

	self:clearTimer()
end

--设置数据
function setRoomData(self,roomId)
	self.m_RoomId = roomId
	self.m_RoomConfigData = buildBase.BuildBaseManager:getBuildBasePosDataByPos(self.m_RoomId)
	if not self.m_RoomConfigData then
		logError("不存在这个房间，请检查配置表 id = " .. foomId)
		return
	end

	self.m_LiveDic = {}
	self.m_LiveList = {}

	--需要寻路到播放动画的点
	self.m_AcitonPoint = math.Vector3()

	--上一个同家具交互的站员ID
	self.m_CurPlayInteractiveId = nil
end

-- ui销毁
function onDestroyPanelHandler(self)
    self.mBuildBaseRoomUI:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPanelHandler, self)
    self.mBuildBaseRoomUI = nil
end

--同家具交互
function playAcitonWithBuild(self,liveId)
	if not self.m_LiveDic[liveId] then return end

	self.m_CurPlayInteractiveId = liveId

	---设置最高优先级，保证玉家具交互的时候不会玉其他站员重叠
	self.m_LiveDic[liveId]:playAction(DormitoryCost.ACT_SHOW_IDLE,nil,function ()
		self.m_LiveDic[liveId]:startAI()
		self.m_CurPlayInteractiveId = nil
	end)
end

function getMapID(self)
	return self.m_RoomConfigData.sceneId
end

-- 清理当前地图
function clearMap(self)
    super.clearMap(self)

    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_BUILDINFO_UPDATE,self.UpadateSceneLive,self)

    self:clearLiveModel()
	self:clearTimer()

	self.m_LiveDic = nil
	self.m_LiveList = nil
	self.m_AcitonPoint = nil
	self.m_CurPlayInteractiveId = nil
end


----------------------------------------------AI 相关----------------------------------

function setLivePatrol(self)
	if not self.m_ActionPos then return end

	self:clearTimer()
	self.m_TimerOutSn = LoopManager:addTimer(30,0,self,self.randomLivePlayAction)
end

--清理交互计时器
function clearTimer(self)
	if self.m_TimerOutSn then
		LoopManager:removeTimerByIndex(self.m_TimerOutSn)
		self.m_TimerOutSn = nil
	end
end

function randomLivePlayAction(self)
	if self.m_CurPlayInteractiveId then return end

	local newPlayLiveIndex = self:getRandomIndex(self.m_LastRandomLiveIndex)
	local live = self.m_LiveList[newPlayLiveIndex]
	live:stopAI()
	live:movePoint(self.m_ActionPos,function ()
		self.m_LastRandomLiveIndex = newPlayLiveIndex

		self:playAcitonWithBuild(live.m_liveId)
	end)
end

function getRandomIndex(self,oldIndex)
	if #self.m_LiveList <= 1 then 
		return 1
	end

	local randomIndex = math.random(1,#self.m_LiveList) 
	if randomIndex == oldIndex then 
		return self:getRandomIndex(oldIndex)
	end

	return randomIndex
end

return _M
