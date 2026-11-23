



local this = {  }
local torightTweener
local upTodownTweener
local UseCount = 0
local fishIds = {}
local fishItems = {}
local fishLua_Index = -1

local currentThemId = nil
local paramEventid = nil
local fishTypeToIndex={
    2,
    3,
    0,
    1,
    4,
}
local newCreateFishSprite={

}

local animatorCraneTween=nil;
local tarGameObject = nil;
local tarRect = nil;
local goCraneDot = nil;


local rectMask=nil;
local rectCranePos=nil;
local rectCraneLength=nil;
local rectYuGong=nil;
local goFailure1=nil;
local goFailure2=nil;
local goFailure3=nil;
local uiSpineCharacter=nil;
local goThinking=nil;
local goRight=nil;
local goWrong=nil;
local animatorRewardShow=nil;
local textNumber=nil;
local rawImageAward=nil;
local goTips=nil;
local goWin=nil;
local goFail=nil;
local isResult=false;
local coroutine = nil;
local fishObjs={};

local ITEM_ICON_PATH = "Assets/_BundleResources/Images/ItemIcons/itemicon_%s.png";

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    rectYuGong = uiLink:Get("rectYuGong"):GetComponent("RectTransform");
    goCraneDot = uiLink:Get("goCraneDot");


    animatorCraneTween=uiLink:Get("animatorCrane"):GetComponent("UITweenMove");
    uiSpineCharacter=uiLink:Get("uiSpineCharacter"):GetComponent("UISpineCharacter")
    rectMask=uiLink:Get("rectMask"):GetComponent("RectTransform");
    rectCranePos= uiLink:Get("animatorCrane"):GetComponent("RectTransform");
    rectCraneLength=uiLink:Get("rectCraneLength"):GetComponent("RectTransform");
    goFailure1=uiLink:Get("goFailure1");
    goFailure2=uiLink:Get("goFailure2");
    goFailure3=uiLink:Get("goFailure3");
    goThinking=uiLink:Get("goThinking");
    goRight=uiLink:Get("goRight")
    goWrong=uiLink:Get("goWrong");
    animatorRewardShow=uiLink:Get("animatorRewardShow"):GetComponent("Animator")
    textNumber=uiLink:Get("textNumber"):GetComponent("Text")
    rawImageAward=uiLink:Get("rawImageAward"):GetComponent("RawImage");
    goTips=uiLink:Get("goTips");
    goWin=uiLink:Get("goWin");
    goFail=uiLink:Get("goFail");

    for i = 1, 5 do
        local obj=uiLink:Get("goFish"..i)
        if IsNull(obj) then
            break;
        end
        
        table.insert(fishObjs,obj)
    end
    
    





    uiLink:AddClickEvent("btnClaw",this.OnStartFishing);
    uiLink:AddClickEvent("btnClose", this.OnClose);
    uiLink:AddClickEvent("btnClose1", this.OnClose2);
    uiLink:AddClickEvent("btnClose2", this.OnClose2);
end

this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    goCraneDot = nil;


    rectMask=nil;
    rectCranePos=nil;
    rectCraneLength=nil;
    animatorCraneTween=nil;
    uiSpineCharacter:Clear();
end

this.OnClose=function()
    if coroutine ~= nil then
        return ;
    end
    
    
    local fishCount= ConfigMgr.Config.InternConstants.FishTimes;
    if  UseCount>=fishCount  then
        LuaMgr.HidePanel(UIName.MiniGameFishViewModel);
        return;
    end

    local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7103"].NameLan)
    LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, tipStr, this.NetDataSuccssful, nil)
end

this.OnClose2=function()
    LuaMgr.HidePanel(UIName.MiniGameFishViewModel);
end


this.NetDataSuccssful = function()
    local data=nil;
    if fishIds~=nil and #fishIds>0 then
        data={ ThemeId = currentThemId, EventType = paramEventid, FishIds=fishIds,Win=true}
    else
        data={ ThemeId = currentThemId, EventType = paramEventid,Win=false}
    end

    local Url = "fish/finished"
    ApiMgr.Request(Url, data, true,
            function(result)

                for i,v in pairs(fishItems) do
                    for i = 1, #v do
                        this.SetRigidbody(v[i].gameObject);
                    end
                end

                if fishIds~=nil and #fishIds>0 then
                    SetActive(goWin,true)
                    SetActive(goFail,false)
                else
                    SetActive(goWin,false)
                    SetActive(goFail,true)
                end

                if torightTweener ~= nil then
                    torightTweener:Kill()
                    torightTweener=nil;
                end
                animatorCraneTween:Pause();
                coroutine = coroutine_runner.start(
                        function()
coroutine_runner.wait(1)
                            isResult=true;
                            coroutine=nil;
                        end )
                
            end,
            function(failCode)
            end,
            true
    )
end


this.OnStartFishing = function()
    if isResult then

        return
    end
    
    local fishCount= ConfigMgr.Config.InternConstants.FishTimes;
    if UseCount>=fishCount then


        return;
    end
    
    if fishLua_Index>=0 or upTodownTweener ~= nil then

        return
    end
    

fishLua_Index=0;
animatorCraneTween:Pause();
    this.UpDownMove(-1,function()

        if fishLua_Index>0 then

            return;
        end
        
           coroutine = coroutine_runner.start(
                    function()
coroutine_runner.wait(0.02)
                        coroutine=nil;
                        if fishLua_Index>0 then

                            return;
                        end

                        this.FailMove();

                    end
            )
end)
end

this.FailMove=function()
    this.UpDownMove(1,function()

        if fishLua_Index>0 then

            return;
        end
        SetActive(goThinking,false)
        SetActive(goRight,false)
        SetActive(goWrong,true)
        SetActive(goTips,true)
        uiSpineCharacter:Play("lose", true, function()
            uiSpineCharacter:Play("idle", true, nil)
            SetActive(goWrong,false)
            SetActive(goTips,false)
        end)

        this.RestMove(function()

            if fishLua_Index>0 then

                return;
            end

            UseCount = UseCount + 1
            SetActive(goFailure1,UseCount>=1)
            SetActive(goFailure2,UseCount>=2)
            SetActive(goFailure3,UseCount>=3)

fishLua_Index = -1

            local fishCount= ConfigMgr.Config.InternConstants.FishTimes;
            if UseCount>=fishCount then
                coroutine = coroutine_runner.start(
                        function()
                            coroutine_runner.wait(2)
this.NetDataSuccssful();
                            coroutine=nil;
                        end )
            end

        end)

    end)

end



local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject);
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then

            currentThemId = vm.behaviour.Params[0];
            paramEventid = vm.behaviour.Params[1];
            coroutine = nil;
            isResult=false;
            SetActive(goThinking, false)
            SetActive(goRight, false)
            SetActive(goWrong, false)
            SetActive(goWin, false)
            SetActive(goFail, false)
            SetActive(goTips, false)
            rectCraneLength.sizeDelta=Vector2(3, 8);
rectCranePos.localPosition = Vector3(490, 244, 0)
            fishIds = {}
            UseCount = 0;
            fishLua_Index = -1

            SetActive(goFailure1, false)
            SetActive(goFailure2, false)
            SetActive(goFailure3, false)

            local fishes = DataMgr.Player.fish.Fishes;
            local fishMap = ConfigMgr.Config.GameFishMap;
            local fishNum = #fishes


            local offestY = 168
for i = 1, 5, 1 do
                local texture=LuaMgr.GetTexture("Assets/_BundleResources/Images/MiniGameFish/ui_xwf_dy_fish_"..tostring(fishTypeToIndex[i])..".png");
                newCreateFishSprite[i]=LuaMgr.Texture2DToSprite(texture);
            end
            for i = 1, fishNum do
                local fishItem = fishMap[fishes[i]];
                if fishItems[fishItem.FishType]==nil then
                    fishItems[fishItem.FishType]={};
                end

                local typeIndex=1;
                local fishObj=nil;
                for i = 1, #fishItems[fishItem.FishType] do
                    if not fishItems[fishItem.FishType][i].gameObject.activeSelf then
                        fishObj=fishItems[fishItem.FishType][i];
                        typeIndex=i;
                        break;
                    end
                end

                if fishObj==nil or IsNull(fishObj) then
                    fishObj =LuaMgr.InstantiateGO(fishObjs[fishItem.FishType], rectMask, false):GetComponent("UITweenMove")
                    table.insert(fishItems[fishItem.FishType], fishObj)
                    typeIndex=#fishItems[fishItem.FishType];
                end
                fishObj.transform:Find("root/icon").gameObject:GetComponent("CustomShaderMaskImage").sprite=newCreateFishSprite[fishItem.FishType];
                fishObj.transform:SetParent(rectMask)
if fishItem.FishType==5 then
                    fishObj.transform.localScale = Vector3(0.7, 0.7, 0.7)
                else
                    fishObj.transform.localScale = Vector3(1, 1, 1)
                end
                SetActive(fishObj.gameObject, true)

                local position=fishItem.Position
                if fishItem.Position>0 then
                    fishObj.moveType=CS.Laigu.Tools.UITools.MoveType.Right;
                else
                    fishObj.moveType=CS.Laigu.Tools.UITools.MoveType.Left;
                end

                local posY = offestY - ( math.abs(position) / 100.0) * (offestY * 2)

                if fishObj.moveType == CS.Laigu.Tools.UITools.MoveType.Left then
                    fishObj.transform.localPosition = Vector3(500, posY, 0)
                elseif fishObj.moveType == CS.Laigu.Tools.UITools.MoveType.Right then
                    fishObj.transform.localPosition = Vector3(-500, posY, 0)
                elseif true then

                end

                this.SetRigidbody(fishObj.transform, true)

                fishObj.name =fishItem.FishType.."|"..typeIndex.."|"..i;
            end

            local characterId = DataMgr.Player.sex > 1 and "SCJ202" or "SCJ201"
            uiSpineCharacter:Clear()
            uiSpineCharacter:SetBattle(characterId, characterId .. "001", "", ConfigMgr.Config.characterTable[characterId].job)
animatorCraneTween:ReStart();
            LuaMgr.AddUIEventListener(UIEventConst.MiniGameToyCraneGetToy, this.OnFishCollider);
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            for i,v in pairs(fishItems) do
                for i = 1, #v do
                    this.SetRigidbody(v[i].gameObject);
                   SetActive(v[i].gameObject,false);
                end
            end
            
            LuaMgr.RemoveUIEventListener(UIEventConst.MiniGameToyCraneGetToy, this.OnFishCollider);
            LuaMgr.InvokeUIEventListeners(UIEventConst.CollectorEventPanelClose);
            uiSpineCharacter:Clear();
        end
    end,
    before_destroy = function(vm)
        this.Clear();
    end,
}


this.LeftPointerDown = function()
    if isResult then

        return
    end
    
    if fishLua_Index>=0 then
        return
    end
    
    this.LeftRightMove(-1)
end


this.RightPointerDown = function()
    if isResult then

        return
    end
    
    if fishLua_Index>=0 then
        return
    end
    
    this.LeftRightMove(1)
end


this.LeftOnPointerUp = function()
    if isResult then

        return
    end
    
    if fishLua_Index>=0 or upTodownTweener ~= nil then

        return
    end
    
    if torightTweener ~= nil then
        torightTweener:Kill()
        torightTweener=nil;
    end

end


this.RightOnPointerUp = function()
    if isResult then

        return
    end
    
    if fishLua_Index>=0 or upTodownTweener ~= nil then

        return
    end
    
    if torightTweener ~= nil then
        torightTweener:Kill()
        torightTweener=nil;
    end

end


this.LeftRightMove = function(type)
    if torightTweener~=nil then
        return
    end
    
local posRight = Vector3(490, 244, 0)
local posLeft = Vector3(-100, 244, 0)
    local currenpos = rectCranePos.localPosition
local posEnd = type > 0 and posRight or posLeft
    local distance = math.abs(currenpos.x - posEnd.x);
local time=distance/196.0
    

    
    torightTweener = DOTWeen.To(
    function()
        return currenpos
    end,
    function(vector)
        rectCranePos.localPosition = vector
    end,
    posEnd, time
    )
end

this.UpDownMove = function(_upDownMoveType,fun)
    if upTodownTweener ~= nil then
        upTodownTweener:Kill()
        upTodownTweener.onComplete = nil
        upTodownTweener = nil
    end
    
upDownMoveType = _upDownMoveType

    local startPos = upDownMoveType < 0 and Vector2(3, 8) or Vector2(3, rectCraneLength.sizeDelta.y)
    local endPos = upDownMoveType < 0 and Vector2(3, 360) or Vector2(3, 8)
    local startY=math.abs(startPos.y);
    local endY=math.abs(endPos.y);
local time=math.abs(startY-endY)/119.0
    
    upTodownTweener = DOTWeen.To(
            function()
                return startPos
            end,
            function(vector)
                rectCraneLength.sizeDelta = vector
            end,
            endPos,
            time
    )

    upTodownTweener.onComplete = function()
        if fun~=nil then
            fun();
        end

        upTodownTweener:Kill()
        upTodownTweener.onComplete = nil
        upTodownTweener = nil
    end
end

this.OnFishCollider = function(args)
    if fishLua_Index<=-1 then

        return;
    end

    if fishLua_Index>0 then

        return;
    end
    
    local listItems=split(args[0],"|")
    
    local fishType= tonumber(listItems[1])
    local fishTypeIndex = tonumber(listItems[2]);
    local fishIndex = tonumber(listItems[3]);
    
    local fishMap=ConfigMgr.Config.GameFishMap;
    local fishFailProb=ConfigMgr.Config.InternConstants.FishFailProb;
    local probNum=#fishFailProb


    
    for i = 1, probNum do
        if fishFailProb[i][1] == fishMap[DataMgr.Player.fish.Fishes[fishIndex]].FishType then
            local failProb=fishFailProb[i][2];
            local randProb=math.random(0,100)
if randProb<failProb then
                LuaDebug.error("鱼脱钩了  随机参数 ："..randProb.."配置参数 ："..failProb);
                this.FailMove();
                return;
            end
        end
    end
    

    fishLua_Index = fishIndex

    
    local rectFish = fishItems[fishType][fishTypeIndex].transform:GetComponent("RectTransform")
    this.SetRigidbody(rectFish,false)
    rectFish:SetParent(rectYuGong)
    rectFish.localPosition=Vector3.zero;
    rectFish.anchoredPosition=Vector2.zero;


    
    this.UpDownMove(1,function()
        
        local movetoPool = fishItems[fishType][fishTypeIndex].transform
        movetoPool.gameObject:SetActive(false)
        SetActive(goThinking,false)
        SetActive(goWrong,false)
        SetActive(goTips,true)
        SetActive(goRight,true)
        uiSpineCharacter:Play("victory", false, function()
            uiSpineCharacter:Play("idle", true, nil)
            SetActive(goRight,false)
            SetActive(goTips,false)
        end)

        local id=DataMgr.Player.fish.Fishes[fishIndex];
        table.insert(fishIds,id)
        UseCount = UseCount + 1
        local itemAward= fishMap[id].ItemId
        textNumber.text="+"..itemAward.count;
        rawImageAward.texture= LuaMgr.GetTexture(string.format(ITEM_ICON_PATH, itemAward.id));
        animatorRewardShow:Play("MiniGamesRewardTip_1", 0, 0)
        
        this.RestMove(function()
            SetActive(goFailure1,UseCount>=1)
            SetActive(goFailure2,UseCount>=2)
            SetActive(goFailure3,UseCount>=3)


            fishLua_Index = -1

            local fishCount= ConfigMgr.Config.InternConstants.FishTimes;
            if UseCount>=fishCount then
                coroutine = coroutine_runner.start(
                        function()
                            coroutine_runner.wait(2)
this.NetDataSuccssful();
                            coroutine = nil;
                        end )
            end
        end)


    end)
end

this.RestMove = function(fun)
    local endPos = rectCranePos.localPosition
    local startPos = Vector3(-100, 244, 0)
    local rightX=math.abs(startPos.x);
    local leftX=math.abs(endPos.x);
local time=math.abs(rightX-leftX)/130.0
torightTweener = DOTWeen.To(
            function()
                return endPos
            end,
            function(vector)
rectCranePos.localPosition=vector;
            end,
            startPos,
            time
    ):SetEase(Ease.Linear)

    torightTweener.onComplete = function()
        if fun~=nil then
            fun();
        end
animatorCraneTween:GetTween():Goto(0,true);
        torightTweener:Kill()
        torightTweener.onComplete = nil
        torightTweener = nil
    end
end

this.SetRigidbody=function(target, isOn)
    local rigidbody= target:GetComponent("Rigidbody2D") 
    local tweenMove= target:GetComponent("UITweenMove")
    local collider= target:GetComponent("CapsuleCollider2D")
    rigidbody.simulated=isOn;
    collider.enabled=isOn;
    if isOn then
        tweenMove:ReStart();
    else
        tweenMove:Pause();
    end
    tweenMove.enabled=isOn;
    end

return vm({
    hook = hook
})