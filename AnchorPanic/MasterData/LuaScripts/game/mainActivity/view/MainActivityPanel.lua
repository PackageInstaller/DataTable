--[[-----------------------------------------------------
@filename       : MainActivityPanel
@Description    : 活动主界面
@date           : 2023-5-22 15:59:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]] module("mainActivity.MainActivityPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("mainActivity/MainActivityPanel.prefab")
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAddMask = 0
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isShowBlackBg = 0 -- 是否显示全屏纯黑防穿帮底图
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("activity_main_bg_01.png", false, "mainActivity")
    self:setTxtTitle(_TT(92009))
    self:setUICode(LinkCode.MainActivity)
end
-- 初始化数据
function initData(self)
    super.initData(self)
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.mAni = self.UIObject:GetComponent(ty.Animator)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)

    self.mBtnGamePlay = self:getChildGO("mBtnGamePlay")
    self.mGroupbottom = self:getChildTrans("mGroupbottom")
end
-- 激活
function active(self, args)
    super.active(self, args)
    local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.ACTIVITY_ANIM)
    local aniState = isNotRemind and "enter" or "enter01"
    self.mAni:SetTrigger(aniState)
    if not isNotRemind then
        GameDispatcher:dispatchEvent(EventName.REQ_ADD_NOT_REMIND, {
            moduleId = RemindConst.ACTIVITY_ANIM
        })
    end

    mainActivity.MainActivityManager:setIsFirstEnter()
    MoneyManager:setMoneyTidList({})

    GameDispatcher:addEventListener(EventName.ACTIVITY_OPEN_UPDATE, self.updateView, self)
    GameDispatcher:addEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.updateView, self)
    GameDispatcher:addEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updateRedFlag, self)

    self:updateTime()
    self:addTimer(1, 0, self.updateTime)
    self:updateView()

    local linkCode = sandPlay.SandPlayManager:getLinkCode()
    if linkCode then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
            linkId = linkCode
        })
        sandPlay.SandPlayManager:setLinkCode(nil)
    end
end
-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.ACTIVITY_OPEN_UPDATE, self.updateView, self)
    GameDispatcher:removeEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.updateView, self)
    GameDispatcher:removeEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updateRedFlag, self)

    self:removeRedFlag()
    self:clearBottomBtns()
end

function updateTime(self)
    local mainActivityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.MainActivity)
    self.mTxtTime.text = mainActivityVo:getRemainingTime() .. _TT(85015)
    if mainActivityVo:getTimeRemaining() <= 0 then
        self:onClickClose()
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    for _, btnVo in ipairs(MainActivityConst.getBtnList()) do
        local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(btnVo.activity_id)
        self:addUIEvent(self:getChildGO(btnVo.btnName), self.onClickOpenViewHandler, nil, activityVo)
    end
end

--[[    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

function onClickOpenViewHandler(self, activityVo)
    if activityVo:getTimeRemaining() <= 0 then
        gs.Message.Show("活动已结束") -- 活动已结束
        return
    elseif not activityVo:getIsCanOpen() then
        gs.Message.Show(activityVo:getLockDec()) -- 未到活动时间
        return
    end

    for _, activity_id in pairs(MainActivityConst.bottomBtns) do
        if activityVo.id == activity_id then
            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
                linkId = activityVo:getUiCode(),
                param = {
                    activity_id = activityVo.id
                }})
                return
            end
        end

        if activityVo:getUiCode() == LinkCode.ActiveDeepDup then
            local newestDupId = mainActivity.ActiveDupManager:getNewestDupId(mainActivity.ActiveDupStyleType.Easy)
            if newestDupId >= mainActivity.ActiveDupManager:getFirstDupByStype(mainActivity.ActiveDupStyleType.Easy) then
                mainActivity.ActiveDupManager:setStyle(mainActivity.ActiveDupStyleType.Difficulty)
                GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
                linkId = activityVo:getUiCode()})
            else
                gs.Message.Show("通关普通关卡后开启")
            end
        elseif activityVo:getUiCode() == LinkCode.ActiveDeepHell then
            local newestDupId = mainActivity.ActiveDupManager:getNewestDupId(mainActivity.ActiveDupStyleType.Difficulty)
            if newestDupId >= mainActivity.ActiveDupManager:getFirstDupByStype(mainActivity.ActiveDupStyleType.Difficulty) then
                mainActivity.ActiveDupManager:setStyle(mainActivity.ActiveDupStyleType.Hard)
                GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
                linkId = activityVo:getUiCode()})
            else
                gs.Message.Show("通关困难关卡后开启")
            end
        elseif activityVo:getUiCode() ~= LinkCode.MainActivityTrial then
            local aniTime = AnimatorUtil.getAnimatorClipTime(self.mAni, "MainActivityPanel_Exit")
            self.mAni:SetTrigger("exit")
            self:addTimer(aniTime / 1.8, 1, function()
                if activityVo.id == activity.ActivityId.NomalLevel or activityVo.id == activity.ActivityId.DifficultyLevel or
                    activityVo.id == activity.ActivityId.HellLevel then
                    local prefixVersion =
                    download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.PrefixVersionKey)
                    local style = battleMap.MainMapStyleType.Easy
                    if activityVo.id == activity.ActivityId.NomalLevel then
                        style = battleMap.MainMapStyleType.Easy
                    elseif activityVo.id == activity.ActivityId.DifficultyLevel then
                        style = battleMap.MainMapStyleType.Difficulty
                    elseif activityVo.id == activity.ActivityId.HellLevel then
                        style = battleMap.MainMapStyleType.SuperDifficulty
                    end

                    if not StorageUtil:getBool1(prefixVersion .. "mainActivity" .. style) then
                        StorageUtil:saveBool1(prefixVersion .. "mainActivity" .. style, true)
                        GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
                    end
                end
                GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
                linkId = activityVo:getUiCode()})
            end)
        else

            GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
            linkId = activityVo:getUiCode()})
        end
    end

    function updateView(self)
        local creatBtn = function(btnVo, activityVo)
            local item = SimpleInsItem:create2(self:getChildGO(btnVo.btnName))
            item:getChildGO("Text"):SetActive(activityVo:getIsCanOpen())
            item:getChildGO("mImgLockBg"):SetActive((not activityVo:getIsCanOpen()))
            item:getChildGO("mTxtProgress"):GetComponent(ty.Text).text = btnVo.progress
            self:setBtnLabel(item:getGo(), activityVo:getNameId(), activityVo:getName())
            item:getChildGO("mTxtLock"):GetComponent(ty.Text).text = activityVo:getLockDec()
            item:getChildGO("mTxtProgress"):SetActive((btnVo.progress ~= nil) and activityVo:getIsCanOpen())
            local mImgBg = item:getChildGO("mImgBg")
            if mImgBg then
                mImgBg:GetComponent(ty.CanvasGroup).alpha = activityVo:getIsCanOpen() and 1 or 0.6
            end
        end

        for _, btnVo in ipairs(MainActivityConst.getBtnList()) do
            local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(btnVo.activity_id)
            if activityVo:getTimeRemaining() > 0 then
                creatBtn(btnVo, activityVo)
            end
        end

        self:createBottomBtn()

        self:updateRedFlag()
    end

    function createBottomBtn(self)
        self:clearBottomBtns()
        for _, activity_id in pairs(MainActivityConst.bottomBtns) do
            local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity_id)
            local isOpen = activityVo:getIsCanOpen()
            if isOpen and activityVo:getTimeRemaining() > 0 then
                local isBubble = MainActivityConst.getActivityRedState(activity_id)
                local item = SimpleInsItem:create(self.mBtnGamePlay, self.mGroupbottom, "mainActivity_bottomBtn")
                item:getGo().name = "mBtnGamePlay"..activity_id
                if isBubble then
                    RedPointManager:add(item:getTrans(), nil, 82.5, 40.5)
                else
                    RedPointManager:remove(item:getTrans())
                end 
                item:addUIEvent(nil, function()
                    self:onClickOpenViewHandler(activityVo)
                end)
                self.mBottomBtnList[activity_id] = item
                item:getChildGO("mImgLockBg"):SetActive((not isOpen))
                self:setBtnLabel(item:getGo(), activityVo:getNameId(), activityVo:getName())
                item:getChildGO("mTxtLock"):GetComponent(ty.Text).text = activityVo:getLockDec()

                local mImgBg = item:getChildGO("mImgBg")
                if mImgBg then
                    mImgBg:GetComponent(ty.CanvasGroup).alpha = activityVo:getIsCanOpen() and 1 or 0.6
                end
            end
        end
    end

    function clearBottomBtns(self)
        if self.mBottomBtnList then
            for _, btn in pairs(self.mBottomBtnList) do
                RedPointManager:remove(btn:getTrans())
                btn:recover()
            end
        end

        self.mBottomBtnList = {}
    end

    -- 更新主UI红点信息--isActivityLimit是否是显示活动
    function updateRedFlag(self)
        for _, btnVo in ipairs(MainActivityConst.getBtnList()) do
            local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(btnVo.activity_id)
            local isBubble = MainActivityConst.getActivityRedState(btnVo.activity_id)
            local isFlag = isBubble and activityVo:getIsCanOpen()
            if isFlag then
                self:addBubble(btnVo)
            else
                self:removeBubble(btnVo)
            end
        end

        for _, activity_id in pairs(MainActivityConst.bottomBtns) do
            local btnItem = self.mBottomBtnList[activity_id]
            if btnItem then
                local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity_id)

                local isBubble, red_type = MainActivityConst.getActivityRedState(activity_id)
                local isFlag = isBubble and activityVo:getIsCanOpen()
                if isFlag then
                    if red_type == 1 then
                        btnItem:getChildGO("mRedTrans"):SetActive(true)
                        RedPointManager:remove(btnItem:getTrans())
                    elseif red_type == 2 then
                        btnItem:getChildGO("mRedTrans"):SetActive(false)
                        RedPointManager:add(btnItem:getTrans(), nil, 59, 27)
                    end
                else
                    btnItem:getChildGO("mRedTrans"):SetActive(false)
                    RedPointManager:remove(btnItem:getTrans())
                end
            end
        end
    end

    function destroyPanel(self)

    end

    function addBubble(self, btnVo)
        if btnVo.activity_id == activity.ActivityId.Sign then
            RedPointManager:add(self:getChildTrans(btnVo.btnName), nil, 90.4, 23.5)
        elseif btnVo.activity_id == activity.ActivityId.Task then
            RedPointManager:add(self:getChildTrans(btnVo.btnName), nil, 90.4, 23.5)
        elseif btnVo.activity_id == activity.ActivityId.TrialPlayLevel then
            RedPointManager:add(self:getChildTrans(btnVo.btnName), nil, 49.7, 23.5)
        else
            RedPointManager:add(self:getChildTrans(btnVo.btnName), nil, 87, 0)
        end
    end

    function removeBubble(self, btnVo)
        RedPointManager:remove(self:getChildTrans(btnVo.btnName))
    end

    function removeRedFlag(self)
        for _, btnVo in ipairs(MainActivityConst.getBtnList()) do
            self:removeBubble(btnVo)
        end
    end

    -- 重置界面计时器
    function restViewTime(self)
        self:removeAllTimer()
        self.mAni:SetTrigger("enter")
    end

    return _M

    --[[ 替换语言包自动生成，请勿修改！
]]
