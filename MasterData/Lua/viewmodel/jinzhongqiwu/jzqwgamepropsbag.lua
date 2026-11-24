JZQWGamePropsBag = JZQWGamePropsBag or {}

JZQWGamePropsBag.Bind = function(this)
    this.ClearPropsScrollItems = function()
        this.curSelectItem = nil
        if this.propsOperateGroup ~= nil then
            SetActive(this.propsOperateGroup.gameObject, false)
        end
        if this.propsScrollViewUI ~= nil then
            this.propsScrollViewUI:Clear()
        end
    end

    this.RefreshProps = function(isInit)
        if isInit then
            SetActive(this.propsOperateGroup.gameObject, false)
        end
        local allDatas = JZQWGameData.GetAllPropsData()
        this.ClearPropsScrollItems()
        local scrollDatas = {}
        local width = 120
        local fixCount = 10
        local maxCount = math.max(#allDatas, fixCount)
        for i = 1, maxCount do
            local data = {}
            data.PropsData = allDatas[i]
            local scrollData = UIScrollData.GetData(this.propsItem, "JZQWGamePropsItem", width - 6, width, data)
            data.OnClickCallback = this.OnClickPropsCallback
            table.insert(scrollDatas, #scrollDatas + 1, scrollData)
        end
        this.propsScrollViewUI:SetParams(1144, 120)
        this.propsScrollViewUI:SetData(scrollDatas, true)
    end

    this.OnClickPropsCallback = function(item)
        if item:GetPropsData() == nil then
            SetActive(this.propsOperateGroup.gameObject, false)
            return
        end
        this.curSelectItem = item
        SetActive(this.propsOperateGroup.gameObject, true)
        local parentTrans = this.propsOperateGroup.parent
        if parentTrans ~= nil and item.transform ~= nil then
            local pos = RectTransformTool.ToContainer(item.transform, parentTrans, LuaMgr.UICamera())
            pos.y = this.propsOperateGroup.anchoredPosition.y
            pos.x = pos.x + 80
            this.propsOperateGroup.anchoredPosition = pos
        end
        local name = this.operateTypeNames[2]
        local obj = this[name]
        local propsData = item:GetPropsData()
        SetActive(obj.gameObject, propsData.CanCombine == true)
        SetActive(this.activateOperateTrans.gameObject, false)
        this.SetActivateArrowVis(true)
        this.curWaitTime = 0
    end

    this.OnClickPropsOperateBtn = function(type)
        if this.curSelectItem == nil then
            LuaMgr.error(LuaMgr.GetLangText("JZQWGamePropsBag_0"))
            return
        end
        if type == JZQWConst.PropsOperateType.Use then
            JZQWGameData.SetOperateProps(this.curSelectItem.data.PropsData)
            local data = {}
            data.PropsData = this.curSelectItem.data.PropsData
            data.IsUsing = true
            LuaMgr.InvokeUIEventListeners(UIEventConst.JZQWOperateProps, data)
        elseif type == JZQWConst.PropsOperateType.Combine then
            local curOperateProps = JZQWGameData.GetOperateProps()
            if curOperateProps ~= nil and curOperateProps.ActivateObjs ~= nil then
                local id1 = curOperateProps.ID
                local id2 = this.curSelectItem.data.PropsData.ID
                local harvestData, consumeData = JZQWGameData.GetCombineInAndOutProps(id1, id2, JZQWConst.CombineType.Props)
                if harvestData == nil then
                    local tipsContent = LuaMgr.GetLangText(JZQWConst.TextLan.TextLan6)
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
                else
                    local canCombine = this.CheckCombineConsumeItems(consumeData, harvestData)
                    if canCombine == true then
                        if consumeData ~= nil and NumTool.GetLen(consumeData) > 0 then
                            this.ReportPropsData(harvestData, consumeData)
                        else
                            this.ReportPropsData(harvestData)
                        end
                    end
                end
            else
                local tipsContent = LuaMgr.GetLangText(JZQWConst.TextLan.TextLan5)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            end
        elseif type == JZQWConst.PropsOperateType.Look then
            local data = {}
            data.PropsData = this.curSelectItem.data.PropsData
            data.OnConfirm = function()
                JZQWGameData.SetOperateProps(this.curSelectItem.data.PropsData)
                local data = {}
                data.PropsData = this.curSelectItem.data.PropsData
                data.IsUsing = true
                LuaMgr.InvokeUIEventListeners(UIEventConst.JZQWOperateProps, data)
                this.curSelectItem = nil
            end
            LuaMgr.ShowLuaPanel(UIName.JZQWGamePropsInfoPopup, data)
        elseif type == JZQWConst.PropsOperateType.Cancel then
            this.curSelectItem = nil
        end
        SetActive(this.propsOperateGroup.gameObject, false)
        this.curWaitTime = 0
    end

    this.CheckCombineConsumeItems = function(consumeData, harvestData)
        local eventData = JZQWGameData.GetUnfinishedTriggerEventByItems(consumeData, harvestData)
        if eventData == nil then
            return true
        end
        local tipsContent = LuaMgr.GetLangText(JZQWConst.TextLan.TextLan10)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return false
    end

    this.RefreshEventData = function()
        local chapterData = JZQWGameData.GetChapterData()
        local eventList = chapterData.EventList
        local finishReportMap = {}
        local finishMsgs = {}
        local nextEventIDs = {}
        local addFinishReport = function(id)
            local key = tostring(id) .. "_" .. tostring(JZQWConst.EventStatus.Finish)
            if finishReportMap[key] == true then
                return
            end
            finishReportMap[key] = true
            local data = {}
            data.Id = id
            data.Typ = JZQWConst.DataReportType.Event
            data.State = JZQWConst.EventStatus.Finish
            table.insert(finishMsgs, #finishMsgs + 1, data)
            table.insert(nextEventIDs, #nextEventIDs + 1, id)
        end
        for i = 1, #eventList do
            local eventData = eventList[i]
            if eventData.Status == JZQWConst.EventStatus.Unlock and this.CheckEventCompleteByItems(eventData) == true then
                addFinishReport(eventData.ID)
            end
        end
        if #finishMsgs > 0 then
            local callback = function()
                local reportMap = {}
                local unlockMsgs = {}
                for index = 1, #nextEventIDs do
                    local nextMsgs = this.GetNextEventReportData(nextEventIDs[index])
                    for i = 1, #nextMsgs do
                        local nextMsg = nextMsgs[i]
                        local key = tostring(nextMsg.Id) .. "_" .. tostring(nextMsg.State)
                        if reportMap[key] ~= true then
                            reportMap[key] = true
                            table.insert(unlockMsgs, #unlockMsgs + 1, nextMsg)
                        end
                    end
                end
                if #unlockMsgs > 0 then
                    local unlockCallback = function()
                        this.RefreshTask()
                    end
                    this.ReportActivateObjData(unlockMsgs, unlockCallback)
                else
                    this.RefreshTask()
                end
            end
            this.ReportActivateObjData(finishMsgs, callback)
        end
    end

    this.CheckEventCompleteByItems = function(eventData)
        local completeItems = eventData.Config.CompleteItem
        if completeItems == nil or #completeItems <= 0 then
            return false
        end
        for index = 1, #completeItems do
            local item = completeItems[index]
            local propsData = JZQWGameData.GetPropsDataByID(item.id)
            if propsData == nil or propsData.IsOwner ~= true then
                return false
            end
        end
        return true
    end
end

return JZQWGamePropsBag