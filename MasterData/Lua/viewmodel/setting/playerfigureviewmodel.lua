





local this = {vm=nil};
local skinPath="Assets/_BundleResources/Character/"
local msgViewModel=nil;
local spineUICharacter=nil;
local data_playerSkins=nil;
local cfg_playerSkins=nil;
local curSkinId=nil;
local curIndex=nil;
local playerSkinId=nil;
local skinDragBehaviour=nil;
local locPos=nil;
local rectTransform=nil;
local isDrag=false;
local spinePosLimit={}
local animator=nil;
local animaName="ani_ui_PlayerfigurePanel_root_002";
local data = {
    skinList={
        {
            redId="",
            id="",
            iconTexture=DefaultTexture,
            tag=DefaultSprite,
            selectBool=false,
        }
    },
    jobTeamSprite=DefaultSprite;
    bodyRawBool=false;
    characterPath="";
    skinBtnBool=true;
    hasSkinBool=false;
    hideBool=true;
    returnBool=false;
    spinePos=Vector2(-155,213);
    spineScale=Vector3(1.2,1.2,1.2);
    sliderValue=0.0;
}

local command = {
    leftBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          if curIndex<=1 then
              return;
          end
          curIndex=curIndex-1;
          this.SwitchSkin(curIndex);
      end
    },
    rightBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if curIndex>=#this.vm.data.skinList then
                return;
            end
            curIndex=curIndex+1;
            this.SwitchSkin(curIndex);
        end
    },
    playerSkinBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local askData={Skin=curSkinId};
            ApiMgr.Request("select_skin", askData, true, function(result)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2262"].NameLan))
               this.ParseData();
            end, nil, true);
        end
    },
    hideBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.hideBool=false;
            this.vm.data.returnBool=true;
            isDrag=true;
            this.vm.data.sliderValue=0.0;
            this.HidePanel(true);
        end
    },
    returnBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            isDrag=false;
            this.vm.data.hideBool=true;
            animator:Play(animaName);
            this.vm.data.returnBool=false;
            this.HidePanel(false);
        end
    },
    skinItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
            if curIndex==index then return end;
            curIndex=index;
            this.SwitchSkin(index);
        end
    },
    skinSlider={
        type=XLuaCommandType.Float,
        execute=function(vm,value)
            this.SliderSkinScale(value);
        end
    }
  
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;

        RedMgr.Singleton:RegisterViewModel(UIName.PlayerFigureViewModel);
        animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
        msgViewModel = vm.behaviour.transform:Find("root/Left/group/CharacterMsgItem"):GetComponent("CharacterMsgViewModel");
        spineUICharacter=vm.behaviour.transform:Find("root/Middle/DrawingSpine/Spine/Group/Body"):GetComponent("UISpineCharacter");
        rectTransform=vm.behaviour.transform:Find("root/Middle/DrawingSpine/Spine"):GetComponent('RectTransform')
        skinDragBehaviour = vm.behaviour.transform:Find("root/Middle/DrawingSpine/Spine"):GetComponent("OnDragBehaviour");
        skinDragBehaviour.onDrag = this.SkinOnDrag;
        skinDragBehaviour.onEndDrag = this.SkinOnEndDrag;
        skinDragBehaviour.onPointerDown=this.SkinonPointerDown
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        curIndex=-1;
        local halfScreenWidth=LuaMgr.ScreenWidth()/2;
        spinePosLimit={halfScreenWidth+100,-halfScreenWidth+100,900,0};
        this.ParseData();

    end,
    before_deactive = function(vm)
        if spineUICharacter~=nil then
            spineUICharacter:Clear();
        end
    end,
}

this.OnBack=function()
    HeroRedDataHelper.ClearPlayerSkin();
    LuaMgr.Back();
end

this.ParseData=function()
    cfg_playerSkins=ConfigMgr.Config.playerSkinMap;
    data_playerSkins=DataMgr.Player.playerSkins;
    isDrag=false;
    this.vm.data.sliderValue=0.0;
    this.vm.data.spinePos=Vector2(-155,213);
    this.vm.data.spineScale=Vector3(1.2,1.2,1.2);
    this.vm.data.hideBool=true;
    this.vm.data.returnBool=false;
    this.SetSKinList();
    this.SetCharacter();
    this.SetCharacterMsg();
end


this.SwitchSkin=function(index)
    for i, v in ipairs(this.vm.data.skinList) do
        local re=i==index;
        v.selectBool=not re;
    end
    curSkinId=this.vm.data.skinList[index].id;
    HeroRedDataHelper.ClearPlayerSkin(curSkinId);
    this.SetCharacter();
end


this.SetCharacter=function()
    if curSkinId==nil then return end;
    local skinInfo=cfg_playerSkins[curSkinId];
    this.vm.data.hasSkinBool=curSkinId==playerSkinId;
    this.vm.data.skinBtnBool=curSkinId~=playerSkinId;
    this.vm.data.jobTeamSprite=LuaMgr.GetSprite("PlayerFigure",skinInfo.TypeNamePic);
    local path=HeroManager.SetCharacterDrawing(spineUICharacter,skinInfo.Id);
    if path~="" then
        this.vm.data.bodyRawBool=true;
        this.vm.data.characterPath=path;
        this.vm.data.spineScale = Vector3(1.2,1.2,1.2);
    end
end


this.SetCharacterMsg=function()
    
    
end


this.SetSKinList=function()
    this.vm.data.skinList={};
    local list={};
    for i,v in pairs(data_playerSkins) do
        if cfg_playerSkins[i]~=nil then
            local skinInfo=cfg_playerSkins[i];
            local path=skinPath..i.."/Cards/"..i.."001.png";
            local skinItem={
                iconTexture=LuaMgr.GetTexture(path),
                tag=LuaMgr.GetSprite("PlayerFigure",skinInfo.TypeCardPic),
                selectBool=not v,
                id=i,
                redId="1114_"..i,
            }
            table.insert(list,skinItem);
            RedMgr.Singleton:UpdateClientRedData("1114_"..i,HeroRedDataHelper.setting_playerSkinsRedList[i]);
        end
    end
    table.sort(list,function(a, b) return a.id<b.id end)
    this.vm.data.skinList=list;
    for _i,_v in ipairs(list) do
        if not _v.selectBool then
            curSkinId=_v.id;
            playerSkinId=_v.id;;
            curIndex=_i;
        end
          
    end
    list=nil;
end

this.HidePanel=function(isHide,callBack)
    local tarPos=isHide and Vector2(70,208) or Vector2(-155,213);
    DOTWeen.To(function() return this.vm.data.spinePos  end,
            function(vect) this.vm.data.spinePos=vect end,
            tarPos,0.5).onComplete=function()
        if callBack~=nil then
            callBack();
        end
    end;
    this.DOScale(isHide);
end

this.SliderSkinScale=function(value)
    this.vm.data.spineScale=Vector3(1,1,1)+Vector3(value,value,value);
end


this.DOScale=function(isHide)
    DOTWeen.To(function() return this.vm.data.spineScale  end,
            function(vect) this.vm.data.spineScale=vect end,
            isHide and Vector3.one or Vector3(1.2,1.2,1.2),0.5);
    
end

this.SkinonPointerDown=function(eventData) 
    if not isDrag then return end;
    locPos=LuaMgr.Screen2Local(eventData.position,rectTransform)
end

this.SkinOnDrag=function(eventData)
    if not isDrag then return end;
    local tarPos=LuaMgr.Screen2Local(eventData.position,rectTransform)
    local dirVector=tarPos-locPos;
    if this.vm.data.spinePos.x>spinePosLimit[1] and dirVector.x>0 then
        dirVector=Vector2(0,dirVector.y)
    end
    if this.vm.data.spinePos.x<spinePosLimit[2] and dirVector.x<0 then
        dirVector=Vector2(0,dirVector.y)
    end
    if this.vm.data.spinePos.y>spinePosLimit[3] and dirVector.y>0 then
        dirVector=Vector2(dirVector.x,0)
    end
    if this.vm.data.spinePos.y<spinePosLimit[4] and dirVector.y<0 then
        dirVector=Vector2(dirVector.x,0)
    end
    this.vm.data.spinePos=this.vm.data.spinePos+dirVector;

end




return vm({
    data = data,
    command = command,
    hook = hook
})