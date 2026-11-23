





local this = {
    vm=nil;
    data = {
        orderType=nil,
    }
};

local data = {
    equipTypeList={
        {
            nameSprite=DefaultSprite,
            sizeData=Vector2(972.337,0);
            nameColor=UnityEngine.Color();
            contentLocalPos=Vector3(0,0,0);
            equipList={{
                
                       }
            },
        }
    },
    
    contentLocalPos=Vector3(0,0,0);
}

local command = {
    returnBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
         LuaMgr.HidePanel(UIName.WeaponItemsViewModel);
      end
    },
}

local tarGameObject = nil;
local tarRect = nil;
local rectContent = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    rectContent = nil;
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject);
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if vm.behaviour.Params.Length > 0 then
            local type = vm.behaviour.Params[0];

            if this.data.orderType ~= nil and this.data.orderType == type then
                return ;
            end
            this.data.orderType = type;
            this.ParseData();
        end

    end,
    before_deactive = function(vm)

    end,

    before_destroy = function(vm)
        this.vm.data = nil;
        this.vm.behaviour = nil;
        this.vm = nil;
        this.data = nil;
        this.Clear();
    end,
}

this.ParseData=function()
    local cfgWeapons=ConfigMgr.Config.weaponMade.Weapons;
    local cfgCraft=ConfigMgr.Config.weaponMade.Craftsman;
    local cfgEquipments=ConfigMgr.Config.equipments;
    
    local orderType_CraftList={};
    local orderType_WeaponsMap={};
    local orderType_WeaponsRareMap={}

    for i,v in pairs(cfgCraft) do
        if v.OrdersType==this.data.orderType then
            table.insert(orderType_CraftList,v);
        end
    end

    for i,v in ipairs(cfgWeapons) do
        for p,m in ipairs(orderType_CraftList) do
            if v.GroupID==m.Drop then
                if orderType_WeaponsMap[v.WeaponID]==nil then
                    orderType_WeaponsMap[v.WeaponID]=v;
                end
                break;
            end
        end
    end
   

    for i,v in pairs(orderType_WeaponsMap) do
        local rare=cfgEquipments[v.WeaponID].rare;
        if orderType_WeaponsRareMap[rare]==nil then
            orderType_WeaponsRareMap[rare]={}
            table.insert(orderType_WeaponsRareMap[rare],v);
        else
            table.insert(orderType_WeaponsRareMap[rare],v);
        end
    end
    for i,v in pairs(orderType_WeaponsRareMap) do
        table.sort(v,function(a, b) return a.WeaponID<b.WeaponID end)
    end
    this.ShowEquip(orderType_WeaponsRareMap);

    this.vm.data.contentLocalPos=Vector3(0,0,0);
end

this.ShowEquip=function(weaponsMap)
    this.vm.data.equipTypeList={};
    local list={}

    for i,v in pairs(weaponsMap) do
        local rareWeapons=v;
        local weaponsList={};
        for p,m in ipairs(rareWeapons) do
            local equipItem=ConfigHelper.CreateEquipItem(m.WeaponID,0.8,true)
            table.insert(weaponsList,equipItem);
        end
        local sizeY=math.ceil(#weaponsList/10)*115+50;
local item={
            nameSprite=LuaMgr.GetSprite("Backpack", "ui_bb_ksxz_wz" ..(i-1)),
            equipList=weaponsList;
            contentLocalPos=Vector3(0,0,0);
            sizeData=Vector2(972.337,sizeY);
        }
        table.insert(list,item);
    end
    
    this.vm.data.equipTypeList=list;
    list=nil;
    this.vm.data.contentLocalPos=Vector3(0,0,0);
end

return vm({
    data = data,
    command = command,
    hook = hook
})