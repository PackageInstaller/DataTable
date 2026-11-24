local objs = {
    closeBtn = {path = "root/btnMask", type = "Button"},
    maskBtn = {path = "root/Middle/CloseBtn", type = "Button"}
}

local data = {
    contentList = {{descText = ""}}
}

local this = {}


this.before_awake = function()
end

this.before_active = function()
    local misinterBulletinDatas = SeasonSLGEventMgr.GetMisinterBulletin(true)
    local datas = {}
    local tempData = {}
    for i = 1, #misinterBulletinDatas do
        tempData = {}
        tempData.descText = misinterBulletinDatas[i].desc
        table.insert(datas, tempData)
    end
    this.vm.data.contentList = datas
end

this.OnClickCloseBtn = function()
    LuaMgr.RemoveTimer(TimerConst.SeasonSLGMisinterNoticeTimer)
    LuaMgr.HidePanel(UIName.SeasonSlGMisinterAppearPopup)
end

local command = {}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.maskBtn, this.OnClickCloseBtn)
        LuaMgr.AddClick(this.closeBtn, this.OnClickCloseBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        LuaMgr.AddTimer(TimerConst.SeasonSLGMisinterNoticeTimer, this.OnClickCloseBtn, 5, 1, false);
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickCloseBtn)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickCloseBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)