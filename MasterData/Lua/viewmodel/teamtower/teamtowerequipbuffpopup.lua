require("ViewModel/TeamTower/TeamTowerSelectBuffItem")


local buffItem = nil
local buffRect = nil
local this =
{
    vm = nil,
    BuffScrollView = nil,
    canSelectBuffCount = 0,
    curSelectBuffItem = nil,
    curSelectEquippedBuffItem = nil,
}
local data =
{
    SelectBuffList = {{buffId = "",buffName = "",equip = false,buffIcon = DefaultSprite,buffBg = DefaultSprite,onClick = nil,select = false,get = true,notGet = false}},
    EquippedBuffList = {{buffId = "",buffName = "",equip = true,buffIcon = DefaultSprite,buffBg = DefaultSprite,onClick = nil,select = false,notEmpty = true}},
    btnEquipState =  false,
    btnUnequipState = false,
}

local objs =
{
    buffRect = { path = "root/Middle/SelectBuffObj/buffInfo", type = "Transform" },
}
local command = {
    CloseCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local equipIds = {}
            for i, v in ipairs(this.vm.data.EquippedBuffList) do
                table.insert(equipIds,v.buffId)
            end
            TeamTowerMgr.EquipBuff(equipIds)
            LuaMgr.HidePanel(UIName.TeamTowerEquipBuffPopUp)
        end
    },
    SelectCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SelectBuff()
        end
    },
    UnSelectCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.UnSelectBuff()
        end
    },
    OnClickSelectBuffItem =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local item = this.vm.data.SelectBuffList[param + 1]
            this.OnClickBuffItem(item)
        end
    },
    OnClickEquipBuffItem =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local item = this.vm.data.EquippedBuffList[param + 1]
            this.OnClickBuffItem(item)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(this.vm.behaviour.gameObject, this, objs)
        local temp = vm.behaviour.transform:Find("template/BuffItem").gameObject
        buffItem = TeamTowerSelectBuffItem.New(temp,this.buffRect);
        SetActive(buffItem.gameObject,false)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.RefreshView()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

this.RefreshView = function()
    SetActive(buffItem.gameObject,false)
    this.vm.data.btnEquipState = false
    this.vm.data.btnUnequipState = false
    this.canSelectBuffCount = ConfigMgr.Config.TeamTowerConstants.BattleSelectBuff;
    this.InitSelectList()
    this.InitEquippedList()
    this.RefreshEquipState()
end

this.RefreshEquipState = function()
    for _, buff in ipairs(this.vm.data.SelectBuffList) do
        buff.equip = false
    end
    
    local equippedIds = {}
    for _, e in ipairs(this.vm.data.EquippedBuffList) do
        if e.buffId ~= "" then
            table.insert(equippedIds, e.buffId)
        end
    end
    
    local equipIndex = 1
    for _, buff in ipairs(this.vm.data.SelectBuffList) do
        if equipIndex > #equippedIds then break end
        if buff.buffId == equippedIds[equipIndex] then
            buff.equip = true
            equipIndex = equipIndex + 1
        end
    end
end

this.InitSelectList = function()
    local tempList= {}
    local uniqueId = 1 
    for id, v in pairs(TeamTowerMgr.GetTeamTowerData().BuffMap) do
        for i = 1, v do
            local buff = ConfigMgr.Config.TeamTowerBuffPoolMap[id];
            local buffConfig = ConfigMgr.Config.TeamTowerBuffDescMap[buff.Key];
            local buffBg = LuaMgr.GetSprite("TeamTowerSprite", "ui_hd_trj_pt_qw_sbd0" .. buffConfig.Param[1])
            local icon = LuaMgr.GetSprite("BuffIcon", buffConfig.BuffIcon)
            local name = LuaMgr.GetLangText(buffConfig.BuffNameLan)
            local selectBuffData = {}
            selectBuffData.buffId = id;
            selectBuffData.uniqueId = uniqueId 
            selectBuffData.equip = false;
            selectBuffData.buffBg = buffBg;
            selectBuffData.buffIcon = icon;
            selectBuffData.buffName = name;
            selectBuffData.select = false;
            selectBuffData.get = true;
            selectBuffData.notGet = false;
            selectBuffData.sort = buffConfig.Sort;
            table.insert(tempList,selectBuffData)
            uniqueId = uniqueId + 1
        end
    end
    if #tempList < 8 then
        for i = #tempList, 7 do
            local selectBuffData = {}
            selectBuffData.buffId = "";
            selectBuffData.uniqueId = uniqueId
            selectBuffData.equip = false;
            selectBuffData.buffBg = DefaultSprite;
            selectBuffData.buffIcon = DefaultSprite;
            selectBuffData.buffName = "";
            selectBuffData.select = false;
            selectBuffData.get = false;
            selectBuffData.notGet = true;
            selectBuffData.sort = 0;
            table.insert(tempList,selectBuffData)
            uniqueId = uniqueId + 1
        end
    end
    table.sort(tempList,function(a,b)
        return a.sort > b.sort
    end)
    this.vm.data.SelectBuffList = tempList
end

this.InitEquippedList = function()
    local tempList= {}
    for i = 1, this.canSelectBuffCount do
        local equippedBuffData = {}
        equippedBuffData.buffId = "";
        equippedBuffData.select = false;
        equippedBuffData.equip = false;
        equippedBuffData.buffBg = DefaultSprite;
        equippedBuffData.buffIcon = DefaultSprite;
        equippedBuffData.buffName = "";
        equippedBuffData.notEmpty = false;
        equippedBuffData.uniqueId = 1;
        table.insert(tempList,equippedBuffData)
    end
    this.vm.data.EquippedBuffList = tempList
    local equippedIds = {}
    equippedIds = table.deepCopy(TeamTowerMgr.equippedBuffList,{});
    
    for i, v in ipairs(this.vm.data.SelectBuffList) do
        for index = 1, #equippedIds do
            if not IsNullOrEmpty(equippedIds[index]) and v.buffId == equippedIds[index] then
                this.AddEquippedBuff(v.buffId,v.uniqueId)
                table.remove(equippedIds,index)
                break;
            end
        end
    end
end

this.OnClickBuffItem = function(item)
    if item.buffId == "" then
        return
    end
    if this.curSelectBuffItem ~= nil then
        this.curSelectBuffItem.select = false
    end
    this.curSelectBuffItem = item;
    this.curSelectBuffItem.select = true;
    this.vm.data.btnEquipState = not item.equip
    this.vm.data.btnUnequipState = item.equip
    SetActive(buffItem.gameObject,true)
    local data = {};
    data.onClick = nil;
    data.buffId = item.buffId;
    data.floor = ""
    buffItem:SetData(data)
end

this.UnSelectBuff = function()
    this.curSelectBuffItem.equip = false
    
    for i, v in ipairs(this.vm.data.SelectBuffList) do
        if v.uniqueId == this.curSelectBuffItem.uniqueId then
            v.equip = false
            this.curSelectBuffItem = v
            v.select = true
            break
        end
    end

    for i, v in ipairs(this.vm.data.EquippedBuffList) do
        if v.buffId == this.curSelectBuffItem.buffId and v.uniqueId == this.curSelectBuffItem.uniqueId then
            v.buffId = ""
            v.equip = false
            v.notEmpty = false
            v.select = false
            break
        end
    end
    this.vm.data.btnEquipState = not this.curSelectBuffItem.equip
    this.vm.data.btnUnequipState = this.curSelectBuffItem.equip
end

this.SelectBuff = function()
    local repeatCount = ConfigMgr.Config.TeamTowerConstants.BattleSelectBuffTitled
    local curRepeatCount = 1;
    local count = 0;
    for i, v in ipairs(this.vm.data.EquippedBuffList) do
        if v.equip then
            count = count + 1
        end
        if v.buffId == this.curSelectBuffItem.buffId then
            curRepeatCount = curRepeatCount + 1
            if curRepeatCount > repeatCount then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(LuaMgr.GetLangText("TeamTowerEquipBuffPopUp_0"),repeatCount))
                return
            end
        end
    end

    if this.canSelectBuffCount <= count then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(LuaMgr.GetLangText("TeamTowerEquipBuffPopUp_0"),this.canSelectBuffCount))
        return
    end
    if curRepeatCount > repeatCount then
        return;
    end
    
    for i, v in ipairs(this.vm.data.SelectBuffList) do
        if v.uniqueId == this.curSelectBuffItem.uniqueId then
            v.equip = true
            break
        end
    end
    this.curSelectBuffItem.equip = true
    this.AddEquippedBuff(this.curSelectBuffItem.buffId,this.curSelectBuffItem.uniqueId)
    this.vm.data.btnEquipState = not this.curSelectBuffItem.equip
    this.vm.data.btnUnequipState = this.curSelectBuffItem.equip
end

this.AddEquippedBuff = function(buffId,uniqueId)
    for i, v in ipairs(this.vm.data.EquippedBuffList) do
        if v.buffId == "" then
            local buff = ConfigMgr.Config.TeamTowerBuffPoolMap[buffId];
            local buffConfig = ConfigMgr.Config.TeamTowerBuffDescMap[buff.Key];
            local buffBg = LuaMgr.GetSprite("TeamTowerSprite", "ui_hd_trj_pt_qw_sbd0" .. buffConfig.Param[1])
            local icon = LuaMgr.GetSprite("BuffIcon", buffConfig.BuffIcon)
            local name = LuaMgr.GetLangText(buffConfig.BuffNameLan)
            v.buffId = buffId;
            v.select = false;
            v.uniqueId = uniqueId;
            v.equip = true;
            v.buffBg = buffBg;
            v.buffIcon = IsNull(icon) and DefaultSprite or icon;
            v.buffName = name;
            v.notEmpty = true;
            break;
        end
    end
end

this.OnBack = function()
    LuaMgr.Back();
end

return vm({
    data = data,
    command = command,
    hook = hook
})