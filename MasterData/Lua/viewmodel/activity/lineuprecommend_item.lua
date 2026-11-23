LineupRecommend_Item = {}

LineupRecommend_Item.__index = LineupRecommend_Item

local objs = 
{




}

function LineupRecommend_Item.New()
    local obj = {}
    setmetatable(obj, LineupRecommend_Item)
    return obj
end

function LineupRecommend_Item:Init()
    UITool.Parse(self.gameObject, self, objs)

    self.listView   = UIListView.New(self.gameObject.transform:Find("Content").gameObject.transform)
    self.itemObj    = self.gameObject.transform:Find("template/hero_item").gameObject
end

function LineupRecommend_Item:SetData(d)
    local data = d.data





    self.listView:Clear(true)
    local data_list = {}

    for _, v in ipairs(data.hero_data) do
        local data = UIListData.GetData(self.itemObj, "LineupRecommend_HeroItem", v);
        table.insert(data_list, data)
    end

    self.listView:SetData(data_list, true)
end

function LineupRecommend_Item:Clear()
    self.listView:Clear()
end

function LineupRecommend_Item:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    UIListView.ClearItem("LineupRecommend_HeroItem")
    self.gameObject = nil




    self.listView        = nil
    self.itemObj         = nil
end