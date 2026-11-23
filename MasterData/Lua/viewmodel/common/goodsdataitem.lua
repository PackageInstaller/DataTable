







































GoodsDataItem = {}
GoodsDataItem.__index = GoodsDataItem

local objs = {
    rareGO = { path = "Rare", type = "GameObject" },
    rare = { path = "Rare", type = "Image" },
    icon = { path = "Icon", type = "RawImage" },
    newRed = { path = "NewRed", type = "GameObject" },
    jobRoot={ path = "Equip/Image", type = "GameObject" },
    jobIcon = { path = "Equip/Image/jobIcon", type = "Image" },
    starRoot = { path = "Equip/Stars", type = "RectTransform" },
    goodsRoot = { path = "Goods", type = "GameObject" },
    countRoot={path = "Goods/Count", type = "GameObject"},
    countRect = { path = "Goods/Count", type = "RectTransform" },
    countText = { path = "Goods/Count/Text", type = "Text" },
    timeRoot = { path = "Goods/Time", type = "RectTransform" },
    timeText1 = { path = "Goods/Time/Text1", type = "Text" },
    timeText2 = { path = "Goods/Time/Text2", type = "Text" },
    goodsBtn = { path = "Goods/Btn", type = "UIButtonClick" },
    iconBg = { path = "Goods/iconBg", type = "Image" },
    littleIcon = { path = "Goods/iconBg/icon", type = "RawImage" },
    iconBgTr = { path = "Goods/iconBg", type = "GameObject" },

    equipRoot = { path = "Equip", type = "GameObject" },
    levelText = { path = "Equip/Level", type = "Text" },
    lockState = { path = "Equip/State/Lock", type = "GameObject" },
    usingState = { path = "Equip/State/Using", type = "GameObject" },
    equipBtn = { path = "Equip/Btn", type = "UIButtonClick" },
    choose = { path = "Equip/Choose", type = "GameObject" },
    attrState = { path = "Equip/State/AttrLock", type = "GameObject" },
    lockImg = { path = "Equip/State/AttrLock", type = "Image" },
}

local TableInsert = table.insert
GoodsDataItem.New = function(container,object)

    local self = {}
    setmetatable(self, GoodsDataItem)
    self.container = container
    if object == nil then
        self.prefabPath = "Assets/_BundleResources/UI/Common/GoodsDataItem.prefab"
        self.object = LuaMgr.GetPrefab(self.prefabPath)
        LuaMgr.AddPrefabRefCount(self.prefabPath)
    else
        self.prefabPath = ""
        self.object = LuaMgr.InstantiateGO(object, container, false)
    end
    self.gameObject = self.object
    self.transform = self.object.transform
    self.transform:SetParent(container, false)
    self.transform.anchoredPosition = Vector2.zero
    self.rectTransform = self.transform:GetComponent("RectTransform")
    UITool.Parse(self.object,self,objs)
    self.stars = {}
    for i = 1, 6 do
        TableInsert(self.stars,self.transform:Find("Equip/Stars/Star"..i).gameObject)
    end
    

    self.GoodsCommand = function()
        HeroRedDataHelper.ClearBackPackGiftRed(self.data.id,true)
        if self.newRed.activeSelf == true then
            self.newRed:SetActive(false)
        end

        local itemConfig = ConfigMgr.Config.itemMap[self.itemId]
        
        if itemConfig.Poke == 1 then
            return
        end
        


        if self.time ~= nil then
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,self.itemId,true,true,true,self.time)
        elseif self.time == nil and self.data.type == 11 then
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,self.itemId,false,false,false,0)
        else
            if self.isHave == nil then
                LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,self.itemId,true,true,true)
            else
                LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,self.itemId,false,false,false)
            end
        end
    end
    

    self.EquipCommand = function()
        HeroRedDataHelper.ClearBackPackGiftRed(self.data.id,false)
        if self.newRed.activeSelf == true then
            self.newRed:SetActive(false)
        end

        if self.state then
            self:ChooseEquip()
        else
            local isVisiable=true
            if self.data.isVisiable~=nil then
                isVisiable=self.data.isVisiable
            end
            LuaMgr.ShowPanel(UIName.WeaponTipsViewModel,self.data.id,self.data.characterId,isVisiable)
        end
    end
    LuaMgr.AddClick(self.goodsBtn,self.GoodsCommand)
    LuaMgr.AddClick(self.equipBtn,self.EquipCommand)
    return self
end


function GoodsDataItem:SetData(index,data,type,state,scale,isHave,disableCount,isPreview)
    if type==1 and ConfigMgr.Config.equipments[data.id]~=nil then
        self:SetEquipConfig(data.id,scale)
        return;
    end
    self.index = index
    self.data = data
    self.state = state
    self.isHave = isHave
    SetActive(self.countRoot,disableCount==nil or not disableCount)
    self.rare.sprite = GetRareSprite(data.rare)
    if type == 1 then
        self:RefreshGoodsData()
        if isPreview~=nil then
            self.newRed:SetActive(HeroRedDataHelper.backPack_giftRedList[self.data.id] ~= nil)
        end
    elseif type == 2 then
        self:RefreshEquipData()
        if isPreview~=nil then
            self.newRed:SetActive(HeroRedDataHelper.backpack_equipRedList[self.data.id] ~= nil)
        end
    end
    self.goodsRoot:SetActive(type == 1)
    self.equipRoot:SetActive(type == 2)
    self.rectTransform.localScale = scale == nil and Vector3.one or scale
    self.countRect.localScale = isHave == nil and Vector3.one or Vector3(1.4,1.4,1)
    self.object:SetActive(true)
end




function GoodsDataItem:SetEquipConfig(equipId,scale)
    local equipConfig = ConfigMgr.Config.equipments[equipId]
    self.index=1
    self.data=equipConfig
    self.state=false
    self.isHave=false
    self.rare.sprite = GetRareSprite(equipConfig.rare)
    SetActive(self.countRoot,false)
    self.goodsRoot:SetActive(false)
    self.equipRoot:SetActive(true)
    self.rectTransform.localScale = scale == nil and Vector3.one or scale
    self.countRect.localScale =Vector3(1.4,1.4,1)
    self.object:SetActive(true)
    

    self.itemId = equipId
    self.lockState:SetActive(false)
    self.usingState:SetActive(false)
    SetActive(self.jobRoot,false);
    local texture=GetItemTexture(self.itemId);
    if IsObjectNull(texture) then
        self.icon.texture = GetItemTexture(self.data.Icon)
    else
        self.icon.texture = GetItemTexture(self.itemId)
    end

    self.choose:SetActive(false)
end



function GoodsDataItem:RefreshGoodsData()
    self.itemId = self.data.id
    if self.data.counts == nil then
        self.countText.text = LuaMgr.NumFormat(self.data.count0)
    else
        self.time = self.data.counts[1][2]
        self.countText.text = LuaMgr.NumFormat(self.data.counts[1][1])
        local timeStr = ConfigHelper.GoodsTime(self.time)
        self.timeText1.text,self.timeText2.text = timeStr,timeStr
    end
    
    self.timeRoot.localScale = self.data.counts == nil and Vector3.zero or Vector3.one


   local texture=GetItemTexture(self.itemId);
    if IsObjectNull(texture) then
        self.icon.texture = GetItemTexture(self.data.Icon)
    else
        self.icon.texture = GetItemTexture(self.itemId)
    end

    


    local itemTexture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/ItemIcons/itemicon_home_%s.png", self.itemId))
    if itemTexture ~= nil then
        self.iconBgTr:SetActive(true)
        self.iconBg.sprite = LuaMgr.GetSprite("Backpack", "ui_ty_daoju_yuan" .. self.data.rare)
        self.littleIcon.texture = itemTexture
    else
        self.iconBgTr:SetActive(false)
    end
end


function GoodsDataItem:SetIconBg(status)
    SetActive(self.iconBgTr, status);
end


function GoodsDataItem:SetRareBg(status)
    SetActive(self.rareGO, status);
end


function GoodsDataItem:SetCount(count, pos, scale)
    if (count ~= nil) then
        self.countText.text = count;
    end
    if (scale ~= nil) then
        self.countRect.localScale = scale;
    end
    if (pos ~= nil) then
        self.countRect.anchoredPosition = pos;
    end 
end


function GoodsDataItem:RefreshEquipData()
    SetActive(self.jobRoot,true);
    self.itemId = self.data.equipmentId
    self.levelText.text = "lv."..self.data.level
    self.lockState:SetActive(self.data.locking)
    self.usingState:SetActive(self.data.characterId ~= "")
    for i = 1, #self.stars do
        self.stars[i]:SetActive(i <= self.data.star)
    end
    local attrLockNum = 0
    if type(self.data.additionalAttrs) ~= "function" and not TableIsNull(self.data.additionalAttrs) then
        for i = 1, #self.data.additionalAttrs do
            if self.data.additionalAttrs[i].lock then
                attrLockNum = attrLockNum + 1
            end
        end
    end
    if attrLockNum > 0 then
        self.lockImg.sprite = LuaMgr.GetSprite("Backpack","attrLock_"..attrLockNum)
    end
    SetActive(self.attrState,attrLockNum > 0)

    local equipConfig = ConfigMgr.Config.equipments[ self.itemId]
    self.jobIcon.sprite=LuaMgr.GetSprite("JobIcon","jobtips_"..equipConfig.job);
    self.starRoot.sizeDelta=self.data.star<=2 and Vector2(125,35) or Vector2(100,35)
    local texture=GetItemTexture(self.itemId);
    if IsObjectNull(texture) then
        self.icon.texture = GetItemTexture(self.data.Icon)
    else
        self.icon.texture = GetItemTexture(self.itemId)
    end

    self.choose:SetActive(self.data.choose)
end

function GoodsDataItem:ChooseEquip()
    LuaMgr.InvokeUIEventListeners(UIEventConst.backpackSplitEvent,self)
end

function GoodsDataItem:Hide()
    self.itemId = ""
    self.data = nil
    self.isHave = nil
    self.object:SetActive(false)
end

function GoodsDataItem:Clear()
    self.itemId = ""
    self.data = nil
    self.isHave = nil
    self.container = nil
    self.rectTransform = nil
    self.rare = nil
    self.icon = nil
    self.newRed = nil
    self.goodsRoot = nil
    self.goodsBtn = nil
    self.equipRoot = nil
    self.equipBtn = nil
    self.isCount=nil
    self.jobRoot=nil;
    if not IsNullOrEmpty(self.prefabPath) then
        LuaMgr.RemovePrefabRefCount(self.prefabPath)
    end
    self.transform = nil
    LuaMgr.DestroyImmediateGO(self.object)
    self.object = nil
end 