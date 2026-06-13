local M = BaseClass("MissionOfferRewardsCtrl", BaseUICtrl)
local tInsert = table.insert

function M:Init()
    self.m_mission = nil
    self.m_selectData = nil
    self.m_isUseItem = false
    self.m_context = self:GetContext()
    self.m_texts = { self._view.txt_desc1, self._view.txt_desc2 }
    self.m_items = { self._view.entryItem1, self._view.entryItem2, self._view.entryItem3 }
    self.m_itemId = GameHelper.GetParamter(280) -- 激素道具
    self._view.tgl_power:onClick(Bind(self, self.OnClickPower))
    self._view.btn_reward:onClick(Bind(self, self.OnClickReward))
    self._view.btn_battle:onClick(Bind(self, self.OnClickBattle))
    self._view.listMask:onClick(Bind(self, self.OnClickListMask))
    self._view.btn_mapInfo:onClick(Bind(self, self.OnClickMapInfo))
    self._view.btn_mstInfo:onClick(Bind(self, self.OnClickMonsterInfo))
    self._view.btn_change:onClick(Bind(self, self.OnClickChangeMission))

    local ctrl = require("UI.Ctrl.Mission.MissionOfferRewardsListItemCtrl")
    local view = require("UI.View.Mission.MissionOfferRewardsListItemView")
    self._view.looplist:Init(ctrl, view)
    self._view.looplist:SetCreateItemCallback(Bind(self, self.OnCreateItem))

    for _, v in ipairs(self.m_items) do
        local txt = v.txt_desc
        txt:SetOnClick(Bind(self, self.OnClickHrefWord, txt))
    end
end

function M:OnEnter(data, _wanted)
    self.m_itemId = data:ActivityCfg().itemSpecial[1]
    local nowTime = TimeUtil.GetNowTimeStamp()
    PlayerPrefTools.SetPlayerPrefs("OfferRewardStamp", nowTime)
    self.m_activityId = data:ActivityId()
    local hour = TimeUtil.DailyRefreshTime
    local lastId = _wanted and _wanted.id or 0
    local idx, listData, offset, selectIdx = 1, {}, hour * 3600, 0
    local hour5ofTime = TimeUtil.GetNowTimerStart(nowTime - offset, hour)
    local wantedGroup = self.m_context:GetCurActivityWanteds() or {}
    for stamp = data:StartTime(), data:EndTime(), 86400 do
        local wanted = wantedGroup[idx]
        if not wanted then break end -- 超过开放天数，不再查找

        local since5clock = TimeUtil.GetNowTimerStart(stamp - offset, hour)
        if (since5clock > hour5ofTime) then break end

        local wantedId, curNum, maxNum = wanted.id, 0, 0
        local mask = self.m_context:GetWantedWordMaskById(wantedId)
        for i, _ in ipairs(wanted.mapConditionId) do
            maxNum = maxNum + 1
            if (1 << (i - 1)) & mask ~= 0 then curNum = curNum + 1 end
        end
        local tbl = {
            MissionCfg = ConfigHelper.GetCfgByLua("mission", wanted.missionID),
            IsToday = since5clock == hour5ofTime, -- 是否今日开放
            Words = wanted.mapConditionId,        -- 词条数组
            Exps = wanted.mapConditionExp,
            IsSelect = lastId == wantedId,
            WantedId = wantedId,
            WantedCfg = wanted,
            CurNum = curNum, -- 当前词条通关数
            MaxNum = maxNum, -- 当前关卡词条数
            Mask = mask,     -- 词条掩码
        }
        if tbl.IsSelect or ((selectIdx == 0) and (curNum < maxNum)) then selectIdx = idx end
        tInsert(listData, tbl)
        idx = idx + 1
    end
    local selectData = listData[(selectIdx > 0) and selectIdx or #listData]
    selectData.IsSelect = true
    self:OnUpdatePanel(selectData)
    self._view.looplist:SetDataList(listData)

    --包小威
    TeamConfMgr:GetInstance():SetBattleType(3)
    self:_SetFixedEntry()
    self._view.txt_itemDesc:SetText(31011076)
    self._view.txt_itemName:SetItemName(self.m_itemId)
    self._view.currency:SetItemNum(self.m_itemId, ItemNumberType.BALANCE, 1)
    self._view.txt_timer:SetText(TimeUtil.GetTimeFormat(data:EndTime(), "%y/%m/%d %H:%M"))

    IRedPointMgr:ForceCheck(RedPointConst.MissionOfferRewardsRedPointChecker)
end

function M:OnDispose()
    for _, v in ipairs(self.m_items) do v:OnDispose() end
    self.m_texts = nil
    self.m_items = nil
    self.m_mission = nil
    self.m_selectData = nil
    M.super.OnDispose(self)
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

function M:OnUpdatePanel(data)
    self.m_selectData = data
    self.m_isUseItem = false
    self.m_wordsDic = {} -- 已选中词条
    self.m_mission = data.MissionCfg
    self._view.openTag:SetActive(data.IsToday)
    if not self.m_mission then Logger.LogError("mission is nil. id = " .. data.WantedCfg.missionID) end
    self._view.img_map:SetPic(self.m_mission.map)
    self._view.txt_name:SetText(self.m_mission.name)
    self._view.txt_label:SetText(self.m_mission.chapterLabel)
    self._view.tgl_power:SetState(self.m_isUseItem and 2 or 1) -- 是否使用激素道具
    for i, id in ipairs(data.Words) do self:_CreateEntry(i, id, data) end
    self._view.listRect:SetActive(false)
    self.m_context:UpdateWanted(self.m_selectData.WantedCfg)
    self.m_context:DataRecord(self.m_wordsDic, self.m_isUseItem)
end

function M:OnClickHrefWord(textView, hrefName, centerX, centerY)
    local alignDir = Vector2.New(0, 0.5)
    local tipsPivot = Vector2.New(0.5, 0)
    local worldPos = Vector3.New(centerX, centerY, 0)
    textView:ShowHrefWordTips(hrefName, worldPos, alignDir, tipsPivot)
end

function M:OnCreateItem(ctrl)
    ctrl:SetCallback(function(data)
        for _, v in ipairs(self._view.looplist:GetDataList()) do
            v.IsSelect = v.WantedId == data.WantedId
        end
        self:OnUpdatePanel(data)
        self._view.looplist:UpdateList()
    end)
end

-- 强化道具按钮
function M:OnClickPower(go)
    if ItemDataMgr:GetInstance():GetItemNumById(self.m_itemId) > 0 then
        local isOn = self._view.tgl_power:GetState() == 2
        isOn = not isOn
        self.m_isUseItem = isOn
        self._view.tgl_power:SetState(isOn and 2 or 1)
    else
        GameHelper.TipsById(30171) -- 消耗不足
    end
end

-- 奖励预览按钮
function M:OnClickReward(go)
    UIContextMgr:GetInstance():Show("MissionOfferAwardDetails", self.m_activityId)
end

-- 开始战斗按钮
function M:OnClickBattle(go)
    local words = {}
    for k, v in pairs(self.m_wordsDic or {}) do
        if v then tInsert(words, k) end
    end
    if #words == 0 then
        GameHelper.TipsById(5652) -- 未选择词条
        return
    end
    self.m_context:DataRecord(self.m_wordsDic, self.m_isUseItem)

    TeamConfMgr:GetInstance():OpenTeamConfUI(
        self.m_mission.IsTeach,
        self.m_mission.id,
        EnumConst.TeamConfigStyle.Battle,
        0,
        EnumConst.EBattleStyle.Reward
    )
end

function M:OnClickListMask(go)
    self._view.listRect:SetActive(false)
end

-- 战场详情按钮
function M:OnClickMapInfo(go)
    UIContextMgr:GetInstance():Show("MissionMapUI", self.m_mission.map)
end

-- 怪物详情按钮
function M:OnClickMonsterInfo(go)
    UIContextMgr:GetInstance():Show("MonsterInfoUI", self.m_mission.Stage)
end

-- 切换关卡
function M:OnClickChangeMission(go)
    self._view.listRect:SetActive(true)
    for i, v in ipairs(self._view.looplist:GetDataList()) do
        if v.IsSelect then
            self._view.looplist:AlignmentContentPosition(i + 1, 1)
            break
        end
    end
end

function M:_CreateEntry(idx, mapCondId, data)
    local keyName = data.WantedId .. "WantedWord" .. mapCondId
    local isDone = (1 << (idx - 1)) & data.Mask ~= 0
    local mView = self:_GetOptionView(idx)
    mView:onClick(function(go)
        local isOn = self.m_wordsDic[mapCondId] or false
        self.m_wordsDic[mapCondId] = not isOn
        PlayerPrefTools.SetPlayerPrefs(keyName, isOn and 0 or 1)
        self:_UpdateItemState(mapCondId, isDone, mView)
    end)
    self.m_wordsDic[mapCondId] = PlayerPrefTools.GetPlayerPrefsInt(keyName, 0) == 1
    mView.txt_exp:SetText("+" .. tostring(data.Exps[idx]))
    local mcrandom = ConfigHelper.GetCfgByLua("mcrandom", mapCondId)
    if mcrandom then
        mView.img_icon:SetPic(mcrandom.icon)
        mView.txt_desc:SetText(mcrandom.name)
        mView.txt_name:SetText(mcrandom.codename)
    else
        Logger.LogError("mcrandom is nil, @四叶, id = " .. mapCondId)
    end

    self:_UpdateItemState(mapCondId, isDone, mView)
end

-- 选项
function M:_GetOptionView(idx)
    local itemView = self.m_items[idx]
    if not itemView then
        itemView = self.m_items[1]:Instantiate()
        self.m_items[idx] = itemView
    end
    return itemView
end

function M:_UpdateItemState(mapCondId, isDone, mView)
    if self.m_wordsDic[mapCondId] then -- 已选中
        mView.uiState:SetState(2)
        mView.tglState:SetState(2)
    elseif isDone then -- 已完成
        mView.uiState:SetState(4)
        mView.tglState:SetState(1)
        -- elseif data.IsWin then -- 可领取
        --     mView.uiState:SetState(3)
        --     mView.tglState:SetState(1)
    else -- 未选中
        mView.tglState:SetState(1)
        mView.uiState:SetState(1)
    end
end

function M:_SetFixedEntry()
    local params = GameHelper.GetParamters(307)
    local len = params and params.Length or 0
    for i, item in ipairs(self.m_texts) do
        if i <= len then
            item:SetActive(true)
            item:SetText(params[i - 1])
        else
            item:SetActive(false)
        end
    end
end

return M
