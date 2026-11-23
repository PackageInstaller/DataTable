
RhythmGameMusicAlbumItem = {};

RhythmGameMusicAlbumItem.__index = RhythmGameMusicAlbumItem;

local objs = {
    button = { path = "", type = "Button" },
    normal = { path = "Normal", type = "GameObject" },
    normalIcon = { path = "Normal/Icon", type = "Image" },
    redIconListener = { path = "Normal/Icon", type = "RedIconListener" },
    redIconListener2 = { path = "Select/Icon", type = "RedIconListener" },
    normalLock = { path = "Normal/Lock", type = "GameObject" },
    normalLockEffect = { path = "Normal/Lock/eff_kuang", type = "GameObject" },
    select = { path = "Select", type = "GameObject" },
    selectImg = { path = "Select", type = "Image" },
    selectIcon = { path = "Select/Icon", type = "Image" },
}

function RhythmGameMusicAlbumItem.New()
    local self = {};
    setmetatable(self, RhythmGameMusicAlbumItem);
    return self;
end

function RhythmGameMusicAlbumItem:Init()
    UITool.Parse(self.gameObject, self, objs); 
    SetActive(self.normalLockEffect,false)   
    self.OnClickItem = function()
        if (PlayerRhythmGameMgr.IsAlbumLock(self.data.id)) then
            ConfigRhythmGameMgr.MusicUnlockTips(self.data.unlock);
            return;
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameMusicAlbum, self.data);
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
end

function RhythmGameMusicAlbumItem:SetData(data)
    SetActive(self.normalLockEffect,false)
    self.data = data.data;
    self.redIconListener.RedId = "12011_"..self.data.group
    self.redIconListener2.RedId = "12011_"..self.data.group
    local musicAlbum = PlayerRhythmGameMgr.GetMusicAlbum();
    if (musicAlbum == self.data.group) then
        SetActive(self.normal, false);
        SetActive(self.select, true);
    else
        SetActive(self.normal, true);
        SetActive(self.select, false);
    end
    local sprite = LuaMgr.GetSprite("RhythmGame", self.data.icon);    
    self.normalIcon.sprite = sprite;
    self.selectIcon.sprite = sprite;
    self.selectImg.sprite = LuaMgr.GetSprite("RhythmGame", self.data.otherIcon[1][1]);   
    if(PlayerRhythmGameMgr.CheckMusicAlbumShownById(self.data.id))then
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
    SetActive(self.normalLock, PlayerRhythmGameMgr.IsAlbumLock(self.data.id));
end

function RhythmGameMusicAlbumItem:Clear()
    self.data = nil;
    self.normalIcon.sprite = nil;
    self.selectIcon.sprite = nil;
    if (not coroutine_runner.checkIsDestory()) and self.startDelay~=nil then
        coroutine_runner.stop(self.startDelay);
        self.startDelay=nil;
    end
end

function RhythmGameMusicAlbumItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end