
SawPuzzleMgr = {
    puzzleList={

    },
    loc2IndexMap={},
    puzzleUIList={},
initUIList={},
tarDistance=40;

    row=nil,
    col=nil,
    tfArea=nil,
    tfRect=nil;
    puzzleScrollView=nil,
    itemSizeX=nil;
    itemSizeY=nil;
    edgeCount=nil;
    isCompleteEdge=false;
    isCompleteAll=false;
    puzzleId=nil;
    cacheData={},
    isRotate=false,
    config=nil,
    autoCount=nil;
    clickInterval=0.3
};

local spacing=nil;


local CreatePuzzleItem=function(rowIndex,colIndex)
    local puzzleItem={
        loc_x=rowIndex,
        loc_y=colIndex,
        pos=Vector2(SawPuzzleMgr.itemSizeX*(colIndex-1),-SawPuzzleMgr.itemSizeY*(rowIndex-1)),
isFix=false;
groupId="";
        isInit=true;
        angleZ=0;
    }
    if SawPuzzleMgr.isRotate then
        local rotateIndex=math.random(4);
        puzzleItem.angleZ=(1-rotateIndex)*90
    end
    return puzzleItem;
    
end


SawPuzzleMgr.InitPuzzleList=function(rootTf,puzzleId,starType)
    SawPuzzleMgr.config=SawPuzzleConfig[tonumber(starType)]
    SawPuzzleMgr.ReadLocalData();
    SawPuzzleMgr.isRotate=SawPuzzleMgr.config.base.isRotate;
    SawPuzzleMgr.puzzleId=puzzleId;
    SawPuzzleMgr.puzzleList={};
    SawPuzzleMgr.puzzleUIList={};
    SawPuzzleMgr.initUIList={};
    
    SawPuzzleMgr.tfArea=rootTf:Find("root/Middle/tranArea"):GetComponent("RectTransform");
    SawPuzzleMgr.tfRect=rootTf:Find("root/Middle/tranRect"):GetComponent("RectTransform");
    SawPuzzleMgr.tfRect.sizeDelta=Vector2(LuaMgr.GetScreenWidth(),720)
    local tfArea_X=LuaMgr.ScreenWidth()/2-SawPuzzleMgr.tfArea.sizeDelta.x/2-LuaMgr.ScreenOffSet()/2-15;
    SawPuzzleMgr.tfArea.anchoredPosition=Vector2(tfArea_X,-77);
    SawPuzzleMgr.row=SawPuzzleMgr.config.base.row
    SawPuzzleMgr.col=SawPuzzleMgr.config.base.col
    SawPuzzleMgr.itemSizeX=SawPuzzleMgr.config.base.size.x;
    SawPuzzleMgr.itemSizeY=SawPuzzleMgr.config.base.size.y;
    SawPuzzleMgr.isCompleteEdge=false;
    SawPuzzleMgr.isCompleteAll=false;
    spacing=SawPuzzleMgr.config.base.spacing;
    SawPuzzleMgr.edgeCount=SawPuzzleMgr.row*2+(SawPuzzleMgr.col-2)*2;
    math.randomseed(LuaMgr.Timestamp())
    for i=1,SawPuzzleMgr.row,1 do
        local rowList={}
        for j=1,SawPuzzleMgr.col,1 do
            table.insert(rowList,CreatePuzzleItem(i,j));
        end
        table.insert(SawPuzzleMgr.puzzleList,rowList)
    end
end

SawPuzzleMgr.BindLoc2Index=function(uiList)
    SawPuzzleMgr.loc2IndexMap={};
    for i,v in ipairs(uiList.itemList) do
       local key=v.data.data.loc_x.."_"..v.data.data.loc_y;
        SawPuzzleMgr.loc2IndexMap[key]=i;
    end
end

SawPuzzleMgr.InitUIList=function(list)
    for i,v in ipairs(list) do
        v.data.index=i;
        v:SetActive(true);
        v:UpdateInit_Pos(Vector2(0,-(v.data.index-1)*(SawPuzzleMgr.itemSizeY+spacing)),false)
        table.insert(SawPuzzleMgr.initUIList,v);
    end
    SawPuzzleMgr.UpdateScrollViewContentSize();
end


SawPuzzleMgr.UpdateUIList=function(puzzleItem,dir)
    if dir>0 then
        for i,v in ipairs(SawPuzzleMgr.initUIList) do
            if v.data.index>puzzleItem.data.index then
                v.data.index=v.data.index-1;
                v:UpdateInit_Pos(Vector2(0,-(v.data.index-1)*(SawPuzzleMgr.itemSizeY+spacing)),true)
            end
        end
        table.remove(SawPuzzleMgr.initUIList,puzzleItem.data.index);
        puzzleItem.data.index=nil;
    else
        for i,v in ipairs(SawPuzzleMgr.initUIList) do
            if v.data.index>=puzzleItem.data.index then
                v.data.index=v.data.index+1;
                v:UpdateInit_Pos(Vector2(0,-(v.data.index-1)*(SawPuzzleMgr.itemSizeY+spacing)),true)
            end
        end
        if puzzleItem.data.index>#SawPuzzleMgr.initUIList then
            puzzleItem.data.index=#SawPuzzleMgr.initUIList+1;
        end
        table.insert(SawPuzzleMgr.initUIList,puzzleItem.data.index,puzzleItem);
        puzzleItem:UpdateInit_Pos(Vector2(0,-(puzzleItem.data.index-1)*(SawPuzzleMgr.itemSizeY+spacing)),true)
    end
    SawPuzzleMgr.UpdateScrollViewContentSize();
end

SawPuzzleMgr.UpdateScrollViewContentSize=function()
    SawPuzzleMgr.puzzleScrollView.content.sizeDelta=Vector2(130,#SawPuzzleMgr.initUIList*(SawPuzzleMgr.itemSizeY+spacing))
end

SawPuzzleMgr.GetIndexByLoc=function(locX,locY)
    local key=locX.."_"..locY;
    if SawPuzzleMgr.loc2IndexMap[key]~=nil then
        return SawPuzzleMgr.loc2IndexMap[key];
    end
    return nil;
end

SawPuzzleMgr.GetPuzzleItemByLoc=function(locX,locY)
    local key=locX.."_"..locY;
    if SawPuzzleMgr.loc2IndexMap[key]~=nil then
        return SawPuzzleMgr.puzzleUIList.itemList[SawPuzzleMgr.loc2IndexMap[key]];
    end
    return nil;
end

SawPuzzleMgr.PuzzleOnBeginDrag=function(scrPosition,locX,loxY)
    local puzzleItem=SawPuzzleMgr.GetPuzzleItemByLoc(locX,loxY);
    if IsNullOrEmpty(puzzleItem.data.data.groupId) then
        if puzzleItem.data.data.isInit then
            SawPuzzleMgr.UpdateUIList(puzzleItem,1)
            puzzleItem:SetScale(1,true);
        end
        puzzleItem:OnBeginDragHandler(scrPosition)
        return
    end
   
    local groupId=puzzleItem.data.data.groupId;
    for i,v in ipairs(SawPuzzleMgr.puzzleUIList.itemList) do
        if v.data.data.groupId==groupId then
            v:OnBeginDragHandler(scrPosition);
        end
    end
end



SawPuzzleMgr.PuzzleOnDrag=function(scrPosition,locX,loxY)
    local puzzleItem=SawPuzzleMgr.GetPuzzleItemByLoc(locX,loxY);
    if IsNullOrEmpty(puzzleItem.data.data.groupId) then
        puzzleItem:OnDragHandler(scrPosition)
        return
    end
    local groupId=puzzleItem.data.data.groupId;
    for i,v in ipairs(SawPuzzleMgr.puzzleUIList.itemList) do
        if v.data.data.groupId==groupId and not v.data.data.isFix then
            v:OnDragHandler(scrPosition);
        end
    end
end

SawPuzzleMgr.PuzzleOnPointUp=function(isRotate,locX,loxY)
    local puzzleItem=SawPuzzleMgr.GetPuzzleItemByLoc(locX,loxY);
    if IsNullOrEmpty(puzzleItem.data.data.groupId) and  SawPuzzleMgr.CheckIsCollectPuzzle(puzzleItem) then
        SawPuzzleMgr.CollectPuzzleItem(puzzleItem)
        puzzleItem:SetScale(-1,true);
        return;
    end
    local groupList={};
    local groupId=puzzleItem.data.data.groupId;
    if IsNullOrEmpty(groupId) then
        table.insert(groupList,puzzleItem);
    else
        groupList=SawPuzzleMgr.GetPuzzleListByGroup(groupId);
    end

    local offPos=nil;
    local near_vm=nil;
    local isFix=false;
    for i,v in ipairs(groupList) do
        local selfPos=LuaMgr.World2Local(v.transform.position,SawPuzzleMgr.tfArea)
        v.transform.parent=SawPuzzleMgr.tfArea;
        v.transform.anchoredPosition=selfPos;
        if near_vm==nil then
            local nearVM,nearPos=SawPuzzleMgr.PuzzleCheckMergeGroup(v,false);
            if nearVM~=nil then
                near_vm=nearVM;
                offPos=nearPos-v.transform.anchoredPosition;
                near_vm=nearVM;
            end
        end
    end
    if near_vm~=nil then
        isFix=near_vm.data.data.isFix;
        local nearList=SawPuzzleMgr.GetPuzzleGridBox_13({
            {vm=puzzleItem,pos=puzzleItem.transform.anchoredPosition+offPos},
            {vm=near_vm,pos=near_vm.transform.anchoredPosition}
        },false);
        table.insert(nearList,near_vm);
        table.insert(nearList,puzzleItem);
        







        for i,v in ipairs(nearList) do
            v:SetFixedFx();



        end
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/change_lock_1.mp3")
    end
    for i,v in ipairs(groupList) do
        local nearPos=nil;
        if near_vm~=nil then
             nearPos=v.transform.anchoredPosition+offPos;
            v.data.data.groupId=near_vm.data.data.groupId;
            v.data.data.isFix=isFix;
            if isFix then
                nearPos=v.data.data.pos;
            end
        end
        v:OnPointerUpHandler(nearPos,isFix,isRotate);
    end
    
end

SawPuzzleMgr.GetPuzzleListByGroup=function(groupId)
    local groupList={}
    for i,v in ipairs(SawPuzzleMgr.puzzleUIList.itemList) do
        if not v.data.data.isInit and not v.data.data.isFix and v.data.data.groupId==groupId then
            table.insert(groupList,v);
        end
    end
    return groupList;
end


SawPuzzleMgr.CheckIsCollectPuzzle=function(puzzleItem)
    return puzzleItem.transform.anchoredPosition.x>SawPuzzleMgr.tfArea.sizeDelta.x+SawPuzzleMgr.tfArea.anchoredPosition.x+26;
end

SawPuzzleMgr.CollectPuzzleItem=function(puzzleItem)
    local selfPos=LuaMgr.World2Local(puzzleItem.transform.position,SawPuzzleMgr.puzzleScrollView.content)
    puzzleItem.transform.parent=SawPuzzleMgr.puzzleScrollView.content;
    puzzleItem.transform.anchoredPosition=selfPos;
    puzzleItem.data.data.isInit=true;
    local locIndex=math.ceil(-selfPos.y/(SawPuzzleMgr.itemSizeY+spacing));
    puzzleItem.data.index=locIndex+1;
    puzzleItem.transform:SetSiblingIndex(locIndex);
    SawPuzzleMgr.UpdateUIList(puzzleItem,-1)
end


SawPuzzleMgr.CheckNearFixPosition=function(curPos,tarPos)
    return Vector2.Distance(curPos,tarPos)<=SawPuzzleMgr.tarDistance;
end


SawPuzzleMgr.CheckIsMyGroup=function(tarTf,myTf)
    if IsNullOrEmpty(tarTf.data.data.groupId) or IsNullOrEmpty(myTf.data.data.groupId) then
        return false;
    end
    return tarTf.data.data.groupId==myTf.data.data.groupId;
end


SawPuzzleMgr.PuzzleCheckMergeGroup=function(puzzleBehavior,isAuto)
    local selfPos=LuaMgr.World2Local(puzzleBehavior.transform.position,SawPuzzleMgr.tfArea)
    puzzleBehavior.transform.parent=SawPuzzleMgr.tfArea;
    puzzleBehavior.transform.anchoredPosition=selfPos;
    
    local locX=puzzleBehavior.data.data.loc_x;
    local locY=puzzleBehavior.data.data.loc_y;

    if locX==1 or locY==1 or locX==SawPuzzleMgr.row or locY==SawPuzzleMgr.col then
        if math.abs(puzzleBehavior.data.data.angleZ)<2 and (isAuto or SawPuzzleMgr.CheckNearFixPosition(selfPos,puzzleBehavior.data.data.pos)) then
            puzzleBehavior.data.data.isFix=true;
            puzzleBehavior.data.data.groupId=string.format("%s_%s",locX,locY)
            return puzzleBehavior,puzzleBehavior.data.data.pos;
        end
    end

    local nearPuzzle=nil;
    local puzzleNearPos=nil;

    if puzzleBehavior.data.data.loc_y>1 then
        local leftIndex=SawPuzzleMgr.GetIndexByLoc(puzzleBehavior.data.data.loc_x,puzzleBehavior.data.data.loc_y-1);
        nearPuzzle=SawPuzzleMgr.puzzleUIList.itemList[leftIndex]
        if not nearPuzzle.data.data.isInit and not SawPuzzleMgr.CheckIsMyGroup(nearPuzzle,puzzleBehavior) then







            puzzleNearPos=SawPuzzleMgr.CheckMergeGroup(nearPuzzle,puzzleBehavior,1,isAuto);
            if puzzleNearPos==nil then
                nearPuzzle=nil;
            end
        else
            nearPuzzle=nil;
        end
    end

    if nearPuzzle==nil and puzzleBehavior.data.data.loc_y<SawPuzzleMgr.col then
        local rightIndex=SawPuzzleMgr.GetIndexByLoc(puzzleBehavior.data.data.loc_x,puzzleBehavior.data.data.loc_y+1);
        nearPuzzle=SawPuzzleMgr.puzzleUIList.itemList[rightIndex];
        if not nearPuzzle.data.data.isInit and not SawPuzzleMgr.CheckIsMyGroup(nearPuzzle,puzzleBehavior)then







            puzzleNearPos=SawPuzzleMgr.CheckMergeGroup(nearPuzzle,puzzleBehavior,2,isAuto);
            if puzzleNearPos==nil then
                nearPuzzle=nil;
            end
        else
            nearPuzzle=nil;
        end
    end

    if  nearPuzzle==nil and puzzleBehavior.data.data.loc_x>1 then
        local upIndex=SawPuzzleMgr.GetIndexByLoc(puzzleBehavior.data.data.loc_x-1,puzzleBehavior.data.data.loc_y);
        nearPuzzle=SawPuzzleMgr.puzzleUIList.itemList[upIndex];
        if not nearPuzzle.data.data.isInit and not SawPuzzleMgr.CheckIsMyGroup(nearPuzzle,puzzleBehavior)then







            puzzleNearPos=SawPuzzleMgr.CheckMergeGroup(nearPuzzle,puzzleBehavior,3,isAuto);
            if puzzleNearPos==nil then
                nearPuzzle=nil;
            end
        else
            nearPuzzle=nil;
        end
    end

    if  nearPuzzle==nil and puzzleBehavior.data.data.loc_x<SawPuzzleMgr.row  then
        local downIndex=SawPuzzleMgr.GetIndexByLoc(puzzleBehavior.data.data.loc_x+1,puzzleBehavior.data.data.loc_y);
        nearPuzzle=SawPuzzleMgr.puzzleUIList.itemList[downIndex];
        if not nearPuzzle.data.data.isInit and not SawPuzzleMgr.CheckIsMyGroup(nearPuzzle,puzzleBehavior)then







            puzzleNearPos=SawPuzzleMgr.CheckMergeGroup(nearPuzzle,puzzleBehavior,4,isAuto);
            if puzzleNearPos==nil then
                nearPuzzle=nil;
            end
        else
            nearPuzzle=nil;
        end
    end
    if nearPuzzle==nil then
        return nil,nil
    end;
    if  IsNullOrEmpty(nearPuzzle.data.data.groupId) then
        nearPuzzle.data.data.groupId=string.format("%s_%s",nearPuzzle.data.data.loc_x,nearPuzzle.data.data.loc_y)
    end
    if not IsNullOrEmpty(puzzleBehavior.data.data.groupId) and puzzleBehavior.data.data.groupId==nearPuzzle.data.data.groupId then
        return nil,nil;
    end
    if not isAuto then
        puzzleBehavior.data.data.groupId=nearPuzzle.data.data.groupId;
    end
    return nearPuzzle,puzzleNearPos;
    
end

SawPuzzleMgr.CheckMergeGroupDistance=function(nearPos,tfPos)
    return Vector2.Distance(nearPos,tfPos)<=SawPuzzleMgr.tarDistance;
end


SawPuzzleMgr.CheckMergeGroup=function(nearVM,myVM,type,isAuto)

    if math.abs(myVM.data.data.angleZ-nearVM.data.data.angleZ)>2 then
        return nil;
    end
    local myAnchoredPosition=myVM.transform.anchoredPosition;
    if isAuto then
        myAnchoredPosition=myVM.data.data.pos
    end
    local dirVector=nearVM.transform.anchoredPosition-myAnchoredPosition
    local nearAngle=20;
    local localAngle=nil;
    local norDir=nil;
    if math.abs(myVM.data.data.angleZ-270)<2 then
        if type==1 then
            norDir=Vector2.up
        elseif type==2 then
            norDir=Vector2.down
        elseif type==3 then
            norDir=Vector2.right
        elseif type==4 then
            norDir=Vector2.left
        end
    elseif math.abs(myVM.data.data.angleZ-180)<2 then
        if type==1 then
            norDir=Vector2.right
        elseif type==2 then
            norDir=Vector2.left
        elseif type==3 then
            norDir=Vector2.down
        elseif type==4 then
            norDir=Vector2.up
        end
    elseif math.abs(myVM.data.data.angleZ-90)<2 then
        if type==1 then
            norDir=Vector2.down
        elseif type==2 then
            norDir=Vector2.up
        elseif type==3 then
            norDir=Vector2.left
        elseif type==4 then
            norDir=Vector2.right
        end
    else
        if type==1 then
            norDir=Vector2.left
        elseif type==2 then
            norDir=Vector2.right
        elseif type==3 then
            norDir=Vector2.up
        elseif type==4 then
            norDir=Vector2.down
        end
    end
    localAngle=Vector2.Angle(dirVector,norDir)
    local itemSize= (type==1 or type==2) and SawPuzzleMgr.itemSizeX or SawPuzzleMgr.itemSizeY
    if localAngle>nearAngle or Vector2.Distance(nearVM.transform.anchoredPosition,myAnchoredPosition)>itemSize+SawPuzzleMgr.tarDistance then
        return nil;
    end
    return nearVM.transform.anchoredPosition-norDir*itemSize
    
end


SawPuzzleMgr.FilterEdgePuzzles=function(isfiler)
    if isfiler then
        SawPuzzleMgr.filerList={};
        local edgeList={}
        for i,v in ipairs(SawPuzzleMgr.initUIList) do
            v.data.data.filerIndex=i;
            if v.data.data.loc_x==1 or v.data.data.loc_x==SawPuzzleMgr.row or v.data.data.loc_y==1 or v.data.data.loc_y==SawPuzzleMgr.col then
                table.insert(edgeList,v);
            else
                v:SetActive(false);
                table.insert(SawPuzzleMgr.filerList,v);
            end
        end
        SawPuzzleMgr.initUIList={};
        for i,v in ipairs(edgeList) do
            v.data.index=i;
            v:UpdateInit_Pos(Vector2(0,-(v.data.index-1)*(SawPuzzleMgr.itemSizeY+spacing)),false)
            table.insert(SawPuzzleMgr.initUIList,v);
        end
        SawPuzzleMgr.UpdateScrollViewContentSize();
    else
        if SawPuzzleMgr.filerList~=nil then
            for i,v in ipairs(SawPuzzleMgr.filerList) do
                table.insert(SawPuzzleMgr.initUIList,v)
            end
            SawPuzzleMgr.filerList=nil;
        end
        table.sort(SawPuzzleMgr.initUIList,function(a, b) return a.data.data.filerIndex<b.data.data.filerIndex end)
        for i,v in ipairs(SawPuzzleMgr.initUIList) do
            v.data.index=i;
            v:SetActive(true);
            v:UpdateInit_Pos(Vector2(0,-(v.data.index-1)*(SawPuzzleMgr.itemSizeY+spacing)),false)
        end
        SawPuzzleMgr.UpdateScrollViewContentSize();
    end
end

SawPuzzleMgr.AutoFixPuzzle=function(callback)
    local autoPuzzle=SawPuzzleMgr.initUIList[1]
    if autoPuzzle==nil then
        for i,v in ipairs(SawPuzzleMgr.puzzleUIList.itemList) do
            if not v.data.data.isFix and (math.abs(v.data.data.angleZ)>2 or Vector2.Distance(v.transform.anchoredPosition,v.data.data.pos)>SawPuzzleMgr.tarDistance/4) then
                autoPuzzle=v;
                break
            end
        end
    end;
    if autoPuzzle==nil then
        if callback~=nil then
            callback(false);
        end
        return
    end
    autoPuzzle.data.data.isInit=false;
    local selfPos=LuaMgr.World2Local(autoPuzzle.transform.position,SawPuzzleMgr.tfArea)
    autoPuzzle.transform.parent=SawPuzzleMgr.tfArea;
    autoPuzzle.transform.anchoredPosition=selfPos;
    autoPuzzle:SetAngle(0)
    autoPuzzle:SetScale(1,true)
    
    local nearVM,nearPos=SawPuzzleMgr.PuzzleCheckMergeGroup(autoPuzzle,true);
    nearPos=autoPuzzle.data.data.pos;

    autoPuzzle:DOLocalMove(Vector3(nearPos.x,nearPos.y,0),function()
        autoPuzzle.transform:SetAsFirstSibling();
        if nearVM~=nil then
            local nearList=SawPuzzleMgr.GetPuzzleGridBox_13(
                    { 
                        { vm=nearVM,pos=nearVM.transform.anchoredPosition },
                        { vm=autoPuzzle,pos=nearPos}
                    },true);
            table.insert(nearList,autoPuzzle);








            for i,v in ipairs(nearList) do
                v:SetFixedFx();



            end

            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/change_lock_1.mp3")
        end
        autoPuzzle.data.data.isFix=true;
        SawPuzzleMgr.CheckPuzzleWin(autoPuzzle);
        if callback~=nil then
            callback(true);
        end
    end);
    SawPuzzleMgr.UpdateUIList(autoPuzzle,1);
    
end















SawPuzzleMgr.GetPuzzleGridBox_13=function(puzzleList,isFix)
    local nearMap={};
    for p,m in ipairs(puzzleList) do
        local nearList_One=SawPuzzleMgr.GetPuzzleNearBox(m.vm,m.pos,isFix);
        for i,v in ipairs(nearList_One) do
            local key=string.format("%s_%s",v.data.data.loc_x,v.data.data.loc_y);
            if nearMap[key]==nil then
                nearMap[key]=v;
            end
        end
        for i,v in ipairs(nearList_One) do
            local nearList_Two=SawPuzzleMgr.GetPuzzleNearBox(v,v.transform.anchoredPosition,isFix);
            for _i,_v in ipairs(nearList_Two) do
                local key=string.format("%s_%s",_v.data.data.loc_x,_v.data.data.loc_y);
                if nearMap[key]==nil then
                    nearMap[key]=_v;
                end
            end
        end
        
    end
    local list={}
    for i,v in pairs(nearMap) do
        table.insert(list,v)
    end
    return list;
end



SawPuzzleMgr.GetPuzzleNearBox=function(puzzleItem,pos,isFix)
    local gridBox={}
    local locX=puzzleItem.data.data.loc_x;
    local locY=puzzleItem.data.data.loc_y;
    for i=locX-1,locX+1,1 do
        for j=locY-1,locY+1,1 do
            if not (i==locX and j==locY) then
                if i==locX or j==locY then
local item=SawPuzzleMgr.GetPuzzleItemByLoc(i,j)
                    if item~=nil and SawPuzzleMgr.CheckNearCondition(item,pos,puzzleItem.data.data.angleZ) then
                        if isFix then
                            if  not item.data.data.isInit and item.data.data.isFix then
                                table.insert(gridBox,item);
                            end
                        else
                            if not item.data.data.isInit then
                                table.insert(gridBox,item);
                            end
                        end
                    end
                end
            end
        end
    end
    return gridBox;
end


SawPuzzleMgr.CheckNearCondition=function(item,tarPos,tarAngleZ)
    local isAngel=math.abs(item.data.data.angleZ-tarAngleZ)<2;
    local isVer=math.abs(item.transform.anchoredPosition.x-tarPos.x)<2 and Vector2.Distance(item.transform.anchoredPosition,tarPos)<SawPuzzleMgr.itemSizeY+2;
    local isHor=math.abs(item.transform.anchoredPosition.y-tarPos.y)<2 and Vector2.Distance(item.transform.anchoredPosition,tarPos)<SawPuzzleMgr.itemSizeX+2
    return isAngel and (isVer or isHor);
end

SawPuzzleMgr.CheckPuzzleWin=function(puzzleItem)
    if SawPuzzleMgr.filerList~=nil and #SawPuzzleMgr.filerList>0 and #SawPuzzleMgr.initUIList==0  then
        puzzleItem.data.autoSwitchEdgeCallback();
    end
    local edgeCount=0;
    local allCount=0;
    for i,v in ipairs(SawPuzzleMgr.puzzleUIList.itemList) do
        if v.data.data.isFix then
            if v.data.data.loc_x==1 or v.data.data.loc_x==SawPuzzleMgr.row or v.data.data.loc_y==1 or v.data.data.loc_y==SawPuzzleMgr.col then
                edgeCount=edgeCount+1;
            end
            allCount=allCount+1;
        else
            if Vector2.Distance(v.transform.anchoredPosition,v.data.data.pos)<2 then
                allCount=allCount+1;
            end
        end
    end
    if not SawPuzzleMgr.isCompleteAll and allCount==#SawPuzzleMgr.puzzleUIList.itemList then
        SawPuzzleMgr.isCompleteAll=true;
        SawPuzzleMgr.ClearLocalData();
        puzzleItem.data.completeCallBack(true);
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .."newUI/Character_StarUp.mp3")
        return
    end
    if not SawPuzzleMgr.isCompleteEdge and edgeCount==SawPuzzleMgr.edgeCount then
        SawPuzzleMgr.isCompleteEdge=true;
        puzzleItem.data.completeCallBack(false);
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "UI/Friendship_content.mp3")
    end
end


SawPuzzleMgr.CheckGroupRotate=function(puzzleItem,angleZ)
    if IsNullOrEmpty(puzzleItem.data.data.groupId) then return end;
   local  groupList=SawPuzzleMgr.GetPuzzleListByGroup(puzzleItem.data.data.groupId);
    if #groupList==1 then return end;
    for i,v in ipairs(groupList) do
        if not v.data.data.isFix and v.data.name~=puzzleItem.data.name then
            local vector=v.transform.anchoredPosition-puzzleItem.transform.anchoredPosition;
            local tarVector=Quaternion.Euler(0,0,angleZ)*Vector3(vector.x,vector.y,0)+
                    Vector3(puzzleItem.transform.anchoredPosition.x,puzzleItem.transform.anchoredPosition.y,0);
            v:RotateByGroup(tarVector,angleZ);
        end
    end
end



SawPuzzleMgr.CheckLocalRecord=function(puzzleId)
    if SawPuzzleMgr.cacheData==nil then
        SawPuzzleMgr.cacheData={}
    end
    if SawPuzzleMgr.cacheData[puzzleId]~=nil then
        return SawPuzzleMgr.cacheData[puzzleId];
    end
    return nil;
end


SawPuzzleMgr.SavePuzzle=function()

    if SawPuzzleMgr.filerList~=nil and #SawPuzzleMgr.filerList>0 then
        for i,v in ipairs(SawPuzzleMgr.filerList) do
            table.insert(SawPuzzleMgr.initUIList,v)
        end
        SawPuzzleMgr.filerList=nil;
        table.sort(SawPuzzleMgr.initUIList,function(a, b) return a.data.data.filerIndex<b.data.data.filerIndex end)
        for i,v in ipairs(SawPuzzleMgr.initUIList) do
            v.data.index=i;
        end
    end
    local puzzleIdData={}
    local proIndex=0;
    for i,v in ipairs(SawPuzzleMgr.puzzleUIList.itemList) do
        local value={
            loc_x=v.data.data.loc_x,
            loc_y=v.data.data.loc_y,
            isFix=v.data.data.isFix,
            groupId=v.data.data.groupId,
            isInit=v.data.data.isInit,
            posX=v.data.data.pos.x,
            posY=v.data.data.pos.x,
            angleZ=v.data.data.angleZ,
            sortNum=v.data.sortNum,
            index=v.data.index,
            anchoredPositionX=v.transform.anchoredPosition.x;
            anchoredPositionY=v.transform.anchoredPosition.y;
        }
        if value.isFix then
            proIndex=proIndex+1;
        end
        local key=value.loc_x.."_"..value.loc_y;
        puzzleIdData[key]=value;
        
    end
    if SawPuzzleMgr.cacheData[SawPuzzleMgr.puzzleId]==nil then
        SawPuzzleMgr.cacheData[SawPuzzleMgr.puzzleId]={};
    end
    local pro=string.format("%.1f%%",proIndex*100/#SawPuzzleMgr.puzzleUIList.itemList);
    SawPuzzleMgr.cacheData[SawPuzzleMgr.puzzleId]={data=puzzleIdData,autoCount=SawPuzzleMgr.autoCount,fixedPro=pro};
    SawPuzzleMgr.WriteLocalData();
end


SawPuzzleMgr.WriteLocalData=function()
    local fileName=DataMgr.Player.uid.."_sawpuzzlefile.txt"
    local spineFile=UnityEngine.Application.persistentDataPath.."/"..fileName;
    if SawPuzzleMgr.cacheData~=nil and SawPuzzleMgr.cacheData~="" then
        local jsonStr=json.encode(SawPuzzleMgr.cacheData);
        LuaMgr.WriteFile(spineFile,jsonStr);
    end
end

SawPuzzleMgr.ReadLocalData=function()
    local fileName=DataMgr.Player.uid.."_sawpuzzlefile.txt"
    local spineFile=UnityEngine.Application.persistentDataPath.."/"..fileName;
    local jsonStr=LuaMgr.ReadFile(spineFile)
    if jsonStr~=nil and jsonStr~="" then
        SawPuzzleMgr.cacheData=json.decode(jsonStr);
        if  SawPuzzleMgr.cacheData==nil then
            SawPuzzleMgr.cacheData={}
        end
    else
        SawPuzzleMgr.cacheData={}
    end
end

SawPuzzleMgr.ClearLocalData=function()
    if SawPuzzleMgr.cacheData~=nil and SawPuzzleMgr.cacheData[SawPuzzleMgr.puzzleId]~=nil then
        SawPuzzleMgr.cacheData[SawPuzzleMgr.puzzleId]=nil;
    end
    SawPuzzleMgr.WriteLocalData();
end

SawPuzzleMgr.Clear=function()
    for i,v in ipairs(SawPuzzleMgr.puzzleUIList) do
        v.transform.parent=SawPuzzleMgr.puzzleScrollView.content;
    end
    SawPuzzleMgr.puzzleList={}
    SawPuzzleMgr.loc2IndexMap={}
    SawPuzzleMgr.puzzleUIList={};
    SawPuzzleMgr.initUIList={};
    SawPuzzleMgr.filerList={};
    SawPuzzleMgr.row=nil
    SawPuzzleMgr.col=nil
    SawPuzzleMgr.puzzleId=nil;
end

return SawPuzzleMgr;