require("DH/DHSurveyMapDrawItem")
require("DH/DHSurveyDrawRewardItem")
require("DH/DHConst")

local this = {
    mapList = nil,
    rewardListH = nil,
    rewardListV = nil,
    dhLevel = nil,
    stageId = nil,
};

local objs = {

    mapItem = { path = "template/MapItem", type = "GameObject" },
    rewardItem = { path = "template/RewardItem", type = "GameObject" },
    mapListTF = { path = "root/Middle/Map/List", type = "Transform" },
    mapListVTF = { path = "root/Middle/Map/ListV", type = "Transform" },
    mapListHTF = { path = "root/Middle/Map/ListH", type = "Transform" },
    imageBgIcon = { path = "root/Middle/Map/ImageBgIcon", type = "Image" },
    repairBtn = { path = "root/Middle/Map/RepairBtn", type = "Button" },
    repairOn = { path = "root/Middle/Map/RepairBtn/RepairOn", type = "GameObject" },
    repairOff = { path = "root/Middle/Map/RepairBtn/RepairOff", type = "GameObject" },
    repairFinish = { path = "root/Middle/Map/RepairBtn/RepairFinish", type = "GameObject" },
    textNum = { path = "root/Middle/Map/ImgNumBg/TextNum", type = "Text" },
    tips = { path = "root/Middle/Map/Tips", type = "Text" },
    imgIcon = { path = "root/Middle/Map/ImgNumBg/ImgIcon", type = "RawImage" },
    backBtn = { path = "root/Bg", type = "Button" },
};


this.OnBack = function()
    LuaMgr.HidePanel(UIName.DHSurveyDrawViewModel);
end


this.SetData = function()
    local curGet = PlayerDHMgr.GetCurExploreReward(this.stageId)
    this.textNum.text = curGet
    this.tips.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_21100")
    this.SetMapList();
    this.SetReward(1)
    this.SetReward(2)  
    if (this.stageConfig.DebrisNum ~= this.openedNum) then
        if (curGet > 0) then
            this.state = 1
        else
            this.state = 2
        end
    else
        this.state = 3
    end
    this.repairBtn.interactable = this.state == 1
    SetActive(this.repairOn, this.state == 1)
    SetActive(this.repairOff, this.state == 2)
    SetActive(this.repairFinish, this.state == 3)
end


this.SetMapList = function()
    local dhMap = PlayerDHMgr.GetCurDrawOpenList(this.stageId)
    local len = this.stageConfig.DebrisNum;
    this.openedNum = 0
    if (#this.mapList.itemList ~= len) then
        this.mapList:Clear()
        local listDatas = {}
        for i = 1, len do
            local data = {}
            data.index = i
            data.stageId = this.stageId
            data.isOpen = dhMap[""..i] ~= nil
            data.isInit = true
            if (data.isOpen) then
                this.openedNum = this.openedNum + 1
            end
            local listData = UIListData.GetData(this.mapItem, "DHSurveyMapDrawItem", data);
            listDatas[i] = listData
        end
        this.mapList:SetData(listDatas);
    else
        for i, v in ipairs(this.mapList.itemList) do
            local data = {}
            data.index = i
            data.stageId = this.stageId
            data.isOpen = dhMap[""..i] ~= nil
            data.isInit = false
            if (data.isOpen) then
                this.openedNum = this.openedNum + 1
            end
            data.data = data
            v:SetData(data, true)
        end
    end
end

this.SetReward = function(posType)
    local dhMap = this.scrollListConfig
    local mapList = nil;
    local startIndex = 1
    if (posType == 1) then
        mapList = this.rewardListH
        startIndex = 7
    else
        mapList = this.rewardListV       
    end
    local refrehIndex = startIndex - 1
    local len = #dhMap / 2;
    if (#mapList.itemList ~= len) then
        mapList:Clear()
        local listDatas = {}
        for i = 1, len do
            local listData = UIListData.GetData(this.rewardItem, "DHSurveyDrawRewardItem", dhMap[i + refrehIndex]);
            listDatas[i] = listData
        end
        mapList:SetData(listDatas);
    else
        for i, v in ipairs(mapList.itemList) do
            local data = {}
            data.data = dhMap[refrehIndex + i]
            v:SetData(data, true)
        end
    end
end


this.OnClickRepair = function()
    if (this.state == 1 or this.state == 2) then
        PlayerDHMgr.ExploreDraw(this.stageId)   
    end
end


this.OnMapRefresh = function(args)
    this.SetData();
end



local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.mapList = UIListView.New(this.mapListTF);
        this.rewardListH = UIListView.New(this.mapListHTF);
        this.rewardListV = UIListView.New(this.mapListVTF);
        LuaMgr.AddClick(this.repairBtn, this.OnClickRepair);
        LuaMgr.AddClick(this.backBtn, this.OnBack)
    end,
    before_active = function(vm)
        this.oldHpPercent = nil
        if (vm.behaviour.Params == nil) then return end
        this.bShow = PlayerDHMgr.GetPlayAudio()
        if (this.bShow) then
            PlayerDHMgr.SetPlayAudio(false)

        end
        LuaMgr.AddUIEventListener(UIEventConst.QinSurveyMapRefresh, this.OnMapRefresh);


        this.stageConfig = vm.behaviour.Params[0];
        this.stageId = this.stageConfig.Id
        this.scrollListConfig = ConfigDHMgr.GetDrawScrollList(this.stageId)
        this.imageBgIcon.sprite = LuaMgr.GetSprite("DunHuang", "ui_hd_dh_ch_xf_pic_" .. this.stageConfig.SortId);       
        local reward = ConfigDHMgr.GetGridReward(DHSurveyGrid.Box2, this.stageId)

        this.imgIcon.texture = GetItemTexture(reward.id)
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.QinSurveyMapRefresh, this.OnMapRefresh);
        this.mapList:Clear();
        this.rewardListH:Clear();
        this.rewardListV:Clear();
        if this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay)
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.repairBtn, this.OnClickRepair);
        LuaMgr.RemoveClick(this.backBtn, this.OnBack)
        UIListView.ClearItem("DHSurveyMapDrawItem");
        UIListView.ClearItem("DHSurveyDrawRewardItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})