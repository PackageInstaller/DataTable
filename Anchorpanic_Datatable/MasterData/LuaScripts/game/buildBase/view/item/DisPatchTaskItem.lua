--[[ 
-----------------------------------------------------
@filename       :
@Description    : 
@date           : 
@Author         : tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("buildBase.DisPatchTaskItem", Class.impl("lib.component.BaseContainer"))

UIRes = UrlManager:getUIPrefabPath("buildBase/DisPatchTaskItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

function dtor(self)
    super.dtor(self)
end

-- 初始化数据
function initData(self)
    self.mState = 0
    self.skillLists = {}
    self.starLists = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnClikcZone = self:getChildGO("mImgBg")
    self.mGoRecommend = self:getChildGO("mGoRecommend")
    self.mGoRecommend:SetActive(false)
    self.mImgRecommendHero = self:getChildGO("mImgRecommendHero"):GetComponent(ty.AutoRefImage)
    self.mStarsGroup = self:getChildGO("mStarsGroup")
    self.mStarsGroup:SetActive(false)
end

--激活
function active(self)
    super.active(self)
end

function addAllUIEvent(self)
    self:addOnClick(self.mBtnClikcZone, self.onClickHandler)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    LoopManager:removeTimer(self, self.onUpdateChargeTimerInfo)
end

function destroy(self)
    super.destroy(self)
    LoopManager:removeTimer(self, self.onUpdateChargeTimerInfo)
end

function setData(self, exploreId)
    self.slotId = exploreId
    self.mInfoHelper = buildBase.DispatchDockManager:getAreaInfo(exploreId)
    if self.mInfoHelper ~= nil then
        self.endTime = self.mInfoHelper.endTIme
        self.taskId = self.mInfoHelper.taskId
        self.icon = buildBase.DispatchDockManager:getTaskConfig(self.taskId).icon
        self.taskConfig = buildBase.DispatchDockManager:getTaskConfig(self.taskId)
    end
    self.unlockLevel = buildBase.DispatchDockManager:getAreaConfig(exploreId).unlockLevel
    self:updateItemState()
end

function updateItemState(self)
    self.mState = buildBase.DispatchDockManager:checkTaskState(self.slotId)
    LoopManager:removeTimer(self, self.onUpdateChargeTimerInfo)
    self.mGoRecommend:SetActive(false)
    self.mStarsGroup:SetActive(false)
    if self.mState == buildBase.TaskState.Available then
        self:onOpenAvailable()
        self:updateGroup()
    elseif self.mState == buildBase.TaskState.Incomplete then
        self:onOpenIncomplete()
        self:updateGroup()
    elseif self.mState == buildBase.TaskState.Complete then
        self:onOpenComplete()
        self:updateGroup()
    elseif self.mState == buildBase.TaskState.Finished then
        self:onOpenFinished()
        self:updateGroup()
    elseif self.mState == buildBase.TaskState.Locked then
        self:onOpenLocked()
        self:updateGroup()
    end
end

function updateGroup(self)
    if self.mBtnStateAvailable then
        self.mBtnStateAvailable:SetActive(self.mState == buildBase.TaskState.Available)
    end
    if self.mBtnStateIncompleted then
        self.mBtnStateIncompleted:SetActive(self.mState == buildBase.TaskState.Incomplete)
    end
    if self.mBtnStateCompleted then
        self.mBtnStateCompleted:SetActive(self.mState == buildBase.TaskState.Complete)
    end
    if self.mImgStateFinished then
        self.mImgStateFinished:SetActive(self.mState == buildBase.TaskState.Finished)
    end
    if self.mImgStateLocked then
        self.mImgStateLocked:SetActive(self.mState == buildBase.TaskState.Locked)
    end
end

function onOpenAvailable(self)
    if not self.mBtnStateAvailable then
        self.mBtnStateAvailable = self:getChildGO("mBtnStateAvailable")
        self.mBtnStateAvailable:SetActive(false)
    end
    if not self.mSkillNode then
        self.mSkillNode = self:getChildTrans("mSkillNode")
        self.mSkillImg = self:getChildGO("mSkillImg")
    end
    self:clearSkills()
    if next(self.taskConfig.eleType) then
        for _, type in pairs(self.taskConfig.eleType) do
            local item = SimpleInsItem:create(self.mSkillImg, self.mSkillNode, "DisPatchTaskItemskills")
            local img = item:getGo():GetComponent(ty.AutoRefImage)
            img:SetImg(UrlManager:getHeroEleTypeIconUrl(type), false)
            table.insert(self.skillLists, item)
        end
    end

    if self.taskConfig.heroType and next(self.taskConfig.heroType) then
        for _, heroType in pairs(self.taskConfig.heroType) do
            local item = SimpleInsItem:create(self.mSkillImg, self.mSkillNode, "DisPatchTaskItemskills")
            local img = item:getGo():GetComponent(ty.AutoRefImage)
            img:SetImg(UrlManager:getHeroJobWhiteIconUrl(heroType), false)
            table.insert(self.skillLists, item)
        end


        -- local item = SimpleInsItem:create(self.mSkillImg, self.mSkillNode, "skills_")
        -- local img = tem:getGo():GetComponent(ty.AutoRefImage)
        -- img:SetImg(UrlManager:getHeroJobWhiteIconUrl(self.mTaskConfig.heroType[1]), false)
        -- table.insert(self.skillLists, item)
    end

    if not self.mStarsGroupTrnas then
        self.mStarsGroupTrnas = self:getChildTrans("mStarsGroup")
        self.mStarIcon = self:getChildGO("mStarIcon")
    end
    self:clearStars()
    self.mStarsGroup:SetActive(true)
    if self.taskConfig.star then
        for i = 1, self.taskConfig.star do
            local item = SimpleInsItem:create(self.mStarIcon, self.mStarsGroupTrnas, "DisPatchTaskItemstars")
            self.starLists[i] = item
        end
    end
    self.mGoRecommend.gameObject:SetActive(true)
    self.mImgRecommendHero:SetImg(UrlManager:getIconPath(self.icon), false)
end

function clearSkills(self)
    if next(self.skillLists) then
        for _, v in pairs(self.skillLists) do
            v:poolRecover()
        end
        self.skillLists = {}
    end
end

function clearStars(self)
    if next(self.starLists) then
        for _, v in pairs(self.starLists) do
            v:poolRecover()
        end
        self.starLists = {}
    end
end

function onOpenComplete(self)
    if not self.mBtnStateCompleted then
        self.mBtnStateCompleted = self:getChildGO("mBtnStateCompleted")
        self.mBtnStateCompleted:SetActive(false)
    end
    self.mGoRecommend.gameObject:SetActive(true)
    self.mImgRecommendHero:SetImg(UrlManager:getIconPath(self.icon), false)
end

function onOpenFinished(self)
    if not self.mImgStateFinished then
        self.mImgStateFinished = self:getChildGO("mImgStateFinished")
        self.mImgStateFinished:SetActive(false)
    end
end

function onOpenLocked(self)
    if not self.mImgStateLocked then
        self.mImgStateLocked = self:getChildGO("mImgStateLocked")
        self.mImgStateLocked:SetActive(false)
    end
    if not self.mTxtStateLocked then
        self.mTxtStateLocked = self:getChildGO("mTxtStateLocked"):GetComponent(ty.Text)
    end
    self.mTxtStateLocked.text = string.format("派遣坞Lv.%d解锁", self.unlockLevel)
end

function onOpenIncomplete(self)
    if not self.mBtnStateIncompleted then
        self.mBtnStateIncompleted = self:getChildGO("mBtnStateIncompleted")
        self.mBtnStateIncompleted:SetActive(false)
    end
    self:clearStars()
    self.mStarsGroup:SetActive(true)
    self.mGoRecommend.gameObject:SetActive(true)
    self.mImgRecommendHero:SetImg(UrlManager:getIconPath(self.icon), false)
    if not self.mStarsGroupTrnas then
        self.mStarsGroupTrnas = self:getChildTrans("mStarsGroup")
        self.mStarIcon = self:getChildGO("mStarIcon")
    end
    if self.taskConfig.star then
        for i = 1, self.taskConfig.star do
            local item = SimpleInsItem:create(self.mStarIcon, self.mStarsGroupTrnas, "DisPatchTaskItemstars")
            self.starLists[i] = item
        end
    end
    LoopManager:removeTimer(self, self.onUpdateChargeTimerInfo)
    if not self.mTxtTimer then
        self.mTxtTimer = self:getChildGO("mTxtTimer"):GetComponent(ty.Text)
    end
    self:onUpdateChargeTimerInfo()
    LoopManager:addTimer(1, 0, self, self.onUpdateChargeTimerInfo)
end

-- 任务进行中倒计时
function onUpdateChargeTimerInfo(self)
    local endTime = self.endTime - GameManager:getClientTime()
    if (endTime < 0) then
    else
        self.mTxtTimer.text = TimeUtil.getHMSByTime(endTime)
    end
end

function onClickHandler(self)
    if self.mState > 0 then
        if self.mState == buildBase.TaskState.Available then
            GameDispatcher:dispatchEvent(EventName.OPEN_DISPATCHDOCK_AVAILABLE, { exploreId = self.slotId, taskId = self.taskId })
        elseif self.mState == buildBase.TaskState.Incomplete then
            GameDispatcher:dispatchEvent(EventName.OPEN_DISPATCHDOCK_INCOMPLETE_VIEW, { exploreId = self.slotId, taskId = self.taskId })
        elseif self.mState == buildBase.TaskState.Complete then
            GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_DISPATCH_REWARDS, { buildId = buildBase.DispatchDockManager:getBaseBuildId(), exploreId = self.slotId })
        elseif self.mState == buildBase.TaskState.Finished then
            gs.Message.Show(_TT(76188)) -- 等待任务恢复
        elseif self.mState == buildBase.TaskState.Locked then
            gs.Message.Show(_TT(76189)) --等级未达到解锁条件
        end
    end
end

function onStateUpdateHandler(self, exploreId)
    if self.slotId == exploreId then
        self:setData(exploreId)
    else
        self:updateItemState()
    end
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]