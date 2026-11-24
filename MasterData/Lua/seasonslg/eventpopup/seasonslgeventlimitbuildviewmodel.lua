require("SeasonSLG/EventPopUp/BuildCostItem")
require("SeasonSLG/EventPopUp/BuildBuffItem")
require("SeasonSLG/EventPopUp/BlockTopRankCom")
require("SeasonSLG/EventPopUp/SeasonSLGTopRankRewardCom")
local this = {
   buildBuffUIList={};
   buildBuffItemObj=nil;
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.goCostItemSelect = uiLink:Get("goCostItemSelect");
    ui.goTopRank = uiLink:Get("goTopRank");
    ui.goScrollView = uiLink:Get("goScrollView");
    ui.goProgress = uiLink:Get("goProgress");
    ui.goProgressUnLock = uiLink:Get("goProgressUnLock");
    ui.goTopRankReward = uiLink:Get("goTopRankReward");
    ui.goProduct = uiLink:Get("goProduct");
    ui.goBGLock = uiLink:Get("goBGLock");
    ui.goBGUnLock = uiLink:Get("goBGUnLock");
    ui.goRewardPreview = uiLink:Get("goRewardPreview");
    ui.goGoodsItem = uiLink:Get("goGoodsItem");
    ui.goBuffs = uiLink:Get("goBuffs");
    ui.goActiveBuff = uiLink:Get("goActiveBuff");
    ui.rawCostIcon = uiLink:Get("rawCostIcon"):GetComponent("RawImage");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnHelp = uiLink:Get("btnHelp"):GetComponent("Button");
    ui.btnComfrim = uiLink:Get("btnComfrim"):GetComponent("Button");
    ui.btnRank = uiLink:Get("btnRank"):GetComponent("Button");
    ui.btnCostItem = uiLink:Get("btnCostItem"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtDes = uiLink:Get("txtDes"):GetComponent("Text");
    ui.txtProgressValue = uiLink:Get("txtProgressValue"):GetComponent("Text");
    ui.txtProgressAdd = uiLink:Get("txtProgressAdd"):GetComponent("Text");
    ui.txtLevelUnLock = uiLink:Get("txtLevelUnLock"):GetComponent("Text");
    ui.txtProgressValueUnLock = uiLink:Get("txtProgressValueUnLock"):GetComponent("Text");
    ui.txtProgressAddUnLock = uiLink:Get("txtProgressAddUnLock"):GetComponent("Text");
    ui.txtDispatchName = uiLink:Get("txtDispatchName"):GetComponent("Text");
    ui.txtCostCount = uiLink:Get("txtCostCount"):GetComponent("Text");
    ui.txtSliderValue = uiLink:Get("txtSliderValue"):GetComponent("Text");
    ui.txtProductCount = uiLink:Get("txtProductCount"):GetComponent("Text");
    ui.txtLocation = uiLink:Get("txtLocation"):GetComponent("Text");
    ui.transCostItemList = uiLink:Get("transCostItemList"):GetComponent("RectTransform");
    ui.transTopRank = uiLink:Get("transTopRank"):GetComponent("RectTransform");
    ui.transTopRankReward = uiLink:Get("transTopRankReward"):GetComponent("RectTransform");
    ui.tranbuffContent = uiLink:Get("tranbuffContent"):GetComponent("RectTransform");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.imgProgress = uiLink:Get("imgProgress"):GetComponent("Image");
    ui.imgProgressUnLock = uiLink:Get("imgProgressUnLock"):GetComponent("Image");
    ui.animatorProgress = uiLink:Get("animatorProgress"):GetComponent("Animator");
    ui.animatorProgressUnLock = uiLink:Get("animatorProgressUnLock"):GetComponent("Animator");
    ui.sliderProduct = uiLink:Get("sliderProduct"):GetComponent("Slider");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventLimitBuildViewModel)
    end)



    uiLink:AddClickEvent("btnComfrim",function()
        if not SeasonSLGMapMgr.CheckBlockIsUnLock(tostring(SeasonSLGEventMgr.curGridIndex),SeasonSLGMapMgr.CheckTriggerEventCoverByTime()) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventLimitBuildViewModel_0"));
            return;
        end
        if this.cfgMaxCount < this.costItemCount then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_34242"));
            return;
        end




        local timeEventId=nil;




        local Action=function()
            timeEventId=this.cfgWorldBuild.Id;
            SeasonSLGAPI.OnAskTimeEventBuild(tostring(SeasonSLGEventMgr.curGridIndex),this.buildId,this.costItemId,this.costItemCount,
                    timeEventId,function(progress)
                        ui.sliderProduct.interactable=this.maxGroupCount>0;
                        ui.sliderProduct.value=0;
                        this.groupCount=0;
                        this.ParseData();
                        if this.fullProgress >= 1 then

                            SeasonSLGEventMgr.UpdateUnLockProgress()
                        end
                    end)
        end
        local itemName=LuaMgr.GetLangText(ConfigHelper.GetItemNamelan(this.costItemId));
        local power=this.cfgWorldBuild.ObtainItem[this.groupCount + 1].count;
        local tip=string.format(LuaMgr.GetLangText("SeasonSlGEventLimitBuildViewModel_1"),this.costItemCount,itemName,power);
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tip,Action,nil);
    end)

end


local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitUI(vm.behaviour)
        this.buildBuffUIList=UIListView.New(ui.tranbuffContent);
        this.costItemUIList=UIListView.New(ui.transCostItemList);
        this.buildBuffItemObj=vm.behaviour.transform:Find("template/buildBuff").gameObject;
        this.costItemObj=vm.behaviour.transform:Find("template/CostItem").gameObject;
        ui.sliderProduct.onValueChanged:AddListener(this.SliderValueChange)
        this.curSelectCostItemIndex = 1
        this.productItem = ui.goGoodsItem:GetComponent("GoodsViewModel")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm = vm
        if vm.behaviour.Params.Length>1 then
            this.buildId=vm.behaviour.Params[0]
            this.cfgWorldBuild=ConfigMgr.Config.SeasonalGridWorldBuildMap[this.buildId];
            this.cfgGrid = SeasonSLGMapMgr.gridMap[tostring(SeasonSLGEventMgr.curGridIndex)]
            this.groupCount=0;
            SetActive(ui.txtProgressAdd.gameObject,false)
            SetActive(ui.animatorProgress.gameObject,false)
            SetActive(ui.txtProgressAddUnLock.gameObject,false)
            SetActive(ui.animatorProgressUnLock.gameObject,false)
            this.lastLevelProgress=nil
            this.ParseData();
            ui.sliderProduct.interactable=this.maxGroupCount>0;
            ui.sliderProduct.value=0;
            if not SeasonSLGMapMgr.CheckBlockEventsIsComplete(tostring(SeasonSLGEventMgr.curGridIndex)) then
                LuaMgr.AddUIEventListener(UIEventConst.SLGSeasonMapUnLock, this.OnMapUnLock)
            end
            LuaMgr.AddUIEventListener(UIEventConst.SeasonSLGUpdateMapState, this.OnMapStateUpdate)
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUpdate(this.UpdateProgress)
        this.buildBuffUIList:Clear();
        if this.topRankItem ~= nil then
            this.topRankItem:Destroy()
            this.topRankItem = nil
        end
        if this.topRankRewardItem ~= nil then
            this.topRankRewardItem:Destroy()
            this.topRankRewardItem = nil
        end
        LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGUpdateMapState, this.OnMapStateUpdate)
        LuaMgr.RemoveUIEventListener(UIEventConst.SLGSeasonMapUnLock, this.OnMapUnLock)
    end,
    before_destroy = function()
        LuaMgr.RemoveUpdate(this.UpdateProgress)
        this.ClearUI();
        UIListView.ClearItem("BuildBuffItem")
        if this.topRankItem ~= nil then
            this.topRankItem:Destroy()
            this.topRankItem = nil
        end
        if this.topRankRewardItem ~= nil then
            this.topRankRewardItem:Destroy()
            this.topRankRewardItem = nil
        end
        LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGUpdateMapState, this.OnMapStateUpdate)
        LuaMgr.RemoveUIEventListener(UIEventConst.SLGSeasonMapUnLock, this.OnMapUnLock)
    end
}

this.SliderValueChange=function(value)

    this.groupCount=math.floor(value)
    this.SetProductCount();
    this.SetCostItem();
end

this.CheckRewardBuff=function()
    if not this.isComplete and this.fullProgress>=1 then
        SeasonSLGAPI.OnAskTimeEventBuildReward(tostring(SeasonSLGEventMgr.curGridIndex),this.buildId,function()
            this.ParseData();
        end)
    end
end

this.OnMapUnLock=function()

    if SeasonSLGMapMgr.CheckBlockEventsIsComplete(tostring(SeasonSLGEventMgr.curGridIndex)) then
        this.progressFinishAction=function()
            LuaMgr.HidePanel(UIName.SeasonSlGEventLimitBuildViewModel)
            SeasonSLGEventMgr.DOGridEvent(tostring(SeasonSLGEventMgr.curGridIndex))
        end
        if not this.progressAnimating then
            local finishAction=this.progressFinishAction
            this.progressFinishAction=nil
            finishAction()
        end
    end
end

this.OnMapStateUpdate=function()
    local gridId=tostring(SeasonSLGEventMgr.curGridIndex)
    local progressData=SeasonSLGMapMgr.MapStateData.EventProgress[gridId]
    local progress=progressData~=nil and progressData.Progress or nil
    if progress==nil then return end
    if SeasonSLGMapMgr.CheckBlockEventsIsComplete(gridId) then

        this.RefreshLevelBuildProgress(progress)
        return
    end
    local oldProgress=this.fullProgress*this.cfgGrid.GridHealth
    if progress>oldProgress then
        this.ShowProgressAdd(oldProgress,progress)
    else
        this.RefreshProgress(progress)
    end
    if progress>=this.cfgGrid.GridHealth and oldProgress<this.cfgGrid.GridHealth then
        SeasonSLGEventMgr.UpdateUnLockProgress()
    end
end


this.CalcLevel=function(progress)
    local level=0;
    local costMatCount=this.cfgWorldBuild~=nil and this.cfgWorldBuild.CostMatCount or nil;
    if IsNull(progress) or IsNull(costMatCount) or TableIsNull(costMatCount) then
        return level;
    end
    for i = 1, #costMatCount do
        if progress >= costMatCount[i] then
            level = i
        end
    end
    return level;
end



this.GetLevelBuildProgress=function(progress)
    local costMatCount=this.cfgWorldBuild~=nil and this.cfgWorldBuild.CostMatCount or nil;
    if IsNull(costMatCount) or TableIsNull(costMatCount) then
        return nil;
    end
    local curLevel=(this.Level or 0) + 1;
    if curLevel > #costMatCount then
        return 1;
    end
    local prevValue=0;
    if curLevel > 1 then
        prevValue=costMatCount[curLevel - 1] or 0;
    end
    local targetValue=costMatCount[curLevel] - prevValue;
    if IsNull(targetValue) or targetValue <= 0 then
        return 1;
    end
    local rate=(progress or 0) - prevValue;
    if rate < 0 then
        rate = 0;
    end
    rate = rate / targetValue;
    if rate > 1 then
        rate = 1;
    end
    return rate;
end


this.GetLevelBuildTargetValue=function()
    local costMatCount=this.cfgWorldBuild~=nil and this.cfgWorldBuild.CostMatCount or nil;
    if IsNull(costMatCount) or TableIsNull(costMatCount) then
        return nil;
    end
    local curLevel=(this.Level or 0) + 1;
    if curLevel > #costMatCount then
        return nil;
    end
    local prevValue=0;
    if curLevel > 1 then
        prevValue=costMatCount[curLevel - 1] or 0;
    end
    local targetValue=costMatCount[curLevel] - prevValue;
    if IsNull(targetValue) or targetValue <= 0 then
        return nil;
    end
    return targetValue;
end


this.ShowLevelProgressAdd=function(oldRate, newRate)
    ui.txtProgressValueUnLock.text=string.format("%.1f%%",newRate*100);
    local per=string.format("%.2f%%",(newRate-oldRate)*100)
    local text=LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_34176")
    ui.txtProgressAddUnLock.text=string.format(text,per)
    SetActive(ui.txtProgressAddUnLock.gameObject,true)
    SetActive(ui.animatorProgressUnLock.gameObject,true)
    ui.animatorProgressUnLock:Play("SeasonSLGProgressAddAniClip",0,0)
    this.progressImg=ui.imgProgressUnLock
    this.progressFrom=oldRate
    this.progressTo=newRate
    this.progressDuration=0.35
    this.progressElapsed=0
    this.progressAnimating=true
    LuaMgr.RemoveUpdate(this.UpdateProgress)
    LuaMgr.AddUpdate(this.UpdateProgress)
end

this.RefreshLevelBuildProgress=function(progress)
    local oldProgress=this.lastLevelProgress
    this.lastLevelProgress=progress
    this.Level=this.CalcLevel(progress);
    ui.txtLevelUnLock.text = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_34241"),tostring(this.Level))
    local rate=this.GetLevelBuildProgress(progress);
    if rate == nil then

        SetActive(ui.goProgressUnLock,false)
        return;
    end
    local targetValue=this.GetLevelBuildTargetValue();
    if targetValue ~= nil and oldProgress ~= nil then

        local costMatCount=this.cfgWorldBuild~=nil and this.cfgWorldBuild.CostMatCount or nil;
        local prevValue=0;
        local curLevel=(this.Level or 0) + 1;
        if costMatCount ~= nil and curLevel > 1 then
            prevValue=costMatCount[curLevel - 1] or 0;
        end
        local oldRate=(oldProgress - prevValue)/targetValue;
        if oldRate > 1 then
            oldRate = 1;
        end
        if oldRate < 0 then
            oldRate = 0;
        end
        if rate > oldRate then
            this.ShowLevelProgressAdd(oldRate,rate)
            return;
        end
    end
    ui.txtProgressValueUnLock.text=string.format("%.1f%%",rate*100);
    if not this.progressAnimating then
        ui.imgProgressUnLock.fillAmount=rate;
    end
end

this.ParseData=function()
    local gridId=tostring(SeasonSLGEventMgr.curGridIndex)
    local isUnLock = SeasonSLGMapMgr.CheckBlockEventsIsComplete(gridId)
    local progressData = SeasonSLGMapMgr.MapStateData.EventProgress[gridId];
    local progress = (progressData~=nil and progressData.Progress) or this.vm.behaviour.Params[1].Progress or 0;
    this.Level = this.CalcLevel(progress);

    if not isUnLock then
        SetActive(ui.goProgress,true)
        SetActive(ui.goProgressUnLock,false)
        local gridId=tostring(SeasonSLGEventMgr.curGridIndex)
        local progressData=SeasonSLGMapMgr.MapStateData.EventProgress[gridId]
        local progress=(progressData~=nil and progressData.Progress) or this.vm.behaviour.Params[1].Progress or 0;
        this.fullProgress=progress/this.cfgGrid.GridHealth
        SetActive(ui.goScrollView,true)
        SetActive(ui.goBGUnLock,false)
        SetActive(ui.goBGLock,true)
        SetActive(ui.goRewardPreview,true)
        SetActive(ui.goActiveBuff,false)
        SetActive(ui.goTopRank,false)
        SetActive(ui.goTopRankReward,true)
        SetActive(ui.goBuffs,false)
        if this.topRankRewardItem == nil then
            this.topRankRewardItem = SeasonSLGTopRankRewardCom.New(ui.transTopRankReward)
            this.topRankRewardItem:SetData(tostring(SeasonSLGEventMgr.curGridIndex))
        end

        this.RefreshProgress(progress)
    else
        SetActive(ui.goProgress,false)
        SetActive(ui.goProgressUnLock,true)
        SetActive(ui.txtProgressAddUnLock.gameObject,false)
        SetActive(ui.animatorProgressUnLock.gameObject,false)
        this.RefreshLevelBuildProgress(progress)
        SetActive(ui.goScrollView,false)
        SetActive(ui.goBGUnLock,true)
        SetActive(ui.goBGLock,false)
        SetActive(ui.goRewardPreview,true)
        SetActive(ui.goActiveBuff,true)
        SetActive(ui.goTopRank,true)
        SetActive(ui.goTopRankReward,false)


        this.fullProgress = 0
        if this.topRankItem == nil then
            this.topRankItem = BlockTopRankCom.New(ui.transTopRank)
            this.topRankItem:SetData(this.vm.behaviour.Params[1],this.cfgGrid.GridHealth)
        end
        SeasonSLGMapMgr.CheckTopRanReward(SeasonSLGEventMgr.curGridIndex,this.vm.behaviour.Params[1])
    end
    SetActive(ui.goCostItemSelect,false)
    this.cfgMaxCount=this.cfgWorldBuild.MaxItem;
    this.dataWorldBuild=not IsNull(DataMgr.Player.SeasonalWorldBuild) and DataMgr.Player.SeasonalWorldBuild[tostring(SeasonSLGEventMgr.curGridIndex)]
    if this.dataWorldBuild~=nil then
        this.cfgMaxCount=this.cfgMaxCount-this.dataWorldBuild.DailyCount
    end

    this.costItemId=this.cfgWorldBuild.ConsumeResources[this.groupCount + 1].id
    this.costItemCount=this.cfgWorldBuild.ConsumeResources[this.groupCount + 1].count;
    this.RefreshCostItemSelect()
    this.SetCostItem()


    ui.txtTitle.text=ConfigMgr.LangGlobal(this.cfgWorldBuild.Name);
    ui.txtDes.text=ConfigMgr.LangGlobal(this.cfgWorldBuild.GridDesc);
    local key=string.format("%s_%s_%s","seasonal_world_dungeon_progress",SeasonSLGEventMgr.curGridIndex,this.cfgWorldBuild.Id)
    this.isComplete=SeasonSLGEventMgr.CheckLimitEventRewardIsComplete(key);
    this.SetBuildBuffUIList();
    this.SetProductCount();

end

this.RefreshCostItemSelect = function()
    this.costItemUIList:Clear();
    this.costItemList={}
    for i,v in ipairs(this.cfgWorldBuild.ConsumeResources) do
       local costItem={
            id = v.id,
            select = v.id == this.costItemId,
            callBack = this.OnClickCostItem,
       }
        if costItem.select then
            this.curSelectCostItemIndex = i
        end
       local costItemData=UIListData.GetData(this.costItemObj,"BuildCostItem",costItem)
       table.insert(this.costItemList,costItemData);
    end
    this.costItemUIList:SetData(this.costItemList);
end

this.OnClickCostItem = function(id)
    for i, v in ipairs(this.costItemList) do
        if v.data.id == id then
            v.data.select = true
            this.curSelectCostItemIndex = i
        else
            v.data.select = false
        end
    end
    this.costItemUIList:Refresh()

    if this.groupCount ~= nil then
        this.costItemId = this.cfgWorldBuild.ConsumeResources[this.groupCount + 1].id
        this.SetCostItem()
        SetActive(ui.goCostItemSelect,false)
    end
end

this.SetCostItem = function()
    this.costItemId=this.cfgWorldBuild.ConsumeResources[this.groupCount + 1].id
    this.costItemCount=this.cfgWorldBuild.ConsumeResources[this.groupCount + 1].count;
    local path=ConfigHelper.GetItemIconPath(this.costItemId)
    ui.rawCostIcon.texture=LuaMgr.GetTexture(path);
    ui.txtCostCount.text=this.costItemCount;
    this.maxGroupCount=#this.cfgWorldBuild.ConsumeResources - 1
    ui.sliderProduct.maxValue = this.maxGroupCount
end

this.RefreshProgress = function(progress)
    this.fullProgress=progress/this.cfgGrid.GridHealth
    local progressRate=this.fullProgress
    ui.txtProgressValue.text=string.format("%.1f%%",progressRate*100);
    if not this.progressAnimating then
        ui.imgProgress.fillAmount=progressRate;
    end
end

this.ShowProgressAdd = function(oldProgress, newProgress)
    local progressAdd = newProgress - oldProgress
    this.fullProgress = newProgress / this.cfgGrid.GridHealth
    if progressAdd <= 0 then
        this.RefreshProgress(newProgress)
        return
    end
    local per = string.format("%.2f%%",progressAdd/this.cfgGrid.GridHealth*100)
    local text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_34176")
    ui.txtProgressAdd.text=string.format(text,per)
    SetActive(ui.txtProgressAdd.gameObject,true)
    SetActive(ui.animatorProgress.gameObject,true)
    ui.animatorProgress:Play("SeasonSLGProgressAddAniClip",0,0)
    this.progressImg=ui.imgProgress
    this.progressFrom=oldProgress/this.cfgGrid.GridHealth
    this.progressTo=this.fullProgress
    this.progressDuration=0.35
    this.progressElapsed=0
    this.progressAnimating=true
    LuaMgr.RemoveUpdate(this.UpdateProgress)
    LuaMgr.AddUpdate(this.UpdateProgress)
end

this.UpdateProgress = function()
    this.progressElapsed=this.progressElapsed+UnityEngine.Time.unscaledDeltaTime
    local progressRate=math.min(this.progressElapsed/this.progressDuration,1)
    local progress=UnityEngine.Mathf.Lerp(this.progressFrom,this.progressTo,progressRate)
    local img=this.progressImg or ui.imgProgress
    img.fillAmount=progress
    if progressRate>=1 then
        img.fillAmount=this.progressTo
        this.progressAnimating=false
        LuaMgr.RemoveUpdate(this.UpdateProgress)
        if this.progressFinishAction~=nil then
            local finishAction=this.progressFinishAction
            this.progressFinishAction=nil
            finishAction()
        end
    end
end

this.SetProductCount=function()
    ui.txtSliderValue.text=(this.groupCount + 1) .. "/" .. (this.maxGroupCount + 1);
    local reItemId=this.cfgWorldBuild.ObtainItem[this.groupCount + 1].id
    local reCount=this.cfgWorldBuild.ObtainItem[this.groupCount + 1].count;
    this.productItem:SetData(reItemId, reCount, 1, 1, true);
end

this.SetBuildBuffUIList=function()
    this.buildBuffUIList:Clear();
    if this.Level == 0 then
        SetActive(ui.goBuffs,false)
        return
    end
    SetActive(ui.goBuffs,true)
    local list={}
    if #this.cfgWorldBuild.RewardBuff >= this.Level then
        local productBuff=ConfigMgr.Config.SeasonalProduceBuffMap[this.cfgWorldBuild.RewardBuff[this.Level]]
        if productBuff~=nil then
            local buffItem={
                itemId=productBuff.Type[1],
                des=LuaMgr.GetLangText(productBuff.NameLan);
                isBuff = false,
            }
            local buffItemData=UIListData.GetData(this.buildBuffItemObj,"BuildBuffItem",buffItem)
            table.insert(list,buffItemData);
        end
    end

    if #this.cfgWorldBuild.SeasonalBuff >= this.Level then
        local buff=ConfigMgr.Config.SeasonalBuffMap[this.cfgWorldBuild.SeasonalBuff[this.Level]]
        if buff~=nil then
            local buffItem={
                itemId=buff.BuffIcon,
                des=LuaMgr.GetLangText(buff.BuffDesLan);
                isBuff = true,
            }
            local buffItemData=UIListData.GetData(this.buildBuffItemObj,"BuildBuffItem",buffItem)
            table.insert(list,buffItemData);
        end
    end
    this.buildBuffUIList:SetData(list);
end

return vm({
    data = data,
    command = command,
    hook = hook
})