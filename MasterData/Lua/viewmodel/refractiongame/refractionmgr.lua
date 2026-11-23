
RefractionMgr = {
    initBlocks = {},
    tranOpBoards = nil,
    rayPointList = {},
    angle = nil,
    lastVector = nil,
    count = nil,
};

local boardConfig={
row=5,
col=9,
blockSize=100,
};


RefractionMgr.Clear=function()
    RefractionMgr.initBlocks={}
    RefractionMgr.opBlockList={};
    RefractionMgr.initPointsList={}
end

RefractionMgr.InitBoards=function(initList,opTF)
    RefractionMgr.tranOpBoards=opTF
    local initBoardMap={};
    for i,v in ipairs(initList) do
        initBoardMap[v]=v;
    end
    RefractionMgr.initBlocks={};
    for i=1,boardConfig.row*boardConfig.col,1 do
        local block={init=false,data=nil}
        if initBoardMap[i]~=nil then
            block.init=true;
            block.data={
                index=i,
                isLocation=false,
                pos=RefractionMgr.BlockGetPosByIndex(i),
            }
        end    
        table.insert(RefractionMgr.initBlocks,block);
    end
    return RefractionMgr.initBlocks;
end

RefractionMgr.InitPointList=function(cfgPoints)
    RefractionMgr.initPointsList={};
    for i,vArray in ipairs(cfgPoints) do
        local point={
            index=vArray[1],
            pos=RefractionMgr.PointGetPosByIndex(vArray[1],vArray[2]);
        }
        table.insert(RefractionMgr.initPointsList,point);
    end
    return RefractionMgr.initPointsList;
end

RefractionMgr.OpBlocksList=function(opBlockList)
    local opBlockMap={}
    for i,vArray in ipairs(opBlockList) do
        opBlockMap[vArray[1]]=vArray;
    end
    RefractionMgr.opBlockList={}
    local locIndex=0;
    for i=1,boardConfig.row*boardConfig.col,1 do
        if opBlockMap[i]~=nil then
            locIndex=locIndex+1;
            local block={
                index=locIndex,
                type=opBlockMap[i][2];
                pos=RefractionMgr.BlockGetPosByIndex(i),
                initIndex=i,
            }
            if RefractionMgr.initBlocks[i].init then
                RefractionMgr.initBlocks[i].data.isLocation=true;
            else
                LuaDebug.error("opBlockList config is error; please check config")
            end
            table.insert(RefractionMgr.opBlockList,block);
        end
    end
    return RefractionMgr.opBlockList;
end


RefractionMgr.UpdateOpBlockData=function(index,initIndex,pos)
    if RefractionMgr.opBlockList[index]~=nil then
        if initIndex~=nil then
            RefractionMgr.opBlockList[index].initIndex=initIndex;
        end
        if pos~=nil then
            RefractionMgr.opBlockList[index].pos=pos;
        end
    end
end


RefractionMgr.PointGetPosByIndex=function(index,dir)
    local blockPos=RefractionMgr.BlockGetPosByIndex(index);
    local x=blockPos.x;
    local y=blockPos.y;
    if dir==1 then
        x=x+boardConfig.blockSize/2
    elseif dir==2 then
        y=y-boardConfig.blockSize/2;
    elseif dir==3 then
        x=x+boardConfig.blockSize/2
        y=y-boardConfig.blockSize;
    elseif dir==4 then
        x=x+boardConfig.blockSize
        y=y-boardConfig.blockSize/2;
    end
    return Vector2(x,y);
end




RefractionMgr.BlockGetPosByIndex=function(index)
    local row=math.floor(index/9)
    local col=index%9;
    if col==0 then
        col=boardConfig.col;
        row=row-1;
    end
    local x=boardConfig.blockSize*(col-1);
    local y=-boardConfig.blockSize*row;
    return Vector2(x,y);
end


RefractionMgr.CheckAndGetBlockMoveToLocation=function(blockPosition)
    local initBlock=nil;
    local minDistance=boardConfig.blockSize;
    for i,v in ipairs(RefractionMgr.initBlocks) do
        if v.init and not v.data.isLocation then
            local distance=UnityEngine.Vector2.Distance(v.data.pos,blockPosition);
            if distance<boardConfig.blockSize and distance<minDistance then
                minDistance=distance;
                initBlock=v;
            end
        end
    end
    return initBlock
end


RefractionMgr.ClearInitBlock=function(initIndex)
    if RefractionMgr.initBlocks[initIndex].init then
        RefractionMgr.initBlocks[initIndex].data.isLocation=false;
    else
        LuaMgr.error("initIndex is Error:"..initIndex)
    end
end



RefractionMgr.GetLinesPoints=function(startIndex,startDir,startAngle)
    RefractionMgr.rayPointList={}
    RefractionMgr.angle=startAngle;
    RefractionMgr.lastVector=Vector3(0,1,0);
    RefractionMgr.count=100;
    RefractionMgr.activePointMap={};
    local startPoint=RefractionMgr.PointGetPosByIndex(startIndex,startDir);
    table.insert(RefractionMgr.rayPointList,Vector3(startPoint.x,startPoint.y,0));
    RefractionMgr.CheckBlocksPoints(startPoint)

    if RefractionMgr.count>0 then
        local len=#RefractionMgr.rayPointList
        local lastPoint=RefractionMgr.rayPointList[len];
        local endPoint=RefractionMgr.GetEdgePoint(lastPoint,RefractionMgr.angle);
        table.insert(RefractionMgr.rayPointList,endPoint);
    end
    return RefractionMgr.rayPointList,RefractionMgr.activePointMap;
end


RefractionMgr.CheckBlocksPoints=function(point)
    local vector=Quaternion.Euler(0,0,RefractionMgr.angle)*RefractionMgr.lastVector;
    RefractionMgr.lastVector=vector;
    local minV= RefractionMgr.CheckBlocksIntersect(point,Vector2(vector.x,vector.y));
    RefractionMgr.CheckPointsIntersect(point,Vector2(vector.x,vector.y),minV);
    if minV==nil or RefractionMgr.count<=0 then
        return;
    end
    RefractionMgr.count=RefractionMgr.count-1;
    local changeAngle=RefractionMgr.GetRayReflectAngle(vector,minV.pointDir)
    RefractionMgr.angle=changeAngle;
    local curPoint=Vector3(minV.intersectPos.x,minV.intersectPos.y,0);
    table.insert(RefractionMgr.rayPointList,curPoint);

    if Vector3.Distance(RefractionMgr.rayPointList[1],curPoint)<=5 or minV.block.type==1 then

        RefractionMgr.count=0;
        return;
    end
    RefractionMgr.CheckBlocksPoints(minV.intersectPos);
end


RefractionMgr.CheckPointsIntersect=function(point,vector,minV)
    local vDistance=nil;
    if minV~=nil then
        vDistance=Vector2.Distance(point,minV.intersectPos);
    end
    for i,v in ipairs(RefractionMgr.initPointsList) do
        local vector_i=v.pos-point;
        if math.abs(vector_i.x)>0.1 or math.abs(vector_i.y)>0.1 then
            local angle=Vector2.Angle(vector_i,vector)
            if angle<5 then
                if vDistance==nil then
                    RefractionMgr.activePointMap[i]=true;
                else
                    local dis_i=Vector2.Distance(v.pos,point)
                    if dis_i-vDistance<5 then
                        RefractionMgr.activePointMap[i]=true;
                    end
                end
            end
        end
    end
end



RefractionMgr.GetRayReflectAngle=function(rayVector,rayPointIndex)

    local norVector=nil;
    if rayPointIndex==1  then
        norVector=Vector3(0,1,0)
    elseif rayPointIndex==2 then
        norVector=Vector3(-1,0,0)
    elseif rayPointIndex==3 then
        norVector=Vector3(0,-1,0);
    elseif rayPointIndex==4 then
        norVector=Vector3(1,0,0)
    end
    local newVector=Quaternion.Euler(0,0,90)*rayVector;
    if Vector3.Angle(newVector,norVector)<50 then
        return 90;
    else
        return -90;
    end
end



RefractionMgr.CheckBlockEdgeIntersect=function(block,startPoint,vector)
    local edgePoints={}
    table.insert(edgePoints,RefractionMgr.PointGetPosByIndex(block.initIndex,1))
    table.insert(edgePoints,RefractionMgr.PointGetPosByIndex(block.initIndex,2))
    table.insert(edgePoints,RefractionMgr.PointGetPosByIndex(block.initIndex,3))
    table.insert(edgePoints,RefractionMgr.PointGetPosByIndex(block.initIndex,4))
    local minDistance=nil;
    local intersectPos=nil;
    local pointDir=0;
    for i,v in ipairs(edgePoints) do
        local vector_i=v-startPoint;

        if math.abs(vector_i.x)>0.1 or math.abs(vector_i.y)>0.1 then
            local angle=Vector2.Angle(vector_i,vector)
            if angle<5 then
                local distance=Vector2.Distance(vector_i,vector)
                if (minDistance==nil or distance<minDistance) then
                    minDistance=distance;
                    intersectPos=v;
                    pointDir=i;
                end
            end
        end
    end
    return intersectPos,pointDir;
end


RefractionMgr.CheckBlocksIntersect=function(startPoint,vector)
    local pointList={}
    for i,v in ipairs(RefractionMgr.opBlockList) do
        local intersectPos,pointDir=RefractionMgr.CheckBlockEdgeIntersect(v,startPoint,vector);
        if intersectPos~=nil then
            table.insert(pointList,{block=v,intersectPos=intersectPos,pointDir=pointDir});
        end
    end
    local min_v=nil;
    if #pointList>0 then
        local min_Distance=nil;
        for i,v in ipairs(pointList) do
            local distance=Vector2.Distance(startPoint,v.intersectPos)
            if min_Distance==nil or distance<min_Distance then
                min_Distance=distance;
                min_v=v;
            end
        end
    end
    return min_v;
end



RefractionMgr.GetEdgePoint=function(point)
    local xLen=math.abs(point.x);
    local yLen=math.abs(point.y);
    if RefractionMgr.lastVector.x>0 and RefractionMgr.lastVector.y>0  then
        xLen=900-xLen;
    elseif RefractionMgr.lastVector.x>0 and RefractionMgr.lastVector.y<0 then
        xLen=900-xLen;
        yLen=500-yLen;
    elseif RefractionMgr.lastVector.x<0 and RefractionMgr.lastVector.y<0 then
        yLen=500-yLen;
    end
    local minLen=xLen<yLen and xLen or yLen;
    local distance=minLen/math.sin(math.pi/4);
    local vector=Vector3.Normalize(RefractionMgr.lastVector)*distance;
    local edgePoint=Vector3(point.x,point.y,0)+vector;
    return edgePoint;
end

return RefractionMgr;