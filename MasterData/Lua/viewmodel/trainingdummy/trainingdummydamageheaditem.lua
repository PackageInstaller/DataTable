TrainingDummyDamageHeadItem = {};

TrainingDummyDamageHeadItem.__index = TrainingDummyDamageHeadItem;

local objs = {
    Icon = { path = "Icon", type = "RawImage" },
    Frame = { path = "Frame", type = "Image" },
    Job = { path = "Job", type = "Image" },
    Slider = { path = "Slider", type = "Slider" },
    Ratio = { path = "Ratio", type = "Text" },
}

function TrainingDummyDamageHeadItem.New()
    local self = {};
    setmetatable(self, TrainingDummyDamageHeadItem);
    return self;
end

function TrainingDummyDamageHeadItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function TrainingDummyDamageHeadItem:SetData(pdata)
    self.data = pdata;
    
    self.Icon.texture = self.data.icon
    self.Frame.sprite = self.data.rare
    self.Job.sprite = self.data.job
    self.Slider.value = self.data.ratio
    self.Ratio.text = math.floor(self.data.ratio * 100) .. "%"
    SetActive(self.gameObject,true);
end

function TrainingDummyDamageHeadItem:Hide()
    SetActive(self.gameObject,false);
end

function TrainingDummyDamageHeadItem:Clear()
    self.data = nil;
end

function TrainingDummyDamageHeadItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end