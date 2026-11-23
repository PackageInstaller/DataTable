CrisisContractTaskItem = {};

CrisisContractTaskItem.__index = CrisisContractTaskItem;

local objs = {
    bg_1={path="Group/Bg/bg1",type="GameObject"},
    bg_2={path="Group/Bg/bg2",type="GameObject"},
    appointBuffListTr={path="Group/ConditionList/AppointBuffList",type="Transform"},
    levelRatingListTr={path="Group/ConditionList/LevelRatingList",type="Transform"},
    rewardContent={path="Group/RewardScrollView/Viewport/Content",type="Transform"},
    AppointBuffItemTemp={path="Group/ConditionList/AppointBuffItem",type="GameObject"},
    LevelItemTemp={path="Group/ConditionList/LevelItem",type="GameObject"},
    RatingItemTemp={path="Group/ConditionList/RatingItem",type="GameObject"},
    RewardItemTemp={path="Group/RewardScrollView/Viewport/Content/RewardItem",type="GameObject"},
    desc={path="Group/Desc",type="Text"},
    canGetBtn={path="Group/BtnGroup/CanGetBtn",type="Button"},
    progressBtn={path="Group/BtnGroup/ProgressBtn",type="Button"},
    finishedBtn={path="Group/BtnGroup/FinishedBtn",type="Button"},
    animatorObj={path="Group",type="GameObject"},
}

function CrisisContractTaskItem.New()
    local self = {};
    setmetatable(self, CrisisContractTaskItem);
    return self;
end

function CrisisContractTaskItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.canGetBtn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end);
    LuaMgr.AddClick(self.progressBtn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end);
    LuaMgr.AddClick(self.finishedBtn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end);
    SetActive(self.AppointBuffItemTemp, false)
    SetActive(self.LevelItemTemp, false)
    SetActive(self.RatingItemTemp, false)
    SetActive(self.RewardItemTemp, false)
    self.rewardItemTrList={}
    self.appointBuffItemIconList={}
    self.levelItemIconList={}
    self.ratingItemIconList={}

    self.HalfAplhaColor = UnityEngine.Color(255 / 255.0, 255 / 255.0, 255 / 255.0, 127.5 / 255.0);
    self.CommonAplhaColor = UnityEngine.Color.white;
    SetActive(self.animatorObj,false)
end

function CrisisContractTaskItem:SetData(pdata)
    self.data = pdata.data
    if self.data.animBool then

        SetActive(self.animatorObj,true)
    end
    SetActive(self.bg_1, not self.data.isFinish)
    SetActive(self.bg_2, self.data.isFinish)
    SetActive(self.appointBuffListTr.gameObject, self.data.showAppointBuffList)
    SetActive(self.levelRatingListTr.gameObject, self.data.showLevelRatingList)
    SetActive(self.canGetBtn.gameObject, self.data.isCanGet)
    SetActive(self.progressBtn.gameObject, self.data.isProgress)
    SetActive(self.finishedBtn.gameObject, self.data.isFinish)
    self.desc.text = self.data.desc
    
    local imageColor = self.data.isFinish and self.HalfAplhaColor or self.CommonAplhaColor

    local index = 1
    for i, v in ipairs(self.data.appointBuffList) do
        if self.appointBuffItemIconList[index] == nil then
            local obj = LuaMgr.InstantiateGO(self.AppointBuffItemTemp, self.appointBuffListTr, false)
            self.appointBuffItemIconList[index] = obj.transform:Find("Icon"):GetComponent("Image")
        end
        SetActive(self.appointBuffItemIconList[index].transform.parent.gameObject,true)
        self.appointBuffItemIconList[index].sprite = v.icon
        self.appointBuffItemIconList[index].color = imageColor
        index = index + 1
    end
    for i = index, #self.appointBuffItemIconList do
        SetActive(self.appointBuffItemIconList[i].transform.parent.gameObject, false)
    end
    
    index = 1
    for i, v in ipairs(self.data.levelRatingList) do
        if v.type == 1 then
            if self.levelItemIconList[index] == nil then
                local obj = LuaMgr.InstantiateGO(self.LevelItemTemp, self.levelRatingListTr, false)
                self.levelItemIconList[index] = obj:GetComponent("Image")
            end
            SetActive(self.levelItemIconList[index].transform.gameObject,true)
            self.levelItemIconList[index].sprite = v.icon
            self.levelItemIconList[index].color = imageColor
            index = index + 1
        end
    end
    for i = index, #self.levelItemIconList do
        SetActive(self.levelItemIconList[i].transform.gameObject, false)
    end
    
    index = 1
    for i, v in ipairs(self.data.levelRatingList) do
        if v.type == 2 then
            if self.ratingItemIconList[index] == nil then
                local obj = LuaMgr.InstantiateGO(self.RatingItemTemp, self.levelRatingListTr, false)
                self.ratingItemIconList[index] = obj.transform:Find("Icon"):GetComponent("Image")
            end
            SetActive(self.ratingItemIconList[index].transform.parent.gameObject,true)
            self.ratingItemIconList[index].transform.parent.gameObject:GetComponent("RectTransform"):SetAsLastSibling()
            self.ratingItemIconList[index].sprite = v.icon
            self.ratingItemIconList[index].color = imageColor
            index = index + 1
        end
    end
    for i = index, #self.ratingItemIconList do
        SetActive(self.ratingItemIconList[i].transform.parent.gameObject, false)
    end

    index = 1
    for i,v in ipairs(self.data.rewardList) do
        local goodsItem = nil
        if self.rewardItemTrList[i] == nil then
            local obj = LuaMgr.InstantiateGO(self.RewardItemTemp, self.rewardContent, false)
            SetActive(obj, true)
            self.rewardItemTrList[i] = GoodsDataItem.New(self.rewardContent)
            self.rewardItemTrList[i].transform:SetParent(obj.transform, false)
        end
        SetActive(self.rewardItemTrList[i].gameObject,true)
        local itemConfig = ConfigMgr.Config.itemMap[v.id]
        itemConfig["count0"] = v.count
        self.rewardItemTrList[i]:SetData(1, itemConfig, 1, false, Vector3(0.5, 0.5, 0.5), false)
        self.rewardItemTrList[i].transform.parent:GetComponent("CanvasGroup").alpha = self.data.isFinish and 0.5 or 1
        index = index + 1
    end
    for i = index, #self.rewardItemTrList do
        self.rewardItemTrList[i]:Hide()
    end
    SetActive(self.gameObject, true)
end

function CrisisContractTaskItem:Hide()
    SetActive(self.gameObject, false)
end
    
function CrisisContractTaskItem:Clear()
    for i,v in ipairs(self.rewardItemTrList) do
        v:Hide()
    end
    for i,v in ipairs(self.appointBuffItemIconList) do
        SetActive(v.transform.parent.gameObject,false);
    end
    for i,v in ipairs(self.levelItemIconList) do
        SetActive(v.gameObject,false);
    end
    for i,v in ipairs(self.ratingItemIconList) do
        SetActive(v.transform.parent.gameObject,false);
    end
    LuaMgr.RemoveTimer(TimerConst.CrisisContractTaskItemShow + self.data.index)
    self.data=nil
    SetActive(self.animatorObj,false)
end

function CrisisContractTaskItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.info=nil
    self.bg_1=nil
    self.bg_2=nil
    self.appointBuffListTr=nil
    self.levelRatingListTr=nil
    self.desc=nil
    self.rewardContent=nil
    self.canGetBtn=nil
    self.progressBtn=nil
    self.finishedBtn=nil
end