




NovelItemModel = {}

NovelItemModel.__index = NovelItemModel

local objs = {
    icon = {path = "Animator/Icon",type = "Image"},
    iconRect = {path = "Animator/Icon",type = "RectTransform"},
    text1 = {path = "Animator/Text",type = "Text"},
    textIsShow = {path = "Animator/Text",type = "GameObject"},
    text2 = {path = "Animator/Select/Text",type = "Text"},
    select = {path = "Animator/Select",type = "GameObject"},
    button = {path = "Animator/Button",type = "Button"},
    animator = {path = "Animator",type = "Animator"},
    lockObj={path = "Animator/lock",type = "GameObject"},
    redObj={path = "Animator/red",type = "GameObject"},
}

function NovelItemModel.New()
    local self = {}
    setmetatable(self, NovelItemModel)
    return self
end

function NovelItemModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.NovelItemClick, self.data.index,self.data.type)
    end
    LuaMgr.AddClick(self.button,self.clickCommand)
end

function NovelItemModel:SetData(data)

    self.data = data.data
    self.icon.sprite = LuaMgr.GetSprite("ActivityEventIcon","Icon_"..self.data.type)
    local name = LuaMgr.GetLangText(ConfigMgr.Config.activityGroup[tostring(self.data.type)].nameLan)
    self.text1.text = name
    self.text2.text = name
    SetActive(self.textIsShow,not self.data.select)
    SetActive(self.select,self.data.select)
    self.iconRect.localRotation = UnityEngine.Quaternion.Euler(Vector3.zero)
    self.animator.enabled = self.data.select
    self.gameObject:SetActive(true)
    SetActive(self.lockObj,not self.data.isUnLock)
    SetActive(self.redObj,self.data.isRed);
end

function NovelItemModel:Open()
    self.data.select = true
    self.animator:Play("EventPlaybackPanel_01",0,0)
    self.animator.enabled = self.data.select
    SetActive(self.textIsShow,false)
    SetActive(self.select,true)
end

function NovelItemModel:Close()
    self.data.select = false
    self.animator.enabled = self.data.select
    self.iconRect.localRotation = UnityEngine.Quaternion.Euler(Vector3.zero)
    SetActive(self.textIsShow,true)
    SetActive(self.select,false)
end

function NovelItemModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function NovelItemModel:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.button, self.clickCommand)
        self.clickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.lockObj=nil;
    self.redObj=nil;
end