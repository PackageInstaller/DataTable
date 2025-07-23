--[[   
     战斗UI
]]
module('fightUI.FightQueueView', Class.impl('lib.component.BaseNode'))

local ITEM_HEIGHT = 50
local ITEM_LINE_HEIGHT = 50
local MoveOffsetTime = 0.3

function initData(self, rootGo)
    super.initData(self, rootGo)
    self.m_queueContext = self:getChildTrans('QueueContext')
    self.mGroupQueueEff = self:getChildTrans('mGroupQueueEff')
    self.m_curQueueItemList = {}
    self.m_nextQueueItemList = {}
    self.m_maxCount = 5
    self.m_intervalDist = 20-- 68 --42+26
    -- contextX 90
    self.m_curLineUpPos = 0

    self.m_tweenList = {}
    self:updateMaxCount()
end

function updateMaxCount(self)
    -- local storageVal = StorageUtil:getBool1(gstor.FIGHT_QUEUE10)
    local storageVal = sysParam.SysParamManager:getValue(SysParamType.FIGHT_QUEUE10)
    if storageVal == 1 then
        self:setMaxCount(9, 2, 90)
        -- gs.TransQuick:LPosX(self.m_queueline, -20)
    else
        self:setMaxCount(5, 4, 108)
        -- gs.TransQuick:LPosX(self.m_queueline, -116)
    end
end

function setMaxCount(self, maxCnt, intervalDist, contextX)
    self.m_maxCount = maxCnt
    self.m_intervalDist = intervalDist
    -- gs.TransQuick:LPosX(self.m_queueContext, contextX)
    self:updateQueue()
end

function _getQueueItem(self, queueDatas, roleID)
    for j, v in ipairs(queueDatas) do
        if v:getHeroID() ~= nil and v:getHeroID() == roleID then
            table.remove(queueDatas, j)
            return v, true
        end
    end
    local live = fight.SceneManager:getThing(roleID)
    if live then
        local item = LuaPoolMgr:poolGet(fightUI.FightQueueItem)
        item:setup(UrlManager:getUIPrefabPath("fight/FightQueueItem.prefab"))
        if live:getRaceType() == 0 then
            item:setHeroID(roleID, live:isAttacker(), UrlManager:getHeroHeadUrlByModel(live:getModelID()))
        else
            local orgData = live:getOrgData()
            if orgData then
                item:setHeroID(roleID, live:isAttacker(), UrlManager:getIconPath(orgData.head))
            end
        end

        return item
    else
        print("no live ", roleID, fight.FightManager:parseUniqueID(roleID))
    end
end

function _getQueueFlag(self, queueDatas)
    for j, v in ipairs(queueDatas) do
        if v:getHeroID() == nil then
            v:removeEffect()
            table.remove(queueDatas, j)
            return v, true
        end
    end
    local icon = LuaPoolMgr:poolGet(fightUI.FightQueueIcon)
    icon:setup(UrlManager:getUIPrefabPath("fight/FightQueueIcon.prefab"))
    return icon
end

function updateQueue(self)
    self:removeEffect("fx_ui_fightQueue_round", self.mGroupQueueEff)

    local roleIDList = fight.FightManager:getCurRoleList()
    local nextRoleIDList = fight.FightManager:getNextRoleList()
    for i, v in ipairs(self.m_tweenList) do
        v:Kill()
    end
    self.m_tweenList = {}

    local showCnt = 0
    local curQueue = self.m_curQueueItemList
    self.m_curQueueItemList = {}
    self.m_curLineUpPos = 0
    local cnt = #roleIDList

    -- 当前回合
    for i = 2, cnt do
        local beFind = false
        local roleID = roleIDList[i]
        local item, isExist = self:_getQueueItem(curQueue, roleID, i)
        if item then
            table.insert(self.m_curQueueItemList, item)
            if isExist then
                self:_moveOffset(item:getTrans(), (i - 2) * (self.m_intervalDist + ITEM_HEIGHT))
            else
                item:setLayerTrans(self.m_queueContext, (i - 2) * (self.m_intervalDist + ITEM_HEIGHT))
            end
            item:setIndex(i)
            showCnt = showCnt + 1
            self.m_curLineUpPos = self.m_curLineUpPos + self.m_intervalDist + ITEM_HEIGHT
            if showCnt == self.m_maxCount then
                break
            end
        end
    end

    -- 回合分割线
    if not table.empty(nextRoleIDList) and showCnt < self.m_maxCount then
        if cnt > 1 then
            local icon, isExist = self:_getQueueFlag(curQueue)
            -- icon:setImg(UrlManager:getFightUIPath("fight_icon_9.png"))
            icon:nextFlag()
            table.insert(self.m_curQueueItemList, icon)
            local offset = self.m_curLineUpPos + (15 - icon:getHeight()) * 0.5
            if isExist then
                self:_moveOffset(icon:getTrans(), offset)
            else
                icon:setLayerTrans(self.m_queueContext, offset)
            end
            self.m_curLineUpPos = self.m_curLineUpPos + self.m_intervalDist + 15
        else
            self:addEffect("fx_ui_fightQueue_round", self.mGroupQueueEff)
        end

        -- 下一回合队列
        for _, roleID in ipairs(nextRoleIDList) do
            local item, isExist = self:_getQueueItem(curQueue, roleID)
            if item then
                table.insert(self.m_curQueueItemList, item)
                if isExist then
                    self:_moveOffset(item:getTrans(), self.m_curLineUpPos)
                else
                    item:setLayerTrans(self.m_queueContext, self.m_curLineUpPos)
                end
                self.m_curLineUpPos = self.m_curLineUpPos + self.m_intervalDist + ITEM_HEIGHT
                showCnt = showCnt + 1
                if showCnt == self.m_maxCount then
                    break
                end
            end
        end
    end

    -- 补空格子
    if (showCnt < self.m_maxCount) then
        for i = showCnt + 1, self.m_maxCount do
            local icon, isExist = self:_getQueueFlag(curQueue)
            icon:setImg(UrlManager:getFightUIPath("fight_icon_1.png"))
            table.insert(self.m_curQueueItemList, icon)
            if isExist then
                self:_moveOffset(icon:getTrans(), self.m_curLineUpPos)
            else
                icon:setLayerTrans(self.m_queueContext, self.m_curLineUpPos)
            end
            self.m_curLineUpPos = self.m_curLineUpPos + self.m_intervalDist + ITEM_LINE_HEIGHT
        end
    end

    -- 清空多余Item
    for _, v in ipairs(curQueue) do
        if v:getHeroID() == nil then
            LuaPoolMgr:poolRecover(v)
        else
            local function _tweenFinish()
                LuaPoolMgr:poolRecover(v)
            end
            local livethingVo = fight.SceneManager:getThing(v:getHeroID())
            if livethingVo and not livethingVo:isDead() then
                TweenFactory:move2Lpos(v:getTrans(), math.Vector3(31, -110, 0), 0.3, nil, _tweenFinish)
            else
                TweenFactory:move2LPosX(v:getTrans(), -30, 0.3, nil, _tweenFinish)
            end
        end
    end
end

function setActiveItem(self, heroID, side)

end

function _moveOffset(self, trans, offset)
    local tween = trans:DOMoveUIY(offset, MoveOffsetTime)
    local function _finishCall()
        for i, v in ipairs(self.m_tweenList) do
            if v == tween then
                table.remove(self.m_tweenList, i)
            end
        end
    end
    tween:OnComplete(_finishCall)
    table.insert(self.m_tweenList, tween)
end

function _setPosition(self, trans, x)
    gs.TransQuick:UIPos(trans, x, 0)
end

function _removeLineItem(self)
    local lineGO = self.m_nextQueueItemList[1]
    if lineGO then
        gs.GameObject.Destroy(lineGO)
        table.remove(self.m_nextQueueItemList, 1)
        return true
    end
    return false
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]