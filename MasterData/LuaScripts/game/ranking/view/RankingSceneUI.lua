-- @FileName:   RankingSceneUI.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-07-03 17:48:19
-- @Copyright:   (LY) 2024 锚点降临

module('game.ranking.view.RankingSceneUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("ranking/RankingSceneUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isBlur = 0
escapeClose = 0 -- 是否能通过esc关闭窗口
isShowCloseAll = false

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(750, 600)
    -- self:setBg("")
    -- self:setTxtTitle(_TT(138601))
    self:setUICode(LinkCode.Ranking)
end

function initData(self)

end

-- 初始化
function configUI(self)
    self.m_startView = fightUI.FightStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)

    self.mBtnPause = self:getChildGO("mBtnPause")
    self.mGroupPause = self:getChildGO("mGroupPause")
    self.mGroupStar = self:getChildTrans("mGroupStar")
    self.mBtnReplay = self:getChildGO("mBtnReplay")
    self.mBtnPlay = self:getChildGO("mBtnPlay")
    self.mBtnExit = self:getChildGO("mBtnExit")

    self.mImgStart = self:getChildGO("mImgStart")
    self.mImgPause = self:getChildGO("mImgPause")

    self.cardItem = self:getChildGO("cardItem")
    self.mTextStepCount = self:getChildGO("mTextStepCount"):GetComponent(ty.Text)
    self.mTextYesCount = self:getChildGO("mTextYesCount"):GetComponent(ty.Text)

    self.up_layer = self:getChildTrans("up_layer")
    self.bottom_layer = self:getChildTrans("bottom_layer")

    self.mStarLayer = self:getChildTrans("mStarLayer")
    self.mStarItem = self:getChildGO("mStarItem")

    self.mEditorToggleGo = self:getChildGO("mEditorToggle")
    self.mEditorToggle = self.mEditorToggleGo:GetComponent(ty.Toggle)

end

function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPause, self.onPauseClick)

    self:addUIEvent(self.mBtnReplay, self.onReplayClick)
    self:addUIEvent(self.mBtnPlay, self.onPlayClick)
    self:addUIEvent(self.mBtnExit, self.onExitClick)
end

--激活
function active(self, args)
    super.active(self)

    self:AddEventListener()

    if self:getTeachingState() then
        self:onOpenTeaching(args)
    else
        self:refreshView(args)
    end

    self:refreshPauseState(false)

    self.mGroupPause:SetActive(false)
    self.cardItem:SetActive(false)
    self.mStarItem:SetActive(false)

    self.mTextStepCount.text = _TT(151102, "-")
    self.mTextYesCount.text = _TT(151103, "-", "-")

    if GameManager.IS_DEBUG and not GameManager.HIDE_DEBUG_INFO then
        self.mEditorToggleGo:SetActive(true)
        self.mEditorToggle.isOn = false

        local onToggle = function (val)
            self:onEditorToggle(val)
        end
        self.mEditorToggle.onValueChanged:AddListener(onToggle)
    else
        self.mEditorToggleGo:SetActive(false)
    end
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:RemoveEventListener()

    self:clearData(true)
end

function clearData(self, deActive)
    self.m_DupConfigVo = nil

    self.bottomCardDic = nil
    self.upCardDic = nil

    self:clearPassStar()
    self:clearCard()
end

function AddEventListener(self)
    GameDispatcher:addEventListener(EventName.RANKING_UPDATE_PAUSESTATE, self.refreshPauseState, self)
end

function RemoveEventListener(self)
    GameDispatcher:removeEventListener(EventName.RANKING_UPDATE_PAUSESTATE, self.refreshPauseState, self)
end

function getTeachingState(self)
    local lasetClickRedDt = StorageUtil:getNumber1(gstor.RANKING_TEACHINGSTATE)
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.Ranking)
    if activityVo and lasetClickRedDt < activityVo.startTime then
        return true
    end

    return false
end

-- 打开教学
function onOpenTeaching(self, args)
    GameDispatcher:dispatchEvent(EventName.OPEN_RANKING_TEACHINGVIEW, {closeCall = function ()
        self:refreshView(args)
    end})
    StorageUtil:saveNumber1(gstor.RANKING_TEACHINGSTATE, GameManager:getClientTime())
end

function onEditorToggle(self, val)
    for k, card_item in pairs(self.m_cardItemList) do
        if card_item.editorCall then
            card_item:editorCall(val)
        end
    end
end

function refreshView(self, args)
    self:clearData()

    self.m_DupConfigVo = args

    local function _finishCall()
        self.m_startView:setActive(false)

        self:onStartGame()
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)
end

function onStartGame(self)
    self:createCard()

    self:refreshYesCount()
    self:refreshPassStar()
    self:refreshStepCount()
end

function createCard(self)
    local cardCount = self.m_DupConfigVo.game_parameter_list[1][1]--卡牌对数
    local yesCount = self.m_DupConfigVo.game_parameter_list[1][2]--初始对的卡牌对数
    self.m_allStepCount = self.m_DupConfigVo.game_parameter_list[1][3] --总步数

    self.bottomCardDic = {}
    self.upCardDic = {}
    for i = 1, cardCount do
        self.bottomCardDic[i] = 0
        self.upCardDic[i] = 0
    end

    local function getRandomIndex(table_list)
        local randomIndex = math.random(1, cardCount)
        local vl = true
        for _, tab in pairs(table_list) do
            if tab[randomIndex] ~= 0 then
                vl = false
                break
            end
        end

        if vl then
            return randomIndex
        else
            return getRandomIndex(table_list)
        end
    end

    --先随机初始正确的卡牌组
    local cardConfigList = table.copy(self.m_DupConfigVo.game_parameter_list[2])
    for y = 1, yesCount do
        local random = math.random(1, #cardConfigList)
        local random_id = cardConfigList[random]
        table.remove(cardConfigList, random)

        local index = getRandomIndex({self.bottomCardDic, self.upCardDic})
        self.bottomCardDic[index] = random_id
        self.upCardDic[index] = random_id
    end

    local function getTwoRandomIndex()
        local randomIndex_1 = getRandomIndex({self.bottomCardDic})
        local randomIndex_2 = getRandomIndex({self.upCardDic})
        if randomIndex_1 ~= randomIndex_2 then
            return randomIndex_1, randomIndex_2
        else
            return getTwoRandomIndex()
        end
    end

    local function getEmptyDic()
        local empty_list1 = {}
        for index, card_id in pairs(self.bottomCardDic) do
            if card_id == 0 then
                table.insert(empty_list1, index)
            end
        end

        local empty_list2 = {}
        for index, card_id in pairs(self.upCardDic) do
            if card_id == 0 then
                table.insert(empty_list2, index)
            end
        end

        return empty_list1, empty_list2
    end

    for index, card_id in pairs(cardConfigList) do
        local empty_list1, empty_list2 = getEmptyDic()
        if table.nums(empty_list1) == 2 then --只有两个空的时候，直接强制交换，让他们不重复
            self.bottomCardDic[empty_list1[1]] = cardConfigList[index]
            self.bottomCardDic[empty_list1[2]] = cardConfigList[index + 1]
            if empty_list1[1] == empty_list2[1] or empty_list1[2] == empty_list2[2] then
                self.upCardDic[empty_list2[1]] = cardConfigList[index + 1]
                self.upCardDic[empty_list2[2]] = cardConfigList[index]
            else
                self.upCardDic[empty_list2[1]] = cardConfigList[index]
                self.upCardDic[empty_list2[2]] = cardConfigList[index + 1]
            end
            break
        else
            local randomIndex_1, randomIndex_2 = getTwoRandomIndex()
            self.bottomCardDic[randomIndex_1] = card_id
            self.upCardDic[randomIndex_2] = card_id
        end
    end

    self:clearCard()
    for index, card_id in pairs(self.bottomCardDic) do
        local card_item = SimpleInsItem:create(self.cardItem, self.bottom_layer, "rankingSceneUI_cardItem")
        table.insert(self.m_cardItemList, card_item)

        card_item.data = {card_id = card_id, tab_index = index}

        card_item:getChildGO("mImgicon"):SetActive(false)
        card_item:getChildGO("mImgSelect"):SetActive(false)

        card_item:getChildGO("mImgmask"):SetActive(true)

        card_item:getChildGO("mImgno"):SetActive(true)
        card_item:getChildGO("mImgyes"):SetActive(false)

        card_item.editorCall = function (item, val)
            if val then
                item:getChildGO("mImgmask"):SetActive(false)

                local mImgicon = item:getChildGO("mImgicon")
                mImgicon:SetActive(true)

                local thingConfig = ranking.RankingManager:getThingConfigVo(item.data.card_id)
                mImgicon:GetComponent(ty.AutoRefImage):SetImg(thingConfig:getIcon())
            else
                item:getChildGO("mImgmask"):SetActive(true)
            end
        end

        card_item:addUIEvent("mImgmask", function (item)
            local active_state = item:getChildGO("mImgyes").activeInHierarchy
            item:getChildGO("mImgno"):SetActive(active_state)
            item:getChildGO("mImgyes"):SetActive(not active_state)

        end, "arts/audio/UI/minigames/mng_mole_1.prefab")

    end

    for index, card_id in pairs(self.upCardDic) do
        local card_item = SimpleInsItem:create(self.cardItem, self.up_layer, "rankingSceneUI_cardItem")
        table.insert(self.m_cardItemList, card_item)

        card_item.data = {card_id = nil, tab_index = index}

        card_item.m_go:GetComponent(ty.CanvasGroup).alpha = 1
        card_item:getChildGO("mImgSelect"):SetActive(false)
        card_item:getChildGO("mImgmask"):SetActive(false)

        card_item:getChildGO("mImgicon"):SetActive(true)

        card_item.refreshIcon = function (item, card_id)
            item.data.card_id = card_id

            local thingConfig = ranking.RankingManager:getThingConfigVo(card_id)
            item:getChildGO("mImgicon"):GetComponent(ty.AutoRefImage):SetImg(thingConfig:getIcon())
        end

        card_item:refreshIcon(card_id)

        card_item:addUIEvent("mImgicon", function (item)
            if self.m_selectCardItem == nil then
                self.m_selectCardItem = item
                self.m_selectCardItem:getChildGO("mImgSelect"):SetActive(true)
            else
                if self.m_selectCardItem.data.tab_index == item.data.tab_index then
                    self.m_selectCardItem:getChildGO("mImgSelect"):SetActive(false)
                    self.m_selectCardItem = nil
                    return
                end

                self.m_selectCardItem:getChildGO("mImgSelect"):SetActive(false)

                local function tween2()
                    self.upCardDic[item.data.tab_index] = self.m_selectCardItem.data.card_id
                    self.upCardDic[self.m_selectCardItem.data.tab_index] = item.data.card_id

                    self.m_selectCardItem:refreshIcon(self.upCardDic[self.m_selectCardItem.data.tab_index])
                    item:refreshIcon(self.upCardDic[item.data.tab_index])

                    self.m_selectCardItem = nil

                    self.m_allStepCount = self.m_allStepCount - 1

                    self:refreshYesCount()
                    self:refreshPassStar()
                    self:refreshStepCount()
                end

                local selectItem = self.m_selectCardItem
                TweenFactory:canvasGroupAlphaTo(item.m_go:GetComponent(ty.CanvasGroup), 1, 0.1, 0.2, nil, tween2)
                TweenFactory:canvasGroupAlphaTo(selectItem.m_go:GetComponent(ty.CanvasGroup), 1, 0.1, 0.2, nil)

                TweenFactory:canvasGroupAlphaTo(item.m_go:GetComponent(ty.CanvasGroup), 0.1, 1, 0.3, nil, nil, 0.2)
                TweenFactory:canvasGroupAlphaTo(selectItem.m_go:GetComponent(ty.CanvasGroup), 0.1, 1, 0.3, nil, nil, 0.2)

            end
        end, "arts/audio/UI/minigames/mng_mole_1.prefab")
    end
end

function clearCard(self)
    if self.m_cardItemList then
        for k, v in pairs(self.m_cardItemList) do
            if v.editorCall then
                v.editorCall = nil
            end
            if v.refreshIcon then
                v.refreshIcon = nil
            end

            v.data = nil

            v:poolRecover()
        end
    end

    self.m_cardItemList = {}
end

function refreshPassStar(self)
    self.mStarCount = 0
    for i = 1, #self.m_DupConfigVo.star_list do
        local starConfig = ranking.RankingManager:getStarConfigVo(self.m_DupConfigVo.star_list[i])

        if self.m_yesCount >= starConfig.correct then
            self.mStarCount = starConfig.star
        end
    end

    self:clearPassStar()
    for i = 1, #self.m_DupConfigVo.star_list do
        local item = SimpleInsItem:create(self.mStarItem, self.mStarLayer, "RankingScenePanelPassStarItem")
        local starConfig = ranking.RankingManager:getStarConfigVo(self.m_DupConfigVo.star_list[i])

        local isMeet = self.mStarCount >= starConfig.star
        local color = "82898c"
        if isMeet then
            color = "ffffff"
        end

        item:getChildGO("mStar_2"):SetActive(isMeet)

        item:setText("mTextDesc", nil, "≥" .. starConfig.correct)

        table.insert(self.mPassStartList, item)
    end
end

function clearPassStar(self)
    if self.mPassStartList then
        for k, v in pairs(self.mPassStartList) do
            v:poolRecover()
        end
    end

    self.mPassStartList = {}
end

function refreshStepCount(self)
    self.mTextStepCount.text = _TT(151102, self.m_allStepCount)

    local function settlement ()
        if self.mStarCount > 0 then
            AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_mole_4.prefab")
        else
            AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_common_1.prefab")
        end
        GameDispatcher:dispatchEvent(EventName.ONREQ_RANKING_PASS_DUP, {dup_id = self.m_DupConfigVo.id, star_count = self.mStarCount})
    end

    if self.m_allStepCount <= 0 then
        settlement()
    else
        local win = true
        for index, card_id in pairs(self.upCardDic) do
            if self.bottomCardDic[index] ~= card_id then
                win = false
                break
            end
        end

        if win then
            settlement()
        end
    end

end

function refreshYesCount(self)
    local allCardCount = table.nums(self.upCardDic)
    self.m_yesCount = 0
    for index, card_id in pairs(self.upCardDic) do
        if self.bottomCardDic[index] == card_id then
            self.m_yesCount = self.m_yesCount + 1
        end
    end

    self.mTextYesCount.text = _TT(151103, self.m_yesCount, allCardCount)
end

-- 暂停
function onPauseClick(self)
    if self.m_ResetCardTween then
        return
    end

    GameDispatcher:dispatchEvent(EventName.RANKING_UPDATE_PAUSESTATE, true)
    self.mGroupPause:SetActive(true)
    self:updateStarInfo()
end

-- 继续
function onPlayClick(self)
    GameDispatcher:dispatchEvent(EventName.RANKING_UPDATE_PAUSESTATE, false)

    self.mGroupPause:SetActive(false)
end

-- 重新开始
function onReplayClick(self)
    GameDispatcher:dispatchEvent(EventName.RANKING_UPDATE_PAUSESTATE, false)

    self.mGroupPause:SetActive(false)
    self:refreshView(self.m_DupConfigVo)
end

-- 退出
function onExitClick(self)
    self:close()
end

function refreshPauseState(self, pauseState)
    self.mImgStart:SetActive(pauseState)
    self.mImgPause:SetActive(not pauseState)
end

-------------------暂停界面Start--------------------------------
-- 更新星级
function updateStarInfo(self)
    self:clearStarItem()
    for i = 1, #self.m_DupConfigVo.star_list do
        local item = SimpleInsItem:create(self:getChildGO("GroupTaskItem"), self.mGroupStar, "RankingScenePanelStarItem")
        local starConfig = ranking.RankingManager:getStarConfigVo(self.m_DupConfigVo.star_list[i])

        local isMeet = self.mStarCount >= starConfig.star
        local color = "82898c"
        if isMeet then
            color = "ffffff"
        end

        item:getChildGO("mImgStar1"):SetActive(isMeet)

        local param = ranking.RankingManager:getStarConfigVo(self.m_DupConfigVo.star_list[i])
        item:setText("mTextDesc", nil, string.format("<color=#%s>%s</color>", color, param:getDesc()))

        table.insert(self.mStarItemList, item)
    end
end

function clearStarItem(self)
    if self.mStarItemList then
        for k, v in pairs(self.mStarItemList) do
            v:poolRecover()
        end
    end
    self.mStarItemList = {}
end
-------------------暂停界面End--------------------------------

return _M
