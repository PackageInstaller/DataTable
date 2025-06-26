module('storyTalk.StoryTalkManager', Class.impl(Manager))

function ctor(self)
    super.ctor(self)
    -- gs.StoryPlayMaker:SetLuaTable(storyTalk.StoryPlayMaker)
    -- 已经播放过的剧情ID列表
    self.m_passStoryList = {}
    -- 剧情数据
    self.m_storyDict = nil

    self.m_curStoryRo = nil
    self.m_isAutoPass = false

    self:_parseData()

    self.m_storyHeroDict = {}
    self.m_tmpHideModel = {}

    self.m_getPlay = false

    self.isEditor = false

    self.notAllowedPlay = false
end

-- Override 重置数据
function resetData(self)
    self.m_passStoryList = {}
    self.m_passStorySetuped = nil
    self.notAllowedPlay = false
end

function setNotAllowdPlay(self, canPlay)
    self.notAllowedPlay = canPlay
end

function getNotAllowdPlay(self)
    return self.notAllowedPlay
end

-- 当前是否存在剧情内容
function getCurHasStory(self)
    return self.m_curStoryRo ~= nil
end

function setIsEditor(self, isEditor)
    self.isEditor = isEditor
end

function getIsEditor(self)
    return self.isEditor
end

-- 需要进行CR标志的人名替换
function crForTalkerName(self, doubtCR, curStoryRo)
    local index = nil

    if doubtCR == "CR1" then
        index = 1
    elseif doubtCR == "CR2" then
        index = 2
    elseif doubtCR == "CR3" then
        index = 3
    elseif doubtCR == "CR4" then
        index = 4
    elseif doubtCR == "CR5" then
        index = 5
    else
        return doubtCR
    end
    local vo = formation.FormationDistributeManager:getMonsterConfigVoByStory(curStoryRo:getBattleType(),
        curStoryRo:getBattleFieldId(), 1, index)
    if vo then
        return vo.name
    end
    return ""
end

-- 纯剧情关卡调用
function justStoryNoFight(self, battleType, fieldID, finishCall)
    fight.FightManager:setBattleData(battleType, fieldID)
    return storyTalk.StoryTalkCondition:condition09(battleType, fieldID, finishCall)
end

function addStoryHero(self, storyID, talkID, hero)
    -- print("addStoryHero", storyID, talkID, hero)
    local sTalkDict = self.m_storyHeroDict[storyID]
    if not sTalkDict then
        sTalkDict = {}
        self.m_storyHeroDict[storyID] = sTalkDict
    end
    local tHeroList = sTalkDict[talkID]
    if not tHeroList then
        tHeroList = {}
        sTalkDict[talkID] = tHeroList
    end
    table.insert(tHeroList, hero)
end

-- 其实就是触发条件3的处理
function tryEnterHero(self, storyID, talkID, finishCall)
    local sTalkDict = self.m_storyHeroDict[storyID]
    if not sTalkDict then
        if finishCall then
            finishCall()
        end
        return
    end
    local tHeroList = {}
    for talkID, hero in pairs(sTalkDict) do
        table.insert(tHeroList, hero)
    end
    -- local tHeroList = sTalkDict[talkID]
    if table.empty(tHeroList) then
        if finishCall then
            finishCall()
        end
        return
    end
    local liveIDs = {}
    local function _enterHero()
        local hero = tHeroList[1]
        if hero then
            table.remove(tHeroList, 1)
            table.insert(liveIDs, hero.id)
            fight.FightLoader:loadHeroLive(hero.__side, hero, false, _enterHero)
        else
            fight.FightLoader:loadEnterSceneList(liveIDs, finishCall)
        end
    end
    self.m_storyHeroDict[storyID] = nil
    local tmpLst = table.copy(tHeroList)
    _enterHero()
    return true, tmpLst
end

function switchFinishCall(self, beSuccessFlag)
    if self.m_curStoryRo == nil then
        return
    end
    -- print("switchFinishCall==", beSuccessFlag, self.m_talkFinishCall)
    local function _finishCall()
        if beSuccessFlag == true and self.m_curStoryRo then
            storyTalk.StoryTalkManager:reqSTORY_OVER(self.m_curStoryRo:getRefID())
            storyTalk.StoryTalkCondition:storyCallback(self.m_curStoryRo:getHappenType(), true, self.m_curStoryRo)

            if guide.GuideCondition:condition01(self.m_curStoryRo:getRefID()) then
                self.m_curStoryRo = nil
                return
            end
            guide.GuideCondition:condition03(self.m_curStoryRo:getRefID())
            self.m_curStoryRo = nil
        end
    end
    if self.m_curStoryRo:getEffectType() == 2 or self.m_curStoryRo:getEffectType() == 13 then
        local tids = self.m_curStoryRo:getEffectParam()
        if not table.empty(tids) then
            local heroNames = {}
            for _, tid in ipairs(tids) do
                local tmpVo = monster.MonsterManager:getMonsterVo(tid)
                if tmpVo then -- 魔力转圈圈
                    local mVo = monster.MonsterManager:getMonsterVo01(tmpVo.tid)
                    if mVo then
                        table.insert(heroNames, mVo.name)
                    end
                end
            end
            if not table.empty(heroNames) then
                gs.Message.Show(_TT(72201, table.concat(heroNames, ",")))
            end
        end
    end
    storyTalk.StoryTalkManager:tryEnterHero(self.m_curStoryRo:getRefID(), nil, _finishCall)
end

-- 初始化配置表
function _parseData(self)
    self.m_storyDict = {}
    self.m_perfabDict = {}

    local baseData = RefMgr:getData('story_data', self.isEditor)
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(storyTalk.StoryDataRo)
        ro:parseData(key, data)
        self.m_storyDict[key] = ro
    end

    local prefabData = RefMgr:getData('story_prefab_data')
    for key, data in pairs(prefabData) do
        local ro = LuaPoolMgr:poolGet(storyTalk.StoryPrefabRo)
        ro:parseData(key, data)
        self.m_perfabDict[key] = ro
    end

    --self:parsePlayData()
end

function debugStoryDFA(self)
    if self.m_storyDict == nil then
        self:_parseData()
    end
    gs.DFAUtil.InitDFA()

    local keys = table.keys(self.m_storyDict)
    table.sort(keys)

    for _, v in ipairs(keys) do
        local ro = self.m_storyDict[v]
        local group = ro:getTalkGroup()
        for id, talkData in pairs(group) do
            gs.DFAUtil.DebugBuilerString(talkData.msg, v, id)
        end
    end

    gs.DFAUtil.CreateLogs()
end

-- 解析玩法的剧情表
function parsePlayData(self)
    local playData = RefMgr:getData('story_play_data')
    for key, data in pairs(playData) do
        local ro = LuaPoolMgr:poolGet(storyTalk.StoryDataRo)
        ro:parseData(key, data)
        self.m_storyDict[key] = ro
    end
    self.m_getPlay = true
end

-- 获取对应剧情数据的效果参数
function getStoryParamByEffectType(self, battleType, dupId, effectType)
    self:storyRos()
    for k, v in pairs(self.m_storyDict) do
        if (v:getBattleType() == battleType and v:getBattleFieldId() == dupId and v:getEffectType() == effectType) then
            return v:getEffectParam()
        end
    end
    return nil
end

-- 获取所有有效的剧情数据
function storyRos(self)
    if self.m_storyDict == nil then
        self:_parseData()
    end
    return self.m_storyDict
end

function getStoryRo(self, storyID)
    self:storyRos()
    local ro = self.m_storyDict[storyID]

    if ro == nil then
        logError("StoryTalkManager", "不存在storyID: " .. storyID)
    end
    return ro
end

-- 获取对应剧情数据的效果参数
function getStoryPrefab(self, prefabName)
    if self.m_perfabDict == nil then
        self:_parseData()
    end
    return self.m_perfabDict[prefabName]
end

-- 仅在编辑器下使用 会使用新数据覆盖原有的
function getStoryRoByNew(self, storyID)
    self:_parseData()
    local ro = self.m_storyDict[storyID]
    if storyID == nil then
        logError("StoryTalkManager", "storyID (剧情ID) 为空")
    elseif ro == nil then
        logError("StoryTalkManager", "不存在storyID：" .. tostring(storyID) .. "， 请检查 story_data.lua 是否存在id")
    end
    return ro
end

function lanuchFirstStory(self)
    if self.m_passStorySetuped == true then
        if table.empty(self.m_passStoryList) then
            return true
        end
    end
end

-- 记录已完成的对话剧情
function setPassStoryIds(self, ids)
    self.m_passStorySetuped = true
    -- for _,id in ipairs(ids) do
    --     local ro = self.m_storyDict[id]
    --     if ro then
    --         LuaPoolMgr:poolRecover(ro)
    --         self.m_storyDict[id] = nil
    --     end
    -- end
    if table.empty(ids) then
        self.m_passStoryList = {}
    else
        for _, v in ipairs(ids) do
            self.m_passStoryList[v.line_id] = v.story_id
        end
    end
    -- if not guide.GuideManager:isPassFirstGuide() then
    --     self.m_passStoryList = {}
    -- end

    -- storyTalk.StoryTalkCondition:condition00()
end

function clearPassStory(self, lineID)
    self.m_passStoryList[lineID] = nil
end

-- 判断对话是否可播放
function canPlayStory(self, storyID)
    local tmpRo = self:getStoryRo(storyID)
    if tmpRo then
        if tmpRo:getIsRepeat() == 1 then
            return true
        end
        local sID = self.m_passStoryList[tmpRo:getLineID()]
        if sID and sID >= storyID then
            return false
        end

        if StorageUtil:getString0('login_guide') == "1" then
            return false
        end

        return true
    end
    print("没有剧情 ", storyID)
    return false
end

-- 判断对话是否能跳过
function canPassStory(self, storyID)
    local tmpRo = self:getStoryRo(storyID)
    if tmpRo then
        if tmpRo:getCanPass() == 2 then
            return false
        end
        if tmpRo:getCanPass() == 0 then
            -- 说明未播过的
            local sID = self.m_passStoryList[tmpRo:getLineID()]
            if sID and sID < storyID then
                return false
            end
        end
        return true
    end
    return true
end

-- 是否可以加速
function canSpeedUp(self, storyID)
    local tmpRo = self:getStoryRo(storyID)
    if tmpRo then
        return tmpRo:getCanSpeedUp() == 1
    else
        return false
    end
end

-- 是否播放过的剧情
function isPassStory(self, storyID)
    local tmpRo = self:getStoryRo(storyID)
    if tmpRo then
        local sID = self.m_passStoryList[tmpRo:getLineID()]
        if sID and sID >= storyID then
            return true
        end
    end
    return false
end

function setCurStoryID(self, storyID)
    if self:canPlayStory(storyID) then
        self.m_curStoryRo = self:getStoryRo(storyID)
        return true
    end
    self.m_curStoryRo = nil
    return false
end

function getCurStoryRo(self)
    return self.m_curStoryRo
end

function setAutoPass(self, beAuto)
    self.m_isAutoPass = beAuto
end

function isAutoPass(self)
    return self.m_isAutoPass
end

-- 隐藏正常的战斗模型
function hideSceneModel(self)
    if table.empty(self.m_tmpHideModel) then
        local _dic = fight.SceneManager:getAllThing()
        for _, vo in pairs(_dic) do
            if vo:getVisibleByCamera() == true then
                table.insert(self.m_tmpHideModel, vo)
                vo:setVisible(false)
            end
        end
    end
end

-- 显示正常的战斗模型
function showSceneModel(self)
    if table.empty(self.m_tmpHideModel) then
        return
    end
    for _, vo in ipairs(self.m_tmpHideModel) do
        vo:setVisible(true)
    end
    self.m_tmpHideModel = {}
end

-- 通知服务器剧情播放完
function reqSTORY_OVER(self, storyID)
    local ro = self.m_storyDict[storyID]
    if ro then
        if self.m_passStoryList[ro:getLineID()] ~= nil and self.m_passStoryList[ro:getLineID()] >= storyID then
            return
        end

        SOCKET_SEND(Protocol.CS_STORY_OVER, {story_id = storyID }) 
        self.m_passStoryList[ro:getLineID()] = storyID
        print("reqSTORY_OVER ============ ", storyID)
    end
end

local OTHER_UI_LAYER = { "SCENE", "MAIN_UI", "POP", "SUB_POP" }
-- 对剧情对话外的其它UI设置可见状态
function setVisibleOtherUI(self, beVisible)
    for _, value in ipairs(OTHER_UI_LAYER) do
        local trans = GameView.UINode[value]
        if trans and not gs.GoUtil.IsTransNull(trans) then
            trans.gameObject:SetActive(beVisible)
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
