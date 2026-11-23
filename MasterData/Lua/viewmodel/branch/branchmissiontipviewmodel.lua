



local this = { vm = nil }
local data = {


    OpinionList = {
        {
            description = "",
            object = false,
            achieve = false,
            unAchieve = false,
            showLocks = false,
            achievetag = "",
            unAchieveTag = "",
            locks = false,
            showgoto = false
        }
    },
}
local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.BranchMissionTipViewModel)
        end
    },
    jumpstoLocks = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local tab = this.vm.data.OpinionList[param + 1]
            this.jumpstopanel(tab)
        end
    }

}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then

            this.InitOpintonShow()
        end
    end,
    before_deactive = function(vm)

    end
}

this.jumpstopanel = function(tab)
    if tab == nil then
        return
    end
    if tab.branche then
        LuaMgr.HidePanel(UIName.BranchMissionTipViewModel)
    elseif (not tab.branche) and (not tab.locks) then
        if tab.jumpid == nil then
            return
        end
        LuaMgr.SetAreaBattleType(BattleType.Area)
        local types = ConfigMgr.Config.dungeonMap[tab.jumpid].type
        BattlePrepareMgr.EnterBattlePrepare(tab.jumpid, tab.jumpid, types)
        LuaMgr.HidePanel(UIName.BranchMissionTipViewModel)
    end
end
this.InitOpintonShow = function()
    local dataTab = ComData.branchData.BooKLockCondition
    local OpinionList = {}
    local BattleLock = false
    for index, Tabvalue in ipairs(dataTab) do
        local showtexts
        if index == 1 then
            local res = string.gsub(LuaMgr.GetLangText(Tabvalue.value), "\n", "")
            showtexts = LuaMgr.GetLangText("BranchMissionViewModel_0") .. res
        else
            local UnlockId = ConfigMgr.Config.areaEvents[Tabvalue.jumpid].unlockParam
            BattleLock = DataMgr.Player.dungeonRecords[UnlockId] == nil or IsNullOrEmpty(DataMgr.Player.dungeonRecords[UnlockId].historyRating)
        end
        local optionton =        {
            description = (index == 1) and showtexts or Tabvalue.value,
            branche = (index == 1),
            object = true,
            achieve = Tabvalue.state,
            unAchieve = not Tabvalue.state,
            jumpid = Tabvalue.jumpid,
            locks = BattleLock,
            showgoto = not BattleLock,
            unAchieveTag = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2293"].NameLan),
            achievetag = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2294"].NameLan)
        }
        table.insert(OpinionList, optionton)
    end

    this.vm.data.OpinionList = OpinionList
end

return vm(
{
    data = data,
    command = command,
    hook = hook
}
)