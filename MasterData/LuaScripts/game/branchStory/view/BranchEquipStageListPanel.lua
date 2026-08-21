module('branchStory.BranchEquipStageListPanel', Class.impl(branchStory.BranchMainStageListPanel))

function UICode(self)
    self:setUICode(LinkCode.BranchStoryEquip)
end

function __onClickAwardHandler(self)
    if (self.mChapterVo) then
        local canRec = branchStory.BranchStoryManager:canRecChapterAward(self.mChapterVo.chapterId)
        if (canRec) then
            GameDispatcher:dispatchEvent(EventName.REQ_REC_BRANCH_EQUIP_AWARD, { chapterId = self.mChapterVo.chapterId })
        else
            local propsList = AwardPackManager:getAwardListById(self.mChapterVo.dropId)
            if (branchStory.BranchStoryManager:hasRecChapterAward(self.mChapterVo.chapterId) == false) then
                GameDispatcher:dispatchEvent(EventName.OPEN_DAILY_TASK_AWARD_PANEL, { tip = _TT(29107), propsList = propsList })
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_DAILY_TASK_AWARD_PANEL, { tip = _TT(411), propsList = propsList })
            end
        end
    end
end

function setData(self, cusData)
    local chapterVo = cusData.chapterVo
    if chapterVo then
        self.mChapterVo = chapterVo
        self:__updateView(true)
    end
end

function __updateStageListView(self, isInit)
    self.mImgRight:SetImg(UrlManager:getPackPath("tacticeTrain/img_stage_title_bz.png"))
    self:__removeItemList()
    local scrollToStageId = nil
    local isHasSelect = false
    local totalW = 0
    local parentTrans = self.mNodeStart
    gs.TransQuick:UIPosX(self.mRectNodeStart, self:getScreenW() / 2)
    local list = self.mChapterVo.stageIdList
    for i = 1, #list do
        local stageVo = branchStory.BranchStoryManager:getStageConfigVo(list[i])
        local item = branchStory.BranchEquipStageItem:create(parentTrans, stageVo, 1, false)

        local isCanFight = not branchStory.BranchStoryManager:isStagePass(stageVo.stageId) and branchStory.BranchStoryManager:canStageFight(stageVo.stageId)
        if (not isHasSelect and isCanFight) then
            scrollToStageId = stageVo.stageId
        end
        if (not isHasSelect) then
            isHasSelect = isCanFight
        end
        item:setCallBack(self, self.__onClickStageItemHandler, stageVo)
        table.insert(self.mItemList, item)
        parentTrans = item:getNextNodeTrans()
        if (i == #list) then
            local starX, middleX, endX = self:__getItemPosX(item)
            totalW = endX + self:getScreenW() * 0.5
        end
    end
    gs.TransQuick:SizeDelta01(self.mRectContent, totalW)
    gs.TransQuick:SizeDelta01(self.gImgBg.gameObject.transform, totalW)
    -- 没有当前正在打的，即所有都打通关了，默认跳到最后一关
    if (scrollToStageId) then
        self:__scrollToStageId(scrollToStageId, not isInit)
    else
        local item = self.mItemList[#self.mItemList]
        if (item) then
            self:__scrollToStageId(item:getStageVo().stageId, not isInit)
        end
    end
end

function updateRedPoint(self)
    local passCount = branchStory.BranchStoryManager:getPassStageCount(self.mChapterVo.chapterId)
    local isFull = passCount >= #self.mChapterVo.stageIdList
    if (isFull) then
        self.mComplete:SetActive(false)   
        self.mReceive:SetActive(true)
        RedPointManager:add(self.mTextBtnTip.transform, nil, -57, 48)
    else
        RedPointManager:remove(self.mTextBtnTip.transform)
    end
end

function __onClickStageItemHandler(self, stageVo)
    local stageId = stageVo.stageId
    -- 已通关/未通关
    if branchStory.BranchStoryManager:isStagePass(stageId) or branchStory.BranchStoryManager:canStageFight(stageId) then
        self:__infoPanelShow(stageId)
        self:__setSelectStage(stageId)
    else
        -- 未解锁
        gs.Message.Show(_TT(44211))
    end
end

-----------------------------------------------------------------------------Info面板内容----------------------------------------------------------------------------------

function updateInfoPanel(self, cusStageId)
    self.mStageId = cusStageId
    self.mStageVo = branchStory.BranchStoryManager:getStageConfigVo(cusStageId)
    self.mTxtStageId.text = ""
    self.mTxtStageName.text = self.mStageVo:getName()
    self.mTxtStageDes.text = self.mStageVo:getDes()

    local costTid = self.mStageVo.costTid
    local costCount = self.mStageVo.costNum
    self.mImgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(costTid), true)
    self.mTxtCost.text = costCount -- .. "/" .. bag.BagManager:getPropsCountByTid(costTid)
    self.mTxtCost.gameObject:SetActive(costCount > 0)
    self.mTxtAwardTitle.text = _TT(44212)
    self.mBtnFight:SetActive(not branchStory.BranchStoryManager:isStagePass(self.mStageVo.stageId))
end

function __updateItem(self)
    self:__removeItem()
    local isPass = branchStory.BranchStoryManager:isStagePass(self.mStageVo.stageId)
    local awardList = AwardPackManager:getAwardListById(self.mStageVo.awardPackId)
    for i = 1, #awardList do
        local vo = awardList[i]
        local propsGrid = PropsGrid:create(self.mScrollContent, { vo.tid, vo.num }, 1, false)
        table.insert(self.mAwardList, propsGrid)
        propsGrid:setIconGray(isPass == true)
        propsGrid:setHasRec(isPass == true)
    end
    gs.TransQuick:UIPosX(self.mScrollContent, 0)
end

function __sendFight(self)
    self:getChildGO('StageInfoPanel'):SetActive(false)
    local callOpenStageListPanel = function()
        -- 纯剧情播放完毕回到对应章节的关卡列表界面，或者打开阵型后又返回来
        GameDispatcher:dispatchEvent(EventName.OPEN_BRANCH_EQUIP_STAGE_PANEL, { chapterVo = self.mChapterVo, stageVo = self.mStageVo })
    end

    local formatoinCallFun = function(callReason)
        if (callReason == formation.CALL_FUN_REASON.PLAYER_CLOSE) then
            callOpenStageListPanel()
        end
    end

    if (self.mStageVo.type == battleMap.MainMapStageType.Story) then
        local finishCall = function(isSuccess)
            if (isSuccess) then
                if (not branchStory.BranchStoryManager:isStagePass(self.mStageVo.stageId)) then
                    GameDispatcher:dispatchEvent(EventName.REQ_DUP_STORY_FINISH, { battleType = PreFightBattleType.DupBranchEquip, fieldId = self.mStageVo.stageId })
                end
                callOpenStageListPanel()
                guide.GuideCondition:condition14()
            else
                -- gs.Message.Show("无剧情可播放")
                gs.Message.Show(_TT(49007))
            end
        end
        storyTalk.StoryTalkManager:justStoryNoFight(PreFightBattleType.DupBranchEquip, self.mStageVo.stageId, finishCall)
    else
        -- 是否有支援我方的怪物id列表
        local supportMonterList = self.mStageVo.supportMonterList
        if (supportMonterList and #supportMonterList > 0) then
            formation.checkFormationFight(PreFightBattleType.DupBranchEquip, nil, self.mStageId, formation.TYPE.MAIN_SUPPORT, nil, supportMonterList, formatoinCallFun)
        else
            formation.checkFormationFight(PreFightBattleType.DupBranchEquip, nil, self.mStageId, nil, nil, formatoinCallFun)
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(44212):	"奖励预览"
	语言包: _TT(44211):	"请先通关前置关卡"
]]