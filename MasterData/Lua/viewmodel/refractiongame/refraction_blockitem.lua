Refraction_BlockItem = {};

Refraction_BlockItem.__index = Refraction_BlockItem;

local objs = {
    dragBehaviour={path="root/block",type="OnDragBehaviour"},
    blockObj={path="root/block",type="GameObject"},
    barrierObj={path="root/barrier",type="GameObject"},
    canvas={path="",type="Canvas"},
}



function Refraction_BlockItem.New()
    local self = {};
    setmetatable(self, Refraction_BlockItem);
    return self;
end


function Refraction_BlockItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.dragBehaviour.onBeginDrag=function(eventData)
        local locPos=LuaMgr.Screen2Local(eventData.position, RefractionMgr.tranOpBoards);
        self.vector=self.transform.anchoredPosition-locPos;
        self.isDarging=false;

        self:UpSortLayer(true)
        
    end;
    self.dragBehaviour.onDrag=function(eventData)
        self.isDarging=true;
        local locPos=LuaMgr.Screen2Local(eventData.position, RefractionMgr.tranOpBoards);
        self.transform.anchoredPosition=locPos+self.vector;
    end;
    self.dragBehaviour.onPointerUp=function(eventData)
        if  self.isDarging then
            self:OnPointerUp();
            self.isDarging=false;
            self:UpSortLayer(false)
        end
    end;
   
end


function Refraction_BlockItem:SetData(pdata)
    self.data=pdata.data
    SetActive(self.blockObj,self.data.type==0);
    SetActive(self.barrierObj,self.data.type==1);
    self.transform.anchoredPosition=self.data.pos
    self.gameObject.name="op_"..self.data.index
end


function Refraction_BlockItem:OnPointerUp()
    local tarPos=self.data.pos;
    local initBlock= RefractionMgr.CheckAndGetBlockMoveToLocation(self.transform.anchoredPosition);
    if initBlock~=nil then
        RefractionMgr.ClearInitBlock(self.data.initIndex)
        tarPos=initBlock.data.pos;
        initBlock.data.isLocation=true;
        self.data.initIndex=initBlock.data.index;
        self.data.pos=tarPos;
        RefractionMgr.UpdateOpBlockData(self.data.index,self.data.initIndex,self.data.pos);

    end

    self.doTween=self.transform:DOLocalMove(Vector3(tarPos.x,tarPos.y,0),0.1);
    self.doTween:SetEase(Ease.OutSine);
    self.doTween.onComplete=function()
AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/Mission_Light_001.mp3");
        self.transform.anchoredPosition=tarPos;
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end
end

function Refraction_BlockItem:UpSortLayer(isOn)
    if isOn then
        self.canvas.overrideSorting=true;
        self.canvas.sortingOrder=15;
    else
        self.canvas.sortingOrder=10;
    end
end


function Refraction_BlockItem:Clear()
    self.data=nil
    
end


function Refraction_BlockItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
  
end

