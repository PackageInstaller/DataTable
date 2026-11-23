AssistHero_HeadItem = {};

AssistHero_HeadItem.__index = AssistHero_HeadItem;
local objs = {
    picIcon={path="root/BG/icon",type="RawImage"},
    imgRare={path="root/BG/rare",type="Image"},
    imgJob={path="root/BG/job",type="Image"},
    txtLevel={path="root/BG/level",type="Text"},
    goSelect={path="root/BG/select",type="GameObject"},
    goInfo={path="root/BG/info",type="GameObject"},
    btnBG={path="root/BG",type="Button"},
}

   

function AssistHero_HeadItem.New()
    local self = {};
    setmetatable(self, AssistHero_HeadItem);
    return self;
end

function AssistHero_HeadItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnBG,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.character.id,self.data.index);
        end
    end)
end


function AssistHero_HeadItem:SetData(pdata)
    self.data=pdata.data
    self.picIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(self.data.character.id,self.data.character.curSkin));
    
    local tempRare = HeroMgr.GetHeroNowRare(self.data.character.id)
    local imageRare = tempRare >= 5 and 4 or tempRare
    self.imgRare.sprite=LuaMgr.GetSprite("AssistRare","ui_sz_qzyz_tx0"..imageRare);
    self.imgJob.sprite=LuaMgr.GetSprite("JobIcon","jobtips_"..self.data.character.job);
    self.txtLevel.text=self.data.character.level
    self:SetInfo(self.data.character.isAssist)
    self:SetSelect(self.data.character.isSelect)
end

function AssistHero_HeadItem:SetInfo(isOn)
    SetActive(self.goInfo,isOn);
end

function AssistHero_HeadItem:SetSelect(isOn)
    SetActive(self.goSelect,isOn);
end

function AssistHero_HeadItem:Clear()
    self.data=nil
end

function AssistHero_HeadItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

