Rogue_ExploreShopItem = {};

Rogue_ExploreShopItem.__index = Rogue_ExploreShopItem;

local objs = { 
    buyBtn = { path = "root/namebg", type = "Button" },
    headObj={ path = "root/bg/head", type = "GameObject" },
    rawHeadIcon={ path = "root/bg/head/iconRaw", type = "RawImage" },
    imgHeadRare={ path = "root/bg/head/rareImg", type = "Image" },
    imgHeadJob={ path = "root/bg/head/jobBg/jobImg", type = "Image" },
    txtHeadLevel={ path = "root/bg/head/level", type = "Text" },
    
    buffObj={ path = "root/bg/buff", type = "GameObject" },
    imgBuffRare={ path = "root/bg/buff/rare", type = "Image" },
    imgBuffIcon={ path = "root/bg/buff/rare/icon", type = "Image" },
    txtName={ path = "root/bg/name", type = "Text" },
    rawCostIcon={ path = "root/namebg/costRaw", type = "RawImage" },
    txtCostCount={ path = "root/namebg/costCount", type = "Text" },
    noGetObj={ path = "root/noGet", type = "GameObject" },
    sellOutObj={ path = "root/done", type = "GameObject" },
    discountObj={ path = "root/discount", type = "GameObject" },
    discountTxt={ path = "root/discount/Text", type = "Text" },
    discountUIGray={ path = "root/discount", type = "UIGray" },
};

function Rogue_ExploreShopItem.New()
    local self = {};
    setmetatable(self, Rogue_ExploreShopItem);
    return self;
end

function Rogue_ExploreShopItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if self.data.isSellOut then
            return
        end
        if (self.data.index~=nil  and self.data.callBack ~= nil) then
            self.data.callBack(self.data.index)
        end
    end
    LuaMgr.AddClick(self.buyBtn, self.OnClickItem);
end








function Rogue_ExploreShopItem:SetData(data)
    self.data = data.data;
    SetActive(self.headObj,self.data.type==2)
    SetActive(self.buffObj,self.data.type~=2)
    SetActive(self.sellOutObj,self.data.isSellOut);
    local name=""
    if self.data.type==2 then

        self.rawHeadIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(self.data.infoId));
        local cfgCharacter=ConfigMgr.Config.characterTable[self.data.infoId];
        local heroData=RogueMgr.GetCharacterDataByID(self.data.infoId)
        local rare=cfgCharacter.rare;
        if  not IsNull(heroData.brilliant) then
            rare = rare + heroData.brilliant.RareLevel
        end
        rare=rare>=5 and 4 or rare;
        self.imgHeadRare.sprite=LuaMgr.GetSprite("CommonRes","ui_zd_jntx_"..rare)
        self.imgHeadJob.sprite=LuaMgr.GetSprite("JobIcon","job_"..cfgCharacter.job)
        self.txtHeadLevel.text="LV.100";
        name=LuaMgr.GetLangText(cfgCharacter.namelan);
        SetActive(self.noGetObj,not RogueExploreMgr.CheckHeroInBag(self.data.infoId))
    elseif self.data.type==1 then
        local cfgBuff=ConfigMgr.Config.RogueBuffDescMap[self.data.infoId];
        self.imgBuffRare.sprite=LuaMgr.GetSprite("Rogue","ui_xhyt_csqzxbfd_0"..cfgBuff.BuffQuality)
        self.imgBuffIcon.sprite=LuaMgr.GetSprite("BuffIcon",cfgBuff.BuffIcon)
        name=LuaMgr.GetLangText(cfgBuff.BuffNameLan);
        SetActive(self.noGetObj,not RogueExploreMgr.CheckBuffInBag(self.data.infoId))
    elseif self.data.type==3 then

        local cfgItem=ConfigMgr.Config.RogueItems[self.data.infoId];
        self.imgBuffRare.sprite=LuaMgr.GetSprite("Rogue","ui_xhyt_csqzxbfd_0"..cfgItem.Quality)
        self.imgBuffIcon.sprite=LuaMgr.GetSprite("BuffIcon",cfgItem.Icon)
        name=LuaMgr.GetLangText(cfgItem.NameLan);
        SetActive(self.noGetObj,false);
    end
    self.txtName.text=name;
    SetActive(self.discountObj,self.data.discount<1);
    self.discountUIGray.IsGray=self.data.isSellOut;
    local costCount=tonumber(self.data.cost[2])
    if self.data.discount<1 then
        self.discountTxt.text=string.format("%.1f",self.data.discount*10)..LuaMgr.GetLangText("Rogue_ExploreShopItem_0")
        costCount=math.ceil(costCount*self.data.discount);
    end
    local isNoMatch=costCount>DataMgr.Player.Rogue.Shell;
    self.rawCostIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(self.data.cost[1]));
    self.txtCostCount.text=isNoMatch and string.format("<color=#FF0000>%s</color>",costCount) or costCount;
    
end

function Rogue_ExploreShopItem:SetSelect(isOn)
    SetActive(self.selectObj,isOn);
end


function Rogue_ExploreShopItem:Clear()
    self.data = nil;
end

function Rogue_ExploreShopItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end