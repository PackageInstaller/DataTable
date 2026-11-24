SmallMapAreaGridItem = {};

SmallMapAreaGridItem.__index = SmallMapAreaGridItem;
local objs = {
    root={ path = "root", type = "Transform" },
    goObject1={ path = "root/Object1", type = "GameObject" },
    numObj1Text={ path = "root/Object1/Text", type = "Text" },
    goObject2={ path = "root/Object2", type = "GameObject" },
    btnGrid = { path = "root/Object2/Button", type = "Button" },
    numText={ path = "root/Object2/Text", type = "Text" },
    progressRoot={ path = "root/Object2/ProgressItem", type = "Transform" },
};

function SmallMapAreaGridItem.New()
    local self = {};
    setmetatable(self, SmallMapAreaGridItem);
    return self;
end

function SmallMapAreaGridItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self:Register();
end

function SmallMapAreaGridItem:Register()
    self.OnCickGrid = function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data);
        end
    end
    LuaMgr.AddClick(self.btnGrid, self.OnCickGrid);
end

function SmallMapAreaGridItem:SetData(data)
    self.data = data.data;
    self.transform.localScale=Vector3.one

    SetActive(self.goObject1, self.data.cfgData.Occ)
    SetActive(self.goObject2, not self.data.cfgData.Occ)


    if self.data.cfgData.Occ then
        self.numObj1Text.text = self.data.name
        return
    end

    self.numText.text = self.data.name;
    local progressData=SeasonSLGMapMgr.MapStateData.EventProgress[self.data.index];
    if progressData~=nil then
        self:SetProgressItem(self.data.index,progressData);
    else
        SetActive(self.progressRoot.gameObject,false);
    end
end

function SmallMapAreaGridItem:SetProgressItem(gridId,progressData)
    SetActive(self.progressRoot.gameObject,true);
    if self.ProgressItem==nil then
        self.ProgressItem=SmallProgressItem.New(self.progressRoot)
    end


    local data={
        gridId=gridId,
        functionId=progressData.FunctionId,
        progress=progressData.Progress,
    }
    self.ProgressItem:SetData(data)
end

function SmallMapAreaGridItem:Clear()
    self.data = nil;

    if self.ProgressItem~=nil then
        self.ProgressItem:Clear();
    end

end

function SmallMapAreaGridItem:Destroy()
    if self.ProgressItem~=nil then
        self.ProgressItem:Destroy();
    end

    if self.OnCickGrid~=nil then
        LuaMgr.RemoveClick(self.btnGrid, self.OnCickGrid);
    end
    self.OnCickGrid = nil;

    LuaMgr.DestroyImmediateGO(self.gameObject);

    self.gameObject = nil;
end