
Rank_BossItem = {};

Rank_BossItem.__index = Rank_BossItem;
local objs = {
    goFirst = { path = "root/rank/frist", type = "GameObject" },
    goSecond = { path = "root/rank/second", type = "GameObject" },
    goThird = { path = "root/rank/thrid", type = "GameObject" },
    goOther={ path = "root/rank/other", type = "GameObject" },
    txtOther={ path = "root/rank/other/num", type = "Text" },
    txtName={ path = "root/name", type = "Text" },
    goLike={ path = "root/liked/like", type = "GameObject" },
    rawHeadIcon={ path = "root/headInfo/Icon", type = "RawImage" },
    imgFrame={ path = "root/headInfo/Frame", type = "Image" },
    dynamicAvatar={ path = "root/headInfo/DynamicAvatar", type = "PlayerDynamicAvatar" },
    txtScore={ path = "root/score", type = "Text" },
    tranHeroList={ path = "root/heroList", type = "Transform" },
};

function Rank_BossItem.New()
    local self = {};
    setmetatable(self, Rank_BossItem);
    return self;
end

function Rank_BossItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.heroUIList=UIListView.New(self.tranHeroList);



end


function Rank_BossItem:SetData(data)
    self.data=data.data;
    SetActive(self.goFirst,self.data.rankData.Rank==1)
    SetActive(self.goSecond,self.data.rankData.Rank==2)
    SetActive(self.goThird,self.data.rankData.Rank==3)
    SetActive(self.goOther,self.data.rankData.Rank>=4)
    self.txtOther.text=self.data.rankData.Rank;
    local avatarPath,avatarFrame,isDynamicAvatar=ConfigHelper.GetAvatarAndAvatarFramePath(self.data.rankData.Avatar,self.data.rankData.AvatarFrame)
    if not isDynamicAvatar then
        self.rawHeadIcon.texture=LuaMgr.GetTexture(avatarPath);
    else

        self.dynamicAvatar:AppointAvatar(self.data.rankData.Avatar)
    end
    SetActive(self.dynamicAvatar.gameObject,isDynamicAvatar)
    SetActive(self.rawHeadIcon.gameObject,not isDynamicAvatar)
    PlayerAvatarFrameTool.SetAvatarFrame(self.imgFrame, avatarFrame)
    self.txtName.text=self.data.rankData.Name;
    self.txtScore.text=self.data.rankData.Score;
    self:SetMembers();
end

function Rank_BossItem:SetMembers()
    self.heroUIList:Clear();
    local memberList={}
    for i,v in pairs(self.data.rankData.Members) do
        v.id=i;
        v.rare=SeasonSLGMapMgr.GetOtherPlayerCharacterRare(i,v.RareLevel);
        table.insert(memberList,v);
    end
    table.sort(memberList,function(a, b)
        if not IsNullOrEmpty(a.Sort) and not IsNullOrEmpty(b.Sort) then
            return tonumber(a.Sort) < tonumber(b.Sort)
        end
        if a.Level==b.Level then
            if a.SeasonalLevel==b.SeasonalLevel then
                return a.rare>b.rare;
            end
            return a.SeasonalLevel>b.SeasonalLevel
        else
            return a.Level>b.Level
        end
    end)
    local list={}
    for i,v in pairs(memberList) do
        local memberItem={
            id=v.id,
            level=v.Level,
            sLevel=v.SeasonalLevel,
            rare=v.rare,
        }
        local memberData=UIListData.GetData(self.data.headItemObj,"Rank_HeadItem",memberItem);
        table.insert(list,memberData);
    end
    self.heroUIList:SetData(list);
end

function Rank_BossItem:Clear()
    self.data=nil;
    self.heroUIList:Clear();
end

function Rank_BossItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end