Boss2HeroTeam = {};

Boss2HeroTeam.__index = Boss2HeroTeam;
local objs = {
    txtName={ path = "root/name", type = "Text" },
    txtScore={ path = "root/score", type = "Text" },
    tfList={ path = "root/list", type = "Transform" },
    goSelect={ path = "root/SelectedFlag", type = "GameObject" },
};

function Boss2HeroTeam.New()
    local self = {};
    setmetatable(self, Boss2HeroTeam);
    return self;
end

function Boss2HeroTeam:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.heroUIList=UIListView.New(self.tfList);
end


function Boss2HeroTeam:SetData(data)
    self.data = data.data;
    self.txtScore.text=self.data.score;
    self.txtName.text=string.format(LuaMgr.GetLangText("Boss2HeroTeam_0"),self.data.index)
    SetActive(self.goSelect,self.data.select);
    self.heroUIList:Clear();
    local list={};
    local HeadCallBack=function(index)
        if self.data.callBack~=nil then
            self.data.callBack(self.data.groupIndex,index);
        end
    end;
    for i=1,6 do
        local memberId=self.data.members[tostring(i-1)];
        if not IsNullOrEmpty(memberId) then
            local uid= self.data.helps[tostring(i-1)];
            local heroData=nil;
            local heroCfg=ConfigMgr.Config.characterTable[memberId];
            if IsNullOrEmpty(uid) then
                heroData=DataMgr.Player.characters[memberId];
            else
                heroData=PlayerAssistMgr.GetAssist_Character(uid,memberId)
            end
            local heroItem={
                index=i,
                id=heroData.id,
                rare=heroCfg.rare,
                job=heroCfg.job,
                name="",
                level=heroData.level,
                sLevel=SeasonSLGMapMgr.GetCharacterSeasonLevel(heroData.id),
                select=false,
                selectIndex=0,
                callBack=HeadCallBack,
            }
            local heroItemData=UIListData.GetData(self.data.heroItemObj,"HeroHeadItem",heroItem);
            table.insert(list,heroItemData);
        else
            local heroItem={
                index=i,
                id="",
                rare=nil,
                job=nil,
                name="",
                level=nil,
                sLevel=nil,
                select=false,
                selectIndex=0,
                callBack=HeadCallBack,
            }
            local heroItemData=UIListData.GetData(self.data.heroItemObj,"HeroHeadItem",heroItem);
            table.insert(list,heroItemData);
        end
    end
    self.heroUIList:SetData(list);
end

function Boss2HeroTeam:Clear()
    self.data = nil;
    self.heroUIList:Clear();
end

function Boss2HeroTeam:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end