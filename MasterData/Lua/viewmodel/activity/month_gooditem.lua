Month_GoodItem = {};

Month_GoodItem.__index = Month_GoodItem;

local objs = {
    bgSprite={path="root/bg",type="Image"},
    bgBtn={path="root/bg",type="UIButtonClick"},
    doneObj={path="root/done",type="GameObject"},
    reCheckingObj={path="root/reChecking",type="GameObject"},
    checkingObj={path="root/checking",type="GameObject"},
    fxObj={path="fx_getting",type="GameObject"},
    rareSprite={path="root/_good/rare",type="Image"},
    iconTexture={path="root/_good/rare/icon",type="RawImage"},
    countText={path="root/_good/count/text/text",type="Text"},
    countTextAdjust={path="root/_good/count/text",type="Text"},
    numText={path="root/num/text",type="Text"},
    nowingObj={path="root/num/now",type="GameObject"},
    tagObj={path="root/tag",type="GameObject"},
    tagSprite={path="root/tag",type="Image"},
    lockObj={path="root/lock",type="GameObject"},
    
}
function Month_GoodItem.New()
    local self = {};
    setmetatable(self, Month_GoodItem);
    return self;
end

function Month_GoodItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Month_GoodItem:SetCheckingObjVisible(visible)
    SetActive(self.checkingObj,visible)
end
function Month_GoodItem:SetFXVisible(visible)
    SetActive(self.fxObj,visible)
end

function Month_GoodItem:SetData(pdata)
    self.data=pdata.data
    self.bgSprite.sprite=self.data.bg 
    self.rareSprite.sprite=self.data.rare
    self.iconTexture.texture=self.data.icon
    self.countText.text=self.data.count
    self.countTextAdjust.text=self.data.count
    self.numText.text=self.data.num
    SetActive(self.doneObj,self.data.checkDone)
    SetActive(self.checkingObj,self.data.checking)
    SetActive(self.reCheckingObj,self.data.reChecking)
    SetActive(self.lockObj,self.data.lock)
    SetActive(self.nowingObj,self.data.nowing)
    if self.data.tagBool then
        SetActive(self.tagObj,true)
        self.tagSprite.sprite=self.data.tagSprite
    else
        SetActive(self.tagObj,false)
    end
    SetActive(self.fxObj,false)
    self.bgBtnCommand=function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.num)
        end
    end
    LuaMgr.AddClick(self.bgBtn, self.bgBtnCommand)
end
function Month_GoodItem:Clear()
    LuaMgr.RemoveClick(self.bgBtn, self.bgBtnCommand)
end
function Month_GoodItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

