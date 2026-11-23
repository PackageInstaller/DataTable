require("ViewModel/Management/ViewItem/HardDelegatedItem")

local objs = {
    rewardItem = {path = "template/ItemParent", type = UITool.GameObject}
}

local this = {

    passItems = {}
}

this.before_awake = function()
end

this.before_active = function()
    local datas = ManagementData.GetHardDelegatedData().configList
    for i = 1, #this.passItems do
        local item = this.passItems[i]
        local data = datas[i]
        item:SetData(data)
    end
end



this.OnClickPassBtn = function(item)
    local data = item.data
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = data.id
    enterDungeonParams.dungeonId = data.eventParam
    BattlePrepareMgr.BattlePrepare(enterDungeonParams)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        for i = 1, 3 do
            local name = "Pass" .. i
            local data = {}
            data.path = string.format("root/Middle/PassParent/Pass%d", i)
            data.type = UITool.GameObject
            objs[name] = data
        end
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        for i = 1, 3 do
            local name = "Pass" .. i
            local obj = this[name]
            local item = HardDelegatedItem.New(obj, this.OnClickPassBtn, this.rewardItem)
            table.insert(this.passItems, #this.passItems + 1, item)
        end
        this.before_awake()
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
        for key, value in pairs(this.passItems) do
            value:Destroy()
        end
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)