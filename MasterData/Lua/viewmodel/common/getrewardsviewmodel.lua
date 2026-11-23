



local this = {vm = nil}
local coroutineKey1 = nil
local isRuning = false
local GEN_ANIMA="ui_ani_BattleWinPopup_template_Gen";
local SPECIAL_ANIMA = "ui_ani_BattleWinPopup_template_Special";

local data = {
    itemsList = {{
        goodData = {},
        equipData = {},
        itemBool = false,
        generalBool = false,
        specialBool = false,
        markBgBool = { false, false, false },
        markText = "",
        goodType = "",
        goodsBool = false,
        equipBool = false,
        itemAnimaName="",
        isSpecial=false,
    }};
    isScroll = false
}

local command = {
    clickMask = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if isRuning then return end;
            LuaMgr.HidePanel(UIName.GetRewardsViewModel);
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,

    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        local rewardJson = vm.behaviour.Params[0]
        local rewardList = json.decode(rewardJson);
        this.ParseData(rewardList);
    end,
    before_deactive = function(vm)
       
    end,
}


this.ParseData=function(rewardList)
    this.vm.data.itemsList={};
    local list={}
    for i,v in pairs(rewardList) do
        local item =ConfigMgr.Config.itemMap[tostring(v.ID)];
        if item then
            local goods={
                id=tostring(v.ID),count=tostring(LuaMgr.NumFormat(v.Count)),isCount=true,
                rare=ConfigHelper.GetRareSprite(item.rare),
                icon=ConfigHelper.GetItemTexture(tostring(v.ID)),
                scale=Vector3(0.73,0.73,0.73),
                sizeDelta=Vector2(80,80),
                isClick=true
            };
            local goodsitem={
                goodData=goods;
                itemBool = false,
                generalBool = false,
                specialBool = false,
                markBgBool = { false, false, false },
                markText = "",
                goodType = "",
                goodsBool = true;
                equipBool = false;
                isSpecial=item.isSpecial~=0;
                itemAnimaName="";
            }
            table.insert(list,goodsitem);
        else
            local equip=DataMgr.Player.equipments[v.ID];
            local configEquip=ConfigMgr.Config.equipments[equip.equipmentId];
            local tempLevel = equip.level or 1
            local tempStar = equip.star or 1
            local equips={itemId=tostring(v.ID),
                          rareIcon=ConfigHelper.GetRareSprite(configEquip.rare),
                          icon=ConfigHelper.GetItemTexture(tostring(equip.equipmentId)),
                          scale=Vector3(0.74,0.74,0.74),
                          level=string.format("lv.%d", tempLevel),
                          star1=true,
                          star2=tempStar>1,
                          star3=tempStar>2,
                          star4=tempStar>3,
                          star5=tempStar>4,
                          star6=tempStar>5,
                          weaponBtnBool=false,
                          isClick=true};
            local equipsItem= {
                equipData = equips;
                itemBool = false,
                generalBool = false,
                specialBool = false,
                markBgBool = { false, false, false },
                markText = "",
                goodType = "",
                goodsBool = false;
                equipBool = true;
                itemAnimaName="",
            }
            table.insert(list,equipsItem);
        end
    end
    this.vm.data.itemsList=list;
    list=nil;
    this.ShowRewardFX();
end

this.ShowRewardFX=function()
    isRuning=true;
    if coroutineKey1~=nil then
        coroutine_runner.stop(coroutineKey1);
    end
    coroutineKey1=coroutine_runner.start(function()
        for i,v in ipairs(this.vm.data.itemsList) do
            if v.isSpecial then
                coroutine_runner.wait(0.3);
                v.itemBool=true;
                AudioHelper.PlayUISFX(AudioNames.ERewarded);
                v.itemAnimaName=SPECIAL_ANIMA;
v.specialBool=true;
                coroutine_runner.wait(0.75);
            else
coroutine_runner.wait(0.1)
                v.itemBool=true;
                AudioHelper.PlayUISFX(AudioNames.ERewarded);
                v.itemAnimaName=GEN_ANIMA;
v.generalBool=true;
            end
        end
        this.vm.data.isScroll = true
        isRuning=false;
    end)
end

return vm({
    data = data,
    command = command,
    hook = hook,
})