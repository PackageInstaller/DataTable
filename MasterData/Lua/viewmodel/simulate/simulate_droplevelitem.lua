Simulate_DropLevelItem = {};

Simulate_DropLevelItem.__index = Simulate_DropLevelItem;

local objs = {
    offTf={path="root/off",type="Transform"},
    txtName={path="root/off/name",type="Text"},
    goNum={path="root/off/num",type="GameObject"},
    txtNum={path="root/off/num/count",type="Text"},
    matListTF={path="root/off/matList",type="Transform"},
    goLock={path="root/off/lock",type="GameObject"},
    lockInfo={path="root/off/lock/lockInfo",type="Text"},
    btnBg={path="root/off/BG",type="Button"},
    redListener={path="root/off",type="RedIconListener"},
}



function Simulate_DropLevelItem.New()
    local self = {};
    setmetatable(self, Simulate_DropLevelItem);
    self.matListVM={};
    return self;
end

function Simulate_DropLevelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    SetActive(self.gameObject,true);
    LuaMgr.AddClick(self.btnBg,function()
        if self.data.callBack~=nil then
            if self.data.isLock then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,self.data.lockInfo);
                return;
            end
            self.data.callBack(self.data.index);
        end
    end)
end


function Simulate_DropLevelItem:SetData(pdata)
    self.data=pdata.data
    self.redListener.RedId=self.data.red
    self.txtName.text=self.data.name;
    self.transform.anchoredPosition=self.data.pos;
    SetActive(self.goLock,self.data.isLock);
    SetActive(self.goNum,not self.data.isLock);
    self.lockInfo.text=self.data.lockInfo;
    self.txtNum.text=string.format("%.2d",self.data.index)
    self:SetMatList();
end

function Simulate_DropLevelItem:SetMatList()
    for i,v in ipairs(self.data.matList) do
        if self.matListVM[tostring(i)]==nil then
            self.matListVM[tostring(i)]=SimulateDropMat.New(self.matListTF);
        end
        self.matListVM[tostring(i)]:SetData(v)
    end
end

function Simulate_DropLevelItem:Clear()
    self.data=nil
end


function Simulate_DropLevelItem:Destroy()
    if #self.matListVM>0 then
        for i,v in pairs(self.matListVM) do
            v:Destroy();
        end
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    
end

