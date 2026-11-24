SmallMapBlockItem = {};

SmallMapBlockItem.__index = SmallMapBlockItem;
local objs = {
    root={ path = "root", type = "Transform" },
    bgBtn = { path = "root/BG", type = "Button" },
    numText={ path = "root/Image/Text", type = "Text" },
    numImgGo={ path = "root/Image", type = "GameObject" },
    progressRoot={ path = "root/ProgressItem", type = "Transform" },
    imgBG={ path = "root/_BG", type = "Image" },
    imgBGGO={ path = "root/BG", type = "GameObject" },
};

function SmallMapBlockItem.New()
    local self = {};
    setmetatable(self, SmallMapBlockItem);
    return self;
end

function SmallMapBlockItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self:Register();
end

function SmallMapBlockItem:Register()
    self.OnCickGrid = function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data);
        end
    end
    LuaMgr.AddClick(self.bgBtn, self.OnCickGrid);
end

function SmallMapBlockItem:SetData(data)
    self.data = data.data;
    self.transform.localScale=Vector3.one
    self.gameObject.name = self.data.index
    SetActive(self.numImgGo,false);
    if self.data.name ~= nil then
        SetActive(self.numImgGo,true);
        self.numText.text=self.data.name;
    end
    SetActive(self.progressRoot.gameObject,false);

    local spicon = LuaMgr.GetSprite("SLGSeason",self.data.miniIcon);
    if spicon then
        SetActive(self.imgBGGO,true)
        self.imgBG.sprite=spicon
    else
        SetActive(self.imgBGGO,false)
    end
end

function SmallMapBlockItem:SetProgressItem(gridId,progressData)
    SetActive(self.progressRoot.gameObject,true);
    if self.ProgressItem==nil then
        self.ProgressItem=SmallProgressItem.New(self.progressRoot)
    end


    local data={
        gridId=gridId,
        functionId=progressData.FunctionId,
        progress=progressData.Progress,
    }
    self.ProgressItem:SetData(data)
end


function SmallMapBlockItem:Clear()
    self.data = nil;
    if self.ProgressItem~=nil then
        self.ProgressItem:Clear();
    end




end

function SmallMapBlockItem:Destroy()
    if self.ProgressItem~=nil then
        self.ProgressItem:Destroy();
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end