SLGSmallMapScrollView = {}

SLGSmallMapScrollView.__index = SLGSmallMapScrollView

local poolMap = {}
local scale = Vector3.one

local function GetItem(this, data)
    local list = poolMap[data.class]
    if (list ~= nil) then
        local len = #list
        if (len > 0) then
            local item = list[len]
            list[len] = nil
            if (this.childContent ~= item.transform.parent) then
                item.transform:SetParent(this.childContent, false)
                item.transform.localScale = scale
            end
            item.transform.anchoredPosition = data.position
            item.gameObject:SetActive(true)
            return item
        end
    end
    local obj = LuaMgr.InstantiateGO(data.prefab)
    if (obj ~= nil) then
        local objTF = obj.transform
        objTF:SetParent(this.childContent, false)
        objTF.localScale = scale
        objTF.transform.anchoredPosition = data.position
        local class = _G[data.class]
        if (class ~= nil) then
            local item = class.New()
            item.class = data.class
            item.gameObject = obj
            item.transform = objTF
            item:Init()
            return item
        end
    end
    LuaMgr.DestroyImmediateGO(obj)
    return nil
end

local function AddItem(item)
    if (item.tween ~= nil) then
        item.tween:Kill(false)
        item.tween = nil
    end
    item:Clear()
    item.gameObject:SetActive(false)
    local list = poolMap[item.class]
    if (list == nil) then
        list = {}
        poolMap[item.class] = list
    end
    list[#list + 1] = item
end

SLGSmallMapScrollView.PreLoadItem=function(class,prefabPath,count)
    local list={};

    for i=1,count do
        local obj = LuaMgr.GetPrefab(prefabPath)
        if (obj ~= nil) then
            local objTF = obj.transform
            objTF.transform.anchoredPosition = Vector2(10000,10000);
            local class = _G[class]
            if (class ~= nil) then
                local item = class.New()
                item.class =class;
                item.gameObject = obj
                item.transform = objTF
                item:Init()
                table.insert(list,item);
            end
        end
    end
    poolMap[class] = list
end
SLGSmallMapScrollView.ClearItem = function(class)
    local list = poolMap[class]
    if (list ~= nil) then
        local item
        local len = #list
        for i = 1, len do
            item = list[i]
            item:Destroy()
            LuaMgr.DestroyImmediateGO(item.gameObject)
        end
        poolMap[class] = nil
        list = nil
    end
end

SLGSmallMapScrollView.ClearAll = function()
    for k, _ in pairs(poolMap) do
        SLGSmallMapScrollView.ClearItem(k)
    end
end

SLGSmallMapScrollView.New = function(gameObject)
    local self = {}
    setmetatable(self, SLGSmallMapScrollView)
    self.gameObject = gameObject
    self.rectTransform = gameObject:GetComponent("RectTransform")
    self.scrollRect = gameObject:GetComponent("ScrollRect")
    self.content = self.scrollRect.content

    self.overlayContainer = self.content:Find("OverlayContainer")
    self.backgroundImage = self.content:Find("btnBackgroundImage")

    self.rectWidth = 0
    self.rectHeight = 0
    self.contentX = 0
    self.contentY = 0
    self.currentX = 0
    self.currentY = 0
    self.dataId = 0
    self.itemMap = {}
    self.dataList = {}
    self.scrollSize = 0
    self.offPos=Vector2(0,0);
    self.scrollCallBack = nil
    self.itemMapPool={};
    self.tarScale = 1.0
    self.touchManager = CS.Laigu.Tools.TouchInputManager.Instance;
    self.updateHandler = function()
        local isStopScrollRect=self.touchManager ~= nil and self.touchManager.HadTwoFingerTouch;
        self.scrollRect.horizontal=not isStopScrollRect
        self.scrollRect.vertical=not isStopScrollRect;
        if (self.content == nil or LuaMgr.IsObjectNull(self.content)) then
            return
        end
        local pos = self.content.anchoredPosition
        local contentX = pos.x
        local contentY = pos.y
        if (contentX ~= self.currentX or contentY ~= self.currentY) then
            if contentX~=self.currentX or contentY~=self.currentY then
                self.contentX = contentX
                self.contentY = contentY
                self.currentX = contentX
                self.currentY = contentY
                self:SetItems(false)
            end
        end
        if (self.isScroll) then
            if (RaycastTool.GetMouseButtonUp(0)) then
                self:SetEnabled(true)
            end
        end
    end
    return self
end

function SLGSmallMapScrollView:SetParams(width, height,contentWidth,contentHeight)
    if (width ~= nil and height ~= nil) then
        self.rectWidth = width
        self.rectHeight = height
        self.rectTransform.sizeDelta = Vector2(width, height)
    else
        local sizeDelta = self.rectTransform.sizeDelta
        self.rectWidth = sizeDelta.x
        self.rectHeight = sizeDelta.y
    end
    if contentWidth~=nil and contentHeight~=nil then
        self.contentWidth=contentWidth;
        self.contentHeight=contentHeight;
        self.content.sizeDelta =Vector2(contentWidth,contentHeight);


        if self.overlayContainer then
            self.overlayContainer.sizeDelta = Vector2(contentWidth, contentHeight)
        end


        if self.backgroundImage then
            self.backgroundImage.sizeDelta = Vector2(contentWidth, contentHeight)
        end
    else
        self.content.sizeDelta=self.rectTransform.sizeDelta
    end

    self.childContent=self.overlayContainer or self.content;



end



local function ParseUnderscoreSeparatedString(str)
    if not str or str == "" then
        return {}
    end

    local result = {}
    local tempStr = str


    while true do
        local pos = string.find(tempStr, "_")
        if pos then

            table.insert(result, string.sub(tempStr, 1, pos - 1))

            tempStr = string.sub(tempStr, pos + 1)
        else

            table.insert(result, tempStr)
            break
        end
    end

    return result
end


function SLGSmallMapScrollView:SetBackImages(prefab, images)






























end

function SLGSmallMapScrollView:SetData(dataCallBack, reset,index,offPos)
    self.itemDataCallBack=dataCallBack;
    self:Clear(reset)




    self:SetItems(true)
    if index~=nil then
        self:MoveToIndex(index,offPos,false);
    end
    LuaMgr.AddUpdate(self.updateHandler)
end

function SLGSmallMapScrollView:AddData(data, refresh)
    self.dataId = self.dataId + 1
    data.id = self.dataId
    table.insert(self.dataList, data)

    if (refresh) then
        self:SetItems(refresh)
        LuaMgr.AddUpdate(self.updateHandler)
    end
end

function SLGSmallMapScrollView:RemoveSameGridIndex(list)
    local listDic={};
    for i,v in ipairs(list) do
        if listDic[v]==nil then
            listDic[v]=v;
        end
    end
    local newList={}
    for i,v in pairs(listDic) do
       table.insert(newList,v);
    end
    return newList;
end

function SLGSmallMapScrollView:SetItems(refresh, indexList)
    local item
    local data
    local map = {}
    local list=self:GetScreenGridIndexList();

    list=self:RemoveSameGridIndex(list);
    self.dataList={};
    local itemData=nil;
    for i,v in ipairs(list) do
        if self.itemMapPool[v]~=nil then
            itemData=self.itemMapPool[v];
        else
            itemData=self.itemDataCallBack(v);
            self.itemMapPool[v]=itemData;
        end
        if itemData ~= nil then
            itemData.id = v
            table.insert(self.dataList,itemData)
        end
    end
    self.sortingOrder=0;

    for i,v in ipairs(self.dataList) do

        data=v;
        if data.position.x*self.tarScale+data.width*self.tarScale>=-self.currentX and data.position.x*self.tarScale<=-self.currentX+self.rectWidth
                and data.position.y*self.tarScale-data.height*self.tarScale<=-self.currentY and data.position.y*self.tarScale>=-self.contentY-self.rectHeight then
            item = self.itemMap[data.id]
            if (item ~= nil) then
                if (refresh) then
                    item:SetData(data)
                end
            else
                item = GetItem(self, data)
                item:SetData(data)
            end
            self.itemMap[data.id] = nil
            map[data.id] = item
            self.sortingOrder=self.sortingOrder+1;
        end
    end
    for _, v in pairs(self.itemMap) do
        AddItem(v)
    end
    self.itemMap = map

    if self.scrollCallBack ~= nil then
        self.scrollCallBack(self.itemMap)
    end
end

function SLGSmallMapScrollView:SelectItem(index)
    self.selectIndex = index
    self:SetItems(true)
end

function SLGSmallMapScrollView:GetScreenGridIndexList()
    local list={};
    local gridList=SeasonSLGSmallMapMgr.GetCurAreaGridList();
    for i,v in pairs(gridList) do
        table.insert(list, tonumber(i));
    end

    return list;
end

function SLGSmallMapScrollView:MoveToIndex(index,isAnim)
    local row,col=SeasonSLGSmallMapMgr.GetBlockLocByIndex(index)
    local position=SeasonSLGSmallMapMgr.GetSmallMapBlockPositionByIndexEx(index);
    local targetPosition=Vector2(self.rectWidth/2,-self.rectHeight/2);
    local offPosition=targetPosition-position
    local tarX=offPosition.x;
    local tarY=offPosition.y;
    if tarX>0 then
        tarX=0;
    elseif tarX<-self.contentWidth+self.rectWidth then
        tarX=-self.contentWidth+self.rectWidth;
    end
    if tarY<0 then
        tarY=0;
    elseif tarY>self.contentHeight-self.rectHeight then
        tarY=self.contentHeight-self.rectHeight;
    end
    if not isAnim then
        self.content.anchoredPosition=Vector2(tarX,tarY);
    else
        if self.tween~=nil then
            self.tween:Kill();
        end
        self.tween=DOTWeen.To(function() return self.content.anchoredPosition  end,function(vector)
            self.content.anchoredPosition=vector;
        end,Vector2(tarX,tarY),0.4);
    end
end

function SLGSmallMapScrollView:LocationCurIndexPositon(index, scale, screenPosition)
    local oldScale = self.tarScale
    if oldScale == nil or oldScale == 0 then
        oldScale = 1
    end


    local anchor = Vector2(self.rectWidth / 2, self.rectHeight / 2)
    if screenPosition ~= nil then
        local localPoint = LuaMgr.Screen2Local(screenPosition, self.rectTransform)
        local rect = self.rectTransform.rect
        local pivot = self.rectTransform.pivot
        anchor = Vector2(
            localPoint.x + pivot.x * rect.width,
            (1 - pivot.y) * rect.height - localPoint.y)
    end

    local pos = self.content.anchoredPosition
    self.scaleAnchorViewport = anchor

    self.scaleAnchorContent = Vector2(
        (-pos.x + anchor.x) / oldScale,
        (pos.y + anchor.y) / oldScale)

    self.deltaScale = scale - oldScale
    self.tarScale = scale
end

function SLGSmallMapScrollView:Refresh(scale)
    if self.deltaScale and self.deltaScale ~= 0 then
        self.content.localScale=Vector3(self.tarScale,self.tarScale,1);
        self.content.anchoredPosition = Vector2(
            self.scaleAnchorViewport.x - self.scaleAnchorContent.x * self.tarScale,
            self.scaleAnchorContent.y * self.tarScale - self.scaleAnchorViewport.y)
        self.deltaScale = 0

    end

    self:SetItems(true)
end

function SLGSmallMapScrollView:SetSortingOrder()
    local list={}
    for i,v in pairs(self.itemMap) do
        table.insert(list,v);
    end
    table.sort(list,function(a, b)
        if a.data.rowIndex==b.data.rowIndex then
            return a.data.colIndex>b.data.colIndex;
        end
        return a.data.rowIndex<b.data.rowIndex;
    end)
    for i,v in ipairs(list) do
        v.transform:SetSiblingIndex(i);
    end
end

function SLGSmallMapScrollView:GetItemByIndex(index)
    local data = self.dataList[index]
    return GetItem(self, data)
end



function SLGSmallMapScrollView:GetMouseContentPosition()
    if self.content == nil or LuaMgr.IsObjectNull(self.content) then
        return nil
    end

    local screenPos
    if CS.UnityEngine.Input.touchCount > 0 then
        screenPos = CS.UnityEngine.Input.GetTouch(0).position
    else
        screenPos = CS.UnityEngine.Input.mousePosition
    end



    local localPoint = LuaMgr.Screen2Local(
        Vector2(screenPos.x, screenPos.y), self.content)
    local rect = self.content.rect
    local pivot = self.content.pivot
    local cx = localPoint.x + pivot.x * rect.width
    local cy = (1 - pivot.y) * rect.height - localPoint.y
    return Vector2(cx, -cy)
end

function SLGSmallMapScrollView:ClearItemMapPool()
    if (self.itemMap ~= nil) then
        for _, v in pairs(self.itemMap) do
            AddItem(v)
        end
        self.itemMap = {}
    end
    if (self.dataList ~= nil) then
        local len = #self.dataList
        for i = 1, len do
            SLGScrollData.AddData(self.dataList[i])
        end
        self.dataList = {}
    end
    self.itemMapPool={};
end

function SLGSmallMapScrollView:Clear(reset)
    LuaMgr.RemoveUpdate(self.updateHandler)
    self.dataId = 0
    self.scrollSize = 0
    if (reset) then
        self.currentX = 0
        self.currentY = 0
        self.contentX = 0
        self.contentY = 0
    else
        self.currentX = self.contentX
        self.currentY = self.contentY
    end
    if (self.itemMap ~= nil) then
        for _, v in pairs(self.itemMap) do
            AddItem(v)
        end
        self.itemMap = {}
    end
    if (self.dataList ~= nil) then
        local len = #self.dataList
        for i = 1, len do
            SLGScrollData.AddData(self.dataList[i])
        end
        self.dataList = {}
    end
    self.itemMapPool={};
end

function SLGSmallMapScrollView:Destroy()
    self.dataList = nil
    self.itemMap = nil
    self.itemMapPool=nil;
end