Delegate_RewardItem = {};

Delegate_RewardItem.__index = Delegate_RewardItem;

local objs = {
    rootObj={path="root",type="GameObject"},
    bgObj={path="BG",type="GameObject"},
    goodRoot={path = "root/GoodsItem", type = "Transform"},
    animator={path="root",type="Animator"},
    extra={path = "root/extra", type = "GameObject"},
    general={path = "root/general", type = "GameObject"},
    special={path = "root/special", type = "GameObject"},
}

function Delegate_RewardItem.New(parent,prefab)
    local self = {};
    setmetatable(self, Delegate_RewardItem);
    if prefab~=nil then
        self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
        UITool.Parse(self.gameObject, self, objs)
        self.transform = self.gameObject:GetComponent("RectTransform")
    end
    self.item=nil;
    return self;
end

function Delegate_RewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Delegate_RewardItem:SetData(data,type)
    self.data=data
    if type==nil then
        if NumTool.GetLen(data.data)>0 then
            if self.item==nil then
                self.item=GoodsDataItem.New(self.goodRoot)
            end
            if data.data.type==1 then
                local itemConfig = ConfigMgr.Config.itemMap[data.data.id]
                itemConfig["count0"] = data.data.count
                self.item:SetData(1,itemConfig,data.data.type,false,Vector3(0.6,0.6,0.6),false)
            elseif data.data.type==2 then
                self.item:SetData(1,data.data,data.data.type,false,Vector3(0.6,0.6,0.6),false)
            end
        end
    else
        SetActive(self.bgObj,false);
        if self.item==nil then
            self.item=GoodsDataItem.New(self.goodRoot)
        end
        if type==1 then
            local itemConfig = ConfigMgr.Config.itemMap[data.id]
            itemConfig["count0"] = data.count
            self.item:SetData(1,itemConfig,type,false,Vector3(0.6,0.6,0.6),false)
        elseif type==2 then
            self.item:SetData(1,data,type,false,Vector3(0.6,0.6,0.6),false)
        end
    end
    SetActive(self.extra,self.data.extra);
    SetActive(self.rootObj,false)
    SetActive(self.general,false)
    SetActive(self.special,false)
end


function Delegate_RewardItem:SetActiveFX(isSpecial,isShowFX)
    SetActive(self.rootObj,true)
    if isSpecial then
        self.animator:Play("ui_ani_BattleWinPopup_template_Special");
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/SSRitem_get.mp3")
        SetActive(self.special,isShowFX);
    else
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/item_reward.mp3")
        self.animator:Play("ui_ani_BattleWinPopup_template_Gen");
        SetActive(self.general,isShowFX)
    end
end

function Delegate_RewardItem:Clear()
    self.data=nil;
end


function Delegate_RewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

