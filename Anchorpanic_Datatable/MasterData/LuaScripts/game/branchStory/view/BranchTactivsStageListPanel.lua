module("branchStory.BranchTactivsStageListPanel", Class.impl(branchStory.BranchMainStageListPanel))

function UICode(self)
    self:setUICode(LinkCode.BranchTactivs)
end

function setData(self, cusData)
    local chapterVo = cusData.chapterVo
    if chapterVo then
        self.mChapterVo = chapterVo
        self:__updateView(true)
    end
end

function __updateView(self, init)
    self.mBtnAward:SetActive(false)
    super.__updateView(self, init)
end

function __updateStageListView(self, isInit)
    self.mImgRight:SetImg(UrlManager:getPackPath("tacticeTrain/img_stage_title_zs.png"))
    self:__removeItemList()
    local scrollToStageId = nil
    local isHasSelect = false
    local totalW = 0
    local parentTrans = self.mNodeStart
    gs.TransQuick:UIPosX(self.mRectNodeStart, self:getScreenW() / 2)

    local list = self.mChapterVo.stageIdList
    for i = 1, #list do
        local stageVo = branchStory.BranchTactivsManager:getTactivsStageConfigVo(list[i])
        local item =        branchStory.BranchTactivsStageItem:create(parentTrans, { type = stageVo.chapterId, data = stageVo }, 1, false)

        local isCanFight =        not branchStory.BranchTactivsManager:isTactivsStagePass(stageVo.chapterId, stageVo.stageId) and
        branchStory.BranchTactivsManager:canTactivsStageFight(stageVo.chapterId, stageVo.stageId)
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
            local _, _, endX = self:__getItemPosX(item)
            totalW = endX + self:getScreenW() * 0.5
        end

        if stageVo.chapterId == 1 and stageVo.stageId == 180101 then
            self:setGuideTrans("tofight_" .. stageVo.chapterId .. "_" .. stageVo.stageId, item:getTrans())
        end

    end
    gs.TransQuick:SizeDelta01(self.mRectContent, totalW)
    -- gs.TransQuick:SizeDelta01(self.gImgBg.gameObject.transform, totalW)
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
        RedPointManager:add(self.mTextBtnTip.transform, nil, 0, 0)
    else
        RedPointManager:remove(self.mTextBtnTip.transform)
    end
end

function __onClickStageItemHandler(self, stageVo)
    local stageId = stageVo.data.stageId
    -- 已通关/未通关
    if branchStory.BranchTactivsManager:isTactivsStagePass(stageVo.data.chapterId, stageId) or
    branchStory.BranchTactivsManager:canTactivsStageFight(stageVo.data.chapterId, stageId)
    then
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
    self.mStageVo = branchStory.BranchTactivsManager:getTactivsStageConfigVo(cusStageId)
    self.mTxtStageId.text = ""
    self.mTxtStageName.text = self.mStageVo:getName()
    self.mTxtStageDes.text = self.mStageVo:getDes()

    local costTid = self.mStageVo.costTid
    local costCount = self.mStageVo.costNum
    self.mImgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(costTid), true)
    self.mTxtCost.gameObject:SetActive(costCount > 0)
    self.mTxtAwardTitle.text = _TT(44212)
    if self.mStageVo.chapterId == 1 and self.mStageVo.stageId == 180101 then
        self:setGuideTrans("tofight_challenge_" .. self.mStageVo.chapterId .. "_" .. self.mStageVo.stageId, self.mBtnFight.transform)
    end
end

function __updateItem(self)
    self:__removeItem()
    local isPass = branchStory.BranchTactivsManager:isTactivsStagePass(self.mStageVo.chapterId, self.mStageVo.stageId)

    local awardList = AwardPackManager:getAwardListById(self.mStageVo.awardPackId)
    for i = 1, #awardList do
        local vo = awardList[i]
        local propsGrid = PropsGrid:create(self.mScrollContent, { vo.tid, vo.num }, 1, false)
        --propsGrid:setPosition(math.Vector3((i - 1) * 114 + 55, 0, 0))
        table.insert(self.mAwardList, propsGrid)
        propsGrid:setIconGray(isPass == true)
        propsGrid:setHasRec(isPass == true)
    end
    gs.TransQuick:UIPosX(self.mScrollContent, 0)
end

function __sendFight(self)
    self:getChildGO("StageInfoPanel"):SetActive(false)
    local callOpenStageListPanel = function()
        -- 纯剧情播放完毕回到对应章节的关卡列表界面，或者打开阵型后又返回来
        GameDispatcher:dispatchEvent(
        EventName.OPEN_BRANCH_TACIVS_PANEL,
        { chapterVo = self.mChapterVo, stageVo = self.mStageVo, type = self.mStageVo.chapterId }
        )
    end

    if (self.mStageVo.type == battleMap.MainMapStageType.Story) then
        local finishCall = function(isSuccess)
            if (isSuccess) then
                if
                (not branchStory.BranchTactivsManager:isTactivsStagePass(
                self.mStageVo.chapterId,
                self.mStageVo.stageId
                ))
                then
                    GameDispatcher:dispatchEvent(
                    EventName.REQ_DUP_STORY_FINISH,
                    { battleType = PreFightBattleType.DupTactivs, fieldId = self.mStageVo.stageId }
                    )
                end
                callOpenStageListPanel()
                guide.GuideCondition:condition14()
            else
                -- gs.Message.Show("无剧情可播放")
                gs.Message.Show(_TT(49007))
            end
        end
        storyTalk.StoryTalkManager:justStoryNoFight(PreFightBattleType.DupTactivs, self.mStageVo.stageId, finishCall)
    else
        GameDispatcher:dispatchEvent(EventName.OPEN_TEACHING_PANEL, { battleType = PreFightBattleType.DupTactivs, dupId = self.mStageId })
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(44212):	"奖励预览"
	语言包: _TT(44211):	"请先通关前置关卡"
	语言包: _TT(7):	"已领取"
]]