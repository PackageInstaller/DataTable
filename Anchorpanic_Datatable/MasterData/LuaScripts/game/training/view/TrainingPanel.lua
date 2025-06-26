module("training.TrainingPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("training/TrainingPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("")
    self:setUICode(LinkCode.Training)
end

-- 初始化数据
function initData(self)
    self.m_playMonsterTid = nil
    self.m_arrowTweenLeft = nil
    self.m_arrowTweenRight = nil
end

-- 玩家点击关闭
function onClickClose(self)
    self:__playerClose()
    super.onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    self:__playerClose()
    super.onCloseAllCall(self)
end

function __playerClose(self)
    self.m_playMonsterTid = nil
    
    GameDispatcher:dispatchEvent(EventName.EXIT_TRAINING_SCENE)
end

function configUI(self)
    self.mGoToucher = self:getChildGO("ImgToucher")
    self.mGroupDupInfo = self:getChildTrans("GroupDupInfo")

    self.mGroupGain = self:getChildTrans("GroupGain")
    self.mGainItem = self:getChildGO("GainItem")
    self.mTextChapterPro = self:getChildGO("TextChapterPro"):GetComponent(ty.Text)
    self.mTextGainTitle = self:getChildGO("TextGainTitle"):GetComponent(ty.Text)
    self.mTextTip = self:getChildGO("TextTip"):GetComponent(ty.Text)
    self.mTextTimeTitle = self:getChildGO("TextTimeTitle"):GetComponent(ty.Text)
    self.mTextTime = self:getChildGO("TextTime"):GetComponent(ty.Text)

    self.mBtnBuy = self:getChildGO("BtnBuy")
    self.mImgBuy = self.mBtnBuy:GetComponent(ty.AutoRefImage)
    self.mBtnChallenge = self:getChildGO("BtnChallenge")
    self.mImgChallenge = self.mBtnChallenge:GetComponent(ty.AutoRefImage)
    self.mImgArrowLeft = self:getChildTrans("ImgArrowLeft")
    self.mImgArrowRight = self:getChildTrans("ImgArrowRight")
    
    self.mImgEliteProgress = self:getChildGO("ImgEliteProgress"):GetComponent(ty.Image)
    self.mTextTrainingPro_1 = self:getChildGO("TextTrainingPro_1"):GetComponent(ty.Text)
    self.mTextTrainingPro_2 = self:getChildGO("TextTrainingPro_2"):GetComponent(ty.Text)

    self.mBtnAward = self:getChildGO("BtnAward")

    self.mGroupAction = self:getChildTrans("GroupAction")
    self.mTextHero = self:getChildGO("TextHero"):GetComponent(ty.Text)
    self.mTextMonster = self:getChildGO("TextMonster"):GetComponent(ty.Text)
    self.mNodeAction = self:getChildTrans("NodeAction")
    self.mTextAction = self:getChildGO("TextAction")
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    GameDispatcher:addEventListener(EventName.OPEN_TRAINING_INFO_VIEW, self.__onOpenDupInfoHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_TRAINING_INFO_VIEW, self.__onCloseDupInfoHandler, self)
    GameDispatcher:addEventListener(EventName.RES_ONE_TRAINING_END, self.__onOneTrainingEndHandler, self)
    GameDispatcher:addEventListener(EventName.RES_TRAINING_PANEL_INFO, self.__onUpdatePanelInfoHandler, self)
    GameDispatcher:addEventListener(EventName.TRAINING_BUBBLE_UPDATE, self.__onUpdateBubbleHandler, self)
    local aaaa = training.TrainingManager
    if(training.TrainingManager.startTime <= 0)then
        Debug:log_error("TrainingPanel", "后端发来的startTime异常")
    else
        self:__updateView()
    end
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.OPEN_TRAINING_INFO_VIEW, self.__onOpenDupInfoHandler, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_TRAINING_INFO_VIEW, self.__onCloseDupInfoHandler, self)
    GameDispatcher:removeEventListener(EventName.RES_ONE_TRAINING_END, self.__onOneTrainingEndHandler, self)
    GameDispatcher:removeEventListener(EventName.RES_TRAINING_PANEL_INFO, self.__onUpdatePanelInfoHandler, self)
    GameDispatcher:removeEventListener(EventName.TRAINING_BUBBLE_UPDATE, self.__onUpdateBubbleHandler, self)
    LoopManager:removeTimerByIndex(self.m_loopSn)
    self.m_loopSn = nil
    self:__removeArrowAction()
    self:__onCloseDupInfoHandler()
end

function initViewText(self)
    self:getChildGO("TextTrainingPro"):GetComponent(ty.Text).text = _TT(43007) --"训练进度"
    self:getChildGO("TextBuy_1"):GetComponent(ty.Text).text = _TT(43004) --"加速训练"
    self:getChildGO("TextBuy_2"):GetComponent(ty.Text).text = _TT(43004) --"加速训练"
    self:getChildGO("TextBuy_3"):GetComponent(ty.Text).text = _TT(43004) --"加速训练"
    self:getChildGO("TextAward_1"):GetComponent(ty.Text).text = _TT(40028) --"领取奖励"
    self:getChildGO("TextAward_2"):GetComponent(ty.Text).text = _TT(40028) --"领取奖励"

    self.mTextGainTitle.text = _TT(43008) --"训练效率："
    self.mTextTip.text = string.format(_TT(43011), sysParam.SysParamManager:getValue(SysParamType.TRAINING_MAX_MINUTE)) --"至多累计%s分钟"
    self.mTextTimeTitle.text = _TT(43009) --"训练时长："
    
    self:setBtnLabel(self.mBtnChallenge, 43002, "阶段考核")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mGoToucher, self.__onCloseDupInfoHandler)
    self:addUIEvent(self.mBtnBuy, self.__onClickBuyHandler)
    self:addUIEvent(self.mBtnChallenge, self.__onClickChallengeHandler)
    self:addUIEvent(self.mBtnAward, self.__onClickAwardHandler)
end

function __onClickBuyHandler(self)
    if(training.TrainingManager.shopState == 0)then
        gs.Message.Show2(_TT(43012)) --"暂未发现数据商人"
    else
        local eliteScore = training.TrainingManager.elite
        if(eliteScore >= sysParam.SysParamManager:getValue(SysParamType.TRAINING_MAX_ELITE))then
            -- gs.Message.Show2("精英数据已满")
            gs.Message.Show2(_TT(43001))
        else
            local shopConfigVo = training.TrainingManager:getTrainingShopConfigVo()
            local propsConfigVo = props.PropsManager:getPropsConfigVo(shopConfigVo.costTid)
            UIFactory:alertMessge(string.format(_TT(43013), shopConfigVo.costNum, propsConfigVo.name, shopConfigVo.getCount), --""是否花费 %s %s购买 %s点 精英数据""
            true, function() 
                if (MoneyUtil.judgeNeedMoneyCountByTid(shopConfigVo.costTid, shopConfigVo.costNum, true, true)) then
                    GameDispatcher:dispatchEvent(EventName.REQ_TRAINING_ELITE_BUY, {}) 
                end
            end, 
            _TT(1),--"确定" 
            nil,
            true, function() end, 
            _TT(2),--"取消"
            _TT(43014),--"购买提示" 
            nil, RemindConst.TRAINING_ELITE_BUY)
        end
    end
end

function __onClickChallengeHandler(self)
    local eliteScore = training.TrainingManager.elite
    if(eliteScore >= sysParam.SysParamManager:getValue(SysParamType.TRAINING_MAX_ELITE))then
        self:__onOpenDupInfoHandler()
    else
        gs.Message.Show2(_TT(43015)) --"精英数据不足"
    end
end

function __onClickAwardHandler(self)
    local list = training.TrainingManager.gainAwardList
    if(#list > 0)then
        GameDispatcher:dispatchEvent(EventName.REQ_TRAINING_RESULT_REC, {})
    else
        gs.Message.Show2(_TT(43016)) --"当前未获得任何成果"
    end
end

function __onUpdatePanelInfoHandler(self, args)
    self:__updateView()
end

function __updateView(self, isMonsterDie)
    local eliteScore = training.TrainingManager.elite
    local ratio = AttConst.getPreciseDecimal(eliteScore / sysParam.SysParamManager:getValue(SysParamType.TRAINING_MAX_ELITE), 2)
    self.mImgEliteProgress.fillAmount = ratio
    self.mTextTrainingPro_1.text = ratio * 100 .. HtmlUtil:size("%", 24)
    self.mTextTrainingPro_2.text = ratio * 100 .. HtmlUtil:size("%", 24)

    local curStageId = battleMap.MainMapManager:getMainMapCurStage()
    local curChapterVo = battleMap.MainMapManager:getChapterVoByStageId(curStageId)
    if (curChapterVo) then
        self.mTextChapterPro.text = string.format(_TT(43017), curChapterVo.chapterId) --"主线进度：第%s章"
    else
        self.mTextChapterPro.text = ""
    end

    if(eliteScore >= sysParam.SysParamManager:getValue(SysParamType.TRAINING_MAX_ELITE))then
        -- self.mImgChallenge:SetGray(false)
        self.mBtnChallenge:SetActive(true)
        self:__addArrowAction()
    else
        -- self.mImgChallenge:SetGray(true)
        self.mBtnChallenge:SetActive(false)
        self:__removeArrowAction()
    end
    if(training.TrainingManager.shopState == 0)then
        -- self.mImgBuy:SetGray(true)
        self.mBtnBuy:SetActive(false)
    else
        -- self.mImgBuy:SetGray(false)
        self.mBtnBuy:SetActive(true)
    end

    if(not self.m_loopSn)then
        self.m_loopSn = LoopManager:addTimer(1, 0, self, self.__updateTickTime)
    end
    self:__updateTickTime()
    self:__updateGainList()
    self:__updateActionPlayer(isMonsterDie)
    self:__onUpdateBubbleHandler()
end

function __updateTickTime(self)
    local deltaTime = training.TrainingManager:getDeltaTime()
    self.mTextTime.text = string.format("-%s-", TimeUtil.getHMSByTime(deltaTime)) 
end

function __onUpdateBubbleHandler(self, args)
    local isBubble = training.TrainingManager:isBubble()
    if(isBubble)then
        RedPointManager:add(self.mBtnAward.transform, nil, 115, 33)
    else
        RedPointManager:remove(self.mBtnAward.transform)
    end
end

function __updateGainList(self)
    self:clearItemList()
    local trainingConfigVo = training.TrainingManager:getTrainingConfigVo()
    for i = 1, #trainingConfigVo.preGainList do
        local data = trainingConfigVo.preGainList[i]
        local item = SimpleInsItem:create(self.mGainItem, self.mGroupGain, "BranchStoryTrainingGainItem")
        item:getChildGO("ImgGain"):GetComponent(ty.AutoRefImage):SetImg(MoneyUtil.getMoneyIconUrlByTid(data.tid), true)
        item:setText("TextGain", nil,  HtmlUtil:color(data.num, "fee600") .. "/" .. _TT(154)) --分钟
        table.insert(self.m_itemList, item)
    end
end

-- 副本详情信息
function __onOpenDupInfoHandler(self, cusDupId)
    if self.gInfoView == nil then
        self.gInfoView = training.TrainingDupInfoView.new()
    end
    local dupConfigVo = training.TrainingManager:getTrainingDupConfigVo()
    self.gInfoView:show(self.mGroupDupInfo, dupConfigVo)
end

-- 关闭副本详情
function __onCloseDupInfoHandler(self)
    if self.gInfoView then
        self.gInfoView:destroy()
        self.gInfoView = nil
    end
    self:recoverMoneyBar()
end

function __onOneTrainingEndHandler(self, args)
    local lastStepId = args.lastStepId
    local lastEventId = args.lastEventId
    -- print(string.format("阶段id为%s，事件id为%s", lastStepId, lastEventId))
    -- 播放怪物死亡ing
    self:__updateView(true)

    local eventConfigVo = training.TrainingManager:getTrainingEventConfigVo(lastStepId, lastEventId)
    if(eventConfigVo)then
        if(eventConfigVo.eventType == training.TrainingEventType.GAIN_ELITE)then
            LoopManager:addFrame(30, 1, self, 
            function() 
                self:__addMoveAction(1, "精英数据增加动画") 
                -- gs.Message.Show2("精英数据增加动画") 
            end)
        end
        if(eventConfigVo.eventType == training.TrainingEventType.GAIN_ELITE_SHOP_ACTIVE)then
            LoopManager:addFrame(30, 1, self, 
            function() 
                self:__addMoveAction(2, "商店触发动画") 
                -- gs.Message.Show2("商店触发动画") 
            end)
        end
        if(eventConfigVo.eventType == training.TrainingEventType.GAIN_DROP_AWARD)then
            LoopManager:addFrame(20, 1, self, 
            function() 
                self:__addMoveAction(3, "固定产出动画 + 随机掉落奖励") 
                -- gs.Message.Show2("固定产出动画 + 随机掉落奖励") 
            end)
        else
            LoopManager:addFrame(20, 1, self, 
            function() 
                self:__addMoveAction(4, "固定产出动画") 
                -- gs.Message.Show2("固定产出动画") 
            end)
        end
    end
end

function __updateActionPlayer(self, isMonsterDie)
    if(not self.m_playMonsterTid)then
        local trainingConfigVo = training.TrainingManager:getTrainingConfigVo()
        self.m_playMonsterTid = trainingConfigVo:getRandomMonsterTid()
    end
    if(isMonsterDie)then
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(role.RoleManager:getRoleVo().showBoardHeroTid)
        -- local monsterTidVo = monster.MonsterManager:getMonsterVo(self.m_playMonsterTid)
        -- local monsterConfigVo = monster.MonsterManager:getMonsterVo01(monsterTidVo.tid)
        local monsterConfigVo = monster.MonsterManager:getMonsterVo01(self.m_playMonsterTid)
        self.mTextHero.text = heroConfigVo.name .. "攻击中"
        self.mTextMonster.text = monsterConfigVo.name .. "被击杀中"
        LoopManager:addFrame(30, 1, self, 
        function()
            -- 设置新的怪物
            local trainingConfigVo = training.TrainingManager:getTrainingConfigVo()
            self.m_playMonsterTid = trainingConfigVo:getRandomMonsterTid(self.m_playMonsterTid)
            self:__updateActionPlayer(false)
        end)
    else
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(role.RoleManager:getRoleVo().showBoardHeroTid)
        -- local monsterTidVo = monster.MonsterManager:getMonsterVo(self.m_playMonsterTid)
        -- local monsterConfigVo = monster.MonsterManager:getMonsterVo01(monsterTidVo.tid)
        local monsterConfigVo = monster.MonsterManager:getMonsterVo01(self.m_playMonsterTid)
        self.mTextHero.text = heroConfigVo.name .. "攻击中"
        self.mTextMonster.text = monsterConfigVo.name .. "攻击中"
    end
end

function __addMoveAction(self, type, content)
    local targetObj = nil
    if(type == 1)then
        targetObj = self.mBtnChallenge
    elseif(type == 2)then
        targetObj = self.mBtnBuy
    elseif(type == 3)then
        targetObj = self.mBtnAward
    elseif(type == 4)then
        targetObj = self.mBtnAward
    end

    local item = SimpleInsItem:create(self.mTextAction, self.mNodeAction, "TrainingTextAction")
    local itemTrans = item:getTrans()
    itemTrans:GetComponent(ty.Text).text = content
    local function _finsihCallFun()
        item:poolRecover()
        item = nil
    end
    local posStart = self.mNodeAction.localPosition
    local posEnd = targetObj.transform.localPosition
    local posMiddle = (posStart + posEnd) / 2
    posMiddle.y = posMiddle.y + 400
    itemTrans:DOLocalBezier(posStart, posMiddle, posEnd, 3):OnComplete(_finsihCallFun)
end

function __addArrowAction(self)
    if(not self.m_arrowTweenLeft and not self.m_arrowTweenRight)then
        gs.TransQuick:LPosX(self.mImgArrowLeft, -110)
        gs.TransQuick:LPosX(self.mImgArrowRight, 110)
        self.m_arrowTweenLeft = TweenFactory:move2LPosX(self.mImgArrowLeft, -140, 0.5, nil, nil, nil, true)
        self.m_arrowTweenRight = TweenFactory:move2LPosX(self.mImgArrowRight, 140, 0.5, nil, nil, nil, true)
    end
end

function __removeArrowAction(self)
    if self.m_arrowTweenLeft then
        self.m_arrowTweenLeft:Kill()
        self.m_arrowTweenLeft = nil
    end
    if self.m_arrowTweenRight then
        self.m_arrowTweenRight:Kill()
        self.m_arrowTweenRight = nil
    end
end

function clearItemList(self)
    if(self.m_itemList)then
        for i = #self.m_itemList, 1, -1 do
            local item = self.m_itemList[i]
            item:poolRecover()
        end
    end
    self.m_itemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
