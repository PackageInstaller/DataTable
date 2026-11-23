WalkMount_MountItem = {};

WalkMount_MountItem.__index = WalkMount_MountItem;

local objs = {
    rootTran={ path = "", type = "RectTransform" },
    bgSprite = { path = "Bg", type = "Image" },
    tagSprite={ path = "Tip/Tag", type = "Image" },
    textCur={ path = "Tip/Pro/Cur", type = "Text" },
    textTotal={ path = "Tip/Pro/Total", type = "Text" },
    goDone={ path = "Done", type = "GameObject" },
    btnBg={ path = "Bg", type = "Button" },
    goLock={ path = "Lock", type = "GameObject" },
    redListener={path = "Bg", type = "RedIconListener"}
}

function WalkMount_MountItem.New()
    local self = {};
    setmetatable(self, WalkMount_MountItem);
    return self;
end

function WalkMount_MountItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function WalkMount_MountItem:SetData(pdata)
    self.data = pdata;
    self.rootTran.anchoredPosition=pdata.data.locPos;
    self.textCur.text=pdata.data.curValue;
    self.textTotal.text=pdata.data.maxValue;
    self.redListener.RedId="3002_"..self.data.data.id
    local endIndex=pdata.data.unLock and "1" or "2"
    local spriteName=string.format("ui_sgwcs_zjm_icon_%s0%s",pdata.data.spriteTag,endIndex)
    self.bgSprite.sprite=LuaMgr.GetSprite("WalkMount",spriteName);
    self.tagSprite.sprite=pdata.data.unLock and LuaMgr.GetSprite("WalkMount","ui_sgwcs_zjm_gs01") or LuaMgr.GetSprite("WalkMount","ui_sgwcs_zjm_gs02");
    SetActive(self.goDone,pdata.data.curValue==pdata.data.maxValue)
    SetActive(self.goLock,not pdata.data.unLock)
    self.onClickBg=function()
        if not self.data.data.unLock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10503"))
            return
        end
        if pdata.data.mountClick~=nil then
            pdata.data.mountClick(self.data.data.index)
        end
    end
    LuaMgr.AddClick(self.btnBg,self.onClickBg);
end


function WalkMount_MountItem:Clear()
    self.data = nil;
    LuaMgr.RemoveClick(self.btnBg,self.onClickBg)
end

function WalkMount_MountItem:Destroy()
    self.data = nil;
    self.rootTran=nil
    self.bgSprite=nil
    self.tagSprite=nil
    self.textCur=nil
    self.textTotal=nil;
    self.goDone=nil
    self.RemoveClick(self.btnBg,self.onClickBg)
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end