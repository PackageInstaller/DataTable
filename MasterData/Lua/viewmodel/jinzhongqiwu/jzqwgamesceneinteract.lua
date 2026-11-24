JZQWGameSceneInteract = JZQWGameSceneInteract or {}

local sceneBGPath = "Assets/_BundleResources/Images/JinZhongQiWu/"

JZQWGameSceneInteract.Bind = function(this)
    this.InitScene = function()
        local sceneData = JZQWGameData.GetSceneData(this.sceneID)
        local imagePath = string.format("%s%s.png", sceneBGPath, sceneData.Config.BG)
        SetActive(this.decorateObj, sceneData.Config.BG == JZQWConst.ParticularSceneImage)
        this.sceneBG.texture = LuaMgr.GetTexture(imagePath)
        local allSceneObjDatas = JZQWGameData.GetSceneActivateObjs(sceneData.ID)
        table.sort(allSceneObjDatas, this.SortActivateDataByOrder)
        for index = 1, #allSceneObjDatas do
            local value = allSceneObjDatas[index]
            local data = value
            if data.Config.Type ~= JZQWConst.ActivateType.Props or data.Config.InteractType ~= JZQWConst.InteractType.Pick or data.Status == JZQWConst.ActivateObjStatus.Default then
                local item = this.GetSceneActivateObj(index)
                item:SetData(data)
                item.gameObject.name = "ActivateObj_" .. data.ID
                item.gameObject.transform:SetAsLastSibling()
                table.insert(this.activateItems, item)
            end
        end
        SetActive(this.activateOperateTrans.gameObject, false)
        this.SetActivateArrowVis(true)
        this.HideTalkBubbles()
        SetActive(this.talkMask.gameObject, false)
        SetActive(this.leftTipBtn.gameObject, false)
        SetActive(this.rightTipBtn.gameObject, false)
    end

    this.SortActivateDataByOrder = function(data1, data2)
        if data1.Config.Order == data2.Config.Order then
            return data1.IDNum < data2.IDNum
        end
        return data1.Config.Order < data2.Config.Order
    end

    this.GetSceneActivateObj = function(index)
        local item = table.remove(this.activateItemCache)
        if item == nil then
            local obj = LuaMgr.InstantiateGO(this.activateItem, this.sceneObjGroup, false)
            item = JZQWGameActivateObjItem.New(obj)
        end
        SetActive(item.gameObject, true)
        return item
    end

    this.SetActivateUI = function(activateObj)
        if this.isTalkTyping == true then
            SetActive(this.activateOperateTrans.gameObject, false)
            return
        end
        local interactType = activateObj.data.Config.InteractType
        local type = activateObj.data.Config.Type
        this.SetActivateButtonVis(JZQWConst.InteractType.Pick, false)
        this.SetActivateButtonVis(JZQWConst.InteractType.Interact, false)
        if type == JZQWConst.ActivateType.Props then
            if interactType == JZQWConst.InteractType.Interact or interactType == JZQWConst.InteractType.Commit or interactType == JZQWConst.InteractType.ChangeScene then
                this.SetActivateButtonVis(JZQWConst.InteractType.Interact, true)
            elseif interactType == JZQWConst.InteractType.Pick then
                local eventData = JZQWGameData.GetEventDataByID(activateObj.data.Config.UnlockEvent)
                if eventData == nil or eventData.Status == JZQWConst.EventStatus.Finish then
                    this.SetActivateButtonVis(JZQWConst.InteractType.Pick, true)
                end
            end
        else
            this.SetActivateButtonVis(JZQWConst.InteractType.Talk, true)
            JZQWGameData.RefreshSceneObj(this.sceneID, activateObj.data.ID)

            if activateObj.data.Status == JZQWConst.ActivateObjStatus.Default then
                local recipesID = this.curOperateActivateObj.data:GetRecipesID()
                local needItemID = activateObj.data:GetNeedCommitItem()

                if recipesID == nil then
                    this.SetActivateButtonVis(JZQWConst.InteractType.Interact, false)
                elseif needItemID ~= nil then
                    local propsData = JZQWGameData.GetPropsDataByID(needItemID)
                    if propsData ~= nil then

                        this.SetActivateButtonVis(JZQWConst.InteractType.Talk, propsData.IsOwner == false)
                        this.SetActivateButtonVis(JZQWConst.InteractType.Interact, propsData.IsOwner == true)
                    end
                end
            else
                local needItemIDs = activateObj.data:GetNeedCommitItems()
                if needItemIDs ~= nil and #needItemIDs == 1 then
                    local needItemID = needItemIDs[1]

                    local propsData = JZQWGameData.GetPropsDataByID(needItemID)
                    if propsData ~= nil then

                        this.SetActivateButtonVis(JZQWConst.InteractType.Talk, propsData.Config.Type == 2 or (propsData.Config.Type == 1 and propsData.IsOwner == false))
                        this.SetActivateButtonVis(JZQWConst.InteractType.Interact, propsData.Config.Type == 1 and propsData.IsOwner == true)
                    end
                elseif needItemIDs ~= nil then
                    local ownerAll = this.IsNeedCommitItemsOwner(needItemIDs)
                    this.SetActivateButtonVis(JZQWConst.InteractType.Talk, true)

                end
            end
        end
        if activateObj ~= nil and activateObj.rectTrans ~= nil and this.activateOperateTrans ~= nil then
            local parentTrans = this.activateOperateTrans.parent
            if parentTrans ~= nil then
                local pos = RectTransformTool.ToContainer(activateObj.rectTrans, parentTrans, LuaMgr.UICamera())
                local _, activateObjSizeY = activateObj:GetRealSize()
                pos.y = pos.y + activateObjSizeY
                this.activateOperateTrans.anchoredPosition = pos
            end
        end
        SetActive(this.activateOperateTrans.gameObject, true)
        this.SetActivateArrowVis(false)
    end

    this.IsNeedCommitItemsOwner = function(needItemIDs)
        if type(needItemIDs) ~= "table" or #needItemIDs <= 0 then
            return false
        end
        for i = 1, #needItemIDs do
            local propsData = JZQWGameData.GetPropsDataByID(needItemIDs[i])
            if propsData == nil or propsData.IsOwner ~= true then

                return false
            end
        end
        return true
    end

    this.SetActivateButtonVis = function(type, visible)
        local name = this.activateTypeNames[type]
        local obj = this[name]
        SetActive(obj.gameObject, visible)
    end

    this.SetOperateActivateObj = function(data)
        this.curOperateActivateObj = data
    end

    this.RecycleAllActivateObj = function()
        for key, value in pairs(this.activateItems) do
            SetActive(value.gameObject, false)
            table.insert(this.activateItemCache, value)
        end
        this.activateItems = {}
    end


    this.OnClickActivateObj = function(params)
        SetActive(this.propsOperateGroup.gameObject, false)
        if this.isTalkTyping == true then
            SetActive(this.activateOperateTrans.gameObject, false)
            return
        end
        SetActive(this.activateOperateTrans.gameObject, false)
        if params.Length < 1 then
            LuaDebug.error("this.OnClickActivateObj 点击交互物参数错误")
            return
        end
        this.StopMoveTweens()
        local activateObj = params[0]
        if this.lasSetArrowVisObj ~= nil and this.lasSetArrowVisObj ~= activateObj then
            this.SetActivateArrowVis(true)
        end
        this.curMoveActivateObj = activateObj
        this.lasSetArrowVisObj = activateObj
        this.SetOperateActivateObj(activateObj)
        if activateObj.rectTrans ~= nil and this.roleRectTrans ~= nil and this.roleRectTrans.parent ~= nil then
            local targetPos = RectTransformTool.ToContainer(activateObj.rectTrans, this.roleRectTrans.parent, LuaMgr.UICamera())
            local orginTargetPosX = targetPos.x
            this.curMoveFaceTargetX = orginTargetPosX
            local callback = function()
                this.SetActivateUI(activateObj)
                this.curMoveFaceTargetX = nil
                this.curMoveActivateObj = nil
            end
            local curRolePos = this.roleRectTrans.anchoredPosition
            local curRoleSize = this.roleRectTrans.sizeDelta
            local activateObjSizeX, _ = activateObj:GetRealSize()
            if targetPos.x > curRolePos.x then
                targetPos.x = targetPos.x - curRoleSize.x / 2 * JZQWConst.GameObjScale - activateObjSizeX / 2
            else
                targetPos.x = targetPos.x + curRoleSize.x / 2 * JZQWConst.GameObjScale + activateObjSizeX / 2
            end
            if math.abs(this.roleRectTrans.anchoredPosition.x - targetPos.x) < 0.1 then
                this.SetRoleFaceToX(this.curMoveFaceTargetX)
                callback()
            else
                this.ControlRolePos(targetPos, callback)
            end
        end
    end


    this.OnClickActivateOperate = function(curInteractType)
        if this.isTalkTyping == true then
            return
        end
        this.curWaitTime = 0
        SetActive(this.propsOperateGroup.gameObject, false)
        if this.curOperateActivateObj == nil then
            LuaDebug.error("this.OnClickActivateOperate 操作UI显示异常 260")
            return
        end
        local data = {}
        data.Id = this.curOperateActivateObj.data.ID
        JZQWGameData.RefreshSceneObj(this.sceneID, this.curOperateActivateObj.data.ID)

        if curInteractType == JZQWConst.InteractType.Talk then

            if this.curOperateActivateObj.data.Status == JZQWConst.ActivateObjStatus.Default then
                local recipesID = this.curOperateActivateObj.data:GetRecipesID()
                if recipesID == nil and this.curOperateActivateObj.data.Config.Type == JZQWConst.ActivateType.NPC then
                    data.Typ = JZQWConst.DataReportType.Npc
                    data.State = JZQWConst.ActivateObjStatus.InteractEnd1
                    local callback = function()
                        this.AfterActivateOperate(JZQWConst.InteractType.Talk)
                    end
                    local msgs = {data}

                    this.ReportActivateObjData(msgs, callback)
                else
                    this.AfterActivateOperate(JZQWConst.InteractType.Talk)
                end
            else
                local activateObj = this.curOperateActivateObj
                local needItemIDs = activateObj.data:GetNeedCommitItems()
                if needItemIDs ~= nil and #needItemIDs == 1 then

                    local needItemID = needItemIDs[1]
                    local propsData = JZQWGameData.GetPropsDataByID(needItemID)
                    if propsData and propsData.Config.Type == 2 and propsData.IsOwner == true then

                        this.AfterActivateOperate(JZQWConst.InteractType.Commit)
                    elseif propsData and propsData.IsOwner == false then

                        this.AfterActivateOperate(JZQWConst.InteractType.Talk)
                    end
                elseif needItemIDs ~= nil and #needItemIDs > 1 then

                    if this.IsNeedCommitItemsOwner(needItemIDs) == false then
                        this.AfterActivateOperate(JZQWConst.InteractType.Talk)
                    else
                        this.AfterActivateOperate(JZQWConst.InteractType.Interact)
                    end
                else
                    this.AfterActivateOperate(JZQWConst.InteractType.Talk)
                end
            end
        elseif curInteractType == JZQWConst.InteractType.Pick then
            data.Typ = JZQWConst.DataReportType.Npc
            data.State = 1
            local callback = function()
                this.AfterActivateOperate(JZQWConst.InteractType.Pick)
            end

            local msgs = {data}
            this.ReportActivateObjData(msgs, callback)
            local pickUpTool = this.curOperateActivateObj.data.Config.PickUpTool
            if type(pickUpTool) == "table" and #pickUpTool > 0 then
                local propsData = {}
                propsData[pickUpTool[1].id] = 1
                this.ReportPropsData(propsData)
            end
        elseif curInteractType == JZQWConst.InteractType.Interact then
            local objctType = this.curOperateActivateObj.data.Config.Type
            local recipesID = this.curOperateActivateObj.data:GetRecipesID()
            this.tempRecipesID = recipesID
            if objctType == JZQWConst.ActivateType.Props and recipesID ~= nil then
                local curOperateProps = JZQWGameData.GetOperateProps()
                if curOperateProps ~= nil then
                    local outputProps, consumeProps = JZQWGameData.GetRecipesInAndOutProps(recipesID)
                    if consumeProps[curOperateProps.ID] == nil then
                        local tipsContent = LuaMgr.GetLangText(JZQWConst.TextLan.TextLan8)
                        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
                    elseif this.curOperateActivateObj.data.Config.InteractType == JZQWConst.InteractType.Commit then

                        local allTrrigger = true
                        for id, value in pairs(outputProps) do
                            local eventData = JZQWGameData.GetEventByFinishItemID(id)
                            if eventData ~= nil and eventData.Status ~= JZQWConst.EventStatus.Unlock then
                                allTrrigger = false
                                break
                            end
                        end
                        if allTrrigger == true then
                            this.ReportPropsData(outputProps, consumeProps, this.ChangeSceneObj)
                        else
                            local tipsContent = LuaMgr.GetLangText(JZQWConst.TextLan.TextLan10)
                            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
                        end
                    else

                        local isFullCondition = true
                        for key, value in pairs(outputProps) do
                            if JZQWGameData.CheckEventUnlockByItemID(key) == false then
                                local tipsContent = LuaMgr.GetLangText(JZQWConst.TextLan.TextLan10)
                                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
                                isFullCondition = false
                                break
                            end
                        end

                        if isFullCondition == true then
                            this.ReportPropsData(outputProps, consumeProps)
                        end
                    end
                else
                    local tipsContent = LuaMgr.GetLangText(JZQWConst.TextLan.TextLan7)
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
                end
            elseif objctType == JZQWConst.ActivateType.NPC and recipesID ~= nil then

                local activateObj = this.curOperateActivateObj
                local eventData = JZQWGameData.GetEventDataByID(this.curOperateActivateObj.data.Config.UnlockEvent)
                if eventData ~= nil and eventData.Status ~= JZQWConst.EventStatus.Finish then
                    local tipsContent = LuaMgr.GetLangText(JZQWConst.TextLan.TextLan10)
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
                    return
                end
                local outputProps, consumeProps = JZQWGameData.GetRecipesInAndOutProps(recipesID)
                data.Typ = JZQWConst.DataReportType.Npc
                data.State = JZQWConst.ActivateObjStatus.InteractEnd2
                local callback1 = function()
                    if activateObj ~= nil then
                        JZQWGameData.RefreshSceneObj(this.sceneID, activateObj.data.ID)
                        local adventureData = DataMgr.Player.Adventure or {}
                        local serverState = adventureData.NpcIds and adventureData.NpcIds[activateObj.data.ID] or nil
                        if serverState == nil then
                            activateObj.data:SetStatus(data.State)
                            activateObj.data:Refresh()
                        end
                        activateObj:Refresh()
                    end
                    this.RefreshTask()
                    if activateObj ~= nil and activateObj.data ~= nil and activateObj.data.IsShow == false then
                        this.tempOperateActivateObj = this.curOperateActivateObj
                        this.curOperateActivateObj = nil
                        SetActive(this.activateOperateTrans.gameObject, false)
                        this.CheckChapteEnd()
                    else
                        this.AfterActivateOperate(JZQWConst.InteractType.Talk)
                    end
                end
                local callback = function()
                    local msgs = {}
                    local msgMap = {}
                    table.insert(msgs, data)
                    msgMap[data.Id] = true
                    for key, value in pairs(outputProps) do
                        local data1 = {}
                        local eventData = JZQWGameData.GetEventByFinishItemID(key)
                        if eventData ~= nil then
                            data1.Id = eventData.ID
                            data1.Typ = JZQWConst.DataReportType.Event
                            data1.State = JZQWConst.EventStatus.Finish
                            table.insert(msgs, data1)
                            msgMap[data1.Id] = true
                            local nextMsgs = this.GetNextEventReportData(eventData.ID, outputProps)
                            for i = 1, #nextMsgs do
                                local nextData = nextMsgs[i]
                                if nextData ~= nil and msgMap[nextData.Id] ~= true then
                                    table.insert(msgs, nextData)
                                    msgMap[nextData.Id] = true
                                end
                            end
                        end
                    end
                    this.ReportActivateObjData(msgs, callback1)
                end
                this.ReportPropsData(outputProps, consumeProps, callback)
            else
                this.AfterActivateOperate(JZQWConst.InteractType.Commit)
            end
        elseif curInteractType == JZQWConst.InteractType.ChangeScene then
            this.ChangeSceneObj()
        elseif curInteractType == JZQWConst.InteractType.MoreTalk then
            if this.curOperateActivateObj.data.Status == JZQWConst.ActivateObjStatus.Default or this.curOperateActivateObj.data.Status == JZQWConst.ActivateObjStatus.InteractEnd2 then
                if this.curOperateActivateObj.data.Status == JZQWConst.ActivateObjStatus.Default then
                    data.State = JZQWConst.ActivateObjStatus.InteractEnd1
                else
                    data.State = this.curOperateActivateObj.data.Status + 1
                end
                data.Typ = JZQWConst.DataReportType.Npc
                local callback = function()
                    this.AfterActivateOperate(JZQWConst.InteractType.Talk)
                end
                local msgs = {data}
                this.ReportActivateObjData(msgs, callback)
            else
                this.AfterActivateOperate(JZQWConst.InteractType.Talk)
            end
        end
        SetActive(this.activateOperateTrans.gameObject, false)
        this.SetActivateArrowVis(true)
    end

    this.ChangeSceneObj = function()
        local activateObj = this.curOperateActivateObj
        if activateObj == nil then
            activateObj = this.tempOperateActivateObj
        end
        local objData = activateObj.data
        local recipesID = activateObj.data:GetRecipesID()
        this.tempRecipesID = recipesID
        local objctType = objData.Config.Type
        if objctType == JZQWConst.ActivateType.Props and recipesID ~= nil then

            local outputProps, consumeProps, changeObjStatus = JZQWGameData.GetRecipesInAndOutProps(recipesID)
            local curOperateProps = JZQWGameData.GetOperateProps()
            if curOperateProps ~= nil and consumeProps[curOperateProps.ID] then

                local data = {}
                data.Id = objData.ID
                data.Typ = JZQWConst.DataReportType.Npc
                data.State = objData.Status
                if objData.Status == JZQWConst.ActivateObjStatus.Default then
                    data.State = JZQWConst.ActivateObjStatus.InteractEnd2
                elseif objData.Status == JZQWConst.ActivateObjStatus.InteractEnd1 then
                    data.State = JZQWConst.ActivateObjStatus.InteractEnd3
                end
                local callback = function()
                    this.AfterActivateOperate(JZQWConst.InteractType.ChangeScene)
                end
                local msgs = {data}
                local propsCallback = function()
                    this.ReportPropsData(outputProps, consumeProps, callback)
                end
                this.ReportActivateObjData(msgs, propsCallback)
            end
        end
    end



    this.StopTalkBubbleTween = function()
        if this.talkBubbleTextSeq ~= nil then
            this.talkBubbleTextSeq:Kill(false)
            this.talkBubbleTextSeq = nil
        end
    end

    this.HideTalkBubbles = function()
        if this.talkBubbleLeft ~= nil then
            SetActive(this.talkBubbleLeft.gameObject, false)
        end
        if this.talkBubbleRight ~= nil then
            SetActive(this.talkBubbleRight.gameObject, false)
        end
    end

    this.SetCurTalkBubble = function(isLeft)
        if isLeft == true then
            this.curTalkBubbleObj = this.talkBubbleLeft
            this.curTalkContent = this.talkBubbleLeftContent
            this.curTalkLayout = this.talkBubbleLeftLayout
        else
            this.curTalkBubbleObj = this.talkBubbleRight
            this.curTalkContent = this.talkBubbleRightContent
            this.curTalkLayout = this.talkBubbleRightLayout
        end
        this.HideTalkBubbles()
        return this.curTalkBubbleObj, this.curTalkContent
    end

    this.ParseTalkGroupString = function(groupStr)
        if type(groupStr) ~= "string" then
            return nil
        end
        local groups = {}
        for groupContent in string.gmatch(groupStr, "%[([^%]]*)%]") do
            local group = {}
            for value in string.gmatch(groupContent, "[^;；,%s]+") do
                table.insert(group, value)
            end
            table.insert(groups, group)
        end
        if #groups >= 2 then
            return groups
        end
        return nil
    end

    this.GetTalkGroup = function(talkConfig)
        if talkConfig == nil then
            return nil
        end
        local talkGroup = talkConfig.TalkGroup
        if type(talkGroup) == "string" then
            talkGroup = this.ParseTalkGroupString(talkGroup)
        end
        if type(talkGroup) ~= "table" or type(talkGroup[1]) ~= "table" or type(talkGroup[2]) ~= "table" or #talkGroup[1] <= 0 or #talkGroup[2] <= 0 then
            return nil
        end
        return talkGroup
    end

    this.GetTalkLineConfig = function(talkID)
        local config = ConfigMgr.Config.AdventureNpcTalkMap[talkID]
        if config ~= nil then
            return config
        end
        if type(talkID) == "string" and string.len(talkID) == 6 then
            local fixedTalkID = string.sub(talkID, 1, 3) .. "0" .. string.sub(talkID, 4)
            return ConfigMgr.Config.AdventureNpcTalkMap[fixedTalkID]
        end
        return nil
    end

    this.GetTalkTextLength = function(text)
        if type(text) ~= "string" then
            return 0
        end
        local length = 0
        local index = 1
        local byteCount = string.len(text)
        while index <= byteCount do
            local byte = string.byte(text, index)
            if byte < 0x80 then
                index = index + 1
            elseif byte < 0xE0 then
                index = index + 2
            elseif byte < 0xF0 then
                index = index + 3
            else
                index = index + 4
            end
            length = length + 1
        end
        return length
    end

    this.GetTalkTypewriterTime = function(text)
        local speed = tonumber(JZQWConst.TalkTypewriterSpeed) or 0
        if speed <= 0 then
            return JZQWConst.TalkTypewriterTime
        end
        return math.max(this.GetTalkTextLength(text) / speed, 0.01)
    end

    this.SetTalkContentPreferredWidth = function(text)
        if this.curTalkContent == nil then
            return
        end
        local oldText = this.curTalkContent.text
        this.curTalkContent.text = text or ""
        local preferredWidth = this.curTalkContent.preferredWidth
        this.curTalkContent.text = oldText
        local paddingWidth = 0
        if this.curTalkLayout ~= nil and this.curTalkLayout.padding ~= nil then
            paddingWidth = (tonumber(this.curTalkLayout.padding.left) or 0) + (tonumber(this.curTalkLayout.padding.right) or 0)
        end
        local maxWidth = this.GetMaxBubbleWidth()
        local width = math.min(preferredWidth + paddingWidth, maxWidth)
        if this.curTalkLayout ~= nil then
            this.curTalkLayout.enabled = false
        end
        if this.curTalkBubbleObj ~= nil then
            local sizeDelta = this.curTalkBubbleObj.sizeDelta
            this.curTalkBubbleObj.sizeDelta = Vector2(width, sizeDelta.y)
        end
        if this.curTalkLayout ~= nil then
            this.curTalkLayout.enabled = true
        end
    end

    this.BuildTalkLines = function(talkContentLan, talkConfig, fallbackText)
        local lines = {}
        local talkGroup = this.GetTalkGroup(talkConfig)
        if talkGroup ~= nil then
            local speakers = talkGroup[1]
            local talkIDs = talkGroup[2]
            local count = math.min(#speakers, #talkIDs)
            for i = 1, count do
                local talkID = tostring(talkIDs[i])
                local lineConfig = this.GetTalkLineConfig(talkID)
                local line = {}
                line.Speaker = tonumber(speakers[i]) or JZQWConst.TalkSpeaker.Npc
                if lineConfig ~= nil and lineConfig.TalkDescLan ~= nil then
                    line.Text = LuaMgr.GetLangText(lineConfig.TalkDescLan) or ""
                    table.insert(lines, line)
                end
            end
        end
        if #lines <= 0 then
            local line = {}
            line.Speaker = JZQWConst.TalkSpeaker.Npc
            if talkContentLan ~= nil then
                line.Text = LuaMgr.GetLangText(talkContentLan) or ""
            else
                line.Text = fallbackText or ""
            end
            table.insert(lines, line)
        end
        return lines
    end

    this.SetTalkBubblePosition = function(activateObj, speaker, forceLeft)
        if activateObj == nil then
            return
        end
        local parentTrans = nil
        if this.talkBubbleLeft ~= nil then
            parentTrans = this.talkBubbleLeft.parent
        elseif this.talkBubbleRight ~= nil then
            parentTrans = this.talkBubbleRight.parent
        end
        if parentTrans == nil then
            return
        end
        local rolePos = nil
        local npcPos = nil
        if this.roleRectTrans ~= nil then
            rolePos = RectTransformTool.ToContainer(this.roleRectTrans, parentTrans, LuaMgr.UICamera())
        end
        if activateObj.rectTrans ~= nil then
            npcPos = RectTransformTool.ToContainer(activateObj.rectTrans, parentTrans, LuaMgr.UICamera())
        end
        if npcPos == nil then
            return
        end
        if speaker == JZQWConst.TalkSpeaker.Role and this.roleRectTrans ~= nil and rolePos ~= nil then
            local roleSize = this.roleRectTrans.sizeDelta
            local isRoleLeft = forceLeft
            if isRoleLeft == nil then
                isRoleLeft = npcPos == nil or rolePos.x <= npcPos.x
            end
            local talkBubbleObj = this.SetCurTalkBubble(isRoleLeft)
            if talkBubbleObj == nil then
                return
            end
            local roleOffset = isRoleLeft and JZQWConst.RoleTalkBubbleOffset.Left or JZQWConst.RoleTalkBubbleOffset.Right
            local roleOffsetX = tonumber(roleOffset[1]) or 0
            local roleOffsetY = tonumber(roleOffset[2]) or 0
            local rolePivotY = this.roleRectTrans.pivot.y or 0.5
            local roleTopY = rolePos.y + roleSize.y * JZQWConst.GameObjScale * (1 - rolePivotY)
            talkBubbleObj.anchoredPosition = Vector2(rolePos.x + roleOffsetX, roleTopY + roleOffsetY)
        else
            local isObjLeft = forceLeft
            if isObjLeft == nil then
                isObjLeft = rolePos == nil or npcPos.x <= rolePos.x
            end
            local talkBubbleObj = this.SetCurTalkBubble(isObjLeft)
            if talkBubbleObj == nil then
                return
            end
            local _, npcSizeY = activateObj:GetRealSize()
            local npcPivotY = activateObj.rectTrans.pivot.y or 0.5
            local npcTopY = npcPos.y + npcSizeY * (1 - npcPivotY)
            if activateObj.data:GetObjType() == JZQWConst.ActivateType.NPC then
                local npcOffset = isObjLeft and JZQWConst.NpcTalkBubbleOffset.Left or JZQWConst.NpcTalkBubbleOffset.Right
                local npcOffsetX = tonumber(npcOffset[1]) or 0
                local npcOffsetY = tonumber(npcOffset[2]) or 0
                talkBubbleObj.anchoredPosition = Vector2(npcPos.x + npcOffsetX, npcTopY + npcOffsetY)
            else
                local dialogOffset = activateObj.data.Config.DialogOffset or {}
                local dialogOffsetX = tonumber(dialogOffset[1]) or 0
                local dialogOffsetY = tonumber(dialogOffset[2]) or 0
                talkBubbleObj.anchoredPosition = Vector2(npcPos.x + dialogOffsetX, npcTopY + dialogOffsetY)
            end
        end
    end

    this.IsTalkBubbleInScreen = function()
        if this.curTalkBubbleObj == nil or this.curTalkBubbleObj.parent == nil then
            return true
        end

        local activateObj = this.curOperateActivateObj
        if activateObj == nil then
            return false
        end
        local halfContenWidth = this.dragBehaviour.content.sizeDelta.x / 2
        local realSizeX, realSizeY = activateObj:GetRealSize()
        local distanceX = halfContenWidth - math.abs(activateObj.rectTrans.anchoredPosition.x)
        local minWidth = JZQWConst.TalkBubbleMaxWidth - 130
        if distanceX > JZQWConst.TalkBubbleMaxWidth then
            return true
        elseif distanceX < JZQWConst.TalkBubbleMaxWidth and distanceX > minWidth then
            return true
        end
        return false
    end

    this.GetMaxBubbleWidth = function()

        local activateObj = this.curOperateActivateObj
        if activateObj == nil then
            return JZQWConst.TalkBubbleMaxWidth
        end
        local halfContenWidth = this.dragBehaviour.content.sizeDelta.x / 2
        local realSizeX, realSizeY = activateObj:GetRealSize()
        local distanceX = halfContenWidth - math.abs(activateObj.rectTrans.anchoredPosition.x)
        local minWidth = JZQWConst.TalkBubbleMaxWidth - 130
        if distanceX > JZQWConst.TalkBubbleMaxWidth then
            return JZQWConst.TalkBubbleMaxWidth
        elseif distanceX < JZQWConst.TalkBubbleMaxWidth and distanceX > minWidth then
            return distanceX - 15
        end
        return JZQWConst.TalkBubbleMaxWidth
    end

    this.FinishTalkBubbleFlow = function()
        this.StopTalkBubbleTween()
        this.isTalkTyping = false
        this.isInTalkFlow = false
        this.isTalkLineTyping = false
        this.HideTalkBubbles()
        SetActive(this.talkMask.gameObject, false)
        LuaMgr.InvokeUIEventListeners(UIEventConst.JZQWTalkEnd)
        local callback = this.talkFlowFinishCallback
        this.talkFlowFinishCallback = nil
        this.talkLines = nil
        this.curTalkLine = nil
        this.curTalkBubbleObj = nil
        this.curTalkContent = nil
        this.curTalkLayout = nil
        if callback ~= nil then
            callback()
        end
    end

    this.PlayNextTalkLine = function()
        this.StopTalkBubbleTween()
        if this.talkLines == nil then
            this.FinishTalkBubbleFlow()
            return
        end
        this.curTalkIndex = (this.curTalkIndex or 0) + 1
        local line = this.talkLines[this.curTalkIndex]
        if line == nil then
            this.FinishTalkBubbleFlow()
            return
        end
        this.curTalkLine = line
        this.SetTalkBubblePosition(this.curTalkActivateObj, line.Speaker)
        if this.curTalkBubbleObj == nil or this.curTalkContent == nil then
            this.FinishTalkBubbleFlow()
            return
        end
        this.SetTalkContentPreferredWidth(line.Text)
        if this.IsTalkBubbleInScreen() == false then
            local isLeft = this.curTalkBubbleObj == this.talkBubbleLeft
            this.SetTalkBubblePosition(this.curTalkActivateObj, line.Speaker, not isLeft)
            this.SetTalkContentPreferredWidth(line.Text)
        end
        this.curTalkContent.text = ""
        SetActive(this.curTalkBubbleObj.gameObject, true)
        this.isTalkLineTyping = true
        this.talkBubbleTextSeq = DOTWeen:Sequence()
        this.talkBubbleTextSeq:Append(this.curTalkContent:DOText(line.Text, this.GetTalkTypewriterTime(line.Text)))
        this.talkBubbleTextSeq:AppendInterval(JZQWConst.TalkLineWaitTime)
        this.talkBubbleTextSeq:OnComplete(
            function()
                this.isTalkLineTyping = false
                this.talkBubbleTextSeq = nil
                this.PlayNextTalkLine()
            end
        )
    end

    this.StartTalkBubbleFlow = function(activateObj, talkContentLan, talkConfig, fallbackText, finishCallback)
        this.StopTalkBubbleTween()
        this.curTalkActivateObj = activateObj
        this.talkLines = this.BuildTalkLines(talkContentLan, talkConfig, fallbackText)
        this.curTalkIndex = 0
        this.talkFlowFinishCallback = finishCallback
        this.isTalkTyping = true
        this.isInTalkFlow = true
        this.isTalkLineTyping = false
        SetActive(this.talkMask.gameObject, true)
        LuaMgr.InvokeUIEventListeners(UIEventConst.JZQWTalkBegin)
        this.PlayNextTalkLine()
    end

    this.OnClickTalkMask = function()
        if this.isInTalkFlow ~= true then
            return
        end
        if this.isTalkLineTyping == true and this.curTalkLine ~= nil then
            this.StopTalkBubbleTween()
            if this.curTalkContent ~= nil then
                this.curTalkContent.text = this.curTalkLine.Text
            end
            this.isTalkLineTyping = false
            this.talkBubbleTextSeq = DOTWeen:Sequence()
            this.talkBubbleTextSeq:AppendInterval(JZQWConst.TalkClickWaitTime)
            this.talkBubbleTextSeq:OnComplete(
                function()
                    this.talkBubbleTextSeq = nil
                    this.PlayNextTalkLine()
                end
            )
        elseif this.talkLines ~= nil and this.curTalkIndex < #this.talkLines then
            this.PlayNextTalkLine()
        end
    end



    this.AfterActivateOperate = function(type)

        local activateObj = this.curOperateActivateObj
        if activateObj == nil then
            return
        end

        if type == JZQWConst.InteractType.Talk then
            local textStr = ""
            local talkContentLan, talkConfig = activateObj.data:GetCurTalkContent()
            if activateObj.data:GetObjType() ~= JZQWConst.ActivateType.NPC or talkContentLan == nil then
                textStr = LuaMgr.GetLangText(activateObj.data.Config.ClickTips)
            end
            local callback = function()
                if talkConfig ~= nil then
                    this.AfterNpcTalk(talkConfig)
                end
                this.tempOperateActivateObj = this.curOperateActivateObj
                this.curOperateActivateObj = nil
            end
            this.StartTalkBubbleFlow(activateObj, talkContentLan, talkConfig, textStr, callback)
        elseif type == JZQWConst.InteractType.Pick then
            SetActive(activateObj.gameObject, false)
            this.tempOperateActivateObj = this.curOperateActivateObj
            this.curOperateActivateObj = nil
        elseif type == JZQWConst.InteractType.Commit then
            local needItemIDs = activateObj.data:GetNeedCommitItems()
            this.tempRecipesID = activateObj.data:GetRecipesID()
            if this.IsNeedCommitItemsOwner(needItemIDs) == true then
                local callback = function()

                    if this.curOperateActivateObj.data.Config.Type == JZQWConst.ActivateType.NPC then
                        this.AfterCommitNpc(true)
                    else
                        this.AfterCommitObj()
                    end
                    this.tempOperateActivateObj = this.curOperateActivateObj
                    this.curOperateActivateObj = nil
                end
                local consumeProps = {}
                for i = 1, #needItemIDs do
                    local needItemID = needItemIDs[i]

                    consumeProps[needItemID] = (consumeProps[needItemID] or 0) + 1
                end
                this.ReportPropsData(nil, consumeProps, callback)
            end
        elseif type == JZQWConst.InteractType.ChangeScene then
            JZQWGameData.RefreshSceneObj(this.sceneID, activateObj.data.ID)

            activateObj:Refresh()
        elseif type == JZQWConst.InteractType.Interact then
            local needItemIDs = activateObj.data:GetNeedCommitItems()
            this.tempRecipesID = activateObj.data:GetRecipesID()

            if this.IsNeedCommitItemsOwner(needItemIDs) == true then
                local data = {}
                data.Id = activateObj.data.ID
                data.Typ = JZQWConst.DataReportType.Npc
                if activateObj.data.Status == JZQWConst.ActivateObjStatus.Default then
                    data.State = JZQWConst.ActivateObjStatus.InteractEnd1
                elseif activateObj.data.Status == JZQWConst.ActivateObjStatus.InteractEnd1 then
                    data.State = JZQWConst.ActivateObjStatus.InteractEnd2
                end
                local msgs = {data}
                local callback = function()
                    JZQWGameData.RefreshSceneObj(this.sceneID, activateObj.data.ID)
                    this.AfterCommitNpc()
                end
                this.ReportActivateObjData(msgs, callback)
            end
        end
    end

    this.AfterNpcTalk = function(talkConfig)
        if talkConfig == nil then
            return
        end
        local callBack = function()
            this.RefreshTask()
        end
        local rewardData = this.BuildTalkRewardItems(talkConfig.Reward)
        local msgs = this.GetNextEventReportData(talkConfig.EventID, rewardData)
        local data = {}
        data.Id = talkConfig.EventID
        data.Typ = JZQWConst.DataReportType.Event
        data.State = JZQWConst.EventStatus.Finish
        table.insert(msgs, 1, data)
        if next(rewardData) ~= nil then
            local reportCallback = function()
                this.ReportActivateObjData(msgs, callBack)
            end
            this.ReportPropsData(rewardData, nil, reportCallback)
        else
            this.ReportActivateObjData(msgs, callBack)
        end
    end

    this.BuildTalkRewardItems = function(rewards)
        local items = {}
        if type(rewards) ~= "table" then
            return items
        end
        for i = 1, #rewards do
            local reward = rewards[i]
            if reward ~= nil and type(reward.id) == "string" and reward.id ~= "" then
                items[reward.id] = (items[reward.id] or 0) + (tonumber(reward.count) or 1)
            end
        end
        return items
    end





    this.GetMissingRewardItems = function(rewardData)
        local missingItems = {}
        if type(rewardData) ~= "table" then
            return missingItems
        end
        local ownerProps = DataMgr.Player.Adventure.Tools or {}
        for id, count in pairs(rewardData) do
            local needCount = tonumber(count) or 1
            local ownerCount = tonumber(ownerProps[id]) or 0
            if ownerCount < needCount then
                missingItems[id] = needCount - ownerCount
            end
        end
        return missingItems
    end

    this.AddRepairEventMsg = function(msgs, msgMap, id, state)
        if type(id) == "number" then
            id = tostring(id)
        end
        if type(id) ~= "string" or id == "" or msgMap[id] == true then
            return
        end
        local data = {}
        data.Id = id
        data.Typ = JZQWConst.DataReportType.Event
        data.State = state
        table.insert(msgs, data)
        msgMap[id] = true
    end

    this.BuildPendingTalkRepairMsgs = function(talkConfig, rewardData)
        local msgs = {}
        local msgMap = {}
        if talkConfig == nil then
            return msgs
        end
        if type(talkConfig.EventID) == "string" and talkConfig.EventID ~= "" then
            local eventData = JZQWGameData.GetEventDataByID(talkConfig.EventID)
            if eventData ~= nil and eventData.Status ~= JZQWConst.EventStatus.Finish then
                this.AddRepairEventMsg(msgs, msgMap, talkConfig.EventID, JZQWConst.EventStatus.Finish)
            end
            local nextMsgs = this.GetNextEventReportData(talkConfig.EventID, rewardData)
            for i = 1, #nextMsgs do
                local data = nextMsgs[i]
                if data ~= nil and msgMap[data.Id] ~= true then
                    table.insert(msgs, data)
                    msgMap[data.Id] = true
                end
            end
        end
        if type(talkConfig.Reward) == "table" then
            for i = 1, #talkConfig.Reward do
                local reward = talkConfig.Reward[i]
                if reward ~= nil then
                    local eventData = JZQWGameData.GetEventByFinishItemID(reward.id)
                    if eventData ~= nil and eventData.Status == JZQWConst.EventStatus.Unlock then
                        this.AddRepairEventMsg(msgs, msgMap, eventData.ID, JZQWConst.EventStatus.Finish)
                    end
                end
            end
        end
        return msgs
    end

    this.IsTalkRewardRepairNeeded = function(talkConfig)
        if talkConfig == nil then
            return false
        end
        if type(talkConfig.EventID) == "string" and talkConfig.EventID ~= "" then
            local eventData = JZQWGameData.GetEventDataByID(talkConfig.EventID)
            if eventData ~= nil and eventData.Status ~= JZQWConst.EventStatus.Finish then
                return true
            end
        end
        if type(talkConfig.Reward) == "table" then
            for i = 1, #talkConfig.Reward do
                local reward = talkConfig.Reward[i]
                if reward ~= nil then
                    local eventData = JZQWGameData.GetEventByFinishItemID(reward.id)
                    if eventData ~= nil and eventData.Status == JZQWConst.EventStatus.Unlock then
                        return true
                    end
                    if this.IsOwnerItemEnough(reward.id, reward.count) == false and this.IsItemNeededByUnfinishedEvent(reward.id) == true then
                        return true
                    end
                end
            end
        end
        return false
    end

    this.ReportPendingTalkRepair = function(talkConfig)
        if talkConfig == nil then
            return false
        end
        local rewardData = this.BuildTalkRewardItems(talkConfig.Reward)
        local missingItems = {}
        if this.IsTalkRewardRepairNeeded(talkConfig) == true then
            missingItems = this.GetMissingRewardItems(rewardData)
        end
        local msgs = this.BuildPendingTalkRepairMsgs(talkConfig, rewardData)
        local hasMissingItems = next(missingItems) ~= nil
        local hasMsgs = #msgs > 0
        if hasMissingItems == false and hasMsgs == false then
            return false
        end
        local callback = function()
            this.RefreshProps(false)
            this.RefreshTask()
            this.CheckChapteEnd()
        end
        if hasMissingItems == true then
            local propsCallback = function()
                if hasMsgs == true then
                    this.ReportActivateObjData(msgs, callback)
                else
                    callback()
                end
            end
            this.ReportPropsData(missingItems, nil, propsCallback)
        else
            this.ReportActivateObjData(msgs, callback)
        end
        return true
    end

    this.IsEventCompleteItemOwner = function(eventData)
        if eventData == nil or eventData.Config == nil or type(eventData.Config.CompleteItem) ~= "table" then
            return false
        end
        for i = 1, #eventData.Config.CompleteItem do
            local item = eventData.Config.CompleteItem[i]
            if item == nil or this.IsOwnerItemEnough(item.id, item.count) == false then
                return false
            end
        end
        return #eventData.Config.CompleteItem > 0
    end

    this.IsPendingCommittedEventNeedRepair = function(eventData)
        if eventData == nil or eventData.Status == JZQWConst.EventStatus.Finish then
            return false
        end
        if this.IsEventPreEventsFinish(eventData.ID) == false then
            return false
        end
        return this.IsEventTriggerItemMissing(eventData) == true and this.IsEventCompleteItemOwner(eventData) == true
    end

    this.GetPendingPassedRewardItems = function()
        local items = {}
        local sceneData = JZQWGameData.GetSceneData(this.sceneID)
        if sceneData == nil then
            return items
        end
        local allSceneObjDatas = JZQWGameData.GetSceneActivateObjs(sceneData.ID)
        for i = 1, #allSceneObjDatas do
            local objData = allSceneObjDatas[i]
            if objData ~= nil and objData.Config ~= nil and objData.Config.Type == JZQWConst.ActivateType.NPC and type(objData.Config.Param) == "table" then
                for j = 1, #objData.Config.Param do
                    if this.IsTalkIndexPassed(objData, j) == true then
                        local talkConfig = this.GetTalkConfigByParamIndex(objData, j)
                        if talkConfig ~= nil and type(talkConfig.Reward) == "table" then
                            for k = 1, #talkConfig.Reward do
                                local reward = talkConfig.Reward[k]
                                if reward ~= nil and this.IsOwnerItemEnough(reward.id, reward.count) == false and this.IsItemNeededByUnfinishedEvent(reward.id) == true then
                                    items[reward.id] = (items[reward.id] or 0) + (tonumber(reward.count) or 1)
                                end
                            end
                        end
                    end
                end
            end
        end
        return items
    end

    this.IsEventCompleteByPendingItems = function(eventData, pendingItems)
        if eventData == nil or eventData.Config == nil or type(eventData.Config.CompleteItem) ~= "table" or type(pendingItems) ~= "table" then
            return false
        end
        for i = 1, #eventData.Config.CompleteItem do
            local item = eventData.Config.CompleteItem[i]
            if item ~= nil and pendingItems[item.id] ~= nil then
                return true
            end
        end
        return false
    end

    this.IsPendingCompleteEventNeedRepair = function(eventData, pendingItems)
        if eventData == nil or eventData.Status ~= JZQWConst.EventStatus.Unlock then
            return false
        end
        if this.IsPendingCommittedEventNeedRepair(eventData) == true then
            return true
        end
        return this.IsEventCompleteByPendingItems(eventData, pendingItems) == true
    end

    this.ReportPendingCompleteItemRepair = function()
        local chapterData = JZQWGameData.GetChapterData()
        if chapterData == nil or type(chapterData.EventList) ~= "table" then
            return false
        end
        local pendingItems = this.GetPendingPassedRewardItems()
        for i = 1, #chapterData.EventList do
            local eventData = chapterData.EventList[i]
            if this.IsPendingCompleteEventNeedRepair(eventData, pendingItems) == true then
                local msgs = {}
                local msgMap = {}
                this.AddRepairEventMsg(msgs, msgMap, eventData.ID, JZQWConst.EventStatus.Finish)
                local nextMsgs = this.GetNextEventReportData(eventData.ID, pendingItems)
                for j = 1, #nextMsgs do
                    local data = nextMsgs[j]
                    if data ~= nil and msgMap[data.Id] ~= true then
                        table.insert(msgs, data)
                        msgMap[data.Id] = true
                    end
                end
                local callback = function()
                    this.RefreshProps(false)
                    this.RefreshTask()
                    this.CheckChapteEnd()
                end
                if next(pendingItems) ~= nil then
                    local propsCallback = function()
                        this.ReportActivateObjData(msgs, callback)
                    end
                    this.ReportPropsData(pendingItems, nil, propsCallback)
                else
                    this.ReportActivateObjData(msgs, callback)
                end
                return true
            end
        end
        return false
    end

    this.GetTalkConfigByParamIndex = function(objData, index)
        if objData == nil or objData.Config == nil or type(objData.Config.Param) ~= "table" then
            return nil
        end
        local talkID = objData.Config.Param[index]
        if talkID == nil or talkID == "" then
            return nil
        end
        return ConfigMgr.Config.AdventureNpcTalkMap[talkID]
    end

    this.IsOwnerItemEnough = function(itemID, count)
        if type(itemID) ~= "string" or itemID == "" then
            return false
        end
        local ownerProps = DataMgr.Player.Adventure.Tools or {}
        local ownerCount = tonumber(ownerProps[itemID]) or 0
        local needCount = tonumber(count) or 1
        return ownerCount >= needCount
    end

    this.IsEventTriggerItemMissing = function(eventData)
        if eventData == nil or eventData.Config == nil or type(eventData.Config.TriggerItem) ~= "table" then
            return false
        end
        for i = 1, #eventData.Config.TriggerItem do
            local item = eventData.Config.TriggerItem[i]
            if item ~= nil and this.IsOwnerItemEnough(item.id, item.count) == false then
                return true
            end
        end
        return false
    end

    this.IsTalkRewardContainsItem = function(talkConfig, itemID)
        if talkConfig == nil or type(talkConfig.Reward) ~= "table" then
            return false
        end
        for i = 1, #talkConfig.Reward do
            local reward = talkConfig.Reward[i]
            if reward ~= nil and reward.id == itemID then
                return true
            end
        end
        return false
    end

    this.GetTalkConfigByRewardItem = function(objData, itemID)
        if objData == nil or objData.Config == nil or type(objData.Config.Param) ~= "table" then
            return nil
        end
        for i = 1, #objData.Config.Param do
            local talkConfig = this.GetTalkConfigByParamIndex(objData, i)
            if talkConfig ~= nil and this.IsTalkRewardContainsItem(talkConfig, itemID) == true then
                return talkConfig
            end
        end
        return nil
    end

    this.GetTalkConfigAndIndexByRewardItem = function(objData, itemID)
        if objData == nil or objData.Config == nil or type(objData.Config.Param) ~= "table" then
            return nil, nil
        end
        for i = 1, #objData.Config.Param do
            local talkConfig = this.GetTalkConfigByParamIndex(objData, i)
            if talkConfig ~= nil and this.IsTalkRewardContainsItem(talkConfig, itemID) == true then
                return talkConfig, i
            end
        end
        return nil, nil
    end

    this.IsTalkIndexPassed = function(objData, index)
        if objData == nil or index == nil then
            return false
        end
        if objData.Config.InteractType == JZQWConst.InteractType.MoreTalk then
            return objData.Status >= index
        end
        return objData.Status >= JZQWConst.ActivateObjStatus.InteractEnd1
    end

    this.GetPendingPassedRewardTalkConfig = function(objData)
        if objData == nil or objData.Config == nil or type(objData.Config.Param) ~= "table" then
            return nil
        end
        for i = 1, #objData.Config.Param do
            if this.IsTalkIndexPassed(objData, i) == true then
                local talkConfig = this.GetTalkConfigByParamIndex(objData, i)
                if talkConfig ~= nil and type(talkConfig.Reward) == "table" then
                    for j = 1, #talkConfig.Reward do
                        local reward = talkConfig.Reward[j]
                        if reward ~= nil and this.IsOwnerItemEnough(reward.id, reward.count) == false and this.IsItemNeededByUnfinishedEvent(reward.id) == true then
                            return talkConfig
                        end
                    end
                end
            end
        end
        return nil
    end

    this.GetPendingCommittedTalkConfig = function(objData)
        local chapterData = JZQWGameData.GetChapterData()
        if chapterData == nil or type(chapterData.EventList) ~= "table" then
            return nil
        end
        for i = 1, #chapterData.EventList do
            local eventData = chapterData.EventList[i]
            if eventData ~= nil and eventData.Status == JZQWConst.EventStatus.Unlock and this.IsEventTriggerItemMissing(eventData) == true then
                local guideTarget = eventData.Config.GuideTarget
                if type(guideTarget) == "string" and guideTarget ~= "" and guideTarget ~= objData.ID then
                    goto continue
                end
                local completeItems = eventData.Config.CompleteItem
                if type(completeItems) == "table" then
                    for j = 1, #completeItems do
                        local item = completeItems[j]
                        if item ~= nil and this.IsOwnerItemEnough(item.id, item.count) == false then
                            local talkConfig = this.GetTalkConfigByRewardItem(objData, item.id)
                            if talkConfig ~= nil then
                                return talkConfig
                            end
                        end
                    end
                end
            end
            if eventData ~= nil and eventData.Status == JZQWConst.EventStatus.Unlock then
                local guideTarget = eventData.Config.GuideTarget
                if type(guideTarget) == "string" and guideTarget ~= "" and guideTarget ~= objData.ID then
                    goto continue
                end
                local completeItems = eventData.Config.CompleteItem
                if type(completeItems) == "table" then
                    for j = 1, #completeItems do
                        local item = completeItems[j]
                        if item ~= nil and this.IsOwnerItemEnough(item.id, item.count) == false then
                            local talkConfig, talkIndex = this.GetTalkConfigAndIndexByRewardItem(objData, item.id)
                            if talkConfig ~= nil and this.IsTalkIndexPassed(objData, talkIndex) == true then
                                return talkConfig
                            end
                        end
                    end
                end
            end
            ::continue::
        end
        return this.GetPendingPassedRewardTalkConfig(objData)
    end

    this.GetPendingRepairTalkConfig = function(objData)
        if objData == nil or objData.Config == nil or objData.Config.Type ~= JZQWConst.ActivateType.NPC then
            return nil
        end
        local committedTalkConfig = this.GetPendingCommittedTalkConfig(objData)
        if committedTalkConfig ~= nil then
            return committedTalkConfig
        end
        if objData.Config.InteractType == JZQWConst.InteractType.MoreTalk and objData.Status >= JZQWConst.ActivateObjStatus.InteractEnd2 then
            return this.GetTalkConfigByParamIndex(objData, objData.Status)
        end
        if objData.Status == JZQWConst.ActivateObjStatus.InteractEnd1 then
            return this.GetTalkConfigByParamIndex(objData, 1)
        end
        if objData.Config.InteractType == JZQWConst.InteractType.Interact and objData.Status == JZQWConst.ActivateObjStatus.InteractEnd3 then
            local paramCount = type(objData.Config.Param) == "table" and #objData.Config.Param or 0
            return this.GetTalkConfigByParamIndex(objData, paramCount)
        end
        return nil
    end

    this.IsItemNeededByUnfinishedEvent = function(itemID)
        local chapterData = JZQWGameData.GetChapterData()
        if chapterData == nil or type(chapterData.EventList) ~= "table" then
            return false
        end
        for i = 1, #chapterData.EventList do
            local eventData = chapterData.EventList[i]
            if eventData ~= nil and eventData.Status ~= JZQWConst.EventStatus.Finish then
                if this.IsItemInEventItems(itemID, eventData.Config.TriggerItem) == true or this.IsItemInEventItems(itemID, eventData.Config.CompleteItem) == true then
                    return true
                end
            end
        end
        return false
    end

    this.IsItemInEventItems = function(itemID, items)
        if type(items) ~= "table" then
            return false
        end
        for i = 1, #items do
            local item = items[i]
            if item ~= nil and item.id == itemID then
                return true
            end
        end
        return false
    end

    this.ReportPendingPickRepair = function(objData)
        if objData == nil or objData.Config == nil or objData.Config.Type ~= JZQWConst.ActivateType.Props or objData.Config.InteractType ~= JZQWConst.InteractType.Pick then
            return false
        end
        if objData.Status == JZQWConst.ActivateObjStatus.Default then
            return false
        end
        local pickUpTool = objData.Config.PickUpTool
        if type(pickUpTool) ~= "table" or #pickUpTool <= 0 then
            return false
        end
        local needRepairItems = {}
        for i = 1, #pickUpTool do
            local item = pickUpTool[i]
            if item ~= nil and this.IsItemNeededByUnfinishedEvent(item.id) == true then
                needRepairItems[item.id] = item.count or 1
            end
        end
        local missingItems = this.GetMissingRewardItems(needRepairItems)
        if next(missingItems) == nil then
            return false
        end
        local callback = function()
            this.RefreshProps(false)
            this.RefreshTask()
        end
        this.ReportPropsData(missingItems, nil, callback)
        return true
    end

    this.CheckPendingProgressRepair = function()
        local sceneData = JZQWGameData.GetSceneData(this.sceneID)
        if sceneData == nil then
            return
        end
        if this.ReportPendingCompleteItemRepair() == true then
            return
        end
        local allSceneObjDatas = JZQWGameData.GetSceneActivateObjs(sceneData.ID)
        for i = 1, #allSceneObjDatas do
            local objData = allSceneObjDatas[i]
            if this.ReportPendingPickRepair(objData) == true then
                return
            end
            local talkConfig = this.GetPendingRepairTalkConfig(objData)
            if this.ReportPendingTalkRepair(talkConfig) == true then
                return
            end
        end
    end



    this.GetTalkRewardFinishMsgs = function(rewards)
        local msgs = {}
        local eventMap = {}
        if type(rewards) ~= "table" then
            return msgs
        end
        for i = 1, #rewards do
            local reward = rewards[i]
            if reward ~= nil then
                local eventData = JZQWGameData.GetEventByFinishItemID(reward.id)
                if eventData ~= nil and eventMap[eventData.ID] ~= true then
                    local data = {}
                    data.Id = eventData.ID
                    data.Typ = JZQWConst.DataReportType.Event
                    data.State = JZQWConst.EventStatus.Finish
                    table.insert(msgs, data)
                    eventMap[eventData.ID] = true
                end
            end
        end
        return msgs
    end

    this.AfterCommitNpc = function(isCommit)

        local activateObj = this.curOperateActivateObj
        if activateObj == nil then
            return
        end
        local talkContentLan, talkConfig = activateObj.data:GetCurTalkContent(isCommit)

        if talkContentLan == nil or talkConfig == nil then
            this.HideTalkBubbles()
            return
        end
        local data = {}
        data.Id = this.curOperateActivateObj.data.ID
        data.Typ = JZQWConst.DataReportType.Npc
        data.State = JZQWConst.ActivateObjStatus.InteractEnd3
        local msgs = {data}
        this.ReportActivateObjData(msgs)

        local callback1 = function()
            local rewardMsgs = this.GetTalkRewardFinishMsgs(talkConfig.Reward)
            if #rewardMsgs > 0 then
                this.ReportActivateObjData(rewardMsgs, this.CheckChapteEnd)
                return
            end
            this.CheckChapteEnd()
        end
        local callback = function()
            local outputItems = this.BuildTalkRewardItems(talkConfig.Reward)
            if next(outputItems) ~= nil then
                this.ReportPropsData(outputItems, nil, callback1)
            else
                callback1()
            end
        end
        this.StartTalkBubbleFlow(activateObj, talkContentLan, talkConfig, nil, callback)
    end

    this.AfterCommitObj = function()
        local recipesID = this.tempRecipesID
        if recipesID == nil then
            return
        end
        local activateObj = this.curOperateActivateObj
        local outputProps, consumeProps = JZQWGameData.GetRecipesInAndOutProps(recipesID)
        this.tempRecipesID = nil

        local data = {}
        data.Id = this.curOperateActivateObj.data.ID
        data.Typ = JZQWConst.DataReportType.Npc
        data.State = JZQWConst.ActivateObjStatus.InteractEnd2
        local msgs = {data}
        this.ReportActivateObjData(msgs)

        local callback1 = function()
            local callback2 = function()
                if activateObj ~= nil then
                    JZQWGameData.RefreshSceneObj(this.sceneID, activateObj.data.ID)
                    activateObj:Refresh()
                end
                this.RefreshTask()
                this.CheckChapteEnd()
            end

            local msgs = {}
            local msgMap = {}
            for key, value in pairs(outputProps) do
                local eventData = JZQWGameData.GetEventByFinishItemID(key)
                if eventData ~= nil then
                    local data = {}
                    data.Id = eventData.ID
                    data.Typ = JZQWConst.DataReportType.Event
                    data.State = JZQWConst.EventStatus.Finish
                    table.insert(msgs, data)
                    msgMap[data.Id] = true
                    local nextMsgs = this.GetNextEventReportData(eventData.ID, outputProps)
                    for i = 1, #nextMsgs do
                        local nextData = nextMsgs[i]
                        if nextData ~= nil and msgMap[nextData.Id] ~= true then
                            table.insert(msgs, nextData)
                            msgMap[nextData.Id] = true
                        end
                    end
                end
            end
            if NumTool.GetLen(msgs) > 0 then
                this.ReportActivateObjData(msgs, callback2)
            else
                callback2()
            end
        end
        local outputItems = {}
        for key, value in pairs(outputProps) do
            outputItems[key] = value
        end

        this.ReportPropsData(outputItems, nil, callback1)
    end

    this.BuildPendingFinishEventMap = function(curEventID, pendingFinishEventIDs)
        local finishMap = {}
        if curEventID ~= nil then
            finishMap[curEventID] = true
        end
        if type(pendingFinishEventIDs) == "table" then
            for i = 1, #pendingFinishEventIDs do
                finishMap[pendingFinishEventIDs[i]] = true
            end
        end
        return finishMap
    end

    this.IsEventPreEventsFinish = function(eventID, pendingFinishMap)
        local chapterData = JZQWGameData.GetChapterData()
        if chapterData == nil or type(chapterData.EventList) ~= "table" then
            return true
        end
        local hasPreEvent = false
        for i = 1, #chapterData.EventList do
            local eventData = chapterData.EventList[i]
            local nextEvents = eventData.Config.NextEvent
            if type(nextEvents) == "table" then
                for j = 1, #nextEvents do
                    if nextEvents[j] == eventID then
                        hasPreEvent = true
                        if eventData.Status ~= JZQWConst.EventStatus.Finish and (pendingFinishMap == nil or pendingFinishMap[eventData.ID] ~= true) then
                            return false
                        end
                    end
                end
            end
        end
        return hasPreEvent
    end

    this.IsEventTriggerComplete = function(eventData, pendingItems, pendingFinishMap)
        if eventData == nil then
            return false
        end
        if this.IsEventPreEventsFinish(eventData.ID, pendingFinishMap) == false then
            return false
        end
        local triggerItems = eventData.Config.TriggerItem
        if type(triggerItems) ~= "table" or #triggerItems <= 0 then
            return true
        end
        for i = 1, #triggerItems do
            local item = triggerItems[i]
            local propsData = JZQWGameData.GetPropsDataByID(item.id)
            local pendingCount = pendingItems ~= nil and (tonumber(pendingItems[item.id]) or 0) or 0
            if (propsData == nil or propsData.IsOwner ~= true) and pendingCount <= 0 then
                return false
            end
        end
        return true
    end

    this.GetNextEventReportData = function(curEventID, pendingItems, pendingFinishEventIDs)
        local curEventData = JZQWGameData.GetEventDataByID(curEventID)
        if curEventData == nil then
            return {}
        end
        local pendingFinishMap = this.BuildPendingFinishEventMap(curEventID, pendingFinishEventIDs)
        local msgs = {}
        for key, eventID in pairs(curEventData.Config.NextEvent) do
            local eventData = JZQWGameData.GetEventDataByID(eventID)
            if (eventData == nil or eventData.Status <= 0) and this.IsEventTriggerComplete(eventData, pendingItems, pendingFinishMap) == true then
                local data1 = {}
                data1.Id = eventID
                data1.Typ = JZQWConst.DataReportType.Event
                data1.State = JZQWConst.EventStatus.Unlock
                table.insert(msgs, #msgs + 1, data1)
            end
        end
        return msgs
    end
end

return JZQWGameSceneInteract