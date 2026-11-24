
BossQSpine = {};

BossQSpine.__index = BossQSpine;
local objs = {
    uiSpineCharacter = { path = "root/qSpine", type = "UISpineCharacter" },
    bossName = { path = "root/goBossName/bossName", type = "Text" },
    goProgress = { path = "root/goProgress", type = "GameObject" },
    progress = { path = "root/goProgress/Image/progress", type = "Image" },
    progressText = { path = "root/goProgress/progressText", type = "Text" },
};

function BossQSpine.New(parent,gridIndex)
    local self = {};
    setmetatable(self, BossQSpine);
    self.parent=parent;
    self.prefabPath = "Assets/_BundleResources/UI/SeasonSLG/BossItem.prefab"
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath)
    self.transform=self.gameObject.transform;
    self.transform:SetParent(parent,false);
    self.transform.localScale=Vector3.one;
    self.bindGridIndex=tonumber(gridIndex)







    self.bindGridLocalPosition=SeasonSLGMapMgr.GetBlockPositionByIndex(self.bindGridIndex, true)
    self:Init();
    return self;
end

function BossQSpine:Init()
    UITool.Parse(self.gameObject, self, objs);



end

function BossQSpine:SetData(data)
    self.data=data;
    self.bossName.text = SeasonSLGMapMgr.GetGridName(self.bindGridIndex)
    self.vector=self.data.pos-self.bindGridLocalPosition
    self.transform.anchoredPosition = self.data.pos;
    self.transform.localScale=Vector3.one*self.data.scale;
    SetActive(self.uiSpineCharacter.gameObject,true);
    self.uiSpineCharacter:SetBattleBoss(self.data.spineId,self.data.skinId,self.data.tCameraPos,self.data.tCameraSize);
    local progressData = {}
    progressData.showProgressTime = false
    progressData.maxProgress = 100
    progressData.Progress = 100
    if progressData.Progress <= 0 then
        SetActive(self.goProgress,false)
    else
        SetActive(self.goProgress,true)
        local value = progressData.maxProgress / progressData.Progress
        self.progress.fillAmount = value
        self.progressText.text = string.format("%.1f%%",value*100);
    end
end

function BossQSpine:DOScaleBOSS()
    local gridNowPosition=SeasonSLGMapMgr.GetBlockPositionByIndex(self.bindGridIndex)
    local scale=SeasonSLGMapMgr.gridScale;
    self.transform.localScale=Vector3.one*self.data.scale*scale;
    self.transform.anchoredPosition=gridNowPosition+self.vector*scale;
end

function BossQSpine:Clear()
    self.uiSpineCharacter:Clear();
    SetActive(self.uiSpineCharacter.gameObject,false);
end

function BossQSpine:Destroy()
    self.uiSpineCharacter:Clear();
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end