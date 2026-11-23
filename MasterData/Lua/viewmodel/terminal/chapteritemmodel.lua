




require("ViewModel/Terminal/MainItemModel")

ChapterItemModel = {}

ChapterItemModel.__index = ChapterItemModel
ChapterItemModel.chapterPos = {Vector2(-12.27,150),Vector2(-16,-1.5),Vector2(-12.27,-150)}
ChapterItemModel.chapterScale = {Vector3(1.05,1.14,1),Vector3.one,Vector3(1.04,1.15,1)}
ChapterItemModel.chapterRot = {Vector3(7.75,0,0),Vector3.zero,Vector3(-7.75,0,0)}
local objs = {
    content = {path = "ContentAnim/Content",type = "RectTransform"},
    group = {path = "ContentAnim/Content",type = "CanvasGroup"},
    chapterIcon = {path = "ContentAnim/Content/ChapterBg",type = "Image"},
    iconRectTransform = {path = "ContentAnim/Content/ChapterBg",type = "RectTransform"},
    chapterText = {path = "ContentAnim/Content/Text",type = "Text"},
    chapterName = {path = "ContentAnim/Content/Name",type = "Text"},
    lock = {path = "ContentAnim/Content/Lock",type = "GameObject"},
    reward = {path = "ContentAnim/Content/Reward",type = "GameObject"},
    complete = {path = "ContentAnim/Content/Complete",type = "GameObject"},
    novelName = {path = "ContentAnim/Content/NovelText",type = "Text"},
    novelViewTransform = {path = "NovelAnim",type = "RectTransform"},
    novelGroup = {path = "NovelAnim/NovelView",type = "CanvasGroup"},
    scrollObject = {path = "NovelAnim/NovelView",type = "GameObject"},
    viewHorizontal = {path = "NovelAnim/NovelView",type = "ScrollRect"},
    viewViewport = {path = "NovelAnim/NovelView/Viewport",type = "RectMask2D"},
    viewBlock = {path = "NovelAnim/NovelView/Viewport",type = "UIBlock"},
    getReward = {path = "ContentAnim/Content/ChapterBg",type = "Button"},
}

function ChapterItemModel.New(prefab, parent,itemObject)
    local self = {}
    setmetatable(self, ChapterItemModel)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.mainItemTemplate = itemObject
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.itemList = {}
    self.uiScroll = nil
    self.clickIndex = 0
    self.selectEvent = function(eventData) self:MainItemClickEvent(eventData) end
    self.bgCommand = function()
        if self.reward.activeSelf == true then
            self:ClickReward()
        end
    end
    LuaMgr.AddClick(self.getReward,self.bgCommand)
    return self
end

function ChapterItemModel:SetData(config,dataList,index,isUpdate)
    self.gameObject.name = "MainChapterItem"..index
    self.type = index
    self.config = config
    self.dataList = dataList
    self.clickIndex = 0
    self.novelName.text = LuaMgr.GetLangText(self.config.uiNamelan)
    self.chapterText.text = LuaMgr.GetLangText(self.config.episodelan)
    self.chapterName.text = LuaMgr.GetLangText("ChapterItemModel_0")..LuaMgr.GetLangText(self.config.mapTitlelan)..LuaMgr.GetLangText("ChapterItemModel_1")
    self.chapterIcon.sprite = LuaMgr.GetSprite("MainChapterBg","Chapter_"..self.config.area)
    self.chapterIcon.raycastTarget = false
    self.group.alpha = index == 2 and 1.0 or 0.5
    self.novelGroup.alpha = index == 2 and 1.0 or 0.5
    self.viewHorizontal.horizontal = index == 2
    self.viewViewport.enabled = index == 2
    self.viewBlock.enabled = index == 2
    self.transform.anchoredPosition = self.chapterPos[index]
    self.transform.localRotation = UnityEngine.Quaternion.Euler(self.chapterRot[index])

    self.novelViewTransform.anchoredPosition = index == 2 and Vector2(265,8) or Vector2(257,8)

    SetActive(self.lock,false)
    SetActive(self.reward,false)
    SetActive(self.complete,false)
    
    self:CreateMainItem(isUpdate)
    self:SetState()
    self.gameObject:SetActive(true)
end

function ChapterItemModel:CreateMainItem(isUpdate)
    if self.type == 2 then
        if self.uiScroll == nil then
            self.uiScroll = UIScrollView.New(self.scrollObject)
            LuaMgr.RemoveUIEventListener(UIEventConst.MainItemClick, self.selectEvent)
            LuaMgr.AddUIEventListener(UIEventConst.MainItemClick, self.selectEvent)
        end
        self.uiScroll:Clear(false)
        local scrollData,scrollDatas = {},{}
        local groupData = nil
        for i = 1, #self.dataList do
            groupData = {}
            groupData.item = self.mainItemTemplate
            groupData.type = self.type
            groupData.index = i
            groupData.data = self.dataList[i]
            groupData.select = false
            groupData.scale = Vector3(0.9,0.9,0.9)
            scrollData = UIScrollData.GetData(self.mainItemTemplate,"MainItemModel",240 + 20,132,groupData)
            table.insert(scrollDatas,scrollData)
        end
        if LuaMgr.GetScreenWidth() > 1280 then
            self.uiScroll:SetParams(1170,130)
        else
            self.uiScroll:SetParams(985,130)
        end
        self.uiScroll:SetData(scrollDatas, isUpdate)
    else
        local tempItem = nil
        for i = 1, 5 do
            if #self.itemList < i then
                tempItem = MainItemModel.New(self.mainItemTemplate,self.viewHorizontal.content)
                table.insert(self.itemList,tempItem)
            end
            if #self.dataList >= i then
                self.itemList[i]:SetData(self.dataList[i],self.type,i)
            else
                self.itemList[i]:Clear()
            end
        end
    end
end

function ChapterItemModel:SetState()
    if DataMgr.Player.areaMaps[self.config.area].lock then 
        SetActive(self.lock,true)
        return
    end
    if type(DataMgr.Player.iceGorge.storyReward) ~= "function" and 
            DataMgr.Player.iceGorge.storyReward[self.config.area] ~= nil then
        SetActive(self.reward,false)
        SetActive(self.complete,true)
        self.chapterIcon.raycastTarget = false
        return
    end
    local rewardIsShow = true
    for i = 1, #self.dataList do
        rewardIsShow = DataHelper.GetNovelState(self.dataList[i].PlotId[1])
        if rewardIsShow == false then
            goto continue
        end
    end
    ::continue::
    SetActive(self.reward,rewardIsShow)
    self.chapterIcon.raycastTarget = self.type == 2 and rewardIsShow
end

function ChapterItemModel:ClickReward()
    local tempData = {}
    tempData.Type = "novel"
    tempData.Key = self.config.area
    ApiMgr.Request("iceGorge/get_reward",tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            self:SetState()
            local rewared = json.encode(re.result)
            LuaMgr.ShowItemRewared(rewared)
        end
    end,nil,true)
end

function ChapterItemModel:MainItemClickEvent(args)
    self.viewHorizontal:StopMovement()
    local index = args[0]
    if self.clickIndex == index then
        if self.uiScroll.itemMap[self.clickIndex].state == true then
            local plotIds = self.uiScroll.dataList[self.clickIndex].data.data.PlotId
            local callBack = function()
                LuaMgr.ShowLuaPanel(UIName.EventPlaybackViewModel)
            end
            LuaMgr.InvokeUIEventListeners(UIEventConst.MainNovelSaveReadList)
            LuaMgr.PlayNovelList(plotIds,callBack)
        else
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["9008"].NameLan)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tipStr)
        end
        return
    end
    if self.clickIndex ~= 0 then
        self.uiScroll.dataList[self.clickIndex].data.scale = Vector3(0.9,0.9,0.9)
        self.uiScroll.dataList[self.clickIndex].data.select = false
    end
    self.clickIndex = index
    self.uiScroll.dataList[self.clickIndex].data.scale = Vector3.one
    self.uiScroll.dataList[self.clickIndex].data.select = true
    self.uiScroll:Refresh()
end

function ChapterItemModel:Clear()
    self.type = nil
    self.config = nil
    self.dataList = nil
    self.clickIndex = nil
    if self.uiScroll ~= nil then
        self.uiScroll:Clear(false)
    end
    self.gameObject:SetActive(false)
end

function ChapterItemModel:Destroy()
    if (self.bgCommand ~= nil) then
        LuaMgr.RemoveClick(self.getReward, self.bgCommand)
        self.bgCommand = nil
    end
    for i = 1, #self.itemList do
        self.itemList[i]:Destroy()
    end
    self.itemList = nil
    if self.uiScroll ~= nil then
        UIScrollView.ClearItem("MainItemModel")
        self.uiScroll = nil
        LuaMgr.RemoveUIEventListener(UIEventConst.MainItemClick, self.selectEvent)
        self.selectEvent = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end