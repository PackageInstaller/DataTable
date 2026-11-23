



local this = { }

local closefun=nil;
local cardItems={ };
require("CollectorPractice/Common/UICollectorCardItem")
local tarGameObject = nil;
local tarRect = nil;
local rectContant = nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    rectContant = uiLink:Get("rectContant"):GetComponent("RectTransform");
end

this.Clear = function()

    for i = 1, #cardItems do
        cardItems[i]:Destroy();
    end

    cardItems = nil;
    tarGameObject = nil
    tarRect = nil
    rectContant = nil;
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject);
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            local paramsData = vm.behaviour.Params[0]
            local currentMap = vm.behaviour.Params[1]
            closefun = vm.behaviour.Params[2]

            local len=#paramsData;

            for i = 1, len do
                for key, value in pairs(CollectorPracticeMgr.HomeGrlleryData) do
                    
                    if paramsData[i] == value.RelicsId then
                        if i>#cardItems then
                            table.insert(cardItems,UICollectorCardItem.New(rectContant,Vector3(1.38,1.38,1.38)))
                        end
                        
                        cardItems[i]:SetData(value,function(itemData)

                            for k = 1, len do
                                if itemData.RelicsId == paramsData[k] then
                                    local data = { ThemeId = currentMap, Idx = (k-1) }
                                    ApiMgr.Request("practice/relics_event_get_reward", data, true,
                                            function(result)
                                                local re = json.decode(result)
                                                if re.code == 0 then
                                                    LuaMgr.InvokeUIEventListeners(UIEventConst.CollectorRandomRewardRefush);
                                                    LuaMgr.HidePanel(UIName.CollectorPracticeRandomCardViewModel)
                                                end
                                            end, nil, true)
                                    
                                    break;
                                end
                            end
                            
                        end);
                        
                        break
                    end
                end
            end

            for i = len+1, #cardItems do
                cardItems[i]:Clear();
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if closefun~=nil then
                closefun();
                closefun=nil;
            end
        end
    end,
    before_destroy = function(vm)
        this.Clear();
    end,
}

return vm({
    hook = hook
})