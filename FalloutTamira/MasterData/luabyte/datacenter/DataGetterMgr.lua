local DataGetterMgr = BaseClass("DataGetterMgr", Singleton)
local M = DataGetterMgr

function M:Load()
    -- 登录前
    self:AddLoad(IItemDataMgr, EGetterType.BeforeEnter, EGetterID.Item)
    self:AddLoad(EnergyMgr:GetInstance(), EGetterType.BeforeEnter, EGetterID.EnergyData)
    self:AddLoad(MissionDataMgr:GetInstance(), EGetterType.BeforeEnter, EGetterID.MissionData)

    -- 进入界面前
    self:AddLoad(IHeroDataMgr, EGetterType.BeforeMainScene, EGetterID.HeroData)
    self:AddLoad(IRoleStudioHeroDataMgr, EGetterType.BeforeMainScene, EGetterID.RoleStudioHeroData)
    self:AddLoad(ActivityDataMgr:GetInstance(), EGetterType.BeforeMainScene, EGetterID.ActivityData)
    self:AddLoad(TeamConfMgr:GetInstance(), EGetterType.BeforeMainScene, EGetterID.TeamConfig)
    self:AddLoad(IPlayerData, EGetterType.BeforeMainScene, EGetterID.PlayerData)
    self:AddLoad(PresentReturnDataMgr, EGetterType.BeforeMainScene, EGetterID.RepresentFixed)

    -- 进入主界面后 ，不影响主体逻辑，一般用于红点所需要的功能提交预热数据
    self:AddLoad(TaskDataMgr, EGetterType.AfterMainsScene, EGetterID.TaskData)
    self:AddLoad(FriendDataMgr:GetInstance(), EGetterType.AfterMainsScene, EGetterID.FriendApply)
    -- self:AddLoad(MailDataMgr, EGetterType.AfterMainsScene, EGetterID.Mail)
    self:AddLoad(PlotAtlasDataMgr:GetInstance(), EGetterType.AfterMainsScene, EGetterID.PlotAtlasData)
    self:AddLoad(ShopDataMgr, EGetterType.AfterMainsScene, EGetterID.ShopData)
    self:AddLoad(OtakuRoomDataMgr:GetInstance(), EGetterType.AfterMainsScene, EGetterID.OtakuData)
    self:AddLoad(AchievementDataMgr:GetInstance(), EGetterType.AfterMainsScene, EGetterID.AchievementData)
    self:AddLoad(ComRoomDataMgr:GetInstance(), EGetterType.AfterMainsScene, EGetterID.ComRoomData)
    self:AddLoad(INoticeDataMgr, EGetterType.AfterMainsScene, EGetterID.NoticeData)
    self:AddLoad(PassDataMgr:GetInstance(), EGetterType.AfterMainsScene, EGetterID.PassData) -- 主界面红点
    self:AddLoad(RechargeDataMgr:GetInstance(), EGetterType.AfterMainsScene, EGetterID.RechargeData)
    self:AddLoad(BossWarDataMgr:GetInstance(), EGetterType.AfterMainsScene, EGetterID.BossWarData) -- Boss战红点
    self:AddLoad(LevelFundMgr:GetInstance(), EGetterType.AfterMainsScene, EGetterID.LevelFundData) -- 成长基金红点
    self._onFinishHandler = Bind(self, self._OnFinish)
    self._onProgressHandler = Bind(self, self._OnProgress)
end

function M:AddLoad(dataGetter, type, id)
    IDataGetterMgr:AddLoad(dataGetter, type, id)
end

function M:RemoveLoad(dataGetter)
    IDataGetterMgr:RemoveLoad(dataGetter)
end

function M:Start(type, onFinish, onProgress)
    if type == EGetterType.AfterMainsScene or type == EGetterType.BeforeMainScene then
        if self:HasLoaded(type) then
            if onFinish then
                onFinish(0)
            end
            return
        end
    end
    self._loadingType = type
    self._onFinishCallback = onFinish
    self._onProgressCallback = onProgress
    IDataGetterMgr:Start(type, self._onFinishHandler, self._onProgressHandler)
end

function M:_OnFinish(errorCode)
    if self._onFinishCallback then
        self._onFinishCallback(errorCode)
    end
    if self._loadingType == EGetterType.AfterMainsScene then
        GameKeyNodeMgr:GetInstance():Record(EGameKeyNode.AfterMainScene)
        CommandMgr:GetInstance():PushExecute(2, "OpenMonthSignPopup")
        CommandMgr:GetInstance():PushExecute(1, "OpenLoginReward")
        CommandMgr:GetInstance():ExcuteOrder()

    end
    self._onFinishCallback = nil
    self._onProgressCallback = nil
end

function M:_OnProgress(progress)
    if self._onProgressCallback then
        self._onProgressCallback(progress)
    end
end

function M:TryCount()
    return IDataGetterMgr:TryCount()
end

function M:Cleanup()

end

function M:Dispose()

end

function M:HasLoaded(type)
    return IDataGetterMgr:HasLoaded(type)
end

return DataGetterMgr
