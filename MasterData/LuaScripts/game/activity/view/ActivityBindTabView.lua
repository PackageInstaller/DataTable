module("game.activity.view.ActivityBindTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("purchase/ActivityBindTabView.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)

end

function initData(self)
    --self.mAniList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(activity.ActivityBindTaskItem)
    self.mTxtCode = self:getChildGO("mTxtCode"):GetComponent(ty.Text)
    self.mBtnBindLink = self:getChildGO("mBtnBindLink")
    self.mBtnCopy = self:getChildGO("mBtnCopy")
    self.mTxtCopy = self:getChildGO("mTxtCopy"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mHeadContent = self:getChildTrans("mHeadContent")
    self.mBtnOther = self:getChildGO("mBtnOther")

    self.mImgInfo = self:getChildGO("mImgInfo")
    self.mTxtInfo = self:getChildGO("mTxtInfo"):GetComponent(ty.Text)

    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtOtherName = self:getChildGO("mTxtOtherName"):GetComponent(ty.Text)
end

function initViewText(self)
    self.mTxtCopy.text = _TT(41779)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBindLink,self.onBtnBindLinkClick)
    self:addUIEvent(self.mBtnOther,self.onBtnOtherClick)
    self:addUIEvent(self.mBtnCopy,self.onBtnCopyClick)
end

function onBtnBindLinkClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_JOINT_OPS_APPLY_LIST)
    --GameDispatcher:dispatchEvent(EventName.REQ_JOINT_OPS_APPLY_LIST)
end

function onBtnOtherClick(self)
    local jointPlayerInfo = activity.ActitvityExtraManager:getJointPlayerInfo()
    if jointPlayerInfo.player_id ~= "0" then
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_JOINT_BIND_TIPS)
end

function onBtnCopyClick(self)
    gs.SdkManager:Copy(activity.ActitvityExtraManager:getJointShowCode())
    local pasteResult = gs.SdkManager:Paste()
    if (pasteResult == "") then
        gs.Message.Show(_TT(25104)) -- "复制失败"
    else
        gs.Message.Show(string.format(_TT(25105), pasteResult)) -- "复制成功：%s"
    end
end
--激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_JOINT_BIND_INFO, self.showPanel, self)
    GameDispatcher:addEventListener(EventName.UPDATE_JOINT_BIND_TASK, self.showPanel, self)
    self:showPanel()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_JOINT_BIND_INFO, self.showPanel, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_JOINT_BIND_TASK, self.showPanel, self)
    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end

    if self.mOtherPlayerHeadGrid then
        self.mOtherPlayerHeadGrid:poolRecover()
        self.mOtherPlayerHeadGrid = nil
    end

    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end

    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

function showPanel(self)
    local list = activity.ActitvityExtraManager:getBindData()
    for i = 1, #list, 1 do
        list[i].tweenId = 2 + (i-1)*2.5
    end
    if (self.mLyScroller.Count <= 0) then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end

    local type = activity.ActitvityExtraManager:getJointPlayerType()
    self.mTxtInfo.text = type == 1 and _TT(41780) or _TT(41781)



    local roleVo = role.RoleManager:getRoleVo()
    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end

    self.mPlayerHeadGrid = PlayerHeadGrid:create(self.mHeadContent, roleVo:getAvatarId(), 1, false)
    self.mPlayerHeadGrid:setHeadFrame(roleVo:getAvatarFrameId())
    self.mPlayerHeadGrid:setLvl(roleVo:getPlayerLvl())
    self.mPlayerHeadGrid:setScale(1)
    self.mPlayerHeadGrid:setClickEnable(false)

    self.mTxtName.text = roleVo:getPlayerName()
    self.mTxtCode.text = _TT(41782)..activity.ActitvityExtraManager:getJointShowCode()


    local jointPlayerInfo = activity.ActitvityExtraManager:getJointPlayerInfo()
    self.mTxtOtherName.text = jointPlayerInfo.player_name

    if self.mOtherPlayerHeadGrid then
        self.mOtherPlayerHeadGrid:poolRecover()
        self.mOtherPlayerHeadGrid = nil
    end
    self.mBtnBindLink:SetActive(jointPlayerInfo.player_id == "0")
    
    if jointPlayerInfo.player_id ~= "0" then
        self.mOtherPlayerHeadGrid = PlayerHeadGrid:create(self.mBtnOther.transform, jointPlayerInfo.avatar_id, 1, false)
        self.mOtherPlayerHeadGrid:setHeadFrame(jointPlayerInfo.avatar_frame)
        self.mOtherPlayerHeadGrid:setLvl(jointPlayerInfo.player_lv)
        self.mOtherPlayerHeadGrid:setScale(1)
        self.mOtherPlayerHeadGrid:setCallBack(self, self.__onClickHeadHandler)
    end
    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end

    self:updateTime()
    self.updateTimeSn = LoopManager:addTimer(1, 0, self, self.updateTime)
   
    local isRed = activity.ActitvityExtraManager:getBindApplyIsRedState()
    if isRed then
        RedPointManager:add(self.mBtnBindLink.transform, nil, 27, 31)
    else
        RedPointManager:remove(self.mBtnBindLink.transform)
    end
end

function __onClickHeadHandler(self)
    local jointPlayerInfo = activity.ActitvityExtraManager:getJointPlayerInfo()
    GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = jointPlayerInfo.player_id })
end
function updateTime(self)
    if activity.ActivityManager:getActivityVoById(activity.ActivityId.Bind) then
        local clientTime = GameManager:getClientTime()
        local remainingTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.Bind):getEndTime() -
                                  clientTime
        local timeTxt = remainingTime <= 0 and "活动已结束" or _TT(94557)..TimeUtil.getFormatTimeBySeconds_9(remainingTime)

        self.mTxtTime.text = timeTxt

        if remainingTime <= 0 then
            LoopManager:removeTimerByIndex(self.updateTimeSn)
            self.updateTimeSn = nil
            -- self:close()
            return
        end
    end
end

return _M