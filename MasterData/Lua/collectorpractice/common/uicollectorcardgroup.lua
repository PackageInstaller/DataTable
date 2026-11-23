UICollectorCardGroup = {}

UICollectorCardGroup.__index = UICollectorCardGroup

function UICollectorCardGroup.New()
    local self = {}
    setmetatable(self, UICollectorCardGroup)
    self.cloneItems={};
    return self
end

function UICollectorCardGroup:Init()
    local allNum= #self.cloneItems;
    for i = 1, allNum do
        self.cloneItems[i]:Clear();
    end
end

function UICollectorCardGroup:SetData(data)
    self.data = data.data;
    local len=#self.data.datas;
    for i = 1, len do
        if (self.data.datas[i]~= nil) and i> (#self.cloneItems) then
            table.insert(self.cloneItems,UICollectorCardItem.New(self.transform,Vector3(1, 1, 1)))
            self.cloneItems[i].transform.anchoredPosition = Vector2.zero;
        end

        SetActive(self.cloneItems[i].gameObject,true);
        self.cloneItems[i]:SetData(self.data.datas[i],self.data.fun)
    end

    local allNum= #self.cloneItems;
    for i = len+1, allNum do
        self.cloneItems[i]:Clear();
    end
end

function UICollectorCardGroup:Clear()
    self.data = nil
    local allNum= #self.cloneItems;
    for i = 1, allNum do
        self.cloneItems[i]:Clear();
    end
end

function UICollectorCardGroup:Destroy()
    local allNum= #self.cloneItems;
    for i = 1, allNum do
        self.cloneItems[i]:Destroy();
        self.cloneItems[i]=nil;
    end
    
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.cloneItems = nil;
    self.gameObject = nil
end