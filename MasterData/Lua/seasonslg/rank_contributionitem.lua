
Rank_ContributionItem = {};

Rank_ContributionItem.__index = Rank_ContributionItem;
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
    txtProduct={ path = "root/bg/product", type = "Text" },
    txtProgress={ path = "root/progress", type = "Text" },
    goHeadInfo={ path = "root/headInfo", type = "GameObject" },
};

function Rank_ContributionItem.New()
    local self = {};
    setmetatable(self, Rank_ContributionItem);
    return self;
end

function Rank_ContributionItem:Init()
    UITool.Parse(self.gameObject, self, objs);



end


function Rank_ContributionItem:SetData(data)
    self.data=data.data;
    SetActive(self.goFirst,self.data.rankData.Rank==1)
    SetActive(self.goSecond,self.data.rankData.Rank==2)
    SetActive(self.goThird,self.data.rankData.Rank==3)
    SetActive(self.goOther,self.data.rankData.Rank>=4)
    SetActive(self.goHeadInfo,not self.data.isGuid)
    self.txtOther.text=self.data.rankData.Rank;
    if not self.data.isGuid then
        local avatarPath,avatarFrame,isDynamicAvatar=ConfigHelper.GetAvatarAndAvatarFramePath(self.data.rankData.Avatar,self.data.rankData.AvatarFrame)
        if not isDynamicAvatar then
            self.rawHeadIcon.texture=LuaMgr.GetTexture(avatarPath);
        else

            self.dynamicAvatar:AppointAvatar(self.data.rankData.Avatar)
        end
        SetActive(self.dynamicAvatar.gameObject,isDynamicAvatar)
        SetActive(self.rawHeadIcon.gameObject,not isDynamicAvatar)
        PlayerAvatarFrameTool.SetAvatarFrame(self.imgFrame, avatarFrame)
    end
    self.txtName.text=self.data.rankData.Name;
    self.txtProduct.text=LuaMgr.NumFormat(self.data.rankData.Score);

end

function Rank_ContributionItem:Clear()
    self.data=nil;
end

function Rank_ContributionItem:Destroy()

    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end