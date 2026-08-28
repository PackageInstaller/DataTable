-------------------------------------------------------------------------------
-- 全局水印
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-05-10 12:06:11
-------------------------------------------------------------------------------

local Application      = CS.UnityEngine.Application
local BehaviourAction  = CS.Engine.Lib.BehaviourAction
local ProfilerRecorder = CS.Unity.Profiling.ProfilerRecorder
local ProfilerCategory = CS.Unity.Profiling.ProfilerCategory

--- from: Assets/BundleResources/Prefabs/UIWaterMark.prefab
---@class UIWaterMark
---@field Env                           	UIWaterMark                             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtUID                        	UnityEngine.RectTransform               
---@field Root                          	UnityEngine.RectTransform               
local UIWaterMark = Class('UIWaterMark')


function UIWaterMark:__init()
    ---@type Engine.Lib.BehaviourAction
    self.behaviourAction_ = nil

    ---@type Unity.Profiling.ProfilerRecorder
    self.drawCallsRecorder_ = nil
end


function UIWaterMark:__delete()
    if self.behaviourAction_ then
        self.behaviourAction_.FixedUpdateAction = nil
        self.behaviourAction_ = nil
    end

    if self.drawCallsRecorder_ then
        self.drawCallsRecorder_:Dispose()
        self.drawCallsRecorder_ = nil
    end
end


function UIWaterMark:Awake()
end


function UIWaterMark:Start()
    CfUtils.SetActive(self.TxtUID, true)

    if Application.isEditor then
        self.drawCallsRecorder_ = ProfilerRecorder.StartNew(ProfilerCategory.Render, "Batches Count")

        self.behaviourAction_ = CfUtils.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
        self.behaviourAction_.FixedUpdateAction = function(dt)
            if self.drawCallsRecorder_ then
                local batchesNum = self.drawCallsRecorder_.LastValue
                if batchesNum > 0 then
                    self:SetBatchesCount(batchesNum)
                end
            end
        end
    end
end


function UIWaterMark:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

function UIWaterMark:GetPlayerId()
    return checkInt(self.playerId_)
end
function UIWaterMark:SetPlayerId(playerId)
    self.playerId_ = checkInt(playerId)
    self:UpdateUidInfo_()
end


---@return integer
function UIWaterMark:GetBatchesCount()
    return checkInt(self.batchesCount_)
end
function UIWaterMark:SetBatchesCount(count)
    local oldBatchesCount = self:GetBatchesCount()
    local mewBatchesCount = checkInt(count)
    self.batchesCount_ = mewBatchesCount
    if oldBatchesCount ~= mewBatchesCount then
        self:UpdateUidInfo_()
    end
end

function UIWaterMark:GetPing()
    return AppService:GetInstance().pingTime
end

-------------------------------------------------
-- private

function UIWaterMark:UpdateUidInfo_()
    local uidInfoStr = string.format('UID:%d', self:GetPlayerId())
    
    if Application.isEditor then
        local batchesNum = self:GetBatchesCount()
        if batchesNum > 0 then
            local colorStr = '#999999'
            if batchesNum > 230 then
                colorStr = '#CC0000'
            elseif batchesNum > 120 then
                colorStr = '#CCCC00'
            end
            uidInfoStr = string.format('%s <color=%s>(%d)</color>', uidInfoStr, colorStr, batchesNum)
        end
        local ping = self:GetPing()
        if ping > 0 then
            local colorStr = '#999999'
            if ping > 750 then
                colorStr = '#CC0000'
            elseif ping > 200 then
                colorStr = '#CCCC00'
            end
            uidInfoStr = uidInfoStr .. string.format(' ping:<color=%s>(%d)</color>', colorStr, ping)
        end
    end

    CfUtils.FillText(self.TxtUID, uidInfoStr)
end


return UIWaterMark
