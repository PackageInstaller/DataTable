-------------------------------------------------------------------------------
-- 任务界面 - 成长任务面板 - 一级面板
-- 
-- Author: zou hanjie <canglanxing@funtoygame.com>
-- 
-- Create: 2023-07-21 13:30:11
-------------------------------------------------------------------------------


---@type TaskComponent
local taskComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.TaskComponent)

       
--- from: Assets/BundleResources/Prefabs/OverseaTasks/OverseaGrowUpTasksDialog.prefab
---@class UITaskGrowUpPanel
---@field Env                           	UITaskGrowUpPanel                       
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ListView                      	Engine.UI.AutoFixSizeListView           
local UITaskGrowUpPanel = Class('UITaskGrowUpPanel')


-- ==============================================================

local UITaskGrowUpPanelUtils = import("Game.UI.Tasks.UITaskGrowUpPanelUtils")
local AutoFixSizeListView = CS.Engine.UI.AutoFixSizeListView
local ThemeCellLuaPath = "Game.UI.Tasks.UITaskGrowUpThemeCell"


-- ==============================================================

-- ==============================================================

function UITaskGrowUpPanel:__init()
    self.themesDojo = {} -- 后端 "task/growthTheme" 中的数据
    self.redPointNums = 0 -- 累计各 主题小红点 的个数
end


function UITaskGrowUpPanel:__delete()
end


function UITaskGrowUpPanel:Start()
    assert( self.ListView )
end


function UITaskGrowUpPanel:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return fun():void
function UITaskGrowUpPanel:GetRedPointChangeCB()
    return self.redPointChangeCB_
end
function UITaskGrowUpPanel:SetRedPointChangeCB(callback)
    self.redPointChangeCB_ = callback
end




function UITaskGrowUpPanel:ReadServer_GrowthTheme()

    GameUtils.Request( Interfaces.GrowUpGrowthTheme, {}, function(request, response) -- "task/growthTheme"
        if checkNumber(response.errCode) == 0 then 
            local growthThemeDojo = response.data
            if not( growthThemeDojo and growthThemeDojo.theme ) then 
                printError( "后端 task/growthTheme 数据异常, 请检查" )
                return
            end

            self.themesDojo = growthThemeDojo.theme       
            local themesDojoCount = table.count(self.themesDojo)

            -- 刷新小红点个数:
            self.redPointNums = 0 
            for k,dojo in pairs(self.themesDojo) do 
                if type(dojo.redDotHint) ~= "number" then 
                    printError( "后端数据 task/growthTheme.data.theme[i].redDotHint 异常" )
                    -- 并不就此中断, 继续执行
                end 
                if checkInt(dojo.redDotHint) == 0 then -- -1表示无红点, 0表示有红点 
                    self.redPointNums = self.redPointNums + 1
                end 
            end
            self:UpdateRedPoint()

            ---
            if not self.ListView.mLoopListView.IsListViewInit then
                self.ListView:InitListView(themesDojoCount, Bind(self, self.OnGetItemByIndex))
            else
                GameUtils.ReloadData(self.ListView, themesDojoCount)
            end
        end
    end)
end


-- index 0-based
function UITaskGrowUpPanel:OnGetItemByIndex(cell, index)
    if index < 0 then
        return nil
    end

    local idx = index+1 -- 1-based
    local themeDojo = self.themesDojo[index+1] 

    ---@type UITaskGrowUpThemeCell
    local nodeEnv = CfUtils.GetLuaScr(cell, ThemeCellLuaPath )

    if isNull(nodeEnv) then 
        return nil 
    end

    nodeEnv:Init( themeDojo )
    return cell
end



-------------------------------------------------
-- public

function UITaskGrowUpPanel:RefreshAll()

    self.redPointNums = 0 -- 重置
    self:ReadServer_GrowthTheme()
end


function UITaskGrowUpPanel:UpdateRedPoint()
    -- 更新成就红点值
    GameUtils.SetRedPointNum(Constants.RedPointConst.GrowUpTask,    (self.redPointNums>0) and 1 or 0 )
    --GameUtils.SetRedPointNum(Constants.RedPointConst.GrowUpTaskBox, (self.redPointNums>0) and 1 or 0 )
    -- do callback
    if self:GetRedPointChangeCB() then
        self:GetRedPointChangeCB()()
    end
end


return UITaskGrowUpPanel
