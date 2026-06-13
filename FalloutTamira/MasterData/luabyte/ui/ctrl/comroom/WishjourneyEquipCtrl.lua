local M = BaseClass("WishjourneyEquipCtrl", BaseUICtrl)
local uiTopShow = CS.GameX.Battle.Event.UITopShow()
local tInsert = table.insert

function M:Init()
    self.m_taskScroll = self._view.taskView
    self.m_heroScroll = self._view.heroView
    self.m_foodScroll = self._view.foodView
    self.m_awardScroll = self._view.rewardView
    self.m_costCfg = ConfigHelper.GetSystemParams(343)

    self.m_data = nil
    self.m_roomData = nil
    self.m_callbcak = nil
    self.m_expMission = nil
    self.m_awardScroll:Init(require("UI.Ctrl.Common.CommonItemCtrl"), require("UI.View.Common.ItemPfbView"))
    self.m_taskScroll:Init(require("UI.Ctrl.ComRoom.JourneyTaskItemCtrl"), require("UI.View.ComRoom.JourneyTaskItemView"))
    self.m_heroScroll:Init(require("UI.Ctrl.ComRoom.JourneyHeroItemCtrl"), require("UI.View.ComRoom.JourneyHeroItemView"))
    self.m_foodScroll:Init(require("UI.Ctrl.ComRoom.JourneyFoodItemCtrl"), require("UI.View.ComRoom.JourneyFoodItemView"))
    self._view.mask:onClick(Bind(self, self.Close))
    self.m_timeHandler = Bind(self, self.OnTimerCallBack)
    self._view.quickBtn:onClick(Bind(self, self.OnClickQuick)) -- 一键上阵
    self._view.startBtn:onClick(Bind(self, self.OnClickStart)) -- 开始远征
    self._view.speedBtn:onClick(Bind(self, self.OnClickSpeed)) -- 加速远征
    self.m_heroScroll:SetCreateItemCallback(Bind(self, self.OnCreateHeroItem))
    self.m_foodScroll:SetCreateItemCallback(Bind(self, self.OnCreateFoodItem))
end

function M:OnEnter(roomData, taskData, callbcak)
    uiTopShow.isShow = false
    IGameEventMgr:SendEventByLua(uiTopShow)

    self.m_data = taskData
    self.m_roomData = roomData
    self.m_callbcak = callbcak
    self.m_onBeginEvent = EventMgr:AddListener(UIMessageNames.EXPMISSION_UPDATE, Bind(self, self.OnExpMissionUpdate))
    self.m_expMission = self.m_roomData:GetExpMission(self.m_data.ConfigId)
    self._view.taskTitle:SetText(self.m_expMission.name)
    self._view.taskDesc:SetText(self.m_expMission.des)

    self.m_taskDatas = {}   -- 任务数据
    self.m_itemFoods = {}   -- 当前任务选择的菜品
    self.m_assignHeros = {} -- 当前任务指派的队员
    self:_ShowHeroList()    -- 队员列表
    self:_ShowFoodList()    -- 食物列表
    self:_ShowTaskList()    -- 条件列表
    self:_ShowItemList()    -- 奖励列表
    self:_UpdateBtnGroup()
    self:_UpdateTaskInfo()
    self:_UpdateTaskState()
    self:_StartTimer()
end

function M:OnClose()
    uiTopShow.isShow = true
    IGameEventMgr:SendEventByLua(uiTopShow)

    self:_StopTimer()
    self.m_data = nil
    self.m_roomData = nil
    self.m_taskDatas = nil
    self.m_itemFoods = nil
    self.m_expMission = nil
    self.m_assignHeros = nil
    if self.m_callbcak then
        self.m_callbcak(2) -- 未选中
        self.m_callbcak = nil
    end
    EventMgr:RemoveListener(UIMessageNames.EXPMISSION_UPDATE, self.m_onBeginEvent)
    M.super.OnClose(self)
end

function M:OnDispose()
    self.m_timeHandler = nil
    M.super.OnDispose(self)
end

function M:OnCreateHeroItem(itemCtrl)
    itemCtrl:ClickCallback(Bind(self, self.OnClickHero))
end

function M:OnCreateFoodItem(itemCtrl)
    itemCtrl:ClickAddCallback(Bind(self, self.OnShowFoodPanel))
end

-- 点击战员
function M:OnClickHero(data)
    if self.m_data.EndTick > 0 then return end
    local heros, sortDic, memberNum = {}, {}, self.m_expMission.member
    for i = 1, memberNum do tInsert(heros, self.m_assignHeros[i - 1] or 0) end
    local assignHeros = OtakuRoomDataMgr:GetInstance():GetSurveyAllAssignHeros()
    local assignDic, str = {}, ConfigHelper.GetLocalString(30001)                    -- 调查中...
    for _, heroId in ipairs(assignHeros) do assignDic[heroId] = str end
    for _, heroId in ipairs(self.m_expMission.parameter2) do sortDic[heroId] = 1 end -- 次要条件
    for _, heroId in ipairs(self.m_expMission.parameter1) do sortDic[heroId] = 2 end -- 主要条件
    UIContextMgr:GetInstance():Show("ComChooseHero", 0, heros, function(heroIds, index)
        local heroList = {}
        for i = 1, memberNum do
            local idx = i - 1
            local heroId = heroIds[i] or 0
            tInsert(heroList, { HeroID = heroId, Pos = idx, IsWork = false })
            self:_SetHeros(heroId, idx)
        end
        self.m_heroScroll:SetDataList(heroList)
        self:_UpdateTaskInfo()
        self:_UpdateTaskState()
    end, assignDic, nil, sortDic)
end

function M:_UpdateTaskState()
    self.m_taskScroll:UpdateList()
    self.m_awardScroll:UpdateList()
    self:UpdateStartBtn()
end

function M:_ShowTaskList()
    local limit1 = self.m_expMission.limit1
    local limit2 = self.m_expMission.limit2
    local params1 = self.m_expMission.parameter1
    local params2 = self.m_expMission.parameter2
    local isReach = function(data)
        return self:_IsReachTask(data.Limit, data.Params)
    end
    self.m_taskDatas = {
        {
            Index = 1,
            Limit = limit1,
            Params = params1,
            IsReach = isReach,
            Desc = self.m_expMission.des2,
        },
        {
            Index = 2,
            Limit = limit2,
            Params = params2,
            IsReach = isReach,
            Desc = self.m_expMission.des3,
        }
    }
    self.m_taskScroll:SetDataList(self.m_taskDatas)
end

-- 显示食物Item列表
function M:_ShowFoodList()
    local isUseFood = self.m_data.Food or false
    for _, foodId in ipairs(self.m_expMission.food) do
        tInsert(self.m_itemFoods, {
            foodId = foodId,
            isSelect = isUseFood,
        })
    end
    self.m_foodScroll:SetDataList(self.m_itemFoods)
end

-- 显示队员列表
function M:_ShowHeroList()
    local heroList = {}
    local isOpen = self.m_data.EndTick > 0
    for i = 1, self.m_expMission.member do
        local heroId = self.m_data.Heroes[i] or 0
        tInsert(heroList, {
            HeroID = heroId,
            Pos = i - 1,
            IsWork = heroId > 0 and isOpen or false
        })
    end

    self.m_heroScroll:SetDataList(heroList)
end

-- 显示奖励列表
function M:_ShowItemList()
    local stateFunc = function(data)
        local index = data.index
        if index == 3 then
            local isUseFood = self:_IsUseFood()
            return isUseFood and 5 or 4
        else
            local task = self.m_taskDatas[index]
            local isReach = task:IsReach()
            if index == 1 then -- 首要
                return isReach and 3 or 2
            else
                return isReach and 1 or 6
            end
        end
    end
    local list = {}
    for i = 1, 3, 1 do
        local groupId = self.m_expMission["reward" .. i] or 0
        if groupId > 0 then
            local itemCfg = ConfigHelper.GetCfgByLua("itemGroup", groupId)
            if itemCfg then
                local cnts = itemCfg.cnts
                local items = itemCfg.items
                local TOTLE = ItemNumberType.TOTLE
                for j = 1, #items do
                    local id, num = items[j], cnts[j]
                    if id > 0 and num > 0 then
                        tInsert(list, {
                            index = i,
                            itemId = id,
                            itemNum = num,
                            numType = TOTLE,
                            State = stateFunc,
                        })
                    end
                end
            else
                Logger.LogError("itemGroup is null. id = " .. groupId)
            end
        end
    end

    self.m_awardScroll:SetDataList(list)
end

-- 更新按钮组
function M:_UpdateBtnGroup()
    local isOn = self.m_data.EndTick <= 0
    self._view.quickBtn:SetActive(isOn)
    self._view.startBtn:SetActive(isOn)
    self._view.speedBtn:SetActive(not isOn)
    if isOn then
        self._view.speedBtn:SetActive(false)
    else
        local itemId = self.m_costCfg[0]
        local itemNum = self.m_costCfg[1]
        self._view.speedBtn:SetActive(true)
        self._view.speedCost:SetItemById(itemId, itemNum)
        self._view.speedBtn:SetState(GameHelper.CheckItem(itemId, itemNum) and 1 or 2)
    end
    for i, heroId in ipairs(self.m_data.Heroes) do
        self:_SetHeros(heroId, i - 1)
    end
end

function M:_StartTimer()
    if not self.m_data then return end

    if not self.m_timer and self.m_data.EndTick > 0 then
        self.m_timer = TimerManager:GetInstance():GetTimer(1, self.m_timeHandler, self)
        self.m_timer:Start()
        self:OnTimerCallBack()
    end
end

function M:_StopTimer()
    if self.m_timer then
        self.m_timer:Stop()
        self.m_timer = nil
    end
end

-- 定时器回调
function M:OnTimerCallBack()
    if not self.m_data then return end

    local isComplete, endTick = false, self.m_data.EndTick
    if endTick > 0 then
        isComplete = (endTick - GameUtil.GetCurTimeTick()) <= 0
    end

    if isComplete then self:Close() end
end

-- 加速远征
function M:OnClickSpeed(go)
    local itemId, itemNum = self.m_costCfg[0], self.m_costCfg[1]
    if not GameHelper.CheckItem(itemId, itemNum) then
        GameHelper.PopItem(itemId, itemNum, self._view, function() end)
        return
    end

    self.m_roomData:RqExpMissionFast(self.m_data.Id, Bind(self, self.Close))
end

-- 点击开始调查按钮
function M:OnClickStart(go)
    if self.m_tipsId == 0 then
        local nameId, heroId = self:_CheckIsOtherTaskBasic()
        if nameId > 0 then
            local heroName = ConfigHelper.GetHeroName(heroId)
            GameHelper.Confirm(string.format(ConfigHelper.GetLocalString(6298), heroName, heroName), function(isOk)
                if isOk then self:_StartSurvey() end
            end)
        else
            self:_StartSurvey()
        end
    else
        GameHelper.TipsById(self.m_tipsId)
    end
end

-- 点击一键上阵按钮，自动上阵角色以及食物；
function M:OnClickQuick(go)
    ----------------------- 派遣战员 Start -----------------------
    local taskHeros, idleHeros, heroCount = {}, {}, 0
    local cfg, hd, heroId, tbl = self.m_expMission, nil, nil, nil
    local heroDic1, needNum1 = SurveyHelper.GetHerosAndNum(cfg.limit1, cfg.parameter1)
    local assigneds, heroDatas = self.m_roomData:GetAllHeros(), IHeroDataMgr:GetHeros()
    for i = 0, heroDatas.Count - 1 do
        hd = heroDatas[i]
        if hd and hd:IsHave() then
            heroId = hd:GetHeroId()
            tbl = {
                HeroId = heroId,
                Rare = hd:GetRare(),
                Level = hd:GetLevel(),
                CoreLevel = hd:GetCoreLevel(),
                BreakLevel = hd:GetBreakLevel(),
                Profession = hd:GetProfession(),
                StudioId = assigneds[heroId] or 0
            }

            if heroDic1[heroId] then          -- 主要条件
                if tbl.StudioId > 0 then
                    GameHelper.TipsById(1011) -- 主要战员已派遣
                    return
                end
                tInsert(taskHeros, tbl)
                heroCount = heroCount + 1
            elseif tbl.StudioId <= 0 then -- 空闲英雄
                tInsert(idleHeros, tbl)
                heroCount = heroCount + 1
            end
        end
    end

    if #taskHeros < needNum1 then
        GameHelper.TipsById(1012) -- 可派遣战员不够
        return
    end

    local limit2, params2 = cfg.limit2, cfg.parameter2
    local heroDic2, needNum2 = SurveyHelper.GetHerosAndNum(limit2, params2)
    self:_SortRole(taskHeros, heroDic1, true)
    self:_SortRole(idleHeros, heroDic2, false)

    -- 次要条件
    local heros = SurveyHelper.FilterHerosByCond(limit2, params2, idleHeros)
    if #heros == needNum2 then
        for _, v in ipairs(heros) do tInsert(taskHeros, v) end
    end

    -- 战员空槽补位
    for _ = #taskHeros + 1, cfg.member do tInsert(taskHeros, { HeroId = 0 }) end

    self.m_assignHeros = {} -- 清空已有战员
    local heroList = {}
    for k, v in ipairs(taskHeros) do
        local pos = k - 1
        self:_SetHeros(v.HeroId, pos)
        tInsert(heroList, { HeroID = v.HeroId, Pos = pos, IsWork = false })
    end
    self:_UpdateTaskInfo()
    self.m_heroScroll:SetDataList(heroList)
    ------------------------ 派遣战员 End ------------------------

    self:_QuickFitFoodItems() -- 上阵食物
    self:_UpdateTaskState()
end

-- 开始调查
function M:_StartSurvey()
    local heroIds = {}
    for _, v in pairs(self.m_assignHeros) do
        if v > 0 then tInsert(heroIds, v) end
    end
    local isUseFood = self:_IsUseFood()
    self.m_roomData:RqBeginExpMission(self.m_data.Id, heroIds, isUseFood)
end

-- 一键上阵食物
function M:_QuickFitFoodItems()
    local isUseFood = true
    for _, foodData in ipairs(self.m_itemFoods) do
        local foodId = foodData.foodId
        local num = ItemDataMgr:GetInstance():GetItemNumById(foodId)
        if num <= 0 then isUseFood = false end
    end
    for _, value in ipairs(self.m_itemFoods) do
        value.isSelect = isUseFood
    end
    self.m_foodScroll:UpdateList() -- 显示食物Item列表
end

function M:_SortRole(roles, heroDic, order)
    table.sort(roles, function(a, b)
        local has1, has2 = heroDic[a.HeroId] or false, heroDic[b.HeroId] or false
        if has1 == has2 then -- 排序：主要战员＞次要战员＞等级＞品质＞角色id；
            if a.Level == b.Level then
                if a.Rare == b.Rare then
                    if order then return a.HeroId > b.HeroId end
                    return a.HeroId < b.HeroId
                else
                    if order then return a.Rare > b.Rare end
                    return a.Rare < b.Rare
                end
            else
                if order then return a.Level > b.Level end
                return a.Level < b.Level
            end
        else
            return has1 -- heroDic有的英雄在前面
        end
    end)
end

-- 选择食物面板
function M:OnShowFoodPanel(itemId)
    if self.m_data.EndTick > 0 then
        GameHelper.PopItem(itemId, 0, self._view, function() end)
        return
    end

    local list = {}
    for _, value in ipairs(self.m_itemFoods) do
        tInsert(list, value.isSelect and value.foodId or 0)
    end
    UIContextMgr:GetInstance():Show("WishjourneySelectItemUI", list, self.m_expMission.food, function(itemIds)
        local itemDic = {}
        for _, id in pairs(itemIds) do itemDic[id] = true end
        for _, value in ipairs(self.m_itemFoods) do
            value.isSelect = itemDic[value.foodId] or false
        end

        self.m_foodScroll:UpdateList()
        self.m_awardScroll:UpdateList()
    end)
end

-- 更新调查按钮
function M:UpdateStartBtn()
    local isEnough = self.m_tipsId == 0
    self._view.startNormal:SetActive(isEnough)
    self._view.startLock:SetActive(not isEnough)
end

-- 更新任务信息
function M:_UpdateTaskInfo()
    --[[if not self:_CheckHeroNum() then
        self.m_tipsId = 1014 -- 1.上阵角色数量
    else]]
    if not self.m_taskDatas[1]:IsReach() then
        self.m_tipsId = 1015 -- 2.主要条件角色达到任务需求
    else
        self.m_tipsId = 0
    end
end

-- 当前任务选择的队员
function M:_SetHeros(heroId, pos)
    self.m_assignHeros[pos] = heroId
end

-- 检查指派队员数量
function M:_CheckHeroNum()
    local num = 0
    for _, heroId in pairs(self.m_assignHeros) do
        if heroId > 0 then num = num + 1 end
    end
    return num >= self.m_expMission.member
end

-- 是否使用额外奖励食物
function M:_IsUseFood()
    local isUseFood = true
    for _, item in ipairs(self.m_itemFoods) do
        if not item.isSelect then
            isUseFood = false
            break
        end
    end
    return isUseFood
end

-- 是否达成任务条件
function M:_IsReachTask(limit, params)
    return SurveyHelper.CheckHeroCond(limit, params, self.m_assignHeros)
end

-- 是否为其它任务的主要英雄,是则返回对应任务名称id
function M:_CheckIsOtherTaskBasic()
    local cfg = self.m_expMission
    local dic = self.m_roomData:GetOtherBasicHeroDic(cfg.id)
    local _, needNum = SurveyHelper.GetHerosAndNum(cfg.limit1, cfg.parameter1)
    for i = needNum, cfg.member do -- m_assignHeros 0开始的
        local id = self.m_assignHeros[i] or 0
        if (dic[id] or 0) > 0 then return dic[id], id end
    end
    return 0, 0
end

function M:OnExpMissionUpdate()
    IRedPointMgr:ForceCheck(RedPointConst.WishjourneyIdleRedPointChecker)
    self:Close()
end

return M
