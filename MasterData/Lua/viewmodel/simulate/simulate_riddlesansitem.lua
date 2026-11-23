Simulate_RiddlesAnsItem = {};

Simulate_RiddlesAnsItem.__index = Simulate_RiddlesAnsItem;

local objs = {
    txtAnswer={path="root/BG/Answer",type="Text"},
    goSuccess={path="root/BG/Success",type="GameObject"},

    btnBg={path="root/BG",type="Button"},
}



function Simulate_RiddlesAnsItem.New()
    local self = {};
    setmetatable(self, Simulate_RiddlesAnsItem);
    return self;
end


function Simulate_RiddlesAnsItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnBg,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end

function Simulate_RiddlesAnsItem:SetData(pdata)
    self.data=pdata.data
    self.txtAnswer.text=self.data.info;
    SetActive(self.goSuccess,self.data.isSuccess);

end

function Simulate_RiddlesAnsItem:SetIsSuccess(isSuc)
    if isSuc then
        SetActive(self.goSuccess,true)




    end
end


function Simulate_RiddlesAnsItem:Clear()
    self.data=nil
end


function Simulate_RiddlesAnsItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end

