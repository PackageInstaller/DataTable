






local this = {vm=nil};
local data={}
local command={}

local interCfg=nil;
local msgIndex=nil;
local worldPos=nil;
local msgList={}



local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local tranMsg = nil;
local rectMask = nil;
local tranFinger = nil;
local rawImageHead = nil;
local txtMsg = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    tranMsg = uiLink:Get("tranMsg"):GetComponent("RectTransform");
    rectMask = uiLink:Get("rectMask"):GetComponent("RectTransform");
    tranFinger = uiLink:Get("tranFinger"):GetComponent("RectTransform");
    rawImageHead = uiLink:Get("rawImageHead"):GetComponent("RawImage");
    txtMsg = uiLink:Get("txtMsg"):GetComponent("Text");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    tranMsg = nil;
    rectMask = nil;
    tranFinger = nil;
    rawImageHead = nil;
    txtMsg = nil;

end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
       
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            interCfg=vm.behaviour.Params[0];
            msgIndex=vm.behaviour.Params[1]
            if vm.behaviour.Params.Length>2 then
                worldPos=vm.behaviour.Params[2];
            end
            SetActive(tranMsg.gameObject,false)
            SetActive(tranFinger.gameObject,false)
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
    end,
    before_destroy=function()
        this.Clear()
    end
}
this.ParseData=function()
    local msg=LuaMgr.GetLangText(interCfg.MsgLan);
    msgList=NumTool.split(msg,"|");
    this.SetMsg();
    this.SetFinger();
end

this.SetMsg=function()
    SetActive(tranMsg.gameObject,true)
    local msg=msgList[msgIndex]
    if string.match(msg,"player") then
        msg=LuaMgr.Replace(msg,"player",DataMgr.Player.name)
    end
    txtMsg.text=msg;
    local skindId=interCfg.IconList[msgIndex]
    local characterId=string.sub(skindId,1,5);
    local path=ConfigHelper.GetCharacterRoundPath(characterId,skindId)
    rawImageHead.texture=LuaMgr.GetTexture(path);
end

this.SetFinger=function()
    if worldPos==nil then return end;
    SetActive(tranFinger.gameObject,true)
    local rectTf=Middle:GetComponent("RectTransform");
    local rectPos=LuaMgr.World2Local(worldPos,rectTf)
    tranFinger.anchoredPosition=rectPos;
end


return vm({
    data = data,
    command = command,
    hook = hook
})