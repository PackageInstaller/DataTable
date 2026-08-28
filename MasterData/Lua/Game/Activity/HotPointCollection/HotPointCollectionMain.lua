
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
local checkString = checkString
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type HotPointCollectionConstants
local HotPointCollectionConstants = import("Game.Activity.HotPointCollection.HotPointCollectionConstants")
---@type HotPointCollectionComponent
local component       = GameUtils.GetEntityCompByType(ECSComponentType.Constants.HotPointCollectionComponent)
local SubPrefabLoader = import(HotPointCollectionConstants.EnvPath.SubPrefabLoader)
local cs_coroutine     = require "XLua.cs_coroutine"
--endregion

--region define



--endregion

--- from: Assets/BundleResources/Prefabs/Hotpoint/HotpointMain.prefab > name: HotpointMain
---@class HotPointCollectionMain
---@field Env                           	HotPointCollectionMain                  
---@field controller                    	Engine.UI.UILuaDialog                   
---@field LabelBtnGroup                 	UnityEngine.RectTransform               
---@field BtnClose                      	UnityEngine.RectTransform               
---@field EmptyClose                    	UnityEngine.RectTransform               
---@field TxtTitle2                     	UnityEngine.UI.Text                     
---@field TxtTitle1                     	UnityEngine.UI.Text                     
---@field Content                       	UnityEngine.RectTransform               
local HotPointCollectionMain = Class('HotPointCollectionMain')


function HotPointCollectionMain:__init()
    self._selectViewType    = nil
    self._prefabType2Env    = {}
    self._prefabType2Canvas = {}
    self._prefabType2Status = {}
end


function HotPointCollectionMain:__delete()
    self.controller = nil
end


-- function HotPointCollectionMain:Start()
    
-- end


-- function HotPointCollectionMain:OnFocus(focus)

-- end


function HotPointCollectionMain:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        -- if not self.UIEffectCaptured.isCaptured then
        --     self.UIEffectCaptured:Capture()
        -- end
        if not string.isEmpty(self.controller.Argument.extra) then
            self._selectViewType = checkNumber(self.controller.Argument.extra)
        end
        local RootTrans = self.controller.transform:Find("Root")
        if isNotNull(RootTrans) then
            CfUtils.SetActive(RootTrans.gameObject, false)
        end
        self._initCo = CoStart(function() 
            self:OnInit()
            component:Request()
            Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, true)
            local CoYield = CoYield
            while component:GetRequesting() do
                CoYield()
            end
            
            self:InitUI()
            local co = self:SwitchTabSelectStatus(self._selectViewType == nil and HotPointCollectionConstants.ViewType.NewCard or self._selectViewType)
            cs_coroutine.yield_return(co)
            
            if isNotNull(RootTrans) then
                CfUtils.SetActive(RootTrans.gameObject, true)
            end
            
            self._initCo = nil
        end)
        
    end))
    return coWait
end


-- function HotPointCollectionMain:OnShow()
--     ---@type Engine.Lib.CoWait
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        
--     end))
--     return coWait
-- end


function HotPointCollectionMain:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if self._initCo then
            CoStop(self._initCo)
            self._initCo = nil
        end
        CfUtils.ConditionRemove("HotPointCollectionMain.PrefabLoad")
        CfUtils.ConditionRemove("HotPointCollectionMain.SwitchTab")
        --- 释放 texture
        component:ReleaseTexturePool()
        self:SaveParameters()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function HotPointCollectionMain:OnInit()
    self:InitData()
    self:InitAction()

end

function HotPointCollectionMain:InitData()
    self._prefabType2Loader = {}
    local parent = self.Content
    for index, prefabType in pairs(HotPointCollectionConstants.PrefabType) do
        local path   = HotPointCollectionConstants.PrefabType2PrefabPath[prefabType]
        local loader = SubPrefabLoader.New(path, parent, function (go)
            local canvas = CfUtils.GetOrAddComponent(go, typeof(CS.UnityEngine.Canvas))
            CfUtils.GetOrAddComponent(go, typeof(CS.UnityEngine.UI.GraphicRaycaster))
            self._prefabType2Canvas[prefabType] = canvas
            
            --- prefab创建好 检查当前选择的界面是否这个prefab 
            local selectViewType = self._selectViewType
            local config          = HotPointCollectionConstants.ViewType2Config[selectViewType]
            local isShow         = config.prefabType == prefabType
            local luaPath        = config.luaPath
            local env            = CfUtils.GetLuaScr(go, luaPath)
            if isNotNull(env) and env.OnInit then
                local parameters = self.controller.Argument.parameters
                local params = parameters.prefabParams ~= nil and parameters.prefabParams[prefabType] or nil
                env:OnInit(params)
            end
            self._prefabType2Env[prefabType] = env
            if isShow then
                local co = self:SwitchSubView()
                if co then
                    CfUtils.ConditionAppend("HotPointCollectionMain.PrefabLoad")
                    cs_coroutine.start(function ()
                        cs_coroutine.yield_return(co)
                        CfUtils.SetActive(go, isShow)
                        CfUtils.ConditionRemove("HotPointCollectionMain.PrefabLoad")
                    end)
                end
            else
                CfUtils.SetActive(go, isShow)
            end

        end)
        self._prefabType2Loader[prefabType] = loader
    end

end

function HotPointCollectionMain:InitUI()
    local ViewType2Data = {
        [HotPointCollectionConstants.ViewType.NewCard] = component:GetCardInfo(),
        [HotPointCollectionConstants.ViewType.NewActivity] = component:GetActivityList(),
        [HotPointCollectionConstants.ViewType.NewFunction] = component:GetModuleList(),
        [HotPointCollectionConstants.ViewType.NewSkin] = component:GetSkinInfo(),
    }

    local tabComponents = {}
    local parent        = self.LabelBtnGroup
    local viewType_ = 999
    for viewType, data in pairs(ViewType2Data) do
        local isSHow = data and next(data) ~= nil
        local child  = parent:Find(string.format("BtnTag%s", viewType))
        CfUtils.SetActive(child, isSHow)
        if isSHow then
            SetButtonAction(child, function()
                if self._selectViewType == viewType then
                    return
                end
                self:SwitchTabSelectStatus(viewType)
            end)
            
            local ImgBg  = child:Find("ImgBg")
            local Text   = child:Find("Text")
            tabComponents[viewType] = {ImgBg, Text}

            viewType_ = math.min(viewType_, viewType)
            -- table.insert(tabComponents, {ImgBg, Text})
        end
    end
    
    if self._selectViewType == nil then
        self._selectViewType = viewType_
    end
    self._tabComponents = tabComponents

    ---@type HotPointCollectionDojo
    local dojo = component:GetDojo()
    self.TxtTitle1.text = checkString(dojo.title)
    self.TxtTitle2.text = checkString(dojo.subtitle)
end

function HotPointCollectionMain:InitAction()
    SetButtonAction(self.BtnClose,   Bind(self, self.OnClickBtnCloseAction))
    SetButtonAction(self.EmptyClose, Bind(self, self.OnClickBtnCloseAction))
    
end

--endregion 


--region logic 

function HotPointCollectionMain:SwitchTabSelectStatus(newViewType)
    local viewType       = self._selectViewType
    self._selectViewType = newViewType
    if viewType then
        self.controller:SetExtraArgument(tostring(self._selectViewType))
        self:FreshTabSelectStatus(viewType,  1)
    end
    self:FreshTabSelectStatus(newViewType,  2)   

    local isFinished, loader = self:LoadSubView()
    local co
    if isFinished then
        self:SwitchSubView()
    else
        CfUtils.ConditionAppend("HotPointCollectionMain.SwitchTab")
        co = cs_coroutine.start(function ()
            local yield_return = cs_coroutine.yield_return
            while not isFinished do
                yield_return()
                isFinished = loader:IsFinished()
            end
            CfUtils.ConditionRemove("HotPointCollectionMain.SwitchTab")
            local tempCo = self:SwitchSubView()
            if tempCo then
                yield_return(tempCo)
            end
            -- print()
        end)
    end
    return co

end
function HotPointCollectionMain:FreshTabSelectStatus(viewType, status)
    local components = self._tabComponents[viewType]
    CfUtils.SetUISwitchImage(components[1], status)
    CfUtils.SetUISwitchImage(components[2], status)

end

---LoadSubView
---@return boolean 是否加载完成
function HotPointCollectionMain:LoadSubView()
    local viewType   = self._selectViewType
    ---@type SubPrefabLoader
    local loader     = self:GetLoaderByPrefabType(viewType)
    return loader:GetInstance(), loader
    
end

function HotPointCollectionMain:SwitchSubView()
    local prefabType = self:GetPrefabTypeByViewType(self._selectViewType)
    for prefabType_, canvas in pairs(self._prefabType2Canvas) do
        if isNotNull(canvas) then
            local enabled = prefabType_ == prefabType
            canvas.enabled = enabled
            local env = self._prefabType2Env[prefabType_]
            if env and env.SetEnabled then
                env:SetEnabled(enabled)
            end
        end 
    end

    return self:FreshSubView(prefabType)
    
end

function HotPointCollectionMain:FreshSubView(prefabType)
    local env = self._prefabType2Env[prefabType]
    if isNull(env) then
        return
    end
    return env:FreshUI(self._selectViewType)

end

function HotPointCollectionMain:SaveParameters()
    local parameters = self.controller.Argument.parameters
    for key, value in pairs(self._prefabType2Env) do
        if value.SaveParameters then
            parameters.prefabParams = parameters.prefabParams or {}
            parameters.prefabParams[key] = value:SaveParameters()
        end
    end
end

--endregion 


--region get/set 

function HotPointCollectionMain:GetPrefabTypeByViewType(viewType)
    local config      = HotPointCollectionConstants.ViewType2Config[viewType]
    local prefabType = config.prefabType
    return prefabType
end

function HotPointCollectionMain:GetLoaderByPrefabType(viewType)
    local prefabType = self:GetPrefabTypeByViewType(viewType)
    ---@type SubPrefabLoader
    local loader     = self._prefabType2Loader[prefabType]
    return loader
end

---endregion 


--region handler 

function HotPointCollectionMain:OnClickBtnCloseAction()
    CfUtils.DialogBack()
end

---endregion 


return HotPointCollectionMain
