WalkMount_PoemItem = {};

WalkMount_PoemItem.__index = WalkMount_PoemItem;
local objs = {
    root={ path = "root", type = "RectTransform" },
    bgSprite={ path = "root/bg", type = "Image" },
    textName = { path = "root/textName", type = "Text" },
    textPoem = { path = "root/textPoem", type = "Text" },
    btnAnalyse = { path = "root/btnAnalyse", type = "Button" },
    goLock={ path = "root/lock", type = "GameObject" },
}

function WalkMount_PoemItem.New()
    local self = {};
    setmetatable(self, WalkMount_PoemItem);
    return self;
end

function WalkMount_PoemItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function WalkMount_PoemItem:SetData(pdata)
    self.data = pdata;
    local spriteName=string.format("hd_sgwcs_tc_%s_db%s",pdata.data.spriteTag,pdata.data.index)
    self.bgSprite.sprite=LuaMgr.GetSprite("WalkMount",spriteName)
    self.textName.text=LuaMgr.GetLangText("WalkMount_PoemItem_0")..pdata.data.title..LuaMgr.GetLangText("WalkMount_PoemItem_1")
    self.textPoem.text=pdata.data.poem
    if pdata.data.index>4 then
        self.root.anchoredPosition=Vector2(40,0);
    else
        self.root.anchoredPosition=Vector2(0,0);
    end
    SetActive(self.goLock,pdata.data.isLock)
    self.AnalyseClick=function()
        if self.data.data.isLock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("WalkMount_PoemItem_2"))
            return
        end
        if self.data.data.poemClick~=nil then
            self.data.data.poemClick(self.data.data.id);
        end
    end
    LuaMgr.AddClick(self.btnAnalyse,self.AnalyseClick)
end




function WalkMount_PoemItem:Clear()
    self.data = nil;
    LuaMgr.RemoveClick(self.btnAnalyse,self.AnalyseClick)
end

function WalkMount_PoemItem:Destroy()
    self.bgSprite=nil
    self.textName= nil
    self.textPoem = nil
    self.btnAnalyse = nil
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end