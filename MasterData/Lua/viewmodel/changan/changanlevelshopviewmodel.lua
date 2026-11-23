




require("ViewModel/Changan/Changan_LevelShopItem")
local this = {
    vm=nil,
    appraisalList={},
    dataExQuests={},
    curAppraisal=nil,
    unConvertAppraisalList={};
    myCount=nil;
    levelShopUIList=nil;
    levelShopItemObj=nil;
    fx_streamer=nil;
    fx_burst=nil;
    midRect=nil;
    stramerOrgPos=Vector2(-260,-295);
    stopClick=false;
    resultData=nil;
};
local data = {
   shopList={
       {
           icon=DefaultSprite,
           isIcon=false,
           isLock=false,
           isDoing=false,
           isDone=false,
       }
   },
   goodsList={
       {
           isReward=false,
           alpha=1.0
       }
   },
   isPopUp=false,
   goods_Name="",
   goods_Des="",
   goods_DesAchorPos=Vector2(0,0);
   goods_rawIcon=DefaultSprite,
   isConvertBtn=false,
   isConvertMask=false,
   costIcon=DefaultTexture,
   costCount="",
   msgText="",
   msgBool=false,
}

local command = {
    convertShopBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if this.stopClick then return end;
            this.stopClick=true;
            if this.curAppraisal==nil and this.myCount>0 then
                local tip= LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10000"].NameLan);
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tip,function()
                    LuaMgr.ShowLuaPanel(UIName.ChanganShopViewModel);
                end,function()
                    this.stopClick=false
                end)
                return;
            elseif this.curAppraisal==nil  then
                return
            end
            local requestCallBack=function()
                local askData={questId=this.curAppraisal.id,count=1}
                ApiMgr.Request("ex/shop_convert", askData, true, function(result)
                    local re=json.decode(result);
                    this.resultData=json.encode(re.result);
                    this.vm.data.isPopUp=true;
                    this.SetPopUpInfo(this.curAppraisal,false);
                end, nil, true);
            end
            this.PlayConverAnimation(requestCallBack);
        end
    },
    closeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.isPopUp=false;
            if this.resultData~=nil then
                LuaMgr.ShowItemRewared(this.resultData);
            end
            this.ParseData();
        end
    },
    msgBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if this.vm.data.msgBool then
                this.vm.data.msgBool=false;
                return;
            end
            this.vm.data.msgBool=true;
            this.SetMsgText();
        end
    }
    

}
this.ShopItemCommand=function(index)
local shopItem=this.levelShopUIList.itemList[index].data;
    this.vm.data.isPopUp=true;
    this.SetPopUpInfo(shopItem,true)
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.levelShopUIList = UIListView.New(vm.behaviour.transform:Find("root/Middle/content"));
        this.levelShopItemObj=vm.behaviour.transform:Find("template/shopItem").gameObject;
        this.fx_streamer=vm.behaviour.transform:Find("root/Middle/fx_streamer").transform;
        this.fx_burst=vm.behaviour.transform:Find("root/Middle/fx_burst").transform;;
        this.midRect=vm.behaviour.transform:Find("root/Middle");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            ChanganMgr.InitData();
            this.appraisalList=ChanganMgr.changanAppraisalQuestEventList;
            table.sort(this.appraisalList,function(a, b) return a.id<b.id end)
            this.vm.data.isPopUp=false
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if this.resultData~=nil then
                LuaMgr.ShowItemRewared(this.resultData);
            end
        end
    end,
    before_destroy=function()
  
    end
        
    
}

this.Clear=function()
    this.appraisalList=nil;
end

this.ParseData=function()
    this.resultData=nil;
    this.stopClick=false;
    this.vm.data.msgBool=true;
    this.dataExQuests=DataMgr.Player.quests;
    this.fx_streamer.anchoredPosition=this.stramerOrgPos;
    SetActive(this.fx_streamer.gameObject,false);
    SetActive(this.fx_burst.gameObject,false);
    this.SetShopList();
    this.SetMsgText();
end

this.SetMsgText=function()
    local tipList=ConfigMgr.Config.constants.changanTipList
    math.randomseed(os.time())
    local randIndex = math.random(1, #tipList)
    local tip= LuaMgr.GetLangText(ConfigMgr.Config.langGlobal[tipList[randIndex]].NameLan);
    this.vm.data.msgText=tip;
end


this.SetShopList=function()
    local listData={}
    local shopItem=nil;
    local dataShop=nil;
    this.unConvertAppraisalList={};
    this.curAppraisal=nil
    local costItem=this.appraisalList[1].cost[1];
    this.myCount=DataHelper.GetItemCountById(costItem.id);
    this.vm.data.costIcon=ConfigHelper.GetItemTexture(costItem.id)
    this.vm.data.costCount=tostring(costItem.count);
    for i,v in ipairs(this.appraisalList) do
        dataShop=this.dataExQuests[v.id];
        shopItem={
            index=i,
            id=v.id,
            icon=LuaMgr.GetSprite("Changan","ui_ca_appraisal_"..v.id);
            isIcon=dataShop.state==3,
            isLock=dataShop.state~=3,

            isDone=dataShop.state==3,
            showReward=v.showReward,
            nameLan=v.namelan,
            remarksLan=v.remarksLan,
            callBack=this.ShopItemCommand;
        }
        if not shopItem.isDone then
            table.insert(this.unConvertAppraisalList,shopItem);
        end
        local itemData=UIListData.GetData(this.levelShopItemObj,"Changan_LevelShopItem",shopItem);
        table.insert(listData,itemData);
    end
    if  this.myCount>=costItem.count and #this.unConvertAppraisalList>0then
        math.randomseed(os.time())
        local randIndex = math.random(1, #this.unConvertAppraisalList)
        this.curAppraisal=this.unConvertAppraisalList[randIndex];
    end
    this.vm.data.isConvertBtn=this.myCount>0;
    this.vm.data.isConvertMask=this.myCount==0
    this.levelShopUIList:SetData(listData);
end

this.SetPopUpInfo=function(shopItem,isReward)
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/terms_spring.mp3");
    this.vm.data.goods_Name=LuaMgr.GetLangText(shopItem.nameLan);
    this.vm.data.goods_Des=LuaMgr.GetLangText(shopItem.remarksLan);
    this.vm.data.goods_DesAchorPos=Vector2(10,0);
    this.vm.data.goods_rawIcon=shopItem.icon;
    this.SetGoodsList(shopItem.showReward,isReward);
end


this.SetGoodsList=function(showReward,isReward)
    local list={}
    for i,v in ipairs(showReward) do
        local goodItem=ConfigHelper.CreateGoodsItem(v.id,v.count,0.65,true,true);
        goodItem.isReward=isReward;
        goodItem.alpha=isReward and 0.5 or 1.0;
        table.insert(list,goodItem);
    end
    this.vm.data.goodsList=list;
end

this.PlayConverAnimation=function(requestCallBack)
    SetActive(this.fx_streamer.gameObject,true);
    SetActive(this.fx_burst.gameObject,false)
    local tarIndex=this.curAppraisal.index;
    local worldPos=this.levelShopUIList.itemList[tarIndex].transform.position;
    local tarPos=LuaMgr.World2Local(worldPos,this.midRect);
    local time=UnityEngine.Vector2.Distance(tarPos,this.stramerOrgPos)*0.001



    local path=this.GetPathList(Vector3(this.stramerOrgPos.x,this.stramerOrgPos.y,0),Vector3(tarPos.x,tarPos.y,0));
    local tweener=this.fx_streamer:DOLocalPath(path,time+0.1,CS.DG.Tweening.PathType.CatmullRom);
    tweener.onComplete=function()
        this.fx_burst.anchoredPosition=tarPos;
        SetActive(this.fx_streamer.gameObject,false)
        SetActive(this.fx_burst.gameObject,true)
        coroutine_runner.start(function()
            coroutine_runner.wait(0.7)
            if requestCallBack~=nil then
                requestCallBack();
            end
        end)
    end
end

this.GetPathList=function(starPos,endPos)
    local dir=endPos-starPos;
    local distance=UnityEngine.Vector3.Distance(starPos,endPos)/2;
    local midPos=starPos+UnityEngine.Quaternion.Euler(0,0,45)*dir.normalized*distance;
    local path={starPos,midPos,endPos};
    return path;
end

return vm({
    data = data,
    command = command,
    hook = hook
})