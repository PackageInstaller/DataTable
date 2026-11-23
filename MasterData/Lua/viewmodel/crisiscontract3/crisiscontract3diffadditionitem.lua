CrisisContract3DiffAdditionItem = {};

CrisisContract3DiffAdditionItem.__index = CrisisContract3DiffAdditionItem;

local objs = {
    animatorObj = { path = "Group", type = "GameObject" },
    bg_1 = { path = "Group/Bg1", type = "GameObject" },
    bg_2 = { path = "Group/Bg2", type = "GameObject" },
    name_1 = { path = "Group/Bg1/Name", type = "Text" },
    name_2 = { path = "Group/Bg2/Name", type = "Text" },
    desc_1 = { path = "Group/Bg1/Desc", type = "Text" },
    desc_2 = { path = "Group/Bg2/Desc", type = "Text" },
}

function CrisisContract3DiffAdditionItem.New()
    local self = {};
    setmetatable(self, CrisisContract3DiffAdditionItem);
    return self;
end

function CrisisContract3DiffAdditionItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    SetActive(self.animatorObj, false)
end

function CrisisContract3DiffAdditionItem:SetData(pdata)
    self.data = pdata.data
    if self.data.animBool then

        SetActive(self.animatorObj, true)
    end
    SetActive(self.bg_1, self.data.isActivated)
    SetActive(self.bg_2, not self.data.isActivated)
    self.name_1.text = self.data.name
    self.name_2.text = self.data.name
    self.desc_1.text = self.data.desc
    self.desc_2.text = self.data.desc
    
    SetActive(self.gameObject, true)
end

function CrisisContract3DiffAdditionItem:Hide()
    SetActive(self.gameObject, false)
end

function CrisisContract3DiffAdditionItem:Clear()
    self.data = nil
    SetActive(self.animatorObj, false)
end

function CrisisContract3DiffAdditionItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
end