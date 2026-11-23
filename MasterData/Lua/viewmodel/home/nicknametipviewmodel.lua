






local aniName01="ani_NicknameView_01";
local aniName02="ani_NicknameView_02";
local randomseed = 0
local _sex=0;
local curIndex=nil;
local callBack=nil;
local this = {vm=nil};
local data = {


  InputName="",
  NickNameData="",
  sexSort_lan=23,
  sexSort_nv=21,
  bgLightPos=Vector2(-119,-74);
  toglist={
      {
          on=true,
          off=false,
      },
      {
          on=true,
          off=false,
      }
      
  }
  
}
local command = {

    BtnRandomName={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            randomseed = randomseed + 1
            math.randomseed(randomseed)
            local fit = math.random(1001, 1093)
            local sed = math.random(2001, 2100)
            local fitName=ConfigMgr.Config.rollName[tostring(fit)];
            local sedName=ConfigMgr.Config.rollName[tostring(sed)];
            local nickName=LuaMgr.GetLangText(fitName.NameLan)..LuaMgr.GetLangText(sedName.NameLan);
            this.vm.data.NickNameData=nickName;
        end
        
    },
    SendNickNameCommand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local nickName=this.vm.data.NickNameData;
            local body={name=nickName,sex=_sex}
            ApiMgr.Request("update_name", body, true, function(result)
                LuaMgr.CallCreateRole(true)
                if callBack~=nil then
                    callBack()
                end
                LuaMgr.HidePanel(UIName.NickNameTipViewModel);
            end, nil, true);
            
        end
        
    },
    sexCommand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param);
            if curIndex==index then return end;
            curIndex=index;
            _sex=index==1 and 2 or 1;
            this.vm.data.sexSort_nv=index==1 and 23 or 21;
            this.vm.data.sexSort_lan=index==2 and 23 or 21;
            this.vm.data.bgLightPos=index==1 and Vector2(-119,-74) or Vector2(85,-74);
            for i,v in ipairs(this.vm.data.toglist) do
                v.on=index==1;
                v.off=index~=1;
            end
        end
    }
    
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            callBack=vm.behaviour.Params[1]
            LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish,this.SwitchAni)
            LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish,this.SwitchAni)
            this.ParseData();
        end
        randomseed = os.time()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish,this.SwitchAni)
        print("before_deactive");
    end,
}
this.ParseData=function()


    curIndex=0;
    _sex=2;
    this.vm.data.sexSort_nv=23;
    this.vm.data.sexSort_lan=21;
end

this.SwitchAni=function()


end


return vm({
    data = data,
    command = command,
    hook = hook
})