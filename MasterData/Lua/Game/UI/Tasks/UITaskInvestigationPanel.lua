-------------------------------------------------------------------------------
-- 任务界面 - 调查任务面板 - 一级面板 (没有二级)
-- 
-- Author: zou hanjie <canglanxing@funtoygame.com>
-- 
-- Create: 2023-08-29 13:30:11
-------------------------------------------------------------------------------


---@type TaskComponent
local taskComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.TaskComponent)

       
--- from: Assets/BundleResources/Prefabs/OverseaTasks/OverseaInvestigationTasksDialog.prefab
---@class UITaskInvestigationPanel
---@field Env                           	UITaskInvestigationPanel                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ListView                      	Engine.UI.AutoFixSizeListView           
local UITaskInvestigationPanel = Class('UITaskInvestigationPanel')
-- 外部调用:
-- local UITaskInvestigationPanel = import('Game.UI.Tasks.UITaskInvestigationPanel')

-- ==============================================================

local KTool = CS.Engine.Lib.KTool
local Animation = CS.UnityEngine.Animation
local AutoFixSizeListView = CS.Engine.UI.AutoFixSizeListView
local ThemeCellLuaPath = "Game.UI.Tasks.UITaskInvestigationThemeCell"

local ActionUtils = import('Game.UI.FightReady.UIMainChapter.ActionUtils')

---@type UITaskUtils
local UITaskUtils = import('Game.UI.Tasks.UITaskUtils')

local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程

-- ==============================================================

-- ==============================================================

function UITaskInvestigationPanel:__init()
    --self.redPoints = {} -- 每个区域的红点信息
    self.allTaskInfosDojo = {} -- 后端 "OverseaRegionalMap/allTaskInfo".allTaskInfo 中的数据
end


function UITaskInvestigationPanel:__delete()
end


function UITaskInvestigationPanel:Start()
    assert( self.ListView )
    self:GetRegionPrimaryMapsVo()
end


function UITaskInvestigationPanel:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return fun():void
function UITaskInvestigationPanel:GetRedPointChangeCB()
    return self.redPointChangeCB_
end
function UITaskInvestigationPanel:SetRedPointChangeCB(callback)
    self.redPointChangeCB_ = callback
end




function UITaskInvestigationPanel:ReadServer_AllTaskInfo( isFirst_ )

    -- 为了强刷 ListView 动画
    local rootTF = self.controller.gameObject.transform:Find("Root")
    if isFirst_ ~= true then 
        KTool.SetActive( rootTF, false )
    end 

    GameUtils.Request( Interfaces.InvestigationAllTaskInfo, {}, function(request, response) -- "OverseaRegionalMap/allTaskInfo"
        if checkNumber(response.errCode) == 0 then 
            local dataDojo = response.data
            if not( dataDojo and dataDojo.allTaskInfo ) then 
                printError( "后端 OverseaRegionalMap/allTaskInfo 数据异常, 请检查" )
                return
            end
            -- dic{ k:"3", v:{} } 注意它的 key 是个 string 的数字
            -- 它的元素个数, 可能少于 self.regionTotalNum
            self.allTaskInfosDojo = dataDojo.allTaskInfo 
            ---

            UITaskUtils.RefreshRedPointsInRegions() -- 遍历所有区域的小红点
            self:UpdateRedPoint()
            ---

            if not self.ListView.mLoopListView.IsListViewInit then
                self.ListView:InitListView(self.regionTotalNum, Bind(self, self.OnGetItemByIndex))
            else
                -- 为了强刷 ListView 动画
                --KTool.SetActive( rootTF, false )
                KTool.SetActive( rootTF, true )
                ---
                GameUtils.ReloadData(self.ListView, self.regionTotalNum)
            end
        end
    end)
end


-- index 0-based
function UITaskInvestigationPanel:OnGetItemByIndex(cell, index)
    if index < 0 then
        return nil
    end
    ---
    local idx = index+1 -- 1-based
    local allTaskInfoDojo = self.allTaskInfosDojo[ tostring(idx) ] -- 若为 nil, 表示此卡未解锁

    ---@type UITaskGrowUpThemeCell
    local nodeEnv = CfUtils.GetLuaScr(cell, ThemeCellLuaPath )
    if isNull(nodeEnv) then 
        printError("koko - 没拿到 themeCell 的 lua脚本")
        return nil 
    end
    ---

    -- local isNeedRedPoint = self.redPoints[idx]
    -- if type(isNeedRedPoint) ~= "boolean" then 
    --     printError("koko - 红点数据异常 " .. tostring(idx)  )
    --     isNeedRedPoint = false -- 手动写个假数据
    -- end 
    nodeEnv:Init( self, allTaskInfoDojo, idx )
    return cell
end



-------------------------------------------------


function UITaskInvestigationPanel:UpdateRedPoint()
    -- do callback
    if self:GetRedPointChangeCB() then
        self:GetRedPointChangeCB()()
    end
end


function UITaskInvestigationPanel:RefreshAll( isFirst_ )
    -- 强播 整个页面的刷新动画:
    --local rootTF = self.controller.gameObject.transform:Find("Root")
    --KTool.SetActive( rootTF, false )
    --KTool.SetActive( rootTF, true )
    ---
    self:ReadServer_AllTaskInfo( isFirst_ )
end

-- =================================== 配表: =========================================

-- 本地缓存所有 一级大地图表 的 行数据
function UITaskInvestigationPanel:GetRegionPrimaryMapsVo()
    self.regionPrimaryMapsVo = ActionUtils.GetAllRegionPrimaryMapVo()
    ---
    local num = 0
    for k,v in pairs(self.regionPrimaryMapsVo) do 
        if isNotNull(v) then 
            num = num + 1
        else 
            printError("koko - 配表中存在 空的 行数据, 异常")
        end 
    end
    self.regionTotalNum = num
end



-- 得到目标区域的 一级大地图表 对应行数据:
function UITaskInvestigationPanel:GetRegionPrimaryMapVo(regionId_)
    if checkNumber(regionId_) == 0 then
        printError("koko - 参数异常")
        return nil
    end
    ---
    for k,v in pairs(self.regionPrimaryMapsVo) do 
        if isNotNull(v) and v.id == regionId_ then 
            return v
        end
    end 
    --- 
    printError( "koko - 没找到目标 配表行 regionId_ = " .. tostring(regionId_)  )
    return nil
end


-- 得到目标区域的 任务总数
function UITaskInvestigationPanel.GetRegionTaskNumById( regionId_, lvl_ )
    if checkNumber(regionId_) == 0 or checkNumber(lvl_) == 0 then
        printError("koko - 参数异常")
        return nil
    end
    ---
    local regionTasksVo = CfUtils.GetCf(AutoIds.IdSetting4090, "RegionTaskVo", true)
    local num = 0
    for k,v in pairs(regionTasksVo) do 
        if isNotNull(v) and v.regionBelong == regionId_ and v.areaLv == lvl_ then 
            num = num + 1
        end 
    end
    return num
end


-- 得到一个区域的 最高调查等级
function UITaskInvestigationPanel.GetRegionMaxLvlById( regionId_ )
    if checkNumber(regionId_) == 0 then
        printError("koko - 参数异常")
        return nil
    end
    ---
    local vos = CfUtils.GetCf(AutoIds.IdSetting3029, "RegionLikabilityVo", true)
    local maxLvl = 1
    for k,v in pairs(vos) do 
        if isNotNull(v) and v.regionId == regionId_ and v.isMax == 1 then 
            maxLvl = v.level
            break
        end 
    end
    return maxLvl
end



return UITaskInvestigationPanel
