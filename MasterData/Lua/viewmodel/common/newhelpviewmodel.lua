




require("ViewModel/Common/NewHelpItem")
require("ViewModel/Common/NewHelpIntroItem")

local this = {
    vm = nil,helpScrollCenter = nil,
    helpItemList = nil,helpItemObj = nil,helpItemParent = nil,
    helpIntroItemObj = nil,guideUnit = nil,
}

local data = {
    leftShow = false, rightShow = false,aniName = "",
}

local command = {
    maskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.NewHelpViewModel)
            if not TableIsNull(this.guideUnit) and this.guideUnit.ClickAny == 1 then
                this.guideUnit = nil
                LuaMgr.GuideManagerNext()
            end
        end
    },
    leftCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.helpScrollCenter:ToLeft()
        end
    },
    rightCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.helpScrollCenter:ToRight()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.helpItemObj = vm.behaviour.transform:Find("template/NewHelpItem").gameObject
        this.helpIntroItemObj = vm.behaviour.transform:Find("template/NewHelpIntroItem").gameObject
        this.helpItemParent = vm.behaviour.transform:Find("root/Middle/Content/Scroll/Viewport/Content").transform
        this.helpScrollCenter = vm.behaviour.transform:Find("root/Middle/Content/Scroll"):GetComponent("ScrollChildrenCenter")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        aniName = ""
        aniName = "ani_ui_NewHelpPanel_enter"
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        this.ClearHelpItem()
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length <= 0 then
       return 
    end
    local firstHelps = nil
    if this.vm.behaviour.Params.Length == 1 then
        firstHelps = json.decode(this.vm.behaviour.Params[0])
    elseif this.vm.behaviour.Params.Length == 2 then

        this.guideUnit = json.decode(this.vm.behaviour.Params[0])
        firstHelps = NumTool.split(this.guideUnit.Data,",")
    end
    if TableIsNull(firstHelps) then
        return
    end
    this.SetHelpItem(firstHelps)
end

this.SetHelpItem = function(firstHelps)
    if TableIsNull(ConfigMgr.Config.GuidePictures) then
        return
    end
    if TableIsNull(this.helpItemList) then
        this.helpItemList = {}
    end
    local helpItem = nil
    local guideConfig = nil
    local length = #firstHelps
    for i = 1, length do
        guideConfig = this.GetGuideConfig(firstHelps[i])
        if not TableIsNull(guideConfig) then
            if #this.helpItemList < i then
                helpItem = NewHelpItem.New(this.helpItemObj,this.helpItemParent)
                table.insert(this.helpItemList,helpItem)
            end
            this.helpItemList[i]:SetData(guideConfig,this.helpIntroItemObj)
        end
    end
    for i = length + 1, #this.helpItemList do
        this.helpItemList[i]:Clear()
    end
    this.helpScrollCenter:InitPageArray(length, false)
    if this.helpScrollCenter.scrollEndCallback == nil then
        this.helpScrollCenter.scrollEndCallback = this.OnScrollEndCallback
    end
    this.helpScrollCenter:ResetPosition(0)
end

this.OnScrollEndCallback = function()
    local tempIndex = this.helpScrollCenter.GetCurrentPage + 1
    this.vm.data.leftShow = this.helpScrollCenter.GetAllPage > 1 and tempIndex > 1
    this.vm.data.rightShow = this.helpScrollCenter.GetAllPage > 1 and tempIndex < this.helpScrollCenter.GetAllPage
end

this.GetGuideConfig = function(id)
    for i = 1, #ConfigMgr.Config.GuidePictures do
        if ConfigMgr.Config.GuidePictures[i].Id == id then
            return ConfigMgr.Config.GuidePictures[i]
        end
    end
    return nil
end

this.ClearHelpItem = function()
    if TableIsNull(this.helpItemList) then
        return
    end
    for i = 1, #this.helpItemList do
        this.helpItemList[i]:Clear()
        this.helpItemList[i]:Destroy()
    end
    this.helpItemList = nil
end

return vm({
    data = data,
    command = command,
    hook = hook
})