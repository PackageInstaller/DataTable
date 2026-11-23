Qin2Main_LineType = {};

Qin2Main_LineType.__index = Qin2Main_LineType;
local objs = {
    numText={ path = "root/text", type = "Text" },
    lockObj={ path = "root/lock", type = "GameObject" },
    tag1Obj={ path = "root/tag1", type = "GameObject" },
    tag2Obj={ path = "root/tag2", type = "GameObject" },
    BgBtn={ path = "root/BG", type = "Button" },
    redIconListener={ path = "root", type = "RedIconListener" },
}

function Qin2Main_LineType.New()
    local self = {};
    setmetatable(self, Qin2Main_LineType);
    self.isActive=false;
    return self;
end

function Qin2Main_LineType:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.BgBtn,function()
        if  self.data.lineCallBack~=nil then
            self.data.lineCallBack(self.data.index);
        end
    end)
end







function Qin2Main_LineType:SetData(pdata)
    self.data = pdata.data
    self.numText.text=tostring(self.data.index);
    self.redIconListener.RedId=self.data.redId;
    SetActive(self.tag1Obj, self.data.isShowTag and self.data.isComplete)
    SetActive(self.tag2Obj, self.data.isShowTag and not self.data.isComplete)
    SetActive(self.lockObj,self.data.isLock);
end



function Qin2Main_LineType:Clear()
    self.data = nil;
end

function Qin2Main_LineType:Destroy()
    self.numText=nil;
    self.lockObj=nil;
    self.tag1Obj=nil;
    self.tag2Obj=nil;
    self.BgBtn=nil;
    self.redIconListener=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end