
RankItem = {};

RankItem.__index = RankItem;
local objs = {
    imgNum = { path = "root/bg/num", type = "Image" },
    txtDes = { path = "root/bg/des", type = "Text" },

};

function RankItem.New()
    local self = {};
    setmetatable(self, RankItem);
    return self;
end

function RankItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function RankItem:SetData(data)
    self.data=data.data;
    self.imgNum.sprite=LuaMgr.GetSprite("SLGSeason",self.data.numName);
    self.txtDes.text=self.data.des;
end

function RankItem:Clear()
    self.data=nil;
end

function RankItem:Destroy()

    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end