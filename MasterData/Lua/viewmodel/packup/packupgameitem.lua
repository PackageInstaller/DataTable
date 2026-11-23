PackUpGameItem = {};

PackUpGameItem.__index = PackUpGameItem;

local objs = {
    rootRt = { path = "", type = "RectTransform" },
    imgIcon = { path = "root/icon", type = "Image" },
    imgIconRt = { path = "root/icon", type = "RectTransform" },
    softPos = { path = "root/softPos", type = "RectTransform" },
    dragBehaviour = { path = "root", type = "OnDragBehaviour" },

}

function PackUpGameItem.New()
    local self = {};
    setmetatable(self, PackUpGameItem);
    return self;
end

function PackUpGameItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.dragBehaviour.onPointerDown = function()
        self.isClick = true;
    end
    self.dragBehaviour.onBeginDrag = function(eventData)
        self.isClick = false;
        if not self.data.isInit then
            self.selfDraging = true;
            PackUpMgr.PuzzleOnBeginDrag(eventData.position, self.data.itemName);
            return;
        end
        self.selfDraging = false;
        self.beginDragPosition = eventData.position;
        PackUpMgr.puzzleScrollView:OnBeginDrag(eventData);
    end;
    self.dragBehaviour.onDrag = function(eventData)
        if not self.selfDraging and self.beginDragPosition.x - eventData.position.x > 75 then
            PackUpMgr.PuzzleOnBeginDrag(self.beginDragPosition, self.data.itemName)
            self.selfDraging = true;
        end
        if self.selfDraging then
            PackUpMgr.PuzzleOnDrag(eventData.position, self.data.itemName);
        else
            PackUpMgr.puzzleScrollView:OnDrag(eventData);
        end
    end;
    self.dragBehaviour.onPointerUp = function(eventData)
        if self.isClick and not self.data.isInit then
            self.isClick = false;
            return
        end
        if self.selfDraging then
            PackUpMgr.PuzzleOnPointUp(self.data.itemName)
        end
        self.selfDraging = false;
    end;
    self.dragBehaviour.onEndDrag = function(eventData)
        if not self.selfDraging then
            PackUpMgr.puzzleScrollView:OnEndDrag(eventData);
        end
    end
end

function PackUpGameItem:SetActive(isOn)
    SetActive(self.gameObject, isOn);
end

function PackUpGameItem:SetData(pdata)
    self.beginDragPosition = 0;
    self.data = pdata.data
    self.data.isInit = true
    self.gameObject.name = self.data.itemName;
    self.finishcallback = self.data.finishcallback
    self.imgIcon.sprite = LuaMgr.GetSprite("PackUp", self.data.config.Id)
    self.imgIcon:SetNativeSize();
    self.rootRt.sizeDelta = self.imgIconRt.sizeDelta
    self.grid_points = {}
    for k, v in pairs(self.data.config.Area) do
        local point = {}
        point.x = v[1];
        point.y = v[2];
        table.insert(self.grid_points, point);
    end
end

function PackUpGameItem:Finishcallback()
    if (self.finishcallback) then
        self.finishcallback()
    end
end

function PackUpGameItem:GetSoftPos()
    return self.softPos.transform.postion
end

function PackUpGameItem:RestSize()
    self.rootRt.sizeDelta = self.imgIconRt.sizeDelta
end

function PackUpGameItem:UpdateInit_Pos(pos, isAnimation)
    if not isAnimation then
        self.transform.anchoredPosition = pos;
        return;
    end
    if self.doTween2 ~= nil then
        self.doTween2:Kill();
    end
    self.doTween2 = self.transform:DOLocalMove(Vector3(pos.x, pos.y, 0), 0.2);
    self.doTween2:SetEase(Ease.OutSine);
    self.doTween2.onComplete = function()
        self.transform.anchoredPosition = pos;
    end
end

function PackUpGameItem:DOLocalMove(pos, callBack)
    if self.doTween4 ~= nil then
        self.doTween4:Kill();
    end
    self.doTween4 = self.transform:DOLocalMove(pos, 0.5);
    self.doTween4:SetEase(Ease.OutSine);
    self.doTween4.onComplete = function()
        if callBack ~= nil then
            callBack();
        end
    end
end

function PackUpGameItem:OnBeginDragHandler(beginPosition)
    local locPos = LuaMgr.Screen2Local(beginPosition, PackUpMgr.tranItems);
    local selfPos = LuaMgr.World2Local(self.transform.position, PackUpMgr.tranItems)
    if self.data.isInit then
        self.data.isInit = false;
    end
    self.transform.parent = PackUpMgr.tranItems;
    self.rootRt.anchorMax = Vector2(0.5, 0.5);
    self.rootRt.anchorMin = Vector2(0.5, 0.5);
    local size = Vector2(0, 0);
    size.x = PackUpMgr.curPackData.cell_size
    size.y = PackUpMgr.curPackData.cell_size
    self.rootRt.sizeDelta = size
    self.transform.anchoredPosition = selfPos;
    self.vector = self.transform.anchoredPosition - locPos;
end

function PackUpGameItem:OnDragHandler(dragPosition)
    local dragPos = LuaMgr.Screen2Local(dragPosition, PackUpMgr.tranItems);
    self.transform.anchoredPosition = dragPos + self.vector;
end

function PackUpGameItem:Clear()
    self.data = nil
    self.doTween = nil
    self.doTween2 = nil;
end

function PackUpGameItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;

end