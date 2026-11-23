
MiniGameSportsExperrtsSlot = {};
MiniGameSportsExperrtsSlot.__index = MiniGameSportsExperrtsSlot
function MiniGameSportsExperrtsSlot.New(prefab, parent, click)
    local self = {}
    setmetatable(self, MiniGameSportsExperrtsSlot)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    local uiLink = self.gameObject:GetComponent("UILink");
    self.textName = uiLink:Get("textName"):GetComponent("Text");
    self.textPuzzleIntorduce = uiLink:Get("textPuzzleIntorduce"):GetComponent("Text");
    self.goCoverImage = uiLink:Get("goCoverImage");
    self.goClickIcon = uiLink:Get("goClickIcon");
    self.btnClick = uiLink:Get("btnClick"):GetComponent("Button");
    self.isSelect = false;
    self.chipId = nil;
    self.slotIndex = nil;
    self.clickFun = click;
    self.animator=self.gameObject:GetComponent("Animator")
    uiLink:AddClickEvent("btnClick", function()
        self.clickFun(self);
    end)
    return self
end

function MiniGameSportsExperrtsSlot:SetData(id, index)

    self.chipId = id;
    self.slotIndex = index
    self.goCoverImage:GetComponent("Image").sprite = LuaMgr.GetSprite("MiniGameSportsExperts",
    "ui_sx_yddr_kk_" .. tostring(index + 1));
    
local item                 = ConfigMgr.Config.itemMap[id];
    self.textName.text         = LuaMgr.GetLangText(item.nameLan);
    self.textPuzzleIntorduce.text=LuaMgr.GetLangText(CollectorPracticeMgr.GetCardInfoByItemId(id).NameLan);
end

function MiniGameSportsExperrtsSlot:Select(toSelectState)
if toSelectState then
        self.animator.enabled=true
        self.animator:Play("UI_SportExpertsSlot_01",0,0);
        self.isSelect = true;
    else
        self.animator.enabled=false;
        SetActive(self.goClickIcon, false);
        self.isSelect = false;
    end
end

function MiniGameSportsExperrtsSlot:Open()
    self.animator.enabled=true
    self.animator:Play("UI_SportExpertsSlot_02",0,0);
end

function MiniGameSportsExperrtsSlot:SetCoverImage(state)
    self.animator.enabled=false;
    SetActive(self.goCoverImage,state);
end

function MiniGameSportsExperrtsSlot:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil
    self.transform = nil
    self.textName = nil;
    self.textPuzzleIntorduce = nil;
    self.goCoverImage = nil;
    self.goClickIcon = nil;
    self.btnClick = nil;
end