local M = BaseClass("BattleResultContext", BaseContext)
local EBattleStyle = EnumConst.EBattleStyle

function M:Open(isWin, items, extItems, start, type, closeCallBack)
    self.m_type = type
    self.m_item = items
    self.m_start = start
    self.m_extItems = extItems
    self.m_closeCallBack = closeCallBack
    self.m_mission = IBattle.context.missionData
    self.m_isWin = isWin == protocol.BattleRes.WIN

    local systemCfg = ConfigHelper.GetSystemParams(252)
    local isEnd = OpenConditionMgr:GetInstance():Execute(systemCfg[1])
    if isEnd then
        self:ShowUI()
        return
    end

    local isStart = OpenConditionMgr:GetInstance():Execute(systemCfg[0])
    local curLv = MissionHelper.GetMissionHeroLV()
    local slider = curLv * 100 / self.m_mission.showLv
    if isStart and slider < 60 and not self.m_isWin then
        UIContextMgr:GetInstance():Show(UIDefine.UIMissionLv, Bind(self, self.ShowUI), true)
        return
    end

    self:ShowUI()
end

function M:ShowUI()
    if self.m_isWin then
        -- local missionId = self.m_mission.id
        -- local backupArr = ConfigHelper.GetCfg("system", 266).param
        -- local md = MissionDataMgr:GetInstance():GetMissionDataById(missionId)
        -- local isFirstPass = md and md:GetPassCount() == 1 or false
        -- isFirstPass = true  --用于测试
        -- if table.contains(backupArr, missionId) and isFirstPass then
        --     -- 战后剧情结束之后立即返回主界面
        --     ModuleMgr:GetInstance():ChangeModule(ModuleConfig.MainSceneModule.id)
        --     return
        -- end
    end
    CloseBattleRelatedUI()
    self:_Show(self.m_isWin, self.m_mission.loseGuide, self.m_mission.loseDesc or "")
end

function M:OnClose()
    self:_Close()

    if self.m_isWin then
        if self.m_closeCallBack then
            self.m_closeCallBack()
        end
        --self:_OnWinCallBack()
    else
        self:_OnFailCallBack()
    end
end

function M:_OnWinCallBack()
    local roleGiftId = {}
    local length = self.m_item.Count
    for i = 0, length - 1 do
        local item = self.m_item[i]
        local cfg = ConfigHelper.GetCfg("item", item.SrcId)
        if cfg and cfg.type == BagConst.ItemType.EIT_Hero then
            local obj = {}
            obj.ObjId = item.SrcId
            obj.ObjNum = 1
            obj.ChipId = item.Id
            obj.ChipNum = item.Cnt
            roleGiftId[#roleGiftId + 1] = obj
        end
    end

    if #roleGiftId > 0 then
        if self.m_closeCallBack ~= nil then
            GameHelper.ShowRolesStarSuccess(roleGiftId, Bind(self, self.m_closeCallBack))
        end
    else
        --self:_OpenBattleSettlementPanel()
        self.m_closeCallBack()
    end
end

function M:_OpenBattleSettlementPanel()
    local uiName = UIDefine.BattleSettlementUI
    UIContextMgr:GetInstance():Show(uiName, self.m_isWin, self.m_start, self.m_item, self.m_extItems, self.m_type)
end

--失败
function M:_OnFailCallBack()
    local battleStyle = EBattleStyle.Normal
    if self.m_mission.Chapter.type == ChapterConst.EChapterType.ECT_Encounter then
        battleStyle = EBattleStyle.Encount
    elseif self.m_mission.Chapter.type == ChapterConst.EChapterType.ECT_Personal then
        battleStyle = EBattleStyle.Personal
    end
    -- 主线关卡
    if self.m_type == EBattleStyle.Normal then
        if self.m_mission.Chapter.type ~= ChapterConst.EChapterType.ECT_None then
            ModuleMgr:GetInstance():ChangeModule(ModuleConfig.StageModule.id, battleStyle, nil, nil, false)
            return
        end

        ModuleMgr:GetInstance():ChangeModule(ModuleConfig.ChallengeModule.id)
        return
    end

    --遭遇战
    if self.m_type == EBattleStyle.Encount then
        ModuleMgr:GetInstance():ChangeModule(ModuleConfig.StageModule.id, battleStyle, nil, nil, false);
        return
    end

    --个人副本
    if self.m_type == EBattleStyle.Personal then
        ModuleMgr:GetInstance():ChangeModule(ModuleConfig.Dorm.id, IBattle.comtext.persional_HeroId);
        return
    end

    --悬赏副本
    if self.m_type == EBattleStyle.Reward then
        UIContextMgr:GetInstance():GetContext("MissionOfferRewards"):BattleBack()
        ModuleMgr:GetInstance():ChangeModule(ModuleConfig.MainSceneModule.id)
        return
    end

    ModuleMgr:GetInstance():ChangeModule(ModuleConfig.StageModule.id, battleStyle, nil, nil, false)
end

return M
