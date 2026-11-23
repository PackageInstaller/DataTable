Qin2LetterGame_CardItem = {};

Qin2LetterGame_CardItem.__index = Qin2LetterGame_CardItem;
local objs = {
    animator={ path = "root", type = "Animator" },
    card={ path = "root/bg/card", type = "Image" },
    cardBtn={path="root/bg/card",type="Button"},
    fxObj={path="root/fx_cardItem_01",type="GameObject"},
}

function Qin2LetterGame_CardItem.New()
    local self = {};
    setmetatable(self, Qin2LetterGame_CardItem);
    self.delayClose=true;
    return self;
end

function Qin2LetterGame_CardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.cardBtn,function()
        if self.cardValue~=nil and  self.data.cardCallBack~=nil then
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/Click_round.mp3");
            self.data.cardCallBack(self.cardValue,self.data.cardIndex);
            self.cardBtn.enabled=false;
            if self.cardValue==Qin2GameMgr.tarImg then
                self:SetClickFX();


            end
        end
    end)
end

function Qin2LetterGame_CardItem:SetClickFX()
    SetActive(self.fxObj,false)
    SetActive(self.fxObj,true)
end

function Qin2LetterGame_CardItem:SetData(pdata)
    self.data = pdata.data
    self.cardValue=nil;
    self.cardBtn.enabled=false;
    self.delayClose=true;
    self.animator:Play("ui_ani_Qin2LetterGamePanel_CardItem",0,0)
end

function Qin2LetterGame_CardItem:Show(spriteName,delay)
    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/File_open.mp3");
    self.card.sprite=LuaMgr.GetSprite("Qin2",spriteName);
    self.cardValue=spriteName;
    self.animator:Play("ui_ani_Qin2LetterGamePanel_CardItem_show",0,0)
    self.cardBtn.enabled=true;





    NumTool.DelayHandler(function()
        if self.delayClose and self.data~=nil then
            Qin2GameMgr.ClearBoardByLoc(self.data.cardIndex);
        end
    end,delay)
    self.showTime=UnityEngine.Time.realtimeSinceStartup;
end

function Qin2LetterGame_CardItem:Close(isDelay)
    self.cardValue=nil;
    if isDelay~=nil and isDelay then
        local interval=UnityEngine.Time.realtimeSinceStartup-self.showTime
        interval=0.5-interval;
        if interval>0 then
            NumTool.DelayHandler(function()
                self.animator:Play("ui_ani_Qin2LetterGamePanel_CardItem_close",0,0)
            end,interval)
            return;
        end
    end
    self.animator:Play("ui_ani_Qin2LetterGamePanel_CardItem_close",0,0)
end

function Qin2LetterGame_CardItem:Clear()
    self.data = nil;
end

function Qin2LetterGame_CardItem:Destroy()
    self.animator=nil;
    self.card=nil;
    self.cardBtn=nil;
    self.cardValue=nil
    self.fxObj=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end