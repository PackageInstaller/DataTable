
local BatchSyncerState = {
    None = 0,
    UnChecked = 1,
    CheckingList = 2,
    WaitDownload = 3,
    Downloading = 4,
    Finish = 5,
    Error = 99,
}

local ErrorCode = {
    None = 0,
    NoBatchSyncer = 1,
    BatchSyncerError = 2,
}

---@class BatchSyncerOperator
local BatchSyncerOperator = {}

function BatchSyncerOperator.New(batchSyncer)
    
    ---@class Operator
    local Operator = {}

    function Operator:CleanField()
        self.batchSyncer = nil
    end

    --- 获取batchSyncer状态
    function Operator:GetBatchSyncerState()
        local state = BatchSyncerState.None
        local errorCode = ErrorCode.None
        local errorMsg = nil

        local batchSyncer = self.batchSyncer
        if isNull(batchSyncer) then
            state = BatchSyncerState.Error
            errorCode = ErrorCode.NoBatchSyncer
            errorMsg = "没有batchSyncer"
        else
            local isError = batchSyncer.IsError
            local isReady = batchSyncer.IsReady
            local isFinish = batchSyncer.IsFinish
            local isStartDownload = batchSyncer.isStart
            local isStartFileList = batchSyncer.IsStartFileList
        
            if not isError then
                if not isStartFileList then
                    state = BatchSyncerState.UnChecked
                else
                    if not isReady then
                        -- 还在检查更新
                        state = BatchSyncerState.CheckingList
                    else
                        -- 已经检查完更新了
                        if not isStartDownload then
                            -- 没有开始下载
                            if not isFinish then
                                -- 等待下载
                                state = BatchSyncerState.WaitDownload
                            else
                                -- 下载过了，且没有更新
                                state = BatchSyncerState.Finish
                            end
                        else
                            -- 开始下载了
                            if not isFinish then
                                -- 下载中
                                state = BatchSyncerState.Downloading
                            else
                                -- 下载完成
                                state = BatchSyncerState.Finish
                            end
                        end
                    end
                end
            else
                state = BatchSyncerState.Error
                errorCode = ErrorCode.BatchSyncerError
                errorMsg = batchSyncer.Error:ToString()
            end
        end
        return state, errorCode, errorMsg
    end

    --- batchSyncer 开始下载
    function Operator:StartDownload()
        local batchSyncer = self.batchSyncer
        if isNull(batchSyncer) then
            return
        end
        local state, errorCode, errorMsg = self:GetBatchSyncerState()
        if state == BatchSyncerState.Error then
            printError(errorMsg)
        else
            if state == BatchSyncerState.UnChecked then
                batchSyncer.IsAutoDownload = false --自动下载的逻辑
                batchSyncer.isStart = false
                batchSyncer:SetBeforeCallback(function(b)
                    -- 如果还有可以下载的东西
                    if not batchSyncer:IsSuccess() then
                        -- 开始下载
                        batchSyncer.isStart = true
                        batchSyncer:StartDownload()
                    end
                end)
                batchSyncer:Start()
            elseif state == BatchSyncerState.CheckingList then
                -- 在检查更新
                printError("未实现的状态")
            elseif state == BatchSyncerState.WaitDownload then
                batchSyncer.isStart = true
                batchSyncer:StartDownload()
            elseif state == BatchSyncerState.Downloading then
                -- 已经在下载了
            elseif state == BatchSyncerState.Finish then
                -- 已经下载完了
            end
        end
    end

    --- 获取batchSyncer 的下载进度
    function Operator:GetDownloadProgress()
        local batchSyncer = self.batchSyncer
        local progress = batchSyncer.Progress
        local totalCount = batchSyncer.Syncers.Count
        local currentCount = progress * totalCount
        return progress, totalCount, currentCount
    end
    
    Operator.batchSyncer = batchSyncer

    return Operator
end

return BatchSyncerOperator