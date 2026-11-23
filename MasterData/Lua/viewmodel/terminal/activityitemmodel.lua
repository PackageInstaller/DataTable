




ActivityItemModel = {}

ActivityItemModel.__index = ActivityItemModel

local objs = {
    icon = {path = "Icon",type = "RawImage"},
    select = {path = "Select",type = "GameObject"},
    bgButton = {path = "Button",type = "Button"},
    LockObj={path = "Lock",type = "GameObject"},
}

function ActivityItemModel.New(prefab, parent)
    local self = {}
    setmetatable(self, ActivityItemModel)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.bgCommand = function()
        if self.isLock then
            if self.data.Unlock[1]=="3" then
                local cfgNovel=ConfigMgr.Config.narrativeMap[self.data.Unlock[2]];
                local name=LuaMgr.GetLangText(cfgNovel.nameLan);
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(ConfigMgr.LangGlobal("15006"),name))
            elseif self.data.Unlock[1]=="2" then
                local cfgDungen=ConfigMgr.Config.dungeonMap[self.data.Unlock[2]];
                local name=LuaMgr.GetLangText(cfgDungen.NameLan);
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(ConfigMgr.LangGlobal("7063"),name))
            end
            return;
        end
        LuaMgr.InvokeUIEventListeners(UIEventConst.ActivityClick, self.data.PlotId,self.data.PlotInfoLan,self.select)
    end
    LuaMgr.AddClick(self.bgButton,self.bgCommand)
    return self
end

function ActivityItemModel:SetData(data,index)
    self.index = index
    self.data = data
    local path = Path.BranchPlotPath..data.Icon..".png"
    self.icon.texture = LuaMgr.GetTexture(path)
    SetActive(self.select,false)
    self.gameObject:SetActive(true)
    self.isLock=true;
    if IsNull(self.data.Unlock) or  #self.data.Unlock==0 then
        self.isLock=false;
    end
    if self.data.Unlock[1]=="3" then
        self.isLock=not DataHelper.IsCompleteNovel(self.data.Unlock[2]);
    elseif self.data.Unlock[1]=="2" then
        self.isLock=not DataHelper.IsCompleteDungeon(self.data.Unlock[2])
    end
    SetActive(self.LockObj,self.isLock);
end

function ActivityItemModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function ActivityItemModel:Destroy()
    if (self.bgCommand ~= nil) then
        LuaMgr.RemoveClick(self.bgButton, self.bgCommand)
        self.bgCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.LockObj=nil;
end