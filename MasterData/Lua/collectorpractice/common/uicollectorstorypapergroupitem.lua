
UICollectorStoryPaperGroupItem = {}

UICollectorStoryPaperGroupItem.__index = UICollectorStoryPaperGroupItem
require("CollectorPractice/Common/UICollectorStoryPaperItem")

local linePos = {
    {
        pos1 = { x = 143, y = -25 },
        pos2 = { x = 127.6, y = -326.9 },
    },
    {
        pos1 = { x = 152.4, y = -2.5 },
        pos2 = { x = 133.2, y = -297.8 },
    },
    {
        pos1 = { x = 154.4, y = -43.6 },
        pos2 = { x = 137.7, y = -324.4 },
    },
    {
        pos1 = { x = 131, y = -12 },
        pos2 = { x = 130, y = -328 },
    },
    {
        pos1 = { x = 151, y = 2 },
        pos2 = { x = 152, y = -306 },
    },
    {
        pos1 = { x = 150, y = -42 },
        pos2 = { x = 138, y = -341 },
    },
}
local lineRotationZ = {
    183.647, 182.676, 185.021, 185.731, 171.891, 174.333, 186.857, 179.337, 183.039, 184.648, 170.809, 172.527,
}
local lineScaleX = {
    1.79038, 1.72018, 1.8213, 1.84076, 1.8213, 1.8213, 1.65762, 1.73023, 1.90809, 1.90924, 1.79038, 1.68284
}
local itemPos = {
    {
        pos1 = { x = 17, y = 148 },
        pos2 = { x = 0, y = -150 },
    },
    {
        pos1 = { x = 7, y = 171 },
        pos2 = { x = 0, y = -122 },
    },
    {
        pos1 = { x = 11, y = 132 },
        pos2 = { x = -11, y = -150 },
    },
    {
        pos1 = { x = 11, y = 163 },
        pos2 = { x = -2, y = -159 },
    },
    {
        pos1 = { x = -3, y = 180 },
        pos2 = { x = 2, y = -130 },
    },
    {
        pos1 = { x = 11, y = 132 },
        pos2 = { x = 0, y = -165 },
    },
}
local itemRotationZ = {
    6, 5, -5, 0, 0, -4, 9, 3, -7, -6, 0, 0
}

local itemType = {
    1, 3, 1, 1, 2, 1, 1, 3, 1, 1, 2, 1
}

function UICollectorStoryPaperGroupItem.New()
    local self = {}
    setmetatable(self, UICollectorStoryPaperGroupItem)
    self.cloneItems = {};
    return self
end

function UICollectorStoryPaperGroupItem:Init()
    local allNum = #self.cloneItems;
    for i = 1, allNum do
        self.cloneItems[i]:Clear();
    end
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.rectLineGroup1 = uiLink:Get("rectLineGroup1"):GetComponent("RectTransform");
    self.rectLineGroup2 = uiLink:Get("rectLineGroup2"):GetComponent("RectTransform");
    self.rectPaperList = uiLink:Get("rectPaperList"):GetComponent("RectTransform");
end













function UICollectorStoryPaperGroupItem:Destroy()
    local allNum = #self.cloneItems;
    for i = 1, allNum do
        self.cloneItems[i]:Destroy();
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.transform = nil
    self.rectLineGroup1 = nil;
    self.rectLineGroup2 = nil;
    self.rectPaperList = nil;
end

function UICollectorStoryPaperGroupItem:Clear()
    self.data = nil;
    SetActive(self.gameObject, false);
end
















function UICollectorStoryPaperGroupItem:SetData(data)

    self.data = data.data.data;
    self.callback=data.data.callback;
    SetActive(self.gameObject, true);
if self.data.index ~= 1 then
        self.rectLineGroup1.anchoredPosition = Vector2(linePos[(self.data.index % 6) + 1].pos1.x,
            linePos[(self.data.index % 6) + 1].pos1.y);
        self.rectLineGroup2.anchoredPosition = Vector2(linePos[(self.data.index % 6) + 1].pos2.x,
            linePos[(self.data.index % 6) + 1].pos2.y);
        self.rectLineGroup1.localScale = Vector3(lineScaleX[(self.data.index % 6) * 2 + 1], 1, 1);
        self.rectLineGroup2.localScale = Vector3(lineScaleX[(self.data.index % 6) * 2 + 2], 1, 1);
        self.rectLineGroup1.localRotation = Quaternion.Euler(0, 0, lineRotationZ[(self.data.index % 6) * 2 + 1]);
        self.rectLineGroup2.localRotation = Quaternion.Euler(0, 0, lineRotationZ[(self.data.index % 6) * 2 + 2]);
    else
        SetActive(self.rectLineGroup1.gameObject, false);
        SetActive(self.rectLineGroup2.gameObject, false);
    end
if self.data.paper1 ~= nil and self.cloneItems[1] == nil then
if self.data.index ~= 1 then
            SetActive(self.rectLineGroup1.gameObject, true);
        end
        local temp1 = UICollectorStoryPaperItem.New(self.rectPaperList);
        temp1:SetData(self.data.paper1, itemType[(self.data.index % 6) * 2 + 1],self.data.questType,true,self.data.index,1,self.callback);
        self.cloneItems[1] = temp1;

        self.cloneItems[1].transform.anchoredPosition = Vector2(itemPos[(self.data.index % 6) + 1].pos1.x,
            itemPos[(self.data.index % 6) + 1].pos1.y);
        self.cloneItems[1].transform.localRotation = Quaternion.Euler(0, 0, itemRotationZ[(self.data.index % 6) * 2 + 1]);

elseif self.data.paper1 ~= nil and self.cloneItems[1] ~= nil then
if self.data.index ~= 1 then
            SetActive(self.rectLineGroup1.gameObject, true);
        end
        self.cloneItems[1]:SetData(self.data.paper1, itemType[(self.data.index % 6) * 2 + 1],self.data.questType,true,self.data.index,1,self.callback);

        self.cloneItems[1].transform.anchoredPosition = Vector2(itemPos[(self.data.index % 6) + 1].pos1.x,
            itemPos[(self.data.index % 6) + 1].pos1.y);
        self.cloneItems[1].transform.localRotation = Quaternion.Euler(0, 0, itemRotationZ[(self.data.index % 6) * 2 + 1]);

    end


if self.data.paper2 ~= nil and self.cloneItems[2] == nil then
        if self.data.index ~= 1 then
            SetActive(self.rectLineGroup2.gameObject, true);
        end
        local temp2 = UICollectorStoryPaperItem.New(self.rectPaperList);
        temp2:SetData(self.data.paper2, itemType[(self.data.index % 6) * 2 + 2],self.data.questType,true,self.data.index,2,self.callback);
        self.cloneItems[2] = temp2;

        self.cloneItems[2].transform.anchoredPosition = Vector2(itemPos[(self.data.index % 6) + 1].pos2.x,
            itemPos[(self.data.index % 6) + 1].pos2.y);
        self.cloneItems[2].transform.localRotation = Quaternion.Euler(0, 0, itemRotationZ[(self.data.index % 6) * 2 + 2]);

    elseif self.data.paper2 ~= nil and self.cloneItems[2] ~= nil then
if self.data.index ~= 1 then
            SetActive(self.rectLineGroup2.gameObject, true);
        end
        self.cloneItems[2]:SetData(self.data.paper2, itemType[(self.data.index % 6) * 2 + 2],self.data.questType,true,self.data.index,2,self.callback);

        self.cloneItems[2].transform.anchoredPosition = Vector2(itemPos[(self.data.index % 6) + 1].pos2.x,
            itemPos[(self.data.index % 6) + 1].pos2.y);
        self.cloneItems[2].transform.localRotation = Quaternion.Euler(0, 0, itemRotationZ[(self.data.index % 6) * 2 + 2]);

    end
    RedMgr.Singleton:Refresh();
end