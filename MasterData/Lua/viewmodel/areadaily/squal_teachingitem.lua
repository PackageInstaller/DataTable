Squal_TeachingItem = {};

Squal_TeachingItem.__index = Squal_TeachingItem;
local nums={LuaMgr.GetLangText("Squal_TeachingItem_0"),LuaMgr.GetLangText("Squal_TeachingItem_1"),LuaMgr.GetLangText("Squal_TeachingItem_2"),LuaMgr.GetLangText("Squal_TeachingItem_3")}

local objs = {
    canvasGroup = { path = "root", type = "CanvasGroup" },
    imgTitle = { path = "root/titleImg", type = "Image" },
    texTitle={path = "root/titleImg/Text", type = "Text"},
    goRate = { path = "root/rate", type = "GameObject" },
    imgRate = { path = "root/rate/rateImg", type = "Image" },
    texNum = { path = "root/numText", type = "Text" },
    imgState = { path = "root/stateImg", type = "Image" },
    texState = { path = "root/stateText", type = "Text" },
    goLock = { path = "lock", type = "GameObject" },
    btnRoot={path = "root", type = "Button"},
}


function Squal_TeachingItem.New()
    local self = {};
    setmetatable(self, Squal_TeachingItem);
    return self;
end

function Squal_TeachingItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Squal_TeachingItem:SetData(pdata)
   self.data=pdata.data
    SetActive(self.goLock,not self.data.isUnLock);
    self.imgTitle.sprite=LuaMgr.GetSprite("Squad","ui_dzr_yh_gkbt"..self.data.index)
    self.texTitle.text=self.data.name
    self.canvasGroup.alpha=self.data.isUnLock and 1.0 or 0.5
    if self.data.rare~="" then
        self.texState.text=LuaMgr.GetLangText("Squal_TeachingItem_4")
        self.imgState.sprite=LuaMgr.GetSprite("Squad","ui_dzr_yh_lb1");
    else
        self.imgState.sprite=LuaMgr.GetSprite("Squad","ui_dzr_yh_lb3");
        self.texState.text=""
    end
    SetActive(self.goRate,self.data.passScore>0)
    if self.data.passScore>0 then
        local hisRare="B";
        if self.data.passScore==3 then
            hisRare="S";
        elseif self.data.passScore==2 then
            hisRare="A";
        end
        self.imgRate.sprite=LuaMgr.GetSprite("AreaMapRes","ui_zqzb_pj_"..hisRare);
        self.texNum.text=""
    else
        self.texNum.text=nums[self.data.index]
    end
    
    self.onClickBg=function()
        if not self.data.isUnLock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("2236"));
            return
        end
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index)
        end
    end
    LuaMgr.AddClick(self.btnRoot,self.onClickBg);
    
    
    
end



function Squal_TeachingItem:Clear()
    self.data = nil;
    LuaMgr.RemoveClick(self.btnRoot,self.onClickBg)
end

function Squal_TeachingItem:Destroy()
    self.canvasGroup =nil
    self.imgTitle = nil
    self.texTitle=nil
    self.goRate = nil
    self.imgRate = nil
    self.texNum = nil 
    self.imgState = nil 
    self.texState = nil 
    self.goLock = nil 
    self.btnRoot=nil 
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end