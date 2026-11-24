JZQWGameChapterFlow = JZQWGameChapterFlow or {}

JZQWGameChapterFlow.Bind = function(this)
    this.CheckChapterEnd = function()
        local chapterData = JZQWGameData.GetChapterData()
        if chapterData == nil or chapterData.LastEvent.Status ~= JZQWConst.EventStatus.Finish then
            return
        end
        this.StopChapterGuideTimers()
        local msgs = this.GetChapterEndReportData(chapterData)
        local callback = function()
            this.PlayChapterEndFlow(chapterData)
        end
        this.ReportActivateObjData(msgs, callback)
    end

    this.CheckChapteEnd = function()
        this.CheckChapterEnd()
    end

    this.GetChapterEndReportData = function(chapterData)
        local msgs = {}
        local data = {}
        data.Id = chapterData.ID
        data.Typ = JZQWConst.DataReportType.Chapter
        data.State = JZQWConst.EventStatus.Finish
        table.insert(msgs, data)

        if this.IsFinalChapter(chapterData) == false and type(chapterData.Config.NextChapter) == "string" and chapterData.Config.NextChapter ~= "" then
            local data1 = {}
            data1.Id = chapterData.Config.NextChapter
            data1.Typ = JZQWConst.DataReportType.Chapter
            data1.State = JZQWConst.EventStatus.Unlock
            table.insert(msgs, data1)

            local tempMsgs = this.GetNextEventReportData(chapterData.LastEvent.ID)
            for key, value in pairs(tempMsgs) do
                table.insert(msgs, value)
            end
        end
        return msgs
    end

    this.IsFinalChapter = function(chapterData)
        return chapterData ~= nil and tonumber(chapterData.Config.FinalChapter) == 1

    end

    this.PlayChapterEndFlow = function(chapterData)
        this.fadeObj.enabled = true
        SetActive(this.fadeObj.gameObject, true)
        if this.tweenSquence ~= nil then
            this.tweenSquence:Kill()
        end
        this.tweenSquence = DOTWeen:Sequence()
        local callBack = function()
            this.fadeObj.enabled = false
            SetActive(this.fadeObj.gameObject, false)
            if this.IsFinalChapter(chapterData) == true and chapterData ~= nil and chapterData.Status == JZQWConst.ChapterStatus.Finish then
                this.PlayFinalChapterFlow(chapterData)
            else
                this.BackToGameHome()
            end
        end
        this.tweenSquence:AppendInterval(0.5):OnComplete(callBack)
    end

    this.PlayFinalChapterFlow = function(chapterData)
        local handled = this.SetNovelAnimPanel(JZQWConst.FinalManifestoID, true)
        if handled ~= true then
            this.BackToGameHome()
        end
    end

    this.BackToGameHome = function()
        JZQWData.SetIsChildPanel(true)
        LuaMgr.ShowLuaPanel(UIName.JZQWHomePanel)
    end
end

return JZQWGameChapterFlow