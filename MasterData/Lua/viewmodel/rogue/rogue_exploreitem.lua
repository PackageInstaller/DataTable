Rogue_ExploreItem = {};

Rogue_ExploreItem.__index = Rogue_ExploreItem;

local objs = {
    upLineOnObj={path = "root/upLine/on", type = "GameObject" },
    upLineOffObj={path = "root/upLine/off", type = "GameObject" },
    downLineOnObj={path = "root/downLine/on", type = "GameObject" },
    downLineOffObj={path = "root/downLine/off", type = "GameObject" },
    leftLineOnObj={path = "root/leftLine/on", type = "GameObject" },
    leftLineOffObj={path = "root/leftLine/off", type = "GameObject" },
    rightLineOnObj={path = "root/rightLine/on", type = "GameObject" },
    rightLineOffObj={path = "root/rightLine/off", type = "GameObject" },
    iconBtn = { path = "root/nor/icon", type = "Button" },
    norObj={ path = "root/nor", type = "GameObject" },
    norIconImg = { path = "root/nor/icon", type = "Image" },
    norTag={ path = "root/nor/tag", type = "Image" },
    norCanvasGroup={ path = "root/nor", type = "CanvasGroup" },
    norNameText={ path = "root/nor/nameBg/Text", type = "Text" },
    norNameObj={ path = "root/nor/nameBg", type = "GameObject" },
    norUIGray={ path = "root/nor", type = "UIGray" },
    curFXObj={ path = "root/curFX", type = "GameObject" },
    lockFXObj={ path = "root/lockFX", type = "GameObject" },
    doneObj={ path = "root/done", type = "GameObject" },
    animator={ path = "", type = "Animator" },
    rootCanvasGroup={ path = "root", type = "CanvasGroup" },
    rootTF={ path = "root", type = "Transform" },
};

function Rogue_ExploreItem.New()
    local self = {};
    setmetatable(self, Rogue_ExploreItem);
    return self;
end

function Rogue_ExploreItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if self.data.isDone then
            return;
        end
        if not self.data.isUnlock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("Rogue_ExploreItem_0"))
            return;
        end
        if (self.data.id~=nil  and self.data.callBack ~= nil) then
            self.data.callBack(self.data.id)
        end
    end
    LuaMgr.AddClick(self.iconBtn, self.OnClickItem);
end


function Rogue_ExploreItem:SetData(data)
    self.data = data.data;
    self.transform.anchoredPosition=self.data.pos;
    self:SetBuildingState(self.data.unLockLines);
    if not self.data.isAnima then
        self.rootCanvasGroup.alpha=1.0;
        self.rootTF.localScale=Vector3.one;
    else

        self.animator:Play("ani_RogueExplorePanel_exploreItem",0,0)
    end
end


function Rogue_ExploreItem:SetBuildingState(unLockLines)
    if self.data.isDone then
        SetActive(self.doneObj,true);
        SetActive(self.curFXObj,false);
        SetActive(self.lockFXObj,false);
        SetActive(self.norObj,false);
    else
        SetActive(self.doneObj,false);
        SetActive(self.norObj,true);
        SetActive(self.norJQObj,self.data.isJQ);
        SetActive(self.norZDObj,self.data.isZD);
        SetActive(self.norNameObj,not IsNullOrEmpty(self.data.name))
        self.norNameText.text=self.data.name;
        self.norIconImg.sprite=LuaMgr.GetSprite("Rogue",self.data.bigIcon);
        if self.norIconImg.sprite==nil then
            self.norIconImg.sprite=LuaMgr.GetSprite("Rogue","ui_xhyt_gq_ggd_xz01");
        end
        if IsNullOrEmpty(self.data.smallIcon) then
            SetActive(self.norTag.gameObject,false)
        else
            SetActive(self.norTag.gameObject,true)
            self.norTag.sprite=LuaMgr.GetSprite("Rogue",self.data.smallIcon)
        end
        self:SetUnLock(self.data.isUnlock,self.data.isUnlockAnima);
    end
    SetActive(self.upLineOnObj,unLockLines[1]==2)
    SetActive(self.upLineOffObj,unLockLines[1]==1)
    SetActive(self.downLineOnObj,unLockLines[2]==2)
    SetActive(self.downLineOffObj,unLockLines[2]==1)
    SetActive(self.leftLineOnObj,unLockLines[3]==2)
    SetActive(self.leftLineOffObj,unLockLines[3]==1)
    SetActive(self.rightLineOnObj,unLockLines[4]==2)
    SetActive(self.rightLineOffObj,unLockLines[4]==1)
end

function Rogue_ExploreItem:SetUnLock(isOn,isUnlockAnima)
    self.norUIGray.IsGray=not isOn;
    self.norCanvasGroup.alpha=not isOn and 0.5 or 1.0
    SetActive(self.curFXObj, isOn);
    if not isOn then
        SetActive(self.lockFXObj,self.data.isFog);
    else
        if isUnlockAnima and self.data.isFog then
            SetActive(self.lockFXObj,true);
            self.animator:Play("ani_RogueExplorePanel_exploreItem_lockFX",0,0)
            coroutine_runner.start(function()
                coroutine_runner.wait(1.2)
                if self.lockFXObj~=nil then
                    SetActive(self.lockFXObj,false);
                end
            end)
        else
            SetActive(self.lockFXObj,false);
        end
    end
end




function Rogue_ExploreItem:UpdateData(unlockInfo)
    if not unlockInfo.isUnlock then return end;

    self.data.isDone=unlockInfo.isDone;
    self.data.isUnlock=unlockInfo.isUnlock;
    self.data.unLockLines=unlockInfo.unLockLines;
    self.data.isUnlockAnima=unlockInfo.isUnlockAnima;
    self:SetBuildingState(self.data.unLockLines)
end

function Rogue_ExploreItem:Clear()
    self.data = nil;
end

function Rogue_ExploreItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end