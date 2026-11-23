




local HEAD_ICON_PATH = "Assets/_BundleResources/Character/"
local maxTopPos = Vector3(0,227,0)
local minTopPos = Vector3(0,156,0)
local maxBottomPos = Vector3(-188,-280,0)
local minBottomPos = Vector3(-188,-230,0)
local maxSpacing = Vector2(70,55)
local minSpacing = Vector2(20,0)
local maxCellSize = Vector2(240,168)
local minCellSize = Vector2(300,210)
local dataInfo = nil
local isPlayCloseAnim = false
local this = {vm = nil}

local data = {
    topPos = Vector3.zero,
    bottomPos = Vector3.zero,
    gridCellSize = Vector2.zero,
    gridSpacing = Vector2.zero,
    itemList = {{headIcon = DefaultTexture,beforeLevel = "",currentLevel = "", animName = "UI_FriendlyUpgradePanel_HeadItem_01"}},
    rootAnimName = "UI_FriendlyUpgradePanel_01",
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.PlayCloseAnim()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        dataInfo = this.vm.behaviour.Params[0]
        dataInfo = json.decode(dataInfo)
        this.InitView()
        this.InitItem()
        isPlayCloseAnim = false
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        dataInfo = nil
        LuaMgr.RemoveTimer(TimerConst.FriendlyCloseTime)
        LuaMgr.RemoveTimer(TimerConst.MissionEndFriendlyUpgradeCloseTimePointMove)
    end,
}

this.InitView = function()
    this.vm.data.topPos = #dataInfo > 3 and maxTopPos or minTopPos
    this.vm.data.bottomPos = #dataInfo > 3 and maxBottomPos or minBottomPos
    this.vm.data.gridCellSize = #dataInfo > 3 and maxCellSize or minCellSize
    this.vm.data.gridSpacing = #dataInfo > 3 and maxSpacing or minSpacing
end
this.InitItem = function()
    local tempList = {}
    local value = nil
    for i = 1, #dataInfo do
        value = dataInfo[i]
        if value.IsLevelUp then
            local tempItem = {headIcon = LuaMgr.GetTexture(HEAD_ICON_PATH..value.ID.."/Avatar/"..DataHelper.GetCharacterSkin(value.ID)..".png"),
                              beforeLevel = this.GetLevelText(value.OrigLevel),currentLevel = this.GetLevelText(value.Level),
                              animName = "UI_FriendlyUpgradePanel_HeadItem_01"}
            table.insert(tempList,tempItem)
        end
    end
    this.vm.data.itemList = tempList
    LuaMgr.AddTimer(TimerConst.FriendlyCloseTime,function()
        this.PlayCloseAnim()
    end,1.5,1,false)
end

this.PlayCloseAnim = function ()
    if isPlayCloseAnim then
        return
    end
    isPlayCloseAnim = true
    this.vm.data.rootAnimName = "UI_FriendlyUpgradePanel_02"
    for index, value in ipairs(this.vm.data.itemList) do
        value.animName = "UI_FriendlyUpgradePanel_HeadItem_01_end"
    end
    LuaMgr.AddTimer(TimerConst.FriendlyUpgradeCloseTime,function()
        LuaMgr.HidePanel(UIName.FriendlyUpgradeViewModel)
    end,1,1,false)
end
this.GetLevelText = function(level)
    if level == 1 then return LuaMgr.GetLangText("FriendlyUpgradeViewModel_0") end
    if level == 2 then return LuaMgr.GetLangText("FriendlyUpgradeViewModel_1") end
    if level == 3 then return LuaMgr.GetLangText("FriendlyUpgradeViewModel_2") end
    if level == 4 then return LuaMgr.GetLangText("FriendlyUpgradeViewModel_3") end
    if level == 5 then return LuaMgr.GetLangText("FriendlyUpgradeViewModel_4") end
    if level == 6 then return LuaMgr.GetLangText("FriendlyUpgradeViewModel_5") end
    if level == 7 then return LuaMgr.GetLangText("FriendlyUpgradeViewModel_6") end
    if level == 8 then return LuaMgr.GetLangText("FriendlyUpgradeViewModel_7") end
    if level == 9 then return LuaMgr.GetLangText("FriendlyUpgradeViewModel_8") end
    if level == 10 then return LuaMgr.GetLangText("FriendlyUpgradeViewModel_9") end
    return "";
end
return vm({
    data = data,
    command = command,
    hook = hook
})