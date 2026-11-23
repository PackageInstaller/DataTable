




UI2048Number = {}
UI2048Number.__index = UI2048Number
local PREFAB_PATH = "Assets/_BundleResources/UI/MiniGames/UI2048Number.prefab";

function UI2048Number.New(parent)
    local self = {}
    setmetatable(self, UI2048Number)
    self.gameObject = LuaMgr.GetPrefab(PREFAB_PATH)
    LuaMgr.AddPrefabRefCount(PREFAB_PATH);
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.transform:SetParent(parent);
    self.transform.localScale=Vector3.one;
    self.transform.localPosition=Vector3.zero;
    self.transform.offsetMin = Vector2.zero;
    self.transform.offsetMax = Vector2.zero;

    local uiLink = self.gameObject:GetComponent("UILink");
    self.bg = uiLink:Get("imgNumberPic"):GetComponent("Image");
    self.rectSpecialGamePlayCueGroup=uiLink:Get("rectSpecialGamePlayCueGroup"):GetComponent("RectTransform");
self.inGrid=nil;
self.status=0;
    self.currNumId="";
    self.spawnScaleTime=1.0;
    self.isPlayingSpawnAnim=false;
    self.mergeSceleTime=1.0;
    self.mergeSceleTimeBack=1.0;
    self.isPlayingMergeAni=false;
    self.movePosTime=1.0;
    self.isMoving=false;
    self.isDestroyOnMoveEnd=false;
    self.startMove=nil;
    self.endMovePos=nil;
self.gameplayBuffList={};
self.gameplayBuffAttribute={};
self.gameplayCueMap={};

self.queueGC=LuaO1DeQueue.New();
    self.waitNowGcTime=0;

    self.tempMergeTarget=nil;
    self.playNextStageMerge=false;
    self.score=nil;
    return self
end

function UI2048Number:Destroy()
    if self.gameObject~=nil then
        LuaMgr.RemovePrefabRefCount(PREFAB_PATH);
        LuaMgr.DestroyImmediateGO(self.gameObject);
        self.gameObject = nil
        self.transform = nil
        self.bg = nil;
        self.rectSpecialGamePlayCueGroup=nil;
    end
end

function UI2048Number:Clear()
self.inGrid=nil;
self.status=nil;
    self.currNumId=nil;
    self.spawnScaleTime=nil;
    self.isPlayingSpawnAnim=nil;
    self.mergeSceleTime=nil;
    self.mergeSceleTimeBack=nil;
    self.isPlayingMergeAni=nil;
    self.movePosTime=nil;
    self.isMoving=nil;
    self.isDestroyOnMoveEnd=nil;
    self.startMove=nil;
    self.endMovePos=nil;
    self.gameplayBuffList=nil;
    self.gameplayBuffAttribute=nil;
    self.gameplayCueMap=nil;
    self.tempMergeTarget=nil;
    self.playNextStageMerge=nil;
    self.queueGC=nil;
    self.score=nil;
    
    SetActive(self.gameObject, false)
end



function UI2048Number:SkillCreateSelf(myGrid,blockId,needWait)
    self.transform:SetParent(myGrid.transform);
    self.transform.localPosition = Vector3.zero;
    SetActive(self.gameObject, true)
    self:SetGrid(myGrid);
    self:SetNumberData(blockId);
    self:SetNumberPic(blockId);
local funList,paramsList=MiniGame2048GamePlayFrameWorkMgr.GetActionByOutInterface(blockId,1)
    local count=#funList;
    for i = 1, count, 1 do
        funList[i](self,paramsList[i]);
    end
    MiniGame2048GamePlayFrameWorkMgr.AddNowMergeBlock(blockId);
    self:PlaySpawnAnim(needWait);
end


function UI2048Number:SkillMove(targetGrid)
    self:SetGrid(targetGrid);
    self:PlayMoveAnim(targetGrid,false);
end



function UI2048Number:SkillMoveAndMerge(notMergeGrid,targetGrid,type,addNotMerge)

    local helpFun=function (mergeSuccesObject,mergeSuccesObjectNumID,mergeFailObject,type)
        local funList,paramsList=MiniGame2048GamePlayFrameWorkMgr.GetActionByOutInterface(mergeSuccesObjectNumID,type==1 and 2 or 4)
        local count=#funList;
        for i = 1, count, 1 do
            funList[i](mergeSuccesObject,paramsList[i]);
        end

        local funList,paramsList=MiniGame2048GamePlayFrameWorkMgr.GetActionByOutInterface(mergeSuccesObjectNumID,type==1 and 3 or 5)
        local count=#funList;
        for i = 1, count, 1 do
            funList[i](mergeFailObject,paramsList[i]);
        end
    end
    if addNotMerge then
        MiniGame2048GamePlayFrameWorkBuff.AddBuffToTarget(self,"NotMerge",{},{1,-1})
        MiniGame2048GamePlayFrameWorkBuff.AddBuffToTarget(targetGrid:GetNumberObj(),"NotMerge",{},{1,-1})
    end
    local numId=nil;
if type==1 then
numId=self.currNumId;
        helpFun(self,numId,targetGrid:GetNumberObj(),type);
elseif type==2 then
numId=targetGrid:GetNumberObj().currNumId;
        helpFun(targetGrid:GetNumberObj(),numId,self,type);
    end

if self.currNumId==nil then
        self:SetGrid(nil);
        if self.gameplayBuffAttribute["ForceMove_target"] then
            self:PlayMoveAnim(targetGrid,true);
        elseif self.gameplayBuffAttribute["ForceMove_beforeTarget"] then
            self:PlayMoveAnim(notMergeGrid,true);
        else
            self:PlayMoveAnim(targetGrid,true);
        end
else
        self:SetGrid(notMergeGrid);
        if self.gameplayBuffAttribute["ForceMove_target"] then
            self:PlayMoveAnim(targetGrid,false);
        elseif self.gameplayBuffAttribute["ForceMove_beforeTarget"] then
            self:PlayMoveAnim(notMergeGrid,false);
        else
            self:PlayMoveAnim(notMergeGrid,false);
        end
    end


targetGrid:GetNumberObj():PlayMergeAnim();
    if targetGrid:GetNumberObj():GetNumberId()==nil then
        targetGrid:GetNumberObj():SetGrid(nil); 
    end

self.tempMergeTarget=targetGrid:GetNumberObj();
end


function UI2048Number:SkillCheckBuff()
    MiniGame2048GamePlayFrameWorkBuff.CheckBuff(self);
end


function UI2048Number:SkillAddQueueGC(gcId,time)
    self.queueGC:PushFirst({gcId=gcId,time=time});
end




function UI2048Number:ArchiveSetData(targetGrid,blockId)
    SetActive(self.gameObject,true);
    self:SetGrid(targetGrid);
    self:SetNumberData(blockId);
    self:SetNumberPic(blockId);
    self.transform:SetParent(targetGrid.transform);
    self.transform.localPosition=Vector3.zero;
    self.transform.localScale=Vector3.one;
end


function UI2048Number:ArchiveSetBuffData(gameplayBuffList,gameplayBuffAttribute)
self.gameplayBuffList=gameplayBuffList;
self.gameplayBuffAttribute=gameplayBuffAttribute;
end

function UI2048Number:ArchiveSetGCData(gameplayCueMap)
    local data={};
    for key, value in pairs(self.gameplayCueMap) do
        data[key]=false;
    end
    for key, value in pairs(gameplayCueMap) do
        data[key]=true;
    end
for key, value in pairs(data) do

if value and (self.gameplayCueMap[key]==nil) then
            MiniGame2048GamePlayFrameWorkGamePlayCueMgr.AddGamePlayCue(self,key);
elseif (not value) and (self.gameplayCueMap[key]~=nil) then
            MiniGame2048GamePlayFrameWorkGamePlayCueMgr.RemoveGamePlayCue(self,key);
        end

    end
end


function UI2048Number:SetNumberData(numberId)
    self.currNumId = numberId;
    MiniGame2048GamePlayFrameWorkMgr.AddNowMergeBlock(numberId);
end

function UI2048Number:SetNumberPic(numberId)
    local item=ConfigMgr.Config.NumberBlockMap[numberId];
    if item~=nil then
        self.bg.sprite = LuaMgr.GetSprite("2048",item.Picture);
        self.score=item.Score;
    end
end


function UI2048Number:GetNumberId()
    return self.currNumId;
end


function UI2048Number:SetGrid(myGrid)
    if self.inGrid~=nil then
        self.inGrid:SetNumberObj(nil);
    end
    if myGrid~=nil then
        myGrid:SetNumberObj(self);
    end
    self.inGrid=myGrid;
end


function UI2048Number:PlaySpawnAnim(needWait)
    if self.gameplayBuffAttribute["NotPlayNormalGC_spawn"] then
        self.spawnScaleTime = 1;
    else
        self.spawnScaleTime = 0;
    end
    self.transform.localScale=Vector3.zero;
    if needWait then
self.co = coroutine_runner.start(function()
            coroutine_runner.wait(0.15)
            self.isPlayingSpawnAnim = true;
            self.co=nil;
        end)
    else
        self.isPlayingSpawnAnim = true;
    end
end


function UI2048Number:PlayMergeAnim()
    if self.gameplayBuffAttribute["NotPlayNormalGC_merge"] then
        self.mergeSceleTime = 1;
        self.mergeSceleTimeBack = 1;
        self.playNextStageMerge=true;
    else
        self.mergeSceleTime = 0;
        self.mergeSceleTimeBack = 0;
        self.playNextStageMerge=false;
    end
    self.isPlayingMergeAnim = true;
    self.isSetNumber = true;
end


function UI2048Number:PlayMoveAnim(myGrid,isEndMoveDestory)
    self.transform:SetParent(myGrid.transform);
    self.startMove = self.transform.localPosition;
    if self.gameplayBuffAttribute["NotPlayNormalGC_move"] then
        self.movePosTime = 1;
    else
        self.movePosTime = 0;
    end
    self.isMoving = true;
    self.isDestroyOnMoveEnd = isEndMoveDestory;
end

function UI2048Number:PlayNextStageMergeAnimation()
    self.playNextStageMerge=true;
end

function UI2048Number:CheckDequeueGC()
    if self.waitNowGcTime>0 then
        self.waitNowGcTime=self.waitNowGcTime-UnityEngine.Time.deltaTime;
        return false;
    else
        if self.queueGC:Size()==0 then
            return true;
        else
            local data=self.queueGC:PopFirst();
            MiniGame2048GamePlayFrameWorkGamePlayCueMgr.AddGamePlayCue(self,data.gcId);
            self.waitNowGcTime=data.time;
            return false;
        end
    end
end

function UI2048Number:Update()

    if  self.isPlayingSpawnAnim then
        if self.spawnScaleTime <= 1 then
            self.spawnScaleTime = self.spawnScaleTime+ UnityEngine.Time.deltaTime * 4;
            self.transform.localScale = Vector3.Lerp(Vector3.zero, Vector3.one,  self.spawnScaleTime);
        else
            if self:CheckDequeueGC() then
                self.isPlayingSpawnAnim = false;
            end
        end
    end


    if self.isPlayingMergeAnim then
if self.mergeSceleTime <= 1 and self.mergeSceleTimeBack == 0 then
            self.mergeSceleTime =self.mergeSceleTime+ UnityEngine.Time.deltaTime * 4;
            self.transform.localScale = Vector3.Lerp(Vector3.one, Vector3.one * 1.2, self.mergeSceleTime);
        end

        if  self.mergeSceleTime >= 1 and  self.mergeSceleTimeBack <= 1 then
            self.mergeSceleTimeBack =  self.mergeSceleTimeBack + UnityEngine.Time.deltaTime * 4;
            self.transform.localScale = Vector3.Lerp(Vector3.one * 1.2, Vector3.one, self.mergeSceleTimeBack);
        end


        if self.mergeSceleTime >= 1 and self.isSetNumber and self.playNextStageMerge then
            self:SetNumberPic(self.currNumId);
            self.isSetNumber = false;
        end
        

        if self.mergeSceleTime >= 1 and self.mergeSceleTimeBack >= 1 then
            if self:CheckDequeueGC() then
                if self.currNumId==nil then
self:OnRecover();
                end
                self.isPlayingMergeAnim = false;
            end
        end
    end


    if self.isMoving then
        self.movePosTime =self.movePosTime+ UnityEngine.Time.deltaTime * 5.5;
        self.transform.localPosition = Vector3.Lerp(self.startMove, Vector3.zero, self.movePosTime);
        if self.movePosTime >= 1 then
self:SetNumberPic(self.currNumId);
            if self:CheckDequeueGC() then
                self.isMoving = false;
                if self.isDestroyOnMoveEnd then
                    self:OnRecover();
                    if self.tempMergeTarget~=nil then
                        self.tempMergeTarget:PlayNextStageMergeAnimation();
                        self.tempMergeTarget=nil;
                    end

                end
            end

        end
    end

end

function UI2048Number:OnRecover()

    self:SetGrid(nil);
    SetActive(self.gameObject,false)
    self.isDestroyOnMoveEnd = false;
    self.status = 0;

self.gameplayBuffList={};
self.gameplayBuffAttribute={};
    for key, value in pairs(self.gameplayCueMap) do
        MiniGame2048GamePlayFrameWorkGamePlayCueMgr.RemoveGamePlayCue(self,key);
    end
    self.gameplayCueMap={};
    self.score=nil;
    if self.co~=nil and (not coroutine_runner.checkIsDestory()) then
        coroutine_runner.stop(self.co)
    end
end


