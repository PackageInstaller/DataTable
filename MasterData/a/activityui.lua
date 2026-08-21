local ActivityUI = {} -- class("ActivityUI")

-----@type MainPanel
local _holder

local _activityCfg = {
    --[GE.Activity.Passport] = {
    --    panelName = "StackPanel",
    --}
}

---@param mainPanel MainPanel
function ActivityUI.Init(mainPanel)
    _holder = mainPanel
end

function ActivityUI.ShowActivity()
    ActivityUI._checkActivityCommon()
end

function ActivityUI._checkActivityCommon()
    for index, v in pairs(_activityCfg) do
        local testVar = string.format("activity%02dLocalTest", index)           -- activity05LocalTest
        local useTestFuncName = string.format("useTestActivity%02dInfo", index) -- useTestActivity05Info
        local isOpenFuncName = string.format("isActivity%02dOpen", index)       -- isActivity05Open
        local canSeeFuncName = string.format("canSeeActivity%02d", index)       -- canSeeActivity05
        local canOpenFuncName = string.format("canOpenActivity%02d", index)     -- canOpenActivity05
        local activityBtnName = string.format("activity%02dBtn", index)         -- activity05Btn

        if Me[testVar] then
            local testFunc = Me[useTestFuncName]
            if testFunc then
                testFunc(Me)
            end
        end

        local showActivityBtn = false
        if Me[canSeeFuncName](Me) then
            if Me[isOpenFuncName](Me) then
                showActivityBtn = true
            else
                if Me[canOpenFuncName] then
                    local ok, res = Me[canOpenFuncName](Me)
                    if not ok and not res then
                        showActivityBtn = true
                    end
                end
            end
        end

        _holder[activityBtnName]:SetActive(showActivityBtn)

        if showActivityBtn then
            UICommonUtils.ResetButtonListener(_holder, _holder[activityBtnName].button, function ()
                UIMgr:popUI(v.panelName)
            end)
        end
    end
end

return ActivityUI