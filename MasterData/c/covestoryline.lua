local events = require("client.clientScript.events")


---@class CoveStoryLine
local CoveStoryLine = class("CoveStoryLine")

---@enum CoveStroyLineEventType 剧情事件类型
local CoveStroyLineEventType = {
	None = 0,				---默认执行
	Move = 1,				---执行移动
	Animation = 2,			---执行动画
	Animator = 3,			---执行动画
	SetActive = 4,			---显示隐藏
	SetMountPoint = 5,		---设置绑点
	ShowMessageBox = 6,		---弹窗对话框
	YieldTime = 7,			---等待时间
	RandomStory = 8,		---随机
	AnimaEvent = 9,			---监听事件
	Spine = 10,				---spine动画
	PlayableDirector = 11,	---TimeLine动画
}

local isDebug = true
local maxRunLine = 100

---@param data integer
function CoveStoryLine:ctor(data)

	self.id = data
	---@type UnityEngine.GameObject?
	self.gameObject = nil
	---@type table<string, CoveActingSystem.CovePoint>
	self.covePointMap = {}
	---@type table<string, CoveActingSystem.CoveAnimation>
	self.coveAnimationMap = {}
	---@type table<string, CoveActingSystem.CoveAnimator>
	self.coveAnimatorMap = {}
	---@type table<string, CoveActingSystem.CoveMove>
	self.coveMoveMap = {}
	---@type table<string, CoveActingSystem.CoveSpine>
	self.coveSpineMap = {}
	---@type table<string, CoveActingSystem.CovePlayableDirector>
	self.covePlayableDirectorMap = {}
	---@type table<string, CoveActingSystem.CoveEntityBase>
	self.allCoveComponent = {}

	---@class AnimaEventData
	---@field lineId integer
	---@field targetName string
	---@field eventName string
	---@field triggerCount integer
	---@field eventParam string

	---@type table<string, AnimaEventData>
	self.animaEventList = {}

	---@type table<integer, DTimer.TimerInfo>
	self.timerInfos = {}

	---@type boolean 
	self.isRuning = false
	---@type integer[]	当前播放列表	用于debug
	self.runStoryLineIds = {}

	---@type boolean
	self.isUnlock = false

	---@type boolean?
	self.destroyed = nil

	---@type table<integer, CoveStoryLineTable>
	self.groupCfg = Config.GetCoveStoryLineTable(data)
	if self.groupCfg == nil then
		self:Error("剧情配置错误 groupId:"  .. tostring(data))
		return
	end

	local temp = nil
	for k, v in pairs(self.groupCfg) do
		if v.eventType == CoveStroyLineEventType.None then
			temp = temp and math.min(temp, v.id) or v.id
		end
	end
	if temp == nil then
		self:Error("未找到 启动项")
	end
	---@type integer?
	self.startId = temp
end

---@param gameObject UnityEngine.GameObject
function CoveStoryLine:InitTransform(gameObject)
	if IsNull(gameObject) then
		return
	end
	self.gameObject = gameObject
	---@type CoveActingSystem.CovePoint[]
	local covePoints = gameObject:GetComponentsInChildren(typeof(CoveActingSystem.CovePoint))
	---@type CoveActingSystem.CoveAnimation[]
	local coveAnimations = gameObject:GetComponentsInChildren(typeof(CoveActingSystem.CoveAnimation))
	---@type CoveActingSystem.CoveAnimator[]
	local coveAnimators = gameObject:GetComponentsInChildren(typeof(CoveActingSystem.CoveAnimator))
	---@type CoveMove[]
	local coveMoves = gameObject:GetComponentsInChildren(typeof(CoveActingSystem.CoveMove))

	---@type CoveActingSystem.CoveSpine[]
	local coveSpines = gameObject:GetComponentsInChildren(typeof(CoveActingSystem.CoveSpine))

	---@type CoveActingSystem.CovePlayableDirector[]
	local covePlayableDirectors = gameObject:GetComponentsInChildren(typeof(CoveActingSystem.CovePlayableDirector))


	for i = 0, coveAnimations.Length - 1 do
		local data = coveAnimations[i]
		local key = data.name
		if self.coveAnimationMap[key] ~= nil then
			self:Error("剧情 covePoint重复 name:" .. key)
		end
		data.eventCallback = BindCallback(self, self.OnAnimaEventCallBack)
		self.coveAnimationMap[key] = data
		self.allCoveComponent[key] = data

	end

	for i = 0, coveAnimators.Length - 1 do
		local data = coveAnimators[i]
		local key = data.name
		if self.coveAnimatorMap[key] ~= nil then
			self:Error("剧情 covePoint重复 name:" .. key)
		end
		self.coveAnimatorMap[key] = data
		self.allCoveComponent[key] = data
	end

	local keys = {
		covePoint = covePoints,
		coveMove = coveMoves,
		coveSpine = coveSpines,
		covePlayableDirector = covePlayableDirectors,
	}

	for k, v in pairs(keys) do
		local map = self[k.."Map"]
		for i = 0, v.Length - 1 do
			local data = v[i]
			local name = data.name
			if map[name] ~= nil then
				self:Error("剧情 covePoint重复 name:" .. name)
			end
			map[name] = data
			self.allCoveComponent[name] = data
		end
	end

	self.gameObject:SetActive(false)
	self.isRuning = false
end

---检测剧情是否激活
function CoveStoryLine:CheckActive()
	if self.isUnlock then
		return
	end
	if self.groupCfg == nil then
		return
	end

	if self.startId == nil then
		return
	end

	if self.gameObject == nil or IsNull(self.gameObject) then
		return
	end
	local cfg = self.groupCfg[self.startId]
	if string.isNullOrEmpty(cfg.activationConditions) then
		self.isUnlock = true
	else
		self.isUnlock = Me:canOpenFunctionByCfg(cfg.activationConditions)
	end
	if not self.isUnlock then
		return
	end
	self.gameObject:SetActive(true)
	self:Play(self.startId)
end

---动画时间触发回调
---@param objName string
function CoveStoryLine:OnAnimaEventCallBack(objName)
	if string.isNullOrEmpty(objName) then
		return
	end

	local eventData = self.animaEventList[objName]
	if eventData == nil then
		return
	end
	eventData.triggerCount = eventData.triggerCount - 1
	if eventData.triggerCount <= 0 then
		self.animaEventList[objName] = nil
		local id = eventData.lineId
		self:OnStroyLineFinishCallback(eventData.eventParam, id)
	end
end

---播放剧情
function CoveStoryLine:Play(id)
	self:Error("===>>> 播放 id:" .. id)
	local index = tablex.indexof(self.runStoryLineIds, id)
	if index > 0 then
		self:Error("当前id:" .. id .. "已经在播放")
		return
	end
	if #self.runStoryLineIds > maxRunLine then
		return
	end
	local lineCfg = self.groupCfg[id]
	if lineCfg == nil then
		return
	end
	local eventKey = nil
	for k, v in pairs(CoveStroyLineEventType) do
		if v == lineCfg.eventType then
			eventKey = k
			break
		end
	end
	if eventKey == nil then
		self:Error("执行事件失败 id" .. id .. " eventType:" .. lineCfg.eventType)
		return
	end
	local fun = self["Play_" ..eventKey]
	if fun == nil then
		self:Error("剧情事件未实现 id:" .. id .. "  eventKey:" .. eventKey)
		return
	end
	table.insert(self.runStoryLineIds, id)
	fun(self, lineCfg)
end



---line播放完成
---@param nextStroyLines integer[]|string
---@param id integer
function CoveStoryLine:OnStroyLineFinishCallback(nextStroyLines, id)
	self:Error("剧情事件播放完成 id:" .. id)

	local index = tablex.indexof(self.runStoryLineIds, id)
	if index < 0 then
		self:Error("当前剧情未开启确收到播放完成回调 id" .. id)
	end
	table.remove(self.runStoryLineIds, index)
	if nextStroyLines == nil then
		return
	end
	if nextStroyLines ~= nil and type(nextStroyLines) == "string" then
		local temp = string.split(nextStroyLines, ",")
		---@type integer[]
		nextStroyLines = {}
		for i = 1, #temp do
			local lineId = tonumber(temp[i])
			if lineId ~= nil then
				table.insert(nextStroyLines, lineId)
			end
		end
	end
	if #nextStroyLines == 0 then
		local runCount = #self.runStoryLineIds
		if runCount == 0 then
			self:OnOver()
		end
		return
	end
	for i = 1, #nextStroyLines do
		local id = nextStroyLines[i]
		self:Play(id)
	end
end

---剧情播放 完毕回调
function CoveStoryLine:OnOver()
	self:Error("===>>> 剧情播放完毕 groupId:" .. self.id)
	self.isRuning = false
end

---@param lineCfg CoveStoryLineTable
function CoveStoryLine:Play_None(lineCfg)
	local id = lineCfg.id
	self:OnStroyLineFinishCallback(lineCfg.finishParam, id)
end


---@param lineCfg CoveStoryLineTable
function CoveStoryLine:Play_Move(lineCfg)
	local id = lineCfg.id
	local target = self.coveMoveMap[lineCfg.objName]
	if target == nil then
		self:Error("剧情播放失败 未找到对应的目标 id:" .. tostring(id))
		return
	end
	local eventParams = string.split(lineCfg.eventParam, "|")
	---@type string[]
	local pointIds = string.split(eventParams[1], ",")
	target:ClearPath()
	for i = 1, #pointIds do
		local p = self.covePointMap[pointIds[i]]
		if p == nil then
			self:Error("===>>>剧情播放失败 未找到对应参照点 id:" .. tostring(id) .. " pointId:" .. pointIds[i]) 
			return
		end
		target:AddPathPoint(p.transform)
	end

	local param = eventParams[2]
	local moveParam = string.split(param, ",")
	local speed = tostring(moveParam[1])
	local rotateType = tostring(moveParam[2])
	local accSpeed = tostring(moveParam[3]) or 0
	local maxSpeed = tostring(moveParam[4]) or 0

	local cb = BindCallback(self, self.OnStroyLineFinishCallback, lineCfg.finishParam, id)
	target:Move(speed, accSpeed, maxSpeed, rotateType, cb)
end

---@param lineCfg CoveStoryLineTable
function CoveStoryLine:Play_Animation(lineCfg)
	local id = lineCfg.id
	local target = self.coveAnimationMap[lineCfg.objName]
	if target == nil then
		self:Error("剧情播放失败 未找到对应的目标 id:" .. tostring(id))
		return
	end
	local cb = BindCallback(self, self.OnStroyLineFinishCallback, lineCfg.finishParam, id)
	target:Play(lineCfg.eventParam, cb)
end

---@param lineCfg CoveStoryLineTable
function CoveStoryLine:Play_Animator(lineCfg)
	local id = lineCfg.id
	local target = self.coveAnimatorMap[lineCfg.objName]
	if target == nil then
		self:Error("剧情播放失败 未找到对应的目标 id:" .. tostring(id))
		return
	end
	---@type string[]
	local eventParams = string.split(lineCfg.eventParam, ",")
	if eventParams == 1 then
		local cb = BindCallback(self, self.OnStroyLineFinishCallback, lineCfg.finishParam, id)
		target:PlayAnim(eventParams[1], cb)
	else
		local anima = target.anima
		local funName = eventParams[1]
		local keyName = eventParams[2]
		local val = eventParams[3]
		if funName == "SetToggle" then
			anima:SetToggle(keyName)
		elseif funName == "SetBool" then
			val = ToBoolean(val)
			anima:SetBool(keyName, val)
		elseif funName == "SetFloat" then
			val = tonumber(val)
			anima:SetFloat(keyName, val)
		elseif funName == "SetInteger" then
			val = tonumber(val)
			val = math.floor(val)
			anima:SetInteger(keyName, val)
		end
	end
end

---监听动画事件剧情函数
---@param lineCfg CoveStoryLineTable
function CoveStoryLine:Play_AnimaEvent(lineCfg)
	local id = lineCfg.id

	---@type string[]
	local params = string.split(lineCfg.eventParam, ",")
	if params == nil or #params < 2 then
		return
	end

	local eventName = params[1]
	local triggerCount = 1
	if params[2] ~= nil then
		triggerCount = tostring(params[2])
	end
	if triggerCount == nil then
		triggerCount = 1
	end
	---@type AnimaEventData
	local data = {
		lineId = id,
		targetName = lineCfg.objName,
		eventName = eventName,
		triggerCount = triggerCount,
		eventParam = lineCfg.finishParam,
	}
	self.animaEventList[data.targetName] = data
end


---@param lineCfg CoveStoryLineTable
function CoveStoryLine:Play_Spine(lineCfg)
	local id = lineCfg.id
	local target = self.coveSpineMap[lineCfg.objName]
	if target == nil then
		self:Error("剧情播放失败 未找到对应的目标 id:" .. tostring(id))
		return
	end
	local cb = BindCallback(self, self.OnStroyLineFinishCallback, lineCfg.finishParam, id)

	local params = string.split(lineCfg.eventParam, ",")
	if #params < 1 then
		self:Error("===>>> 剧情配置参数错误 id:" .. id .. " eventParam:"..lineCfg.eventParam)
		return
	end
	local animaName = params[1]
	local isLoop = params[2] == "-1"
	target:Play(animaName, isLoop, cb)
end

---播放TimeLine
---@param lineCfg CoveStoryLineTable
function CoveStoryLine:Play_PlayableDirector(lineCfg)
	local id = lineCfg.id
	local target = self.covePlayableDirectorMap[lineCfg.objName]
	if target == nil then
		self:Error("剧情播放失败 未找到对应的目标 id:" .. tostring(id))
		return
	end
	local cb = BindCallback(self, self.OnStroyLineFinishCallback, lineCfg.finishParam, id)
	target:Play(cb)
end

---显示隐藏
---@param lineCfg CoveStoryLineTable
function CoveStoryLine:Play_SetActive(lineCfg)
	local id = lineCfg.id
	local target = self.allCoveComponent[lineCfg.objName]
	if target == nil then
		self:Error("剧情播放失败 未找到对应的目标 id:" .. tostring(id))
		return
	end
	local param = tonumber(lineCfg.eventParam )
	param = param or 0
	---@type boolean
	local isActive = param ~= 0
	target.gameObject:SetActive(isActive)
	self:OnStroyLineFinishCallback(lineCfg.finishParam, id)
end

---设置绑定点
---@param lineCfg CoveStoryLineTable
function CoveStoryLine:Play_SetMountPoint(lineCfg)
	local id = lineCfg.id
	local target = self.allCoveComponent[lineCfg.objName]
	if target == nil then
		self:Error("剧情播放失败 未找到对应的目标 id:" .. tostring(id))
		return
	end

	local mountName = lineCfg.eventParam
	local mountObj = self.allCoveComponent[mountName]
	if mountObj == nil then
		self:Error("对于挂点未找到 id:" .. id .."  挂点名:" .. mountName)
		return
	end
	target.transform:SetParent(mountObj.transform)
	target.transform.localPosition = Vector3.zero
	target.transform.localRotation = Quaternion.identity
	self:OnStroyLineFinishCallback(lineCfg.finishParam, id)
end


---处理剧情结束事件
---@param lineCfg CoveStoryLineTable
function CoveStoryLine:Play_ShowMessageBox(lineCfg)
	local id = lineCfg.id

	local params = string.split(lineCfg.eventParam, ",")
	if #params < 4 then
		self:Error("===>>> 剧情配置参数错误 id:" .. id .. " eventParam:"..lineCfg.eventParam)
		return
	end
	local title = params[1]
	local content = params[2]
	local okstr = params[3]
	local canclestr = params[4]
	local params = string.split(lineCfg.finishParam, "|")
	if #params < 2 then
		self:Error("===>>> 剧情配置参数错误 id:" .. id .. " finishParam:"..lineCfg.finishParam)
		return
	end
	local event_a = params[1]
	local event_b = params[2]
	UICommonUtils.PopMsgBox(title, content, MsgBoxType.OKCancel, function()
		self:OnStroyLineFinishCallback(event_a, id)
	end,  function()
		self:OnStroyLineFinishCallback(event_b, id)
	end, okstr, canclestr)
end

---延时剧情函数
---@param lineCfg CoveStoryLineTable
function CoveStoryLine:Play_YieldTime(lineCfg)
	local id = lineCfg.id

	local time = tonumber(lineCfg.eventParam)
	if time == nil then
		self:Error("配置错误  id" .. tostring(id))
		return
	end
	local timer = self.timerInfos[id]
	if timer ~= nil then
		timer:Stop()
		timer = nil
		self.timerInfos[id] = nil
	end
	timer = DLuaTimer:DoAfter(time, function()
		self.timerInfos[id] = nil
		self:OnStroyLineFinishCallback(lineCfg.finishParam, id)
	end)
	self.timerInfos[id] = timer
end

---随机剧情函数
---@param lineCfg CoveStoryLineTable
function CoveStoryLine:Play_RandomStory(lineCfg)
	local id = lineCfg.id
	---@type string[]
	local params = string.split(lineCfg.finishParam, "|")
	if params == nil then
		self:Error("随机参数错误 id:" .. id)
		return
	end
	local pcTab = {}	---排除列表
	local function checkIsValid(paramStr)
		local temp = string.split(paramStr, ",")
		if not temp or #temp == 0 then
			 return false 
		end

		local lineId = tonumber(temp[1])
		if not lineId then 
			return false 
		end

		local cfg = self.groupCfg[lineId]
		if not cfg then 
			return false 
		end
		if string.isNullOrEmpty(cfg.activationConditions) then 
			return true 
		end
		return Me:canOpenFunctionByCfg(cfg.activationConditions)
	end
	for i = 1, #params do
		if not checkIsValid(params[i]) then
        	table.insert(pcTab, i)
    	end
	end

	if #pcTab ~= 0 then
		for i = #pcTab, 1, -1 do
			table.remove(params, pcTab[i])
		end	
	end
	if #params == 0 then
        self:Error("没有可用的随机剧情参数 id:" .. id)
        return
    end
	local r = math.random(1, #params)
	local p = params[r]
	self:OnStroyLineFinishCallback(p, id)
end

function CoveStoryLine:Destroy()

	if self.timerInfos ~= nil then
		for k, v in pairs(self.timerInfos) do
			v:Stop()
		end
		self.timerInfos = nil
	end
	self.destroyed = true
end


function CoveStoryLine:Error(str)
	if not isDebug then
		return
	end
	if str == nil then
		return
	end
	str = "===>>> CoveStroyLine Group:" .. self.id .. "    ".. str
	LuaLogger.ds(str)
end

return CoveStoryLine