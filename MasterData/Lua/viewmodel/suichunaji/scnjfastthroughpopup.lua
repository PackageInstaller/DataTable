local objs = {
    leftBtn = {path = "root/Middle/LeftBtn", type = UITool.Button},
    rightBtn = {path = "root/Middle/RightBtn", type = UITool.Button},
    subBtn = {path = "root/Middle/SubBtn", type = UITool.Button},
    addBtn = {path = "root/Middle/AddBtn", type = UITool.Button},
    maxBtn = {path = "root/Middle/MaxBtn", type = UITool.Button},
    inputField = {path = "root/Middle/InputField", type = UITool.InputField},
    maxScore = {path = "root/Middle/MaxScore", type = UITool.Text},
    scorePreview = {path = "root/Middle/ScorePreview", type = UITool.Text},
    fireWorkCount = {path = "root/Middle/FastThroughCount", type = UITool.Text}
}

local this = {}

this.before_awake = function()
    this.inputField.onEndEdit:AddListener(this.OnInputChange)
end

this.before_active = function()
    SCNJData.SetOldTotleScore()
    this.inputField.text = "0"
    local dailyCount, maxCount = SCNJData.GetChallengeCount()
    this.fireWorkCount.text = string.format("<color=#C03A00>%d</color>/%d", dailyCount, maxCount)
    this.remainCount = maxCount - dailyCount
    this.curSelectCount = 0
    local maxScoreLan = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29613")
    this.maxScore.text = string.format(maxScoreLan, this.paramData.maxScore)
end

this.OnClose = function()
    LuaMgr.HidePanel(UIName.SCNJFastThroughPopup)
end

this.OnClickLeftBtn = function()
    this.OnClose()
end

this.OnClickRightBtn = function()
    if this.curSelectCount == 0 then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29607")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    this.OnClose()
    if this.paramData.OnConfirmCallback then
        this.paramData.OnConfirmCallback(this.curSelectCount)
    end
end

this.OnClickSubBtn = function()
    local tempCount = this.curSelectCount - 1
    tempCount = math.max(tempCount, 0)
    this.curSelectCount = tempCount
    this.inputField.text = tostring(this.curSelectCount)
    this.RefreshPreScrore()
end

this.OnClickAddBtn = function()
    local tempCount = this.curSelectCount + 1
    tempCount = math.min(tempCount, this.remainCount)
    this.curSelectCount = tempCount
    this.inputField.text = tostring(this.curSelectCount)
    this.RefreshPreScrore()
end

this.OnClickMaxBtn = function()
    this.curSelectCount = this.remainCount
    this.inputField.text = tostring(this.curSelectCount)
    this.RefreshPreScrore()
end

this.RefreshPreScrore = function()
    this.scorePreview.text = tostring(this.curSelectCount * this.paramData.maxScore)
end

this.OnInputChange = function(value)
    local tempCount = tonumber(value) or 0
    tempCount = math.min(tempCount, this.remainCount)
    tempCount = math.max(tempCount, 0)
    this.curSelectCount = tempCount
    this.inputField.text = tostring(this.curSelectCount)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.leftBtn, this.OnClickLeftBtn)
        LuaMgr.AddClick(this.rightBtn, this.OnClickRightBtn)
        LuaMgr.AddClick(this.subBtn, this.OnClickSubBtn)
        LuaMgr.AddClick(this.addBtn, this.OnClickAddBtn)
        LuaMgr.AddClick(this.maxBtn, this.OnClickMaxBtn)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length < 1 then
            return
        end
        this.paramData = vm.behaviour.Params[0]
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.leftBtn, this.OnClickLeftBtn)
        LuaMgr.RemoveClick(this.rightBtn, this.OnClickRightBtn)
        LuaMgr.RemoveClick(this.subBtn, this.OnClickSubBtn)
        LuaMgr.RemoveClick(this.addBtn, this.OnClickAddBtn)
        LuaMgr.RemoveClick(this.maxBtn, this.OnClickMaxBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)