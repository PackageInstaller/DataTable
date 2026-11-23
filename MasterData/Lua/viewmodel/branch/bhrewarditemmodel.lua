





BHRewardItemModel = {}
BHRewardItemModel.__index = BHRewardItemModel
local objs = {
    introText = {path = "Normal/IntroText",type = "Text"},
    getBtn = {path = "GetBtn",type = "GameObject"},
    getBtnText = {path = "GetBtn/Text",type = "Text"},
    getBtnClick = {path = "GetBtn",type = "Button"},
    rewardRoot = {path = "Reward",type = "RectTransform"},
    mask = {path = "Mask",type = "GameObject"},
    barState = {path = "BarState",type = "GameObject"},
    countText = {path = "BarState/Count",type = "Text"},
}

function BHRewardItemModel.New()
    local self = {}
    setmetatable(self, BHRewardItemModel)
    return self
end

function BHRewardItemModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.getCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.BranchHeroGetReward,self.data.id,self.index)
    end
    self.animator = self.transform:GetComponent("Animator")
    LuaMgr.AddClick(self.getBtnClick,self.getCommand)
end

function BHRewardItemModel:SetData(data)
    self.getBtnText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15009"].NameLan)
    self.index = data.data.index
    self.config = data.data.config
    self.data = data.data.data
    SetActive(self.barState,self.data.state == 1)
    if self.data.state == 1 then
        self.countText.text = self.data.progress.."/"..self.config.progress
    end
    SetActive(self.getBtn,self.data.state == 2 and self.config.progress == self.data.progress)
    SetActive(self.mask,self.data.state == 3)
    self.introText.text = LuaMgr.GetLangText(self.config.namelan)
    self:SetGoods(self.config.reward)
    self.gameObject:SetActive(true)
end

function BHRewardItemModel:PlayAnim()
    SetActive(self.getBtn,false)
    SetActive(self.mask,true)
    self.animator:Play("ani_BranchHeroRewardPanel_BHrewarditem_lingqu",0,0)
end

function BHRewardItemModel:SetGoods(rewards)
    if self.goods == nil then
        self.goods = {}
    end
    local itemConfig = nil
    if rewards == nil or #rewards <= 0 then return end
    for i = 1, #rewards do
        if #self.goods < i then
            table.insert(self.goods,GoodsDataItem.New(self.rewardRoot))
        end
        itemConfig = table.Copy(ConfigMgr.Config.itemMap[rewards[i].id])
        itemConfig["count0"] = rewards[i].count
        self.goods[i]:SetData(i,itemConfig,1,false,Vector3(0.5,0.5,0.5),false)
    end
    for i = #rewards + 1, #self.goods do
        self.goods[i]:Hide()
    end
    itemConfig = nil
end

function BHRewardItemModel:Clear()
    self.data = nil
    self.config = nil
    self.index = nil
    self.gameObject:SetActive(false)
end

function BHRewardItemModel:Destroy()
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