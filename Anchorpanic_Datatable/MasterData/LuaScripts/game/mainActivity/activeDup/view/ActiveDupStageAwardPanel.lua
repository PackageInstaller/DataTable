-- 1.1副本活动
module("mainActivity.ActiveDupStageAwardPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("mainActivity/ActiveDupStageAwardPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 1

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(2914))
end

function initData(self)

end

function configUI(self)
    super.configUI(self)
    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(mainActivity.ActiveDupStageAwardItem)
    self.mScrollerRec = self:getChildGO("mLyScroller"):GetComponent(ty.RectTransform)
    self.mTxtActiveTime = self:getChildGO("mTxtActiveTime"):GetComponent(ty.Text)
    self.mGroupRecAll = self:getChildGO("mGroupRecAll")
    self.mBtnRecAll = self:getChildGO("mBtnRecAll")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRecAll, self.recAllAward)
end

function recAllAward(self)
    GameDispatcher:dispatchEvent(EventName.REQ_ACTIVEDUP_ALL_AWARD)
end

function active(self, args)
    super.active(self, args)
    mainActivity.ActiveDupManager.scrollHeight = self.mScrollerRec.sizeDelta.y
    mainActivity.ActiveDupManager:addEventListener(mainActivity.ActiveDupManager.EVENT_STAGE_AWARD_UPDATE, self.updateView, self)
    self:updateView()
end

function updateView(self)
    self.mStageAwardList = mainActivity.ActiveDupManager:getMsgAwardList()
    local activeData = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.DifficultyLevel)
    self.mGroupRecAll:SetActive(mainActivity.ActiveDupManager:getCanRecAll())
    -- self.mGroupRecAll:SetActive(true)
    local height
    if self.mGroupRecAll.activeSelf == true then
        height = mainActivity.ActiveDupManager.scrollHeight - self.mGroupRecAll:GetComponent(ty.RectTransform).rect.height / 2
    else
        height = mainActivity.ActiveDupManager.scrollHeight
    end
    gs.TransQuick:SizeDelta02(self.mScrollerRec, height)

    self.mTxtActiveTime.text = "活动结束时间： " .. TimeUtil.getFormatTimeBySeconds_7(activeData.endTime)
    for k, v in pairs(self.mStageAwardList) do
        v.tweenId = k / 2
    end
    if self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = self.mStageAwardList
    else
        self.mLyScroller:ReplaceAllDataProvider(self.mStageAwardList)
    end
end

function deActive(self)
    super.deActive(self)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
    mainActivity.ActiveDupManager:removeEventListener(mainActivity.ActiveDupManager.EVENT_STAGE_AWARD_UPDATE, self.updateView, self)
end

return _M
