require("SeasonSLG/EventPopUp/HeroHeadGroup")
HeroChoiceModel = {};

HeroChoiceModel.__index = HeroChoiceModel;
local objs = {
    rootTF = { path = "root", type = "Transform" },
    txtTitle = { path = "root/lable/title", type = "Text" },
    btnFilter={path="root/FilterButton",type="Button"},
    goView={path="root/ScrollView",type="GameObject"},
    btnArrow={path="root/btnArrow",type="Button"},
    goNone={path="root/goNoneHero",type="GameObject"},
    goHeadListGroup={path="template/headListGroup",type="GameObject"},
    goHeadItem={path="template/headItem",type="GameObject"},
};

function HeroChoiceModel.New(parent)
    local self = {};
    setmetatable(self, HeroChoiceModel);
    self.prefabPath = "Assets/_BundleResources/UI/SeasonSLG/HeroChoiceModel.prefab"
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath)
    self.transform=self.gameObject.transform;
    self.transform:SetParent(parent,false);
    self.transform.localPosition = Vector3.zero;
    self.transform.localScale=Vector3.one;
    self:Init();
    return self;
end

function HeroChoiceModel:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.heroScrollView=UIScrollView.New(self.goView);
    LuaMgr.AddClick(self.btnArrow,function()
        self.heroScrollView:Clear();
        SetActive(self.gameObject,false);
    end)

    LuaMgr.AddClick(self.btnFilter,function()
        self:ClickFilter();
    end)
end

function HeroChoiceModel:ClickFilter()
    self.jobType = self.jobType == nil and CharacterJob.All or self.jobType
    self.sortType = self.sortType == nil and HeroSortType.Level or self.sortType
    self.sequenceType = self.sequenceType == nil and SequenceType.FromBigToSmall or self.sequenceType
    HeroParameter.SaveListParam(self.jobType, self.sortType, self.sequenceType, 0, 1)
    LuaMgr.ShowLuaPanel(UIName.FilterSortViewModel)
end

function HeroChoiceModel:PlayAnimation()
    SetActive(self.rootTF.gameObject,false)
    SetActive(self.rootTF.gameObject,true)
end

function HeroChoiceModel:FitterList(selectList,fitterList)
    local len=#fitterList
    if len>0 then
        for i=len,1,-1 do
            if NumTool.FindIndex(selectList,fitterList[i])>0 then
                table.remove(fitterList,i);
            end
        end
    end
end

function HeroChoiceModel:SetData(selectList,callBack,fitterList)
    self.fitterList=fitterList==nil and {} or fitterList;
    self:FitterList(selectList,self.fitterList)
    SetActive(self.gameObject,true);
    LuaMgr.RemoveUIEventListener(UIEventConst.UpdateHeroList, self.UpdateHeroListBySort)
    self.UpdateHeroListBySort=function()
        self.heroList = self:GetAllCharacter();
        self:SetHeroViewList();
    end
    LuaMgr.AddUIEventListener(UIEventConst.UpdateHeroList, self.UpdateHeroListBySort)
    self.selectList=selectList;
    self.upCallBack=callBack;
    self.heroList = self:GetAllCharacter();
    self:SetHeroViewList();
end


function HeroChoiceModel:GetAllCharacter()
    self.jobType = HeroParameter.paramBool and HeroParameter.jobType or CharacterJob.All
    self.sortType = HeroParameter.paramBool and HeroParameter.sortType or HeroSortType.Level
    self.sequenceType = HeroParameter.paramBool and HeroParameter.sequenceType or SequenceType.FromBigToSmall
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
            if self.jobType == CharacterJob.All or (heroConfig ~= nil and self.jobType == heroConfig.job) then
                if NumTool.FindIndex(self.fitterList,heroConfig.id)<=0 then
                    heroDic[tempData.heroID] = tempData
                end
            end
        end
    end
    local heroList = {}
    for key, value in pairs(heroDic) do

            table.insert(heroList, value)

    end

    if #heroList > 1 then
        if self.sortType == HeroSortType.Level then
            table.sort(heroList, SeasonSLGMapMgr.LevelSort)
        elseif self.sortType == HeroSortType.Rare then
            table.sort(heroList, SeasonSLGMapMgr.RareSort)
        elseif self.sortType == HeroSortType.Star then
            table.sort(heroList, SeasonSLGMapMgr.StarSort)
        elseif self.sortType == HeroSortType.Time then
            table.sort(heroList, SeasonSLGMapMgr.TimeSort)
        end
    end
    return heroList
end

function HeroChoiceModel:UpdateHeroListSelectState()
    local selectList={};
    for i = #self.heroList, 1, -1 do
        local findIndex = NumTool.FindIndex(self.selectList, self.heroList[i].id)
        if findIndex > 0 then
            self.heroList[i].selected = true;
            self.heroList[i].selectIndex = findIndex;
            table.insert(selectList, self.heroList[i]);
            table.remove(self.heroList, i)
        else
            self.heroList[i].selected = false;
        end
    end
    local newHeroList = {};
    for i=#selectList, 1,-1 do
        table.insert(newHeroList,selectList[i])
    end
    for _, v in ipairs(self.heroList) do
        table.insert(newHeroList, v)
    end
    self.heroList=newHeroList;
end


function HeroChoiceModel:SetHeroViewList()
    self.heroScrollView:Clear();
    self:UpdateHeroListSelectState();
    SetActive(self.goNone,#self.heroList==0);
    self.heroGroupList = {}
    for i = 1, #self.heroList, 4 do
        local group = {}
        for j = i, math.min(i + 3, #self.heroList) do
            table.insert(group, self.heroList[j])
        end
        table.insert(self.heroGroupList, group)
    end
    local CallBack=function(groupIndex,locIndex)
        local index=(groupIndex-1)*4+locIndex
       self:HeadClickCallBack(index);
    end
    local list={}
    for i,v in ipairs(self.heroGroupList) do
        local groupList={
            groupIndex=i,
            list=v,
            headItemObj=self.goHeadItem,
            callBack=CallBack
        }
        local groupListData=UIScrollData.GetData(self.goHeadListGroup,"HeroHeadGroup",493,100,groupList)
        table.insert(list,groupListData);
    end
    self.heroScrollView:SetParams(385,410)
    self.heroScrollView:SetData(list);
end

function HeroChoiceModel:HeadClickCallBack(index)
    local dataItem=self.heroList[index];
    if SeasonSLGMapMgr.CheckCharacterIsDispatching(dataItem.id) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("HeroChoiceModel_0"))
        return;
    end
    if dataItem.selected then
        local findIndex=NumTool.FindIndex(self.selectList,dataItem.id)
        if findIndex>0 then
            table.remove(self.selectList,findIndex);
        end
    else
        if #self.selectList>=6 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("HeroChoiceModel_1"));
            return;
        end
        table.insert(self.selectList,dataItem.id);
    end
    if self.upCallBack~=nil then
        self.upCallBack(self.selectList);
    end
    self:SetHeroViewList();
end

function HeroChoiceModel:Clear()
    self.heroScrollView:Clear();
    UIScrollView.ClearItem("HeroHeadGroup")
    self.heroList={};
    SetActive(self.gameObject,false);
    LuaMgr.RemoveUIEventListener(UIEventConst.UpdateHeroList, self.UpdateHeroListBySort)
    self.data = nil;
    self.selectList={};
end

function HeroChoiceModel:Destroy()
    self.heroScrollView:Clear();
    UIScrollView.ClearItem("HeroHeadGroup")
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end