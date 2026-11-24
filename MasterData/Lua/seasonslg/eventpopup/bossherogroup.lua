BossHeroGroup = {};

BossHeroGroup.__index = BossHeroGroup;
local objs = {
    txtName={ path = "root/formatiom/name", type = "Text" },
    txtScore={ path = "root/formatiom/score/value", type = "Text" },
    tfList={ path = "root/formatiom/tranContent", type = "Transform" },
    goCur={ path = "root/formatiom/selcet", type = "GameObject" },
    goDone={ path = "root/formatiom/done", type = "GameObject" },
};

function BossHeroGroup.New()
    local self = {};
    setmetatable(self, BossHeroGroup);
    return self;
end

function BossHeroGroup:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.heroUIList=UIListView.New(self.tfList);
end


function BossHeroGroup:SetData(data)
    self.data = data.data;
    self.txtScore.text=self.data.score;
    self.txtName.text=string.format(LuaMgr.GetLangText("BossHeroGroup_0"),self.data.index)
    SetActive(self.goCur,self.data.select);
    SetActive(self.goDone,not self.data.select);
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
            local heroCfg=table.Copy(ConfigMgr.Config.characterTable[memberId]);
            if IsNullOrEmpty(uid) then
                local actorConfig = ConfigMgr.Config.actor[memberId]
                if actorConfig==nil  then
                    heroData=DataMgr.Player.characters[memberId];
                    heroCfg.rare=HeroMgr.GetHeroNowRare(memberId)
                else
                    heroData={id=actorConfig.CharacterId,
                              level=actorConfig.Level,
                              sLevel=actorConfig.SeasonalLevel,}
                    heroCfg=ConfigMgr.Config.characterTable[actorConfig.CharacterId];
                end
            else
                heroData=PlayerAssistMgr.GetAssist_Character(uid,memberId)
                heroCfg.rare=HeroMgr.GetHeroNowRare(memberId,uid)
            end
            local heroItem={
                index=i,
                id=heroData.id,
                rare=heroCfg.rare>4 and 4 or heroCfg.rare,
                job=heroCfg.job,
                name="",
                level=heroData~=nil and heroData.level or nil,
                sLevel=(heroData ==nil and heroData.sLevel==nil) and SeasonSLGMapMgr.GetCharacterSeasonLevel(memberId) or heroData.sLevel ,
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

function BossHeroGroup:Clear()
    self.data = nil;
    self.heroUIList:Clear();
end

function BossHeroGroup:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end