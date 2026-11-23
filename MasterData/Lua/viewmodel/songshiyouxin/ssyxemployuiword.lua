require("ViewModel/SongShiYouXin/ViewItem/SSYXWordItem")









SSYXEmployUIWord = {}
SSYXEmployUIWord.__index = SSYXEmployUIWord

local objs = {
    wordItemTemplete = {path = "WordItemTemplete", type = UITool.GameObject},
    allWordItemBtn = {path = "AllWordItem", type = UITool.Button},
    wordItemParent = {path = "WordItemParent", type = UITool.Transform}
}

SSYXEmployUIWord.New = function(obj)

    local self = {}
    setmetatable(self, SSYXEmployUIWord)
    self.gameObject = obj
    self:Init()
    return self
end

function SSYXEmployUIWord:Init()
    UITool.Parse(self.gameObject, self, objs)

    self.OnClickOtherToggle = function(params)
        self:OnRefreshItem(params)
    end
    LuaMgr.AddUIEventListener(UIEventConst.SSYXWordItemRefresh, self.OnClickOtherToggle)

    self.allWordItem = SSYXWordItem.New(self.allWordItemBtn.gameObject)
    self.OnClickWordItem = function()
        local data = self.allWordItem.data
        data.IsSelected = self.allWordItem.data.IsSelected == false
        self.allWordItem:SetData(data)
        self.isAllSelected = data.IsSelected
        SSYXData.SelectAllWord(self.isAllSelected)
        LuaMgr.InvokeUIEventListeners(UIEventConst.SSYXWordItemRefresh)
        self:RefreshUI()
        LuaMgr.InvokeUIEventListeners(UIEventConst.SSYXSelectWord)
    end
    LuaMgr.AddClick(self.allWordItemBtn, self.OnClickWordItem)
    local allWordDatas = SSYXData.GetAllWordDatas()
    self.wordItemDic = {}
    for i = 1, #allWordDatas do
        local wordItem = SSYXWordItem.New(self.wordItemTemplete, true, self.wordItemParent)
        local wordData = allWordDatas[i]
        wordData.IsSelected = SSYXData.IsWordSelected(wordData.ID)
        wordItem:SetData(wordData)
        self.wordItemDic[wordData.ID] = wordItem
    end
end

function SSYXEmployUIWord:OnRefreshItem(params)
    if params == nil or params.Length == 0 then
        return
    end
    local data = params[0]
    SSYXData.SelectOneWord(data.ID, data.IsSelected)
    if data.IsSelected == true then
        local allSelected = true
        for id, item in pairs(self.wordItemDic) do
            if item.data.IsSelected ~= true then
                allSelected = false
                break
            end
        end
        self.isAllSelected = allSelected
        if self.allWordItem.data == nil then
            self.allWordItem.data = {}
        end
        self.allWordItem.data.IsAllWord = true
        self.allWordItem.data.IsSelected = self.isAllSelected
        self.allWordItem:SetData(self.allWordItem.data)
    else
        self.isAllSelected = false
        if self.allWordItem.data == nil then
            self.allWordItem.data = {}
        end
        self.allWordItem.data.IsAllWord = true
        self.allWordItem.data.IsSelected = false
        self.allWordItem:SetData(self.allWordItem.data)
    end
    LuaMgr.InvokeUIEventListeners(UIEventConst.SSYXSelectWord)
end

function SSYXEmployUIWord:RefreshUI()
    local data = {}
    data.IsAllWord = true
    data.IsSelected = self:GetAllSelectStatus()
    self.allWordItem:SetData(data)
    local allWordDatas = SSYXData.GetAllWordDatas()
    for i = 1, #allWordDatas do
        local wordData = allWordDatas[i]
        local wordItem = self.wordItemDic[wordData.ID]
        if wordItem ~= nil then
            wordItem:SetData(wordData)
        end
    end
end

function SSYXEmployUIWord:GetAllSelectStatus()
    local allSelected = true
    for id, item in pairs(self.wordItemDic) do
        if item.data.IsSelected ~= true then
            allSelected = false
            break
        end
    end
    return allSelected
end

function SSYXEmployUIWord:ClearItems()
end

function SSYXEmployUIWord:Clear()
    self:ClearItems()
end

function SSYXEmployUIWord:Destroy()
    LuaMgr.RemoveUIEventListener(UIEventConst.SSYXWordItemRefresh, self.OnClickOtherToggle)
    self.gameObject = nil
end