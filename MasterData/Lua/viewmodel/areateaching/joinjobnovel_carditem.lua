JoinJobNovel_CardItem = {};

JoinJobNovel_CardItem.__index = JoinJobNovel_CardItem;
local objs = {
    rootObj={path="root",type="GameObject"},
    bgBtn={path="root/bg",type="UIButtonClick"},
    iconSprite={path="root/icon",type="Image"},
    name={path="root/imgName/Text",type="Text"},



    tipObj={path="root/tip",type="GameObject"},
    tagObj={path="root/tag",type="GameObject"},
    tagSprite={path="root/tag",type="Image"},
    lockObj={path="root/lock",type="GameObject"},
    fxPlayObj={path="root/fxPlay",type="GameObject"}
}

   

function JoinJobNovel_CardItem.New()
    local self = {};
    setmetatable(self, JoinJobNovel_CardItem);
    return self;
end

function JoinJobNovel_CardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function JoinJobNovel_CardItem:SetData(pdata)
    self.data=pdata.data
    self.iconSprite.sprite=LuaMgr.GetSprite("JoinJob",pdata.data.iconName)
    self.name.text=self.data.name
    SetActive(self.lockObj,not self.data.unLock)
    SetActive(self.tipObj,self.data.isTip);
    SetActive(self.tagObj,self.data.isCan)
    SetActive(self.fxPlayObj,self.data.isFirst)
    self.bgBtnCommand=function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data);
        end
    end
    LuaMgr.AddClick(self.bgBtn,self.bgBtnCommand)
    SetActive(self.rootObj,false)
    
    if not self.data.unLock then return end;
    if not self.data.isCan then return end;
    self.tagSprite.sprite=self.data.isFirst and LuaMgr.GetSprite("JoinJob","ui_rz_scjhy_jq_kaiqi") or LuaMgr.GetSprite("JoinJob","ui_rz_scjhy_jq_huigu")
  
end

function JoinJobNovel_CardItem:SetActive()
    SetActive(self.rootObj,true)
end

function JoinJobNovel_CardItem:Clear()
    if self.bgBtnCommand~=nil then
        LuaMgr.RemoveClick(self.bgBtn,self.bgBtnCommand)
    end
    self.data=nil
end

function JoinJobNovel_CardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

