SLGScrollView = {}

SLGScrollView.__index = SLGScrollView

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

            SetActive(item.gameObject, true)
            return item
        end
    end
    LuaDebug.error("getitem InstantiateGO" .. data.id)
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

local addItem_list={}
local v3pos = Vector2(1000000,1000000)
local function AddItem(item)
    if (item.tween ~= nil) then
        item.tween:Kill(false)
        item.tween = nil
    end
    item:Clear()

    item.transform.anchoredPosition = v3pos

    addItem_list = poolMap[item.class]
    if (addItem_list == nil) then
        addItem_list = {}
        poolMap[item.class] = addItem_list
    end
    addItem_list[#addItem_list + 1] = item
end

SLGScrollView.PreLoadItem=function(prefab, count, parent)
    SLGScrollView.templete = parent
    local className = "MapBlockItem"
    local list=poolMap[className] or {}
    if #list >= count then
        return
    else
        count = count - #list
    end
    local class = _G[className]
    for i=1,count do
        local obj =  LuaMgr.InstantiateGO(prefab)
        if (obj ~= nil) then
            local objTF = obj.transform
            if parent then
                objTF:SetParent(parent, false)
            end
            SetActive(obj, false)
            objTF.transform.anchoredPosition = v3pos;
            if (class ~= nil) then
                local item = class.New()
                item.class =className;
                item.gameObject = obj
                item.transform = objTF
                item:Init()
                table.insert(list,item);
            end
        end
    end



    poolMap[className] = list
end
SLGScrollView.ClearItem = function(class)
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

SLGScrollView.ClearAll = function()
    for k, _ in pairs(poolMap) do
        SLGScrollView.ClearItem(k)
    end
end

SLGScrollView.New = function(gameObject)
    local self = {}
    setmetatable(self, SLGScrollView)
    self.gameObject = gameObject
    self.rectTransform = gameObject:GetComponent("RectTransform")
    self.scrollRect = gameObject:GetComponent("ScrollRect")
    self.content = self.scrollRect.content
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
    self.updateHandler = function()
        if (self.content == nil or LuaMgr.IsObjectNull(self.content)) then
            return
        end
        local pos = self.content.anchoredPosition
        local contentX = pos.x
        local contentY = pos.y
        if (contentX ~= self.currentX or contentY ~= self.currentY) then
            local targetX,targetY,blockX,blockY=self:GetGridLimitedPosition(self.currentX,self.currentY,contentX,contentY);
            if targetX~=contentX or targetY~=contentY then
                self.content.anchoredPosition=Vector2(targetX,targetY);
                if self.scrollRect~=nil then
                    local velocity=self.scrollRect.velocity;
                    if blockX then
                        velocity.x=0;
                    end
                    if blockY then
                        velocity.y=0;
                    end
                    self.scrollRect.velocity=velocity;
                end
                contentX=targetX;
                contentY=targetY;
            end
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

function SLGScrollView:SetParams(width, height,contentWidth,contentHeight,childContent)
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
    else
        self.content.sizeDelta=self.rectTransform.sizeDelta
    end
    if childContent~=nil then
        self.childContent=childContent;
    else
        self.childContent=self.content;
    end
end


function SLGScrollView:SetData(dataCallBack, reset,index,offPos)
    self.itemDataCallBack=dataCallBack;
    self:Clear(reset)




    self:SetItems(true)
    if index~=nil then
        self:MoveToIndex(index,offPos,false);
    end
    LuaMgr.AddUpdate(self.updateHandler)
end

function SLGScrollView:AddData(data, refresh)
    self.dataId = self.dataId + 1
    data.id = self.dataId
    table.insert(self.dataList, data)

    if (refresh) then
        self:SetItems(refresh)
        LuaMgr.AddUpdate(self.updateHandler)
    end
end


function SLGScrollView:LocationCurIndexPositon(index,scale)
    local tarIndex=index;
    if tarIndex==nil then
        local row,col=self:GetRowAndColByContentPosition();
        tarIndex=SeasonSLGMapMgr.GetBlockIndexByLoc(row,col);
    end
    self.tarIndex=tarIndex;
    self.tarScale=scale;
    self.tarIndexPosition=SeasonSLGMapMgr.GetBlockPositionByIndex(tarIndex);
end

function SLGScrollView:Refresh()
    self:SetItems(true)
end

function SLGScrollView:UpdateItemMap(blockIds)
    if IsNull(self.itemMap) then
        return;
    end
    if blockIds==nil then
        for i,v in pairs(self.itemMap) do
            local newData=self.itemDataCallBack(i);
            self.itemMapPool[i]=newData;
            v:UpdateData(newData);
        end
    else

        for i,v in ipairs(blockIds) do
            if self.itemMap[tonumber(v)]~=nil then
                local newData=self.itemDataCallBack(tonumber(v));
                self.itemMapPool[tonumber(v)]=newData;
                v:UpdateData(newData);
            end
        end
    end
end

function SLGScrollView:RefreshByScale(scale)
    if self.tarIndex~=nil then
        self.scaleTarIndexPosition=SeasonSLGMapMgr.GetBlockPositionByIndex(self.tarIndex);
        local vector=self.scaleTarIndexPosition-self.tarIndexPosition;
        self.content.anchoredPosition=self.content.anchoredPosition-vector;

        local position = self.content.anchoredPosition;
        self.contentX = position.x;
        self.contentY = position.y;
        self.currentX = position.x;
        self.currentY = position.y;
    end

    self:SetItems(false)



end


function SLGScrollView:RefreshBlocks(index,lastCurIndex)
    local list=SeasonSLGMapMgr.GetAroundBlocksByIndex(index)
    self.itemMapPool[index]=nil;
    self.itemMapPool[lastCurIndex]=nil;
    for i,v in ipairs(list) do
        self.itemMapPool[v]=nil;
    end
    self:SetItems(true)
end



local itemL=nil
local dataL=nil
local mapL = {}
local itemDataL=nil;
local listL={};
function SLGScrollView:SetItems(refresh)
    itemL=nil;
    dataL=nil;
    mapL = {}
    itemDataL=nil;
    listL=self:GetScreenGridIndexList();

    self.dataList={};
    for i,v in ipairs(listL) do
        if self.itemMapPool[v]~=nil then
            itemDataL=self.itemMapPool[v];
            itemDataL.position=SeasonSLGMapMgr.GetBlockPositionByIndex(v);
        else
            itemDataL=self.itemDataCallBack(v);
            self.itemMapPool[v]=itemDataL;
        end
        itemDataL.id=v;
        table.insert(self.dataList,itemDataL);
    end









    self.sortingOrder=0;
    for i,v in ipairs(self.dataList) do
        dataL=v;
        if dataL.position.x+dataL.width>=-self.currentX and dataL.position.x<=-self.currentX+self.rectWidth
                and dataL.position.y-dataL.height<=-self.currentY and dataL.position.y>=-self.contentY-self.rectHeight then
            itemL = self.itemMap[dataL.id]
            if (itemL ~= nil) then
                if (refresh) then

                    itemL:SetData(dataL)
                else

                    itemL:UpdateTransform(dataL.position);
                end
            else
                itemL = GetItem(self, dataL)
                if not SeasonSLGMapMgr.isDrag then

                    itemL:SetData(dataL)
                else

                    itemL:SetDataSimple(dataL)
                end
            end
            self.itemMap[dataL.id] = nil
            mapL[dataL.id] = itemL
            self.sortingOrder=self.sortingOrder+1;
        end
    end





    for _, v in pairs(self.itemMap) do
        AddItem(v)
    end
    self.itemMap = mapL




    self:SetSortingOrder();


    if self.scrollCallBack ~= nil then
        self.scrollCallBack(self.itemMap)
    end
end


function SLGScrollView:GetGridLimitedPosition(oldX,oldY,newX,newY)
    if self:HasGridInView(newX,newY) then
        return newX,newY,false,false;
    end
    if not self:HasGridInView(oldX,oldY) then
        return newX,newY,false,false;
    end

    local xChanged=newX~=oldX;
    local yChanged=newY~=oldY;
    local keepY=xChanged and self:HasGridInView(oldX,newY);
    local keepX=yChanged and self:HasGridInView(newX,oldY);

    if keepY and keepX then
        if math.abs(newX-oldX)>=math.abs(newY-oldY) then
            return oldX,newY,true,false;
        end
        return newX,oldY,false,true;
    elseif keepY then
        return oldX,newY,true,false;
    elseif keepX then
        return newX,oldY,false,true;
    end
    return oldX,oldY,xChanged,yChanged;
end


function SLGScrollView:CheckCorner(startPos,x,y,minRowIndex,maxRowIndex,minColIndex,maxColIndex,rowOff,colOff,det)
    local offX=x-startPos.x;
    local offY=y-startPos.y;
    local rawRowIndex=(offX*rowOff.y-offY*rowOff.x)/det;
    local rawColIndex=(colOff.x*offY-colOff.y*offX)/det;
    if rawRowIndex<minRowIndex then minRowIndex=rawRowIndex end
    if rawRowIndex>maxRowIndex then maxRowIndex=rawRowIndex end
    if rawColIndex<minColIndex then minColIndex=rawColIndex end
    if rawColIndex>maxColIndex then maxColIndex=rawColIndex end
    return minRowIndex,maxRowIndex,minColIndex,maxColIndex;
end

function SLGScrollView:CheckByStartPos(startPos,startRow,contentX,contentY,det,config)
    local left=-contentX;
    local right=left+self.rectWidth;
    local top=-contentY;
    local bottom=top-self.rectHeight;
    local minX=left-config.blockSize.x;
    local maxX=right;
    local minY=bottom;
    local maxY=top+config.blockSize.y;
    local minRowIndex=math.huge;
    local maxRowIndex=-math.huge;
    local minColIndex=math.huge;
    local maxColIndex=-math.huge;
    minRowIndex,maxRowIndex,minColIndex,maxColIndex=self:CheckCorner(startPos,left,top,minRowIndex,maxRowIndex,minColIndex,maxColIndex,config.row_off,config.col_off,det);
    minRowIndex,maxRowIndex,minColIndex,maxColIndex=self:CheckCorner(startPos,right,top,minRowIndex,maxRowIndex,minColIndex,maxColIndex,config.row_off,config.col_off,det);
    minRowIndex,maxRowIndex,minColIndex,maxColIndex=self:CheckCorner(startPos,left,bottom,minRowIndex,maxRowIndex,minColIndex,maxColIndex,config.row_off,config.col_off,det);
    minRowIndex,maxRowIndex,minColIndex,maxColIndex=self:CheckCorner(startPos,right,bottom,minRowIndex,maxRowIndex,minColIndex,maxColIndex,config.row_off,config.col_off,det);

    local floor=math.floor;
    local maxRowIndexLimit=floor((config.row-startRow)/2);
    local rowStart=SeasonSLGMapMgr.Clamp(floor(minRowIndex)-2,0,maxRowIndexLimit);
    local rowEnd=SeasonSLGMapMgr.Clamp(floor(maxRowIndex)+2,0,maxRowIndexLimit);
    local colStart=SeasonSLGMapMgr.Clamp(floor(minColIndex)-2,0,config.col-1);
    local colEnd=SeasonSLGMapMgr.Clamp(floor(maxColIndex)+2,0,config.col-1);
    local row=nil;
    local position=nil;

    for i=rowStart,rowEnd do
        row=startRow+i*2;
        for j=colStart,colEnd do
            if row%2~=0 then
                position=config.startPos_1+i*config.col_off+j*config.row_off;
            else
                position=config.startPos_2+i*config.col_off+j*config.row_off;
            end
            if position.x>=minX and position.x<=maxX and position.y>=minY and position.y<=maxY then
                return true;
            end
        end
    end
    return false;
end

function SLGScrollView:HasGridInView(contentX,contentY)
    if self.sortingOrder~=nil and self.sortingOrder>10 then
        return true;
    end
    if SeasonSLGMapMgr==nil or SeasonSLGMapMgr.mapConfig==nil then
        return true;
    end
    local config=SeasonSLGMapMgr.mapConfig;
    if config.row_off==nil or config.col_off==nil or config.blockSize==nil then
        return true;
    end
    local det=config.col_off.x*config.row_off.y-config.col_off.y*config.row_off.x;
    if det==0 then
        return true;
    end

    return self:CheckByStartPos(config.startPos_1,1,contentX,contentY,det,config)
            or self:CheckByStartPos(config.startPos_2,2,contentX,contentY,det,config);
end

local screenGridIndexList_list={};
local screenGridIndexList_row=nil;
local screenGridIndexList_col=nil;
local screenGridIndexList_rowStart=nil;
local screenGridIndexList_rowEnd=nil;
local screenGridIndexList_colStart=nil;
local screenGridIndexList_colEnd=nil;
function SLGScrollView:GetScreenGridIndexList()
    screenGridIndexList_list={};
    screenGridIndexList_row,screenGridIndexList_col=self:GetRowAndColByContentPosition();
    screenGridIndexList_rowStart,screenGridIndexList_rowEnd,screenGridIndexList_colStart,screenGridIndexList_colEnd=nil,nil,nil,nil
    local mapConfig=SeasonSLGMapMgr.mapConfig;
    if mapConfig==nil or mapConfig.row==nil or mapConfig.col==nil or self.content==nil then
        return screenGridIndexList_list;
    end
    screenGridIndexList_row=math.max(1,math.min(mapConfig.row,screenGridIndexList_row or 1));
    screenGridIndexList_col=math.max(1,math.min(mapConfig.col,screenGridIndexList_col or 1));
    local offCell=mapConfig.offCell or 0;


    if screenGridIndexList_row<=offCell then
        screenGridIndexList_rowStart=1
        screenGridIndexList_rowEnd=offCell*2+1;
    elseif screenGridIndexList_row>=mapConfig.row-offCell then
        screenGridIndexList_rowEnd=mapConfig.row;
        screenGridIndexList_rowStart=mapConfig.row-offCell*2;
        screenGridIndexList_rowStart=screenGridIndexList_rowStart<1 and 1 or screenGridIndexList_rowStart;
    else
        screenGridIndexList_rowStart=screenGridIndexList_row-offCell;
        screenGridIndexList_rowEnd=screenGridIndexList_row+offCell;
    end

    if screenGridIndexList_col<=offCell then
        screenGridIndexList_colStart=1
        screenGridIndexList_colEnd=offCell*2+1;
    elseif screenGridIndexList_col>=mapConfig.col-offCell then
        screenGridIndexList_colEnd=mapConfig.col
        screenGridIndexList_colStart=mapConfig.col-offCell*2;
        screenGridIndexList_colStart=screenGridIndexList_colStart<1 and 1 or screenGridIndexList_colStart;
    else
        screenGridIndexList_colStart=screenGridIndexList_col-offCell;
        screenGridIndexList_colEnd=screenGridIndexList_col+offCell;
    end
    local index=nil;
    screenGridIndexList_rowStart=math.max(1,screenGridIndexList_rowStart);
    screenGridIndexList_rowEnd=math.min(mapConfig.row,screenGridIndexList_rowEnd);
    screenGridIndexList_colStart=math.max(1,screenGridIndexList_colStart);
    screenGridIndexList_colEnd=math.min(mapConfig.col,screenGridIndexList_colEnd);
    local contentPosition=self.content.anchoredPosition;
    local left=-contentPosition.x;
    local right=left+self.rectWidth;
    local top=-contentPosition.y;
    local bottom=top-self.rectHeight;
    local blockWidth=mapConfig.blockSize~=nil and mapConfig.blockSize.x or 0;
    local blockHeight=mapConfig.blockSize~=nil and mapConfig.blockSize.y or 0;
    for i=screenGridIndexList_rowStart,screenGridIndexList_rowEnd do
        for j=screenGridIndexList_colStart,screenGridIndexList_colEnd do
            index=SeasonSLGMapMgr.GetBlockIndexByLoc(i,j)



            local position=SeasonSLGMapMgr.GetBlockPositionByIndex(index);
            if position.x+blockWidth>=left and position.x<=right
                    and position.y-blockHeight<=top and position.y>=bottom then
                table.insert(screenGridIndexList_list,index);
            end
        end
    end
    return screenGridIndexList_list;
end

local GetRowAndColByContentPosition_centerPosition=nil;
local GetRowAndColByContentPosition_row=nil;
local GetRowAndColByContentPosition_col=nil;
function SLGScrollView:GetRowAndColByContentPosition(contentX,contentY)
    if contentX==nil or contentY==nil then
        local pos=self.content.anchoredPosition;
        contentX=contentX or pos.x;
        contentY=contentY or pos.y;
    end
    GetRowAndColByContentPosition_centerPosition=Vector2(self.rectWidth/2,-self.rectHeight/2)
            -Vector2(contentX,contentY)+self.offPos;
    GetRowAndColByContentPosition_row,GetRowAndColByContentPosition_col=SeasonSLGMapMgr.GetRowAndColByPositon(GetRowAndColByContentPosition_centerPosition);
    return GetRowAndColByContentPosition_row,GetRowAndColByContentPosition_col;
end


function SLGScrollView:GetLocationPosition()
    local row,col=self:GetRowAndColByContentPosition();
    return Vector2(col,row);

end

function SLGScrollView:MoveToIndex(index,offPos,isAnim,callBack)
    self.offPos=offPos;
    local row,col=SeasonSLGMapMgr.GetBlockLocByIndex(index)
    local curRow,curCol=self:GetRowAndColByContentPosition()
    if isAnim and (math.abs(row-curRow)>SeasonSLGMapMgr.mapConfig.offCell or math.abs(col-curCol)>SeasonSLGMapMgr.mapConfig.offCell) then
        isAnim=false;
    end
    local position=SeasonSLGMapMgr.GetBlockPositionByIndex(index);
    local targetPosition=Vector2(self.rectWidth/2,-self.rectHeight/2);
    local offPosition=targetPosition-position+offPos
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
        if callBack~=nil then
            callBack();
        end
    else
        if self.tween~=nil then
            self.tween:Kill();
        end
        self.tween=DOTWeen.To(function() return self.content.anchoredPosition  end,function(vector)
            self.content.anchoredPosition=vector;
        end,Vector2(tarX,tarY),0.5);
        self.tween.onComplete=function()
            if callBack~=nil then
                callBack();
            end
        end
    end
end


local sortList={};
function SLGScrollView:SetSortingOrder()
    sortList={}

    for i,v in pairs(self.itemMap) do
        table.insert(sortList,v);
    end
    table.sort(sortList,function(a, b)
        if a.data.rowIndex==b.data.rowIndex then
            return a.data.colIndex>b.data.colIndex;
        end
        return a.data.rowIndex<b.data.rowIndex;
    end)




    for i,v in ipairs(sortList) do
        v.transform:SetSiblingIndex(i);
    end


end

function SLGScrollView:GetItemByIndex(index)
    local data = self.dataList[index]
    return GetItem(self, data)
end

function SLGScrollView:ClearItemMapPool()
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

function SLGScrollView:Clear(reset)
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

function SLGScrollView:Destroy()
    self.dataList = nil
    self.itemMap = nil
    self.itemMapPool=nil;
    SLGScrollView.templete = nil
end