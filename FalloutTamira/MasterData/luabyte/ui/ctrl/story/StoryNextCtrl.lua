local M = BaseClass("StoryNextCtrl", require("UI.Ctrl.Story.BaseStoryCtrl"))
local StoryMgr = StoryDataMgr:GetInstance()
local CheckTbl = table.isNullOrEmpty
local StoryType = StoryConst.StoryType
local RspType = StoryConst.ResponseType
local CInput = CS.UnityEngine.Input

function M:Init()
    self.m_lineTransList = { self._view.rectLine1, self._view.rectLine2 }
    self.m_dialogTrans = self._view.txtDialogue.transform:rectTransform()
    self.m_dialogueEndHandler = Bind(self, self.OnDialogueComplete)
    self.m_kwGuideHandler = Bind(self, self._SetKeywordGuide)
    self.m_kwGuideTimer = nil
    self.m_dialogTween = nil
    self.m_lastStepIds = {}

    self._view.txtDialogue:SetOnClick(Bind(self, self.OnHrefWordClick))
    self._view.imgGuidePanel:onClick(Bind(self, self.OnGuideClick))
end

function M:OnDispose()
    self:_StopDialogTween()
    self:_StopKeywordGuide()
    self.m_dialogTrans = nil
    self.m_lastStepIds = nil
    self.m_lineTransList = nil
    self.m_kwGuideHandler = nil
    self.m_dialogueEndHandler = nil
    M.super.OnDispose(self)
end

function M:RefreshNextVisible(storyCfg)
    local isTalk = storyCfg.roleTalk > 0
    local mType, cmdType = storyCfg.storyType, storyCfg.commanderType
    local unSam, unBg = mType ~= StoryType.Sam, mType ~= StoryType.Background
    local isNone, isDlg = cmdType == RspType.None, cmdType == RspType.Selection -- 锵锵：选项类型保留对话
    local isLastStep = table.contains(self.m_lastStepIds, storyCfg.stepId)      -- 上一条配置是否是对话
    self:SetSamActive(not unSam)
    StoryHelper.SetActive(self._view.rectBlackPanel, not unBg)
    StoryHelper.SetActive(self._view.imgGuidePanel, not CheckTbl(storyCfg.guide))
    self:SetDialogueActive((isDlg and isLastStep) or (isTalk and isNone and unSam and unBg))
end

function M:ShowDialogue(storyCfg)
    self:_StopDialogTween()
    local fontSize, txtDlg = 38, self._view.txtDialogue
    local isHeadTalk = storyCfg.storyType == StoryType.HeadTalk
    txtDlg:SetText("")
    if isHeadTalk then fontSize = 34 end
    txtDlg:SetFontSize(fontSize)
    local width, num, content = self:_GetDialogueData(storyCfg.roleTalk)
    txtDlg:SetColorByColor(StoryConst.Color.WhiteOpacity)
    if isHeadTalk then width = 1325 end
    self.m_dialogTrans.sizeDelta = Vector2.New(width, self.m_dialogTrans.sizeDelta.y)

    local roleName = storyCfg.roleName
    local nameId = roleName and roleName[1] or 0
    if isHeadTalk then
        self._view.txtHeadName:SetText(nameId)
        self._view.txtHeadName:SetActive(nameId > 0)
        self._view.rectHeadDialogue:SetActive(true)
        self._view.imgHeadIcon:SetPic(storyCfg.miniHeadIcon)
        StoryHelper.SetActive(self._view.rectNameLine, false)
    else
        if nameId > 0 then
            self:_SetLineLayout(width)
            self._view.txtName:SetText(nameId)
            StoryHelper.SetActive(self._view.rectNameLine, true)
        else
            StoryHelper.SetActive(self._view.rectNameLine, false)
        end
        self._view.rectHeadDialogue:SetActive(false)
    end

    local showTime = num / StoryMgr:GetSpeed()
    if showTime > 0 then
        -- self.m_lastStepIds = storyCfg.nextStepId -- 小美：暂时关闭保留上一条对话
        self.m_dialogTween = txtDlg:SetDoText(content, showTime):SetTweenUpdate(true)
            :OnTweenComplete(self.m_dialogueEndHandler)
    end
end

function M:SetGuide(guide)
    if not CheckTbl(guide) then
        local heroId, dialogueId = guide[1], guide[2]
        self._view.imgGuideHero:SetAvatarIcon(heroId, RoleType.ERT_Hero, 1)
        self._view.txtGuideName:SetAvatarName(heroId, RoleType.ERT_Hero)
        self._view.imgGuidePanel:GetMaterial():SetFloat("_Silder", 0)
        self._view.txtGuideContent:SetText(dialogueId)
        self._view.rectGuideMark:SetActive(false)
    end
end

function M:ShowSamStory(roleTalk)
    self:_StopDialogTween()
    if roleTalk > 0 then
        local txtSam = self._view.txtSamDialogue
        txtSam:SetText("")
        local content = ConfigHelper.GetLocalStringByPlayerName(roleTalk)
        local showTime = string.utf8len(content) / StoryMgr:GetSpeed()
        self.m_dialogTween = txtSam:SetDoText(content, showTime):SetTweenUpdate(true)
            :OnTweenComplete(self.m_dialogueEndHandler)
    end
end

function M:ShowBlackStory(roleTalk)
    self:_StopDialogTween()
    if roleTalk > 0 then
        local isFast = StoryMgr:IsAutoOrFast()
        local delay = isFast and StoryMgr:GetDialogueShowTime() or 2
        local txtBlack = self._view.txtBlackDialogue
        local zeroAlphaColor = txtBlack:GetColor():ZeroAlpha()
        txtBlack:SetText(ConfigHelper.GetLocalStringByPlayerName(roleTalk))
        txtBlack:SetColorByColor(zeroAlphaColor)
        self.m_dialogTween = txtBlack:SetDoFade(1, delay, 17):SetTweenUpdate(true):OnTweenComplete(function()
            self.m_dialogTween = nil
            self:CheckVoice()
        end)
    end
end

function M:OnHrefWordClick(hrefName, centerX, centerY)
    if string.isNullOrEmpty(hrefName) then
        EventMgr:Broadcast(UIMessageNames.STORY_CALL_MAIN, "OnClickBackground")
    else
        self:_SetKeywordTips(hrefName, centerX, centerY + 2)
    end
end

function M:OnGuideClick()
    local mousePos = CInput.mousePosition
    local screenPoint = Vector2.New(mousePos.x, mousePos.y)
    if self._view.rectGuideMark:IsContainPoint(screenPoint) then
        self:OnHrefWordClick(ConfigHelper.GetLocalString(5200), -1000, -30)
        StoryHelper.SetActive(self._view.imgGuidePanel, false)
    end
end

function M:OnDialogueComplete()
    self.m_dialogTween = nil
    self._view.rectArrow:SetActive(true)
    if not CheckTbl(StoryMgr:GetStory().guide) then self:_StartKeywordGuide() end
    self:CheckVoice()
end

function M:NextStoryDialogue(storyCfg)
    if self.m_dialogTween then
        self.m_dialogTween:DoTweenComplete()

        local mType = storyCfg.storyType
        local content = ConfigHelper.GetLocalStringByPlayerName(storyCfg.roleTalk)
        if mType == StoryType.Background then
            self._view.txtBlackDialogue:SetText(content)
        elseif mType == StoryType.Sam then
            self._view.txtSamDialogue:SetText(content)
        else
            self._view.txtDialogue:SetText(content)
            StoryHelper.SetActive(self._view.rectArrow, true)
        end
    else
        StoryHelper.SetActive(self._view.rectArrow, false)
        StoryMgr:NextStory()
    end
end

function M:_SetKeywordTips(hrefName, centerX, centerY)
    local arr = string.split(hrefName, "|", 1)
    if arr and #arr >= 2 then
        local titleId, contentId = tonumber(arr[1]), tonumber(arr[2])
        local content = ConfigHelper.GetLocalStringByPlayerName(contentId)
        self._view.rectTips:Show(titleId, content, centerX, centerY)
    end
end

function M:_SetLineLayout(width)
    local lineWidth = width * 0.5 + 70
    for _, trans in ipairs(self.m_lineTransList) do
        trans.sizeDelta = Vector2.New(lineWidth, trans.sizeDelta.y)
    end
end

function M:_GetDialogueData(roleTalk)
    local content = ConfigHelper.GetLocalStringByPlayerName(roleTalk)
    local trimStr = string.replaceRichText(content)
    local limit, num = StoryConst.CharLimit, string.utf8len(trimStr)
    if num > limit then trimStr = string.utf8sub(trimStr, 1, limit) end
    return self._view.txtDialogue:GetTextWidth(trimStr) + 30, num, content
end

function M:_StartKeywordGuide()
    self.m_kwGuideTimer = TimerManager:GetInstance():GetTimer(0.2, self.m_kwGuideHandler, self, true, nil, true)
    self.m_kwGuideTimer:Start()
end

function M:_SetKeywordGuide()
    self:_StopKeywordGuide()
    local text = self._view.txtDialogue
    local guideMark = self._view.rectGuideMark
    guideMark:SetActive(true)
    local sizeDelta = text:GetRectSizeDelta()
    guideMark.parent:rectTransform():SetRectSizeDelta(sizeDelta.x, sizeDelta.y)
    local anchoredPos = text:GetTextAnchoredPosition()
    local size = text:GetTextSize()
    local newSize = Vector2.New(size.x + 20, size.y + 30)
    guideMark:SetRectLocalPos(anchoredPos.x, anchoredPos.y)
    guideMark.sizeDelta = newSize

    local pos = guideMark.transform.position
    local markRefTrans = self._view.rectGuideMarkRef.transform
    markRefTrans:SetPos(pos.x, pos.y, pos.z)
    local canvas = UIManager:GetInstance():canvasTransformNormal()
    local coord = GameHelper.GetTargetPos(markRefTrans, markRefTrans.parent:rectTransform(), canvas)
    local maskPos = Vector2.New(coord.x, coord.y)
    local matGuide = self._view.imgGuidePanel:GetMaterial()
    matGuide:SetFloat("_Scale", canvas.transform.localScale.x)
    matGuide:SetVector("_Center", maskPos)
    matGuide:SetFloat("_Silder", size.x / 2 + 20)
    matGuide:SetFloat("_Height", size.y / 2 + 20)
    matGuide:SetFloat("_Fillet", 0)
end

function M:_StopKeywordGuide()
    if self.m_kwGuideTimer then
        self.m_kwGuideTimer:Stop()
        self.m_kwGuideTimer = nil
    end
end

function M:_StopDialogTween()
    if self.m_dialogTween then
        self.m_dialogTween:TweenKill()
        self.m_dialogTween = nil
    end
end

function M:CloseKeyword()
    if self._view.rectTips:GetActive() then
        self._view.rectTips:Close()
        return true
    end
    return false
end

function M:SetDialogueActive(active)
    StoryHelper.SetActive(self._view.rectDialoguePanel, active)
end

function M:SetSamActive(active)
    StoryHelper.SetActive(self._view.rectSamPanel, active)
end

return M
