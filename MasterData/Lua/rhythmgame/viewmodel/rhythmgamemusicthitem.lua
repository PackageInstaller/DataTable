
RhythmGameMusicTHItem = {};

RhythmGameMusicTHItem.__index = RhythmGameMusicTHItem;

local objs = {
    aniRoot = { path = "", type = "Animator" },
    normalCG = { path = "Normal", type = "CanvasGroup" },
    normalTF = { path = "Normal", type = "RectTransform" },   
    normalNum = { path = "Normal/ImgIcon/Num", type = "Text" },
    redIconListener = { path = "Normal/ImgIcon", type = "RedIconListener" },
    normalName = { path = "Normal/ImgIcon/Name", type = "Text" },
    normalPercent = { path = "Normal/ImgIcon/Percent", type = "Text" },
    normalBtn = { path = "Normal/Button", type = "Button" },
    ImgIcon = { path = "Normal/ImgIcon/ImgIcon", type = "Image" },
    ImgIconGo = { path = "Normal/ImgIcon/ImgIcon", type = "GameObject" },
    Imglock = { path = "Normal/Imglock", type = "GameObject" },
    ImglockCG = { path = "Normal/Imglock", type = "CanvasGroup" },
    ImglockEffect = { path = "Normal/Imglock/eff_kuang", type = "GameObject" },    
};

function RhythmGameMusicTHItem.New()
    local self = {};
    setmetatable(self, RhythmGameMusicTHItem);
    return self
end

function RhythmGameMusicTHItem:Init()   
    UITool.Parse(self.gameObject, self, objs);
    SetActive(self.ImglockEffect,false)
    self.data = nil;
    self.typeStr = "TH"
    self.normalAlphaTween = nil;
    self.OnClickReceive = function()       
        local musicSongData = PlayerRhythmGameMgr.GetMusicSong(self.data.Easy.id,self.typeStr);
        if (musicSongData == nil) then            
            ConfigRhythmGameMgr.MusicUnlockTips(self.data.Easy.unlock,self.typeStr);         
        else
            LuaMgr.ShowLuaPanel(UIName.RhythmGameLvSelectViewModel, self.data);
        end        
    end
    LuaMgr.AddClick(self.normalBtn, self.OnClickReceive);
    
    return self;
end

function RhythmGameMusicTHItem:SetData(data)  
    SetActive(self.ImglockEffect,false)
    self.ImglockCG.alpha = 1
    self.index = data.data.index
    self.data = data.data.data;    





    self.normalNum.text = self.data.group; 
    local nameStr = ""
    local id = 0
    local eventId = 0
    if (self.data.Easy ~= nil) then
        nameStr = LuaMgr.GetLangText(self.data.Easy.nameLan);
        id = self.data.Easy.id
        eventId = self.data.Easy.eventID
    elseif (self.data.Hard ~= nil) then
        nameStr = LuaMgr.GetLangText(self.data.Hard.nameLan);
        id = self.data.Hard.id
        eventId = self.data.Hard.eventID
    elseif (self.data.Master ~= nil) then
        nameStr = LuaMgr.GetLangText(self.data.Master.nameLan);
        id = self.data.Master.id
        eventId = self.data.Master.eventID
    end
    self.redIconListener.RedId = "12012_"..id
    self.normalName.text = nameStr;   
    local musicSong = PlayerRhythmGameMgr.GetMusicSong(id,self.typeStr);
    local num,maxNum = ConfigRhythmGameMgr.GetTotalNum(self.data,self.typeStr)
    if (num >= maxNum) then
        self.normalPercent.text = string.format("<size=24><color=#5978de>%s</color></size>/%s", num, maxNum)
    else
        self.normalPercent.text = string.format("<size=24>%s</size>/%s", num, maxNum)
    end
    local song = ConfigRhythmGameMgr.GetSongContent(eventId,self.typeStr);  
    local bNotNil = song.songBanner ~= nil and #song.songBanner > 0    
    if (bNotNil) then

        self.ImgIcon.sprite = LuaMgr.GetSprite("FoundationRhythm", song.songBanner);       


    end   
    
    if(PlayerRhythmGameMgr.CheckMusicShownById(id,self.typeStr))then   
        if self.startDelay ~= nil then
            coroutine_runner.stop(self.startDelay)
        end
        self.startDelay = coroutine_runner.start(function()
            SetActive(self.ImgIconGo, false)
            SetActive(self.Imglock, true)           
            coroutine_runner.wait(0.3)  
            SetActive(self.ImglockEffect,true)           
            coroutine_runner.wait(0.4) 
            SetActive(self.ImgIconGo, true)  
            for i=1,10,1 do                
                coroutine_runner.waitForEndOfFrame();
                self.ImglockCG.alpha = 1 - (i*0.1) 
            end
            SetActive(self.Imglock, false) 
            SetActive(self.ImglockEffect,false)
                      
        end)  
        return
    end  
    SetActive(self.ImgIconGo, musicSong ~= nil)
    SetActive(self.Imglock, musicSong == nil)

end

function RhythmGameMusicTHItem:ShowAim(groupIndex)    
    if(self.aniRoot == nil)then return end 
    self.coroutine = coroutine_runner.start(
        function()           
            SetActive(self.aniRoot.gameObject, false)
            coroutine_runner.wait(0.1 * (groupIndex - 1))
            SetActive(self.aniRoot.gameObject, true)
            self.aniRoot.enabled = false;
            self.aniRoot.enabled = true;
            self.aniRoot:Rebind();
            self.aniRoot:Play("ani_RhythmGameMusicPanel_MusicItem_001");
            coroutine_runner.wait(3)
            self.aniRoot.enabled = false;
            self.coroutine = nil
        end)
end

function RhythmGameMusicTHItem:Clear()
    self.data = nil;
    if (not coroutine_runner.checkIsDestory()) and self.startDelay~=nil then
        coroutine_runner.stop(self.startDelay);
        self.startDelay=nil;
     end
     if self.coroutine ~= nil then
        coroutine_runner.stop(self.coroutine);
        self.coroutine = nil;
        SetActive(self.aniRoot.gameObject, true)        
    end
end

function RhythmGameMusicTHItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end