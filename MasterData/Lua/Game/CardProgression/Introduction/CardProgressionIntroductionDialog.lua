--- 养成-资料界面  羁绊+档案

------------ import ------------
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
------------ import ------------


------------ define ------------
local ViewType = CardProgressionConstants.IntroductionViewType

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaIllustratedHandbookAndFetter.prefab > name: CultivateOverseaIllustratedHandbookAndFetter
---@class CardProgressionIntroductionDialog
---@field Env                           	CardProgressionIntroductionDialog       
---@field controller                    	Engine.UI.UILuaDialog                   
---@field Fetter                        	UnityEngine.RectTransform               	@ 0    
---@field IllustratedHandbook           	UnityEngine.RectTransform               	@ 1    
---@field Feeling                       	UnityEngine.RectTransform               	@ 2    
---@field CommonTabToggleLeft           	UnityEngine.RectTransform               	@ 3    
local CardProgressionIntroduction = Class('CardProgressionIntroduction')


function CardProgressionIntroduction:__init()
    self._selectViewType = ViewType.Synergies
    self._selectViewIndex = 1
end


function CardProgressionIntroduction:__delete()
    self.controller = nil
end


function CardProgressionIntroduction:Awake()
end


function CardProgressionIntroduction:OnFocus(focus)
    if focus then
        -- ---@type CardProgressionControllerRole
        -- local controllerEnv = self._controllerEnv
        -- controllerEnv:FreshCameraState(CardProgressionConstants.CameraState.CultivateRoleFull, false)
    end


    local info          = self._viewType2Info[self._selectViewType]
    if info then
        local node, envPath = SafeUnpack(info)
        local env = CfUtils.GetLuaScr(node, envPath)
        if env.OnFocus then
            env:OnFocus(focus)
        end
    end
end


function CardProgressionIntroduction:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusGrowSceneEventName, true)
        Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShowCultivate = true})
        self:InitData()
        self:InitAction()
        self:InitTabToggle()
        
        CardProgressionUtils.RegRoleSwipeRegion(self.controller)
    end))
    return coWait
end

function CardProgressionIntroduction:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:FreshUI()
    end))
    return coWait
end

function CardProgressionIntroduction:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local parameters = self.controller.Argument.parameters
        parameters.viewType = self._selectViewType
        parameters.favorLevel = self._favorLevel
        CfUtils.EventsUndecorated(self._listeners)
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

function CardProgressionIntroduction:InitData()
    local parameters = self.controller.Argument.parameters
    local cardId     = parameters.cardId
    local playerCardId = parameters.playerCardId
    local favorLevel = parameters.favorLevel
    self._selectViewType = parameters.viewType or ViewType.Synergies 
    self._cardId     = cardId
    self._favorLevel = favorLevel
    self._playerCardId = playerCardId
    self._togglesData = self:InitToggleData()
    ---@type CardProgressionControllerRole
    local env = CardProgressionUtils.GetRoleControllerEnv()
    self._controllerEnv = env
    
    self._viewType2Info = {
        [ViewType.Synergies]   = {self.Fetter, CardProgressionConstants.EnvPath.CardProgressionSynergies},
        [ViewType.Illustrated] = {self.IllustratedHandbook, CardProgressionConstants.EnvPath.CardProgressionIllustrated},
    }
    if self._playerCardId then
        self._viewType2Info[ViewType.Favor] = {self.Feeling, CardProgressionConstants.EnvPath.CardProgressionFavor}
    end

end

function CardProgressionIntroduction:InitAction()
    self._listeners = CfUtils.EventsDecorated({
        [CardProgressionConstants.EventNames.FavorChange] = Bind(self, self.OnChangeFavor)
    })
end

function CardProgressionIntroduction:InitTabToggle()
    ---@type CommonTabToggleLeft
    local env = CfUtils.GetLuaScr(self.CommonTabToggleLeft, CardProgressionConstants.EnvPath.CommonTabToggleLeft)
    if isNull(env) then return end
    self._toggleLeftEnv = env
    
    env:FillToggles(self._togglesData, self._selectViewIndex, function (isSelected, index, curIndex, data, nodeEnv)
        local toggleData = self._togglesData[index]
        local num = toggleData.subType == ViewType.Favor and self._favorLevel or nil
        nodeEnv:FreshIconTxtNum(num, isSelected)
    end)
end


function CardProgressionIntroduction:InitToggleData()
    local t = {}
    if self._playerCardId then
        table.insert(t, { "UIAtlas/CultivateOversea/Main/cultivate_btn_favorability.png", localize("好感度"),  ViewType.Favor, Constants.SystemToggleIds.Id109})
    end
    table.insert(t, { "UIAtlas/CultivateOversea/Main/cultivate_btn_data.png",        localize("档案"),  ViewType.Illustrated, Constants.SystemToggleIds.Id110})
    table.insert(t, { "UIAtlas/CultivateOversea/Main/cultivate_icon_fetter.png", localize("羁绊"),  ViewType.Synergies, Constants.SystemToggleIds.Id111})
    
    local toggles = {}
    for i, conf in ipairs(t) do
        local icon, name, subType, systemToggleId = SafeUnpack(conf)

        local isLock      = not GameUtils.IsUnlockedBySystemTogId(systemToggleId)
        local toggleData = {
            text = name,
            iconPath = icon,
            textDefStatus    = isLock and 3 or 1,
            imgIconDefStatus = isLock and 3 or 1,
            lock = isLock == true and true or nil,
            subType = subType,
            func = function()
                if isLock then
                    local desc = GameUtils.GetUnlockDescrBySystemTogId(systemToggleId)
                    GameUtils.Toast(desc)
                    return 0
                end
                local info          = self._viewType2Info[self._selectViewType]
                if info then
                    local node = SafeUnpack(info)
                    KTool.SetActive(node.gameObject, false)
                end
                self:FreshToggleIconTxtNum(self._selectViewIndex, false)
                self:FreshToggleIconTxtNum(i, true)
                -- self:FreshToggleIconTxtNumByEnv(env, index, isSelected)
                self._selectViewIndex = i
                self._selectViewType = subType
                self:OnSelectTabChange()
            end
        }

        if self._selectViewType == subType then
            self._selectViewIndex = i
        end

        table.insert(toggles, toggleData)
    end
    return toggles

end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CardProgressionIntroduction:FreshUI()
    self:OnSelectTabChange()
end

function CardProgressionIntroduction:OnSelectTabChange()
    local info          = self._viewType2Info[self._selectViewType]
    if info == nil then
        return
    end
    local node, envPath = SafeUnpack(info)
    KTool.SetActive(node.gameObject, true)
    local env = CfUtils.GetLuaScr(node, envPath)
    if not isNull(env) then
        if env.SetFavorLv then
            env:SetFavorLv(self._favorLevel)
        end
        if ViewType.Favor == self._selectViewType then
            env:Fresh(self._playerCardId)
        else
            env:FreshUI(self._cardId)
        end
    end
end

function CardProgressionIntroduction:FreshToggleIconTxtNum(index, isSelected)
    if isNull(self._toggleLeftEnv) then
        return
    end
    local env = self._toggleLeftEnv:GetTogGoEnvByIndex(index - 1)
    self:FreshToggleIconTxtNumByEnv(env, index, isSelected)
end

function CardProgressionIntroduction:FreshToggleIconTxtNumByEnv(env, index, isSelected)
    local toggleData = self._togglesData[index]
    local num = toggleData.subType == ViewType.Favor and self._favorLevel or nil
    env:FreshIconTxtNum(num, isSelected)
end


---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionIntroduction:OnChangeFavor(favorLevel)
    self._favorLevel = favorLevel
    self:FreshToggleIconTxtNum(1, self._selectViewIndex == 1)
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionIntroduction
