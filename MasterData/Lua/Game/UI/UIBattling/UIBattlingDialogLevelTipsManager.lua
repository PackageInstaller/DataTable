local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local UIBattlingCtrlMgr = import("Game.UI.UIBattling.UIBattlingCtrlMgr")

-- 提示类型
local TipsType = {
    LevelTips = 1,      -- 关卡提示
    WeatherTips = 2,    -- 天气提示
    ConditionTips = 3,  -- 三星提示
}

-- 托管类型
local ManagerType = {
    Self = 1,           -- 在这里管理
    Other = 2,          -- 其他脚本管理
}

-- 展示优先级
local Prority = {
    TipsType.ConditionTips,
    TipsType.LevelTips,
    TipsType.WeatherTips,
}

---@class TipsBtn
---按钮数据对象
local TipsBtn = {}
function TipsBtn.New()
    ---@type TipsBtn
    local this = {}
    -- setmetatable(this, { __index = TipsBtn })
    this.type = 0
    this.managerType = 1
    this.btnLT = nil
    this.btnTF = nil
    this.btnShowState = false   -- 按钮的显示和隐藏
    this.panelShowState = false -- 弹窗的显示和隐藏
    this.hasTips = nil          -- 是否有提示
    this.getTipsDesc = nil      -- 获取提示描述
    this.showPanel = nil        -- 显示弹窗
    this.hidePanel = nil        -- 隐藏弹窗
    this.showBtn = nil          -- 显示按钮
    this.hideBtn = nil          -- 隐藏按钮
    this.canAutoShow = nil      -- 是否自动显示
    return this
end

---@class UIBattlingDialogLevelTipsManager
local UIBattlingDialogLevelTipsManager = {}


function UIBattlingDialogLevelTipsManager:CleanProperties()
    self.tipsBtnPrefab = nil
    self.tipsBtnParent = nil
    self.siblingIndex = nil

    self.tipsBtnList = nil          -- 关卡提示类型的按钮们
end

function UIBattlingDialogLevelTipsManager:Init(prefab, parent)
    self:CleanProperties()

    self.tipsBtnPrefab = prefab.gameObject
    self.tipsBtnParent = parent

    self.siblingIndex = prefab.transform:GetSiblingIndex()

    self:InitTipsBtn()
    self:AddOtherTipsBtn()
end

function UIBattlingDialogLevelTipsManager:Clear()
    self:RemoveListener()
    self:CleanProperties()
end

function UIBattlingDialogLevelTipsManager:InitListener()
    self.eventOnShowBattleLevelTips = Events.AddListener(Constants.EventNames.BattleShowLevelTips, Bind(self, self.OnShowLevelTips))
end

function UIBattlingDialogLevelTipsManager:RemoveListener()
    Events.RemoveListener(Constants.EventNames.BattleShowLevelTips, self.eventOnShowBattleLevelTips)
end

--- 初始化所有按钮
function UIBattlingDialogLevelTipsManager:InitTipsBtn()
    self.tipsBtnList = {}

    --- 关卡提示按钮
    local tipsBtnRoot = self.tipsBtnPrefab
    local tipsBtn = tipsBtnRoot.transform:Find("TipsBtn")
    local tipsBtnLT = GetLuaBehaviour(tipsBtn.gameObject, Constants.UIBattlingLuaTablePath.UIBattlingBtnNode).Env
    tipsBtnLT:OnToggleClicked(false)
    
    local refreshTipBtnIcon = function(waveNum)
        local tipId = UIBattlingDataMgr:GetBattleTipsValue(UIBattlingDataMgr.questId, waveNum)
        local iconType = UIBattlingDataMgr:GetBattleTipsIconType(tipId)
        local iconPath = UIBattlingDataMgr:GetBattleTipsIconPath(iconType)
        tipsBtnLT:SetIconSize(iconType == 0 and Vector2.New(80,80) or Vector2.New(115,88))
        tipsBtnLT:SetBtnIcon(iconPath) -- 刷新提示icon
        tipsBtnLT:SetIconUseSwitch(iconType == 0)
    end

    -- 看第一波有没有提示，有的话显示按钮并刷新icon
    local tipId = UIBattlingDataMgr:GetBattleTipsValue(UIBattlingDataMgr.questId, 1)
    local showDialog = tipId > 0
    if showDialog then
        refreshTipBtnIcon(1)
    end
    KTool.SetActive(tipsBtnRoot, showDialog)

    -- 构造关卡提示按钮的数据结构
    ---@type TipsBtn
    local tipsBtn = TipsBtn.New()
    tipsBtn.type = TipsType.LevelTips
    tipsBtn.managerType = 1
    tipsBtn.btnLT = tipsBtnLT
    tipsBtn.btnTF = tipsBtnRoot.transform
    tipsBtn.btnShowState = showDialog
    tipsBtn.panelShowState = false
    tipsBtn.hasTips = function(waveNum)
        local tipId = UIBattlingDataMgr:GetBattleTipsValue(UIBattlingDataMgr.questId, waveNum)
        local showDialog = tipId > 0
        return showDialog
    end
    tipsBtn.getTipsDesc = function()
        return UIBattlingCtrlMgr:GetInstance():GetQuestWaveTips(UIBattlingDataMgr.questId)
    end
    tipsBtn.showPanel = function()
        self:SetLevelTipsDialogShowState(true, tipsBtn)
    end
    tipsBtn.hidePanel = function()
        self:SetLevelTipsDialogShowState(false, tipsBtn)
    end
    tipsBtn.showBtn = function(waveNum)
        refreshTipBtnIcon(waveNum)
        tipsBtn.btnShowState = true
        KTool.SetActive(tipsBtn.btnTF, true)
    end
    tipsBtn.hideBtn = function()
        tipsBtn.btnShowState = false
        KTool.SetActive(tipsBtn.btnTF, false)
    end
    tipsBtn.canAutoShow = function(waveNum)
        local tipId = UIBattlingDataMgr:GetBattleTipsValue(UIBattlingDataMgr.questId, waveNum)
        local showDialog = UIBattlingDataMgr:GetBattleTipsShowState(tipId) > 0
        return showDialog
    end
    table.insert(self.tipsBtnList, tipsBtn)

    -- 天气提示按钮
    if UIBattlingDataMgr:HasWeatherTips() then
        local weatherTipsBtnGo = KTool.Instantiate(self.tipsBtnParent.gameObject, self.tipsBtnPrefab.gameObject)
        weatherTipsBtnGo.name = "WeatherTipsBtnRoot"
        local tipsBtn = weatherTipsBtnGo.transform:Find("TipsBtn")
        local tipsBtnLT = GetLuaBehaviour(tipsBtn.gameObject, Constants.UIBattlingLuaTablePath.UIBattlingBtnNode).Env
        tipsBtnLT:OnToggleClicked(false)
        local iconPath = UIBattlingDataMgr:GetWeatherTipsIconPath()
        tipsBtnLT:SetBtnIcon(iconPath)
        tipsBtnLT:SetIconUseSwitch(true)
        tipsBtnLT:SetIconSize(Vector2.New(66,66))
        KTool.SetActive(weatherTipsBtnGo, true)
        weatherTipsBtnGo.transform:SetSiblingIndex(self.siblingIndex + 1)

        -- 天气提示按钮的数据结构
        ---@type TipsBtn
        local tipsBtn = TipsBtn.New()
        tipsBtn.type = TipsType.WeatherTips
        tipsBtn.btnLT = tipsBtnLT
        tipsBtn.btnTF = weatherTipsBtnGo.transform
        tipsBtn.btnShowState = true
        tipsBtn.panelShowState = false
        tipsBtn.hasTips = function(waveNum)
            return UIBattlingDataMgr:HasWeatherTips()
        end
        tipsBtn.getTipsDesc = function()
            return UIBattlingDataMgr:GetWeatherTipsDesc()
        end
        tipsBtn.showPanel = function()
            self:SetLevelTipsDialogShowState(true, tipsBtn)
        end
        tipsBtn.hidePanel = function()
            self:SetLevelTipsDialogShowState(false, tipsBtn)
        end
        tipsBtn.showBtn = function(waveNum)
            tipsBtn.btnShowState = true
            KTool.SetActive(tipsBtn.btnTF, true)
        end
        tipsBtn.hideBtn = function()
            tipsBtn.btnShowState = false
            KTool.SetActive(tipsBtn.btnTF, false)
        end
        tipsBtn.canAutoShow = function(waveNum)
            local tipId = UIBattlingDataMgr:GetWeatherTipsId()
            local showDialog = UIBattlingDataMgr:GetBattleTipsShowState(tipId) > 0
            return showDialog and (waveNum == 1)
        end
        table.insert(self.tipsBtnList, tipsBtn)
    end

    -- 设置关卡提示按钮的点击事件
    for i, data in ipairs(self.tipsBtnList) do
        SetButtonAction(data.btnLT:ButtonComponent(), function()
            local isOpen = data.panelShowState
            if not isOpen then
                Events.Broadcast(Constants.EventNames.BattleShowLevelTips, data.type)
            end
            self:SetLevelTipsDialogShowState(not isOpen, data)
        end)
    end
end

--- 设置关卡提示的开关
---@param state any
function UIBattlingDialogLevelTipsManager:SetLevelTipsDialogShowState(state, tipsBtn)
    local dialog = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.UIBattlingLevelTipsDialog)
    if isNotNull(dialog) then
        if state then
            UIBattlingTools.PlayAudio(UISheets.UI_Menu.ui_menu_click, UISheets.UI_Menu.path)
            local strTips = tipsBtn.getTipsDesc()
            local position = tipsBtn.btnTF.anchoredPosition
            dialog.Env:Refresh(strTips, position)
        end
        tipsBtn.btnLT:OnToggleClicked(state)
        KTool.SetActive(dialog, state)
    else
        if state then
            UIBattlingTools.PlayAudio(UISheets.UI_Menu.ui_menu_click, UISheets.UI_Menu.path)
            local strTips = tipsBtn.getTipsDesc()
            local position = tipsBtn.btnTF.anchoredPosition
            UIModule.OpenDialog({ id = Constants.UITypeIds.UIBattlingLevelTipsDialog, parameters = { strTips = strTips, position = position } })
        end
        tipsBtn.btnLT:OnToggleClicked(state)
    end
    tipsBtn.panelShowState = state
end

function UIBattlingDialogLevelTipsManager:AddOtherTipsBtn()
    self.tipsBtnList = checkTable(self.tipsBtnList)

    -- 三星提示
    local dialog = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.UIBattlingDialog)
    local btnTF, btnLT
    if isNotNull(dialog) and isNotNull(dialog.Env) then
        btnLT = dialog.Env:LoadTrainingTargetPanel()
        btnTF = btnLT.controller.gameObject.transform.parent
    end
    local listCondition = BattlingCombatLevelMgr:GetQuestMissionData(UIBattlingDataMgr.questId, 1)
    local showCondition = listCondition and #listCondition > 0
    KTool.SetActive(btnTF, showCondition)
    ---@type TipsBtn
    local tipsBtn = TipsBtn.New()
    tipsBtn.type = TipsType.ConditionTips
    tipsBtn.managerType = ManagerType.Other
    tipsBtn.btnLT = btnLT
    tipsBtn.btnTF = btnTF
    tipsBtn.btnShowState = showCondition
    tipsBtn.panelShowState = false
    tipsBtn.hasTips = function(waveNum)
        local listCondition = BattlingCombatLevelMgr:GetQuestMissionData(UIBattlingDataMgr.questId, waveNum)
        return listCondition and #listCondition > 0
    end
    tipsBtn.showPanel = function()
        tipsBtn.panelShowState = true
        if isNotNull(tipsBtn.btnLT) then
            tipsBtn.btnLT:ShowConditionDesc()
        end
    end
    tipsBtn.hidePanel = function()
        tipsBtn.panelShowState = false
        if isNotNull(tipsBtn.btnLT) then
            tipsBtn.btnLT:SetShowState(false)
        end
    end
    tipsBtn.showBtn = function(waveNum)
        tipsBtn.btnShowState = true
        KTool.SetActive(tipsBtn.btnTF, true)
    end
    tipsBtn.hideBtn = function()
        tipsBtn.btnShowState = false
        KTool.SetActive(tipsBtn.btnTF, false)
    end
    tipsBtn.canAutoShow = function()
        return true
    end
    table.insert(self.tipsBtnList, tipsBtn)
end

--- 自动显示，按优先级找到第一个
function UIBattlingDialogLevelTipsManager:AutoShowTips(waveNum)
    -- 有提示的把按钮都打开
    for i, tipsBtn in ipairs(self.tipsBtnList) do
        if tipsBtn.hasTips(waveNum) then
            -- 显示btn
            tipsBtn.showBtn(waveNum)
        end
    end
    -- 自动打开优先级最高的一个panel
    for i, type in ipairs(Prority) do
        for i, tipsBtn in ipairs(self.tipsBtnList) do
            if tipsBtn.type == type 
            and tipsBtn.hasTips(waveNum)
            and tipsBtn.canAutoShow(waveNum) then
                Events.Broadcast(Constants.EventNames.BattleShowLevelTips, tipsBtn.type)
                tipsBtn.showPanel()
                return
            end
        end
    end
end

--- 打开一个的时候，关闭其他的
---@param type any
function UIBattlingDialogLevelTipsManager:OnShowLevelTips(type)
    local waveNum = UIBattlingCtrlMgr:GetInstance():GetBattleWave(Constants.Camp.Two) -- 设置战局波次信息
    for i, tipsBtn in ipairs(self.tipsBtnList) do
        if tipsBtn.type ~= type then
            if tipsBtn.hasTips(waveNum) then
                -- 有提示显示
                tipsBtn.hidePanel()
            else
                -- 没提示直接把按钮隐藏
                tipsBtn.hideBtn()
            end
        end
    end
end

--- 关闭全部提示弹窗
function UIBattlingDialogLevelTipsManager:CloseAllTips()
    if isNull(self.tipsBtnList) then return end
    for i, tipsBtn in ipairs(self.tipsBtnList) do
        tipsBtn.hidePanel()
    end
end

return UIBattlingDialogLevelTipsManager