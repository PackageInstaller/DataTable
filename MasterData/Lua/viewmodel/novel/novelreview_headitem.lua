NovelReview_HeadItem = {};

NovelReview_HeadItem.__index = NovelReview_HeadItem;
local objs = {
    goPlayer={ path = "isPlayer", type = "GameObject" },
    nameText = { path = "name", type = "Text" },
    goVoice={path = "voice", type = "GameObject"},
    voiceBtn={path = "voice", type = "Button"},
    goVoicePlaying={path = "voice/voicePlaying", type = "GameObject"},

}

function NovelReview_HeadItem.New()
    local self = {};
    setmetatable(self, NovelReview_HeadItem);
    return self;
end

function NovelReview_HeadItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.isPlaying=false;
    self.tweener=nil;
    LuaMgr.AddClick(self.voiceBtn,function()

        if self.data.callBack~=nil then

            self.data.callBack(self.data.index,not self.isPlaying)
        end
    end)
end

function NovelReview_HeadItem:SetData(pdata)
    self.data = pdata.data;
    SetActive(self.goPlayer,self.data.isPlayer)
    self.nameText.text=self.data.isPlayer and string.format("<color=#c7b79b>%s</color>",self.data.text) 
            or string.format("<color=#3f7c7a>%s</color>",self.data.text);
    SetActive(self.goVoice,self.data.voice~="")
    SetActive(self.goVoicePlaying,self.data.isPlaying)
    self.isPlaying=self.data.isPlaying;
end

function NovelReview_HeadItem:SetVoiceState(isOn,time)
    self.isPlaying=isOn;
    SetActive(self.goVoicePlaying,isOn)






end

function NovelReview_HeadItem:Clear()
    self.data = nil;
    if self.tweener~=nil then
        self.tweener:Kill();
        self.tweener=nil;
    end
end

function NovelReview_HeadItem:Destroy()
    self.goPlayer=nil;
    self.nameText =nil;
    self.textName = nil;
    self.goVoice=nil;
    self.voiceBtn=nil;
    self.goVoicePlaying=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end