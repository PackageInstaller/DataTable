HuanZhang_HeadItem = {};

HuanZhang_HeadItem.__index = HuanZhang_HeadItem;
local objs = {
    picIcon={path="root/BG/icon",type="RawImage"},
    imgRare={path="root/BG/rare",type="Image"},
    imgJob={path="root/BG/job",type="Image"},
    txtLevel={path="root/BG/Level/Text",type="Text"},
    goSelect={path="root/BG/select",type="GameObject"},
    btnBG={path="root/BG",type="Button"},
}



function HuanZhang_HeadItem.New()
    local self = {};
    setmetatable(self, HuanZhang_HeadItem);
    return self;
end

function HuanZhang_HeadItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnBG,function()
        if self.data.headCallBack~=nil then
            self.data.headCallBack(self.data.rowIndex,self.data.colIndex,self.data.heroData.id);
        end
    end)
end


function HuanZhang_HeadItem:SetData(pdata)
    self.data=pdata.data
    self.picIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(self.data.heroData.id,self.data.heroData.curSkin));
    local imageRare = self.data.heroData.rare >= 5 and 4 or self.data.heroData.rare
    self.imgRare.sprite=LuaMgr.GetSprite("AssistRare","ui_sz_qzyz_tx0"..imageRare);
    self.imgJob.sprite=LuaMgr.GetSprite("JobIcon","jobtips_"..self.data.heroData.job);
    self.txtLevel.text=self.data.heroData.level
    self:SetSelect(self.data.heroData.isSelect)
end



function HuanZhang_HeadItem:SetSelect(isOn)
    SetActive(self.goSelect,isOn);
end

function HuanZhang_HeadItem:Clear()
    self.data=nil
end

function HuanZhang_HeadItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end
