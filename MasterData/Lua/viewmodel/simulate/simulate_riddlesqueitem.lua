Simulate_RiddlesQueItem = {};

Simulate_RiddlesQueItem.__index = Simulate_RiddlesQueItem;

local objs = {
    off={path="root/off",type="Transform"},
    imgIcon={path="root/off/icon",type="Image"},
    goDone={path="root/off/done",type="GameObject"},
    txtAnswer={path="root/off/done/answer",type="Text"},
    goLock={path="root/off/lock",type="GameObject"},
    txtLock={path="root/off/lock/Text",type="Text"},
    btnClick={path="root/off/clickArea",type="Button"},
    redListener={path="root/off",type="RedIconListener"},
}



function Simulate_RiddlesQueItem.New()
    local self = {};
    setmetatable(self, Simulate_RiddlesQueItem);
    return self;
end


function Simulate_RiddlesQueItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnClick,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end


function Simulate_RiddlesQueItem:SetData(pdata)
    self.data=pdata.data
    self.redListener.RedId=self.data.redId

    self.off.anchoredPosition=Vector2(0,self.data.posY);
    SetActive(self.goDone,false)
    SetActive(self.goLock,false)
    if self.data.isPass then
        SetActive(self.goDone,true)
        self.txtAnswer.text=self.data.answer;
    elseif self.data.isLock then
        SetActive(self.goLock,true);
        self.txtLock.text=self.data.lockInfo;
    end
end
    


function Simulate_RiddlesQueItem:Clear()
    self.data=nil
end


function Simulate_RiddlesQueItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

