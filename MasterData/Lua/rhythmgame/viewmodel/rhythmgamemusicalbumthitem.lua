
RhythmGameMusicAlbumTHItem = {};

RhythmGameMusicAlbumTHItem.__index = RhythmGameMusicAlbumTHItem;

local objs = {
    button = { path = "", type = "Button" },
    normal = { path = "Normal", type = "GameObject" },    
    redIconListener = { path = "Normal", type = "RedIconListener" },
    redIconListener2 = { path = "Select", type = "RedIconListener" },
    normalLock = { path = "Lock", type = "GameObject" },
    normalLockEffect = { path = "Lock/eff_kuang", type = "GameObject" },
    select = { path = "Select", type = "GameObject" },
    textTitle1 = { path = "Normal/TextTitle", type = "Text" },
    textTitle2 = { path = "Select/TextTitle", type = "Text" },
    textTitle3 = { path = "Lock/TextTitle", type = "Text" },    
}

function RhythmGameMusicAlbumTHItem.New()
    local self = {};
    setmetatable(self, RhythmGameMusicAlbumTHItem);
    return self;
end

function RhythmGameMusicAlbumTHItem:Init()
    UITool.Parse(self.gameObject, self, objs); 
    SetActive(self.normalLockEffect,false) 
    self.typeStr = "TH"
    self.OnClickItem = function()
        if (PlayerRhythmGameMgr.IsAlbumLock(self.data.id,self.typeStr)) then
            ConfigRhythmGameMgr.MusicUnlockTips(self.data.unlock,self.typeStr);
            return;
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameMusicAlbum, self.data);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function RhythmGameMusicAlbumTHItem:SetData(data)
    SetActive(self.normalLockEffect,false)
    self.data = data.data;
    self.redIconListener.RedId = "12011_"..self.data.group..self.typeStr
    self.redIconListener2.RedId = "12011_"..self.data.group..self.typeStr
    local musicAlbum = PlayerRhythmGameMgr.GetTHMusicAlbum();
    if (musicAlbum == self.data.group) then
        SetActive(self.normal, false);
        SetActive(self.select, true);
    else
        SetActive(self.normal, true);
        SetActive(self.select, false);
    end 
    
    for i = 1, 3 do
        self["textTitle"..i].text = LuaMgr.GetLangText(self.data.nameLan)
    end
    
    if(PlayerRhythmGameMgr.CheckMusicAlbumShownById(self.data.id,self.typeStr))then
        if self.startDelay ~= nil then
            coroutine_runner.stop(self.startDelay)
        end
        self.startDelay = coroutine_runner.start(function()  
            SetActive(self.normalLock, true);         
            coroutine_runner.wait(0.3) 
            SetActive(self.normalLockEffect, true);
            coroutine_runner.wait(0.3)           
            SetActive(self.normalLock, false);
            SetActive(self.normalLockEffect, false);
        end) 
        return
    end
    SetActive(self.normalLock, PlayerRhythmGameMgr.IsAlbumLock(self.data.id,self.typeStr));
end

function RhythmGameMusicAlbumTHItem:Clear()
    self.data = nil;
   
    
    if (not coroutine_runner.checkIsDestory()) and self.startDelay~=nil then
        coroutine_runner.stop(self.startDelay);
        self.startDelay=nil;
    end
end

function RhythmGameMusicAlbumTHItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end