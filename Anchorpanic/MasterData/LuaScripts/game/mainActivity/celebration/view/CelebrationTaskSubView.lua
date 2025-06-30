--[[ SetActive
-----------------------------------------------------
@filename       : ActivitySubscribeGift
@Description      关注领取奖励
@date           : 2023-06-23 
@Author         : tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('Celebration.CelebrationTaskSubView', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("activity/CelebrationTaskSubView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self.mCurDay = 0
    self.mSnLists={}
    self.mDayItemList = {}
    self.mAwardItemList = {}
end
--析构  
function dtor(self)
end

function initData(self)
    self.mTargetAwardItem=nil
    self.mTimeSn=nil
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mDayItem = self:getChildGO("mDayItem")
    self.mBtnGetAll = self:getChildGO("mBtnGetAll")
    self.mDayTrans = self:getChildTrans("mDayTrans")
    self.mBtnFashion = self:getChildGO("mBtnFashion")
    self.mImgTargetIng = self:getChildGO("mImgTargetIng")
    self.mBtnTargetRecive = self:getChildGO("mBtnTargetRecive")
    self.mImgTargetRecived = self:getChildGO("mImgTargetRecived")
    self.mTargetAwardTrans = self:getChildTrans("mTargetAwardTrans")
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtHeroName = self:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
    self.mTxtTargetIng = self:getChildGO("mTxtTargetIng"):GetComponent(ty.Text)
    self.mImgTargetBar = self:getChildGO("mImgTargetBar"):GetComponent(ty.Image)
    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mTxtFashionName = self:getChildGO("mTxtFashionName"):GetComponent(ty.Text)
    self.mTxtTargetTaskDes = self:getChildGO("mTxtTargetTaskDes"):GetComponent(ty.Text)
    self.mTxtTargetTaskName = self:getChildGO("mTxtTargetTaskName"):GetComponent(ty.Text)
    self.mTxtTargetTaskName = self:getChildGO("mTxtTargetTaskName"):GetComponent(ty.Text)
    self.mTxtTargetTaskProgress = self:getChildGO("mTxtTargetTaskProgress"):GetComponent(ty.Text)
    self.mLyScroller:SetItemRender(Celebration.CelebrationTaskItem)

    self.mBtnAwardPre = self:getChildGO("mBtnAwardPre")
    self.mBtnCloseAward = self:getChildGO("mBtnCloseAward")
    self.mBtnHideAward = self:getChildGO("mBtnHideAward")
    self.mAwardShowContent = self:getChildTrans("mAwardShowContent")
    self.mTxtAwardDes = self:getChildGO("mTxtAwardDes"):GetComponent(ty.Text)
    self.mTxtAwardTips = self:getChildGO("mTxtAwardTips"):GetComponent(ty.Text)

    self.mAwardEff = self:getChildGO("mAwardEff")
end

function onBtnAwardClick(self)
    local taskAwardList=sysParam.SysParamManager:getValue(SysParamType.CELEBRATION_TASK_AWARD)[1]
    self.showProps = PropsGrid:createByData({ tid = taskAwardList[1], num = taskAwardList[2], parent = self.mAwardShowContent, scale = 0.6, showUseInTip = true })
    self.mBtnCloseAward:SetActive(true)
end

function onBtnHideAwardClick(self)
    self.mBtnCloseAward:SetActive(false)
    if self.showProps then
        self.showProps:poolRecover()
        self.showProps = nil
    end
end

--激活
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_CELEBRATION_TASK_LIST,self.updateList,self)
    GameDispatcher:addEventListener(EventName.UPDATE_CELEBRATION_TARGET_TASK_STATE,self.updateTargetTaskInfo,self)
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverSn()
    GameDispatcher:removeEventListener(EventName.UPDATE_CELEBRATION_TASK_LIST,self.updateList,self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CELEBRATION_TARGET_TASK_STATE,self.updateTargetTaskInfo,self)
    self:clearItem()
    --self:removeTimer()
    self:clearScrollerItem()

    self:onBtnHideAwardClick()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTitle.text = _TT(98107)--"动态立绘"
    self.mTxtHeroName.text = "纯白芳颜   莉丽拉"
    self.mTxtFashionName.text = "绫罗礼宴"
    self.mTxtTargetTaskName.text=_TT(121007)
    self.mTxtTargetIng.text=_TT(36520)
    self:setBtnLabel(self.mBtnTargetRecive, 412, "领取")
    self:setBtnLabel(self.mBtnGetAll, 403, "全部领取")
    self.mTxtAwardDes.text = _TT(44212)
    self.mTxtAwardTips.text = _TT(121217)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGetAll,self.onClickGetAll)
    self:addUIEvent(self.mBtnTargetRecive,self.onClickGet)
    self:addUIEvent(self.mBtnFashion,self.onClickLockHandler)

    self:addUIEvent(self.mBtnAwardPre, self.onBtnAwardClick)
    self:addUIEvent(self.mBtnHideAward, self.onBtnHideAwardClick)
end

function onClickGet(self)
    GameDispatcher:dispatchEvent(EventName.REQ_RECIVE_CELEBRATION_TARGET_TASK_AWARD)
end

function onClickGetAll(self)
    local list = Celebration.CelebrationManager:getCanReciveListByDay(self.mCurDay)
    GameDispatcher:dispatchEvent(EventName.REQ_RECIVE_CELEBRATION_TASK_AWARD, list)
end
-- 更新 View 界面
function updateView(self)
    --self:updateTime()
    --self.mTimeSn = self:addTimer(1,0,self.updateTime)
    self:clearItem()
    self:createDayItem(true)

    local curActivityOverTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.CelebrationTask):getOverTime()
    local md, hm = TimeUtil.getMDHByTime2(curActivityOverTime)
    self.mTxtTime.text = _TT(121009,md .. " " .. hm) 

end

function updateTargetTaskInfo(self)
    self:clearTargetAwardItem()
    local taskAwardList=sysParam.SysParamManager:getValue(SysParamType.CELEBRATION_TASK_AWARD)[1]
    --self.mTargetAwardItem=PropsGrid:createByData({ tid = taskAwardList[1], num = taskAwardList[2], parent = self.mTargetAwardTrans, scale = 1, showUseInTip = true })
    self:updateProgress()

end

function updateProgress(self)
    local taskNeedNum=sysParam.SysParamManager:getValue(SysParamType.CELEBRATION_TASK_AWARD_NEED_COUNT)
    local curTaskOverNum=Celebration.CelebrationManager:getTaskOverNum()<=taskNeedNum and Celebration.CelebrationManager:getTaskOverNum() or taskNeedNum
    local isoK=(curTaskOverNum>=taskNeedNum and Celebration.CelebrationManager:getTargetState()==Celebration.CelebrationConst.AwardState.Nomal) 
    self.mImgTargetIng:SetActive(Celebration.CelebrationManager:getTargetState()==Celebration.CelebrationConst.AwardState.Nomal and not isoK)
    self.mBtnTargetRecive:SetActive(isoK) 
    self.mAwardEff:SetActive(not (not self.mImgTargetIng.activeSelf and not self.mBtnTargetRecive.activeSelf))
    self.mImgTargetRecived:SetActive((not self.mImgTargetIng.activeSelf and not self.mBtnTargetRecive.activeSelf))
    self.mTxtTargetTaskDes.text=_TT(121008,taskNeedNum)
    self.mImgTargetBar.fillAmount=curTaskOverNum/taskNeedNum
    self.mTxtTargetTaskProgress.text=_TT(45013,curTaskOverNum,taskNeedNum)
end

function createDayItem(self,isInit)
    self:clearDayItem()
    self:recoverSn()
    local UnlockDay=Celebration.CelebrationManager:getCurUnLockDay()
    local selectDay=UnlockDay
    for i = 1, 7, 1 do
        if Celebration.CelebrationManager:getIsRedByDay(i) then
            selectDay=i
        end
        local item = SimpleInsItem:create(self.mDayItem,self.mDayTrans,"celebrationTaskDay"..i)
        item:addUIEvent("mBtnClick",function ()
            if item:getChildGO("mImgLock").activeSelf then
                gs.Message.Show("暂未解锁")
                return
            end
            if self.mCurDay ~= i then
                self:updateViewList(i)
            end
        end)
        item:getGo():SetActive(false)
        item:getChildGO("mSelectState"):SetActive(i==self.mCurDay)
        item:getChildGO("mImgLock"):SetActive(i>UnlockDay)
        item:getChildGO("mTxtName"):GetComponent(ty.Text).text=i.._TT(152)
        local performAni = function()
            if (not gs.GoUtil.IsCompNull(item:getGo():GetComponent(ty.Animator))) then
                item:getGo():SetActive(true)
                item:getGo():GetComponent(ty.Animator):SetTrigger("show")
            end
        end
        table.insert(self.mSnLists, LoopManager:addFrame(7 + i * 2, 1, self, performAni))
        table.insert(self.mDayItemList,item)
    end

    self:updateViewList(selectDay,isInit)
end

function recoverSn(self)
    if next(self.mSnLists) then
        for _, sn in pairs(self.mSnLists) do
            LoopManager:removeFrameByIndex(sn)
        end
        self.mSnLists = {}
    end
end

function updateViewList(self,day,isInit)
    -- if day and self.mCurDay~=day then
    --     self:clearScrollerItem()
    -- end
    self.mCurDay = day or self.mCurDay
    for i, dayItem in ipairs(self.mDayItemList) do
        dayItem:getChildGO("mSelectState"):SetActive(self.mCurDay==i)
    end
    self:updateList(isInit)
end

function updateList(self,isInit)
    self:updateTargetTaskInfo()
    for i, dayItem in ipairs(self.mDayItemList) do
        local isRed = Celebration.CelebrationManager:getIsRedByDay(i)
        if isRed then
            RedPointManager:add(dayItem:getChildTrans("root"), nil, 34, 10)
        else
            RedPointManager:remove(dayItem:getChildTrans("root"))
        end
    end
    self.mBtnGetAll:SetActive(#Celebration.CelebrationManager:getCanReciveListByDay(self.mCurDay)>0)
    gs.TransQuick:SizeDelta02(self.mLyScroller.gameObject:GetComponent(ty.RectTransform),
     #Celebration.CelebrationManager:getCanReciveListByDay(self.mCurDay)>0 and  457 or 532)


    local list = Celebration.CelebrationManager:getCelebrationTaskListByDay(self.mCurDay)
    if isInit then
        for i = 1, #list do
            list[i].tweenId =i/2
        end
        self:setTimeout(3 * 0.02, function() self.mLyScroller.DataProvider = list end)
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
        self.mLyScroller:JumpToTop()
    end
    self:updateProgress()
end

--查看莉丽拉皮肤
function onClickLockHandler(self)
    local fashionInfo=sysParam.SysParamManager:getValue(SysParamType.CELEBRATION_TASK_FASHION_INFO)
    GameDispatcher:dispatchEvent(EventName.OPEN_SKIN_SHOW_ONE_VIEW, {heroTid = fashionInfo[1], fashionId = fashionInfo[2], isShow3D = true})
end

function clearScrollerItem(self)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

function clearDayItem(self)
    if #self.mDayItemList>0 then
        for _, dayItem in ipairs(self.mDayItemList) do
            RedPointManager:remove(dayItem:getChildTrans("root"))
            dayItem:poolRecover()
            dayItem=nil
        end
        self.mDayItemList={}
    end
end

function clearTargetAwardItem(self)
    if self.mTargetAwardItem then
        self.mTargetAwardItem:poolRecover()
        self.mTargetAwardItem=nil
    end
end

function clearItem(self)
    if #self.mAwardItemList>0 then
        for _, awardItem in ipairs(self.mAwardItemList) do
            awardItem:poolRecover()
            awardItem=nil
        end
        self.mAwardItemList={}
    end
end
return _M