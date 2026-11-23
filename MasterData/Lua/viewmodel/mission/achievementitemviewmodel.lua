





AchievementItemViewModel = {}

AchievementItemViewModel.__index = AchievementItemViewModel
AchievementItemViewModel.countFormat = "<color=#262429>/%s</color>"
local objs = {
    normal = {path = "Group/Normal",type = "GameObject"},
    normalCount = {path = "Group/Normal/Group/CountBar/Text",type = "Text"},
    normalBarImg = {path = "Group/Normal/Group/CountBar/Bar/BarImg",type = "Image"},
    getObj = {path = "Group/Normal/Group/GetBtn",type = "GameObject"},
    getBtn = {path = "Group/Normal/Group/GetBtn",type = "Button"},
    gotoObj = {path = "Group/Normal/Group/GotoBut",type = "GameObject"},
    gotoBut = {path = "Group/Normal/Group/GotoBut",type = "Button"},

    complete = {path = "Group/Complete",type = "GameObject"},
    completeCount = {path = "Group/Complete/CountBar/Text",type = "Text"},
    
    goodsRoot = {path = "Group/Goods",type = "RectTransform"},
    typeIcon = {path = "Group/TypeIcon",type = "Image"},
    introText = {path = "Group/Text",type = "Text"},
    mask_1 = {path = "Group/Mask1",type = "GameObject"},
    mask_2 = {path = "Group/Mask2",type = "GameObject"},
    canvasGroup = {path = "Group",type = "CanvasGroup"},
}

function AchievementItemViewModel.New(prefab, parent)
    local self = {}
    setmetatable(self, AchievementItemViewModel)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.RareSort = function(item1,item2)
        if ConfigMgr.Config.itemMap[item1.itemId].rare ~= ConfigMgr.Config.itemMap[item2.itemId].rare then
            return ConfigMgr.Config.itemMap[item1.itemId].rare > ConfigMgr.Config.itemMap[item2.itemId].rare
        end
    end
    self.getCommand = function()
        self:PlayAnim()
        LuaMgr.InvokeUIEventListeners(UIEventConst.MissionCompleted, self.data.id)
    end
    self.gotoCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.MissionGotoPanel, self.data.id)
    end
    LuaMgr.AddClick(self.getBtn,self.getCommand)
    LuaMgr.AddClick(self.gotoBut,self.gotoCommand)
    return self
end

function AchievementItemViewModel:SetData(data)
    self.data = data
    self.canvasGroup.alpha = 1
    local achievement = ConfigMgr.Config.missionMap[self.data.id]
    if achievement == nil then return end
    local targetCount = achievement.condition1[1].Count;
    if self.data.completed then
        SetActive(self.mask_1,#achievement.rewards >= 1)
        SetActive(self.mask_2,#achievement.rewards == 2)
        self.completeCount.text = LuaMgr.NumFormat(self.data.current)..string.format(self.countFormat,LuaMgr.NumFormat(targetCount))
        self.typeIcon.sprite = LuaMgr.GetSprite("AchievementIcon", "achievement_sticker_OFF_"..achievement.group)
    else
        SetActive(self.mask_1,false)
        SetActive(self.mask_2,false)
        SetActive(self.getObj,self.data.current >= targetCount)
        SetActive(self.gotoObj,self.data.current < targetCount)
        self.normalBarImg.fillAmount = self.data.current / targetCount
        self.normalCount.text = LuaMgr.NumFormat(self.data.current)..string.format(self.countFormat,LuaMgr.NumFormat(targetCount))
        self.typeIcon.sprite = LuaMgr.GetSprite("AchievementIcon","achievement_sticker_ON_"..achievement.group)
    end
    self.introText.text = LuaMgr.GetLangText(achievement.NameLan)
    SetActive(self.normal,not self.data.completed)
    SetActive(self.complete,self.data.completed)
    self:SetGoods(achievement.rewards)
    self.gameObject:SetActive(true)
    achievement = nil
end

function AchievementItemViewModel:SetGoods(rewards)
    if self.goods == nil then
        self.goods = {}
    end
    local itemConfig = nil
    if rewards == nil or #rewards <= 0 then return end
    table.sort(rewards,self.RareSort)
    for i = 1, #rewards do
        if #self.goods < i then
            table.insert(self.goods,GoodsDataItem.New(self.goodsRoot))
        end
        itemConfig = ConfigMgr.Config.itemMap[rewards[i].itemId]
        itemConfig["count0"] = rewards[i].count
        self.goods[i]:SetData(i,itemConfig,1,false,Vector3(0.55,0.55,0.55),false)
    end
    for i = #rewards + 1, #self.goods do
        self.goods[i]:Hide()
    end
    itemConfig = nil
end

function AchievementItemViewModel:PlayAnim()
    DOTWeen.To(function() return 1 end,
            function(vector)
                self.canvasGroup.alpha = vector
            end, 0, 0.5):SetEase(Ease.OutQuint)
end

function AchievementItemViewModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function AchievementItemViewModel:Destroy()
    if (self.getCommand ~= nil) then
        LuaMgr.RemoveClick(self.getBtn, self.getCommand)
        self.getCommand = nil
    end
    if (self.gotoCommand ~= nil) then
        LuaMgr.RemoveClick(self.gotoBut, self.gotoCommand)
        self.gotoCommand = nil
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