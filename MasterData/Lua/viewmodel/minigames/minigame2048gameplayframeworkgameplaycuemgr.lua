MiniGame2048GamePlayFrameWorkGamePlayCueMgr={};

MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueGroupRect=nil;
MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAvailableGroup={};
MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAllGroup={};

MiniGame2048GamePlayFrameWorkGamePlayCueMgr.GAMEPLAYCUEPAHT="Assets/_BundleResources/UI/MiniGames/Effect/";
MiniGame2048GamePlayFrameWorkGamePlayCueMgr.InitCueMgr=function (group)
    MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueGroupRect=group
MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAvailableGroup={};
MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAllGroup={};
end

MiniGame2048GamePlayFrameWorkGamePlayCueMgr.GetGamePlayCue=function (gcId)
    local gcTable=MiniGame2048GamePlayFrameWorkGamePlayCueMgr.GamePlayCueTable[gcId];
    local path=MiniGame2048GamePlayFrameWorkGamePlayCueMgr.GAMEPLAYCUEPAHT..gcTable.allName;
    if gcTable.effectType==1 then
if TableIsNull(MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAvailableGroup[gcId]) then
            local temp=LuaMgr.GetPrefab(path);
            LuaMgr.AddPrefabRefCount(path);
            if MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAvailableGroup[gcId]==nil then
                MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAvailableGroup[gcId]={};
            end
            if MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAllGroup[gcId]==nil then
                MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAllGroup[gcId]={};
            end
            table.insert(MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAllGroup[gcId],temp);
            table.insert(MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAvailableGroup[gcId],temp);
            return temp;
        else
            local temp=MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAvailableGroup[gcId][1];
            table.remove(MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAvailableGroup[gcId],1);
            return temp;
        end
    end
end

MiniGame2048GamePlayFrameWorkGamePlayCueMgr.AddBeforeGamePlayCue=function (targetObj,gcId)
    local gcTable=MiniGame2048GamePlayFrameWorkGamePlayCueMgr.GamePlayCueTable[gcId];
    targetObj:SkillAddQueueGC(gcId,gcTable.time);
end

MiniGame2048GamePlayFrameWorkGamePlayCueMgr.AddGamePlayCue=function (targetObj,gcId)
    local gcTable=MiniGame2048GamePlayFrameWorkGamePlayCueMgr.GamePlayCueTable[gcId];
    MiniGame2048GamePlayFrameWorkGamePlayCueMgr.GamePlayCueTable[gcId].operateFunction(targetObj,gcId);
end

MiniGame2048GamePlayFrameWorkGamePlayCueMgr.AddGamePlayCueHelpFun=function (targetObj,gcId,gcObj)
    targetObj.gameplayCueMap[gcId]=gcObj;
end

MiniGame2048GamePlayFrameWorkGamePlayCueMgr.RemoveGamePlayCue=function (targetObj,gcId)
    local gcTable=MiniGame2048GamePlayFrameWorkGamePlayCueMgr.GamePlayCueTable[gcId];
    local temp=targetObj.gameplayCueMap[gcId];
    targetObj.gameplayCueMap[gcId]=nil;
table.insert(MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAvailableGroup[gcId],temp);
    local rect=temp:GetComponent("RectTransform");
    rect:SetParent(MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueGroupRect);
    rect.anchoredPosition=Vector2(0,0);
    SetActive(temp,false);
end

MiniGame2048GamePlayFrameWorkGamePlayCueMgr.ClearCueMgr=function ()
    for key, value in pairs(MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAllGroup) do
        local gcTable=MiniGame2048GamePlayFrameWorkGamePlayCueMgr.GamePlayCueTable[key];
        local path=MiniGame2048GamePlayFrameWorkGamePlayCueMgr.GAMEPLAYCUEPAHT..gcTable.allName;
        for i = 1, #value, 1 do
            LuaMgr.RemovePrefabRefCount(path);
            LuaMgr.DestroyImmediateGO(value);
        end
    end
MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAvailableGroup={};
MiniGame2048GamePlayFrameWorkGamePlayCueMgr.gamePlayCueIdToAllGroup={};
end

MiniGame2048GamePlayFrameWorkGamePlayCueMgr.GamePlayCueTable={
    ["IcebergEffect"]={
gcId="IcebergEffect",
effectType=1,
allName="UI_ice_ani_2048Number.prefab",

playType=0,
        time=0,

operateFunction=function (target,gcId)
            local temp=MiniGame2048GamePlayFrameWorkGamePlayCueMgr.GetGamePlayCue(gcId);
            local rect=temp:GetComponent("RectTransform");
            rect:SetParent(target.rectSpecialGamePlayCueGroup);
            rect.anchoredPosition3D=Vector3(0,0,0);
            rect.localScale=Vector3(1,1,1);
            SetActive(temp,true);
            local animator=temp:GetComponent("Animator");
            animator:Play("UI_ice_ani_001",0,0)
            MiniGame2048GamePlayFrameWorkGamePlayCueMgr.AddGamePlayCueHelpFun(target,gcId,temp);
        end
    },
    ["IcebergBreak"]={
gcId="IcebergBreak",
effectType=1,
allName="UI_ice_ani_break",

playType=1,

        time=0.5,
operateFunction=function (target,gcId)
            local animator=target.gameplayCueMap["IcebergEffect"]:GetComponent("Animator");
            local data=MiniGame2048GamePlayFrameWorkGamePlayCueMgr.GamePlayCueTable[gcId];
            if animator~=nil then
                animator:Play(data.allName,0,0);
            else
                print("Error,animator==nil")
            end
        end
    },
};