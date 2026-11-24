
Rank_ResourceItem = {};

Rank_ResourceItem.__index = Rank_ResourceItem;
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

};

function Rank_ResourceItem.New()
    local self = {};
    setmetatable(self, Rank_ResourceItem);
    return self;
end

function Rank_ResourceItem:Init()
    UITool.Parse(self.gameObject, self, objs);



end


function Rank_ResourceItem:SetData(data)
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
    self.txtProduct.text=LuaMgr.NumFormat(self.data.rankData.Score);

end

function Rank_ResourceItem:Clear()
    self.data=nil;
end

function Rank_ResourceItem:Destroy()

    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end