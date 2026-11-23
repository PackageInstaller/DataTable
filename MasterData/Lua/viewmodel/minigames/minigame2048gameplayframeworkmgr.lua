require("Tools/LuaO1DeQueue")
require("ViewModel/MiniGames/MiniGame2048GamePlayFrameWorkBuff")
require("ViewModel/MiniGames/MiniGame2048GamePlayFrameWorkOutInterface")
require("ViewModel/MiniGames/MiniGame2048GamePlayFrameWorkGamePlayCueMgr")









MiniGame2048GamePlayFrameWorkMgr={};
MiniGame2048GamePlayFrameWorkMgr.StartTagTree={
blockIdList={},
tagNextPointMap={},
};
MiniGame2048GamePlayFrameWorkMgr.isInitData=false;
MiniGame2048GamePlayFrameWorkMgr.PrivateTagCacheData={};

MiniGame2048GamePlayFrameWorkMgr.nowScore=0;
MiniGame2048GamePlayFrameWorkMgr.nowMergeBlock={};
MiniGame2048GamePlayFrameWorkMgr.nowMergeMaxLevelBlock=nil;
MiniGame2048GamePlayFrameWorkMgr.InitViewModelData=function ()
    MiniGame2048GamePlayFrameWorkMgr.nowScore=0;
    MiniGame2048GamePlayFrameWorkMgr.nowMergeBlock={};
    MiniGame2048GamePlayFrameWorkMgr.nowMergeMaxLevelBlock=nil;
end

MiniGame2048GamePlayFrameWorkMgr.AddNowScore=function (score)
    MiniGame2048GamePlayFrameWorkMgr.nowScore=MiniGame2048GamePlayFrameWorkMgr.nowScore+score;
end
MiniGame2048GamePlayFrameWorkMgr.AddNowMergeBlock=function (blockId)
    if blockId==nil then
        return;
    end
    MiniGame2048GamePlayFrameWorkMgr.nowMergeBlock[blockId]=true;
    local config=ConfigMgr.Config.NumberBlockMap;
    if MiniGame2048GamePlayFrameWorkMgr.nowMergeMaxLevelBlock==nil then
        MiniGame2048GamePlayFrameWorkMgr.nowMergeMaxLevelBlock=blockId;
    else
        if config[blockId].Priority>=config[MiniGame2048GamePlayFrameWorkMgr.nowMergeMaxLevelBlock].Priority then
            MiniGame2048GamePlayFrameWorkMgr.nowMergeMaxLevelBlock=blockId;
        end
    end
end

MiniGame2048GamePlayFrameWorkMgr.GetArchiveData=function ()
    local archiveData={
        nowScore=nil,
        nowMergeBlock={},
        nowMergeMaxLevelBlock=nil,
    }
    archiveData.nowScore=MiniGame2048GamePlayFrameWorkMgr.nowScore;
    archiveData.nowMergeBlock=MiniGame2048GamePlayFrameWorkMgr.nowMergeBlock;
    archiveData.nowMergeMaxLevelBlock=MiniGame2048GamePlayFrameWorkMgr.nowMergeMaxLevelBlock;
    return archiveData;
end

MiniGame2048GamePlayFrameWorkMgr.LoadArchive=function (archiveData)
    MiniGame2048GamePlayFrameWorkMgr.nowScore=archiveData.nowScore;
    MiniGame2048GamePlayFrameWorkMgr.nowMergeBlock=archiveData.nowMergeBlock;
    MiniGame2048GamePlayFrameWorkMgr.nowMergeMaxLevelBlock=archiveData.nowMergeMaxLevelBlock;
end


MiniGame2048GamePlayFrameWorkMgr.InitData=function ()
    if MiniGame2048GamePlayFrameWorkMgr.isInitData then
        return;
    end
    local config=ConfigMgr.Config.NumberBlockMap;
    for key, value in pairs(config) do
        MiniGame2048GamePlayFrameWorkMgr.PrivateDFSAddData(MiniGame2048GamePlayFrameWorkMgr.TagSplitTagList(value.MoveTimes),1,MiniGame2048GamePlayFrameWorkMgr.StartTagTree,key);
    end
    MiniGame2048GamePlayFrameWorkMgr.isInitData=true;
end


MiniGame2048GamePlayFrameWorkMgr.PrivateCreateTagTree=function ()
    local node={
        blockIdList={},
        tagNextPointMap={},
    }
    return node;
end

MiniGame2048GamePlayFrameWorkMgr.PrivateDFSAddData=function (tagList,tagListIndex,nowTreeNode,BlockId)
if tagListIndex==#tagList then
        local nowTag=tagList[tagListIndex];
        if nowTreeNode.tagNextPointMap[nowTag]==nil then
            local node=MiniGame2048GamePlayFrameWorkMgr.PrivateCreateTagTree();
            nowTreeNode.tagNextPointMap[nowTag]=node;
        end
        table.insert(nowTreeNode.tagNextPointMap[nowTag].blockIdList,BlockId);
    else
        local nowTag=tagList[tagListIndex];
        if nowTreeNode.tagNextPointMap[nowTag]==nil then
            local node=MiniGame2048GamePlayFrameWorkMgr.PrivateCreateTagTree();
            nowTreeNode.tagNextPointMap[nowTag]=node;
        end
        MiniGame2048GamePlayFrameWorkMgr.PrivateDFSAddData(tagList,tagListIndex+1,nowTreeNode.tagNextPointMap[nowTag],BlockId);
    end

end


MiniGame2048GamePlayFrameWorkMgr.TagSplitTagList=function (tag)
    local tagList=Split(tag,".");
    return tagList;
end

MiniGame2048GamePlayFrameWorkMgr.PrivateBFSSearchAllBlockList=function (tagList,tagListIndex,nowTreeNode)
    local nowTag=tagList[tagListIndex];
    local result={};
if nowTag=="*" then
        local queue=LuaO1DeQueue.New();
        for key, value in pairs(nowTreeNode.tagNextPointMap) do
            queue:PushLast(value);
        end
        while queue:Size()~=0 do
            local size=queue:Size();
            for i = 1, size, 1 do
                local temp=queue:PopFirst();
                
                for index2, value2 in ipairs(temp.blockIdList) do
                    table.insert(result,value2);
                end
                for key, value in pairs(temp.tagNextPointMap) do
                    queue:PushLast(value);
                end
            end
        end
        return result;
elseif nowTreeNode.tagNextPointMap[nowTag]==nil then
        return result;
elseif tagListIndex==#tagList then
        return nowTreeNode.tagNextPointMap[nowTag].blockIdList;
else
        return MiniGame2048GamePlayFrameWorkMgr.PrivateBFSSearchAllBlockList(tagList,tagListIndex+1,nowTreeNode.tagNextPointMap[nowTag]);
    end
end


MiniGame2048GamePlayFrameWorkMgr.GetBlockIdMapByTag=function (tag)
    local result={};
if MiniGame2048GamePlayFrameWorkMgr.PrivateTagCacheData[tag]~=nil then
        result=MiniGame2048GamePlayFrameWorkMgr.PrivateTagCacheData[tag];
else
        local tagList=MiniGame2048GamePlayFrameWorkMgr.TagSplitTagList(tag);
        local temp=MiniGame2048GamePlayFrameWorkMgr.PrivateBFSSearchAllBlockList(tagList,1,MiniGame2048GamePlayFrameWorkMgr.StartTagTree);
for index, value in ipairs(temp) do
            result[value]=true;
        end
        MiniGame2048GamePlayFrameWorkMgr.PrivateTagCacheData[tag]=result;
    end
    return result;
end


MiniGame2048GamePlayFrameWorkMgr.GetActionByOutInterface=function (blockId,actionType)
local config=ConfigMgr.Config.NumberBlockMap[blockId];
    local resultFun={};
    local resultParams={};
    local count=0;
    local targetParams={};
if actionType==1 then
        count=#config.CreateFunc;
        targetParams=config.CreateFunc;

    elseif actionType==2 then
        count=#config.HitSelf;
        targetParams=config.HitSelf;
    elseif actionType==3 then
        count=#config.HitObject;
        targetParams=config.HitObject;
    elseif actionType==4 then
        count=#config.CrashSelf;
        targetParams=config.CrashSelf;
    elseif actionType==5 then
        count=#config.CrashObject;
        targetParams=config.CrashObject;
    else
        print("MiniGame2048GamePlayFrameWorkMgr.GetActionByOutInterface Error")
        return;
    end
    for i = 1, count, 1 do
        if resultParams[i]==nil then
            resultParams[i]={};
        end
        local fun=MiniGame2048GamePlayFrameWorkOutInterface.GetOutInterface(targetParams[i][1]);
        table.insert(resultFun,fun);
        for j = 2, #targetParams[i], 1 do
            table.insert(resultParams[i],targetParams[i][j])
        end
    end
    return resultFun,resultParams;

end