------------ import ------------
local util   = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
-- local KTool  = CS.Engine.Lib.KTool
local Animator = CS.UnityEngine.Animator
-- local cs_coroutine      = require 'XLua.cs_coroutine'
-- local Yielders = CS.Engine.Lib.Yielders
local UIModule = CS.Engine.UI.UIModule
local CriWareUtils        = import('Game.Entry.CriWareUtilsFix')

------------ import ------------

--- from: Assets/BundleResources/Prefabs/Common/CommonFunctionUnlockDialog.prefab > name: CommonFunctionUnlockDialog
---@class CommonFunctionUnlockDialog
---@field Env                           	CommonFunctionUnlockDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field FunctionCell                  	UnityEngine.RectTransform               
---@field ListView                      	UnityEngine.RectTransform               
---@field ClickClose                    	UnityEngine.RectTransform               
---@field Fuzzy                         	UGUI.Effects.UIEffectCapturedImage      
local CommonFunctionUnlockDialog = Class("CommonFunctionUnlockDialog")

------------ define ------------
local MBPath = "Game.UI.Cultivate.UICultivatePlayerUpgradeFunctionNode"
local DefaultNameHash = Animator.StringToHash("Default")
------------ define ------------

function CommonFunctionUnlockDialog:__init()
    self.unlockFunctionCells = {}
end


function CommonFunctionUnlockDialog:__delete()
    self.controller = nil
end


function CommonFunctionUnlockDialog:Awake()
    SetButtonAction(self.ClickClose, function ()
        if self.play then return end
        UIModule.CloseDialog(self.controller)
    end)
end


-- function CommonFunctionUnlockDialog:OnFocus(focus)

-- end


function CommonFunctionUnlockDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local argument   = self.controller.Argument
        local parameters = argument.parameters
        self.params      = parameters.params
        self:InitData()
        CriWareUtils.PlaySe(UISheets.SFX_TAKEOUT.path, UISheets.SFX_TAKEOUT.sfx_takeout_unlock)
    end))
    return coWait
end

function CommonFunctionUnlockDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        -- self.co = cs_coroutine.start(function()
        --     xTry(function()
        --         self.play = true
                self:ShowFunctionUnlock()
        --         ---1秒钟后再截图
        --         coroutine.yield(Yielders.GetWaitForSeconds(1))
        --         self.Fuzzy:Capture()
        --         self.play = false
        --     end)
        -- end)
    end))
    return coWait
end


function CommonFunctionUnlockDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end))
    return coWait
end


function CommonFunctionUnlockDialog:InitData()
    local argument   = self.controller.Argument
    local parameters = argument.parameters

    ---@type SystemGuideModuleStepVo
    local moduleStepVo = parameters.moduleStepVo
    local moduleId
    if moduleStepVo then
        moduleId = moduleStepVo.systemFunction
    elseif parameters.moduleId then
        moduleId = parameters.moduleId
    end
    self._moduleId = moduleId
    
end

---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

function CommonFunctionUnlockDialog:ShowFunctionUnlock()

    ---@type UICultivatePlayerUpgradeFunctionNode
    local env = CfUtils.GetLuaScr(self.FunctionCell, MBPath)
    if isNull(env) then return end
    env:RefreshUI(self._moduleId)

    -- local isShowSystemFunction, count = self:InitFunctionUnlock()
    -- if not isShowSystemFunction then
    --     return
    -- end
    -- for i = 1, count do
    --     local cell = self.unlockFunctionCells[i]
    --     cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.1))
    -- end
end

-- function CommonFunctionUnlockDialog:InitFunctionUnlock()
--     local unlockType = self.params.unlockType
--     local refId      = self.params.refId
--     local systemToggleIds = SystemToggleMgr:GetInstance():GetSystemToggleIds(unlockType, refId)
--     local isShowSystemFunction = systemToggleIds ~= nil
--     local count = 0
--     if isShowSystemFunction then
--         count = self:RefreshListView(self.ListView, self.FunctionCell, self.unlockFunctionCells, systemToggleIds)
--     end
--     return isShowSystemFunction, count
-- end


-- function CommonFunctionUnlockDialog:RefreshListView(parent, child, childList, systemToggleIds)
--     local ownNodeCount = #childList
--     local idCount      = #systemToggleIds
--     local forTimes     = math.max(ownNodeCount, idCount)
--     for i = 1, forTimes do
--         local systemToggleId = systemToggleIds[i]
--         local cell = childList[i]
--         if systemToggleId then
--             if cell ==  nil then
--                 cell = parent.gameObject:AddChild(child.gameObject)
--                 table.insert(childList, cell)
--             end
--             KTool.SetActive(cell, true)

--             ---@type UICultivatePlayerUpgradeFunctionNode
--             local env = CfUtils.GetLuaScr(cell.gameObject, MBPath)
--             if not KTool.IsNull(env) then
--                 env:RefreshUI(systemToggleId)

--             end

--         elseif cell then
--             KTool.SetActive(cell, false)
--         end
--     end
--     return idCount
-- end

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

---------------------------------------------------
--- handler end --
---------------------------------------------------

return CommonFunctionUnlockDialog
