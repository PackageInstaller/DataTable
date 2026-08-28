
------------ import ------------
---@type CardConfMgr
local cardConfMgr          = CardConfMgr:GetInstance()
local Utils                = CS.Engine.Tools.Utils
local UIModule             = CS.Engine.UI.UIModule
local KTool                = CS.Engine.Lib.KTool
local BehaviourAction      = CS.Engine.Lib.BehaviourAction
local RectTransformUtility = CS.UnityEngine.RectTransformUtility
------------ import ------------


------------ define ------------

local checkNumber = checkNumber


local FilterClass2TitleConfig = {
    [Constants.UIFilterType.EquipCultivateFastSelect] = {
        [1] = localize("选择哪些品质涂鸦"),
        [2] = localize("选择哪些部位"),
        [3] = localize("选择材料类型"),
        [4] = localize("选择哪些主属性"),
    },
    [Constants.UIFilterType.EquipReclaimFastSelect]   = {
        --[1] = localize("选择哪些部位"),
        [1] = localize("选择哪些品质涂鸦"),
        [2] = localize("选择哪些主属性"),
        [3] = localize("选择哪些升星属性品质"),
        [4] = localize("选择哪些升星属性"),
    },
}

local FilterClass2BtnStyle = {
    [Constants.UIFilterType.EquipCultivateFastSelect] = {"B7", localize("取消")},
    [Constants.UIFilterType.EquipReclaimFastSelect]   = {"B7", localize("重置")},
}

local PanelCellEnvPath = "Game.UI.Cultivate.Equip.UICultivateEquipUpgradeLevelSetListCell"

------------ define ------------

--- from: Assets/BundleResources/Prefabs/Cultivate/UICultivateEquipSettingPanel.prefab
---@class UICultivateEquipSettingPanel
---@field Env                           	UICultivateEquipSettingPanel                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field RightButton                   	Game.Native.Common.FontStyleButton      
---@field LeftButton                    	Game.Native.Common.FontStyleButton      
---@field BtnMax                        	UnityEngine.RectTransform               
---@field BtnAdd                        	UnityEngine.RectTransform               
---@field BtnReduce                     	UnityEngine.RectTransform               
---@field InputField                    	TMPro.TMP_InputField                    
---@field ChooseNumberNode              	UnityEngine.RectTransform               
---@field TargetLevel                   	UnityEngine.RectTransform               
---@field ListCell2                     	UnityEngine.RectTransform               
---@field ListCell1                     	UnityEngine.RectTransform               
---@field Panel                         	UnityEngine.RectTransform               
local UICultivateEquipSettingPanel = Class('UICultivateEquipSettingPanel')

function UICultivateEquipSettingPanel:__init()
    self.ListCells = {}
end

function UICultivateEquipSettingPanel:__delete()
    if self._behaviourAction then
        self._behaviourAction.UpdateAction = nil
        self._behaviourAction = nil
    end
end


function UICultivateEquipSettingPanel:Awake()
    KTool.SetActive(self.ListCell1.gameObject, false)
    KTool.SetActive(self.ListCell2.gameObject, false)
    local Layout = self.controller.transform:Find("Root/Layout")
    if Layout then
        self.Layout = KTool.GetComponent(Layout.gameObject, typeof(CS.UnityEngine.RectTransform))
    end
    local BottomButton = self.controller.transform:Find("Root/ButtomButton")
    if BottomButton then
        self.BottomButton = KTool.GetComponent(BottomButton.gameObject, typeof(CS.UnityEngine.RectTransform))
    end
end


function UICultivateEquipSettingPanel:Start()
    SetButtonAction(self.LeftButton,  Bind(self, self.OnClickLeftButton))
    SetButtonAction(self.RightButton, Bind(self, self.OnClickRightButton))
    

    local behaviourAction = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
    if behaviourAction then
        behaviourAction.UpdateAction = Bind(self, self.Update)
        self._behaviourAction = behaviourAction
    end
end


function UICultivateEquipSettingPanel:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


function UICultivateEquipSettingPanel:Update()
    if Utils.TouchCount() > 0 then
        local positionV = Utils.GetInputDownPos()
        local position = Vector2.New(positionV.x, positionV.y)
        if position ~= Vector2.zero then
            local isInRect = RectTransformUtility.RectangleContainsScreenPoint(self.Layout, position,
                    UIModule.RootCanvas.canvas.worldCamera) or RectTransformUtility.RectangleContainsScreenPoint(self.BottomButton, position,
                    UIModule.RootCanvas.canvas.worldCamera)
            if not isInRect then
                ---不在区域中
                self:CloseView()
            end
        end
    end
end

---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

function UICultivateEquipSettingPanel:FreshUI(filterClass, selectRule)
    self.filterClass = filterClass
    self.selectRule  = selectRule
    self:InitUIByFilterClass(filterClass)
    self:FreshBtnStyleByFilterClass(filterClass)
    self:FreshFilterCondition(filterClass, selectRule)
end

function UICultivateEquipSettingPanel:InitUIByFilterClass(filterClass)
    if filterClass == Constants.UIFilterType.EquipCultivateFastSelect then
        KTool.SetActive(self.TargetLevel.gameObject, true)
        SetButtonAction(self.BtnAdd,      Bind(self, self.OnClickBtnAddAction))
        SetButtonAction(self.BtnReduce,   Bind(self, self.OnClickBtnReduceAction))
        SetButtonAction(self.BtnMax,   Bind(self, self.OnClickBtnMaxAction))

        self.InputField.onEndEdit:AddListener(function(num)
            self:FreshTargetLevel(num)
        end)
    end
end

function UICultivateEquipSettingPanel:FreshBtnStyleByFilterClass(filterClass)
    local buttonStyle = FilterClass2BtnStyle[filterClass]
    if buttonStyle == nil then return end
    local leftStyle, leftTxt, rightStyle, rightTxt = SafeUnpack(buttonStyle)
    if leftStyle then
        self.LeftButton:ResetFontStyle(leftStyle, leftTxt)
    end

    if rightStyle then
        self.RightButton:ResetFontStyle(rightStyle, rightTxt)
    end
end

function UICultivateEquipSettingPanel:FreshFilterCondition(filterClass, selectRule)
    local screenList = cardConfMgr:GetAllScreenVo(filterClass)
    
    local TitleConf = FilterClass2TitleConfig[filterClass] or {}
    local count      = #screenList
    for i = count, 1, -1 do
        ---@type ScreenVo
        local screenVo = screenList[i]
        local cell     = self.ListCells[i]
        if cell == nil then
            local child = self:GetListCellByFilterClass(filterClass, screenVo)
            cell = self.Panel.gameObject:AddChild(child.gameObject)
            self.ListCells[i] = cell
            KTool.SetActive(cell.gameObject, true)
            cell.transform:SetAsFirstSibling()
        end
        self:FreshListCell(cell, screenVo, TitleConf[i], selectRule)
    end
end

function UICultivateEquipSettingPanel:GetListCellByFilterClass(filterClass, screenVo)
    local child
    if filterClass == Constants.UIFilterType.EquipCultivateFastSelect then
        child = screenVo.id == Constants.EquipCultivateFastSelectFilterType.Quality and self.ListCell1 or self.ListCell2  
    elseif filterClass == Constants.UIFilterType.EquipReclaimFastSelect then
        child = screenVo.id == Constants.EquipReclaimFilterType.Quality and self.ListCell1 or self.ListCell2  
    else
        child = self.ListCell2
    end

    return child
end

function UICultivateEquipSettingPanel:FreshListCell(go, screenVo, title, selectRule)
    ---@type UICultivateEquipUpgradeLevelSetListCell
    local env = CfUtils.GetLuaScr(go.gameObject, PanelCellEnvPath)
    if isNull(env) then return end
    env:RefreshUI(screenVo, title, selectRule)
end

------------ TargetLevel --------------

function UICultivateEquipSettingPanel:FreshMinAndMaxLv(minLevel, maxLevel)
    self.minLevel, self.maxLevel = checkNumber(minLevel), checkNumber(maxLevel)
    self:FreshTargetLevel(self.minLevel)
end

--- FreshTargetLevel
---@param level number
---@param maxLevel number
function UICultivateEquipSettingPanel:FreshTargetLevel(level)
    self.targetLevel = math.max(self.minLevel, math.min(self.maxLevel, checkNumber(level)))
    self.InputField.text = self.targetLevel

end

------------ TargetLevel --------------

function UICultivateEquipSettingPanel:CloseView()
    KTool.SetActive(self.controller.gameObject, false)
    
end

function UICultivateEquipSettingPanel:ResetUI()
    self.selectRule = {}
    self:FreshFilterCondition(self.filterClass, self.selectRule)
end

---------------------------------------------------
--- ui logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function UICultivateEquipSettingPanel:SetLeftBtnClickCallback(cb)
    self.leftBtnClickCallback = cb
end

function UICultivateEquipSettingPanel:SetRightBtnClickCallback(cb)
    self.rightBtnClickCallback = cb
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function UICultivateEquipSettingPanel:OnClickLeftButton()

    if self.leftBtnClickCallback then
        self.leftBtnClickCallback(self)
    end
    -- self.selectRule = {}
    -- self:FreshFilterCondition(self.filterClass, self.selectRule)
end

function UICultivateEquipSettingPanel:OnClickRightButton()
    self:CloseView()
    if self.rightBtnClickCallback then
        self.rightBtnClickCallback(self)
    end
end

------------ TargetLevel --------------

function UICultivateEquipSettingPanel:OnClickBtnAddAction()
    self:FreshTargetLevel(self.targetLevel + 1)

end

function UICultivateEquipSettingPanel:OnClickBtnReduceAction()
    self:FreshTargetLevel(self.targetLevel - 1)
    
end

function UICultivateEquipSettingPanel:OnClickBtnMaxAction()
    self:FreshTargetLevel(self.maxLevel)
end

------------ TargetLevel --------------

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return UICultivateEquipSettingPanel
