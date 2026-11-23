Qin2Answer_AnswerItem = {};

Qin2Answer_AnswerItem.__index = Qin2Answer_AnswerItem;
local objs = {
    bgSprite={ path = "root/bg", type = "Image" },
    text={ path = "root/text", type = "Text" },
    tagObj={ path = "root/tag", type = "GameObject" },
    BtnBG={ path = "root/bg", type = "Button" },
   
}

function Qin2Answer_AnswerItem.New()
    local self = {};
    setmetatable(self, Qin2Answer_AnswerItem);
    self.isActive=false;
    return self;
end

function Qin2Answer_AnswerItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.BtnBG,function()
        if  self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end




function Qin2Answer_AnswerItem:SetData(pdata)
    self.data = pdata.data
    self.bgSprite.sprite=LuaMgr.GetSprite("Qin2","ui_hd_dqww_wd_daxz"..self.data.index)
    self.transform.anchoredPosition=self.data.pos;
    self.text.text=self.data.name;
    self:SetIsOn(self.data.isOn);
end


function Qin2Answer_AnswerItem:SetIsOn(isOn)
    SetActive(self.tagObj,isOn)
end


function Qin2Answer_AnswerItem:Clear()
    self.data = nil;
end

function Qin2Answer_AnswerItem:Destroy()
    self.bgSprite=nil;
    self.text=nil;
    self.tagObj=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end