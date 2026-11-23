




local this = { vm = nil; };
local path="Assets/_BundleResources/Images/Archives/";
local relicsAction=nil;
local linkID=nil;
local linkIndex=nil;
local historicalRelicsMap=nil;
local characterList={};
local cfgCharacterTable={};
local cfgHistoricalText={};
local dataCharacter={};
local coroutineKey=nil;

local infoTf=nil;

local data = {
    relicsList={
        {
            relicsIcon = DefaultTexture,
            name = "",
            lock = false,
            alpha=0.0,
        }
    },
    linkName="",
    linkDes="",
    linkInfo="",
    contentPos=Vector2(0,0);
}

local command = {
    relicsBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          local index=tonumber(param)+1;
          local charaId=this.vm.data.relicsList[index].characterId;
          if relicsAction~=nil and charaId~=nil then
              relicsAction(charaId);
          end
          LuaMgr.HidePanel(UIName.HeroArchivesLinkViewModel)
      end
    },
    closeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.HidePanel(UIName.HeroArchivesLinkViewModel)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        infoTf=vm.behaviour.transform:Find("root/Middle/BG/Left/Scroll View/Viewport/Info"):GetComponent("Transform");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>0 then
            local data=vm.behaviour.Params;
            linkIndex=data[0];
            linkID=data[1];
            relicsAction=data[2];
            
            historicalRelicsMap=ConfigMgr.Config.historicalRelicsMap;
            cfgHistoricalText=ConfigMgr.Config.HistoricalTextMap[linkID];
            cfgCharacterTable=ConfigMgr.Config.characterTable;
            dataCharacter=DataMgr.Player.characters;
            
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        for i,v in ipairs(this.vm.data.relicsList) do
           v.alpha=0.0;
        end
    end,
}

this.ParseData=function()
    this.vm.data.contentPos=Vector2(0,0);
    this.vm.data.linkName=LuaMgr.GetLangText(cfgHistoricalText.TextLan);
    this.vm.data.linkDes=LuaMgr.GetLangText(cfgHistoricalText.TextIntroduceLan);
    local text=this.GetLinkInfoText();
    if text~=nil then
        this.vm.data.linkInfo=string.format(text,LuaMgr.GetLangText(cfgHistoricalText.TextLan));
    end
    
    
    this.FilterData();
    this.vm.data.relicsList={};
    local list={}
    for i,v in ipairs(characterList) do
        local cfgCharacter=cfgCharacterTable[v.id];
        if cfgCharacter.Switch==0 and (cfgCharacter.UnlockDate==0 or cfgCharacter.UnlockDate<=LuaMgr.Timestamp()) then
            local relicsItem= {
                relicsIcon = LuaMgr.GetTexture(path..v.id..".png"),
                name = LuaMgr.GetLangText(cfgCharacterTable[v.id].namelan),
                lock = dataCharacter[v.id]==nil,
                characterId=v.id,
                alpha=0.0,
            }
            table.insert(list,relicsItem);
        end
    end
    table.sort(list,function(a, b)
        if not a.lock and not b.lock then
            return a.characterId<b.characterId;
        else
            return not a.lock and  b.lock;
        end
    end)
    this.vm.data.relicsList=list;
    this.ShowAlphaAnimation();
    LuaMgr.DelayFrame(function()
        RectTransformTool.RebuildLayoutImmediate(infoTf);
    end)
end

this.ShowAlphaAnimation=function()
    if coroutineKey~=nil then
        coroutine_runner.stop(coroutineKey);
    end
    coroutineKey=coroutine_runner.start(function()
        coroutine_runner.wait(0.02)
        for i,v in ipairs(this.vm.data.relicsList) do
            DOTWeen.To(function()return 0.0  end,function(alpah) v.alpha=alpah; end,
                    1.0,0.5);
        end
    end)
end
   
this.GetLinkInfoText=function()
    local text=nil;
    if linkIndex==1 then  
        text=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2311"].NameLan)
    elseif linkIndex==2 then  
        text=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2312"].NameLan)
    elseif linkIndex==3 then  
        text=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2313"].NameLan)
    elseif linkIndex==4 then  
        text=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2314"].NameLan)
    elseif linkIndex==5 then  
        text=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2315"].NameLan)
    elseif linkIndex==6 then  
        text=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2316"].NameLan)
    elseif linkIndex==7 then 
        text=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2317"].NameLan)
    end
    return text;
end


this.FilterData=function()
    characterList={};
    for i,v in pairs(historicalRelicsMap) do
        if linkIndex==1 and v.museum==linkID then
            table.insert(characterList,v);
        elseif linkIndex==2 and v.relics==linkID then
            table.insert(characterList,v);
        elseif linkIndex==3 and v.dynasty==linkID then
            table.insert(characterList,v);
        elseif linkIndex==4 and v.tag2==linkID then
            table.insert(characterList,v);
        elseif linkIndex==5 and v.tag1==linkID then
            table.insert(characterList,v);
        elseif linkIndex==6 and v.tag3==linkID then
            table.insert(characterList,v);
        elseif linkIndex==7 and v.tag4==linkID then
            table.insert(characterList,v);
        end
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})