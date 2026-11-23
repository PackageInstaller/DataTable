





MissionRewardViewModel = {}

MissionRewardViewModel.__index = MissionRewardViewModel

local objs = {
    normal = {path = "Group/Normal",type = "GameObject"},
    dailyActivity = {path = "Group/Normal/DailyActivity",type = "RectTransform"},
    weeklyActivity = {path = "Group/Normal/WeeklyActivity",type = "RectTransform"},
    
    goodsRoot = {path = "Group/Goods",type = "RectTransform"},
    
    complete = {path = "Group/Complete",type = "GameObject"},
    dailyState = {path = "Group/Complete/DailyState",type = "RectTransform"},
    weeklyState = {path = "Group/Complete/WeeklyState",type = "RectTransform"},
}

function MissionRewardViewModel.New()
    local self = {}
    setmetatable(self, MissionRewardViewModel)
    return self
end

function MissionRewardViewModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self:FindNode()
    self.RareSort = function(item1,item2)
        if ConfigMgr.Config.itemMap[item1.itemId].rare ~= ConfigMgr.Config.itemMap[item2.itemId].rare then
            return ConfigMgr.Config.itemMap[item1.itemId].rare > ConfigMgr.Config.itemMap[item2.itemId].rare
        end
    end
end

function MissionRewardViewModel:FindNode()

    self.d_Activity,self.d_Point = {},{}
    local root_1,root_2 = nil,nil
    local temp = nil
    for i = 1, self.dailyActivity.childCount do
        root_1 = self.dailyActivity:Find("Activity_"..i).gameObject
        table.insert(self.d_Activity,root_1)
        temp = {}
        for j = 1, root_1.transform.childCount do
            root_2 = root_1.transform:Find("Point_"..j).gameObject
            table.insert(temp,root_2)
        end
        table.insert(self.d_Point,temp)
    end

    self.d_State = {}
    for i = 1, self.dailyState.childCount do
        root_1 = self.dailyState:Find("State_"..i).gameObject
        table.insert(self.d_State,root_1)
    end
    

    self.w_Activity,self.w_Point = {},{}
    for i = 1, self.weeklyActivity.childCount do
        root_1 = self.weeklyActivity:Find("Activity_"..i).gameObject
        table.insert(self.w_Activity,root_1)
        temp = {}
        for j = 1, root_1.transform.childCount do
            root_2 = root_1.transform:Find("Point_"..j).gameObject
            table.insert(temp,root_2)
        end
        table.insert(self.w_Point,temp)
    end

    self.w_State = {}
    for i = 1, self.weeklyState.childCount do
        root_1 = self.weeklyState:Find("State_"..i).gameObject
        table.insert(self.w_State,root_1)
    end
    root_1,root_2,temp = nil,nil,nil
end


function MissionRewardViewModel:SetData(data)
    self.type = data.data.type
    self.data = data.data.reward
    self:SetState()
    self:SetGoods()
    self.gameObject:SetActive(true)
end

function MissionRewardViewModel:SetState()
    if self.data.completed then
        if self.type == "102" then
            for i = 1, #self.d_State do
                SetActive(self.d_State[i],i == self.data.target)
            end
        elseif self.type == "104" then
            for i = 1, #self.w_State do
                SetActive(self.w_State[i],i == self.data.target)
            end
        end
        SetActive(self.dailyState.gameObject,self.type == "102")
        SetActive(self.weeklyState.gameObject,self.type == "104")
    else
        if self.type == "102" then
            for i = 1, #self.d_Activity do
                if i > 1 and i == self.data.target then
                    for j = 1, #self.d_Point[i] do
                        SetActive(self.d_Point[i][j],j <= self.data.current)
                    end
                end
                SetActive(self.d_Activity[i],i == self.data.target)
            end
        elseif self.type == "104" then
            for i = 1, #self.w_Activity do
                if i > 1 and i == self.data.target then
                    for j = 1, #self.w_Point[i] do
                        SetActive(self.w_Point[i][j],j <= self.data.current)
                    end
                end
                SetActive(self.w_Activity[i],i == self.data.target)
            end
        end
        SetActive(self.dailyActivity.gameObject,self.type == "102")
        SetActive(self.weeklyActivity.gameObject,self.type == "104")
    end
    SetActive(self.complete,self.data.completed)
    SetActive(self.normal,not self.data.completed)
end

function MissionRewardViewModel:SetGoods()
    if self.goods == nil then
        self.goods = {}
    end
    local mission = ConfigMgr.Config.missionMap[self.data.id]
    local itemConfig = nil
    if mission == nil then return end
    table.sort(mission.rewards,self.RareSort)
    for i = 1, #mission.rewards do
        if #self.goods < i then
            table.insert(self.goods,GoodsDataItem.New(self.goodsRoot))
        end
        itemConfig = ConfigMgr.Config.itemMap[mission.rewards[i].itemId]
        itemConfig["count0"] = mission.rewards[i].count
        self.goods[i]:SetData(i,itemConfig,1,false,Vector3(0.55,0.55,0.55),false)
    end
    for i = #mission.rewards + 1, #self.goods do
        self.goods[i]:Hide()
    end
    mission,itemConfig = nil,nil
end

function MissionRewardViewModel:Clear()
    self.data = nil
    self.type = nil
    self.gameObject:SetActive(false)
end

function MissionRewardViewModel:Destroy()
    self.d_Activity = nil
    self.d_Point = nil
    self.d_State = nil

    self.w_Activity = nil
    self.w_Point = nil
    self.w_State = nil
    self.RareSort = nil
    if self.goods ~= nil then
        for i = 1, #self.goods do
            self.goods[i]:Clear()
        end
        self.goods = nil 
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end