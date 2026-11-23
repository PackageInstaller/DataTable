




local this = {vm=nil};
local cfgTravelCard={};
local cardId=nil;
local onDragBehaviour=nil;
local startDragX=0;
local maxDargStep=300;
local speed=0.2;
local path="Images/TravelCards/"
local lowOrder=16;
local dragDir=0;
local isNegativeDir=false;
local dataPostcards={};
local travelCardList={}
local maxLength=nil;
local locIndex=nil;
local norVM=nil;
local isOutArray=false;
local dragEndDir=nil;
local callBack=nil;
local tempList={{pos=Vector2(-410,0),order=18,scale=Vector3(0.67,0.67,0.67)},
                {pos=Vector2(-220,0),order=19,scale=Vector3(0.9,0.9,0.9)},
                {pos=Vector2(0,0),order=20,scale=Vector3(1,1,1)},
                {pos=Vector2(220,0),order=19,scale=Vector3(0.9,0.9,0.9)},
                {pos=Vector2(410,0),order=18,scale=Vector3(0.67,0.67,0.67)},}

local data = {
    cardList={
        {
            isActive=false;
            markIndex=0;
            cardPos=Vector2(0,0);
            cardOrder=0;
            cardScale=Vector3(0,0,0);
            poem1="",
            poem2="",
            cardTexture=DefaultTexture;
            loc="",
            mail="",
            maskBool=false,
            imageName="",
        }
    },
    shareBool=false,
    isShareBtn = false,
}

local command = {

    nextBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if locIndex<=1 then
                return;
            end
            this.AdsorpTo(1,0.3);
        end
    },
    lastBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if locIndex>=maxLength then
                return
            end
            this.AdsorpTo(-1,0.3);
        end
    },
    closeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.HidePanel(UIName.TravelCardsViewModel);
        end
    },
    loadBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.HidePanel("Laigu.ViewModel.TopBarViewModel")
            this.vm.data.shareBool=false;
            local imageName=travelCardList[locIndex].SetContent1;
            local filename = string.format("/travel/%s.png",imageName);
            LuaMgr.NextFrame(function()
                LuaMgr.CaptureScreenshot(filename)
                LuaMgr.NextFrame(function()
                    this.vm.data.shareBool=true;
                    norVM.behaviour:UpdateTopBar("",nil);
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TravelCardsViewModel_0"));
                end);
            end)
        end
    },
    shareBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.HidePanel("Laigu.ViewModel.TopBarViewModel")
            LuaMgr.HidePanel(UIName.MessageTipsViewModel);
            LuaMgr.HidePanel(UIName.NoticeRollhorseViewModel)
            this.vm.data.shareBool=false;
            local filename = "screenshot/shareScreenshot.png"
            LuaMgr.NextFrame(function()
                LuaMgr.CaptureScreenshot(filename)
                local path = UnityEngine.Application.persistentDataPath..'/'..filename
                LuaMgr.NextFrame(function()
                    LuaMgr.ShowPanel("Laigu.ViewModel.SharePopupViewModel","travel",path,function()
                        this.vm.data.shareBool = true
                        norVM.behaviour:UpdateTopBar("",nil);
                    end)
                end)
            end)
        end
    },
    
}


local hook = {
    before_awake = function(vm)
        this.vm=vm;
        onDragBehaviour=vm.behaviour.transform:Find("root/Middle/DragArea"):GetComponent("OnDragBehaviour");
        onDragBehaviour.onDrag=this.OnDrag;
        onDragBehaviour.onPointerDown=this.PointerDown;
        onDragBehaviour.onEndDrag=this.OnEndDrag;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>1 then
                local data=vm.behaviour.Params;
                cfgTravelCard=data[0];
                cardId=data[1];
                norVM=data[2];
                if vm.behaviour.Params.Length>3 then
                    callBack=data[3];
                end
                locIndex=1
                this.PlayRandomAudio();
                this.ParseData();
                this.CheckShareBtn();
            end
        end
    end,
    before_deactive = function(vm)
        if callBack~=nil then
            callBack();
        end
        callBack=nil;
    end,
}

this.CheckShareBtn = function()
    local channel = LuaMgr.GetChanel();
    local shareChannel = ConfigMgr.Config.ShareChannel;
    local showShare = false
    local channelData = nil
    for _, v in pairs(shareChannel) do
        if (v.ChannelId == channel) then
            channelData = v;
            break;
        end
    end
    if (channelData ~= nil) then
        showShare = not channelData.Close and not ConfigMgr.Config.constants.CloseShare;
    end
    this.vm.data.isShareBtn = showShare;
end

this.PlayRandomAudio=function()
    math.randomseed(os.time());
    local index=math.random(1,3)
    local audioName="newUI/travel_CardOpen_"..index;
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. audioName..".mp3");
end

this.ParseData=function()
    if #cfgTravelCard==0 then return end;
    this.vm.data.shareBool=true;
    travelCardList={};
    dataPostcards=DataMgr.Player.postcards;
    local count=0;
    for i,v in pairs(cfgTravelCard) do
        if dataPostcards[v.Item]~=nil then
            table.insert(travelCardList,v);
            count=count+1;
            if v.Id==cardId then
                locIndex=count;
            end
        end
    end
    maxLength=#travelCardList;
    this.vm.data.cardList={};
    local list={};
local starIndex=locIndex-3;
    for i=1,5,1 do
        local travelCard=travelCardList[starIndex+i]
        local cardItem={
            markIndex=i-1;
            cardPos=tempList[i].pos;
            cardOrder=tempList[i].order;
            cardScale=tempList[i].scale;
            imageName="";
            maskBool=i~=3;
            tarIndex=0;
        }
        if travelCard~=nil then
            cardItem.cardTexture=LuaMgr.GetTexture(path..travelCard.SetContent1..".png");
            local poems=NumTool.split(LuaMgr.GetLangText(travelCard.SetContent2Lan),";")
            cardItem.poem1=poems[1];
            cardItem.poem2=#poems>1 and poems[2] or "";
            cardItem.imageName=travelCard.SetContent1;
            cardItem.mail=travelCard.SetContent3;
            cardItem.loc=LuaMgr.GetLangText(travelCard.SetContent4Lan);
            cardItem.isActive=true;
        else
            cardItem.cardTexture=DefaultTexture
            cardItem.poem1=""
            cardItem.poem2=""
            cardItem.imageName=""
            cardItem.loc=""
            cardItem.mail=""
            cardItem.isActive=false;
        end
        table.insert(list,cardItem);
    end
    this.vm.data.cardList=list;
end

this.PointerDown=function(eventData)
    dragDir=0;
    isNegativeDir=false;
    startDragX=eventData.position.x;
end
this.OnDrag=function(eventData)
    local deltaX=eventData.delta.x;

    if deltaX>maxDargStep then
        deltaX=maxDargStep;
    elseif deltaX<-maxDargStep then
        deltaX=-maxDargStep;
    end
    
    isOutArray=false;





    

    if (dragDir>0 and deltaX<0) or (dragDir<0 and deltaX>0) then
        isNegativeDir=true;
    elseif (dragDir>0 and deltaX>0) or (dragDir<0 and deltaX<0) then
        isNegativeDir=false;
    end
    

    if (not isNegativeDir and locIndex>=maxLength and deltaX<0) or (not isNegativeDir and locIndex<=1 and deltaX>0) then
        isOutArray=true;
        return
    end
    dragDir=dragDir==0 and deltaX or dragDir;
    this.DoMoveCardItem(deltaX);
    
end
        

this.OnEndDrag=function(eventData)
    if isOutArray then
        return;
    end
    this.DragEnd(dragEndDir,0.2)
end



this.DoMoveCardItem=function(deltaX)
    if deltaX==0 then return end;
    dragEndDir=deltaX;

    local tarIndex=nil
    for i,v in ipairs(this.vm.data.cardList) do
        tarIndex=v.markIndex;
        if isNegativeDir then

        elseif deltaX>0 then
            tarIndex=tarIndex+1;
        else
            tarIndex=tarIndex-1;
        end
        tarIndex=tarIndex%5;
        
        local stepPos=tempList[tarIndex+1].pos-v.cardPos
        local stepScale=tempList[tarIndex+1].scale-v.cardScale
        local tarOrder=tempList[tarIndex+1].order;
     
        if deltaX>0 then
            v.cardPos=v.cardPos+stepPos*deltaX*UnityEngine.Time.deltaTime*speed
            v.cardScale=v.cardScale+stepScale*deltaX*UnityEngine.Time.deltaTime*speed
        else
            v.cardPos=v.cardPos-stepPos*deltaX*UnityEngine.Time.deltaTime*speed
            v.cardScale=v.cardScale-stepScale*deltaX*UnityEngine.Time.deltaTime*speed
        end

        if deltaX>0 and tarIndex==0 or  deltaX<0 and tarIndex==4 then
            v.cardOrder=lowOrder;
        else
            v.cardOrder=tarOrder;
        end
        v.maskBool=tarIndex+1~=3
        v.tarIndex=tarIndex;
    end
    
end

this.DragEnd=function(dir,timer)
    if dir==0 then return end;
    for i,v in ipairs(this.vm.data.cardList) do
        v.markIndex=v.tarIndex;
        DOTWeen.To(function() return v.cardPos  end,
                function(vect) v.cardPos=vect end,
                tempList[v.tarIndex+1].pos,timer);
        DOTWeen.To(function() return v.cardScale  end,
                function(vect) v.cardScale=vect end,
                tempList[v.tarIndex+1].scale,timer);
        if not isNegativeDir then
            if (dir>0 and v.markIndex==0) or (dir<0 and v.markIndex==4) then
                this.UpdateDate(v,dir)
            end
        end
    end
end



this.AdsorpTo=function(dir,timer)
    if dir==0 then return end;
    local tarIndex=nil;
    local halfStepList={}
    local orderList={}
    for i,v in ipairs(this.vm.data.cardList) do
        tarIndex=v.markIndex;
        if dir>0 then
            tarIndex=tarIndex+1;
        else
            tarIndex=tarIndex-1;
        end
        tarIndex=tarIndex%5;
        v.markIndex=tarIndex;
        v.maskBool=v.markIndex~=2;
        local step=(tempList[tarIndex+1].pos.x-v.cardPos.x)/2+v.cardPos.x;
        table.insert(halfStepList,step);
        table.insert(orderList,tempList[tarIndex+1].order);
        v.cardOrder=orderList[i];

        if (dir>0 and v.markIndex==0) or (dir<0 and v.markIndex==4) then
            this.UpdateDate(v,dir)
        end
        
        DOTWeen.To(function() return v.cardPos  end,
                function(vect)
                    v.cardPos=vect
                end,
                tempList[tarIndex+1].pos,timer);
        DOTWeen.To(function() return v.cardScale  end,
                function(vect) v.cardScale=vect end,
                tempList[tarIndex+1].scale,timer).onComplete=function()
           
        end;

    end
    
end
        
    



this.UpdateDate=function(cardItem,dir)
    this.PlayRandomAudio();
    local updateIndex=nil;
    if dir>0 then
        locIndex=locIndex-1;
        updateIndex=locIndex-2;
    else
        locIndex=locIndex+1;
        updateIndex=locIndex+2;
    end
   
    local updateCard=travelCardList[updateIndex];
    if updateCard~=nil then
        cardItem.cardTexture=LuaMgr.GetTexture(path..updateCard.SetContent1..".png");
        local poems=NumTool.split(LuaMgr.GetLangText(updateCard.SetContent2Lan),";")
        cardItem.poem1=poems[1];
        cardItem.poem2=#poems>1 and poems[2] or "";
        cardItem.mail=updateCard.SetContent3;
        cardItem.imageName=updateCard.SetContent1;
        cardItem.loc=LuaMgr.GetLangText(updateCard.SetContent4Lan);
        cardItem.isActive=true;
    else
        cardItem.isActive=false;
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})