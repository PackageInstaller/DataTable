WorldBuffItem = {};

WorldBuffItem.__index = WorldBuffItem;
local objs = {
    txtName={ path = "root/bg/name", type = "Text" },
    tfList={ path = "root/bg/content", type = "Transform" },
};

function WorldBuffItem.New()
    local self = {};
    setmetatable(self, WorldBuffItem);
    return self;
end

function WorldBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.buffUIList=UIListView.New(self.tfList);
end









function WorldBuffItem:SetData(data)
    self.data = data.data;
    self.txtName.text=self.data.name;
    self.buffUIList:Clear();
    local list={};
    local buffCallBack=function(index)
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBuffDesPopUpViewModel,self.data.buffList[index])
    end
    for i,v in ipairs(self.data.buffList) do
        local seasonalBuff=ConfigMgr.Config.SeasonalBuffMap[v];
        if seasonalBuff~=nil then
            local buffItem={
                icon=LuaMgr.GetSprite("BuffIcon", seasonalBuff.BuffIcon);
                name=LuaMgr.GetLangText(seasonalBuff.BuffNameLan),
                level=seasonalBuff.Param[2];
                index=i,
                callBack=buffCallBack
            }
            local buffData=UIListData.GetData(self.data.buffItemObj,"Boss2BuffItem",buffItem);
            table.insert(list,buffData)
        end
    end
    self.buffUIList:SetData(list);
end

function WorldBuffItem:Clear()
    self.data = nil;
    self.buffUIList:Clear();
end

function WorldBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end