JZQWGameGuide = JZQWGameGuide or {}

JZQWGameGuide.Bind = function(this)
    this.RefreshTask = function()
        local goalDatas = JZQWGameData.GetChapterGoal()
        for i = 1, 3 do
            local name = "Goal" .. i
            local name1 = "GoalText" .. i
            local data = goalDatas[i]
            SetActive(this[name], data ~= nil)
            if data ~= nil then
                this[name1].text = LuaMgr.GetLangText(data.Config.GoalDescLan)
            end
        end
    end

    this.GetActivateItemByID = function(id)
        if type(this.activateItems) ~= "table" then
            return nil
        end
        for i = 1, #this.activateItems do
            local item = this.activateItems[i]
            if item ~= nil and item.data ~= nil and item.data.ID == id then
                return item
            end
        end
        return nil
    end

    this.GetGuideTargetViewportBounds = function(guideTarget)
        local activateItem = this.GetActivateItemByID(guideTarget)
        if activateItem == nil or activateItem.rectTrans == nil or this.dragBehaviour == nil or this.dragBehaviour.viewport == nil then
            return nil, nil
        end
        local pos = RectTransformTool.ToContainer(activateItem.rectTrans, this.dragBehaviour.viewport, LuaMgr.UICamera())
        local sizeX, _ = activateItem:GetRealSize()
        return pos.x - sizeX / 2, pos.x + sizeX / 2
    end

    this.GetGoalVisibleState = function(goalDatas)
        local viewport = this.dragBehaviour and this.dragBehaviour.viewport or nil
        if viewport == nil then
            return false, false, false
        end
        local leftBound = viewport.rect.xMin
        local rightBound = viewport.rect.xMax
        local hasGoal = false
        local hasLeftGoal = false
        local hasRightGoal = false
        for i = 1, #goalDatas do
            local goalData = goalDatas[i]
            if goalData.Config.GuideSence == this.sceneID then
                local targetLeft, targetRight = this.GetGuideTargetViewportBounds(goalData.Config.GuideTarget)
                if targetLeft ~= nil and targetRight ~= nil then
                    hasGoal = true
                    if targetRight < leftBound then
                        hasLeftGoal = true
                    end
                    if targetLeft > rightBound then
                        hasRightGoal = true
                    end
                end
            end
        end
        if hasGoal == false then
            return false, false, hasGoal
        end
        return hasLeftGoal, hasRightGoal, hasGoal
    end

    this.OnTipTimer = function()
        if this.CheckStopChapterGuideTimers ~= nil and this.CheckStopChapterGuideTimers() == true then
            return
        end
        this.curWaitTime = this.curWaitTime + 1
        if this.curWaitTime >= JZQWConst.TipsWaitTime then
            local goalDatas = JZQWGameData.GetChapterGoal()
            local viewport = this.dragBehaviour and this.dragBehaviour.viewport or nil
            if viewport == nil then
                SetActive(this.leftTipBtn.gameObject, false)
                SetActive(this.rightTipBtn.gameObject, false)
                return
            end

            local showLeft, showRight, hasGoal = this.GetGoalVisibleState(goalDatas)
            if hasGoal == false then
                SetActive(this.leftTipBtn.gameObject, false)
                SetActive(this.rightTipBtn.gameObject, false)
                return
            end

            SetActive(this.leftTipBtn.gameObject, showLeft)
            SetActive(this.rightTipBtn.gameObject, showRight)
        end
    end

    this.OnClickLeftTipBtn = function()
        this.curWaitTime = 0
        this.dragBehaviour.horizontalNormalizedPosition = 0
        SetActive(this.leftTipBtn.gameObject, false)
        SetActive(this.rightTipBtn.gameObject, false)
    end

    this.OnClickRightTipBtn = function()
        this.curWaitTime = 0
        this.dragBehaviour.horizontalNormalizedPosition = 1
        SetActive(this.leftTipBtn.gameObject, false)
        SetActive(this.rightTipBtn.gameObject, false)
    end

    this.SetActivateArrowVis = function(visible)
        if this.lasSetArrowVisObj ~= nil then
            this.lasSetArrowVisObj:SetArrowVisible(visible)
            if visible == true then
                this.lasSetArrowVisObj = nil
            end
        end
    end
end

return JZQWGameGuide