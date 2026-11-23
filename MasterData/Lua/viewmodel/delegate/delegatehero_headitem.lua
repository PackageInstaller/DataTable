DelegateHero_HeadItem = {};

DelegateHero_HeadItem.__index = DelegateHero_HeadItem;
local objs = {
    headIcon={ path = "bg/HeadIcon", type = "RawImage" },
    goFeeling={path = "bg/feeling", type = "GameObject"},
    goMaxFeeling={path = "bg/maxfeeling", type = "GameObject"},
    feelingText={path = "bg/feeling/Level", type = "Text"},
    maxFeelingText={path = "bg/maxfeeling/Level", type = "Text"},
    levelText={path = "bg/Level", type = "Text"},
    imgRare = { path = "bg/nameBg", type = "Image" },
    nameText= { path = "bg/nameBg/Text", type = "Text" },
    goSelect={path = "bg/select", type = "GameObject"},
    selectNum={path = "bg/select/Text", type = "Text"},
    btnClick={path = "bg/HeadIcon", type = "Button"},
}

function DelegateHero_HeadItem.New()
    local self = {};
    setmetatable(self, DelegateHero_HeadItem);
    self.isActive=false;
    return self;
end

function DelegateHero_HeadItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnClick,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.indexData,not self.isActive)
        end
    end)
end

function DelegateHero_HeadItem:SetData(pdata)
    self.data = pdata.data.data;
    self.headIcon.texture=self.data.headIcon
    local imageRare = self.data.rare >= 5 and 4 or self.data.rare
    self.imgRare.sprite=LuaMgr.GetSprite("BattleDelegate","ui_ck_glxq_gl_0"..imageRare)
    self.nameText.text=self.data.name;
    self.levelText.text=self.data.level;
    SetActive(self.goSelect,self.data.activeNum<999)
    self.isActive=self.data.activeNum<999;
    if self.data.activeNum<999 then
        self.selectNum.text=self.data.activeNum;
    end
    SetActive(self.goFeeling,not self.data.isMax);
    SetActive(self.goMaxFeeling,self.data.isMax);
    self.feelingText.text=self.data.prestigeLevel;
    self.maxFeelingText.text=self.data.prestigeLevel;
 
end

function DelegateHero_HeadItem:SetActiveNum(isOn)
    self.isActive=isOn
    SetActive(self.goSelect,isOn)
    self.selectNum.text=self.data.activeNum;
end


function DelegateHero_HeadItem:Clear()
    self.isActive=false
    self.data = nil;
end

function DelegateHero_HeadItem:Destroy()
    self.headIcon=nil;
    self.goFeeling=nil;
    self.goMaxFeeling=nil;
    self.feelingText=nil;
    self.maxFeelingText=nil;
    self.levelText=nil;
    self.imgRare = nil;
    self.nameText= nil;
    self.goSelect=nil;
    self.btnClick=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end