require("ViewModel/TeamTower/TeamTowerSelectBuffItem")
local this =
{
    vm = nil,
    BuffItems = {},
    content = nil,
    BuffItemTemplate = nil,
    SelectBuffList = {},
    canSelectBuffCount = 0,
    selectBuffCount = 0,
}
local data =
{
    confirmText = ""
}

local command = {
    SelectCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.selectBuffCount < this.canSelectBuffCount then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29760"),this.canSelectBuffCount))
                return
            end
            TeamTowerMgr.ChooseBuff(this.SelectBuffList,function() LuaMgr.HidePanel(UIName.TeamTowerSelectBuffPopUp)end,nil);
        end
    },
    CloseCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.content = vm.behaviour.transform:Find("root/Middle/ScrollView/Viewport/rectContent").gameObject
        this.BuffItemTemplate = vm.behaviour.transform:Find("template/BuffItem").gameObject
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
    this.SelectBuffList = {};
    this.selectBuffCount = 0;
    local len = 0;
    for k, floorBuffs in pairs(TeamTowerMgr.GetTeamTowerData().ChooseBuff) do
        for i, v in pairs(floorBuffs) do
            local data = {
                floor = k,
                buffId = v,
                onClick = this.OnClickBuffItem
            }
            len = len + 1
            if len>#this.BuffItems then
                table.insert(this.BuffItems,TeamTowerSelectBuffItem.New(this.BuffItemTemplate.gameObject, this.content.transform))
            end

            SetActive(this.BuffItems[len].gameObject,true);
            this.BuffItems[len]:SetData(data)
        end
    end
    
    for i = (len+1), #this.BuffItems do
        SetActive(this.BuffItems[i].gameObject,false)
    end

    this.canSelectBuffCount = math.floor(len * ConfigMgr.Config.TeamTowerConstants.BuffPoolSelect / ConfigMgr.Config.TeamTowerConstants.BuffPoolNumber);
    this.vm.data.confirmText = string.format(LuaMgr.GetLangText("TeamTowerSelectBuffPopUp_0"),this.selectBuffCount ,this.canSelectBuffCount)
end

this.OnClickBuffItem = function(buffItem)
    for k, v in pairs(this.SelectBuffList) do
        if v ~= nil and k == buffItem.floor then
            for i, id in ipairs(v) do
                if id == buffItem.buffId then
                    buffItem:Select(false)
                    table.remove(this.SelectBuffList[k],i)
                    this.selectBuffCount = this.selectBuffCount - 1
                    this.vm.data.confirmText = string.format(LuaMgr.GetLangText("TeamTowerSelectBuffPopUp_1"),this.selectBuffCount ,this.canSelectBuffCount)
                    return
                end
            end
        end
    end
    local count = 0
    for i, v in pairs(this.SelectBuffList) do
        count = count + ConfigHelper.GetTableLength(v)
    end
    if this.canSelectBuffCount <= count then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("TeamTowerSelectBuffPopUp_2"))
        return
    end
    buffItem:Select(true)
    if this.SelectBuffList[buffItem.floor] == nil then
        this.SelectBuffList[buffItem.floor] = {}
    end
    table.insert(this.SelectBuffList[buffItem.floor],buffItem.buffId)
    this.selectBuffCount = this.selectBuffCount + 1
    this.vm.data.confirmText = string.format(LuaMgr.GetLangText("TeamTowerSelectBuffPopUp_3"),this.selectBuffCount ,this.canSelectBuffCount)
end

this.OnBack = function()
    LuaMgr.Back();
end

return vm({
    data = data,
    command = command,
    hook = hook
})