ChallengeItem = {};

ChallengeItem.__index = ChallengeItem;

local objs = {
    bg_no={path="IconBg/bg_no",type="GameObject"},
    bg_ed={path="IconBg/bg_ed",type="GameObject"},
    bg_fx={path="IconBg/ui_fx",type="GameObject"},
    tag={path="IconBg/tag",type="GameObject"},
    itemIcon={path="Item/Icon/item",type="RawImage"},
    itemNum={path="Item/NumBg/Num",type="Text"},
    itemDes={path="Item/Des",type="Text"},
}
function ChallengeItem.New()
    local self = {};
    setmetatable(self, ChallengeItem);
    return self;
end

function ChallengeItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function ChallengeItem:SetData(pdata)
    self.data=pdata.data
    self.itemIcon.texture=ConfigHelper.GetItemTexture(self.data.itemId)
    self.itemNum.text=self.data.itemCount
    self.itemDes.text=not self.data.isComplete and string.format("<color=#ffffff>%s</color>",self.data.des)
          or string.format("<color=#c1c0c0>%s</color>",self.data.des)
    if self.data.isCompleted then
        SetActive(self.bg_no,false)
        SetActive(self.bg_ed,true)
    else
        SetActive(self.bg_no,true)
        SetActive(self.bg_ed,false)
    end
    SetActive(self.bg_fx,false);
    SetActive(self.tag,self.data.isCompleted)

    if self.data.isNew then
        coroutine_runner.start(function()
            coroutine_runner.wait(0.2)
            SetActive(self.bg_fx,true);
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/tag_complete.mp3");
            coroutine_runner.wait(0.2)
            SetActive(self.bg_fx,false);
            SetActive(self.bg_no,false)
            SetActive(self.bg_ed,true)
            SetActive(self.tag,true)
            
        end)
    end
end
function ChallengeItem:Clear()
   
end

function ChallengeItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

