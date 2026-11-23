





YXTwoEventItemViewModel = {}

YXTwoEventItemViewModel.__index = YXTwoEventItemViewModel
local objs = {
    normal = {path = "Normal",type = "GameObject"},
    normal_name = {path = "Normal/Name",type = "Text"},
    
    choose = {path = "Choose",type = "GameObject"},
    choose_name = {path = "Choose/Name",type = "Text"},
    
    lock = {path = "Lock",type = "GameObject"},
    clickBtn = {path = "Normal",type = "Button"},
    redGroup = {path = "RedGroup",type = "GameObject"},
}

function YXTwoEventItemViewModel.New()
    local self = {}
    setmetatable(self, YXTwoEventItemViewModel)
    return self
end

function YXTwoEventItemViewModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        self.fun(self.index)
    end
    self.redIconList=self.gameObject:GetComponent("RedIconListener");
    LuaMgr.AddClick(self.clickBtn,self.clickCommand)
end

function YXTwoEventItemViewModel:SetData(data)
    self.data = data.data.data
    self.index = data.data.index
    self.fun = data.data.fun
    local config = ConfigMgr.Config.missionMap[self.data.id]
    if RedMgr.Singleton:GetRedStateById("1314_"..tostring(self.data.id)) > 0 then
        SetActive(self.redGroup,true);
    else
        SetActive(self.redGroup,false);
    end
    local tempLock = not self.data.completed and self.data.current < MissionHelper.GetTargetCount(self.data.id)
    local nameStr = tempLock and ConfigMgr.LangGlobal("7207") or LuaMgr.GetLangText(config.NameLan)
    self.normal_name.text = nameStr
    self.choose_name.text = nameStr
    SetActive(self.normal,true)
    SetActive(self.choose,data.data.choose)
    SetActive(self.lock,tempLock)
    self.gameObject:SetActive(true)
    RedMgr.Singleton:Refresh();
end

function YXTwoEventItemViewModel:Clear()
    self.data = nil
    self.index = nil
    self.fun = nil
    self.gameObject:SetActive(false)
end

function YXTwoEventItemViewModel:RefreshRed()
    if RedMgr.Singleton:GetRedStateById("1314_"..tostring(self.data.id)) > 0 then
        SetActive(self.redGroup,true);
    else
        SetActive(self.redGroup,false);
    end
    RedMgr.Singleton:Refresh();
end

function YXTwoEventItemViewModel:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.clickCommand)
        self.clickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end