




require("ViewModel/Novel/NovelReview_HeadItem")
require("ViewModel/Novel/NovelReview_TextItem")

local this = {vm=nil,
              scrollViewList=nil,
              textItemObj=nil,
              headItemObj=nil,

};

local data={}
local command={}
local curHeadData=nil;
local curTextData=nil;
local curIndex=nil;

local coKey=nil;

local path="Assets/_BundleResources/Audio/NovelVoice/%s.mp3";
local tarGameObject = nil;
local tarRect = nil;
local textItem = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goScrollView = nil;
local Right = nil;
local btnMask = nil;
local tranContent=nil;
local audioSource=nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    textItem = uiLink:Get("textItem"):GetComponent("Text");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goScrollView = uiLink:Get("goScrollView");
    Right = uiLink:Get("Right");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    tranContent=uiLink:Get("tranContent");
    uiLink:AddClickEvent("btnMask",function()
       LuaMgr.HidePanel(UIName.NovelReviewViewModel)
    end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    textItem = nil;
    root = nil;
    Left = nil;
    Middle = nil;
    goScrollView = nil;
    Right = nil;
    btnMask = nil;
    tranContent=nil;

end



local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.scrollViewList=UIScrollView.New(goScrollView);
        this.headItemObj=vm.behaviour.transform:Find("template/headItem").gameObject;
        this.textItemObj=vm.behaviour.transform:Find("template/textItem").gameObject;
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil and vm.behaviour.Params.Length>0) then
           local jsonStr=vm.behaviour.Params[0];
            curIndex=nil;
            curTextData=nil;
            curHeadData=nil;
            local dialogList=json.decode(jsonStr)
            this.ParseData(dialogList);
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if vm.behaviour.Params ~= nil then
            this.scrollViewList:Clear(true);

            if audioSource~=nil then
                audioSource:Stop();
            end
            if coKey~=nil then
                coroutine_runner.stop(coKey);
            end
        end
    end,
    before_destroy=function()
        this.Clear()
        UIScrollView.ClearItem("NovelReview_HeadItem")
        UIScrollView.ClearItem("NovelReview_TextItem")
    end
}



this.ParseData=function(dialogList)
    local list={}
    local loc=1;
    local maxHeight=0;
    for i,v in ipairs(dialogList) do

        v.ContentKey=this.ReplacePart(v.ContentKey);
        if v.type==2 and v.NameKey~=""then
            local headItem={
                index=loc,
                isPlayer=v.NameKey=="player";
                text=v.NameKey=="player" and DataMgr.Player.name or v.NameKey;
                voice=v.voice,
                isPlaying=false,
                callBack=this.VoicePlayCallBack;
            }
            local headData=UIScrollData.GetData(this.headItemObj,"NovelReview_HeadItem",720,52,headItem);
            maxHeight=maxHeight+52;
            table.insert(list,headData);
            loc=loc+1
        end
        textItem.text=v.ContentKey;
        if v.ContentKey~=nil and v.ContentKey~="" then
            local texItem={
                index=loc,
                isOption=v.type==3;
                text=v.ContentKey;
                isPlaying=false;
                type=v.type;
                width=textItem.preferredWidth;
                isAide=v.NameKey==nil or v.NameKey=="" or v.NameKey=="null"
            }
            textItem.text=v.ContentKey;
            local textData=UIScrollData.GetData(this.textItemObj,"NovelReview_TextItem",720,textItem.preferredHeight+40,texItem);
            maxHeight=maxHeight+textItem.preferredHeight+40;
            table.insert(list,textData);
            loc=loc+1;
            textItem.text=""
        end
    end
    this.scrollViewList:SetParams(1280, 630)
    this.scrollViewList:SetData(list, true)
    tranContent.transform.anchoredPosition=Vector2(0,maxHeight);
end


this.ReplacePart=function(text)
    if string.match(text,"<part=left>") then
        text = string.gsub(text, "<part=left>", "");
    end
    if string.match(text,"<part=middle>") then
        text = string.gsub(text, "<part=middle>", "");
    end
    if string.match(text,"<part=right>") then
        text = string.gsub(text, "<part=right>", "");
    end
    if string.match(text,"</part>") then
        text = string.gsub(text, "</part>", "");
    end
    return text;
end

this.VoicePlayCallBack=function(index,isOn)
    if index~=curIndex or not isOn then
       this.ClearPlay();
    end
    curIndex=index;
    if isOn then

        for i,v in ipairs(this.scrollViewList.screenList) do
            if v.data.index==index then
                break
            end
        end
        curHeadData=this.scrollViewList.dataList[index].data;
        curTextData=this.scrollViewList.dataList[index+1].data
        curHeadData.isPlaying=true;
        curTextData.isPlaying=true;
        local voicePath=string.format(path,curHeadData.voice)
        audioSource=AudioMgr.Singleton:PlayVoice(voicePath);
        local len=0;
        if audioSource~=nil then
            len=audioSource.clip.length
        end

        for i,v in ipairs(this.scrollViewList.screenList) do
            if v.data.index==index then
                v:SetVoiceState(true,len)
            end
            if v.data.index==index+1 then
                v:TextPlay()
            end
        end
        coKey=coroutine_runner.start(function()
            coroutine_runner.wait(audioSource.clip.length);
            this.ClearPlay();
        end)
    end
    
end


this.ClearPlay=function()
    if coKey~=nil then
        coroutine_runner.stop(coKey);
    end
    if audioSource~=nil then
        audioSource:Stop();
    end

    if curIndex~=nil then
        for i,v in ipairs(this.scrollViewList.screenList) do
            if v.data.index==curIndex then
                v:SetVoiceState(false);
            elseif v.data.index==curIndex+1 then
                v:StopPlay();
            end
        end
    end
    if curHeadData~=nil then
        curHeadData.isPlaying=false;
    end
    if curTextData~=nil then
        curTextData.isPlaying=false;
    end 
end


return vm({
    data = data,
    command = command,
    hook = hook
})