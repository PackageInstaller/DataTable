require("CollectorPractice/Version2/Common/UISelectMonsterItem")
local tarGameObject = nil;
local tarRect = nil;
local UISelectMonsterItemPrefab = nil;
local root = nil;
local Middle = nil;
local ScrollView = nil;
local rectContent = nil;
local animator=nil;

local this = {
    mapToMapIdToLevel={};
    mapIDItemList={};
    selectMonsterItemList={};
saveClickMonsterItemBeforeData={};
    dotweenPool={};
    funList={},
    beforeRectContent=nil,

    maxStep=nil,
    maxStepItemIndex=nil,
    maxDotweenPoolSize=1,
    firstCo=nil,
};
this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    UISelectMonsterItemPrefab = uiLink:Get("UISelectMonsterItem");
    root = uiLink:Get("root");
    animator=uiLink:Get("root"):GetComponent("Animator");
    Middle = uiLink:Get("Middle");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    UISelectMonsterItemPrefab = nil;
    root = nil;
    Middle = nil;
    ScrollView = nil;
    rectContent = nil;
    animator=nil;
    for index, value in ipairs(this.selectMonsterItemList) do
        value:Destroy();
    end
    this=nil;
end

this.PreInitData = function()
    local config=ConfigMgr.Config.YX2Maps;
    this.mapToMapIdToLevel={};
    for key, value in pairs(config) do
        if this.mapToMapIdToLevel[value.MapType]==nil then
            this.mapToMapIdToLevel[value.MapType]={};
        end
        if this.mapToMapIdToLevel[value.MapType][value.BossType]==nil then
            this.mapToMapIdToLevel[value.MapType][value.BossType]={};
        end
        table.insert(this.mapToMapIdToLevel[value.MapType][value.BossType],value);
    end


end

this.InitData = function()
    local nowMap = CollectorPracticeAllMgr.currentSelectMap;
    local tempBossTypeToIndex={};
    local index=1;
    this.mapIDItemList={};
    this.maxDotweenPoolSize=1;
    for key, value in pairs(this.mapToMapIdToLevel[nowMap]) do
        for key2, value2 in pairs(value) do
            if tempBossTypeToIndex[value2.BossType]==nil then
                table.insert(this.mapIDItemList,{});
                tempBossTypeToIndex[value2.BossType]=index;
                index=index+1;
            end
            table.insert(this.mapIDItemList[tempBossTypeToIndex[value2.BossType]],value2);
        end
    end
    table.sort(this.mapIDItemList,function (a, b)
        return a[1].BossType<b[1].BossType;
    end)
    for key, value in pairs(this.mapIDItemList) do
        table.sort(value,function (a, b)
            return a.LevelShow<b.LevelShow;
        end)
    end
end

this.InitPanel = function()
    this.funList={
        clickMonsterItem=this.ClickMonsterItem,
        clickBackMonsterItem=this.ClickBackMonsterItem,
        nextStep1Fun=this.ItemNextStep1Fun,
        nextStep2Fun=this.ItemNextStep2Fun,
        nextStep3Fun=this.ItemNextStep3Fun,
        saveSerializeData=this.SaveSerializeData,
        isDotweenMove=this.IsDotweenMove
    }
for i = 1, #this.mapIDItemList, 1 do
        if i > #this.selectMonsterItemList then
            table.insert(this.selectMonsterItemList, UISelectMonsterItem.New(UISelectMonsterItemPrefab, rectContent))
        end
        local mapIdList={};
        for index, value in ipairs(this.mapIDItemList[i]) do
            table.insert(mapIdList,value.MapID)
        end
if TableIsNull(CollectorPracticeMgrVersion2.SelectMonsterSerializeData) then
            this.selectMonsterItemList[i]:InitSaveData();
            this.selectMonsterItemList[i]:SetData(i,mapIdList,this.funList);
        else
            this.selectMonsterItemList[i]:LoadSaveData(CollectorPracticeMgrVersion2.SelectMonsterSerializeData.itemData[i]);
            this.selectMonsterItemList[i]:SetData(i,mapIdList,this.funList);
        end
    end
if TableIsNull(CollectorPracticeMgrVersion2.SelectMonsterSerializeData) then
this.ControlAllItemClickButton(true);
this.vm.behaviour:UpdateTopBar("", function ()
            if this.IsDotweenMove() then
                return;
            end
            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeHomeVersion2ViewModel);
        end)
    else

        this.saveClickMonsterItemBeforeData=CollectorPracticeMgrVersion2.SelectMonsterSerializeData.beforeData;
        local maxStep,maxStepItemIndex=this.GetSerializeMaxStepAndItemIndex();
        this.SetBackFunAndClickButtonStateByStep(maxStep,maxStepItemIndex);
    end
    for i = #this.mapIDItemList + 1, #this.selectMonsterItemList do
        this.selectMonsterItemList[i]:Hide();
    end
    ScrollView.enabled=true;

    this.InitScrollViewItem();

end

this.InitScrollViewItem = function()
    local numberCnt=#this.mapIDItemList;
    local itemWidth=399;
local addOpenItemWdith=1044.5;
if TableIsNull(CollectorPracticeMgrVersion2.SelectMonsterSerializeData) then
        rectContent.sizeDelta = Vector2(itemWidth*numberCnt, 550);
        for i = 1, numberCnt, 1 do
            this.selectMonsterItemList[i].transform.anchoredPosition=Vector2((i-1)*itemWidth,-25);
        end
    else
        local maxStep,maxStepItemIndex=this.GetSerializeMaxStepAndItemIndex();
if maxStep~=1 then
            ScrollView.enabled=false;
            rectContent.sizeDelta = Vector2(itemWidth*numberCnt, 550);

            local moveLength=addOpenItemWdith/2;
local picOff=-46;
local center=(1443.5/2)-picOff-moveLength;


            local centerCard=#this.mapIDItemList/2;
            local targetCardVal=(maxStepItemIndex-1-centerCard);
local addScrollViewNeedPX=-(targetCardVal*399)
            local nowPos=addScrollViewNeedPX-center;
            local targetpos=Vector2(nowPos,0);
            rectContent.anchoredPosition=targetpos
else
            rectContent.sizeDelta = Vector2(itemWidth*numberCnt, 550);
            for i = 1, numberCnt, 1 do
                this.selectMonsterItemList[i].transform.anchoredPosition=Vector2((i-1)*itemWidth,-25);
            end
        end        
    end
end

this.SetBackFunAndClickButtonStateByStep=function (step,itemIndex)
    if step==1 then
this.ControlAllItemClickButton(true);
        this.ItemNextStep1Fun(this.selectMonsterItemList[itemIndex])
    elseif step==2 then
this.ControlAllItemClickButton(false);
        this.ItemNextStep2Fun(this.selectMonsterItemList[itemIndex])
    elseif step==3 then
this.ControlAllItemClickButton(false);
        this.ItemNextStep3Fun(this.selectMonsterItemList[itemIndex])
    end
end

this.GetSerializeMaxStepAndItemIndex=function ()
    if this.maxStep~=nil then
        return this.maxStep,this.maxStepItemIndex;
    else
        local maxStep=1;
        local maxStepItemIndex=1;
        for index, value in ipairs(CollectorPracticeMgrVersion2.SelectMonsterSerializeData.itemData) do
            if maxStep<value.nowStep then
                maxStepItemIndex=index;
                maxStep=value.nowStep;
            end
        end
        return maxStep,maxStepItemIndex;
    end

end

this.SaveSerializeData = function()
    local data={};
    for i = 1, #this.mapIDItemList, 1 do
        table.insert(data,this.selectMonsterItemList[i]:GetSaveData());
    end
    CollectorPracticeMgrVersion2.SelectMonsterSerializeData.itemData=data;
    CollectorPracticeMgrVersion2.SelectMonsterSerializeData.beforeData=this.saveClickMonsterItemBeforeData;
end



this.ClickMonsterItem=function (itemSelf)
    if this.firstCo~=nil then
        return;
    end
    itemSelf:PublicInitFirstReward(itemSelf.levelItemList[itemSelf.nowSelectLevelIndex].mapId)
    local clickIndex=itemSelf.index;
    ScrollView.enabled=false;
    this.saveClickMonsterItemBeforeData={};
    for i = 1, #this.mapIDItemList, 1 do
        table.insert(this.saveClickMonsterItemBeforeData,this.selectMonsterItemList[i].transform.anchoredPosition);
    end
local addOpenItemWdith=1044.5;


    local moveLength=addOpenItemWdith/2;
    for i = 1, #this.mapIDItemList, 1 do
        local targetObjRect=this.selectMonsterItemList[i].transform;
        local targetpos=nil;
        if i<=clickIndex then
            targetpos=Vector2(targetObjRect.anchoredPosition.x-moveLength, targetObjRect.anchoredPosition.y);
        elseif i>clickIndex then
            targetpos=Vector2(targetObjRect.anchoredPosition.x+moveLength, targetObjRect.anchoredPosition.y);
        end
        local tweenerIndex=this.GetDotweenPool();
        this.dotweenPool[tweenerIndex] = DOTWeen.To(function() return targetObjRect.anchoredPosition end,
        function(vector) targetObjRect.anchoredPosition = vector end, targetpos, 0.4)
        this.dotweenPool[tweenerIndex].onComplete = function()
            this.dotweenPool[tweenerIndex] = nil
        end
    end
local picOff=-46;
local center=(1443.5/2)-picOff-moveLength;


    local centerCard=#this.mapIDItemList/2;
    local targetCardVal=clickIndex-1-centerCard;
local addScrollViewNeedPX=-(targetCardVal*399)
    local nowPos=addScrollViewNeedPX-center;
    local tweenerIndex=this.GetDotweenPool();
    this.beforeRectContent=rectContent.anchoredPosition;
    local targetpos=Vector2(nowPos,0);
    this.dotweenPool[tweenerIndex] = DOTWeen.To(function() return rectContent.anchoredPosition end,
    function(vector) rectContent.anchoredPosition = vector end, targetpos, 0.4)
    this.dotweenPool[tweenerIndex].onComplete = function()
        this.dotweenPool[tweenerIndex] = nil
    end
    this.ControlAllItemClickButton(false);
end

this.ClickBackMonsterItem=function (itemSelf)
    itemSelf:SwitchStep(1);
local addOpenItemWdith=1044.5;
    ScrollView.enabled=true;

    for i = 1, #this.mapIDItemList, 1 do
        local targetObjRect=this.selectMonsterItemList[i].transform;
        local targetpos=this.saveClickMonsterItemBeforeData[i];
        local tweenerIndex=this.GetDotweenPool();
        this.dotweenPool[tweenerIndex] = DOTWeen.To(function() return targetObjRect.anchoredPosition end,
        function(vector) targetObjRect.anchoredPosition = vector end, targetpos, 0.4)
        this.dotweenPool[tweenerIndex].onComplete = function()
            this.dotweenPool[tweenerIndex] = nil
        end
    end

    local targetpos=Vector2(0,0);
    if this.beforeRectContent~=nil then
        targetpos=this.beforeRectContent;
    end
    local tweenerIndex=this.GetDotweenPool();
    this.dotweenPool[tweenerIndex] = DOTWeen.To(function() return rectContent.anchoredPosition end,
    function(vector) rectContent.anchoredPosition = vector end, targetpos, 0.4);
    this.dotweenPool[tweenerIndex].onComplete = function()
        this.dotweenPool[tweenerIndex] = nil
    end

    this.ControlAllItemClickButton(true);
end

this.ControlAllItemClickButton=function (isCanClick)
    ScrollView.enabled=isCanClick; 
    for i = 1, #this.mapIDItemList, 1 do
        local targetItem=this.selectMonsterItemList[i];
        targetItem:SetClickMonsterButton(isCanClick);
    end
end


this.ItemNextStep1Fun=function (itemSelf)
    this.vm.behaviour:UpdateTopBar("", function ()
        if this.IsDotweenMove() then
            return;
        end
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeHomeVersion2ViewModel);
    end)
end


this.ItemNextStep2Fun=function (itemSelf)
    this.vm.behaviour:UpdateTopBar("", function ()
        if this.IsDotweenMove() then
            return;
        end
        this.ClickBackMonsterItem(itemSelf);
    end)
end


this.ItemNextStep3Fun=function (itemSelf)
    this.vm.behaviour:UpdateTopBar("", function ()
        if this.IsDotweenMove() then
            return;
        end
        itemSelf:SwitchStep(2);
    end)
end

this.ClearSerializeData=function ()
    CollectorPracticeMgrVersion2.SelectMonsterSerializeData={};
    this.maxStep=nil;
    this.maxStepItemIndex=nil;
end

this.GetDotweenPool=function ()
    for i = 1, this.maxDotweenPoolSize, 1 do
        if this.dotweenPool[tostring(i)]~=nil then
            return tostring(i);
        end
    end
    this.maxDotweenPoolSize=this.maxDotweenPoolSize+1;
    return tostring(this.maxDotweenPoolSize);
end

this.IsDotweenMove=function ()
    for i = 1, this.maxDotweenPoolSize, 1 do
        if this.dotweenPool[tostring(i)]~=nil then
            return true;
        end
    end
    return false;
end

this.ClearDotweenPool=function ()
    for i = 1, this.maxDotweenPoolSize, 1 do
        if this.dotweenPool[tostring(i)]~=nil then
            this.dotweenPool[tostring(i)]:Kill();
        end
    end
    this.maxDotweenPoolSize=1;
end

this.ShowFirstAnimation=function ()
    for i = 1, #this.mapIDItemList, 1 do
        this.selectMonsterItemList[i]:ReadyToShowFirstAnimation();
    end
    this.firstCo = coroutine_runner.start(
        function()
            for i = 1, #this.mapIDItemList, 1 do
                this.selectMonsterItemList[i]:PlayFirstAnimation();
                coroutine_runner.wait(0.15)
            end
            this.firstCo=nil;
        end)
    animator:Play("ani_CollectorPracticeSelectMonsterVersion2Panel_root",0,0);
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour.gameObject)
        this.PreInitData();
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.InitData();
        this.InitPanel();
        if CollectorPracticeMgrVersion2.FirstOpenSelectMonster then
            this.ShowFirstAnimation();
            CollectorPracticeMgrVersion2.FirstOpenSelectMonster=false;
        end
this.ClearSerializeData();
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
            this.ClearDotweenPool();
            if this.firstCo ~= nil and (not coroutine_runner.checkIsDestory()) then
                coroutine_runner.stop(this.firstCo)
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