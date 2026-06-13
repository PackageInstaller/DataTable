local M = BaseClass("BossWarMainUICtrl", BaseUICtrl)

function M:Init()
    self.m_labelIds = { 1304, 1305, 1306, 1307, 1308 }
    self._view.btn_shop:onClick(Bind(self, self.OnClickShop))
    self._view.btn_award:onClick(Bind(self, self.OnClickAward))
    self.m_missionItems = { self._view.missionItem1, self._view.missionItem2, self._view.missionItem3 }
end

function M:OnEnter()
    local datas = BossWarDataMgr:GetInstance():GetBossDatas() or {}
    local nextTick = BossWarDataMgr:GetInstance():NextRefreshTick()
    self:_SetLevel()
    self:_SetRemainTime()
    self:_SetMissionItems(datas)
    self:_AfterBattleBackReady(datas)
    if nextTick ~= PlayerPrefTools.GetPlayerPrefsInt("BossRefreshTick", -1) then
        local level = BossWarDataMgr:GetInstance():DifficultyLevel()
        if level > 1 then UIContextMgr:GetInstance():Show("BossWarLvUpUI", level) end
        PlayerPrefTools.SetPlayerPrefs("BossRefreshTick", nextTick)
    end
end

function M:OnDispose()
    self.m_missionItems = nil
    M.super.OnDispose(self)
end

function M:OnClickAward(go)
    UIContextMgr:GetInstance():Show("BossWarAwardUI")
end

function M:OnClickShop(go)
    GameHelper.Jump(51)
    --self:OpenModule(ModuleConfig.ShopModule.id, 1, 101)
end

function M:_SetLevel()
    local level = BossWarDataMgr:GetInstance():DifficultyLevel()
    local label = ConfigHelper.GetLocalString(self.m_labelIds[level] or 0)
    self._view.txt_level:SetText(string.format("%02d %s", level, label))
end

function M:_SetRemainTime()
    local curTime = TimeUtil.GetNowTimeStamp()
    local nextTime = BossWarDataMgr:GetInstance():NextRefreshTick()
    local second = math.max(0, nextTime - curTime)
    self._view.txt_day:SetText(string.format("%02d", math.floor(second / 86400)))
    self._view.txt_hour:SetText(string.format("%02d", math.floor((second % 86400) / 3600)))
end

function M:_SetMissionItems(datas)
    for i, item in ipairs(self.m_missionItems) do
        item:UpdateItem(datas[i], i)
    end
end

function M:_AfterBattleBackReady(datas)
    local module = ModuleMgr:GetInstance():GetCurrentModule()
    if module and module.IsBoss and module:IsBoss() then
        local bwId = BossWarTeamMgr:GetInstance():GetBossWarId()
        for i, value in ipairs(datas) do
            if value:BossWarId() == bwId then
                UIContextMgr:GetInstance():Show("BossWarReadyUI", value, i)
                break
            end
        end
    end
    BossWarTeamMgr:GetInstance():SetBossData(nil)
end

return M
