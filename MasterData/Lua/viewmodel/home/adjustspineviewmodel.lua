




local this = { vm = nil,
               characterSkin=nil,
               spineCharacter = nil, 
               skinDragBehaviour = nil,
               spineContentRect=nil,
               spinePosLimit={},
               localPosition = nil
}

local data = {
    bodyPath = "",
    bodyScale = Vector3.one,
    bodyPos = Vector2(0,0),
    slider=1.0,
    bgTexture=DefaultTexture,
}

local sliderValue=nil;
local fileData=nil;
local command = {
     closeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
           LuaMgr.Back();
        end
    },
     confirmBtn = {
         type = XLuaCommandType.Void,
         execute = function(vm,param)
             this.SaveSpineData()
             LuaMgr.Back();
         end
         
     },
     sliderCommand={
         type = XLuaCommandType.Float,
         execute = function(vm,value)
             sliderValue=value;
            this.vm.data.bodyScale=Vector3.one*sliderValue;
         end
     },
     reSetCommand={
         type = XLuaCommandType.Void,
         execute = function(vm,param)
             sliderValue=1.0;
             this.vm.data.slider=1.0;
             this.vm.data.bodyScale=Vector3.one*sliderValue;
             this.vm.data.bodyPos=Vector2(0,0);
         end
     },
     
     
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.spineCharacter = vm.behaviour.transform:Find("root/Middle/Character/Group/Body"):GetComponent("UISpineCharacter")
        this.skinDragBehaviour = vm.behaviour.transform:Find("root/Middle/Character/Group"):GetComponent("OnDragBehaviour")
        this.spineContentRect= vm.behaviour.transform:Find("root/Middle/Character/Group"):GetComponent("RectTransform")
        this.skinDragBehaviour.onDrag = this.OnDrag
        this.skinDragBehaviour.onPointerDown = this.PointerDown
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>0 then
            local characterId=vm.behaviour.Params[0]
            this.characterSkin=vm.behaviour.Params[1]
            local halfScreenWidth = LuaMgr.ScreenWidth() / 2
            this.spinePosLimit={halfScreenWidth,-halfScreenWidth,512,-512}
            this.vm.data.bodyPos = Vector2(0,0);
            local bgName=ConfigHelper.GetHomeBgTexture();
            local bgPath = string.format("Assets/_BundleResources/Images/Home/%s.png", bgName);
            this.vm.data.bgTexture = LuaMgr.GetTexture(bgPath);
            this.SetCharacter(characterId,this.characterSkin)
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.characterSkin = nil
        this.spineCharacter:Clear()
        
    end,
    before_destroy = function(vm)
        this = nil
    end,
}



this.SaveSpineData=function()
    local anchoredPosition=this.spineContentRect.anchoredPosition
    if fileData[this.characterSkin]==nil then
        fileData[this.characterSkin]={posX=anchoredPosition.x,posY=anchoredPosition.y,scale=sliderValue}
    else
        fileData[this.characterSkin].posX=anchoredPosition.x;
        fileData[this.characterSkin].posY=anchoredPosition.y;
        fileData[this.characterSkin].scale=sliderValue;
    end
    HeroMgr.SetSpineFile(fileData)
end


this.SetCharacter=function(characterId,skinId)
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, characterId,skinId);
    if (path ~= "") then
        this.vm.data.bodyPath = path;
    end
    sliderValue=1.0
    fileData=HeroMgr.GetSpineFile();
    if fileData==nil then
        fileData={}
    end;
    if fileData[skinId]~=nil then
        sliderValue=fileData[skinId].scale;
        this.vm.data.bodyPos=Vector2(fileData[skinId].posX,fileData[skinId].posY)
        this.vm.data.bodyScale=Vector3.one*sliderValue
    end
    this.vm.data.slider=sliderValue;
end


this.PointerDown = function(eventData)

    this.localPosition = LuaMgr.Screen2Local(eventData.position,this.spineContentRect)
end

this.OnDrag = function(eventData)

    local tarPos = LuaMgr.Screen2Local(eventData.position,this.spineContentRect)
    local dirVector = tarPos - this.localPosition
    if this.vm.data.bodyPos.x > this.spinePosLimit[1] and dirVector.x > 0 then
        dirVector = Vector2(0,dirVector.y)
    end
    if this.vm.data.bodyPos.x < this.spinePosLimit[2] and dirVector.x < 0 then
        dirVector = Vector2(0,dirVector.y)
    end
    if this.vm.data.bodyPos.y > this.spinePosLimit[3] and dirVector.y > 0 then
        dirVector = Vector2(dirVector.x,0)
    end
    if this.vm.data.bodyPos.y < this.spinePosLimit[4] and dirVector.y < 0 then
        dirVector = Vector2(dirVector.x,0)
    end
    this.vm.data.bodyPos = this.vm.data.bodyPos + dirVector
end


return vm({
    data = data,
    command = command,
    hook = hook
})