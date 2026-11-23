Simulate_OrderSlotItem = {};

Simulate_OrderSlotItem.__index = Simulate_OrderSlotItem;

local objs = {
    rawIcon={path="root/rawIcon",type="RawImage"},
    goFrush={path="root/frush",type="GameObject"},
    txtFrush={path="root/frush/Text",type="Text"},
    goLock={path="root/lock",type="GameObject"},
    txtLock={path="root/lock/Text",type="Text"},
    goSelect={path="root/select",type="GameObject"},
    bgBtn={path="root/BG",type="Button"},
}



function Simulate_OrderSlotItem.New()
    local self = {};
    setmetatable(self, Simulate_OrderSlotItem);
    return self;
end

function Simulate_OrderSlotItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.bgBtn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end

function Simulate_OrderSlotItem:SetData(pdata)
    self.data=pdata.data
    if not IsNullOrEmpty(self.data.characterId) then
        local path=ConfigHelper.GetCharacterAvatarPath(self.data.characterId);
        self.rawIcon.texture=LuaMgr.GetTexture(path);
    end
    if self.data.orderState<2 then
        self.rawIcon.enabled=false;
    else
        self.rawIcon.enabled=true;
    end
    SetActive(self.goLock,false);
    SetActive(self.goFrush,false);
    if self.data.orderState==0 then
        SetActive(self.goLock,true);
        self.txtLock.text=self.data.stateInfo
    elseif self.data.orderState==1 then
        SetActive(self.goFrush,true);
        self.txtFrush.text=self.data.stateInfo
    end
    self:SetSelect(self.data.isCur)
end

function Simulate_OrderSlotItem:SetSelect(isOn)
    SetActive(self.goSelect,isOn);
end

function Simulate_OrderSlotItem:Clear()
    self.data=nil
end


function Simulate_OrderSlotItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

