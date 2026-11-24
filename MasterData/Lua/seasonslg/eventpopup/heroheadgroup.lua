HeroHeadGroup = {};

HeroHeadGroup.__index = HeroHeadGroup;
local objs = {
    root={ path = "", type = "Transform" },
};

function HeroHeadGroup.New()
    local self = {};
    setmetatable(self, HeroHeadGroup);
    return self;
end

function HeroHeadGroup:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.heroUIList=UIListView.New(self.root);
end

function HeroHeadGroup:SetData(data)
    self.data = data.data;
    self.heroUIList:Clear();
    local list={};
    local HeadCallBack=function(index)
        if self.data.callBack~=nil then
            self.data.callBack(self.data.groupIndex,index);
        end
    end;
    for i,v in ipairs(self.data.list) do
        local heroItem={
            index=i,
            id=v.id,
            rare=v.rare>4 and 4 or v.rare,
            job=v.job,
            skinId=v.skinId,
            name="",
            level=v.level,
            sLevel=v.sLevel,
            select=v.selected,
            lock = v.lock,
            selectIndex=v.selectIndex,
            callBack=HeadCallBack,
        }
        local heroData=UIListData.GetData(self.data.headItemObj,"HeroHeadItem",heroItem);
        table.insert(list,heroData);
    end
    self.heroUIList:SetData(list);
end

function HeroHeadGroup:Clear()
    self.data = nil;
    self.heroUIList:Clear();
    UIListView.ClearItem("HeroHeadItem");
end

function HeroHeadGroup:Destroy()
    UIListView.ClearItem("HeroHeadItem");
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end