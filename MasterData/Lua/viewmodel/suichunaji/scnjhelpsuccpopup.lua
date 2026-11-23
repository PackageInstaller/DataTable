local objs = {
    maskCloseBtn = {path = "root/Mask", type = UITool.Button},
    curHelpFireNum = {path = "root/Middle/CurHelpFireNum", type = UITool.Text}
}

local this = {}

this.before_awake = function()
end

this.BatchInitNode = function()
    for i = 1, 2 do
        local beforeName = "UpBefore" .. i
        local path = string.format("root/Middle/Addition%d/Before", i)
        objs[beforeName] = {path = path, type = UITool.Text}

        local afterName = "UpAfter" .. i
        local path = string.format("root/Middle/Addition%d/Arrow/After", i)
        objs[afterName] = {path = path, type = UITool.Text}

        local arrowObj = "Arrow" .. i
        local path = string.format("root/Middle/Addition%d/Arrow", i)
        objs[arrowObj] = {path = path, type = UITool.GameObject}
    end
end

this.before_active = function()
    local oldHelpLevel = SCNJData.GetOldHelpLevel()
    local oldHelpScore = SCNJData.GetOldHelpScore()
    local newHelpLevel, _, newHelpScore = SCNJData.GetCurHelpLevel()
    local deltaScore = newHelpScore - oldHelpScore
    this.curHelpFireNum.text = tostring(deltaScore)
    SCNJData.SetOldHelpScore()
    local oldAdditions, _oldAdditions = SCNJData.GetHelpAddition(oldHelpLevel)
    local newAdditions, newAdditionDic = SCNJData.GetHelpAddition(newHelpLevel)
    for i = 1, 2 do
        local beforeName = "UpBefore" .. i
        local afterName = "UpAfter" .. i
        local arrowObj = "Arrow" .. i
        SetActive(this[arrowObj], oldHelpLevel < newHelpLevel)
        local oldAddition = oldAdditions[i]
        if oldAddition ~= nil then
            this[beforeName].text = string.format("%s", LuaMgr.GetLangText(oldAddition.DescLan))
        else
            this[beforeName].text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29538")
        end
        if oldHelpLevel < newHelpLevel then
            local newAddition = nil
            if oldAddition ~= nil then
                newAddition = newAdditionDic[oldAddition.TalentName]
            end

            if newAddition == nil then
                newAddition = newAdditions[i]
                SetActive(this[arrowObj], false)
                this[beforeName].text = string.format("%s", LuaMgr.GetLangText(newAddition.DescLan))
            else
                this[afterName].text = string.format("%s%%", tostring(newAddition.TalentNumber))
            end
        end
    end
end

this.OnClickCloseBtn = function()
    LuaMgr.HidePanel(UIName.SCNJHelpSuccPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.BatchInitNode()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.maskCloseBtn, this.OnClickCloseBtn)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.maskCloseBtn, this.OnClickCloseBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)