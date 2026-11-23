Teaching_JCItem = {};

Teaching_JCItem.__index = Teaching_JCItem;
local objs = {
    bgSprite={path="root/bg",type="Image"},
    name={path="root/name",type="Text"},
    bgBtn={path="root/bg",type="UIButtonClick"},
    reward={path="root/bg/reward",type="GameObject"},
    icon={path="root/bg/reward/icon",type="RawImage"},
    textObj={path="root/tex",type="GameObject"},
}

   

function Teaching_JCItem.New()
    local self = {};
    setmetatable(self, Teaching_JCItem);
    return self;
end

function Teaching_JCItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function Teaching_JCItem:SetData(pdata)
    self.gameObject.transform.anchoredPosition=pdata.data.pos
    if pdata.data.type==1 then
        self.bgSprite.sprite=pdata.data.active and LuaMgr.GetSprite("JoinJob","ui_rz_szxl_jc_gk") or LuaMgr.GetSprite("JoinJob","ui_rz_szxl_jc_gk0")
    elseif pdata.data.type==2 then
        self.bgSprite.sprite=pdata.data.active and LuaMgr.GetSprite("JoinJob","ui_rz_szxl_jj_gk") or LuaMgr.GetSprite("JoinJob","ui_rz_szxl_jj_gk0")
    end
    self.name.text=pdata.data.name;
    SetActive(self.textObj,pdata.data.active)
    if pdata.data.active and pdata.data.noPass then
        SetActive(self.reward,true)
        self.icon.texture=pdata.data.icon
    else
        SetActive(self.reward,false)
    end
    self.bgBtnCommand=function()
        if pdata.data.callBack~=nil then
            pdata.data.callBack(pdata.data);
        end
    end
    LuaMgr.RemoveClick(self.bgBtn,self.bgBtnCommand)
    LuaMgr.AddClick(self.bgBtn,self.bgBtnCommand)
end

function Teaching_JCItem:Clear()
    if self.bgBtnCommand~=nil then
        LuaMgr.RemoveClick(self.bgBtn,self.bgBtnCommand)
    end
    self.data=nil
end

function Teaching_JCItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

