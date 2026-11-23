KZRYExplore_EventItem = {};

KZRYExplore_EventItem.__index = KZRYExplore_EventItem;
local objs = {
    passType1Obj={ path = "root/passType1", type = "GameObject" },
    passType2Obj={ path = "root/passType2", type = "GameObject" },
    lockSprite={ path = "root/lock", type = "Image" },
    norSprite={ path = "root/nor", type = "Image" },
    btnClick={ path = "root", type = "Button" },
}

function KZRYExplore_EventItem.New()
    local self = {};
    setmetatable(self, KZRYExplore_EventItem);
    return self;
end

function KZRYExplore_EventItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnClick,function()
        if not self.data.isLock and self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_12000"));
        end
    end)
end


function KZRYExplore_EventItem:SetData(pdata)
    self.data = pdata.data
    self.transform.anchoredPosition=self.data.locPos;
    SetActive(self.passType1Obj,self.data.isPass and not self.data.isRepeat);
    SetActive(self.passType2Obj,self.data.isPass and self.data.isRepeat);
    SetActive(self.lockSprite.gameObject,self.data.isLock);
    SetActive(self.norSprite.gameObject,not self.data.isLock);
    if self.data.isLock then
        self.lockSprite.sprite=LuaMgr.GetSprite("KZRY",self.data.lockIconName);
    else
        self.norSprite.sprite=LuaMgr.GetSprite("KZRY",self.data.iconName);
    end
end
    


function KZRYExplore_EventItem:Clear()
    self.data = nil;
end

function KZRYExplore_EventItem:Destroy()
    
    LuaMgr.DestroyImmediateGO(self.gameObject);
end