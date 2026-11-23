



ComboManager = {}
ComboManager.__index = ComboManager

function ComboManager.New(gridManager)

    local self = {}
    setmetatable(self, ComboManager)
    self.gridManager = gridManager
    self.comboCount = 0
    self.isProcessing = false
    self:InitEvents()
    return self
end


function ComboManager:InitEvents()
    self.onElementsEliminated = function(params)
        local data = {}
        if params.Length > 0 then
            data = params[0]
        end
        self:CheckForCombos(data)
    end
    LuaMgr.AddUIEventListener(UIEventConst.ElementsEliminated, self.onElementsEliminated)
end


function ComboManager:CheckForCombos(data)
    if self.isProcessing then
        return
    end
    self.isProcessing = true
    if self.coroutine ~= nil then
        coroutine_runner.stop(self.coroutine)
        self.coroutine = nil
    end

    local coroutineCallback = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.Match3ComboStepStatus, Match3Const.ComboStatus.Start)
        if type(data.animTime) == "number" then
            coroutine_runner.wait(data.animTime)
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.Match3OperateLimitChange, true)
        self.gridManager:PrintAllGridStatus("手动交换后补充之前")
        local waitEliminateTime = self.gridManager:FillEmptySpaces()
        coroutine_runner.wait(waitEliminateTime)
        self.gridManager:PrintAllGridStatus("手动交换补充之后" .. waitEliminateTime)

        local matches = self.gridManager:FindAllMatches()
        while #matches > 0 do
            LuaMgr.InvokeUIEventListeners(UIEventConst.Match3ComboIncreased, self.comboCount)
            self.comboCount = self.comboCount + 1
            Match3Const.PlaySound(Match3Const.AudioNameIndex.EliminateCombo)
            local maxAnimTime = 0

            local removeDuplicateDatas = {}
            for key, singleMatchs in pairs(matches) do
                local posSpecialType, specialElementPos = self.gridManager:GetSpecialTypeByMatch(singleMatchs)
                local allSpecialElementData = {}
                for _, element in ipairs(singleMatchs) do
                    local pos = element.Pos
                    local posStr = pos:ToString()
                    local specialElementData = nil
                    if posSpecialType ~= Match3Const.ElementType.None and specialElementPos ~= nil and posStr == specialElementPos:ToString() then
                        specialElementData = {}
                        specialElementData.genElementType = posSpecialType
                        specialElementData.pos = pos
                        table.insert(allSpecialElementData, specialElementData)
                    end
                    if element.Type ~= Match3Const.ElementType.WoodenBox and element.Healthy == 0 then
                        removeDuplicateDatas[posStr] = true
                    end
                end
                maxAnimTime = self.gridManager:EliminateSameTime(singleMatchs, nil, #allSpecialElementData > 0 and allSpecialElementData or nil)
                coroutine_runner.wait(maxAnimTime + 0.1)
            end
            Match3Const.PlaySound(Match3Const.AudioNameIndex.EliminatePop)
            local scoreData = {}
            scoreData.eliminateNum = NumTool.GetLen(removeDuplicateDatas)
            scoreData.comboCount = self.comboCount
            LuaMgr.InvokeUIEventListeners(UIEventConst.Match3ScoreUpdate, scoreData)
            self.gridManager:PrintAllGridStatus("连击中补充之前：")
            waitEliminateTime = self.gridManager:FillEmptySpaces()
            coroutine_runner.wait(waitEliminateTime)
            self.gridManager:PrintAllGridStatus("连击中补充之后：" .. waitEliminateTime)
            matches = self.gridManager:FindAllMatches()
        end

        local tempData = data
        tempData.comboCount = self.comboCount
        LuaMgr.InvokeUIEventListeners(UIEventConst.Match3ComboEnded, tempData)
        self.gridManager:PrintAllGridStatus("未连击或连击结束之后：")
        self.gridManager:FliterDirtyGrid()
        if self.comboCount > 0 then
            self.comboCount = 0
        end
        self.isProcessing = false
        LuaMgr.InvokeUIEventListeners(UIEventConst.Match3OperateLimitChange, false)
        LuaMgr.InvokeUIEventListeners(UIEventConst.Match3ComboStepStatus, Match3Const.ComboStatus.End)
    end
    self.coroutine = coroutine_runner.start(coroutineCallback)
end

function ComboManager:RemoveUIEvent()
    LuaMgr.RemoveUIEventListener(UIEventConst.ElementsEliminated, self.onElementsEliminated)
end

function ComboManager:Destroy()
    if self.coroutine ~= nil then
        coroutine_runner.stop(self.coroutine)
        self.coroutine = nil
    end
    self:RemoveUIEvent()
end