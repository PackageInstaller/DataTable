local MainSceneModule = BaseClass("MainSceneModule", require("Framework.Module.BaseGameModule"))
local M = MainSceneModule

local CS_UIFormsType = CS.GameX.UIFormsType
local MAX_SHOW_GIRL_CACHE_COUNT = 5 -- 缓存战员数量
local REMOVE_GIRL_COUNT = 3 -- 达到缓存数量之后，一次性删除的个数
local EBattleStyle = EnumConst.EBattleStyle
local tInsert = table.insert
local HOURS5 = 18000
local showHeroId = 120002

function M:__init()
    self._allGirls = {}
    self._openUI = nil
    self._openUIParam = nil
    self._OnShowGirlDisposeHandler = Bind(self, self._OnShowGirlDispose)
end

function M:OnEnter(uiName, ...)

    self._openUI = uiName
    if self._openUI == nil then
        self._openUI = "MainSceneUI"
    end
    self._openUIParam = {...}
    IRoleActionMgr:Reset()
    if CS.GameX.GameGlobal.guideFunctionOpen then
        local curMissionId = IPlayerData.missionId
        local initMissionId = GameHelper.GetParamter(101)
        if curMissionId == 0 then
            curMissionId = initMissionId
        else
            local nextData = MissionDataMgr:GetInstance():GetNextMissionData()
            if nextData then
                curMissionId = nextData:GetMissionId()
            end
        end
        -- 是否完成前3关的新手关卡
        local newbieMissionId = GameHelper.GetParamter(171)
        if not MissionDataMgr:GetInstance():IsMissionPassById(newbieMissionId) then
            -- 如果一关未通过，即当前进度为system中配置的初始关卡，则直接开战
            if curMissionId == initMissionId then
                IBattle:EnterBattle(curMissionId)
            else
                local firstMissionDate = MissionDataMgr:GetInstance():GetMissionDataById(initMissionId)
                local secondMissionId = firstMissionDate:GetNextMissionId()
                if secondMissionId == curMissionId then -- 该打第二关
                    IBattle:EnterBattle(curMissionId)
                    return
                end

                local chapter_1 = firstMissionDate:GetChapter()
                local battleStyle = EBattleStyle.Normal
                if chapter_1.type == ChapterConst.EChapterType.ECT_Encounter then
                    battleStyle = EBattleStyle.Encount
                elseif chapter_1.type == ChapterConst.EChapterType.ECT_Personal then
                    battleStyle = EBattleStyle.Personal
                end
                self:ChangeModule(ModuleConfig.StageModule.id, battleStyle, chapter_1)
            end
            return
        end
    end
    -- self.isDining = self:GetCurSceneName() == "Dining02"
    if self:GetCurSceneName() ~= "Display02" then
        self._OnStartLoadSceneHandler = Bind(self, self.OnStartLoadScene)
        IGameEventMgr:RegisterEventHandleByTypeName("SceneStartLoadEvent", self._OnStartLoadSceneHandler)
        self:LoadScene("Display02", Bind(self, self.OnSceneLoadCompleted))
        UIManager:GetInstance():CacheAysn()
    else
        self:OnSceneLoadCompleted(self:GetViewAndCtrl("Display02"))
    end
    self._ChangeCenterGirlEventHandler = Bind(self, self.OnChangeCenterGirlEvent)
    EventMgr:AddListener(UIMessageNames.CHANGE_MAINSCENE_HERO, self._ChangeCenterGirlEventHandler)
    if self._ChangeBackgroundEventHandler then
        EventMgr:RemoveListener(UIMessageNames.CHANGE_MAINSCENE_BACKGROUND, self._ChangeBackgroundEventHandler)
    end
    self._ChangeBackgroundEventHandler = EventMgr:AddListener(UIMessageNames.CHANGE_MAINSCENE_BACKGROUND, Bind(self, self._OnChangeBackground))

    self._isReady = false
end

function M:_OnChangeBackground(backgroundName, isOpen)
    if isOpen then
        self._ctrl:ChangeDisplay(backgroundName)
        IRoleActionMgr:Reset()
        UIContextMgr:GetInstance():Close("RoleWordUI");
    end
    if backgroundName == "ShopBg" then
        if isOpen then
            local model = CS.UnityEngine.GameObject.Find("ShopModel").transform
            if not self._landlady then
                RoleBehaviorCtrl:GetInstance():RemoveAllGirls()
                self._landlady = RoleBehaviorCtrl:GetInstance():CreateGirl(showHeroId, false, require("RoleBehavior.Ctrls.CommonShowCtrl"), RoleUse.Shop,1)
                self._landlady.transform:SetParent(model)
                self._landlady:SetCanTouch(false)
                self._landlady.transform:Reset()
                self._landlady:Run()
            end
        else
            if self._landlady then
                self._landlady = nil
                RoleBehaviorCtrl:GetInstance():RemoveGirl(showHeroId, RoleUse.Shop)
            end
        end
    else
        if self._landlady then
            self._landlady = nil
            RoleBehaviorCtrl:GetInstance():RemoveGirl(showHeroId, RoleUse.Shop)
        end
    end
    CS.AutoBackground.ReDrawAll()
end

-- 主场景角色 region

function M:GetShowGirlData(isInit)
    -- body
    local pictureId = IPlayerData.pictureId
    local herodata = IHeroDataMgr:GetMyHeroDataById(pictureId)
    return herodata
end

function M:OnResetGirlEvent(evt)
    self:ResetShowGirlRotation()
end

function M:OnChangeCenterGirlEvent(evt)
    self:ChangeShowGirl(evt.heroData)
end

-- 用于主界面显示的时候，检查一下相关英雄是否显示
function M:CheckShowGirl()
    if self._allGirls[self._curHeroSkinId] == nil then
        self._sg = nil
        local data = self:GetShowGirlData(true)
        -- self:InitHeroModels()
        self:ChangeShowGirl(data)
    end
end

-- 设置主场景相机所在结点激活情况
function M:SetCameraNodeActive(isActive)
    if isActive then
        if self._landlady then
            self._landlady = nil
            RoleBehaviorCtrl:GetInstance():RemoveGirl(showHeroId, RoleUse.Shop)
        end
        self._ctrl:ChangeDisplay("CharacterShow")
    else
        -- 已经切换过了
        if self._ctrl:GetCurSceneName() ~= "CharacterShow" then
            return
        end
        self._ctrl:ChangeDisplay("")
    end
end

function M:_OnShowGirlDispose(heroId)
    self._allGirls[heroId] = nil
end

function M:ChangeShowGirl(herodata)
    if IsNull(herodata) then
        return
    end
    if not IsNull(self._sg) then
        self._sg:Hide()
    end
    local modelGo = CS.UnityEngine.GameObject.Find("Model")
    if modelGo == nil then
        return
    end
    local model = modelGo.transform
    -- local model = go.transform:Find("Model")
    local heroId = herodata:GetHeroId()
    local skinId = GameHelper.HeroId2SkinId(heroId, herodata:GetFashion())
    if self._allGirls[skinId] then
        self._sg = self._allGirls[skinId]
    else
        self:CreateShowGirl(herodata, model)
    end
    self._sg:Show()
    self._curHeroSkinId = skinId
    self:RefrshHeroPosition(self._sg.transform, herodata)
end

function M:CreateShowGirl(heroData, tf)
    local showGirlId = heroData:GetHeroId()

    local skinId = GameHelper.HeroId2SkinId(showGirlId, heroData:GetFashion())

    self._sg = RoleBehaviorCtrl:GetInstance():CreateGirl(heroData:GetHeroId(), false, require("RoleBehavior.Ctrls.CommonShowCtrl"), RoleUse.MainScene)
    self._sg.transform:SetParent(tf, false);
    self._sg:SetCanTouch(true)
    self._sg.disposeCallback = self._OnShowGirlDisposeHandler
    self._allGirls[skinId] = self._sg

    -- 检测需要回收的角色
    if table.count(self._allGirls) >= MAX_SHOW_GIRL_CACHE_COUNT then
        local heroIdList = {}
        for id, _ in pairs(self._allGirls) do
            if id ~= skinId and #heroIdList <= REMOVE_GIRL_COUNT then
                tInsert(heroIdList, id)
            end
        end
        for _, heroId in ipairs(heroIdList) do
            -- body
            RoleBehaviorCtrl:GetInstance():RemoveGirl(heroId)
            self._allGirls[heroId] = nil
        end
        ResourceManager:GetInstance():RemoveUnusedAssets()
    end

end

function M:ResetShowGirlRotation()
    if not IsNull(self._sg) then
        self._sg.transform.localEulerAngles = CS.UnityEngine.Vector3
    end
end

function M:RefrshHeroPosition(tf, heroData)
    local offset = {}
    if not IsNull(heroData:GetSkinCfg().offset) then
        local csOffset = heroData:GetSkinCfg().offset
        offset[1] = csOffset[0] * 0.001
        offset[2] = csOffset[1] * 0.001
        offset[3] = csOffset[2] * 0.001
    else
        offset = {}
        offset[1] = 0
        offset[2] = 0
        offset[3] = 0
    end
    tf.localPosition = CS.UnityEngine.Vector3(offset[1], offset[2], offset[3])
end

-- 主场景角色 endRegion

function M:OnStartLoadScene(ev)
    local camera = ICameraMgr:GetCamera(CS.GameX.ECameraType.MainCamera)
    if not IsNull(camera) then
        GameUtil.DestroyGo(camera.gameObejct)
    end
    IGameEventMgr:UnRegisterEventHandleByTypeName("SceneStartLoadEvent", self._OnStartLoadSceneHandler)
end

-- 用于切换时，不用突兀
function M:OnDisActive()
    self:CloseUI("MainSceneUI")
    -- RoleBehaviorCtrl:GetInstance():RemoveAllGirls()
    UIContextMgr:GetInstance():Close("RoleWordUI");
    for heroId, sg in pairs(self._allGirls) do
        RoleBehaviorCtrl:GetInstance():RemoveGirl(heroId, RoleUse.MainScene)
    end
    -- ResourceManager:GetInstance():RemoveUnusedAssets()
    self._sg = nil
    self._allGirls = {}
end

function M:OnExit()
    M.super.OnExit(self)
    self:CloseUI("ShopUI")
    self:CloseUI("ChangeShowGirl")
    IGameEventMgr:UnRegisterEventHandleByTypeName("SceneStartLoadEvent", self._OnStartLoadSceneHandler)
    EventMgr:RemoveListener(UIMessageNames.CHANGE_MAINSCENE_HERO, self._ChangeCenterGirlEventHandler)
    if self._ChangeBackgroundEventHandler then
        EventMgr:RemoveListener(UIMessageNames.CHANGE_MAINSCENE_BACKGROUND, self._ChangeBackgroundEventHandler)
    end
    self._ChangeBackgroundEventHandler = nil
    self.landlady = nil
    RoleBehaviorCtrl:GetInstance():RemoveGirl(showHeroId, RoleUse.Shop)
end

function M:OnSceneLoadCompleted(v, ctrl)
    -- local _,ctrl = self:GetViewAndCtrl("Display02")
    self._ctrl = ctrl
    if self._openUI and self._openUI == "MainSceneUI" then
        ctrl:ChangeDisplay("CharacterShow")
    end

    self._holder = ctrl:GetHolder("CharacterShow")

    -- 等待数据加载完成，再显示主界面
    DataGetterMgr:GetInstance():Start(EGetterType.BeforeMainScene, Bind(self, self.CheckWaitDataRequest), nil)
    -- 5点钟提醒
    ITimeNotifier:AddTime(5, 0)
end

function M:CheckWaitDataRequest(result)
    -- 本来是处理加载断线重连可以连接问题，其他界面会返回result，所以建议使用特殊的result code进行处理断线重连问题
    -- if result ~= 0 then
    --     self:Ready()
    --     return
    -- end
    UIContextMgr:GetInstance():CloseUIByType(CS_UIFormsType.Normal)
    UIContextMgr:GetInstance():CloseUIByType(CS_UIFormsType.Fixed)
    UIContextMgr:GetInstance():CloseUIByType(CS_UIFormsType.PopUp)
    self.cameraDirector = CS.GameX.Battle.MainSceneCameraDirector(nil)
    self:ShowUI(self._openUI, SafeUnpack(self._openUIParam))
    self:HandlerGirlAysn()
end

function M:HandlerGirlAysn()
    coroutine.start(function()
        -- 显示模型
        -- local data = self:GetShowGirlData(true)
        -- self:InitHeroModels()
        -- self:ChangeShowGirl(data)
        coroutine.waitforseconds(0.2)
        self:Ready()
        self._isReady = true
        -- 检测是否跨天
        if INetPack.connector:CheckClockUp() then
            return
        end
        DataGetterMgr:GetInstance():Start(EGetterType.AfterMainsScene)
        coroutine.waitforseconds(0.2)
        CommandMgr:GetInstance():PushExecute(3, "OpenNoticePopup")
        CommandMgr:GetInstance():ExcuteOrder()
    end)
end

return M
