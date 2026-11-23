






local this = {vm=nil};
local onDragBehaviour=nil;
local posList={{pos=Vector3(-575,0,0),angle=Vector3(0,-100,0),scale=Vector3(0.23,0.9,1),alpha=0.2},
               {pos=Vector3(-410,0,0),angle=Vector3(0,-50,0),scale=Vector3(0.27,0.9,1),alpha=0.5},
               {pos=Vector3(0,0,0),angle=Vector3(0,0,0),scale=Vector3(1,1,1),alpha=1.0},
               {pos=Vector3(410,0,0),angle=Vector3(0,50,0),scale=Vector3(0.27,0.9,1),alpha=0.5},
               {pos=Vector3(575,0,0),angle=Vector3(0,100,0),scale=Vector3(0.23,0.9,1),alpha=0.2},
               

}
local startDragX=0;
local sliderIndex=0;

local cfgDeconstructionMap={};
local dataDeconstructionMap={};
local mixIndex=nil;
local maxIndex=nil;
local speed=0.2;
local maxDargStep=300;
local dragDir=0;
local isNegativeDir=false;
local isOutArray=false;
local locateIndex=1;
local dragEndDir=nil;
local data = {
   pageList={{isOn=false}};
   destructList={{
                  markIndex=0,
                  tarIndex=0,
                  isActive=true,
                  titleSprite=DefaultSprite,
                  monsterHeadIcon1=DefaultTexture,
                  monsterHeadIcon2=DefaultTexture,
                  monsterHeadIcon3=DefaultTexture,
monsterHeadIcon4=DefaultTexture,
                  monsterBool1=false,
                  monsterBool2=false,
                  monsterBool3=false,
                  monsterBool4=false,

                  pro="",
                  proprass=1.0,
                  alpha=1.0,
                  buffText="",
                  buffIsOn=false}};
   btnName=LuaMgr.GetLangText("ClimbdestructViewModel_0");
}

local command = {

    destructBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          local curIndex=rightIndex-2
          local deconstruction=dataDeconstructionMap[tostring(curIndex)];
          if deconstruction==nil then

              this.UnlockStruct(curIndex);
              return;
          end
          local cfgDeconstruction=cfgDeconstructionMap[tostring(curIndex)];
          if deconstruction+1>#cfgDeconstruction.DungeonGroup then
              LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ClimbdestructViewModel_1"));
              return;
          end
          local dungeonId=cfgDeconstruction.DungeonGroup[deconstruction+1];
          LuaMgr.SetAreaBattleType(5);
          BattlePrepareMgr.ClimbtowerEnterBattlePrepare(dungeonId,"deconstruction",curIndex);
      end
    },
    
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
        onDragBehaviour=vm.behaviour.transform:Find("root/Middle/Middle_1/DragArea"):GetComponent("OnDragBehaviour");
        onDragBehaviour.onDrag=this.OnDrag;
        onDragBehaviour.onPointerDown=this.PointerDown;
        onDragBehaviour.onPointerUp=this.OnPointerUp;
        onDragBehaviour.onEndDrag=this.OnEndDrag;
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        startDragX=0;
        sliderIndex=0;
        cfgDeconstructionMap=ConfigMgr.Config.deconstructionMap;
        dataDeconstructionMap=DataMgr.Player.deconstruction;
        this.formatTable();
        this.ParseData();
       
    end,
    before_deactive = function(vm)
      
        print("before_deactive");
    end,
}


this.UnlockStruct=function(index)
    local unlockItemID=cfgDeconstructionMap[tostring(index)].UnlockItem;
    local count=DataHelper.GetItemCountById(unlockItemID);
    if count<1 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ClimbdestructViewModel_2"));
        return;
    end
    local askData={ID=index}
    ApiMgr.Request("tower/unlock", askData, true, function(result)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ClimbdestructViewModel_3"));
        this.vm.data.btnName=LuaMgr.GetLangText("ClimbdestructViewModel_4");
    end, nil, false);
end

this.formatTable=function()
    local newTable={};
    for i,v in pairs(cfgDeconstructionMap) do
        table.insert(newTable,v);
    end
    maxIndex=#newTable;

    local newTable2={};
    for i,v in pairs(dataDeconstructionMap) do
        table.insert(newTable2,v);
    end
    locateIndex=#newTable2;
end

this.ParseData=function()
    this.SetDestruct();
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


    if (not isNegativeDir and locateIndex>=maxIndex and deltaX<0) or (not isNegativeDir and locateIndex<=1 and deltaX>0) then
        isOutArray=true;
        return
    end
    dragDir=dragDir==0 and deltaX or dragDir;
    this.DragMove(deltaX);
end


this.DragMove=function(deltaX)
    if deltaX==0 then return end;
    dragEndDir=deltaX;
    local tarIndex=nil;
    for i,v in ipairs(this.vm.data.destructList) do
        tarIndex=v.markIndex;
        if isNegativeDir then

        elseif deltaX>0 then
            tarIndex=tarIndex+1;
        else
            tarIndex=tarIndex-1;
        end
        tarIndex=tarIndex%5;
        local deltaPos=posList[tarIndex+1].pos-v.pos; 
        local deltaAngle=posList[tarIndex+1].angle-v.angle
        local deltaScale=posList[tarIndex+1].scale-v.scale
        local deltaAlpha=posList[tarIndex+1].alpha-v.alpha;
        
        if deltaX>0 then
            this.vm.data.destructList[i].pos=this.vm.data.destructList[i].pos+deltaPos*deltaX*UnityEngine.Time.deltaTime*speed;
            this.vm.data.destructList[i].angle=this.vm.data.destructList[i].angle+deltaAngle*deltaX*UnityEngine.Time.deltaTime*speed;
            this.vm.data.destructList[i].scale=this.vm.data.destructList[i].scale+deltaScale*deltaX*UnityEngine.Time.deltaTime*speed;
            this.vm.data.destructList[i].alpha=this.vm.data.destructList[i].alpha+deltaAlpha*deltaX*UnityEngine.Time.deltaTime*speed;
        elseif deltaX<0 then
            this.vm.data.destructList[i].pos=this.vm.data.destructList[i].pos-deltaPos*deltaX*UnityEngine.Time.deltaTime*speed;
            this.vm.data.destructList[i].angle=this.vm.data.destructList[i].angle-deltaAngle*deltaX*UnityEngine.Time.deltaTime*speed;
            this.vm.data.destructList[i].scale=this.vm.data.destructList[i].scale-deltaScale*deltaX*UnityEngine.Time.deltaTime*speed;
            this.vm.data.destructList[i].alpha=this.vm.data.destructList[i].alpha-deltaAlpha*deltaX*UnityEngine.Time.deltaTime*speed;
        end
        v.tarIndex=tarIndex;
        
    end
    
    
end

this.OnEndDrag=function(eventData)
    if isOutArray then
        return;
    end
    this.DragEnd(dragEndDir,0.2);
end

this.DragEnd=function(dir,timer)
    if dir==0 then return end;
    for i,v in ipairs(this.vm.data.destructList) do
        v.markIndex=v.tarIndex;
        DOTWeen.To(function() return v.alpha  end,
                function(a) v.alpha=a  end,
                posList[v.tarIndex+1].alpha,timer);
        DOTWeen.To(function() return v.pos  end,
                function(vect) v.pos=vect  end,
                posList[v.tarIndex+1].pos,timer);
        DOTWeen.To(function() return v.angle  end,
                function(vect) v.angle=vect end,
                posList[v.tarIndex+1].angle,timer);
        DOTWeen.To(function() return v.scale  end,
                function(vect) v.scale=vect  end,
                posList[v.tarIndex+1].scale,timer)
        if not isNegativeDir then
            if (dir>0 and v.markIndex==0) or (dir<0 and v.markIndex==4) then
                this.UpdateDestructInfo(v,dir)
            end
        end
    end
    
end



this.UpdateDestructInfo=function(destuctItem,dir)
    local updateIndex=nil;
    if dir>=0 then
        locateIndex=locateIndex-1;
        updateIndex=locateIndex-2;
        this.SetPage(locateIndex);
        this.SetBtnName(locateIndex)
    else
        locateIndex=locateIndex+1;
        updateIndex=locateIndex+2;
        this.SetPage(locateIndex);
        this.SetBtnName(locateIndex)
    end
    local cfgDestruction=cfgDeconstructionMap[tostring(updateIndex)];
    if cfgDestruction==nil then
        destuctItem.isActive=false;
        return
    end;

    local monsterHeadIconList={};
    local monsterBoolList={}
    monsterHeadIconList,monsterBoolList=this.GetMonsterHeadIcon(cfgDestruction);
    
    local maxPrograss=#cfgDestruction.DungeonGroup
    local dataStruction=dataDeconstructionMap[tostring(cfgDestruction.ID)];
    local curPrograss=dataStruction~=nil and dataStruction+1 or 0;
    curPrograss=curPrograss>maxPrograss and maxPrograss or curPrograss;
    local  tmpBuffIsOn=dataStruction~=nil and dataStruction==maxPrograss;
    local  tmpBuffText=cfgDestruction.Describe;
    local  tmpPrograss=curPrograss/maxPrograss;
    local tmpPro=string.format("%s@%s",curPrograss,maxPrograss)

    destuctItem.titleSprite=LuaMgr.GetSprite("Climbtower",cfgDestruction.AreaIcon);
    destuctItem.monsterHeadIcon1=monsterHeadIconList[1];
    destuctItem.monsterHeadIcon2=monsterHeadIconList[2];
    destuctItem.monsterHeadIcon3=monsterHeadIconList[3];
    destuctItem.monsterHeadIcon4=monsterHeadIconList[4];
    destuctItem.monsterBool1=monsterBoolList[1];
    destuctItem.monsterBool2=monsterBoolList[2];
    destuctItem.monsterBool3=monsterBoolList[3];
    destuctItem.monsterBool4=monsterBoolList[4];
    destuctItem.pro=tmpPro;
    destuctItem.proprass=tmpPrograss;
    destuctItem.buffText=tmpBuffText;
    destuctItem.buffIsOn=tmpBuffIsOn;
    destuctItem.isActive=true;
end
    

this.SetDestruct=function()
    this.vm.data.destructList={};
    local list={};
    mixIndex=-1;
    local index=locateIndex-3;
    for i=1,5,1 do
        local destructItem=cfgDeconstructionMap[tostring(index+i)];
        local monsterHeadIconList={DefaultTexture,DefaultTexture,DefaultTexture,DefaultTexture};
        local monsterBoolList={false,false,false,false};
        local tmpPrograss=0.0;
        local tmpPro="";
        local tmpBuffIsOn=true;
        local tmpBuffText="";
        if destructItem~=nil then
            monsterHeadIconList,monsterBoolList=this.GetMonsterHeadIcon(destructItem);
            local maxPrograss=#destructItem.DungeonGroup
            local dataStruction=dataDeconstructionMap[tostring(destructItem.ID)];
            local curPrograss=dataStruction~=nil and dataStruction+1 or 0;
            curPrograss=curPrograss>maxPrograss and maxPrograss or curPrograss;
            tmpBuffIsOn=dataStruction~=nil and dataStruction==maxPrograss;

            tmpBuffText=destructItem.Describe;
            tmpPrograss=curPrograss/maxPrograss;
            tmpPro=string.format("%s@%s",curPrograss,maxPrograss)
        end
        local destructItem={
            pos=posList[i].pos,
            angle=posList[i].angle,
            scale=posList[i].scale,
            alpha=posList[i].alpha,
            markIndex=i-1;
            tarIndex=i-1;
            isActive=destructItem~=nil,
            titleSprite=destructItem~=nil and LuaMgr.GetSprite("Climbtower",destructItem.AreaIcon) or DefaultSprite,
            monsterHeadIcon1=monsterHeadIconList[1],
            monsterHeadIcon2=monsterHeadIconList[2],
            monsterHeadIcon3=monsterHeadIconList[3],
            monsterHeadIcon4=monsterHeadIconList[4],
            monsterBool1=monsterBoolList[1],
            monsterBool2=monsterBoolList[2],
            monsterBool3=monsterBoolList[3],
            monsterBool4=monsterBoolList[4],
            pro=tmpPro,
            proprass=tmpPrograss,
            buffText=tmpBuffText,
            buffIsOn=tmpBuffIsOn,
        }
        table.insert(list,destructItem);
    end
    this.vm.data.destructList=list;
    this.SetPage(1)
    this.SetBtnName(1);
end

this.SetPage=function(index)
    local len=maxIndex;
    local list={};
    for i=1,len,1 do
        local pageItem={
            isOn=i==index;
        }
        table.insert(list,pageItem);
    end
    this.vm.data.pageList=list;
end

this.SetBtnName=function(index)
    local re=dataDeconstructionMap[tostring(index)];
    this.vm.data.btnName=re~=nil and LuaMgr.GetLangText("ClimbdestructViewModel_5") or LuaMgr.GetLangText("ClimbdestructViewModel_6");
end


this.GetMonsterHeadIcon=function(destructItem)
    local monsterIds= destructItem.Monster;
    local monsterIcons={}
    local monsterBools={}
    for i,v in ipairs(monsterIds) do
        local texture=LuaMgr.GetTexture(ConfigHelper.GetMonsterAvatarPath(v));
        table.insert(monsterIcons,texture~=nil and texture or DefaultTexture);
        table.insert(monsterBools,true);
    end
    
    for i=1,4,1 do
        if i>#monsterIds then
            table.insert(monsterIcons,DefaultTexture);
            table.insert(monsterBools,false);
        end
    end
    return monsterIcons,monsterBools;
end

return vm({
    data = data,
    command = command,
    hook = hook
})