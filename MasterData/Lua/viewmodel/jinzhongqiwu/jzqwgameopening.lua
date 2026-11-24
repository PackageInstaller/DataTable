JZQWGameOpening = JZQWGameOpening or {}

JZQWGameOpening.Bind = function(this)
    this.SetNovelAnimPanel = function(id, showIntroBeforeNovel)
        SetActive(this.novelMask, false)
        SetActive(this.introAnimObj, false)
        SetActive(this.introAnimObj2, false)
        this.introAnimClickCallback = nil
        local novelData = JZQWGameData.GetGameNovelData(id)
        if novelData == nil then
            return
        end
        local novelID = novelData.NarrativeId
        if type(novelID) ~= "string" or novelID == "" then
            novelID = "E047001"
        end

        local reportNovelData = function()
            local data = {}
            data.Id = novelData.Id
            data.Typ = JZQWConst.DataReportType.Novel
            data.State = 1
            local msgs = { data }
            this.ReportActivateObjData(msgs)
        end

        local showIntroAnim = function(callback)
            if this.topBarComp == nil then
                local topBarObj = UnityEngine.GameObject.Find("UIRoot(Clone)/Fixed")
                this.topBarComp = topBarObj
            end
            this.introAnimClickCallback = callback
            SetActive(this.topBarComp, false)
            if (showIntroBeforeNovel) then
                SetActive(this.introAnimObj2, true)
                local softText = LuaMgr.GetLangText(novelData.ContentTextLan)
                this.introAnimDesc2.text = softText
            else
                SetActive(this.introAnimObj, true)
                this.introAnimDesc.text = LuaMgr.GetLangText(novelData.ContentTextLan)
            end
        end

        if showIntroBeforeNovel == true then
            local playNovelCallback = function()
                if LuaMgr.IsPanelOpen(UIName.JZQWHomePanel) then
                    SetActive(this.novelMask, false)
                end
                reportNovelData()
                LuaMgr.ShowLuaPanel(UIName.JZQWHomePanel);
            end
            local introAnimCallback = function()
                if LuaMgr.IsPanelOpen(UIName.JZQWGameOpening) then
                    SetActive(this.novelMask, true)
                end
                LuaMgr.PlayNovel(novelID, playNovelCallback)
            end
            showIntroAnim(introAnimCallback)
            return true
        end

        local novelIsFinish = DataHelper.CheckNovelComplete(novelID)
        if novelIsFinish == false then
            SetActive(this.introAnimObj, false)
            if LuaMgr.IsPanelOpen(UIName.JZQWGameOpening) then
                SetActive(this.novelMask, true)
            end
            local callback = function()
                LuaMgr.Back()
            end
            LuaMgr.PlayNovel(novelID, callback)
            return
        end
        showIntroAnim()
        reportNovelData()
    end

    this.OnClickIntroBtn = function()
        local introAnimClickCallback = this.introAnimClickCallback
        this.introAnimClickCallback = nil
        SetActive(this.introAnimObj, false)
        SetActive(this.topBarComp, true)
        if introAnimClickCallback ~= nil then
            introAnimClickCallback()
        end
    end
end

return JZQWGameOpening