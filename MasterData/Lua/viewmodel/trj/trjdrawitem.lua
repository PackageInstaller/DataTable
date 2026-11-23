TRJDrawItem = {};

TRJDrawItem.__index = TRJDrawItem;

local objs = {
    rawIcon = { path = "root/icon", type = "RawImage" },
    txtNum={ path = "root/Image/num", type = "Text" },
    txtInfo={ path = "root/Info/Text", type = "Text" },
    goDone={ path = "root/done", type = "GameObject" },
    goMask1={ path = "root/done/mask1", type = "GameObject" },
    goMask2={ path = "root/done/mask2", type = "GameObject" },
    btnClick={ path = "root/icon", type = "Button" },
};

function TRJDrawItem.New()
    local self = {};
    setmetatable(self, TRJDrawItem);
    return self;
end

function TRJDrawItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    
    LuaMgr.AddClick(self.btnClick,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end











function TRJDrawItem:SetData(data)
    self.data = data.data;
    self.transform.anchoredPosition=self.data.pos;
    local itemPath=ConfigHelper.GetItemIconPath(self.data.item[1].id);
    local reCount=self.data.maxCount-self.data.drawCount;
    self.txtNum.text=self.data.item[1].count;
    self.txtInfo.text=string.format("%s/%s",self.data.drawCount,self.data.maxCount);
    self.rawIcon.texture=LuaMgr.GetTexture(itemPath);
    if reCount>0 then 
        SetActive(self.goDone,false)
        return
    end;
    SetActive(self.goDone,true);
    if self.data.index==2 or self.data.index==3 or self.data.index==5 or self.data.index==7 
            or self.data.index==8 or self.data.index==10 then
        SetActive(self.goMask1,true)
        SetActive(self.goMask2,false);
    else
        SetActive(self.goMask1,false)
        SetActive(self.goMask2,true);
        if self.data.index==1 then
            self.goMask2.transform.localScale=Vector3(-1,1,1);
        elseif self.data.index==4 then
            self.goMask2.transform.localScale=Vector3(1,1,1);
        elseif self.data.index==6 then
            self.goMask2.transform.localScale=Vector3(1,-1,1);
        elseif self.data.index==9 then
            self.goMask2.transform.localScale=Vector3(-1,-1,1);
        end
    end
end


function TRJDrawItem:Clear()
    self.data = nil;
end

function TRJDrawItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end