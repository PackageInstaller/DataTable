Simulate_BuildBufferItem = {};

Simulate_BuildBufferItem.__index = Simulate_BuildBufferItem;

local objs = {
    imgTag={path="root/tag",type="Image"},
    txtName={path="root/name",type="Text"},
    txtLevel={path="root/level",type="Text"},
    starTF={path="root/star",type="Transform"},
    btnClick1 = {path="root/clickArea/clickArea1",type="Button"},
    btnClick2 = {path="root/clickArea/clickArea2",type="Button"},
    btnClick3 = {path="root/clickArea/clickArea3",type="Button"},
    btnClick4 = {path="root/clickArea/clickArea4",type="Button"},
    btnClick5 = {path="root/clickArea/clickArea5",type="Button"},
    goRed={path="root/red",type="GameObject"},
}



function Simulate_BuildBufferItem.New()
    local self = {};
    setmetatable(self, Simulate_BuildBufferItem);
    return self;
end


function Simulate_BuildBufferItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnClick1,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.id);
        end
    end)
    LuaMgr.AddClick(self.btnClick2,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.id);
        end
    end)
    LuaMgr.AddClick(self.btnClick3,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.id);
        end
    end)
    LuaMgr.AddClick(self.btnClick4,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.id);
        end
    end)
    LuaMgr.AddClick(self.btnClick5,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.id);
        end
    end)
end








function Simulate_BuildBufferItem:SetData(pdata)
    self.data=pdata.data
self.transform.anchoredPosition=self.data.pos;
    self.txtName.text=self.data.name;
    self.txtLevel.text=self.data.levelInfo;
    self.imgTag.sprite=LuaMgr.GetSprite("Simulate","ui_hd_rsrh_jy_icon_"..self.data.id);
    for i=1,self.starTF.childCount,1 do
        SetActive(self.starTF:GetChild(i-1).gameObject,i<=self.data.starIndex);
    end
    SetActive(self.goRed,self.data.isRed)
    SetActive(self.btnClick1.gameObject,self.data.index==1)
    SetActive(self.btnClick2.gameObject,self.data.index==2)
    SetActive(self.btnClick3.gameObject,self.data.index==3)
    SetActive(self.btnClick4.gameObject,self.data.index==4)
    SetActive(self.btnClick5.gameObject,self.data.index==5)
end
    


function Simulate_BuildBufferItem:Clear()
    self.data=nil
end


function Simulate_BuildBufferItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
end

