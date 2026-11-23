require("ViewModel/HMWY/Dispatch_AttrItem")
local this = {
    attrUIList={};
    attrItemObj=nil;
    callBack=nil;
    point2List={};
    isUnLock=false;
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
    ui.imgFillAmount = uiLink:Get("imgFillAmount"):GetComponent("Image");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnULock = uiLink:Get("btnULock"):GetComponent("Button");
    ui.rawIcon = uiLink:Get("rawIcon"):GetComponent("RawImage");
    ui.rawUnlockIcon = uiLink:Get("rawUnlockIcon"):GetComponent("RawImage");
    ui.txtName = uiLink:Get("txtName"):GetComponent("Text");
    ui.txtLevel = uiLink:Get("txtLevel"):GetComponent("Text");
    ui.txtAttr1 = uiLink:Get("txtAttr1"):GetComponent("Text");
    ui.txtAttr2 = uiLink:Get("txtAttr2"):GetComponent("Text");
    ui.txtAttr3 = uiLink:Get("txtAttr3"):GetComponent("Text");
    ui.txtAttr4 = uiLink:Get("txtAttr4"):GetComponent("Text");
    ui.txtAttr5 = uiLink:Get("txtAttr5"):GetComponent("Text");
    ui.txtAttr6 = uiLink:Get("txtAttr6"):GetComponent("Text");
    ui.tranAttrList = uiLink:Get("tranAttrList"):GetComponent("RectTransform");
    ui.tranPolygon02 = uiLink:Get("tranPolygon02"):GetComponent("RectTransform");
    ui.tranPoinst = uiLink:Get("tranPoinst"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
   uiLink:AddClickEvent("btnMask",function()
       if this.callBack~=nil then

           this.callBack(0);
       end
      LuaMgr.HidePanel(UIName.HMWYDispatchHeroInfoViewModel)
   end)
    uiLink:AddClickEvent("btnULock",function()
        this.OnAskBuyHero();
    end)
    
end

this.OnAskBuyHero=function()
    local askData={Id=this.heroId};
    ApiMgr.Request("HMWYGame/buyChar",askData,true,function(re)
        if this.callBack~=nil then
            this.callBack(1);
        end
       this.ParseData();
    end,function()  end,true)
end



local data = {}
local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour);
        this.attrUIList=UIListView.New(ui.tranAttrList);
        this.attrItemObj=vm.behaviour.transform:Find("template/attrItem").gameObject;
        this.tranPolygon=ui.tranPolygon02:GetComponent("LineChat");
        this.point2Obj=vm.behaviour.transform:Find("template/point2").gameObject;
        this.point2List={};
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>0 then
            this.heroId= vm.behaviour.Params[0];
            if vm.behaviour.Params.Length>1 then
                this.callBack=vm.behaviour.Params[1];
            end
            this.hmwyConstant=ConfigMgr.Config.HmwyDispatchConstants;
            this.hmwyRelic=ConfigMgr.Config.HmwyRelicStatsMap

            LuaMgr.RemoveUIEventListener(UIEventConst.HMWYDispatchId, this.UpdateData)
            LuaMgr.AddUIEventListener(UIEventConst.HMWYDispatchId, this.UpdateData);
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUIEventListener(UIEventConst.HMWYDispatchId, this.UpdateData)
        this.attrUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Dispatch_AttrItem");
    end
}

this.UpdateData=function(args)

    this.heroId= args[0]
    this.ParseData();
end


this.ParseData=function()
    this.hMWYGame=DataMgr.Player.HMWYGame;
    this.SetBaseInfo();
    this.SetAttrInfo();
end
this.SetBaseInfo=function()
    local cfgHero=ConfigMgr.Config.characterTable[this.heroId];
    local level=1;
    local proValue=0;
    if not IsNull(this.hMWYGame.Chars) and this.hMWYGame.Chars[this.heroId]~=nil then
        local heroData=this.hMWYGame.Chars[this.heroId];
        level=heroData.Level;
        local exp=heroData.Exp;
        local levelInfo=ConfigMgr.Config.HmwyHeroExpMap[tostring(level)];
        if levelInfo==nil then
            proValue=1;
        else 
           proValue=exp/levelInfo.Exp; 
        end
    end
    local path=ConfigHelper.GetCharacterAvatarPath(this.heroId);
    ui.rawIcon.texture=LuaMgr.GetTexture(path);
    ui.txtName.text=LuaMgr.GetLangText(cfgHero.namelan);
    ui.txtLevel.text=level;
    ui.imgFillAmount.fillAmount=proValue;
    if HMWYDispatchMgr.CheckHeroIsUnLock(this.heroId) then
        SetActive(ui.btnULock.gameObject,false)
        return;
    end
    SetActive(ui.btnULock.gameObject,true);
    local itemId=this.hmwyConstant.TokenCost[1].id
    local itemPath=ConfigHelper.GetItemHomeIconPath(itemId)
    ui.rawUnlockIcon.texture=LuaMgr.GetTexture(itemPath)
end



this.SetAttrInfo=function()
    local attrStr=ConfigMgr.LangGlobal("30104")
    local attrArray=NumTool.split(attrStr,"_");
    ui.txtAttr1.text=attrArray[1];
    ui.txtAttr2.text=attrArray[6];
    ui.txtAttr3.text=attrArray[5];
    ui.txtAttr4.text=attrArray[4];
    ui.txtAttr5.text=attrArray[3];
    ui.txtAttr6.text=attrArray[2];
    local attrList=HMWYDispatchMgr.GetHeroAttrList(this.heroId)
    local rateList={}
    local maxRate=this.hmwyConstant.MaxValue/10000;
    for i,v in ipairs(attrList) do
        local rate=v/this.hmwyConstant.HeroDefaultValue;
        rate=rate>maxRate and maxRate or rate;
        table.insert(rateList,rate);
    end
    this.tranPolygon:SetPoints(rateList)
    SetActive(this.tranPolygon.gameObject,false);
    SetActive(this.tranPolygon.gameObject,true);
    local points=HMWYDispatchMgr.GetPolygonPoints(rateList,ui.tranPoinst.sizeDelta.x)
    for i=1,#points,1 do
        local obj=this.point2List[i];
        if obj==nil then
            this.point2List[i]=LuaMgr.InstantiateGO(this.point2Obj, ui.tranPoinst, false);
            obj=this.point2List[i];
        end
        SetActive(obj,true);
        obj.transform.anchoredPosition=points[i];
    end
    this.SetAttrUIList(attrList,attrArray)
end

this.SetAttrUIList=function(attrList,nameList)
    this.attrUIList:Clear();
    local techTreeAdd=HMWYDispatchMgr.CalculateTechTree();
    local list={};
    for i,v in ipairs(attrList) do
        local attrItem={
            index=i,
            name=nameList[i],
            curValue=v*(1+techTreeAdd),
            maxValue=this.hmwyConstant.HeroDefaultValue;
        }
        local attrData=UIListData.GetData(this.attrItemObj,"Dispatch_AttrItem",attrItem);
        table.insert(list,attrData);
    end
    this.attrUIList:SetData(list);
end

return vm({
    data = data,
    command = command,
    hook = hook
})