




local this = {
    vm = nil,
    rankData = nil,
    content = nil,
    scrollReuse = nil,
    RankLishiData = {},
    RankAwardData = {},
}

require("ViewModel/Common/ConnectFourRankItem")
require("ViewModel/Common/ConnectFourRankGroup")
require("ViewModel/Common/ConnectFourRankAwardItem")
require("ViewModel/Common/ConnectFourRankAwardGroup")

local data = {
    uiBtn={
        {
            goChoose=false;
        },
        {
            goChoose=false;
        },
    },
    goRankListScroll=false,
    goAwardListScroll=false,
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.ConnectFourRankViewModel)
        end
    },
   
    uiBtnClick = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local lua_Index = param + 1;
            this.UIBtnClick(lua_Index)
        end
    }
}

this.UIBtnClick=function(lua_Index)
    if lua_Index==1 then
        this.vm.data.goRankListScroll=true;
        this.vm.data.goAwardListScroll=false;
        this.InitRankList()
    elseif(lua_Index==2) then
        this.vm.data.goRankListScroll=false;
        this.vm.data.goAwardListScroll=true;
        this.InitRankAwardList()
    else
        print("UIBtnClick is err")
    end

    local btnCount= # this.vm.data.uiBtn;
    for i = 1, btnCount do
        this.vm.data.uiBtn[i].goChoose=i==lua_Index;
    end
end

local hook = {
    before_awake = function(vm)
        this.vm = vm
        
        this.rankScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/goRoot/goRankListScroll"):GetComponent("ScrollRect").gameObject)

        this.rankAwardScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/goRoot/goAwardListScroll"):GetComponent("ScrollRect").gameObject)
        
        this.Rankitem = vm.behaviour.transform:Find("template/ConnectFourRankItem").gameObject
        this.RankGroup = vm.behaviour.transform:Find("template/ConnectFourRankGroup").gameObject
        
        this.RankAwarditem = vm.behaviour.transform:Find("template/ConnectFourRankAwardItem").gameObject
        this.RankAwardGroup = vm.behaviour.transform:Find("template/ConnectFourRankAwardGroup").gameObject
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            this.rankData = vm.behaviour.Params[0]
            this.UIBtnClick(1);
        end
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
            this.rankScrollView:Clear(true)
            this.rankAwardScrollView:Clear(true)
            this.rankData = nil
        end
    end,
    before_destroy = function(vm)
        if vm.behaviour.Params ~= nil then
            UIScrollView.ClearItem("ConnectFourRankGroup")
            UIScrollView.ClearItem("ConnectFourRankAwardGroup")
        end
    end
}

this.InitRankAwardList= function()

    local rankAward=ConfigMgr.Config.RankMap;
    local tempt = {}

    for index, value in pairs(rankAward) do

        local tempRewardLis,rewardItem = {},nil

        local awardNum=#value.VicItem;
        for i = 1, awardNum do
            rewardItem = {
                id = value.VicItem[i].id,
                count = value.VicItem[i].count,
               }
            table.insert(tempRewardLis,rewardItem)
        end

        local  tempAward= {
            id=tonumber(value.Id),
            goLevelBgsType1 = (value.Left - value.Right) == 0 and  value.Left<=3;
            goLevelBgsType2 = (value.Left - value.Right) == 0 and  value.Left>3;
            goLevelBgsType3 = (value.Left - value.Right) ~= 0;
            textLeft = tostring(value.Left),
            textRight = tostring(value.Right),
        }
        
        tempAward.rewardLis = tempRewardLis

        table.insert(tempt,tempAward);
    end

    table.sort(tempt, function(a, b)
        return a.id < b.id
    end)
    
    this.RankAwardData=tempt;
    this.SetAwardScrollView();
end


this.InitRankList = function()
    local tempt = {}
    for index, value in ipairs(this.rankData) do
        local Dataavatar, DataavatarFrame = this.OnAvatarRefresh(value.Avatar, value.CurrentAvatarFrame)
        local rankItem =        {
            itemId = value.Uid,
            avatar = Dataavatar,
            avatarFrame = DataavatarFrame,
            frontTree = index <= 3,
            normalRank = index > 3,
            AchieveNum = tostring(value.Score),
            heroName = value.Name,
            levelNum = tostring(index),
            emptyData = Dataavatar==nil
        }
        table.insert(tempt, rankItem)
    end
    local listlength = #tempt
    local needTab
    if listlength < 20 then
        if listlength == 0 then
            needTab =        {
                itemId = "",
                avatar = DefaultTexture,
                avatarFrame = "",
                frontTree = false,
                normalRank = false,
                AchieveNum = "",
                heroName = "",
                levelNum = "",
                emptyData = false
            }
        else
            needTab = table.Copy(tempt[1])
        end
        local fileNum = 20 - listlength
        for i = 1, fileNum, 1 do
            needTab.emptyData = true
            needTab.heroName = LuaMgr.GetLangText("ConnectFourRankViewModel_0")
            needTab.AchieveNum = LuaMgr.GetLangText("ConnectFourRankViewModel_1")
            needTab.levelNum = tostring(listlength + i)
            needTab.frontTree = listlength + i <= 3
            needTab.normalRank = listlength + i > 3
            local currentTab = table.Copy(needTab)
            table.insert(tempt, currentTab)
        end
    end

    this.RankLishiData = tempt
    this.SetScrollView()
end


this.OnAvatarRefresh = function(currentavaratr, currentframe)
    local avatarTexture = nil
    local avatarFrameId = nil
    local avatarData = nil;
    local frameData = nil;
    for i, v in ipairs(ConfigMgr.Config.avatarFrames) do
        if v.id == currentavaratr then
            avatarData = v;
        elseif v.id == currentframe then
            frameData = v;
        end
        if avatarData ~= nil and frameData ~= nil then
            break;
        end
    end
    if avatarData ~= nil then
        local avatarPath = ConfigHelper.GetHeadIconPath(avatarData.img, avatarData.imgId);
        avatarTexture = LuaMgr.GetTexture(avatarPath);
    end
    if frameData ~= nil then
        avatarFrameId = frameData.id;
    end
    return avatarTexture, avatarFrameId
end

local keyList = { "data_1" }


this.SetScrollView = function()
    local RankItemData
    local groupData
    local scrollData
    this.rankScrollView:Clear(false)
    local scrollDatas = {}
    local len = #this.RankLishiData
    local index = 1
    while (index <= len) do
        groupData = {}
        groupData.item = this.Rankitem
        RankItemData = this.RankLishiData[index]
        if (RankItemData ~= nil) then
            groupData[keyList[1]] = RankItemData
        end
        scrollData = UIScrollData.GetData(this.RankGroup, "ConnectFourRankGroup", 654, 75.3, groupData)
        table.insert(scrollDatas, scrollData)
        index = index + 1
    end
    this.rankScrollView:SetParams(654, 375)
    this.rankScrollView:SetData(scrollDatas, true)
end


this.SetAwardScrollView = function()
    local RankAwardItemData
    local groupData
    local scrollData
    this.rankAwardScrollView:Clear(false)
    local scrollDatas = {}
    local len = #this.RankAwardData
    local index = 1
    while (index <= len) do
        groupData = {}
        groupData.item = this.RankAwarditem
        RankAwardItemData = this.RankAwardData[index]
        if (RankAwardItemData ~= nil) then
            groupData[keyList[1]] = RankAwardItemData
        end
        scrollData = UIScrollData.GetData(this.RankAwardGroup, "ConnectFourRankAwardGroup", 654, 75.3, groupData)
        table.insert(scrollDatas, scrollData)
        index = index + 1
    end
    
    this.rankAwardScrollView:SetParams(654, 375)
    this.rankAwardScrollView:SetData(scrollDatas, true)
end


return vm(
{
    data = data,
    command = command,
    hook = hook
}
)