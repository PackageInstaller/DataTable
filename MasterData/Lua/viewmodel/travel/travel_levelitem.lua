Travel_LevelItem = {};

Travel_LevelItem.__index = Travel_LevelItem;
local objs = {
    root={ path = "", type = "RectTransform" },
    bgSprite={ path = "root/bg", type = "Image" },
    btnBg = { path = "root/bg", type = "Button" },
    goSelect={path = "root/select", type = "GameObject" },
    goSelectBg={path = "root/selectBg", type = "GameObject"},
    animator={path = "root", type = "Animator"},
    goFx={path = "root/goFx", type = "GameObject"},
    doneObj={path = "root/done", type = "GameObject"},
}

function Travel_LevelItem.New()
    local self = {};
    setmetatable(self, Travel_LevelItem);
    return self;
end

function Travel_LevelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Travel_LevelItem:SetData(pdata)
    self.data = pdata.data;
    self.root.anchoredPosition=self.data.pos;
    self.bgSprite.sprite=LuaMgr.GetSprite("Travel","ui_lx_lxwl_lxzb_ gk"..self.data.index);
    self.goSelect.transform.anchoredPosition=self.data.index%2==0 and Vector2(-11,-4) or Vector2(-38,-4);
    self.SetSelectStatue(self,false);
    SetActive(self.doneObj,self.data.isDone);
    self.doneObj.transform.anchoredPosition=self.data.index%2==1 and Vector2(6,-91) or Vector2(-45.4,-78.6);
    SetActive(self.goFx,true)
    self.animator:Play("ani_TravelevelPanel_Item")
    self.BgClick=function()
        self.data.levelClick(self.data.groupId);
    end
    LuaMgr.AddClick(self.btnBg,self.BgClick)
end

function Travel_LevelItem:SetSelectStatue(isOn)
    SetActive(self.goSelect,isOn)
    SetActive(self.goSelectBg,isOn)
    if isOn then
        self.animator:Play("ani_TravelevelPanel_Select")
    end
end


function Travel_LevelItem:Clear()
    self.data = nil;
    LuaMgr.RemoveClick(self.btnBg,self.BgClick)
end

function Travel_LevelItem:Destroy()
    self.bgSprite=nil
    self.textName= nil
    self.textPoem = nil
    self.btnAnalyse = nil
    self.doneObj=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end