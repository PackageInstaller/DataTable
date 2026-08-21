module("ghost.GhostGamePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("ghost/GhostGamePanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isBlur = 0
escapeClose = 0 -- 是否能通过esc关闭窗口
isShowCloseAll = false
-- 构造函数
function ctor(self)
    super.ctor(self)
    -- self:setTxtTitle(_TT(149186))
    -- self:setSize(0, 0)
    -- self:setBg("guild_bg.jpg", false, "guild")
    -- self:setUICode(LinkCode.GuildWar)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mScore = 0 -- 分数
    self.mGameItemDic = {}
    self.mPosDic = {}
    self:initIdx()
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.m_startView = ghost.GhostStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))
    self.mTxtTargetGame = self:getChildGO("mTxtTargetGame"):GetComponent(ty.Text)
    self.mTxtScoreGame = self:getChildGO("mTxtScoreGame"):GetComponent(ty.Text)
    self.mBtnPause = self:getChildGO("mBtnPause")
    self.mBtnSkill = self:getChildGO("mBtnSkill")

    self.mGroupPause = self:getChildGO("mGroupPause")
    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mBtnFinish = self:getChildGO("mBtnFinish")
    self.mBtnReplay = self:getChildGO("mBtnReplay")
    self.mBtnPlay = self:getChildGO("mBtnPlay")

    self.mTxtCurrentScore = self:getChildGO("mTxtCurrentScore"):GetComponent(ty.Text)
    self.mTxtTargetScore = self:getChildGO("mTxtTargetScore"):GetComponent(ty.Text)
    self.mIsTarget = self:getChildGO("mIsTarget")

    self.mIsTargetNot = self:getChildGO("mIsTargetNot")
    self.mGameItem = self:getChildGO("mGameItem")
    self.mGameItem:SetActive(false)

    self.mContentDic = {}
    for i = 1, 16, 1 do
        self.mContentDic[i] = self:getChildTrans("content" .. i)
    end
    self.mCreateContent = self:getChildTrans("mCreateContent")
end

function initViewText(self)

end

-- 激活
function active(self, args)
    super.active(self, args)
    self.dupId = args.dupId
    MoneyManager:setMoneyTidList({})
    local function _finishCall()
        self.m_startView:setActive(false)
        self:showPanel()
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)
    self:initGameData()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearAll()
end


function clearAll(self)
    for k, v in pairs(self.mPosDic) do
        self.mPosDic[k].item:poolRecover()
    end
    self.mPosDic = {}

    if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPause, self.onClickPause)

    self:addUIEvent(self.mBtnExit, self.onClickExit)
    self:addUIEvent(self.mBtnFinish, self.onClickFinish)
    self:addUIEvent(self.mBtnReplay, self.onClickReplay)
    self:addUIEvent(self.mBtnPlay, self.onClickPlay)
end

function onClickFinish(self)
    self.mGroupPause:SetActive(false)
    self:onGameEnd()
end

function onClickExit(self)
    self:close()
end


function onClickReplay(self)
    self.isPasue = false
    self.mGroupPause:SetActive(false)
    local function _finishCall()
        self.m_startView:setActive(false)
        self:showPanel()
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)
    self:clearAll()
    self:initGameData()
end

function onClickPlay(self)
    self.isPasue = false
    self.mGroupPause:SetActive(false)
end

function onClickPause(self)
    if self.gameData.targetScore <= self.mScore then
        self.mBtnFinish:SetActive(true)
        self.mBtnExit:SetActive(false)
        -- self.mBtnReplay:SetActive(false)
    else
        self.mBtnFinish:SetActive(false)
        self.mBtnExit:SetActive(true)
    end

    -- self.mBtnFinish:SetActive(true)
    -- self.mBtnExit:SetActive(true)
    self.isPasue = true
    self.mGroupPause:SetActive(true)

    self.mTxtCurrentScore.text = _TT(151209) .. self.mScore
    self.mTxtTargetScore.text = _TT(151208) .. self.gameData.targetScore
    self.mIsTarget:SetActive(self.gameData.targetScore <= self.mScore)
    self.mIsTargetNot:SetActive(self.gameData.targetScore > self.mScore)
end

function initGameData(self)
    self.isFirstFinish = false
    self.isEnd = false
    self.isPasue = false
    self.mScore = 0
    self.mTxtScoreGame.text = self.mScore

    self.gameData = ghost.GhostManager:getGhostDataById(self.dupId)
    self.mTxtTargetGame.text = self.gameData.targetScore

    self.waveList = self.gameData.waveList
    for k, v in pairs(self.waveList) do
        if v.icon_id ~= 0 then
            local item = SimpleInsItem:create(self.mGameItem, self.mContentDic[k], "mGameItem")
            item:getChildGO("mGroupItem"):GetComponent(ty.AutoRefImage):SetImg(
                UrlManager:getIconPath("ghost/level" .. v.icon_id .. ".png"), false)
            item:getChildGO("mTxtLevel"):GetComponent(ty.Text).text = v.icon_id
            gs.TransQuick:UIPos(item:getGo():GetComponent(ty.RectTransform), 0, 0)
            --item:getChildGO("mIsNew"):SetActive(false)
            -- item.m_go.transform:SetParent(self.mCreateContent,false)
            self.mPosDic[k] = {
                item = item,
                level = v.icon_id,
                oldPos = k,
                newPos = k,
                isComNew = false
            }
        end
    end
end

function showPanel(self)
    if self.gameSn ~= nil then
        LoopManager:removeFrameByIndex(self.gameSn)
        self.gameSn = nil
    end
    self.gameSn = LoopManager:addFrame(0, 0, self, self.updateGame)
end

function updateGame(self)
    if self.isPasue or self.isEnd then
        return
    end

    if gs.Input.GetMouseButtonDown(0) then
        self.downPos = gs.Input.mousePosition
        self.isDonw = true
    elseif self.downPos and gs.Input.GetMouseButtonUp(0) then
        self.isdown = false
        local curPos = gs.Input.mousePosition

        local tempX = curPos.x - self.downPos.x
        local tempY = curPos.y - self.downPos.y

        if tempX > 0 then
            local x = math.abs(tempX)
            local y = math.abs(tempY)
            if tempY > 0 then
                if x > y then
                    self.dir = ghost.GhostDir.Right
                else
                    self.dir = ghost.GhostDir.Top
                end
            else
                if x > y then
                    self.dir = ghost.GhostDir.Right
                else
                    self.dir = ghost.GhostDir.Bottom
                end
            end
        else
            local x = math.abs(tempX)
            local y = math.abs(tempY)
            if tempY > 0 then
                if x > y then
                    self.dir = ghost.GhostDir.Left
                else
                    self.dir = ghost.GhostDir.Top
                end
            else
                if x > y then
                    self.dir = ghost.GhostDir.Left
                else
                    self.dir = ghost.GhostDir.Bottom
                end
            end
        end
        self:runDir()
    end
end

function initIdx(self)
    self.leftIdx1 = {1, 2, 3, 4}
    self.leftIdx2 = {5, 6, 7, 8}
    self.leftIdx3 = {9, 10, 11, 12}
    self.leftIdx4 = {13, 14, 15, 16}
    self.leftIdx = {self.leftIdx1, self.leftIdx2, self.leftIdx3, self.leftIdx4}

    self.rightIdx1 = {4, 3, 2, 1}
    self.rightIdx2 = {8, 7, 6, 5}
    self.rightIdx3 = {12, 11, 10, 9}
    self.rightIdx4 = {16, 15, 14, 13}
    self.rightIdx = {self.rightIdx1, self.rightIdx2, self.rightIdx3, self.rightIdx4}

    self.topIdx1 = {1, 5, 9, 13}
    self.topIdx2 = {2, 6, 10, 14}
    self.topIdx3 = {3, 7, 11, 15}
    self.topIdx4 = {4, 8, 12, 16}
    self.topIdx = {self.topIdx1, self.topIdx2, self.topIdx3, self.topIdx4}

    self.bottomIdx1 = {13, 9, 5, 1}
    self.bottomIdx2 = {14, 10, 6, 2}
    self.bottomIdx3 = {15, 11, 7, 3}
    self.bottomIdx4 = {16, 12, 8, 4}
    self.bottomIdx = {self.bottomIdx1, self.bottomIdx2, self.bottomIdx3, self.bottomIdx4}
end

function checkCanMove(self, dir)
    local runIdxList = {}
    if dir == ghost.GhostDir.Left then
        runIdxList = self.leftIdx
    elseif dir == ghost.GhostDir.Right then
        runIdxList = self.rightIdx
    elseif dir == ghost.GhostDir.Top then
        runIdxList = self.topIdx
    elseif dir == ghost.GhostDir.Bottom then
        runIdxList = self.bottomIdx
    end
    local canMove = false
    -- 存在任何空位并且后面还有内容的就可以移动
    for a = 1, #runIdxList do
        for b = 1, #runIdxList[a] - 1 do
            if self.mPosDic[runIdxList[a][b]] == nil then
                for c = b + 1, #runIdxList[a] do
                    if self.mPosDic[runIdxList[a][c]] ~= nil then
                        canMove = true
                        break
                    end
                end
            end
        end
    end

    -- 没有任何空位并且但是有相同并且相邻的就可以移动
    if canMove == false then
        for a = 1, #runIdxList do
            for b = 1, #runIdxList[a] - 1 do
                if self.mPosDic[runIdxList[a][b]] ~= nil and self.mPosDic[runIdxList[a][b + 1]] ~= nil and
                    self.mPosDic[runIdxList[a][b]].level == self.mPosDic[runIdxList[a][b + 1]].level and self.mPosDic[runIdxList[a][b]].level < 10 then
                    canMove = true
                    break
                end
            end
        end
    end
    return canMove, runIdxList
end

function runDir(self)

    local canMove, runIdxList = self:checkCanMove(self.dir)

    if canMove == false then
        -- gs.Message.Show("不能移动")
        return
    else
        -- gs.Message.Show("可以移动")
        self:gameMove(runIdxList)
        return
    end
end

function gameMove(self, runIdxList)

    for a = 1, #runIdxList do
        local neeCom = true
        local isNext = false
        -- 只要有合成成功的需要继续执行一遍逻辑 可能会多次合成
        while neeCom do
            isNext = true
            local tempList = {}
            for b = 1, #runIdxList[a] do
                -- 存储临时数据 --丢弃掉合成的数据
                if self.mPosDic[runIdxList[a][b]] ~= nil and self.mPosDic[runIdxList[a][b]].isComNew == false then
                    table.insert(tempList, self.mPosDic[runIdxList[a][b]])
                end
            end
            local comNum = 0
            for b = 1, #tempList do
                local data = self.mPosDic[tempList[b].oldPos]
                data.newPos = runIdxList[a][b - comNum]
                if isNext then
                    if tempList[b + 1] ~= nil and tempList[b].level == tempList[b + 1].level and tempList[b].level < 10 then
                        self:onReqEvent(data.level+1)
                        data.level = data.level + 1
                        data.item.m_go:GetComponent(ty.Animator):SetTrigger("levelup")
                        tempList[b + 1].isComNew = true                  
                        comNum = comNum + 1
                        isNext = false
                    end
                else
                    -- 等待下一次合成
                end
            end
            neeCom = comNum > 0
        end
    end

    local removeKey = {}
    for k, v in pairs(self.mPosDic) do
        local item = v.item
        item.m_trans:SetParent(self.mContentDic[v.newPos])
        TweenFactory:move2Lpos(item:getGo():GetComponent(ty.RectTransform), gs.VEC3_ZERO, 0.2)

        if v.isComNew then
            table.insert(removeKey, k)
        end

        local vo = ghost.GhostManager:getGhostItemData(v.level)
        item:getChildGO("mTxtLevel"):GetComponent(ty.Text).text = v.level
        item:getChildGO("mGroupItem"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath("ghost/level" .. v.level .. ".png"),
            false)
        --item:getChildGO("mIsNew"):SetActive(false)
    end

    for i = 1, #removeKey do
        self:getScore(self.mPosDic[removeKey[i]].level)
        self.mPosDic[removeKey[i]].item:poolRecover()
        self.mPosDic[removeKey[i]] = nil
    end

    if #removeKey > 0 then
        AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_ghost_2.prefab")
    end
    
    self.newDic = {}
    for k, v in pairs(self.mPosDic) do
        self.newDic[v.newPos] = {
            item = v.item,
            oldPos = v.newPos,
            newPos = v.newPos,
            level = v.level,
            isComNew = false
        }
    end
    self.mPosDic = self.newDic
    AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_ghost_1.prefab")

    self:createNewItem()
end

function onReqEvent(self,level)
    GameDispatcher:dispatchEvent(EventName.REQ_GHOST_EVENT,level)
end

function getScore(self,level)
    local vo = ghost.GhostManager:getGhostItemData(level)
    self.mScore = self.mScore + vo.score
    self.mTxtScoreGame.text = self.mScore

    if self.mScore >= self.gameData.targetScore and self.isFirstFinish == false then
        self.isFirstFinish = true
        self:onClickPause()
 
    end
end

function createNewItem(self)
    local nilList = {}
    for i = 1, 16 do
        if self.mPosDic[i] == nil then
            table.insert(nilList, i)
        end
    end

    -- if #nilList == 0 then
    --     self:onGameEnd()
    --     return
    -- end
    local random = math.random(#nilList)
    local ranPos = nilList[random]

    local valueList = {1, 2}
    random = math.random(#valueList)
    local randomValue = valueList[random]

    local item = SimpleInsItem:create(self.mGameItem, self.mContentDic[ranPos], "mGameItem")
    item:getChildGO("mGroupItem"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath("ghost/level" .. randomValue .. ".png"),
        false)
    item:getChildGO("mTxtLevel"):GetComponent(ty.Text).text = randomValue
    --item:getChildGO("mIsNew"):SetActive(true)
    gs.TransQuick:UIPos(item:getGo():GetComponent(ty.RectTransform), 0, 0)
    -- item.m_go.transform:SetParent(self.mCreateContent,false)

    self.mPosDic[ranPos] = {
        item = item,
        level = randomValue,
        oldPos = ranPos,
        newPos = ranPos,
        isComNew = false
    }

    local gameEnd = true
    for i = 1, 4, 1 do
        gameEnd = not self:checkCanMove(i) and gameEnd
    end
    if gameEnd then
        self:onGameEnd()
    end
end

function onGameEnd(self)
    self.isEnd = true

    local his = ghost.GhostManager:getDupPassStar(self.dupId)
    local isPass = ghost.GhostManager:getDupPassState(self.dupId)
    local isFirst = false
    if self.mScore >= self.gameData.targetScore and isPass == false then
        isFirst = true
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_GHOST_SETTLE_PANEL, {
        dupId = self.dupId,
        score = self.mScore,
        first = isFirst
    })
end

return _M
