local M = BaseClass("StageModule", require("Framework.Module.BaseGameModule"))
local EBattleStyle = EnumConst.EBattleStyle

function M:__init()
    self.m_chapter = nil
    self.m_jumpToMissionId = 0
    self.m_battleStyle = EBattleStyle.Normal -- 战斗模式
end

function M:OnEnter(battleStyle, chapter, id, isWin)
    M.super.OnEnter(self)

    if isWin == nil then isWin = false end
    self.m_isWin = isWin
    self.m_battleStyle = battleStyle
    -- 悬赏 和 遭遇战 和 Boss战 不需要去主界面
    if not self:IsReward() and not self:IsEncount() and not self:IsBoss() then
        self.m_chapter = chapter
        if not self.m_chapter then
            local chapterId = IPlayerData.cur_chapterId
            if chapterId > 0 then
                self.m_chapter = ConfigHelper.GetCfgByLua("chapter", chapterId)
            end
        end

        if not self.m_chapter then
            self:ChangeModule(ModuleConfig.MainSceneModule.id)
            return
        end
    end

    TeamConfMgr:GetInstance():SetBattleType(self.m_battleStyle)
    GameState.CurChapterType = self.m_chapter and self.m_chapter.type or 0
    self.m_jumpToMissionId = id or 0
    if self:GetCurSceneName() ~= "Display02" then
        self:LoadScene("Display02", Bind(self, self.OnLoadComplete))
    else
        self:OnLoadComplete(self:GetViewAndCtrl("Display02"))
    end
end

function M:OnExit()
    self.m_chapter = nil
    self.m_battleStyle = nil
    self.m_jumpToMissionId = nil
    GameState.CurChapterType = nil
    UIContextMgr:GetInstance():Close("TargetRewardUI")
    M.super.OnExit(self)
end

function M:OnLoadComplete(_, ctrl)
    ctrl:ChangeDisplay("")
    UIContextMgr:GetInstance():Close("ChapterSelection")

    --等待数据加载完成，再显示主界面
    DataGetterMgr:GetInstance():Start(EGetterType.BeforeMainScene, Bind(self, self.CheckWaitDataRequest), nil)
end

function M:CheckWaitDataRequest()
    

    -- 悬赏关卡 or 遭遇战 or Boss战
    if self:IsReward() or self:IsEncount() or self:IsBoss() then
        self:Ready()
        self:ShowUI("ChapterSelection", nil, self.m_battleStyle, self.m_isWin)
        return
    end

    if GameState.CurChapterType == ChapterConst.EChapterType.ECT_Encounter then
        self:ShowUI("ChapterSelection", nil, self.m_battleStyle, self.m_isWin)
        self:Ready()
    else
        if self:IsMaskedBall() then -- 假面舞会
            self:ShowUI("MissionActivityStageUI", self.m_chapter, self.m_jumpToMissionId)
            self:Ready()
        elseif self:LimitChallge() then -- 极限挑战
            local handler = UIContextMgr:GetInstance():Show("LimiteChallgeStage")
            handler.onShow = function()
                self:Ready()
            end
        else
            self:ShowUI("MissionStageUI", self.m_chapter, self.m_jumpToMissionId)
            self:Ready()
        end
    end

    MissionDataMgr:GetInstance():ShowPostMissionPopup()
end

function M:GetGetCurChapterType()
    if not self.m_chapter then return 0 end
    return self.m_chapter.type
end

function M:IsReward()
    return self.m_battleStyle == EBattleStyle.Reward
end

function M:IsEncount()
    return self.m_battleStyle == EBattleStyle.Encount
end

function M:IsBoss()
    return self.m_battleStyle == EBattleStyle.Boss
end

-- 假面舞会
function M:IsMaskedBall()
    if not self.m_chapter then return false end
    local subType = self.m_chapter.subType
    return (subType == 1001) or (subType == 1002)
end

-- 平行宇宙
function M:IsMultiverse()
    if not self.m_chapter then return false end
    local subType = self.m_chapter.subType
    return (subType == 2001) or (subType == 2002)
end

-- 极限挑战
function M:LimitChallge()
    if not self.m_chapter then return false end
    return  self.m_chapter.type  == ChapterConst.EChapterType.ECT_LimitChallge
end


return M
