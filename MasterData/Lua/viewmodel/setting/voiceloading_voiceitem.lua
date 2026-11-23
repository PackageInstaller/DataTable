VoiceLoading_VoiceItem = {};

VoiceLoading_VoiceItem.__index = VoiceLoading_VoiceItem;
local objs = {
    des1={path="des1",type="Text"},
    des2={path="des2",type="Text"},
    loadingObj={path="loading",type="GameObject"},
    selectObj={path="loading/select",type="GameObject"},
    loadingBtn={path="loading",type="UIButtonClick"},
    loadedObj={path="loaded",type="GameObject"},
   
}

   

function VoiceLoading_VoiceItem.New()
    local self = {};
    self.isSelecting=false
    setmetatable(self, VoiceLoading_VoiceItem);
    return self;
end

function VoiceLoading_VoiceItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function VoiceLoading_VoiceItem:SetData(pdata)
    self.data=pdata.data
    SetActive(self.selectObj,false)
    SetActive(self.loadingObj,not self.data.isLoaded)
    SetActive(self.loadedObj, self.data.isLoaded)
    self.des1.text=self.data.isLoaded and string.format("<color=#707070>%s</color>",self.data.des1) 
            or string.format("<color=#ffffff>%s</color>",self.data.des1)
    self.des2.text=self.data.isLoaded and string.format("<color=#707070>%s</color>",self.data.des2)
            or string.format("<color=#a3a3a3>%s</color>",self.data.des2)
    self.height=self.des2.preferredHeight-16+73;
    self.loadingBtnCommand=function()
        self.isSelecting=not self.isSelecting;
        SetActive(self.selectObj,self.isSelecting);
        if pdata.data.callBack~=nil then
            pdata.data.callBack(self.data.id,self.isSelecting);
        end
    end
    LuaMgr.AddClick(self.loadingBtn,self.loadingBtnCommand)
end

function VoiceLoading_VoiceItem:Clear()
    if self.bgBtnCommand~=nil then
        LuaMgr.RemoveClick(self.bgBtn,self.bgBtnCommand)
    end
    self.data=nil
end

function VoiceLoading_VoiceItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

