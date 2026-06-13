local MainUICtrl = BaseClass("MainUICtrl", BaseUICtrl)
local M = MainUICtrl
local MessageId = Proto.MessageId
local EBattleStyle = EnumConst.EBattleStyle

function M:Init()
    -- 中间按钮
    self._view.rectFormation:onClick(Bind(self, self.OnFormationClick))
    self._view.rectBattle:onClick(Bind(self, self.OnBattleClick))
    self._view.rectSevenGoal:onClick(Bind(self, self.OnSevenGoalClick))
    self._view.rectCombatants:onClick(Bind(self, self.OnCombatantsClick))
    self._view.rectShop:onClick(Bind(self, self.OnShopClick))
    self._view.rectDormitory:onClick(Bind(self, self.OnDormitoryClick))
    self._view.rectStory:onClick(Bind(self, self.OnBackStoryClick))

    -- 左下按钮
    self._view.rectSettings:onClick(Bind(self, self.OnSettingsClick))
    -- self._view.rectMail:onClick(Bind(self, self.OnMailClick))
    -- self._view.rectSign:onClick(Bind(self, self.OnSignClick))
    self._view.rectNotice:onClick(Bind(self, self.OnNoticeClick))
    self._view.rectReplace:onClick(Bind(self, self.OnReplaceClick))
    self._view.BtnSkin:onClick(Bind(self, self.OnSkinClick))
    self._view.QQButton:onClick(Bind(self, self.OnQQButton))
    self._view.MusicBoxBtn:onClick(Bind(self, self.OnMusicBoxBtn))

    -- 右下按钮
    self._view.rectActivity:onClick(Bind(self, self.OnActivityClick))
    self._view.rectNetwork:onClick(Bind(self, self.OnNetworkClick))
    -- self._view.rectBacklog:onClick(Bind(self, self.OnBacklogClick))
    self._view.rectWarehouse:onClick(Bind(self, self.OnWarehouseClick))
    self._view.rectFriend:onClick(Bind(self, self.OnFriendClick))
    self._view.rectPass:onClick(Bind(self, self.OnPassClick))
    self._view.achievement:onClick(Bind(self, self.OnAchievementClick))
    self._view.btnSkill:onClick(Bind(self, self.OnSkillClick))
    -- self._view.sevenLogin:onClick(Bind(self, self.OnLoginRewardClick)) -- 七日登陆
    self._view.awakeTask:onClick(Bind(self, self.OnAwakeTaskClick))

    -- 左上按钮
    self._view.rectAccount:onClick(Bind(self, self.OnAccountClick))
    self._view.btnVoting:onClick(Bind(self, self.OnClickVoting))  -- 票选按钮
    self._view.rectReward:onClick(Bind(self, self.OnClickReward)) -- 悬赏按钮
    self._view.FirstRechargeBtn:onClick(Bind(self, self.OnClickFirstRecharge))
    self.m_PanelLRedPointList = self._view.panel_L:GetAllRedPoint()
    self.m_PanelRRedPointList = self._view.panel_R:GetAllRedPoint()
    self.m_PanelTopRedPointList = self._view.panel_Top:GetAllRedPoint()
    local energyHandler = Bind(self, self.OnChangedEnergy)
    self._view.energyTimer.onComplete = energyHandler
    self._energyChanged = EventMgr:AddListener(UIMessageNames.ENERGY_CHANGED_NOTIFY, energyHandler)
    self._bannerChanged = EventMgr:AddListener(UIMessageNames.BANNER_ITEM, Bind(self, self.InitBanner))
    self.RechargeStateHandler = EventMgr:AddListener(UIMessageNames.RECHARGE_STATE_UPDATE,
        Bind(self, self.InitFirstRecharge))
    self.OnMainMaskHandle = Bind(self, self.SetMainMask)
    IGameEventMgr:RegisterEventHandleByTypeName("MainMask", self.OnMainMaskHandle)
    self._notifyLevelChange = NetPack:RegistResponse(MessageId.NotifyLevelChange, Bind(self, self.OnNotifyLevelChange))
    self.m_itemTag = ItemDataMgr:GetInstance():AddItemChange(2, Bind(self, self.OnExpChange))
    GameKeyNodeMgr:GetInstance():Record(EGameKeyNode.LoginGameToMainScene)
    self.minTime = GameHelper.GetParamters(294)[0] / 100
    self.maxTime = GameHelper.GetParamters(295)[0] / 100
    self._view.btnActive:onClick(Bind(self, self._OnClickBtn))
end

function M:OnDispose()
    self:_StopExpRefreshTimer()
    self:StopPresentReturnTimer()
    self:StopRepresentFixedTimer()
    self._view.energyTimer.onComplete = nil
    EventMgr:RemoveListener(UIMessageNames.ENERGY_CHANGED_NOTIFY, self._energyChanged)
    EventMgr:RemoveListener(UIMessageNames.BANNER_ITEM, self._bannerChanged)
    EventMgr:RemoveListener(UIMessageNames.RECHARGE_STATE_UPDATE, self.RechargeStateHandler)
    IGameEventMgr:UnRegisterEventHandleByTypeName("MainMask", self.OnMainMaskHandle)
    NetPack:UnRegistResponse(MessageId.NotifyLevelChange, self._notifyLevelChange)
    ItemDataMgr:GetInstance():RemoveItemChangeByTag(self.m_itemTag)
    M.super.OnDispose(self)
end

function M:OnEnter()
    -- 初始化
    self:_SetLockMaskActive()

    self:_InitAccountData()
    self:InitBanner()
    -- --抽卡的表演形式  有限时卡池的话播放video 没有的话就用图片
    -- local videoPath = LotteryHelper.GetActivePoolView()
    -- if videoPath == nil then
    --     self._view.chouka_Image:SetActive(true)
    --     self._view.media.gameObject:SetActive(false)
    -- else
    --     self._view.chouka_Image:SetActive(false)
    --     self._view.media.gameObject:SetActive(true)
    --     self:_InitVideo(videoPath)
    -- end
    ActivityDataMgr:GetInstance():UpdateActivityData()
    self:_ActivityButtonState()
    self:_InitFormationGroupIcon()
    self:_InitBattleBannerAndProgress()
    self:_InitCombatantsRatio()

    self.isOpenLimitBattle = true
    self:_CheckLimitBattleState()
    -- 体力系统
    self:OnChangedEnergy()
    self:CheckPresentReturn()
    self:CheckRepresentFixed()
    self:InitBattery()
    self:InitAvtivity()
    self:InitVoting()
    self:InitReward()
    self:InitPassCard()
    self:InitFirstRecharge()
    self:InitBackStory()
    self:OnVisible()
    self:InitMailButton()
    self:CheckRewardPanel()
    self:HandlerRedpoint()
end

function M:HandlerRedpoint()
    coroutine.start(function()
        coroutine.waitforseconds(0.5)
        IRedPointMgr:ForceCheck(RedPointConst.DormHeroRedPoint)
        IRedPointMgr:ForceCheck(RedPointConst.DormPuzzleRedPointChecker)
    end)
end

function M:OnClose()
    self:_StopExpRefreshTimer()
    self:StopPresentReturnTimer()
    self:StopRepresentFixedTimer()
end

function M:InitBanner()
    self._view.BannerContant:Init()
end

-- 假面舞会
function M:InitAvtivity()
    self._view.UIActivityItem1Ctrl:UpdateData()
end

-- 票选活动
function M:InitVoting()
    local votingOpen = VotingDataMgr:GetInstance():IsOpen()
    self._view.btnVoting:SetActive(votingOpen and true or false)
end

function M:InitReward()
    for _, v in ipairs(ActivityDataMgr:GetInstance():GetActivitySimpleByType(ActivityType.OFFER_ACTIVITY_COPY) or {}) do
        if v:IsOpen() then
            self._view.rectReward:SetActive(true)
            return
        end
    end
    self._view.rectReward:SetActive(false)
end

function M:InitPassCard()
    for _, v in ipairs(ActivityDataMgr:GetInstance():GetActivitySimpleByType(ActivityType.PASS_MAIN) or {}) do
        if v:IsOpen() then
            self._view.rectPass:SetActive(true)
            return
        end
    end
    self._view.rectPass:SetActive(false)
end

function M:InitFirstRecharge()
    local firstRechargeState = RechargeDataMgr:GetInstance():CheckFirstRechargeReward()
    if firstRechargeState ~= nil then
        self._view.FirstRechargeBtn:SetActive(true)
    else
        self._view.FirstRechargeBtn:SetActive(false)
    end
end

function M:InitBackStory()
    for _, v in ipairs(ActivityDataMgr:GetInstance():GetActivitySimpleByType(ActivityType.BACKSTORY) or {}) do
        if v:IsOpen() then
            self._view.rectStory:SetActive(true)
            return
        end
    end
    self._view.rectStory:SetActive(false)
end

function M:CheckRewardPanel()
    local context = UIContextMgr:GetInstance():GetContext("MissionOfferRewards")
    if context and context:IsBattleBack() then self:OnClickReward() end
end

function M:InitBattery()
    local isCharging = GameHelper.GetBatteryStatus()
    local batteryPercent = GameHelper.GetBatteryLevel()
    local isWifi = GameHelper.GetWifiStauts()
    self._view.BatteryImage:SetFillAmount(batteryPercent)
    if isCharging then
        self._view.BatteryState:SetState(3)
    else
        if batteryPercent > 0.2 then
            self._view.BatteryState:SetState(1)
        else
            self._view.BatteryState:SetState(2)
        end
    end
    if isWifi then
        self._view.SignalState:SetState(2)
    else
        self._view.SignalState:SetState(1)
    end
end

-- 宿舍固定时段剧情
function M:CheckRepresentFixed()
    if PresentReturnDataMgr:CheckHeroDormActive() then
        local trigger, eventId = PresentReturnDataMgr:CheckRepresentFixedTrigger()
        if trigger then
            PresentReturnDataMgr:RequestRepresentFixedTrigger(eventId, Bind(self, self.RepresentFixedTriggerCallback))
        else
            self.representFixedTimer = TimerManager:GetInstance():GetTimer(120, Bind(self, self.RepresentFixedTick), self)
            self.representFixedTimer:Start()
        end
    end
end

-- 宿舍固定时段计时
function M:RepresentFixedTick()
    local trigger, eventId = PresentReturnDataMgr:CheckRepresentFixedTrigger()
    if trigger then
        self.representFixedTimer:Stop()
        self.representFixedTimer = nil
        PresentReturnDataMgr:RequestRepresentFixedTrigger(eventId, Bind(self, self.RepresentFixedTriggerCallback))
    end
end

-- 触发宿舍固定时段剧情回调
function M:RepresentFixedTriggerCallback(msg)
    -- 成功触发，更新红点
    IRedPointMgr:ForceCheck(RedPointConst.DormHeroRedPoint)
end

-- 回礼判断
function M:CheckPresentReturn()
    local trigger = PresentReturnDataMgr:CheckHeroRePresent()
    if trigger then
        self.randomTime = math.random(self.minTime, self.maxTime) + PresentReturnDataMgr.curTimer
        self:StopPresentReturnTimer()
        self.presentReturnTimer = TimerManager:GetInstance():GetTimer(60, Bind(self, self.PresentReturnTick), self)
        self.presentReturnTimer:Start()
    end
end

-- 回礼计时
function M:PresentReturnTick()
    local realtime = Time.realtimeSinceStartup
    if realtime > self.randomTime then
        self.presentReturnTimer:Stop()
        self.presentReturnTimer = nil
        PresentReturnDataMgr:RequestTriggerRepresent(Bind(self, self.CheckPresentReturn))
    end
end

---初始化邮件按钮
function M:InitMailButton()
    local block = GameHelper.bMailLock()
    self._view.rectMail:SetState(block and 1 or 0)
end

function M:OnVisible()
    GameHelper.DoPlayerAction(PlayerAction.OpenMain)

    self:_CheckJumpBack()
    self:_ActivityButtonState()
    self:_RefreshRedPoints()
    self:_SetNickName()
    local module = ModuleMgr:GetInstance().GetCurrentModule()
    if module and module.CheckShowGirl then
        module:CheckShowGirl()
    end
    if module and module.SetCameraNodeActive then
        module:SetCameraNodeActive(true)
    end
end

function M:OnInvisible()
    local module = ModuleMgr:GetInstance().GetCurrentModule()
    if module and module.SetCameraNodeActive then
        module:SetCameraNodeActive(false)
    end
end

function M:OnChangedEnergy()
    local energy = EnergyMgr:GetInstance():EnergyValue()
    local energyLimit = EnergyMgr:GetInstance():EnergyLimit()
    local recTime = EnergyMgr:GetInstance():RemainWholeRecTime()
    self._view.txtEnergyNum:SetText(string.format("<size=44>%d</size>/%d", energy, energyLimit))
    self._view.energyTimer:SetActive((recTime > 0) and (energy < energyLimit))
    self._view.energyTimer:SetTime(recTime)
end

function M:_ActivityButtonState()
    local activityData = ActivityDataMgr:GetInstance():GetActivityByType(ActivityType.DAILY_GOALS)
    if not activityData then
        self._view.rectSevenGoal:SetActive(false)
    else
        self._view.rectSevenGoal:SetActive(true)
    end
end

function M:_RefreshRedPoints()
    local name = { "PanelL", "PanelR", "PanelTop" }

    local strFormat = string.format
    for i, v in ipairs(name) do
        local listName = strFormat("m_%sRedPointList", v)
        local list = self[listName]

        if list then
            self:_CheckRedPoint(list)
        end
    end
end

function M:_CheckRedPoint(data)
    local length = data.Length
    for i = 1, length do
        local index = i - 1
        local redpoint = data[index]
        redpoint:Check()
    end
end

-- 检查是否清理跳转步骤
function M:_CheckJumpBack()
    local jMgr = JumpMgr:GetInstance()
    -- 有可能经过，所以只有不大于1步则清除
    if not jMgr:IsJumpBack() then
        jMgr:ResetJumpBack()
    end
end

function M:_SetLockMaskActive()
    -- 征募Lock遮罩
    local lockId = JumpMgr:GetInstance():CheckLockByJumpId(3)
    self._view.rectRecruitmentLock:SetActive(lockId > 0)

    -- 商店Lock遮罩
    lockId = JumpMgr:GetInstance():CheckLockByJumpId(51)
    self._view.rectShopLock:SetActive(lockId > 0)
end

function M._SortActivity(data1, data2)
    return data1:ActivityId() < data2:ActivityId()
end

function M:_InitAccountData()
    self:_SetAccountLevel()
    self:_SetNickName()
    self:_SetAccountId()
    self:_ExpRefresh()
end

function M:_SetAccountLevel()
    self._view.txtLevel:SetText(tostring(IPlayerData.level))
end

function M:_SetNickName()
    local userName = tostring(IPlayerData.NickName)
    if string.startswith(userName, "guest_") then
        -- 未取名
        self._view.txtName:SetText(5841)
        return
    end
    self._view.txtName:SetText(userName)
end

function M:_SetAccountId()
    local accountId = INetPack.accountId
    self._view.txtId:SetText(tostring(accountId))
end

function M:_StopExpRefreshTimer()
    if self._expRefreshTimer then
        self._expRefreshTimer:Stop()
        self._expRefreshTimer = nil
    end
end

function M:StopPresentReturnTimer()
    if self.presentReturnTimer then
        self.presentReturnTimer:Stop()
        self.presentReturnTimer = nil
    end
end

function M:StopRepresentFixedTimer()
    if self.representFixedTimer then
        self.representFixedTimer:Stop()
        self.representFixedTimer = nil
    end
end

function M:_ExpRefresh()
    local levelCfgs = ConfigHelper.GetCfgs("homepageLevel")
    if levelCfgs then
        local len = levelCfgs.Length
        local maxLevel = levelCfgs[len - 1].id
        local curLevel = IPlayerData.level > maxLevel and maxLevel or IPlayerData.level
        local curLevelMaxExp = ConfigHelper.GetCfg("homepageLevel", curLevel).exp
        local curExp = IPlayerData.Exp
        if curLevel ~= 1 then
            local preLevel = curLevel - 1
            local preLevelExpSum = ConfigHelper.GetCfg("homepageLevel", preLevel).expSum
            curExp = curExp - preLevelExpSum
            if curExp > curLevelMaxExp then
                curExp = curLevelMaxExp
            end
        end
        local ratio = curExp / curLevelMaxExp
        self._view.imgExp:SetFillAmount(ratio)
        self:_SetAccountLevel()
    else
        Logger.LogError("homepageLevel cannot be found!!!")
    end
end

function M:_InitVideo(videoPath)
    self._view.media:Play(videoPath, true)
end

function M:_InitFormationGroupIcon()
    local teamId = IPlayerData.GetActiveTeamId + 1
    local iconPath = MainConst.FormationIconPath[teamId]
    self._view.imgGroup:SetPic(iconPath)
end

function M:_InitBattleBannerAndProgress()
    local chapterId = IPlayerData:GetMyNextChapterId()
    local chapterCfg = ConfigHelper.GetCfg("chapter", chapterId)
    if chapterCfg then
        self._view.imgBanner:SetPic(chapterCfg.mainBanner)
    end

    local missionId = IPlayerData.missionId
    local missionCfg = ConfigHelper.GetCfg("mission", missionId)
    if missionCfg then
        local missionName = ConfigHelper.GetLocalString(missionCfg.name)
        self._view.txtProgress:SetText(missionCfg.chapterLabel .. " " .. missionName)
    else
        self._view.txtProgress:SetText("")
    end
end

function M:_InitCombatantsRatio()
    local heroNum = IHeroDataMgr:GetHeros().Count
    local maxHeroNum = ConfigHelper.GetSystemParam(122)
    local percentage = heroNum / maxHeroNum
    percentage = math.floor(percentage * 100)
    self._view.txtRatio:SetText(percentage .. "<size=46>%</size>")
end

function M:_CheckLimitBattleState()
    if self.isOpenLimitBattle then
        ActivityDataMgr:GetInstance():GetActivitysByTypeAsyn(ActivityType.TIME_LIMIT_PVE, function(datas)
            if datas == nil or #datas == 0 then
                self.isOpenLimitBattle = false
                self._view.missionState1:SetActive(false)
                self._view.missionState2:SetActive(false)
                return
            end

            local activity = nil
            for _, data in ipairs(datas) do
                if data:RemainTimes() > 0 then
                    if not activity or activity:EndTime() < data:EndTime() then
                        activity = data
                    end
                end
            end

            if not activity then
                self.isOpenLimitBattle = false
                self._view.missionState1:SetActive(false)
                self._view.missionState2:SetActive(false)
                return
            end

            local cfgs = ConfigHelper.GetCfgsByLua("activityDouble", { activityId = activity:ActivityId() })
            if cfgs ~= nil and #cfgs > 0 then
                local endTick = TimeUtil.TimeStampToDateTime(activity:EndTime())
                -- 格林威治时间戳
                self._view.missionState1Time:SetTime(CS.TimeTools.ConvertToCsStampToGo(endTick))
                self._view.missionState1Time.onComplete = function()
                    -- self._view.missionState1.SetActive(false)
                    -- self._view.missionState2:SetActive(false)
                    self.isOpenLimitBattle = false
                    self:_CheckLimitBattleState()
                    self._view.missionState1Time.onComplete = nil
                end
                self._view.missionState1:SetActive(true)
                self._view.missionState2:SetActive(false)
                self.isOpenLimitBattle = true
            end
        end)
    end
end

function M:OnNotifyLevelChange(messageId, result, msg)
    if result ~= 0 then
        return
    end
    self:_SetLockMaskActive()
    self:_SetAccountLevel()
end

function M:OnExpChange(itemId, preExp, nextExp)
    self:_StopExpRefreshTimer()
    self._expRefreshTimer = TimerManager:GetInstance():GetTimer(0.1, self._ExpRefresh, self, true)
    self._expRefreshTimer:Start()
end

function M:OnBackStoryClick()
    UIContextMgr:GetInstance():Show("BackStoryUI")
end

function M:OnFormationClick()
    TeamConfMgr:GetInstance():OpenTeamConfUI(false, -1, 1, nil, EBattleStyle.Normal)
end

function M:OnBattleClick()
    JumpMgr:GetInstance():Execute(41)
    -- UIContextMgr:GetInstance():Show("ChapterSelection", nil, EBattleStyle.Normal)
end

function M:OnCombatantsClick()
    JumpMgr:GetInstance():Execute(68)
end

function M:OnPresentClick()
    JumpMgr:GetInstance():Execute(4)
end

-- function M:OnRecruitmentClick()
--     JumpMgr:GetInstance():Execute(3)
-- end

function M:OnShopClick()
    JumpMgr:GetInstance():Execute(57)
end

-- 边舱
-- function M:OnDormitoryTaskClick()
--     JumpMgr:GetInstance():Execute(5)
-- end

-- 宿舍
function M:OnDormitoryClick()
    JumpMgr:GetInstance():Execute(6)
end

function M:OnSettingsClick()
    UIContextMgr:GetInstance():Show("SettingUI")
end

function M:OnMailClick()
    UIContextMgr:GetInstance():Show("MailUI")
end

function M:OnFriendClick()
    JumpMgr:GetInstance():Execute(15)
end

function M:OnAchievementClick()
    JumpMgr:GetInstance():Execute(13)
end

function M:OnNoticeClick()
    if not JumpMgr:GetInstance():CheckUnlockByFunctionOpenId(31) then
        GameHelper.TipsById(51004)
        return
    end
    UIContextMgr:GetInstance():Show("Notice")
end

function M:OnReplaceClick()
    UIContextMgr:GetInstance():Show("ChangeShowGirl")
end

function M:OnSkinClick()
    GameHelper.Jump(67)
end

function M:OnActivityClick()
    Logger.LogError("待开放~~~")
end

function M:OnNetworkClick()
    JumpMgr:GetInstance():Execute(77)
end

function M:OnQQButton()
    GameHelper.JoinQQGroup()
end

function M:OnMusicBoxBtn()
    UIContextMgr:GetInstance():Show("MusicBox")
end

-- function M:OnBacklogClick()
--     JumpMgr:GetInstance():Execute(82)
-- end

function M:OnWarehouseClick()
    JumpMgr:GetInstance():Execute(2)
end

function M:OnSkillClick()
    JumpMgr:GetInstance():Execute(11)
end

function M:OnSevenGoalClick()
    -- UIContextMgr:GetInstance():Show("DailyGoals")
    JumpMgr:GetInstance():Execute(301)
end

function M:OnAwakeTaskClick()
    JumpMgr:GetInstance():Execute(5)
end

function M:OnAccountClick()
    -- GameHelper.CopyToClipboard(tostring(INetPack.accountId));
end

-- 票选
function M:OnClickVoting()
    UIContextMgr:GetInstance():Show(UIDefine.UIVoting)
end

-- 悬赏
function M:OnClickReward()
    UIContextMgr:GetInstance():Show(UIDefine.MissionOfferRewards)
end

function M:OnPassClick()
    JumpMgr:GetInstance():Execute(12)
end

function M:SetMainMask(value)
    self._view.Mask:SetActive(value.value)
end

function M:_OnClickBtn()
    UIContextMgr:GetInstance():Show(UIDefine.UIActivity)
end

function M:OnClickFirstRecharge()
    JumpMgr:GetInstance():Execute(306)
end

return MainUICtrl
