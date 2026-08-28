------------ import ------------
local util               = require 'XLua.util'
local KTool              = CS.Engine.Lib.KTool
local CoWait             = CS.Engine.Lib.CoWait
local KCookie            = CS.Engine.Lib.KCookie
local UIModule           = CS.Engine.UI.UIModule
-- local Screen             = CS.UnityEngine.Screen
-- local Camera             = CS.UnityEngine.Camera

local cs_coroutine       = require 'XLua.cs_coroutine'
---@type CardProgressionConstants
local CardProgressionConstants  = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils      = import("Game.CardProgression.CardProgressionUtils")
------------ import ------------

---@class CardProgressionEntry
---@field Root                          	UnityEngine.RectTransform               
local CardProgressionEntry = Class("CardProgressionEntry")

------------ define ------------

local isNull               = isNull

local PerspectivePanelPath = CardProgressionConstants.EnvPath.CardProgressionEntryPanel

------------ define ------------

function CardProgressionEntry:__init()
    self.isClearEntryState = true
    self.isInitTrans = true
end


function CardProgressionEntry:__delete()
    self.controller = nil
    self = nil
end


function CardProgressionEntry:Awake()
end

function CardProgressionEntry:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        xTry(function ()
            -- self.controller.IsAutoHandleNavBar = false
            --- 显示养成场景
            Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShowCultivate = true})
            Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusGrowSceneEventName, true)
            Events.Broadcast(Constants.EventNames.FightChooseCardsDialogAct, { isTrue = false })
            KTool.SetRenderFeatureActiveByName(Constants.RenderFeatureNames.BLUR, false)
            cs_coroutine.yield_return()
            self:InitPerspectivePanel()
            self:InitData()
            self:InitAction()
            
            
        end)
    end))
    return coWait
end

function CardProgressionEntry:OnFocus(focus)
    if focus then
        -- GameUtils.UpdateUIShowState(self.go.gameObject, focus)
        GameUtils.SetUICameraProjection(false)
        CfUtils.SetTopCommonCb(Bind(self, self.OnClickBackAction))
    else
        --if self.isClearEntryState then
        --    GameUtils.SetUICameraProjection(true)
        --end
        CfUtils.ResetNavigatorCustomBackAction()

    end
end


function CardProgressionEntry:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        -- self.controller:FreshNavigator()
        self:InitPerspectivePanelTrans()
        self:InitView()

    end))
    return coWait
end

function CardProgressionEntry:OnHide()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if self.__EventUIScreenDialogsShowState then
            Events.RemoveListener(Constants.EventNames.UIScreenDialogsShowState, self.__EventUIScreenDialogsShowState)
        end
        GameUtils.UpdateUIShowState(self.go.gameObject, false)
        if not isNull(self.go) then
            KTool.SafeDelete(self.go)
            self.go = nil
        end
        
    end))
    return coWait
end

function CardProgressionEntry:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        GameUtils.SetRedPointNum(Constants.RedPointConst.StrengthenList, CardProgressionUtils.GetCultivateListRedPoint())
        
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end))
    return coWait
end


---------------------------------------------------
--- init begin --
---------------------------------------------------


function CardProgressionEntry:InitPerspectivePanel()
    local go = GameUtils.LoadBundleAsync(CardProgressionConstants.PrefabPath.CardProgressionEntryPanel)
    if isNull(go) then return end
    self.go = go

    ---@type CardProgressionEntryPanel
    local env = CfUtils.GetLuaScr(go, PerspectivePanelPath)
    if isNull(env) then return end
    env:SetRootGo(self.Root.gameObject)
    env:SetEnterCallback(function ()
        self.isClearEntryState = false
    end)
    self.perspectivePanelEnv = env

    KTool.SetActive(go, false)
end

function CardProgressionEntry:InitPerspectivePanelTrans()
    if not self.isInitTrans then return end
    self.isInitTrans = false
    local go = self.go
    KTool.SetActive(go, true)
    local transform = go.transform
    local mirrorTrans = self.Root.transform:Find("Mirror")
    local rt = mirrorTrans:rectTransform()
    transform.position = rt.position
    transform.localScale    = UIModule.RootCanvas.transform.localScale
    transform.sizeDelta     = Vector2.New(rt.rect.width, rt.rect.height)

end

function CardProgressionEntry:InitData()
    local parameters    = self.controller.Argument.parameters
    if not isNull(parameters) then
        self._isFromHome    = parameters.isFromHome
        parameters.isFromHome = nil
    end
end

function CardProgressionEntry:InitAction()
    self.__EventUIScreenDialogsShowState = Events.AddListener(Constants.EventNames.UIScreenDialogsShowState, Bind(self, self.OnEventUIScreenDialogsShowState))
end


function CardProgressionEntry:InitView()
    if isNull(self.perspectivePanelEnv) then return end
    self.perspectivePanelEnv:InitView(self._isFromHome)

end

---------------------------------------------------
--- init end --
---------------------------------------------------

---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

---------------------------------------------------
--- ui logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin --
---------------------------------------------------


---------------------------------------------------
--- get/set end --
---------------------------------------------------


---------------------------------------------------
--- handler begin --
---------------------------------------------------


function CardProgressionEntry:OnClickBackAction()
    KTool.SetActive(self.go, false)
    
    --Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShowCultivate = false})
    UIModule.BackDialog()
    
end

function CardProgressionEntry:OnEventUIScreenDialogsShowState(isShowScreenNode)
    GameUtils.UpdateUIShowState(self.go, not isShowScreenNode)
    if not isShowScreenNode then
        self.controller:FreshNavigator()
    end
end
   

---------------------------------------------------
--- handler end --
---------------------------------------------------

return CardProgressionEntry
