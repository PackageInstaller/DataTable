BrilliantGift_progressItem = {};

BrilliantGift_progressItem.__index = BrilliantGift_progressItem;

local objs = {
    count={path="count",type="Text"},
    iconSprite={path="iconBtn",type="Image"},
    iconBtn={path="iconBtn",type="Button"},
    doneObj={path="done",type="GameObject"},
}
function BrilliantGift_progressItem.New()
    local self = {};
    setmetatable(self, BrilliantGift_progressItem);
    return self;
end

function BrilliantGift_progressItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.iconBtn, function()
        if self.data.progressCallBack~=nil then
            self.data.progressCallBack(self.data.index)
        end
    end)
end

function BrilliantGift_progressItem:SetData(pdata)
    self.data=pdata.data
    self.iconSprite.sprite=LuaMgr.GetSprite("BrilliantGift","ui_yc_hz_lb0"..self.data.state);
    self.count.text=self.data.pro;
    SetActive(self.doneObj,self.data.state==3);
   
end
function BrilliantGift_progressItem:Clear()
   self.data=nil
end
function BrilliantGift_progressItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
   
end

