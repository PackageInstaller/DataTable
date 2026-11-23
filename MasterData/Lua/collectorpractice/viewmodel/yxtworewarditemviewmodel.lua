





YXTwoRewardItemViewModel = {}
YXTwoRewardItemViewModel.__index = YXTwoRewardItemViewModel
YXTwoRewardItemViewModel.countFormat = "<size=26><color=#FFFFFF>%d</color></size>/%d"
local objs = {
    normal = {path = "Normal",type = "GameObject"},
    normal_Intro = {path = "Normal/Text",type = "Text"},
    count = {path = "Normal/Count",type = "Text"},
    barValue = {path = "Normal/Bar/BarImage",type = "Image"},
    
    canGet = {path = "CanGet",type = "GameObject"},
    canGet_Intro = {path = "CanGet/Text",type = "Text"},
    getBtnClick = {path = "CanGet/GetBtn",type = "Button"},

    already = {path = "Already",type = "GameObject"},
    already_Intro = {path = "Already/Text",type = "Text"},
    goodsRoot = {path = "GoodsRoot",type = "RectTransform"},
}

function YXTwoRewardItemViewModel.New()
    local self = {}
    setmetatable(self, YXTwoRewardItemViewModel)
    return self
end

function YXTwoRewardItemViewModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.getCommand = function()
        self.fun()
    end
    LuaMgr.AddClick(self.getBtnClick,self.getCommand)
end

function YXTwoRewardItemViewModel:SetData(data)
    self.data = data.data.data
    self.config = data.data.config
    self.fun = data.data.fun
    SetActive(self.already,self.data.completed)
    local target = MissionHelper.GetTargetCount(self.data.id)
    SetActive(self.normal,not self.data.completed and self.data.current < target)
    SetActive(self.canGet,not self.data.completed and self.data.current >= target)
    if self.normal.activeSelf then
        self.barValue.fillAmount = self.data.current / target
        self.count.text = string.format(self.countFormat,self.data.current,target)
    end
    local missionIntro = ""
    if self.config ~= nil then
        self:SetGoods(self.config.rewards)
        missionIntro = LuaMgr.GetLangText(self.config.NameLan)
    end
    self.normal_Intro.text = missionIntro
    self.canGet_Intro.text = missionIntro
    self.already_Intro.text = missionIntro
    self.gameObject:SetActive(true)
end

function YXTwoRewardItemViewModel:SetGoods(rewards)
    if self.goods == nil then
        self.goods = {}
    end
    local itemConfig = nil
    if TableIsNull(rewards) then return end
    for i = 1, #rewards do
        if #self.goods < i then
            table.insert(self.goods,GoodsDataItem.New(self.goodsRoot))
        end
        itemConfig = table.Copy(ConfigMgr.Config.itemMap[rewards[i].itemId])
        itemConfig["count0"] = rewards[i].count
        self.goods[i]:SetData(i,itemConfig,1,false,Vector3(0.45,0.45,0.45),false)
    end
    for i = #rewards + 1, #self.goods do
        self.goods[i]:Hide()
    end
    itemConfig = nil
end

function YXTwoRewardItemViewModel:Clear()
    self.data = nil
    self.config = nil
    self.fun = nil
    self.gameObject:SetActive(false)
end

function YXTwoRewardItemViewModel:Destroy()
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