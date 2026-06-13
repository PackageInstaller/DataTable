local LotteryCtrl = BaseClass("LotteryCtrl", BaseUICtrl)
local M = LotteryCtrl
local tInsert = table.insert

function M:Init()
    self._lotteryCostItems = {}
    self._lotteryDatas = nil
    self._availablePage = nil
    self._allContentCtrls = nil
    self._curIdx = nil

    self._updateDrawDataHandler = function(lotteryPage, drawData)
        for key, value in pairs(self._allContentCtrls) do
            if value:GetPage() == lotteryPage then
                value:Refresh(drawData)
            end
        end
    end
    self:_AddListener(UIMessageNames.UPDATE_LOTTERY_DATA, self._updateDrawDataHandler)
    self._view.tsBtn_once.onClick = function(g)
        local cfg = self._allContentCtrls[self._curIdx]:GetCfg()
        self:_Lotto(cfg, self._allContentCtrls[self._curIdx]:DrawData(), 1)
    end

    self._view.tsBtn_ten.onClick = function(g)
        local cfg = self._allContentCtrls[self._curIdx]:GetCfg()
        local times = 0
        local timeSystem = ConfigHelper.GetSystemParams(311)
        local type_time = {}
        local lastKey = 0
        for i = 0, timeSystem.Length - 1 do
            if i % 2 == 0 then
                lastKey = timeSystem[i]
            else
                type_time[lastKey] = timeSystem[i]
            end
        end

        if type_time[cfg.type] then
            times = type_time[cfg.type]
        end


        self:_Lotto(cfg, self._allContentCtrls[self._curIdx]:DrawData(), times)
    end

    self._view.ProbabilityBtn:onClick(function(g)
        local cfg = self._allContentCtrls[self._curIdx]:GetCfg()
        local cardPoolId = cfg.jackpot
        UIContextMgr:GetInstance():Show("LotteryProbability", cardPoolId)
    end
    )

    self._view.BtnRecord:onClick(function(g)
        local cfg = self._allContentCtrls[self._curIdx]:GetCfg()
        UIContextMgr:GetInstance():Show("LotteryRecord", cfg)
    end
    )

    self._view.BtnTipBtn:onClick(function(g)
        local cfg = self._allContentCtrls[self._curIdx]:GetCfg()
        local cardPoolId = cfg.jackpot
        local cardPoolcfg = ConfigHelper.GetCfgByLua("cardPool", cardPoolId)
        if cardPoolcfg ~= nil then
            UIContextMgr:GetInstance():Show("GamePlayExplain", cardPoolcfg.explainId)
        end
    end
    )

    self._costItem1 = self._view.trans_consume1
    self._costItem2 = self._view.trans_consume2

    self._tab = self._view.tab

    --self.showVideoCardPool = {}

    self._view.tgl_skip:SetIsOn(PlayerPrefabHelper.GetBool("SkipLotteryTimeLine", true))
    self._view.tgl_skip:OnToggleClick(Bind(self, self.OnClickToggle))
end

-- defaultType  默认显示内容
-- lotteryDatas 以type为key,value 为服务器数据的数组
-- type 的数组，相当于lotteryDatas keys
-- cfgArr 所有cfg
function M:OnEnter(defaultType, lotteryDatas)
    Logger.Log("Lottery: -- LotteryCtrl :" .. defaultType)
    GameHelper.DoPlayerAction(PlayerAction.ShowLotteryUI)
    self._lotteryDatas = lotteryDatas
    self._availablePage = lotteryDatas:GetAllPages()
    local needChangeType = false
    local firstNotNoobType = nil
    local isHaveLottery = false    --是否抽过奖
    local canLottyNew = true       -- 可以新手抽卡
    local bDefaultTypeShow = false --希望打开的界面是否开启
    for i = 1, #self._availablePage do
        local canShow = true       --是否可以抽 不能抽的不显示
        local tmpPage = self._availablePage[i]
        --通过类型找到卡池数据，(type ->sign -> signData(ld) )
        local ld = lotteryDatas:GetDrawDataByPage(tmpPage)
        local cfg = lotteryDatas:GetCfgByPage(tmpPage)
        if ld then
            isHaveLottery = true
            -- if tmpPage == LotteryType.Noob then
            local times = cfg.lotteryTimes          --Mathf.Max( cfg[1].floorTimes , cfg[1].bigfloorTimes )
            local restTimes = times - ld.TotalTimes --剩余次数
            if restTimes <= 0 then
                if self:GetContext()._curIdx == i and times ~= 0 then
                    self:GetContext()._curIdx = 0 --上次打开的页面已经抽光
                end
                if cfg.page == 2 then             --新手抽卡
                    canLottyNew = false
                end
                needChangeType = true
            end
            if times == 0 then
                canShow = true
            else
                canShow = restTimes > 0
            end --还有可以抽的次数
        end

        if cfg.sign == 3 then
            if (LotteryHelper.CheckLotteryShow(cfg) or GameUtil.CheckInTime(cfg.startTime, cfg.lastTime)) then
                if not ld then
                    canShow = true
                else
                    if cfg.lotteryTimes == 0 then --无限抽
                        canShow = true
                    else
                        canShow = (cfg.lotteryTimes - ld.TotalTimes) > 0 --还可以抽 有剩余次数
                    end
                end
            else
                canShow = false
            end
        end

        if defaultType == tmpPage then
            bDefaultTypeShow = canShow
        end
        self._tab:SetItemActive(tmpPage - 1, canShow)

        --判断限时卡池播放动画的逻辑
        self._view.tableView.view["cell" .. i].view.BtnPV:SetActive(false)
        if cfg.sign == 3 then
            if LotteryHelper.CheckLotteryShow(cfg) then
                self.waitingLuckDrawData = {}
                self.waitingLuckDrawData[i] = cfg
                if self.waitTimeer then
                    self.waitTimeer:Stop()
                end
                self.waitTimeer = TimerManager:GetInstance():GetTimer(1, self.CheckWaittingLuckDraw, self)
                self.waitTimeer:Start()

                --self.showVideoCardPool[i] = cfg[1].previewVideo
                self._view.tableView.view["cell" .. i].view.Background:SetActive(false)
                self._view.tableView.view["cell" .. i].view.BtnPV:SetActive(true)
                local startstr = GameHelper.TimeStampToString(cfg.startTime, "yyyy.MM.dd")
                self._view.tableView.view["cell" .. i].view.StartText:SetText(tostring(startstr))

                self._view.tableView.view["cell" .. i].view.BtnPV:SetOnClick(function(g)
                    UIContextMgr:GetInstance():Show("Lottery_PV", cfg.previewVideo)
                end)
            end
        end
    end

    if not isHaveLottery then
        isHaveLottery = (lotteryDatas:GetFirstHeroId() ~= nil and lotteryDatas:GetFirstHeroId() > 0)
        needChangeType = true
    end

    -- if isHaveLottery and canLottyNew then --如果抽过奖 而且可以抽新晋征募
    if canLottyNew then                           --如果可以抽新晋征募
        firstNotNoobType = self._availablePage[2] --默认新手卡池
        Logger.Log("Lottery: -- LotteryCtrl -- canLottyNew:" .. tostring(canLottyNew))
    else
        firstNotNoobType = self:GetFirstActiveActivityPage() --self._availablePage[1]--第一次要引导，抽常驻卡池 改成了取当前激活的卡池
        Logger.Log("Lottery: -- LotteryCtrl --firstNotNoobType :" .. firstNotNoobType)
    end



    if (needChangeType and defaultType == 0) or (not bDefaultTypeShow) then
        Logger.Log("Lottery: -- LotteryCtrl --needChangeType--" ..
            tostring(needChangeType) ..
            "--defaultType" .. defaultType .. "bDefaultTypeShow" .. tostring(bDefaultTypeShow))
        defaultType = firstNotNoobType
    end

    Logger.Log("Lottery: -- LotteryCtrl : defaultType:" .. defaultType)
    self._curIdx = self:GetContext()._curIdx
    if self._curIdx == 0 then
        if table.indexof(self._availablePage, defaultType) > 0 then
            self._curIdx = defaultType
        else
            self._curIdx = self._availablePage[1]
        end
    end
    self:_initContentCtrls()
    self._tab:Init(self._curIdx - 1, Bind(self, self._OnSelect), Bind(self, self._OnCheckCanClick))
    self:_SetCost(lotteryDatas:GetCfgByPage(self._availablePage[1]))
    self:_OnSelect(self._curIdx - 1)
    self._view.tab.transform:SetLocalPos(0, self._view.tab.transform.localPosition.y,
        self._view.tab.transform.localPosition.z)
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

function M:OnVisible()
    self:RefTitle()
end

function M:_OnSelect(idx)
    local luaIdx = idx + 1
    local lotteryType = luaIdx -- self._availablePage[luaIdx]
    local lotteryCfg = self._lotteryDatas:GetCfgByPage(lotteryType)
    self._allContentCtrls[luaIdx]:Refresh(self._lotteryDatas._allLotteryId2Datas[lotteryCfg.id])
    self._allContentCtrls[luaIdx]:SetActive(true)
    self._allContentCtrls[luaIdx]:Action()
    self._curPage = self._allContentCtrls[luaIdx]
    self:_SetCost(lotteryCfg)
    self._curIdx = luaIdx
    self:GetContext()._curIdx = luaIdx
    --新晋抽卡不显示单抽
    if lotteryType == LotteryType.Noob then
        self:_SetEnableBtns({ 1, 1 }) --现在显示了 by duzhong
    else
        self:_SetEnableBtns({ 1, 1 })
    end
    self._view.tgl_skip:SetActive(lotteryCfg.type == 1) -- 角色抽卡才显示
    self:RefTitle()
    self:RefreshButtonText()
end

function M:_OnCheckCanClick(idx)
    -- if idx + 1 > #self._availablePage then
    --     GameHelper.TipsById(4137)
    --     return
    -- end
    return true
end

function M:_SetEnableBtns(enables)
    self._view.tsBtn_once.gameObject:SetActive(enables[1] == 1)
    self._view.tsBtn_ten.gameObject:SetActive(enables[2] == 1)
end

function M:_SetCost(lottoCfg)
    self._lotteryCostItems = {}
    --目前只支持2个
    for i = 1, 2 do
        --1 为单抽  2为10连
        --local cfgs = lottoCfgs[i].costItem
        local itemId
        local itemNum
        local isEnough
        itemId, itemNum, isEnough = LotteryHelper.GetCostItemByShow(lottoCfg, i == 1)
        --self["_costItem"..i]:SetWarningNumber(itemNum)
        --玮哥说这里不要变红
        if itemId == nil or itemId == 0 then
        else
            self["_costItem" .. i]:SetWarningNumber(0)
            self["_costItem" .. i]:Action(itemId, itemNum)
            tInsert(self._lotteryCostItems, itemId)
        end
    end
end

function M:_initContentCtrls()
    if self._allContentCtrls == nil then
        self._allContentCtrls = {}
        for i = 1, #self._availablePage do
            local pg = self._availablePage[i]
            local path = "UI.Ctrl.Lottery.LotteryTypeItem" .. pg
            local cls = require(path)
            if cls == nil then
                Logger.LogError("subCls is nil , path = " .. path)
            end
            local cfg = self._lotteryDatas:GetCfgByPage(pg)
            local instance = cls.New(pg, self._view["item" .. pg], cfg)
            instance:Refresh(self._lotteryDatas._allLotteryId2Datas[cfg.id])
            self._allContentCtrls[pg] = instance
            --tInsert( self._allContentCtrls,instance)
        end
    end
end

function M:_Lotto(lottoCfg, drawData, times)
    local lottoId = lottoCfg.id
    if not LotteryHelper.CheckLottery(lottoCfg, drawData, times) then
        GameHelper.TipsById(4135)
        return
    end

    local context = UIContextMgr:GetInstance():GetContext("Lottery")
    context:Lotto(lottoId, times)
end

function M:OnClose()
    if self.waitTimeer ~= nil then
        self.waitTimeer:Stop()
        self.waitTimeer = nil
    end
end

function M:OnDispose()
    self._view.tsBtn_once.onClick = nil
    self._view.tsBtn_ten.onClick = nil
    if self._allContentCtrls then
        for i, v in ipairs(self._allContentCtrls) do
            if v then
                v:OnDispose()
            end
        end
    end
    self._view.item1:OnDispose()
    self._view.item2:OnDispose()
    self._view.item3:OnDispose()
    self._view.item4:OnDispose()
    self:_RemoveListener(UIMessageNames.UPDATE_LOTTERY_DATA, self._updateDrawDataHandler)
    if self.waitTimeer ~= nil then
        self.waitTimeer:Stop()
        self.waitTimeer = nil
    end
    self.waitingLuckDrawData = nil

    M.super.OnDispose(self)
    --self.showVideoCardPool = nil
end

function M:GetLotterNeedItemId(cfg)
    local allItemIds = {}
    local onceItem = LotteryHelper.GetCostItems(cfg.id, true)
    local tenItem = LotteryHelper.GetCostItems(cfg.id, false)
    for _, v in pairs(onceItem) do
        if not table.indexof(allItemIds, v.id) then
            tInsert(allItemIds, v.id)
        end
    end

    for _, v in pairs(tenItem) do
        if not table.indexof(allItemIds, v.id) then
            tInsert(allItemIds, v.id)
        end
    end

    return allItemIds
end

--
function M:CheckWaittingLuckDraw()
    Logger.Log("CheckWaittingLuckDraw")
    if self.waitingLuckDrawData ~= nil then
        local number = 0
        for key, value in pairs(self.waitingLuckDrawData) do
            number = number + 1
            if GameUtil.CheckInTime(value.startTime, value.lastTime) then
                self._view.tableView.view["cell" .. key].view.Background:SetActive(true)
                self._view.tableView.view["cell" .. key].view.BtnPV:SetActive(false)
                self.waitingLuckDrawData = nil
                number = number - 1
            end
        end
        if number == 0 then
            if self.waitTimeer ~= nil then
                self.waitTimeer:Stop()
                self.waitTimeer = nil
            end
        end
    end
end

function M:RefreshButtonText()
    local cfg = self._allContentCtrls[self._curIdx]:GetCfg()
    if cfg.type == 1 then --英雄抽卡
        self._view.tsBtn_once_text:SetText(5540)
        self._view.tsBtn_ten_text:SetText(5541)
    else -- 礼物抽卡
        self._view.tsBtn_once_text:SetText(5538)
        self._view.tsBtn_ten_text:SetText(5539)
    end

    --Lock
    self._view.tsBtn_once_state:SetState(2)
    if cfg.openCondition1 ~= nil and #cfg.openCondition1 > 0 then --单抽按钮
        for i = 1, #cfg.openCondition1 do
            if not GameHelper.CheckLockByOpenConditionId(cfg.openCondition1[i]) then
                self._view.tsBtn_once_state:SetState(1)
                local openConditionCfg = ConfigHelper.GetCfgByLua("openCondition", cfg.openCondition1[i])
                self._view.tsBtn_once_locktext:SetText(openConditionCfg.tips)
                break
            end
        end
    end

    self._view.tsBtn_ten_state:SetState(2)
    if cfg.openCondition2 ~= nil and #cfg.openCondition2 > 0 then --单抽按钮
        for i = 1, #cfg.openCondition2 do
            if not GameHelper.CheckLockByOpenConditionId(cfg.openCondition2[i]) then
                self._view.tsBtn_ten_state:SetState(1)
                local openConditionCfg = ConfigHelper.GetCfgByLua("openCondition", cfg.openCondition2[i])
                self._view.tsBtn_ten_locktext:SetText(openConditionCfg.tips)
                break
            end
        end
    end
end

function M:RefTitle()
    local lotteryType = self._curIdx --self._availablePage[self._curIdx]
    local lotteryCfg = self._lotteryDatas:GetCfgByPage(lotteryType)
    local itemids = self:GetLotterNeedItemId(lotteryCfg)
    local array = GameHelper.TableToArray(itemids)
    UIContextMgr:GetInstance():Show("TopBar", self.config, array)
end

function M:GetFirstActiveActivityPage()
    local defaultCardPoolPage = 0
    for i = 1, #self._availablePage do
        local canshow = false --是否可以抽 不能抽的不显示
        local tmpPage = self._availablePage[i]
        --通过类型找到卡池数据，(type ->sign -> signData(ld) )
        local ld = self._lotteryDatas:GetDrawDataByPage(tmpPage)
        local cfg = self._lotteryDatas:GetCfgByPage(tmpPage)
        if cfg.sign == 1 and defaultCardPoolPage == 0 then
            defaultCardPoolPage = tmpPage
        end

        if cfg.sign == 3 then
            if (GameUtil.CheckInTime(cfg.startTime, cfg.lastTime)) then
                if not ld then
                    canshow = true
                else
                    if cfg.lotteryTimes == 0 then --无限抽
                        canshow = true
                    else
                        canshow = (cfg.lotteryTimes - ld.TotalTimes) > 0 --还可以抽 有剩余次数
                    end
                end
            else
                canshow = false
            end

            if canshow then
                return tmpPage
            end
        end
    end

    return defaultCardPoolPage --常规卡池
end

function M:OnClickToggle(isOn)
    PlayerPrefabHelper.SetBool("SkipLotteryTimeLine", isOn, true)
end

return LotteryCtrl
