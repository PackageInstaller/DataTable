-- 效果执行器，统筹动画和特效的调用
module("maze.MazeEffectExecutor", Class.impl())

function initRequireList(self)
    self.mIsLog = false
    maze.MazeBaseEffectExecuter = require('game/maze/executor/effect/MazeBaseEffectExecuter')  
    maze.MazeEffectExecuter_effect = require('game/maze/executor/effect/MazeEffectExecuter_effect')
    maze.MazeEffectExecuter_0 = require('game/maze/executor/effect/MazeEffectExecuter_0')
    maze.MazeEffectExecuter_1 = require('game/maze/executor/effect/MazeEffectExecuter_1')
    maze.MazeEffectExecuter_2 = require('game/maze/executor/effect/MazeEffectExecuter_2')
    maze.MazeEffectExecuter_3 = require('game/maze/executor/effect/MazeEffectExecuter_3')
end

function __print(self, str)
	if(self.mIsLog)then
		print(str)
	end
end

-- 创建唯一的粒子特效效果
function addNormalEffect(self, effectName, parentTrans, callFun)
    if (effectName) then
        self:removeNormalEffect(effectName)
    end
    local effectData = { effectSn = nil, effectName = nil, effectGo = nil }
    table.insert(self.mEffectList, effectData)
    local function _loadAysnCall(effectGo)
        if (effectGo) then
            local effectTrans = effectGo.transform
            effectData.effectGo = effectGo
            effectData.effectGo:SetActive(true)
            gs.TransQuick:SetParentOrg(effectTrans, parentTrans)
            if (localPosX and localPosY) then
                gs.TransQuick:LPosXY(effectTrans, 0, 0)
            end
            if (callFun) then
                callFun(true, effectData.effectGo)
            end
        else
            if (effectName) then
                self:removeNormalEffect(effectName)
            end
            if (callFun) then
                callFun(false, nil)
            end
        end
    end
    effectData.effectName = effectName
    effectData.effectSn = gs.GOPoolMgr:GetAsyc(maze.getEffectUrl(effectData.effectName), _loadAysnCall)
end

-- 移除唯一的粒子特效效果
function removeNormalEffect(self, effectName)
    if (self.mEffectList) then
        for i = #self.mEffectList, 1, -1 do
            local effectData = self.mEffectList[i]
            if effectData then
                if (effectName == nil or effectName == effectData.effectName) then
                    gs.GOPoolMgr:CancelAsyc(effectData.effectSn)
                    if (effectData.effectGo and not gs.GoUtil.IsGoNull(effectData.effectGo)) then
                        effectData.effectGo:SetActive(false)
                        gs.GOPoolMgr:Recover(effectData.effectGo, maze.getEffectUrl(effectData.effectName))
                    end
                    table.remove(self.mEffectList, i)
                    if (effectName ~= nil) then
                        return true
                    end
                end
            end
        end
        if (effectName == nil) then
            self.mEffectList = {}
            return true
        end
    else
        self.mEffectList = {}
    end
    return false
end

function getEffectDic(self)
	if(not self.mEffectDic)then
		self.mEffectDic = {}
	end
	return self.mEffectDic
end

function addEffect(self, effect)
    local dic = self:getEffectDic()
    if(dic and effect and effect:getSn())then
        dic[effect:getSn()] = effect
    end
end

function removeEffect(self, effect)
	local dic = self:getEffectDic()
	if(dic and effect and effect:getSn())then
		dic[effect:getSn()] = nil
		LuaPoolMgr:poolRecover(effect)
	end
end

-- 创建粒子特效效果（不指定父容器则默认添加在地板上）
function createParticleEffect(self, mazeId, tileId, prefabName, playTime, parentTrans, destroyCallFun)
    local effect = LuaPoolMgr:poolGet(maze.MazeEffectExecuter_effect)
    self:addEffect(effect)
    effect:setEffectCall(destroyCallFun)
    effect:startPlay(mazeId, tileId, prefabName, playTime, parentTrans)
    return effect
end

-- 创建表现特效效果
function createEffect(self, mazeId, data, eventConfigVo, delEventList, addEventList, updateEventList, updateTileList, callFun)
	local eventType = eventConfigVo:getEventType()
	local effect = nil
	if(eventType == maze.THING_TYPE_CANNON)then
		effect = LuaPoolMgr:poolGet(maze.MazeEffectExecuter_1)
        self:addEffect(effect)
		effect:setEffectCall(callFun)
		effect:startPlay(mazeId, data)
	elseif(eventType == maze.THING_TYPE_OBSTACLE_SWITCHER)then
		effect = LuaPoolMgr:poolGet(maze.MazeEffectExecuter_2)
        self:addEffect(effect)
		effect:setEffectCall(callFun)
		effect:startPlay(mazeId, updateEventList)
	elseif(eventType == maze.THING_TYPE_ROTARY_SWITCH) or (eventType == maze.EVENT_TYPE_ONECALL_DOOR) or (eventType == maze.EVENT_TYPE_ROTARY_SEND_DOOR_ONECALL) then
		effect = LuaPoolMgr:poolGet(maze.MazeEffectExecuter_3)
        self:addEffect(effect)
		effect:setEffectCall(callFun)
		effect:startPlay(mazeId, updateEventList)
    else
        -- 通用效果表现
		effect = LuaPoolMgr:poolGet(maze.MazeEffectExecuter_0)
        self:addEffect(effect)
		effect:setEffectCall(callFun)
		effect:startPlay(mazeId, delEventList, addEventList, updateEventList)
	end
    return effect
end

function resetEffect(self)
	if(self.mEffectDic)then
		for sn, effect in pairs(self.mEffectDic) do
			self:removeEffect(effect)
		end
	end
	self:removeNormalEffect()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
