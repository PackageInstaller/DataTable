SawPuzzle_TaskItem = {};

SawPuzzle_TaskItem.__index = SawPuzzle_TaskItem;

local objs = {
    iconSprite={path="icon",type="Image"},
    goUnlock={path="goUnlock",type="GameObject"},
    unlockText={path="goUnlock/unlock/Text",type="Text"},
    goLock={path="goLock",type="GameObject"},
    lockText={path="goLock/Text",type="Text"},
    proText={path="pro/Text",type="Text"},
    goInfo1={path="content/info1",type="GameObject"},
    info1Bg={path="content/info1",type="Image"},
    info1Des={path="content/info1/des",type="Text"},
    info1Done={path="content/info1/done",type="GameObject"},
    info1JumpBtn={path="content/info1/jump",type="Button"},
    info2Bg={path="content/info2",type="Image"},
    goInfo2={path="content/info2",type="GameObject"},
    info2Des={path="content/info2/des",type="Text"},
    info2Done={path="content/info2/done",type="GameObject"},
    info2JumpBtn={path="content/info2/jump",type="Button"},
}



function SawPuzzle_TaskItem.New()
    local self = {};
    setmetatable(self, SawPuzzle_TaskItem);
    return self;
end


function SawPuzzle_TaskItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.info1JumpBtn,function()
        if self.data.jumpCallBck~=nil then
            self.data.jumpCallBck(self.data.index,1);
        end
    end)
    LuaMgr.AddClick(self.info2JumpBtn,function()
        if self.data.jumpCallBck~=nil then
            self.data.jumpCallBck(self.data.index,2);
        end
    end)
end

function SawPuzzle_TaskItem:SetData(pdata)
    self.data=pdata.data
    self.iconSprite.sprite=LuaMgr.GetSprite("SawPuzzle","ui_xqpt_tu_s0"..self.data.nameIndex);
    self.proText.text="X"..self.data.rewardCount;
    self.unlockText.text=self.data.title
    self.lockText.text=self.data.title
    SetActive(self.goUnlock,self.data.task1Pass and self.data.task2Pass)
    SetActive(self.goLock,not (self.data.task1Pass and self.data.task2Pass))

    self.info1Bg.sprite=self.data.task1Pass and LuaMgr.GetSprite("SawPuzzle","ui_xqpt_tj_rwdi04") 
            or LuaMgr.GetSprite("SawPuzzle","ui_xqpt_tj_rwdi03")
    self.info1Des.text=self.data.task1Pass and string.format("<color=#e0e0e0>%s</color>",self.data.task1Des) 
            or string.format("<color=#262429>%s</color>",self.data.task1Des);
    SetActive(self.info1Done,self.data.task1Pass)
    SetActive(self.info1JumpBtn.gameObject,not self.data.task1Pass and self.data.task1IsJump)
   

    if IsNullOrEmpty(self.data.task2Des) then
        SetActive(self.goInfo2,false);
        return
    end
    SetActive(self.goInfo2,true)
    self.info2Bg.sprite=self.data.task2Pass and LuaMgr.GetSprite("SawPuzzle","ui_xqpt_tj_rwdi04")
            or LuaMgr.GetSprite("SawPuzzle","ui_xqpt_tj_rwdi03")
    self.info2Des.text=self.data.task2Pass and string.format("<color=#e0e0e0>%s</color>",self.data.task2Des)
            or string.format("<color=#262429>%s</color>",self.data.task2Des);
    SetActive(self.info2Done,self.data.task2Pass)
    SetActive(self.info2JumpBtn.gameObject,not self.data.task2Pass and self.data.task2IsJump)
end



function SawPuzzle_TaskItem:Clear()
    self.data=nil
end


function SawPuzzle_TaskItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.unlockText=nil;
    self.goLock=nil;
    self.lockText=nil;
    self.iconSprite=nil
    self.goUnlock=nil
    self.proText=nil
    self.info1Bg=nil;
    self.goInfo1=nil
    self.info1Des=nil
    self.info1Done=nil
    self.info1JumpBtn=nil
    self.info1Bg=nil;
    self.goInfo2=nil
    self.info2Des=nil
    self.info2Done=nil
    self.info2JumpBtn=nil
end

