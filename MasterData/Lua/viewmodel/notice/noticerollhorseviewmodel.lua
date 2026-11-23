





local this = {vm=nil};
local curCount=0;
local contentText=nil;
local callBack=nil;
local startPosX=0;
local rate=4;
local tweener=nil;
local data = {

    contentText="",
    contentPos=Vector2(startPosX,0);
}

local command = {
    closeBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          LuaMgr.HidePanel(UIName.CalendarViewModel);
      end
    },
   
  
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        contentText=vm.behaviour.transform:Find("root/Middle/Bg/Mask/Content"):GetComponent("Text");
       
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if  vm.behaviour.Params.Length>0 then
            local data=vm.behaviour.Params;
            local rollItem=data[0];
            callBack=data[1];
            this.ParseData(rollItem.Contents);
            
        end
        
    end,
    before_deactive = function(vm)
        if tweener~=nil then
            tweener:Kill();
        end
        if callBack~=nil then
            callBack();
        end
    end,
}
this.ParseData=function(content)
    this.vm.data.contentText=content;
    startPosX=math.floor(contentText.preferredWidth/2)+320;
    local charX= contentText.preferredWidth / #content;
    local widthOff=charX* rate;
    local  time=(640 + contentText.preferredWidth/2) / widthOff;
    curCount=0;
    this.DoMove(time,function()
        LuaMgr.HidePanel(UIName.NoticeRollhorseViewModel);
    end)
end


this.DoMove=function(time,callBack)

    tweener=DOTWeen.To(function() return Vector2(startPosX,0)  end,
            function(vector) this.vm.data.contentPos=vector end,
Vector2(-startPosX,0),time):SetEase(Ease.Linear);
    tweener.onComplete=function()
        if callBack~=nil then
            callBack();
        end
    end
end



return vm({
    data = data,
    command = command,
    hook = hook
})