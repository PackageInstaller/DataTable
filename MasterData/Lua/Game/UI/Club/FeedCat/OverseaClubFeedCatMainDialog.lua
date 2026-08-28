---@type OverseaClubFeedCatMgr
local Mgr = import("Game.UI.Club.FeedCat.OverseaClubFeedCatMgr"):GetInstance()
---@type OverseaClubFeedCatUtils
local Utils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")

local cs_coroutine = import("XLua.cs_coroutine")
local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
local UINavigationBarRoot = CS.UINavigationBarRoot
local ChapterUtils = import('Game.Chapter.ChapterUtils')
local UIModule = CS.Engine.UI.UIModule
local Time = CS.UnityEngine.Time

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubFeedCatMain.prefab > name: OverseaClubFeedCatMain
---@class OverseaClubFeedCatMainDialog
---@field Env                            OverseaClubFeedCatMainDialog
---@field controller                        Engine.UI.UILuaDialog
---@field CommonTabToggleLeft            UnityEngine.RectTransform                @ 0    
---@field Root                            UnityEngine.RectTransform                @ 1    
---@field Role                            UnityEngine.RectTransform                @ 2    
---@field TextName                        UnityEngine.RectTransform                @ 3    
---@field TxtDesc                        UnityEngine.RectTransform                @ 4    
---@field OverseaClubFeedingDialog        UnityEngine.RectTransform                @ 5    
---@field OverseaClubFeedingSkinDialog    UnityEngine.RectTransform                @ 6    
local OverseaClubFeedCatMainDialog = Class("OverseaClubFeedCatMainDialog")

function OverseaClubFeedCatMainDialog:__init()
    self.controller = nil
    self.selectTab = 1
end

function OverseaClubFeedCatMainDialog:__delete()
    self.controller = nil
    CfUtils.EventsUndecorated(self.events)
end

function OverseaClubFeedCatMainDialog:Awake()
    self.events = CfUtils.EventsDecorated({
        [ClubUtils.EventName.FeedCat_LevelUp] = Bind(self, self.CatLevelUpEventHandle),
        [ClubUtils.EventName.FeedCat_PhaseUp] = Bind(self, self.CatPhaseUpEventHandle),
        [ClubUtils.EventName.FeedCat_RefineCoinChange] = Bind(self, self.RefreshUI),
        [ClubUtils.EventName.FeedCat_CatClick] = Bind(self, self.CatClickHandle),
        [ClubUtils.EventName.FeedCat_FeedSuccess] = Bind(self, self.CatEatEventHandle),
    })
end

function OverseaClubFeedCatMainDialog:OnInitialize()
    local function OnInitialize_()
        ---@type OverseaClubFeedingPanel
        self.feedPanel = CfUtils.GetLuaScr(self.OverseaClubFeedingDialog, "Game.UI.Club.FeedCat.Feed.OverseaClubFeedingPanel")
        ---@type OverseaClubFeedingSkinPanel
        self.skinPanel = CfUtils.GetLuaScr(self.OverseaClubFeedingSkinDialog, "Game.UI.Club.FeedCat.Skin.OverseaClubFeedingSkinPanel")
        self:InitTabData()

        local recordPhase = Utils.GetLocalPetsPhase()
        local curPhase = Utils.CalPetPhase(Mgr.Server.dojo.petsLevel)
        if recordPhase < curPhase then
            CfUtils.SetActive(self.Root, false)
            CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubFeedingUpDialog, { onClose = function()
                CfUtils.SetActive(self.Root, true)
                self:RefreshUI()
            end })
            Utils.SavePetsPhase(curPhase)
        else
            self:RefreshUI()
        end
    end

    local plotFlag = Utils.GetInitialPlot()
    if plotFlag == "0" then
        self:StartPlayPlot({ Utils.GetParamValue(Utils.ParamsId.InitialPlotId) }, function()
            OnInitialize_()
            Utils.SaveInitialPlot()
        end)

    else
        OnInitialize_()
    end
    
    Events.Broadcast(ClubUtils.EventName.FeedCat_Open)
end

function OverseaClubFeedCatMainDialog:OnFinalize()
    Events.Broadcast(ClubUtils.EventName.FeedCat_Close)
    self:Delete()
end

function OverseaClubFeedCatMainDialog:RefreshUI()
    ---@type CommonTabToggleLeft
    local tab = CfUtils.GetLuaScr(self.CommonTabToggleLeft, Constants.UILuaTablePath.ComTabToggle)
    tab:FillToggles(self.tabData, self.selectTab)

    
    local phaseVo = Utils.GetPhaseVo(Utils.CalPetPhase(Mgr.Server.dojo.petsLevel))
    CfUtils.FillText(self.TextName, phaseVo.title)
    --local vo = Utils.GetExpVo(Mgr.Server.dojo.petsLevel)
    --CfUtils.FillText(self.TxtDesc, vo.txtLevel)
    CfUtils.SetActive(self.Role.gameObject,false)
    self:RefreshRightPanel()
end

function OverseaClubFeedCatMainDialog:RefreshRightPanel()
    if self.selectTab == 1 then
        self.feedPanel:Show(true)
        self.skinPanel:Show(false)
    elseif self.selectTab == 2 then
        self.feedPanel:Show(false)
        self.skinPanel:Show(true)
    end
end

function OverseaClubFeedCatMainDialog:InitTabData()
    self.tabData = {
        {
            text = localize("投喂食物"),
            iconPath = 'Arts/Icons/HomeLabel/tab_ico_club_1.png',
            func = function()
                self:SwitchTab(1)
            end
        },
        {
            text = localize("外观洗练"),
            iconPath = 'Arts/Icons/HomeLabel/tab_ico_club_2.png',
            func = function()
                self:SwitchTab(2)
            end
        }
    }
end

function OverseaClubFeedCatMainDialog:StartPlayPlot(plotIds, cb)
    local co = cs_coroutine.start(function()
        for _, episodeId in ipairs(plotIds) do
            local wait = true
            local plotGo = nil
            local lastDialog = UIModule.CurrentScreen:LastDialog()
            ChapterUtils.ProcessChapter(checkNumber(episodeId), function(go)
                if lastDialog then
                    lastDialog.transform.localPosition = Vector3(9999, 9999, 9999)
                    URPCameraController:SetMainCameraActive(false)
                    UINavigationBarRoot.Instance:SetActive(false)
                    plotGo = go
                end
            end, function()
                if lastDialog then
                    lastDialog.transform.localPosition = Vector3(0, 0, 0)
                end
                URPCameraController:SetMainCameraActive(true)
                UINavigationBarRoot.Instance:SetActive(true)
                wait = false
            end)
            while wait do
                coroutine.yield()
            end
            CfUtils.SafeDelete(plotGo)
            coroutine.yield()
        end

        GameUtils.PlayMainBGM()
        if cb then
            cb()
        end
    end)
end

function OverseaClubFeedCatMainDialog:SwitchTab(index)
    self.selectTab = index
    self:RefreshRightPanel()
end

function OverseaClubFeedCatMainDialog:CatLevelUpEventHandle()
    --CfUtils.PlayAnimation(self.Role, "OverseaClubFeedCatMain_Role_Entry")
    local vo = Utils.GetExpVo(Mgr.Server.dojo.petsLevel)
    if vo then
        --CfUtils.FillText(self.TxtDesc, vo.txtLevel)
        self:SetText(vo.txtLevel)
    end
end

function OverseaClubFeedCatMainDialog:CatPhaseUpEventHandle()
    local curPhase = Utils.CalPetPhase(Mgr.Server.dojo.petsLevel)
    CfUtils.SetActive(self.Root, false)
    CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubFeedingUpDialog, { onClose = function()
        CfUtils.SetActive(self.Root, true)
        self:RefreshUI()
        self:CatLevelUpEventHandle()
    end })
    Utils.SavePetsPhase(curPhase)
end

function OverseaClubFeedCatMainDialog:CatClickHandle()
    local vo = Utils.GetTextVo(Mgr.Server.dojo.petsPhase, 1)
    if vo then
        --CfUtils.FillText(self.TxtDesc, vo.text)
        self:SetText(vo.text)
    end
end

function OverseaClubFeedCatMainDialog:CatEatEventHandle()
    local vo = Utils.GetTextVo(Mgr.Server.dojo.petsPhase, 2)
    if vo then
        self:SetText(vo.text)
    end
end

function OverseaClubFeedCatMainDialog:SetText(text)
    CfUtils.SetActive(self.Role.gameObject,true)
    CfUtils.FillText(self.TxtDesc, text)
    if not self.showingText then
        self.showingText = true
        self.showingTextTimer = 8
        CoStart(function()
            while self.showingTextTimer > 0 do
                self.showingTextTimer = self.showingTextTimer - Time.deltaTime
                CoYield()
            end
            if isNotNull(self.Role) then
                CfUtils.SetActive(self.Role.gameObject,false)
                self.showingText = false
            end
        end)
    else
        self.showingTextTimer = 8
    end
end

return OverseaClubFeedCatMainDialog