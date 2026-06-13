local GamePlayExplainCtrl = BaseClass("GamePlayExplainCtrl", BaseUICtrl)
local M = GamePlayExplainCtrl

function M:Init()
    self._view.Mask:onClick(Bind(self, self.OnClickClose))
    self.uiStates = {}
    self.style02CurrentIndex = 1
    self.closeTime = 0
end

function M:OnClickClose()
    if self.timer then
        self.timer:Stop()
    end
    self.animator:Play("DormHelpPopup_Close")
    -- print("self.closeTime: " .. self.closeTime .. " time " .. CS.UnityEngine.Time.time)
    self.timer = TimerManager:GetInstance():GetTimer(self.closeTime, self.Close, self, true)
    self.timer:Start()
end

function M:OnEnter(id)
    -- if PlayerPrefabHelper.GetBool("GamePlayExplain"..id) and id then
    --     Logger.Log("GamePlayExplainId " .. id .. " Record: " .. tostring(PlayerPrefabHelper.GetBool("GamePlayExplain"..id)))
    -- end

    self.animator = self._view.DormHelpPopupAnimator
    local clips = self.animator.runtimeAnimatorController.animationClips
    -- print("clipInfos length " .. clips.Length)
    for i = 0, clips.Length - 1 do
        local clip = clips[i]
        if clip.name == "DormHelpPopup_Close" then
            -- print("set timeLength " .. clip.length)
            self.closeTime = clip.length
        end
    end

    if self.lastId == id then
        return
    end

    PlayerPrefabHelper.SetBool("GamePlayExplain" .. id, true)
    IRedPointMgr:ForceCheck(RedPointConst.GameTipsTeskChecker)

    self.lastId = id

    for i = 1, self._view.Display.childCount do
        self._view.Display:GetChild(i - 1).gameObject:SetActive(false)
    end
    local config = ConfigHelper.GetCfgByLua("explain", id)
    local func = self[config.templateType]
    if (func ~= nil and type(func) == "function") then
        func(self, config)
    end
end

function M:OnClose()
    if self.timer then
        self.timer:Stop()
    end
    print("closeTimeEnd" .. CS.UnityEngine.Time.time)

    self.animator = nil
    self.timer = nil
    self._view.Style01.BtnL:RemoveOnClick()
    self._view.Style01.BtnR:RemoveOnClick()
end

function M:WordPage(config)
    local style = self._view.Style03

    self._view.Style02.gameObject:SetActive(false)
    self._view.Style01.gameObject:SetActive(false)

    if config.pageText and #config.pageText >= 0 then
        style.Title:SetText(config.pageText[1])
        style.Desc:SetText(config.pageText[2])
    end

    style.gameObject:SetActive(true)
end

function M:NormalPage(config)
    local style = self._view.Style01

    self._view.Style02.gameObject:SetActive(false)
    self._view.Style03.gameObject:SetActive(false)

    local length = config.totalPage

    -- 处理页面
    style.ScrollView.listItem.transform:ClearChildren()

    if config.pageImage and #config.pageImage == length then
        for i = 1, length do
            local page = style.PageTemplate:Instantiate(style.ScrollView.listItem.transform)
            page.gameObject:SetActive(true)
            page:SetPic(config.imagePath .. config.pageImage[i])

            -- TODO: 待实现，暂时没有需求
            -- if config.pageText and #config.pageText >= i then
            -- end
        end
    end

    style.ScrollView:UpdateContent()

    -- 处理页下标
    if length > 1 then
        style.ToggleDots:SetLength(length)
        style.ToggleDots:SetIndex(0)

        style.ScrollView.enableDrag = true
    end

    style.gameObject:SetActive(true)
    -- style.BtnL:SetOnClick(self, self._PageLeft)
    -- style.BtnR:SetOnClick(self, self._PageRight)

    style.ScrollView.onChangePage = function(index)
        style.ToggleDots:SetIndex(index)
    end
end

function M:VideoPage(config)
    local style = self._view.Style02

    self._view.Style01.gameObject:SetActive(false)
    self._view.Style03.gameObject:SetActive(false)
    local length = config.totalPage

    -- 处理页面
    style.TabGroup.transform:ClearChildren()

    -- 处理页下标
    if config.pageImage and (#config.pageImage == length) and config.pageText and (#config.pageText == length) then
        for i = 1, length do
            local tab = CS.UnityEngine.GameObject.Instantiate(style.TabTemplate.gameObject, style.TabGroup.transform)
            tab:SetActive(true)
            tab:onClick(
                function(g)
                    -- CS.UnityEngine.Debug.Log("-->" .. self.style02CurrentIndex)
                    local n = tonumber(g.name)
                    self:ToggleUIStateOn(n)
                    if not (self.style02CurrentIndex == n) then
                        -- CS.UnityEngine.Debug.Log("-->" .. config.imagePath .. config.pageImage[n])
                        style.Video:Play(config.imagePath .. config.pageImage[n])
                    end
                    self.style02CurrentIndex = n
                    -- CS.UnityEngine.Debug.Log("-->" .. n)
                end
            )
            tab.name = tostring(i)
            local state = tab:GetComponent(typeof(CS.UIState))
            table.insert(self.uiStates, state)
            state.texts[0]:SetText(ConfigHelper.GetLocalString(tonumber(config.pageText[i])))
            -- CS.UnityEngine.Debug.Log(state.texts[0].text)
            -- CS.UnityEngine.Debug.Log("-->" .. tonumber(config.pageText[i]))
            -- CS.UnityEngine.Debug.Log("-->" .. ConfigHelper.GetLocalString(tonumber(config.pageText[i])))
        end

        self:ToggleUIStateOn(1)
    end

    -- CS.UnityEngine.Debug.Log("-->"..config.pageText)

    style.TabGroup.gameObject:SetActive(not (length == 0))

    style.gameObject:SetActive(true)
    style.Video:Play(config.imagePath .. config.pageImage[1])
end

function M:ToggleUIStateOn(index)
    for i = 1, #self.uiStates do
        if index == i then
            self.uiStates[i]:SetState(2)
        else
            self.uiStates[i]:SetState(1)
        end
        self.uiStates[i].imgs[0].enabled = false
        self.uiStates[i].imgs[1].enabled = false
    end

    self.uiStates[1].imgs[0].enabled = true
    self.uiStates[#self.uiStates].imgs[1].enabled = true
end

-- function M:_PageLeft()
--     local style = self._view.Style01
--     local n = style.ToggleDots.currentIndex - 1
--     if n < 0 then
--         n = 0
--     end
--     style.ToggleDots:SetIndex(n)
-- end

-- function M:_PageRight()
--     local style = self._view.Style01
--     local n = style.ToggleDots.currentIndex + 1
--     if n >= style.ToggleDots.total then
--         n = style.ToggleDots.total - 1
--     end
--     style.ToggleDots:SetIndex(n)
-- end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    if self._view and self._view.Style01 and self._view.Style01.ScrollView then
        self._view.Style01:OnDispose()
    end
    M.super.OnDispose(self)
end

return GamePlayExplainCtrl
