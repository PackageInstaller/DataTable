LuckyDraw_LayoutGroup = {};

LuckyDraw_LayoutGroup.__index = LuckyDraw_LayoutGroup;

local objs = {
    imgTitle={path="root/title",type="Image"},
    tranContent={path="root/content",type="Transform"},
}

function LuckyDraw_LayoutGroup.New()
    local self = {};
    setmetatable(self, LuckyDraw_LayoutGroup);
    return self;
end

function LuckyDraw_LayoutGroup:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.itemUIList=UIListView.New(self.tranContent);
end

function LuckyDraw_LayoutGroup:SetData(pdata)
    local dataRecords=DataMgr.Player.drawRewardRecords
    self.data = pdata.data;
    self.transform.anchoredPosition=Vector2(0,self.data.posY)
    self.tranContent.sizeDelta=Vector2(self.data.width,114)
    self.imgTitle.sprite=LuaMgr.GetSprite("LuckyDraw","ui_hd_dgfl_djbt"..self.data.type)
    
    local itemList={}
    for i,v in ipairs(self.data.layoutList) do
        local passCount=dataRecords[self.data.drawId.."_"..v.ID]==nil and 0 or dataRecords[self.data.drawId.."_"..v.ID];
        local item={
            count=v.Time-passCount,
            Reward=v.Reward;
        }
        local itemData=UIListData.GetData(self.data.itemObj,"LuckyDraw_goodItem",item);
        table.insert(itemList,itemData);
    end
    self.itemUIList:SetData(itemList);
end


function LuckyDraw_LayoutGroup:Clear()
    self.data = nil;
    self.itemUIList:Clear();
end


function LuckyDraw_LayoutGroup:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.imgTitle=nil;
    self.tranContent=nil;
end

