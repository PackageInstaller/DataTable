





RewardItemModel = {}
RewardItemModel.__index = RewardItemModel
RewardItemModel.countFormat = "<color=#146e48>%d</color>/%d"
local objs = {
    count = {path = "Count",type = "Text"},
    text = {path = "Text",type = "Text"},
    slider = {path = "Slider/Image",type = "Image"},
    goodsRoot = {path = "Goods",type = "RectTransform"},
    normal = {path = "Normal",type = "GameObject"},
    getBtn = {path = "GetBtn",type = "GameObject"},
    getBtnClick = {path = "GetBtn",type = "Button"},
    complete = {path = "Complete",type = "GameObject"},
}

function RewardItemModel.New()
    local self = {}
    setmetatable(self, RewardItemModel)
    return self
end

function RewardItemModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.getCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.GroupGetRewardClick, self.data.id)
    end
    LuaMgr.AddClick(self.getBtnClick,self.getCommand)
end

function RewardItemModel:SetData(data)
    self.data = data.data.data
    self.slider.fillAmount = self.data.current / self.data.target
    self.count.text = string.format(self.countFormat,self.data.current,self.data.target)
    local config = ConfigMgr.Config.missionMap[self.data.id]
    if config ~= nil then
        self:SetGoods(config.rewards)
        self.text.text = LuaMgr.GetLangText(config.NameLan)
    end
    SetActive(self.normal,not self.data.completed and self.data.current < self.data.target)
    SetActive(self.getBtn,not self.data.completed and self.data.current >= self.data.target)
    SetActive(self.complete,self.data.completed)
    self.gameObject:SetActive(true)
end

function RewardItemModel:SetGoods(rewards)
    if self.goods == nil then
        self.goods = {}
    end
    local itemConfig = nil
    if rewards == nil or #rewards <= 0 then return end
    for i = 1, #rewards do
        if #self.goods < i then
            table.insert(self.goods,GoodsDataItem.New(self.goodsRoot))
        end
        itemConfig = table.Copy(ConfigMgr.Config.itemMap[rewards[i].itemId])
        itemConfig["count0"] = rewards[i].count
        self.goods[i]:SetData(i,itemConfig,1,false,Vector3(0.5,0.5,0.5),false)
    end
    for i = #rewards + 1, #self.goods do
        self.goods[i]:Hide()
    end
    itemConfig = nil
end

function RewardItemModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function RewardItemModel:Destroy()
    if (self.getCommand ~= nil) then
        LuaMgr.RemoveClick(self.getBtnClick, self.getCommand)
        self.getCommand = nil
    end
    if self.goods ~= nil then
        for i = 1, #self.goods do
            self.goods[i]:Clear()
        end
        self.goods = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end