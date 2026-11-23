WalkMount_PoemRewardItem = {};

WalkMount_PoemRewardItem.__index = WalkMount_PoemRewardItem;
local objs = {
    bgSprite={ path = "goods/bg", type = "Image" },
    icon = { path = "goods/bg/icon", type = "RawImage" },
    btnBg={ path = "goods/bg", type = "Button" },
}

local itemId=nil

function WalkMount_PoemRewardItem.New()
    local self = {};
    setmetatable(self, WalkMount_PoemRewardItem);
    return self;
end

function WalkMount_PoemRewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.LotteryMap=ConfigMgr.Config.LotteryMap
end

function WalkMount_PoemRewardItem:SetData(pdata)
    self.data = pdata.data;
    itemId=pdata.data.reward.id;
    local rare=ConfigMgr.Config.itemMap[itemId].rare
    self.bgSprite.sprite=LuaMgr.GetSprite("WalkMount","hd_sgwcs_tc_dj"..rare)
    self.icon.texture=ConfigHelper.GetItemTexture(pdata.data.reward.id)
    self.ShowItemTip=function()
        LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,self.data.reward.id,false,false,false)
    end
    LuaMgr.AddClick(self.btnBg,self.ShowItemTip)
end


function WalkMount_PoemRewardItem:Clear()
    self.data = nil;
    itemId=nil
    LuaMgr.RemoveClick(self.btnBg,self.ShowItemTip)
end

function WalkMount_PoemRewardItem:Destroy()
    self.textName=nil;
    self.goodsRoot=nil;
    self.rewardedObj=nil
    itemId=nil
    LuaMgr.DestroyImmediateGO(self.gameObject);
end