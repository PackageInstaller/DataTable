-------------------------------------------------------------------------------
-- Pass卡 - 入口界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-28 18:01:05
-------------------------------------------------------------------------------

local PassCardUtils = import('Game.UI.PassCard.PassCardUtils')
local passCardComp  = PassCardUtils.GetComp()

local TabViewType = {
    Rewards = 1, -- 奖励
    Tasks   = 2, -- 任务
}

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/BattlePass/BattlePassEntryDialog.prefab > name: BattlePassEntryDialog
---@class BattlePassEntryDialog
---@field Env                           	BattlePassEntryDialog                   
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BuyPassPanel                  	UnityEngine.RectTransform               @ Pass卡购买界面
---@field LeftTabToggle                 	UnityEngine.RectTransform               @ 左侧页签控制节点
---@field UIContainer                   	UnityEngine.RectTransform               @ 面板的容器节点
---@field Root                          	UnityEngine.RectTransform               @ 根节点
local BattlePassEntryDialog = Class('BattlePassEntryDialog')


function BattlePassEntryDialog:__init()
    ---@type CommonTabToggleLeft @ 左侧页签控制器
    self.viewTabEnv_ = nil
    
    ---@type table[] @ 视图切换页签数据
    self.viewTabDatas_ = nil

    ---@type table<integer, UnityEngine.GameObject> @ 视图面板节点map（key：视图类型，value：视图节点）
    self.viewPanelMap_ = {}

    ---@type table<integer, boolean> @ 初始化视图状态map（key：视图类型，value：是否初始化完）
    self.initedViewMap_ = {}

    ---@type table<integer, boolean> @ 初始化指定数据map（key：视图类型，value：是否初始化完）
    self.initedDataMap_ = {}

    ---@type UnityEngine.Coroutine @ 页签创建协程
    self.createNodeCo_ = nil

    ---@type UIBattlePassBuyManualDialog @ 购买Pass卡界面
    self.buyPassPanelEnv_ = nil

    ---@type boolean @ 防止改层级 @see UINavigatorBar.OnBackButtonAction
    self.isBatch = true
end


function BattlePassEntryDialog:__delete()
    self.viewTabEnv_      = nil
    self.viewTabDatas_    = nil
    self.viewPanelMap_    = nil
    self.initedViewMap_   = nil
    self.initedDataMap_   = nil
    self.createNodeCo_    = nil
    self.buyPassPanelEnv_ = nil
end


function BattlePassEntryDialog:Awake()
    self.OnBuyDialogEvent_ = Events.AddListener(PassCardUtils.EventName.PASS_CARD_BUY_DIALOG, Bind(self, self.OnBuyDialogEventHandler_))
    self.buyPassPanelEnv_  = CfUtils.GetLuaScr(self.BuyPassPanel, 'Game.UI.PassCard.BattlePassBuyManual.UIBattlePassBuyManualDialog')
    self.viewTabEnv_       = CfUtils.GetLuaScr(self.LeftTabToggle, Constants.UILuaTablePath.ComTabToggle)
    self:InitViewTabData_()
end


---@param isFocus boolean
function BattlePassEntryDialog:OnFocus(isFocus)
    if isFocus then
        CfUtils.RefreshTopGoodsNew()
    end
end


function BattlePassEntryDialog:OnInitialize()
    return CoWaitDo(function()
        -- init var
        local initParams = CfUtils.DialogSafeParameters(self.controller)

        -- 是否以 显示购买界面 的方式打开
        -- 例如：打开购买界面 -> 查看奖励卡牌预览界面（会关闭该界面） -> 返回这里（需要直接显示购买界面）
        if initParams.isShowBuyDialog then
            initParams.isShowBuyDialog = nil
            initParams.selectTabIndex  = TabViewType.Rewards
            self:SetOpenBuyPanel(true)
        else
            initParams.selectTabIndex = initParams.selectTabIndex or TabViewType.Rewards
            self:SetOpenBuyPanel(false)
        end
    end)
end


function BattlePassEntryDialog:OnFinalize()
    return CoWaitDo(function()
        Events.RemoveListener(PassCardUtils.EventName.PASS_CARD_BUY_DIALOG, self.OnBuyDialogEvent_)

        -- 记录当前面板位置
        local initParams = self.controller.Argument.parameters or {}
        initParams.selectTabIndex = self:GetSelectTabIndex()

        -- 让当前的面板有机会保存关闭变量
        if self.viewPanelMap_ then
            local currentTabIndex  = self:GetSelectTabIndex()
            local currentTabData   = checkTable(self.viewTabDatas_[currentTabIndex])
            local currentViewType  = checkInt(currentTabData.tabType)
            local currentPanelData = self.viewPanelMap_[currentViewType]
            local currentPanelEnv  = currentPanelData and currentPanelData.src or nil
            if currentPanelEnv and currentPanelEnv.OnClose then
                currentPanelEnv:OnClose(initParams)
            end
        end
        
        if self.createNodeCo_ then
            CoStop(self.createNodeCo_)
            self.createNodeCo_ = nil
        end

        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


function BattlePassEntryDialog:HandleBackAction()
    if self:IsOpenBuyPanel() then
        self.buyPassPanelEnv_:DoHide()
    else
        CfUtils.DialogBack()
    end
end


-------------------------------------------------
-- get / set

---@return boolean
function BattlePassEntryDialog:IsOpenBuyPanel()
    return checkBool(self.isOpenBuyPanel_)
end
function BattlePassEntryDialog:SetOpenBuyPanel(isOpen)
    self.isOpenBuyPanel_ = checkBool(isOpen)
    self:UpdateBuyPanelState_()
end


---@return integer
function BattlePassEntryDialog:GetSelectTabIndex()
    return checkInt(self.selectTabIndex_)
end
function BattlePassEntryDialog:SetSelectTabIndex(tabIndex)
    self.selectTabIndex_ = checkInt(tabIndex)
end


---@param viewType integer
---@return boolean
function BattlePassEntryDialog:IsInitedViewState(viewType)
    return checkBool(self.initedViewMap_[checkInt(viewType)])
end
function BattlePassEntryDialog:SetInitedViewState(viewType)
    self.initedViewMap_[checkInt(viewType)] = true
end


---@param viewType integer
---@return boolean
function BattlePassEntryDialog:IsInitedDataState(viewType)
    return checkBool(self.initedDataMap_[checkInt(viewType)])
end
function BattlePassEntryDialog:SetInitedDataState(viewType)
    self.initedDataMap_[checkInt(viewType)] = true
end


-------------------------------------------------
-- private

function BattlePassEntryDialog:InitViewTabData_()
    self.viewTabDatas_ = {
        {
            text            = localize('奖励'),
            iconPath        = 'Arts/Icons/HomeLabel/tab_ico_psaa_1.png',
            prefabe         = 'Prefabs/BattlePass/BattlePassContractManual.prefab',
            srcPath         = 'Game.UI.PassCard.BattlePassContractManual.UIBattlePassContractManualDialog',
            tabType         = TabViewType.Rewards,
            func            = Bind(self, self.OnClickViewTypeTabHandler_),
            requestFunc     = Bind(passCardComp, passCardComp.SyncPassHomeData),
            redPointStrNode = Constants.RedPointConst.BattlePassRewards,
        },
        {
            text            = localize('任务'),
            iconPath        = 'Arts/Icons/HomeLabel/tab_ico_psaa_2.png',
            prefabe         = 'Prefabs/BattlePass/BattlePassTaskPopup.prefab',
            srcPath         = 'Game.UI.PassCard.BattlePassTaskPopup.UIBattlePassTaskPopupDialog',
            tabType         = TabViewType.Tasks,
            func            = Bind(self, self.OnClickViewTypeTabHandler_),
            requestFunc     = Bind(passCardComp, passCardComp.SyncPassTaskData),
            redPointStrNode = Constants.RedPointConst.BattlePassTask,
        },
    }
end


function BattlePassEntryDialog:UpdateBuyPanelState_()
    local isOpenBuyPanel = self:IsOpenBuyPanel()
    CfUtils.SetActive(self.UIContainer, not isOpenBuyPanel)
    CfUtils.SetActive(self.LeftTabToggle, not isOpenBuyPanel)
    CfUtils.SetActive(self.BuyPassPanel, isOpenBuyPanel)

    -- 如果以 显示购买界面 的方式打开该界面，那么关闭购买界面后，需要进行页签初始化
    local initParams = self.controller.Argument.parameters
    if not isOpenBuyPanel and initParams.selectTabIndex then
        self.viewTabEnv_:FillToggles(self.viewTabDatas_, initParams.selectTabIndex, nil, true)
        initParams.selectTabIndex = nil
    end

    if isOpenBuyPanel then
        self.buyPassPanelEnv_:DoShow()
    end
end


function BattlePassEntryDialog:UpdateSelectViewType_()
    local currentTabIndex  = self:GetSelectTabIndex()
    local currentTabData   = checkTable(self.viewTabDatas_[currentTabIndex])
    local currentViewType  = checkInt(currentTabData.tabType)
    local currentPanelData = self.viewPanelMap_[currentViewType]
    local currentPanelEnv  = currentPanelData.src
    
    if self:IsInitedViewState(currentViewType) then
    else
        -- mark view init
        self:SetInitedViewState(currentViewType)

        -- 排期变化后，需要首次打开优先打脸购买
        local oldPassCardStartTime = checkInt(CfUtils.GetLocalData(Constants.PlayerPrefsType.PassCardScheduleStartTime, '0'))
        local newPassCardStartTime = passCardComp:GetHomeDojo().startTime
        if newPassCardStartTime ~= oldPassCardStartTime then
            CfUtils.WriteLocalData(Constants.PlayerPrefsType.PassCardScheduleStartTime, newPassCardStartTime)
            self:SetOpenBuyPanel(true)
        end

        -- view to show
        local initParams = self.controller.Argument.parameters
        currentPanelEnv:OnOpen(initParams)
        CfUtils.SetActive(currentPanelData.go, true)
    end
end


---@param newTypeTabIndex integer
---@param oldTypeTabIndex integer
function BattlePassEntryDialog:SwitchViewTypePanel_(newTypeTabIndex, oldTypeTabIndex)
    local oldTypeTabData = checkTable(self.viewTabDatas_[oldTypeTabIndex])
    local newTypeTabData = checkTable(self.viewTabDatas_[newTypeTabIndex])
    local oldViewTabType = checkInt(oldTypeTabData.tabType)
    local newViewTabType = checkInt(newTypeTabData.tabType)

    -- check data state
    if not self:IsInitedDataState(newViewTabType) then
        if newTypeTabData.requestFunc then
            newTypeTabData.requestFunc(function()

                -- mark data init
                self:SetInitedDataState(newViewTabType)

                -- 如果加载完成后，当前所选类型未发生变化
                if self:GetSelectTabIndex() == newTypeTabIndex then
                    -- 如果加载好了，则立刻刷新
                    local newViewPanelData = self.viewPanelMap_[self:GetSelectTabIndex()]
                    if newViewPanelData and newViewPanelData.go then
                        self:UpdateSelectViewType_()
                    end
                end
            end)
        else
            self:SetInitedDataState(newViewTabType)
        end
    end

    -- hide old panel
    local oldViewPanelData = self.viewPanelMap_[oldViewTabType]
    if isNotNull(oldViewPanelData) then
        CfUtils.SetCanvasEnabled(oldViewPanelData.go, false)
    end
    
    -- check view loaded
    local newViewPanelData = self.viewPanelMap_[newViewTabType]
    if newViewPanelData and newViewPanelData.go then

        -- show new panel
        CfUtils.SetCanvasEnabled(newViewPanelData.go, true)
        
        -- update new panel
        self:UpdateSelectViewType_()
        
    else
        -- create new panel
        self:CreateViewTypePanel_(newTypeTabIndex)
    end
end


---@param typeTabIndex integer
function BattlePassEntryDialog:CreateViewTypePanel_(typeTabIndex)
    self.createNodeCo_ = CoStart(function()
        local typeTabData = checkTable(self.viewTabDatas_[typeTabIndex])
        local createType  = checkInt(typeTabData.tabType)
        local prefabePath = typeTabData.prefabe
        local luaEnvPath  = typeTabData.srcPath
        if not prefabePath then return end

        local panelNodeGo  = GameUtils.LoadBundleAsync(prefabePath, self.UIContainer.gameObject, false)
        local panelNodeEnv = CfUtils.GetLuaScr(panelNodeGo, luaEnvPath)
        self.viewPanelMap_[createType] = {go = panelNodeGo, src = panelNodeEnv}

        -- 如果加载完成后，当前所选类型已经发生变化
        if self:GetSelectTabIndex() ~= typeTabIndex then

            -- 先隐藏加载好的界面
            CfUtils.SetActive(panelNodeGo, false)

            -- 切换到当前最新选择
            self:SwitchViewTypePanel_(self:GetSelectTabIndex())
            
        else
            if self:IsInitedDataState(createType) then
                -- 数据加载好了：直接刷新
                self:UpdateSelectViewType_()

            else
                -- 数据没加载好：先隐藏视图
                CfUtils.SetActive(panelNodeGo, false)
            end
        end

        self.createNodeCo_ = nil
    end)
end


-------------------------------------------------
-- handler

function BattlePassEntryDialog:OnBuyDialogEventHandler_(isShow)
    self:SetOpenBuyPanel(isShow)
end


---@param typeTabData table
---@param typeTabIndex integer
function BattlePassEntryDialog:OnClickViewTypeTabHandler_(typeTabData, typeTabIndex)
    local oldTypeTabIndex = self:GetSelectTabIndex()
    local newTypeTabIndex = checkInt(typeTabIndex)
    if oldTypeTabIndex == newTypeTabIndex then
        return
    end

    -- save select index
    self:SetSelectTabIndex(newTypeTabIndex)

    -- 没有正在加载的prefab，才切换
    if not self.createNodeCo_ then
        self:SwitchViewTypePanel_(newTypeTabIndex, oldTypeTabIndex)
    end
end


return BattlePassEntryDialog
