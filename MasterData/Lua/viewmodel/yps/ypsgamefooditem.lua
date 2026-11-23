YPSGameFoodItem = {};

YPSGameFoodItem.__index = YPSGameFoodItem;

local objs = {
    button = { path = "", type = "Button" },
    group = { path = "Group", type = "GameObject" },
    iconTF = { path = "Group/Icon", type = "Transform" },
    icon = { path = "Group/Icon", type = "RawImage" },
    iconAni = { path = "Group/Icon", type = "Animator" },    
    sellOut = { path = "Group/SellOut", type = "GameObject" },
    textName = { path = "Group/TextName", type = "Text" },
    textTime = { path = "Group/TextTime", type = "Text" },
    textNum = { path = "Group/TextNum", type = "Text" },
    zhizuo = { path = "Group/FX_zhizuozhong", type = "GameObject" },
    wancheng = { path = "Group/FX_wancheng", type = "GameObject" },
    textT = { path = "Group/Text", type = "Text" },
}

function YPSGameFoodItem.New(prefab, parent)
    local self = {};
    setmetatable(self, YPSGameFoodItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject.transform:GetComponent("RectTransform");
    self.index = 0;
    self.stopTime = 0
    UITool.Parse(self.gameObject, self, objs);
    self.tween = nil;
    self.OnClickItem = function()
        if (self.isCooking) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29120"))
            return
        end
        if (self.data.num <= 0) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29121"))
            return
        end
        if (self.data.callback ~= nil) then
            self.data.callback()
        end
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
    return self;
end

function YPSGameFoodItem:SetData(index, data)
    self.index = index;
    self.data = data
    self.config = data.config
    self:SetIcon(self.config.Icon);
    self.textName.text = LuaMgr.GetLangText(self.config.NameLan)
    self:ShowItem(true);
    self:SetLight(false);
    self:SetHint(false);
    self:SetStatus()
    self:SetSellOut(self.data.num <= 0)
    self.textT.text = self.config.Id
    self.textNum.text = self.data.num
    self.isCooking = false
    self.stopTime = 0
end

function YPSGameFoodItem:SetIcon(resId)
    self.icon.texture = YPSGameMgr.GetTexture(resId);
end

function YPSGameFoodItem:ShowItem(bShow)
    SetActive(self.group, bShow)
    self.button.enabled = bShow
end

function YPSGameFoodItem:SetStatus()
    SetActive(self.textTime.gameObject, self.data.state == 0)
    SetActive(self.zhizuo.gameObject, self.data.state == 0)

end

function YPSGameFoodItem:SetLight(status)
    self.iconAni.enabled = status;   

end

function YPSGameFoodItem:SetHint(status)
    self.iconTF.localScale = Vector3.one;
    self:ClearTween();
    if (status) then
        self.tween = self.iconTF:DOScale(1.3, 0.5):SetEase(CS.DG.Tweening.Ease.InOutCubic):SetLoops(-1, LoopType.Yoyo);
    end
end

function YPSGameFoodItem:SetSellOut(status)
    SetActive(self.sellOut, status);
    if (status) then
        SetActive(self.wancheng.gameObject, false)
    end
end

function YPSGameFoodItem:UpdateTime(reduceTime)
    if (self.data.state == 0 and self.data.cookStartTime ~= nil) then
        local curTime = LuaMgr.Timestamp()
        local interval = curTime - self.data.cookStartTime       
        if (interval > self.data.cookTime - reduceTime) then
            self.data.state = 1
            self.data.num = self.data.num + self.data.addNum
            self.textNum.text = self.data.num
            self.data.cookStartTime = nil
            self:SetStatus()
            self:SetSellOut(false)
            self.isCooking = false
            SetActive(self.wancheng.gameObject, true)
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/equip_starup.mp3");
            return
        end
        self.isCooking = true
        self.textTime.text = self.data.cookTime - interval - reduceTime
        self:SetSellOut(true)
    end
end

function YPSGameFoodItem:AddStopTime(intervalTime)    
    self.data.cookStartTime = self.data.cookStartTime + intervalTime
end

function YPSGameFoodItem:CostNum(num)
    self.data.num = self.data.num - num
    self.textNum.text = self.data.num
    self:SetSellOut(self.data.num <= 0)

end

function YPSGameFoodItem:ClearTween()
    if (self.tween ~= nil) then
        self.tween:Kill(false);
        self.tween = nil;
    end
end

function YPSGameFoodItem:Clear()
    self.index = 0;
    self.icon.texture = nil;
    self:ClearTween();
end

function YPSGameFoodItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end