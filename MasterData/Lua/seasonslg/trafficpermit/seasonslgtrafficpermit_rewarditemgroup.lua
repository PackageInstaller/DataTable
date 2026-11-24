SeasonSLGTrafficPermit_RewardItemGroup = {};

SeasonSLGTrafficPermit_RewardItemGroup.__index = SeasonSLGTrafficPermit_RewardItemGroup;
require("SeasonSLG/TrafficPermit/SeasonSLGTrafficPermit_RewardItem")

local objs = {
    animator = { path = "", type = "Animator" },
    bgTra = { path = "bg", type = "RectTransform" },
    num1Text = { path = "bg/Num_1", type = "Text" },
    numInfGo = { path = "bg/num_inf", type = "GameObject" },
    norBtn = { path = "bg/norBtn", type = "UIButtonClick" },
    highBtn = { path = "bg/highBtn", type = "UIButtonClick" },
    norItemObj = { path = "bg/normalReward", type = "GameObject" },
    norItemRT = { path = "bg/normalReward", type = "RectTransform" },
    highItemObj = { path = "bg/highRewards", type = "GameObject" },
    highItemRT = { path = "bg/highRewards", type = "RectTransform" },
    bgCanvas = { path = "bg", type = "CanvasGroup" },
}

function SeasonSLGTrafficPermit_RewardItemGroup.New()
    local self = {};
    self.init = false
    setmetatable(self, SeasonSLGTrafficPermit_RewardItemGroup);
    return self;
end

function SeasonSLGTrafficPermit_RewardItemGroup:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.norUIList = UIListView.New(self.norItemObj.transform)
    self.highUIList = UIListView.New(self.highItemObj.transform)
end

function SeasonSLGTrafficPermit_RewardItemGroup:SetData(pdata)
    self.data = pdata.data


    self.bgTra.localScale = Vector3.one;
    self.norItemRT.localScale = Vector3.one;
    self.highItemRT.localScale = Vector3.one;
    self.animator.enabled = true
    self.num1Text.text = self.data.isLast and "" or self.data.num_1
    if (self.data.weekAni) then
        self.animator:Play("ani_SeasonSLGTrafficPermitPanel_rewardItemGroup_02")
    else
        self.animator:Play("ani_SeasonSLGTrafficPermitPanel_rewardItemGroup")
    end
    SetActive(self.numInfGo, self.data.isLast)
    local norList = {}
    for i, v in ipairs(self.data.normalItems) do
        local dataItem = UIListData.GetData(self.data.rewardItemObj, "SeasonSLGTrafficPermit_RewardItem", v)
        table.insert(norList, dataItem);
    end
    self.norUIList:SetData(norList, true)
    local highList = {}
    for i, v in ipairs(self.data.specialItems) do
        local dataItem = UIListData.GetData(self.data.rewardItemObj, "SeasonSLGTrafficPermit_RewardItem", v)
        table.insert(highList, dataItem);
    end
    self.highUIList:SetData(highList, true)

    SetActive(self.norBtn.gameObject, self.data.isNorRewarding);
    SetActive(self.highBtn.gameObject, self.data.isSpeRewarding);

    self.norCommand = function()
        if self.data.callBackNor ~= nil then
            self.data.callBackNor(self.data.index)
        end
    end
    self.highCommand = function()
        if self.data.callBackSpe ~= nil then
            self.data.callBackSpe(self.data.index)
        end
    end
    LuaMgr.AddClick(self.norBtn, self.norCommand)
    LuaMgr.AddClick(self.highBtn, self.highCommand)
end

function SeasonSLGTrafficPermit_RewardItemGroup:DOAlphaAnimation(time)
    self.bgCanvas.alpha = 0.0
    DOTWeen.To(function() return 0.0 end, function(value)
        self.bgCanvas.alpha = value
    end, 1.0, 0.5):SetDelay(0.2 + time)
end

function SeasonSLGTrafficPermit_RewardItemGroup:Clear()
    self.animator.enabled = false
    self.animator:Rebind()
    self.bgTra.localScale = Vector3.one;
    self.norItemRT.localScale = Vector3.one;
    self.highItemRT.localScale = Vector3.one;
    self.bgCanvas.alpha = 1.0
    LuaMgr.RemoveClick(self.norBtn, self.norCommand)
    LuaMgr.RemoveClick(self.highBtn, self.highCommand)
    UIListView.ClearItem("SeasonSLGTrafficPermit_RewardItem")
end

function SeasonSLGTrafficPermit_RewardItemGroup:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.init = nil
end