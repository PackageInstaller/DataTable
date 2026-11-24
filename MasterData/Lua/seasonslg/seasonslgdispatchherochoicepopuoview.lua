require("SeasonSLG/EventPopUp/HeroHeadGroup")
require("SeasonSLG/EventPopUp/HeroHeadItem")

local PANEL_NAME = "SeasonSLGDisPatchHerochoicePopuoView"

local this = {
    vm = nil,
    gridId,
    allHeroIdList,
    dispatchInfo,
    heroScrollView,
    selectList,
    fitterList,


    jobType,
    sortType,
    sequenceType,

    heroGroupList,
    upCallBack,


    dispatchTimeSelectIndex,
    dispatchTimeCfg,
    functionKey,

    characterSeasonLevelMin,

    updateCallBack,
}

local data = {
    dispatchTimeList = {{time = "",select = false},}
}

local command = {
    SelectTimeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OnClickDispatchTimeItem(param + 1)
        end
    },
    CloseCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.heroScrollView:Clear();
            LuaMgr.HidePanel(UIName.SeasonSLGDisPatchHerochoicePopuoView)
        end
    },
}

local function GetPanelName()
    return UIName ~= nil and UIName.SeasonSLGDisPatchHerochoicePopuoView or PANEL_NAME
end

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");

    ui.goScrollView = uiLink:Get("goScrollView"):GetComponent("RectTransform");
    ui.btnArrow = uiLink:Get("btnArrow"):GetComponent("Button");
    ui.btnFilter = uiLink:Get("btnFillter"):GetComponent("Button");
    ui.goNoneHero = uiLink:Get("goNoneHero");
    ui.goHeadListGroup = uiLink:Get("goHeadListGroup");
    ui.goHeadItem = uiLink:Get("goHeadItem");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");

    this.heroScrollView = UIScrollView.New(ui.goScrollView);
end

this.ClickFilter = function()
    this.jobType = this.jobType == nil and CharacterJob.All or this.jobType
    this.sortType = this.sortType == nil and HeroSortType.Level or this.sortType
    this.sequenceType = this.sequenceType == nil and SequenceType.FromBigToSmall or this.sequenceType
    HeroParameter.SaveListParam(this.jobType, this.sortType, this.sequenceType, 0, 1)
    LuaMgr.ShowLuaPanel(UIName.FilterSortViewModel)
end

this.ClearUI = function()
    ui = nil
end


this.ClearScrollViews = function()
    if this.overviewScrollView ~= nil then
        this.overviewScrollView:Clear()
    end



    if this.gridScrollView ~= nil then
        this.gridScrollView:Clear()
    end
    if this.tabScrollView ~= nil then
        this.tabScrollView:Clear()
    end
end

this.ClearListViews = function()
    if this.gridFilterListView ~= nil then
        this.gridFilterListView:Clear()
    end
end

this.DestroyScrollViews = function()
    this.ClearScrollViews()
    if this.overviewScrollView ~= nil then
        this.overviewScrollView:Destroy()
        this.overviewScrollView = nil
    end




    if this.gridScrollView ~= nil then
        this.gridScrollView:Destroy()
        this.gridScrollView = nil
    end
    if this.tabScrollView ~= nil then
        this.tabScrollView:Destroy()
        this.tabScrollView = nil
    end
end

this.DestroyListViews = function()
    this.ClearListViews()
    if this.gridFilterListView ~= nil then
        this.gridFilterListView:Destroy()
        this.gridFilterListView = nil
    end
end

this.ClearItems = function(groupName)
    if this.items[groupName] == nil then
        return
    end
    for i = #this.items[groupName], 1, -1 do
        local item = this.items[groupName][i]
        if item ~= nil then
            item:Destroy()
        end
        this.items[groupName][i] = nil
    end
end

this.ClearAllItems = function()
    this.characterSeasonLevelMin = nil
    if this.items ~= nil then
        for groupName, _ in pairs(this.items) do
            this.ClearItems(groupName)
        end
    end
    this.ClearScrollViews()
    this.ClearListViews()
end

this.CreateItem = function(groupName, template, parent, itemClass)
    if template == nil or parent == nil or itemClass == nil then
        return nil
    end
    if this.items[groupName] == nil then
        this.items[groupName] = {}
    end

    local gameObject = LuaMgr.InstantiateGO(template, parent.transform, false)
    if gameObject == nil then
        return nil
    end
    SetActive(gameObject, true)

    local item = itemClass.New()
    item.gameObject = gameObject
    item.transform = gameObject.transform
    item:Init()
    table.insert(this.items[groupName], item)
    return item
end

this.SetDispatchTimeList = function()
    if IsNull(this.dispatchTimeCfg) then
        return
    end
    local tempList = {};
    for i, v in ipairs(this.dispatchTimeCfg) do
        local item = {};
        item.time = v .. LuaMgr.GetLangText("SeasonSLGDisPatchHerochoicePopuoView_0");
        item.select = i == this.dispatchTimeSelectIndex;
        table.insert(tempList,item)
    end
    this.vm.data.dispatchTimeList = tempList
end

this.OnClickDispatchTimeItem = function(param)
    if param == this.dispatchTimeSelectIndex then
        return
    end
    this.vm.data.dispatchTimeList[this.dispatchTimeSelectIndex].select = false
    this.dispatchTimeSelectIndex = tonumber(param)
    this.vm.data.dispatchTimeList[this.dispatchTimeSelectIndex].select = true

    this.UpdateParentFunc();
end

this.RefreshPopuShow = function()
    this.RefreshHeroList()
    this.SetDispatchTimeList();
end

this.FillterList = function(selectList,fitterList)
    local len=#fitterList
    if len>0 then
        for i=len,1,-1 do
            if NumTool.FindIndex(selectList,fitterList[i])>0 then
                table.remove(fitterList,i);
            end
        end
    end
end


this.GetAllCharacter=function()
    this.jobType = HeroParameter.paramBool and HeroParameter.jobType or CharacterJob.All
    this.sortType = HeroParameter.paramBool and HeroParameter.sortType or HeroSortType.Level
    this.sequenceType = HeroParameter.paramBool and HeroParameter.sequenceType or SequenceType.FromBigToSmall
    local heroDic = {}
    local characters = DataMgr.Player.characters
    for key, value in pairs(characters) do

        if ConfigCharacterMgr.GetSeasonalHeroConfig(key) then
            local tempData = {}
            local heroConfig = ConfigMgr.Config.characterTable[key]
            tempData.name = LuaMgr.GetLangText(heroConfig.namelan)
            tempData.rare = HeroMgr.GetHeroNowRare(key);
            tempData.job=heroConfig.job
            tempData.id = heroConfig.id
            tempData.heroID = heroConfig.id
            tempData.level = value.level
            tempData.star = value.star
            tempData.createTime = value.createTime
            tempData.selectIndex = 0
            tempData.selected=false;
            tempData.lock=SeasonSLGMapMgr.CheckCharacterIsDispatching(heroConfig.id);
            tempData.isFullExtraCond=false;
            tempData.sLevel=SeasonSLGMapMgr.GetCharacterSeasonLevel(key)
            if this.jobType == CharacterJob.All or (heroConfig ~= nil and this.jobType == heroConfig.job) then
                if NumTool.FindIndex(this.fitterList,heroConfig.id)<=0 then
                    heroDic[tempData.heroID] = tempData
                end
            end
        end
    end
    local heroList = {}
    for key, value in pairs(heroDic) do
        if value.sLevel >= this.characterSeasonLevelMin  then
            table.insert(heroList, value)
        end
    end

    if #heroList > 1 then
        if this.sortType == HeroSortType.Level then
            table.sort(heroList, SeasonSLGMapMgr.LevelSort)
        elseif this.sortType == HeroSortType.Rare then
            table.sort(heroList, SeasonSLGMapMgr.RareSort)
        elseif this.sortType == HeroSortType.Star then
            table.sort(heroList, SeasonSLGMapMgr.StarSort)
        elseif this.sortType == HeroSortType.Time then
            table.sort(heroList, SeasonSLGMapMgr.TimeSort)
        end
    end
    return heroList
end


this.UpdateHeroListSelectState = function()
    local selectList={};
    if this.selectList == nil then
        this.selectList = {}
        if not IsNull(this.dispatchInfo) and not IsNull(this.dispatchInfo.members) then
            this.selectList = this.dispatchInfo.members
        end
    end
    for i = #this.allHeroIdList, 1, -1 do
        local findIndex = NumTool.FindIndex(this.selectList, this.allHeroIdList[i].id)
        if findIndex > 0 then
            this.allHeroIdList[i].selected = true;
            this.allHeroIdList[i].selectIndex = findIndex;
            table.insert(selectList, this.allHeroIdList[i]);
            table.remove(this.allHeroIdList, i)
        else
            this.allHeroIdList[i].selected = false;
        end
    end
    local newHeroList = {};
    for i=#selectList, 1,-1 do
        table.insert(newHeroList,selectList[i])
    end
    for _, v in ipairs(this.allHeroIdList) do
        table.insert(newHeroList, v)
    end
    this.allHeroIdList=newHeroList;
end

this.UpdateParentFunc = function()
    if this.updateCallBack ~= nil then
        this.updateCallBack({chooseTime = this.dispatchTimeCfg[this.dispatchTimeSelectIndex],
        chooseMembers = this.selectList,
    })
    end
end


this.HeadClickCallBack = function(index)
    local dataItem=this.allHeroIdList[index];
    if SeasonSLGMapMgr.CheckCharacterIsDispatching(dataItem.id) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSLGDisPatchHerochoicePopuoView_1"))
        return;
    end
    if dataItem.selected then
        local findIndex=NumTool.FindIndex(this.selectList,dataItem.id)
        if findIndex>0 then
            table.remove(this.selectList,findIndex);
        end
    else
        if #this.selectList>=6 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSLGDisPatchHerochoicePopuoView_2"));
            return;
        end
        table.insert(this.selectList,dataItem.id);
    end
    if this.upCallBack~=nil then
        this.upCallBack(this.selectList);
    end
    this.SetHeroViewList();
    this.UpdateParentFunc();
end

this.SetHeroViewList = function()
    this.heroScrollView:Clear();
    this.UpdateHeroListSelectState();
    SetActive(ui.goNoneHero,#this.allHeroIdList==0);
    this.heroGroupList = {}
    for i = 1, #this.allHeroIdList, 4 do
        local group = {}
        for j = i, math.min(i + 3, #this.allHeroIdList) do
            table.insert(group, this.allHeroIdList[j])
        end
        table.insert(this.heroGroupList, group)
    end
    local CallBack=function(groupIndex,locIndex)
        local index=(groupIndex-1)*4+locIndex
       this.HeadClickCallBack(index);
    end
    local list={}
    for i,v in ipairs(this.heroGroupList) do
        local groupList={
            groupIndex=i,
            list=v,
            headItemObj=ui.goHeadItem,
            callBack=CallBack
        }
        local groupListData=UIScrollData.GetData(ui.goHeadListGroup,"HeroHeadGroup",493,100,groupList)
        table.insert(list,groupListData);
    end

    this.heroScrollView:SetParams(385,410)
    this.heroScrollView:SetData(list);
end

this.RefreshHeroList = function()
    if this.characterSeasonLevelMin == nil then
        return
    end
    this.fitterList=SeasonSLGEventMgr.GetDispatchHeroList(this.gridId)
    this.FillterList(this.selectList,this.fitterList)
    LuaMgr.RemoveUIEventListener(UIEventConst.UpdateHeroList, this.UpdateHeroListBySort)
    this.UpdateHeroListBySort=function()
        this.allHeroIdList = this.GetAllCharacter();
        this.SetHeroViewList();
    end
    LuaMgr.AddUIEventListener(UIEventConst.UpdateHeroList, this.UpdateHeroListBySort)
    this.allHeroIdList = this.GetAllCharacter();
    this.SetHeroViewList();
end

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitUI(vm.behaviour)
    end,
    before_active = function(vm)
        if vm.behaviour.Params and vm.behaviour.Params.Length > 0 then
            local uiParam = vm.behaviour.Params[0]
            this.gridId = uiParam.gridId
            this.dispatchInfo = uiParam.dispatchInfo
            this.updateCallBack = uiParam.updateCallBack
            this.selectList = {}
            if not IsNull(this.dispatchInfo) and not IsNull(this.dispatchInfo.members) then
                this.selectList = this.dispatchInfo.members
            elseif uiParam.fillterChoose then
                this.selectList = uiParam.fillterChoose
            end
            this.dispatchTimeSelectIndex = 1
            if uiParam.chooseTime ~= nil then
                for i, v in ipairs(uiParam.dispatchTimeList) do
                    if v == uiParam.chooseTime then
                        this.dispatchTimeSelectIndex = i
                        break
                    end
                end
            end
            this.functionKey = uiParam.functionKey
            this.dispatchTimeCfg = uiParam.dispatchTimeList
            this.characterSeasonLevelMin = uiParam.heroSeasonLevelMin == nil and 0 or uiParam.heroSeasonLevelMin
        end
        this.RefreshPopuShow()
    end,
    before_deactive = function(vm)
        this.ClearAllItems()
        LuaMgr.RemoveUIEventListener(UIEventConst.UpdateHeroList, this.UpdateHeroListBySort)
    end,
    before_destroy = function()
        this.ClearAllItems()
        this.DestroyScrollViews()
        this.DestroyListViews()
        UIScrollView.ClearItem("SeasonSLGOverviewCardItem")
        UIScrollView.ClearItem("SeasonSLGOverviewTabItem")
        UIScrollView.ClearItem("SeasonSLGOverviewMiniGameItem")
        UIScrollView.ClearItem("SeasonSLGOverviewGridLevelUpItem")
        UIScrollView.ClearItem("SeasonSLGDispatchItem")
        UIScrollView.ClearItem("HeroHeadGroup")
        UIListView.ClearItem("SeasonSLGOverviewFilterItem")
        this.ClearUI()
        this.vm = nil
    end
}

return vm({
    data = data,
    command = command,
    hook = hook,
})