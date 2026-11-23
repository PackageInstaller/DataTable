JoinJobNovel_TabItem = {};

JoinJobNovel_TabItem.__index = JoinJobNovel_TabItem;
local objs = {
    rootRect={path="root",type="RectTransform"},
    iconSprite={path="root/icon",type="Image"},
    desText={path="root/Text",type="Text"},
    lockObj={path="root/lock",type="GameObject"},
    lockInfo={path="root/lock/Text",type="Text"},
    btnIcon={path="root/icon",type="UIButtonClick"},
    redListener={path="root",type="RedIconListener"},
}

   

function JoinJobNovel_TabItem.New()
    local self = {};
    setmetatable(self, JoinJobNovel_TabItem);
    return self;
end

function JoinJobNovel_TabItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function JoinJobNovel_TabItem:SetData(pdata)
    self.data=pdata.data
    self.iconSprite.sprite=pdata.data.tabIcon;
    self.desText.text=pdata.data.tabDes;
    self.redListener.RedId=pdata.data.redId;
    if not pdata.data.tabUnLock then
        SetActive(self.lockObj,true)
        self.lockInfo.text=pdata.data.tabLockInfo
    else
        SetActive(self.lockObj,false)
    end
    self.rootRect.anchoredPosition=pdata.data.tabIsOn and Vector2(50,0) or Vector2(0,0);
    self.btnIconCommand=function()
        if self.data.callBack~=nil then
            if not self.data.tabUnLock then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,self.data.tabLockInfo)
                return
            end
            self.data.callBack(tonumber(self.data.index));
        end
    end
    LuaMgr.AddClick(self.btnIcon,self.btnIconCommand)
end

function JoinJobNovel_TabItem:SetTabIsOn(isOn)
    local tarPosX=isOn and 50 or 0
    self.rootRect:DOLocalMoveX(tarPosX,0.15);
end

function JoinJobNovel_TabItem:Clear()
    if self.bgBtnCommand~=nil then
        LuaMgr.RemoveClick(self.btnIcon,self.btnIconCommand)
    end
    self.data=nil
end

function JoinJobNovel_TabItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

