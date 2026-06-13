local M = BaseClass("BossWarAwardUICtrl", BaseUICtrl)

function M:Init()
    local view = require("UI.View.BossWar.BossWarAwardItemView")
    local ctrl = require("UI.Ctrl.BossWar.BossWarAwardItemCtrl")
    self.m_bossWarId = 0
    self.m_quickState = 2 -- 不可领取
    self.m_tabDatas = {}
    self.m_totalChests = {}
    self._view.looplist:Init(ctrl, view)
    self.m_onUpdate = Bind(self, self._UpdateLoopList)
    self._view.txt_back:onClick(Bind(self, self.Close))
    self._view.btn_quick:onClick(Bind(self, self.OnClickQuick))
    self._view.tgl_cycle:OnToggleClick(Bind(self, self.OnCycleChanged))
    self._view.tgl_battle:OnToggleClick(Bind(self, self.OnBattleChanged))
end

function M:OnEnter()
    local function firstGet(tbl)
        if tbl.GetState() ~= 2 then return end
        BossWarDataMgr:GetInstance():ReqBossBattleFirstChests({ BossWarId = tbl.Id, Step = tbl.Stage }, self.m_onUpdate)
    end
    local function chestGet(tbl)
        if tbl.GetState() ~= 2 then return end
        BossWarDataMgr:GetInstance():ReqBossBattleChests({ BossWarId = tbl.Id, Step = tbl.Stage }, self.m_onUpdate)
    end
    local firstlist, names, bossWarIds = {}, {}, {} -- 挑战奖励，放最后
    for _, data in ipairs(BossWarDataMgr:GetInstance():GetBossDatas() or {}) do
        local id, icon = data:BossWarId(), data:BossIcon()
        local curStage, stageNum, percent = data:BloodStage()
        local cycleChests, firstChests = data:CycleChests(), data:FirstChests()
        local isPass = (percent <= 0) and ((curStage + 1) >= stageNum)
        local name = ConfigHelper.GetLocalString(data:BossName())

        for i, value in ipairs(firstChests) do
            local idx = i - 1
            table.insert(firstlist, {
                Id = id,
                Stage = i,
                Icon = icon,
                Name = name,
                Items = value,
                StageNum = stageNum,
                GetReward = firstGet,
                GetState = function()
                    -- 1:Normal 2:Can Award 3:Awarded
                    if data:IsGetFirstChest(idx) then return 3 end
                    return ((idx >= curStage) and not isPass) and 1 or 2
                end,
            })
        end
        local tbl = {}
        for i, value in ipairs(cycleChests) do
            local idx = i - 1
            table.insert(tbl, {
                Id = id,
                Stage = i,
                Icon = icon,
                Name = name,
                Items = value,
                StageNum = stageNum,
                GetReward = chestGet,
                GetState = function()
                    if data:IsGetChest(idx) then return 3 end
                    return ((idx >= curStage) and not isPass) and 1 or 2
                end,
            })
        end
        table.insert(names, name)
        table.insert(bossWarIds, id)
        table.insert(self.m_totalChests, tbl)
    end
    self._view.bossTab:InitItems(0, names, Bind(self, self.OnBossTabChanged))
    table.insert(self.m_totalChests, firstlist)
    self._view.tgl_battle:SetIsOn(true)
    for i, id in ipairs(bossWarIds) do
        local idx = i - 1
        self._view.bossTab:SetRedPointParma(idx, 0, id)
        self._view.bossTab:SetRedPointCheck(idx)
    end
end

function M:OnDispose()
    self.m_onUpdate = nil
    self.m_tabDatas = nil
    self.m_totalChests = nil
    M.super.OnDispose(self)
end

function M:OnBattleChanged(isOn)
    self._view.firstTips:SetActive(isOn)
    if isOn then
        self:_UpdateRewardList(#self.m_totalChests)
    end
end

function M:OnCycleChanged(isOn)
    self._view.chestTips:SetActive(isOn)
    self._view.bossTab:SetActive(isOn)
    if isOn then
        self._view.bossTab:TabSelect(0)
    end
end

function M:OnBossTabChanged(idx)
    self:_UpdateRewardList(idx + 1)
end

function M:OnClickQuick(go)
    if self.m_quickState ~= 1 then return end
    if self._view.tgl_battle:GetIsOn() then
        --如果BossWarId和Step都为0, 为一键领取
        BossWarDataMgr:GetInstance():ReqBossBattleFirstChests({ BossWarId = 0, Step = 0 }, self.m_onUpdate)
    else
        BossWarDataMgr:GetInstance():ReqBossBattleChests({ BossWarId = self.m_bossWarId, Step = 0 }, self.m_onUpdate)
    end
end

function M:_UpdateRewardList(idx)
    self.m_tabDatas = self.m_totalChests[idx]
    self.m_bossWarId = self.m_tabDatas[1].Id
    self:_SortBossDatas()
    self._view.looplist:SetDataList(self.m_tabDatas)
    self:_UpdateQuickState()
end

function M:_UpdateQuickState()
    self.m_quickState = 2
    for _, value in ipairs(self.m_tabDatas) do
        if value.GetState() == 2 then
            self.m_quickState = 1 -- 一键领取
            break
        end
    end
    self._view.btn_quick:SetState(self.m_quickState)
end

function M:_UpdateLoopList()
    self:_SortBossDatas()
    self._view.looplist:UpdateList()
    self:_UpdateQuickState()
    IRedPointMgr:ForceCheck(RedPointConst.BossWarFirstRedPointChecker)
    IRedPointMgr:ForceCheck(RedPointConst.BossWarChestRedPointChecker)
end

function M:_SortBossDatas()
    table.sort(self.m_tabDatas, function(a, b)
        local a_s, b_s = a.GetState(), b.GetState()
        if a_s == b_s then
            if a.Stage == b.Stage then
                return a.Id < b.Id
            else
                return a.Stage < b.Stage
            end
        else
            if a_s + b_s == 3 then
                return a_s > b_s
            else
                return a_s < b_s
            end
        end
    end)
end

return M
