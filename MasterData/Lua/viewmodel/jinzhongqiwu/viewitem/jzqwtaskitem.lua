













JZQWTaskItem = {}
JZQWTaskItem.__index = JZQWTaskItem

local objs = {}






JZQWTaskItem.New = function(prefab, parent, itemType)

    local self = {}
    setmetatable(self, JZQWTaskItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    SetActive(self.gameObject, true)
    self.transform = self.gameObject.transform
    self.itemType = itemType
    if itemType == JZQWConst.TaskItemType.Chapter then
        self.chapterBtn = self.transform:Find("Group"):GetComponent(UITool.Button)
        self.chapterArrow = self.transform:Find("Group/Arrow"):GetComponent(UITool.Transform)
        self.chapterName = self.transform:Find("Group/ChapterName"):GetComponent(UITool.Text)
    elseif itemType == JZQWConst.TaskItemType.Event then
        self.eventName = self.transform:Find("Group/EventName"):GetComponent(UITool.Text)
        self.eventFlag = self.transform:Find("Group/Flag").gameObject
    else
        self.rewardItems = {}
        for i = 1, 3 do
            local obj = self.transform:Find("Group/ItemParent/CommonItem" .. i).gameObject
            local item = CommonRewardItem.New(obj, true, 0.55)
            table.insert(self.rewardItems, item)
        end
        self.rewardParent = self.transform:Find("Group/ItemParent"):GetComponent(UITool.Transform)
        self.getRewardBtn = self.transform:Find("Group/GetBtn"):GetComponent(UITool.Button)
        self.gotObj = self.transform:Find("Group/GotObj").gameObject
    end
    self:Init()
    return self
end

function JZQWTaskItem:Init()
    if self.itemType == JZQWConst.TaskItemType.Chapter then
        self.OnClickChapterBtn = function()
            self.chapterIsOpen = self.chapterIsOpen == false
            self:RefreshChapterStatus()
        end
        LuaMgr.AddClick(self.chapterBtn, self.OnClickChapterBtn)
    elseif self.itemType == JZQWConst.TaskItemType.Event then
        SetActive(self.eventFlag, false)
    else
        self.OnClickGetBtn = function()
            if self.data.Status == CommonRewardItem.Status.CanGet then
                local callBack = function()
                    if self.data.callback ~= nil then
                        self.data.callback()
                    end
                end
                DataExHelper.EX_GetAward(self.data.Config.id, callBack)


            end
        end
        LuaMgr.AddClick(self.getRewardBtn, self.OnClickGetBtn)
    end
end

function JZQWTaskItem:SetData(data)
    self.data = data
    if self.itemType == JZQWConst.TaskItemType.Chapter then
        self.chapterName.text = self.data.Name
    elseif self.itemType == JZQWConst.TaskItemType.Event then
        self.eventName.text = self.data.Name
        SetActive(self.eventFlag, self.data.Status == JZQWConst.EventStatus.Finish)
    else
        for key, value in pairs(self.rewardItems) do
            SetActive(value.gameObject, false)
        end
        local rewards = self.data.Config.showReward
        for i = 1, #rewards do
            local item = self.rewardItems[i]
            if item ~= nil then
                SetActive(item.gameObject, true)
                local rewardData = rewards[i]
                rewardData.scale = 0.6
                rewardData.status = self.data.Status
                item:SetData1(rewardData)
            end
        end
        SetActive(self.gotObj, self.data.Status == CommonRewardItem.Status.Got)
        SetActive(self.getRewardBtn.gameObject, self.data.Status ~= CommonRewardItem.Status.Got)
        self.getRewardBtn.interactable = self.data.Status == CommonRewardItem.Status.CanGet
    end
end



function JZQWTaskItem:SetChildItems(items, isOpen)
    self.childItems = items
    self.chapterIsOpen = isOpen
    self:RefreshChapterStatus()
end

function JZQWTaskItem:RefreshChapterStatus(isOpen)
    if isOpen ~= nil then
        self.chapterIsOpen = isOpen
    end
    for key, value in pairs(self.childItems) do
        SetActive(value.gameObject, self.chapterIsOpen)
    end
    if self.chapterIsOpen == true then
        self.chapterArrow.localScale = Vector3(1, 1, 1)
    else
        self.chapterArrow.localScale = Vector3(-1, 1, 1)
    end
end

function JZQWTaskItem:ClearItems()
end

function JZQWTaskItem:Clear()
    self:ClearItems()
end

function JZQWTaskItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end