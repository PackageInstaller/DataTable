NovelReview_TextItem = {};

NovelReview_TextItem.__index = NovelReview_TextItem;
local objs = {
    textContent={ path = "", type = "Text" },
    optionText={ path = "option/Text", type = "Text" },
    tranOption = { path = "option", type = "RectTransform" },
}

function NovelReview_TextItem.New()
    local self = {};
    setmetatable(self, NovelReview_TextItem);
    return self;
end

function NovelReview_TextItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function NovelReview_TextItem:SetTextColor()
    if self.data==nil then return end;
    if self.data.isAide then
        self.textContent.text=string.format("<color=#a6a29c>%s</color>",self.data.text);
    else
        self.textContent.text=self.data.text;
    end
end


function NovelReview_TextItem:SetData(pdata)
    self.data = pdata.data;
    SetActive(self.tranOption.gameObject,self.data.isOption)
    if self.data.isOption then
        self.textContent.text="";
        self.optionText.text=self.data.text
        self.tranOption.sizeDelta=Vector2(self.data.width+50,52);
    else
        self.textContent.text=self.data.text
        self.optionText.text="";
        self:SetTextColor();
    end
    if self.data.isPlaying then
        self.textContent.text=string.format("<color=#8afffb>%s</color>",self.data.text);
    end
end

function NovelReview_TextItem:TextPlay()
    self.textContent.text=string.format("<color=#8afffb>%s</color>",self.data.text);














end

function NovelReview_TextItem:StopPlay()
    self:SetTextColor();
    LuaMgr.RemoveTimer(TimerConst.NovelReviewTextInterval)
end

function NovelReview_TextItem:Clear()
    self.data = nil;
    LuaMgr.RemoveTimer(TimerConst.NovelReviewTextInterval)
end

function NovelReview_TextItem:Destroy()
    self.textContent=nil;
    self.tranOption =nil;
    LuaMgr.RemoveTimer(TimerConst.NovelReviewTextInterval)
    LuaMgr.DestroyImmediateGO(self.gameObject);
end