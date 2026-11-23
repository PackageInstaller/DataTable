





SignIn7DaysItem = {}

SignIn7DaysItem.__index = SignIn7DaysItem
local objs = {
    normal = {path = "Normal",type = "GameObject"},
    canGet = {path = "CanGet",type = "GameObject"},
    already = {path = "Already",type = "GameObject"},
    getBtn = {path = "rewardBtn",type = "Button"},
    c_canGetSprite = {path = "CanGet/DayImage",type = "Image"},
    c_normalSprite = {path = "Normal/DayImage",type = "Image"},
    c_alreadySprite = {path = "Already/DayImage",type = "Image"},
    dayText={path = "DayText",type = "Text"},
    rewardRoot = {path = "RewardList",type = "RectTransform"},
}

function SignIn7DaysItem.New()
    local self = {}
    setmetatable(self, SignIn7DaysItem)
    return self
end

function SignIn7DaysItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.rewardList=UIListView.New(self.rewardRoot)
    self.getCommand = function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end
    LuaMgr.AddClick(self.getBtn,self.getCommand)
end







function SignIn7DaysItem:SetData(data)
    self.data = data.data
    SetActive(self.normal,self.data.state==1)
    SetActive(self.canGet,self.data.state==2);
    SetActive(self.already,self.data.state==3);
    SetActive(self.getBtn.gameObject,self.data.state==2);
    if self.data.state==2 then
        self.c_canGetSprite.sprite=LuaMgr.GetSprite("CheckIn7Days","ui_hd_dh_qd_bhh_0"..self.data.index)
        self.dayText.text=string.format("<color=#A15c32>%s</color>",self.data.dayName);
    else
        self.c_normalSprite.sprite=LuaMgr.GetSprite("CheckIn7Days","ui_hd_dh_qd_bh_0"..self.data.index)
        self.c_alreadySprite.sprite=LuaMgr.GetSprite("CheckIn7Days","ui_hd_dh_qd_bh_0"..self.data.index)
        self.dayText.text=string.format("<color=#5C3A2C>%s</color>",self.data.dayName);
    end

    self.rewardList:Clear();
    if IsNull(self.data.items) then return end;
    local list={}
    for i,v in ipairs(self.data.items) do
        local item={
            id=v.id;
            count=v.count;
            isRewarded=self.data.state==3;
        }
        local itemData=UIListData.GetData(self.data.goodsItemObj,"SignIn7DaysGoodsItem",item);
        table.insert(list,itemData);
    end
    self.rewardList:SetData(list)
end


function SignIn7DaysItem:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function SignIn7DaysItem:Destroy()
    if (self.getCommand ~= nil) then
        LuaMgr.RemoveClick(self.getBtn, self.getCommand)
        self.getCommand = nil
    end
    self.rewardList:Clear();
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end