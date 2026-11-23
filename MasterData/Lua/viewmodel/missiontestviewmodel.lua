local this = {};


local jobDropDownTr = nil
local nameDropdownTr = nil
local selectMonsterJob = 1
local selectMonsterID = ""
local selectMonsterCount = 1
local monsterList = {}

local data = {
   
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.MissionTestViewModel);
        end
    },


    OnClickSelectMonsterJob = {
        type = XLuaCommandType.Int,
        execute = function(vm, value, param)
            this.SetSelectMonsterJob(value + 1)
        end
    },


    OnClickSelectMonsterName = {
        type = XLuaCommandType.Int,
        execute = function(vm, value, param)
            selectMonsterID = monsterList[selectMonsterJob][value + 1].id
        end
    },


    OnInputKillMonsterCount = {
        type = XLuaCommandType.String,
        execute = function(vm, value)
            selectMonsterCount = value
        end
    },


    OnClickSelectConfirm = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local data = {
                MonsterID = selectMonsterID,
                Count = tonumber(selectMonsterCount)
            }
            ApiMgr.Request("admin/kill_enemy", data, true, function(data)
                LuaMgr.InvokeUIEventListeners(UIEventConst.MissionGmRefresh)
            end, nil, true)
        end
    }
}



this.SetKillMonsterGM = function()
    jobDropDownTr = this.vm.behaviour.transform:Find("root/Middle/KillMonster/JobDropdown")
    nameDropdownTr = this.vm.behaviour.transform:Find("root/Middle/KillMonster/NameDropdown")

    monsterList = {}
    for k, monster in pairs(ConfigMgr.Config.monsterMap) do
        if monsterList[monster.job] == nil then
            monsterList[monster.job] = {}
        end
        table.insert(monsterList[monster.job], monster)
    end

    local jobList = {}
    for k, v in pairs(monsterList) do
        table.insert(jobList, k)
    end
    LuaMgr.BindDropdownList(jobDropDownTr, jobList)
    
    this.SetSelectMonsterJob(selectMonsterJob)
end

this.SetSelectMonsterJob = function(value)
    selectMonsterJob = value

    local nameList = {}
    for i, monster in ipairs(monsterList[selectMonsterJob]) do
        if selectMonsterID == nil or selectMonsterID == "" then
            selectMonsterID = monster.id
        end
        table.insert(nameList, LuaMgr.GetLangText(monster.NameLan))
    end
    LuaMgr.BindDropdownList(nameDropdownTr, nameList)
end

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.SetKillMonsterGM()
            
        end
    end,
    before_deactive = function(vm)
       
    end,
}

return vm({
    data = data,
    command = command,
    hook = hook
})