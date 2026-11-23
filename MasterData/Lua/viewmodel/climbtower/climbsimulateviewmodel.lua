






local this = {vm=nil};
local onDragBehaviour=nil;
local BGPos={Vector3(-1508,0,0),Vector3(0,0,0),Vector3(1508,0,0)}
local dragSpeed=50;
local elastic=0;
local maxDelta=100;
local rightOffset=0;
local leftOffSet=0
local width=1006;
local startDragX=0;
local cfgSimulation={};
local cfgDeconstruction={}
local cfgDungeon={};
local maxLength=nil;
local normalLength=10;
local simulateRightIndex=0;
local simulateleftIndex=0;
local simulateMaxIndex=0;
local dataSimulationTraining=nil;
local lastSimulateItem={};
local curCfgIndex=nil;
local curDungeonId=nil;
local curBG={};
local climb_clicks = { 
    "newUI/climb_click-001.mp3",
    "newUI/climb_click-002.mp3",
    "newUI/climb_click-003.mp3"
}
local data = {
    BGList={{pos=Vector3(-1006,0,0),cententBool=true,index=0,dir=-1;
             simulateItemList={
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false}
             }},
            {pos=Vector3(0,0,0),cententBool=true,index=0,dir=0;
             simulateItemList={
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false}
             }},
            {pos=Vector3(1006,0,0),cententBool=true,index=0,dir=1;
             simulateItemList={
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false},
                 {cIndex=0,cUnlock=false,cNum="",icon=DefaultSprite,pass=false,cur=false,lineSprite=DefaultSprite,num1Sprite=DefaultSprite,num2Sprite=DefaultSprite,num3Sprite=DefaultSprite,num3Bool=false,line1Bool=false,line2Bool=false,line3Bool=false}
             }}
    },
    rewardList={{id="1",count=tostring(0),isCount=true,sizeDelta=Vector2(0,0),rare=DefaultSprite,icon=DefaultTexture,scale=Vector3(0,0,0),isClick=true}},
    name="";
    
}

local command = {

    simulateBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          if DataMgr.Player.simulationTraining>NumTool.GetLen(cfgSimulation) then
              LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ClimbsimulateViewModel_0"));
              return;
          end
          if curCfgIndex>dataSimulationTraining then
              LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ClimbsimulateViewModel_1"))
              return;
          end
          LuaMgr.SetAreaBattleType(BattleType.Climbtower);
          BattlePrepareMgr.ClimbtowerEnterBattlePrepare(curDungeonId,"simulationTraining");
      end
    },

    destructBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ClimbsimulateViewModel_2"));

        end
    },
    locationBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)

            this.DOMoveLocation();
        end
    },
    simulateItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local num=tonumber(param)-1;
            local num_1=math.floor(num/10)+1;
            local num_2=num%10+1;

            local selectIndex=this.vm.data.BGList[num_1].index;
            local cIndex=(selectIndex-1)*10+num_2;
            if cIndex<dataSimulationTraining then
                return
            end
            local random = math.random(1, 3)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. climb_clicks[random])
            this.ShowSimalateItem(num_1,num_2);
        end
    }

}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
        onDragBehaviour=vm.behaviour.transform:Find("root3D/Content"):GetComponent("OnDragBehaviour");
        onDragBehaviour.onDrag=this.OnDrag;
        onDragBehaviour.onPointerDown=this.PointerDown;
        onDragBehaviour.onPointerUp=this.OnPointerUp;
        onDragBehaviour.onEndDrag=this.OnEndDrag;
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params == nil) then return end
        cfgSimulation=ConfigMgr.Config.simulationTrainingMap;
        cfgDeconstruction=ConfigMgr.Config.deconstructionMap
        cfgDungeon=ConfigMgr.Config.dungeonMap;
        dataSimulationTraining=DataMgr.Player.simulationTraining;
        local cfgLen=NumTool.GetLen(cfgSimulation);
        if dataSimulationTraining>cfgLen then
            dataSimulationTraining=cfgLen;
        end
        math.randomseed(os.time())
        this.ParseData();
    end,
    before_deactive = function(vm)

        this.vm.data.BGList[1].pos=Vector3(-1006,0,0);
        this.vm.data.BGList[1].dir=-1;
        this.vm.data.BGList[2].pos=Vector3(0,0,0);
        this.vm.data.BGList[2].dir=0;
        this.vm.data.BGList[3].pos=Vector3(1006,0,0);
        this.vm.data.BGList[3].dir=1;
        print("before_deactive");
        
    end,
}

this.PointerDown=function(eventData)
    startDragX=eventData.position.x;
end

this.OnDrag=function(eventData)
    local detaX=eventData.delta.x;
    if detaX>maxDelta then
        detaX=maxDelta;
    elseif  detaX<-maxDelta then

        detaX=-maxDelta;
    end

    local dragingX=detaX*dragSpeed*UnityEngine.Time.deltaTime;
    this.BGMove(dragingX)
    
end



this.OnPointerUp=function(eventData)
    print("PointUp")
end

this.OnEndDrag=function(eventData)



end

this.ShowSimalateItem=function(bgIndex,cIndex)
    this.ClearLastSimulateItem();
    local selectIndex=this.vm.data.BGList[bgIndex].index;
    local index=(selectIndex-1)*10+cIndex;
    local cfgSimulateItem=cfgSimulation[tostring(index)];
    this.ShowReward(index);
    local selectSimulateItem=this.vm.data.BGList[bgIndex].simulateItemList[cIndex];
    lastSimulateItem=selectSimulateItem;
    local nums=NumTool.split(cfgSimulateItem.Num,",");
    selectSimulateItem.cIndex=cIndex;
    selectSimulateItem.cNum=cfgSimulateItem.Num;
    selectSimulateItem.pass=true;
    
    selectSimulateItem.icon=LuaMgr.GetSprite("Climbtower","ui_pt_mn_gk3_"..cIndex);
    selectSimulateItem.lineSprite=LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz3_-");
    selectSimulateItem.num1Sprite=LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz3_"..nums[1]);
    selectSimulateItem.num2Sprite=LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz3_"..nums[2]);
    if #nums>2 then
        selectSimulateItem.num3Bool=true;
        selectSimulateItem.num3Sprite=LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz3_"..nums[3])
        
    else
        selectSimulateItem.num3Bool=false;
    end
end

this.ClearLastSimulateItem=function()
    lastSimulateItem.pass=false;
    lastSimulateItem.icon=lastSimulateItem.cUnlock and LuaMgr.GetSprite("Climbtower","ui_pt_mn_gk2_"..lastSimulateItem.cIndex) or
            LuaMgr.GetSprite("Climbtower","ui_pt_mn_gk1_"..lastSimulateItem.cIndex);
    lastSimulateItem.lineSprite=lastSimulateItem.cUnlock and LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz2_-") or
            LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz1_-");

    local nums=NumTool.split(lastSimulateItem.cNum,",");
    lastSimulateItem.num1Sprite=lastSimulateItem.cUnlock and LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz2_"..nums[1]) or
            LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz1_"..nums[1]);
    lastSimulateItem.num2Sprite=lastSimulateItem.cUnlock and LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz2_"..nums[2]) or
            LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz1_"..nums[2]);
    if #nums>2 then
        lastSimulateItem.num3Bool=true;
        lastSimulateItem.num3Sprite=unlock and LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz2_"..nums[3]) or
                LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz1_"..nums[3]);
    else
        lastSimulateItem.num3Bool=false;
    end
end

this.CheckRightPos=function(BGItem)
    local posX=0;
    if BGItem.dir>0 then
        posX=width-elastic;
    elseif BGItem.dir<0 then
        posX=-width+elastic;
    end
    return posX;
end


this.ElasticMove=function(dir)
    if rightOffset==0 and leftOffSet==0 then return end;
    local offset=0;
    if dir>0 and rightOffset>0 then
        offset=-elastic;
    elseif dir<0 and leftOffSet<0 then
        offset=elastic;
    end
    DOTWeen.To(function()return this.vm.data.BGList[1].pos  end,
            function(vetor)  this.vm.data.BGList[1].pos=vetor  end,
            Vector3(this.vm.data.BGList[1].pos.x+offset,0,0),0.05);
    DOTWeen.To(function()return this.vm.data.BGList[2].pos  end,
            function(vetor)  this.vm.data.BGList[2].pos=vetor  end,
            Vector3(this.vm.data.BGList[2].pos.x+offset,0,0),0.05);
    DOTWeen.To(function()return this.vm.data.BGList[3].pos  end,
            function(vetor)  this.vm.data.BGList[3].pos=vetor  end,
            Vector3(this.vm.data.BGList[3].pos.x+offset,0,0),0.05);
    
end


this.BGMove=function(dirX)
    local posX=this.CheckRightPos(curBG);
    rightOffset=0;
    leftOffSet=0;
if dirX>0 and simulateleftIndex<=0 and curBG.pos.x+dirX>=posX then
         rightOffset =curBG.pos.x+dirX-posX
      return;
    end
    if dirX<0 and simulateRightIndex>=simulateMaxIndex+1 and curBG.pos.x+dirX<=posX then
        leftOffSet=curBG.pos.x+dirX-posX;
        return
    end
    for i,v in ipairs(this.vm.data.BGList) do
        v.pos=v.pos+Vector3(dirX,0,0);
        if v.pos.x>=BGPos[3].x then
            local offSetX=v.pos.x-BGPos[3].x;
            v.pos=Vector3(BGPos[1].x,0,0)+Vector3(offSetX,0,0);
            v.dir=-1;
            this.SetBGInfo(v,-1)
        elseif v.pos.x<=BGPos[1].x then
            local offSetX=v.pos.x-BGPos[1].x;
            v.dir=1;
            v.pos=Vector3(BGPos[3].x,0,0)+Vector3(offSetX,0,0);
            this.SetBGInfo(v,1);
        end
    end
end


this.DOMoveLocation=function()
    this.vm.data.BGList[1].dir=-1;
    this.vm.data.BGList[2].dir=0;
    this.vm.data.BGList[3].dir=1;
    DOTWeen.To(function()return this.vm.data.BGList[1].pos  end,
            function(vetor)  this.vm.data.BGList[1].pos=vetor  end,
            Vector3(-1006,0,0),0.05);
    DOTWeen.To(function()return this.vm.data.BGList[2].pos  end,
            function(vetor)  this.vm.data.BGList[2].pos=vetor  end,
            Vector3(0,0,0),0.05);
    DOTWeen.To(function()return this.vm.data.BGList[3].pos  end,
            function(vetor)  this.vm.data.BGList[3].pos=vetor  end,
            Vector3(1006,0,0),0.05).onComplete=function()
        this.Location();
    end;
end

this.Location=function()
    local locatieIndex=math.ceil(dataSimulationTraining/10)
    simulateRightIndex=locatieIndex-2;
    simulateleftIndex=locatieIndex-4;
    this.SetBGInfo(this.vm.data.BGList[1],locatieIndex-1);
    this.SetBGInfo(this.vm.data.BGList[2],locatieIndex)
    this.SetBGInfo(this.vm.data.BGList[3],locatieIndex+1)
    this.ShowReward(dataSimulationTraining)
end


this.ParseData=function();
    maxLength=NumTool.GetLen(cfgSimulation);
    simulateMaxIndex=math.ceil(maxLength/normalLength);
    this.Location();
end

this.SetBGInfo=function(BGItem,dir);
    curBG=BGItem;
    local curIndex=nil;
    if dir>=0 then
        simulateRightIndex=simulateRightIndex+1;
        simulateleftIndex=simulateleftIndex+1;
        curIndex=simulateRightIndex;
    else
        simulateRightIndex=simulateRightIndex-1;
        simulateleftIndex=simulateleftIndex-1;
        curIndex=simulateleftIndex;
    end
    
    if curIndex<=0 or dir>0 and simulateRightIndex>simulateMaxIndex or dir<0 and simulateleftIndex<1 then
        BGItem.cententBool=false;
        return;
    end
    this.SetBGItem(BGItem,curIndex);
end

this.SetBGItem=function(BGItem,curIndex)
    BGItem.index=curIndex;
    BGItem.cententBool=curIndex>0 or curIndex<=simulateMaxIndex;
    for i,v in ipairs(BGItem.simulateItemList) do

        local endV=curIndex==simulateMaxIndex and i==10;
        local index=(curIndex-1)*10+i;
        local unlock=index<=dataSimulationTraining;
        if index==dataSimulationTraining then
            this.ShowReward(dataSimulationTraining);
        end
        local simulateItem=cfgSimulation[tostring(index)];
        if simulateItem==nil then
            return
        end;
        local nums=NumTool.split(simulateItem.Num,",");
        if index==dataSimulationTraining then
            lastSimulateItem=v;
        end
        v.cIndex=i;
        v.cUnlock=unlock;
        v.cNum=simulateItem.Num;
        v.cur=index==dataSimulationTraining;
        v.pass=index==dataSimulationTraining;
        v.line3Bool=not unlock and not endV;
        v.line2Bool= unlock and index~=dataSimulationTraining and not endV ;
        v.line1Bool=index==dataSimulationTraining and not endV;
        
        v.icon=unlock and LuaMgr.GetSprite("Climbtower","ui_pt_mn_gk2_"..i) or
                LuaMgr.GetSprite("Climbtower","ui_pt_mn_gk1_"..i);
        v.lineSprite=unlock and LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz2_-") or
                LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz1_-");
        v.num1Sprite=unlock and LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz2_"..nums[1]) or
                LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz1_"..nums[1]);
        v.num2Sprite=unlock and LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz2_"..nums[2]) or
                LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz1_"..nums[2]);
        if #nums>2 then
            v.num3Bool=true;
            v.num3Sprite=unlock and LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz2_"..nums[3]) or
                    LuaMgr.GetSprite("Climbtower","ui_pt_mn_sz1_"..nums[3]);
        else
            v.num3Bool=false;
        end
    end
end


this.ShowReward=function(cfgIndex)
    this.vm.data.rewardList={};
    local simulation=cfgSimulation[tostring(cfgIndex)];
    if simulation==nil then return end;
    curCfgIndex=cfgIndex;
    curDungeonId=simulation.DungeonId;
    this.vm.data.name=string.format(LuaMgr.GetLangText("ClimbsimulateViewModel_3"),simulation.Name);
    local reward=cfgDungeon[simulation.DungeonId].firstDropShow;
    local reardIds=NumTool.split(reward,";")
    local list={};
    for i,v in ipairs(reardIds) do
        local item =ConfigMgr.Config.itemMap[tostring(v)];
        local rewardItem={id=tostring(v),isCount=false,
                          rare=ActivityMgr.GetRareSprite(item.rare),
                          icon=ActivityMgr.GetItemTexture(tostring(v)),
                          scale=Vector3(0.56,0.56,0.56),
                          sizeDelta=Vector2(72,72),
                          isClick=true}
        table.insert(list,rewardItem);
    end
    this.vm.data.rewardList=list;
end




return vm({
    data = data,
    command = command,
    hook = hook
})