TRJPuzzleItem = {};

TRJPuzzleItem.__index = TRJPuzzleItem;

local objs = {
    imgIcon = { path = "root/icon", type = "Image" },
    onDragEvent = { path = "root/icon", type = "OnDragEvent" },
    goDefault={ path = "root/default", type = "GameObject" },

    animator={ path = "root", type = "Animator" },
};

function TRJPuzzleItem.New(prefab, parent)
    local self = {};
    setmetatable(self, TRJPuzzleItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform=self.gameObject.transform;
    UITool.Parse(self.gameObject, self, objs);




    
    local onPointDown=function(index,eventData)
        if self.data==nil or self.isSuccess then return end;
        local locPos=LuaMgr.Screen2Local(eventData.position,self.data.tf)
        self.vector=self.transform.anchoredPosition-locPos;
        if self.data.onDragBeginCallBack~=nil then
            self.data.onDragBeginCallBack(self.data.index);
        end
    end
    local onDrag=function(eventData)
        if self.data==nil or self.isSuccess then return end;
        local locPos=LuaMgr.Screen2Local(eventData.position,self.data.tf)
        self.transform.anchoredPosition=locPos+self.vector;
        if self.data.onDragCallBack~=nil then
            self.transform:SetAsLastSibling();
            self.data.onDragCallBack(self.data.index);
        end
    end
    local onPointerUp=function()
        if self.data==nil then return end;
        if self.data.onDragEndCallBack~=nil then
            self.data.onDragEndCallBack(self.data.index,self.transform.anchoredPosition);
        end
    end
    self.onDragEvent:SetData(nil,onPointDown,onDrag,onPointerUp);
    return self;
end

function TRJPuzzleItem:SetData(data)
    self.data = data;
    self.isSuccess=false;
    self.imgIcon.sprite=LuaMgr.GetSprite("TRJ",string.format("%s_%s",self.data.iconName,self.data.iconIndex))
    SetActive(self.gameObject,true);
    self.animator:Play("ani_TRJPuzzlePanel_iconItem2",0,0)

    if self.data.index==self.data.iconIndex then
        LuaDebug.error("index==iconIndex");
    end
    self.gameObject.name=self.data.index;
    self.transform.anchoredPosition=self.data.pos;
end

function TRJPuzzleItem:DOMove(tarPos,isAni,isSuccess)
    self.isSuccess=isSuccess;
    if isAni then
        DOTWeen.To(function() return  self.transform.anchoredPosition end,function(value)
            self.transform.anchoredPosition=value;
        end,tarPos,0.1).onComplete=function()
            self.transform.anchoredPosition=tarPos;
            if isSuccess then
                self:SetOutFade();
            end
        end;
    else
        self.transform.anchoredPosition=tarPos;
        if isSuccess then
            self:SetOutFade();
        end
    end
    
end

function TRJPuzzleItem:SetOutFade()
    self.animator:Play("ani_TRJPuzzlePanel_iconItem",0,0)
end

function TRJPuzzleItem:Clear()
    self.data = nil;
end

function TRJPuzzleItem:Destroy()
    
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end