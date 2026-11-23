SawPuzzle_PuzzleItem = {};

SawPuzzle_PuzzleItem.__index = SawPuzzle_PuzzleItem;

local objs = {
    root={path="root",type="Transform"},
    offSet={path="root/offset",type="Transform"},
    rawMaterial={path="root/offset/raw",type="Image"},
    rawMask={path="root/offset/flare",type="Image"},
    imgShadow={path="root/offset/shadow",type="Image"},
    dragBehaviour={path="root",type="OnDragBehaviour"},
    animator={path="",type="Animator"},
}

local function CreateMaterial(self,index,isMainTex)
    local material=UnityEngine.Material(self.rawMaterial.material);
    material:SetFloat("_Row",SawPuzzleMgr.row)
    material:SetFloat("_Col",SawPuzzleMgr.col)
    material:SetFloat("_AreaWidth",SawPuzzleMgr.config.material._AreaWidth)
    material:SetFloat("_AreaHight",SawPuzzleMgr.config.material._AreaHight)
    material:SetFloat("_PieceWidth",SawPuzzleMgr.config.material._PieceWidthBase
            +SawPuzzleMgr.config.material._PieceWidthOff*(self.data.data.loc_y-1))
    material:SetFloat("_PieceHight",SawPuzzleMgr.config.material._PieceHightBase
            -SawPuzzleMgr.config.material._PieceHightOff*(self.data.data.loc_x-1))
    material:SetFloat("_maskRectWidth",SawPuzzleMgr.config.material._maskRectWidth)
    material:SetFloat("_offSet",SawPuzzleMgr.config.material._offSet)
    
    local tex=LuaMgr.GetTexture(SawPuzzleMgr.config.base.texPath..index..".png")
    material:SetTexture("_Mask",tex)
    if isMainTex then
        local mainTex=LuaMgr.GetTexture(Path.Image.."SawPuzzle/"..self.data.imgName..".png")
        material:SetTexture("_Tex",mainTex);
    else
        material:SetTexture("_Tex",DefaultTexture);
    end
    return material;
end

function SawPuzzle_PuzzleItem.New()
    local self = {};
    setmetatable(self, SawPuzzle_PuzzleItem);
    return self;
end


function SawPuzzle_PuzzleItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.dragBehaviour.onPointerDown=function()
        self.isClick=true;
    end
    self.dragBehaviour.onBeginDrag=function(eventData)
        self.isClick=false;
        if self.data.data.isFix then
            return
        end
        if not self.data.data.isInit then
            self.selfDraging=true;
            SawPuzzleMgr.PuzzleOnBeginDrag(eventData.position,self.data.data.loc_x,self.data.data.loc_y);
            return;
        end
        self.selfDraging=false;
        self.beginDragPosition=eventData.position;
        SawPuzzleMgr.puzzleScrollView:OnBeginDrag(eventData);
    end;
    self.dragBehaviour.onDrag=function(eventData)
        if self.data.data.isFix then
            return;
        end
if not self.selfDraging and self.beginDragPosition.x-eventData.position.x>75 then
            SawPuzzleMgr.PuzzleOnBeginDrag(self.beginDragPosition,self.data.data.loc_x,self.data.data.loc_y)
           self.selfDraging=true;
        end
        if self.selfDraging then
            SawPuzzleMgr.PuzzleOnDrag(eventData.position,self.data.data.loc_x,self.data.data.loc_y);
        else
            SawPuzzleMgr.puzzleScrollView:OnDrag(eventData);
        end
    end;
    self.dragBehaviour.onPointerUp=function(eventData)
        if self.isClick and not self.data.data.isFix and not self.data.data.isInit then

            self.isClick=false;
            self:DORotate();
            return
        end
        if self.selfDraging  and not self.data.data.isFix then
            SawPuzzleMgr.PuzzleOnPointUp(false,self.data.data.loc_x,self.data.data.loc_y)
        end
        self.selfDraging=false;
    end;
    self.dragBehaviour.onEndDrag=function(eventData)
        if not self.selfDraging then
            SawPuzzleMgr.puzzleScrollView:OnEndDrag(eventData);
            return
        end
    end
end

function SawPuzzle_PuzzleItem:SetActive(isOn)
    SetActive(self.gameObject,isOn);
end

function SawPuzzle_PuzzleItem:SetData(pdata)
    self.lastTime=0;
    self.beginDragPosition=0;
    self.data=pdata.data
    self.gameObject.name=self.data.index;
    self.rawMaterial.material=CreateMaterial(self,self.data.index,true)
    self.rawMask.material=CreateMaterial(self,self.data.index,false)
    local spriteName="pt"..self.data.index;
    if SawPuzzleMgr.config.type~="1" then
        spriteName=SawPuzzleMgr.config.type..spriteName;
    end
    self.imgShadow.sprite=LuaMgr.GetSprite("SawPuzzle",spriteName)
    self:SetScale(-1,false);
    self:SetAngle(self.data.data.angleZ)
end


function SawPuzzle_PuzzleItem:SetFixedFx()
    self.animator:Play("ui_ani_SawPuzzlePanel_puzzleitem_flare",0,0)
end


function SawPuzzle_PuzzleItem:SetScale(dir,isAnimation)
    if SawPuzzleMgr.config.type=="2" then
        self.root.localScale=Vector3.one;
        return;
    end
    local tarScale=dir>0 and 1.0 or 0.8;
    if not isAnimation then
        self.root.localScale=Vector3.one*tarScale;
        return
    end
    if self.doTween3~=nil then
        self.doTween3:Kill();
    end
    self.doTween3=self.root:DOScale(tarScale,0.3);
    self.doTween3.onComplete=function()
        self.root.localScale=Vector3.one*tarScale
    end;
end

function SawPuzzle_PuzzleItem:DORotate()
    if UnityEngine.Time.realtimeSinceStartup-self.lastTime<SawPuzzleMgr.clickInterval then
        return
    end
    self.lastTime=UnityEngine.Time.realtimeSinceStartup;
    local angle=self.data.data.angleZ-90;
    self:SetAngle(angle)
    SawPuzzleMgr.CheckGroupRotate(self,-90);
    SawPuzzleMgr.PuzzleOnPointUp(true,self.data.data.loc_x,self.data.data.loc_y)
end

function SawPuzzle_PuzzleItem:SetAngle(angleZ)
    self.data.data.angleZ=angleZ%360;
    self.root.localRotation=Quaternion.Euler(0,0,self.data.data.angleZ)
end

function SawPuzzle_PuzzleItem:RotateByGroup(pos,angleZ)
    local angle=self.data.data.angleZ+angleZ;
    self:SetAngle(angle)
    self.transform.anchoredPosition=Vector2(pos.x,pos.y);
end

function SawPuzzle_PuzzleItem:UpdateInit_Pos(pos,isAnimation)
    if not isAnimation then
        self.transform.anchoredPosition=pos;
        return;
    end
    if self.doTween2~=nil then
        self.doTween2:Kill();
    end
    self.doTween2=self.transform:DOLocalMove(Vector3(pos.x,pos.y,0),0.2);
    self.doTween2:SetEase(Ease.OutSine);
    self.doTween2.onComplete=function()
        self.transform.anchoredPosition=pos;
    end
end


function SawPuzzle_PuzzleItem:DOLocalMove(pos,callBack)
    if self.doTween4~=nil then
        self.doTween4:Kill();
    end
    self.doTween4=self.transform:DOLocalMove(pos,0.5);
    self.doTween4:SetEase(Ease.OutSine);
    self.doTween4.onComplete=function()
        if callBack~=nil then
            callBack();
        end
    end
end

function SawPuzzle_PuzzleItem:OnBeginDragHandler(beginPosition)
    local locPos=LuaMgr.Screen2Local(beginPosition, SawPuzzleMgr.tfRect);
    local selfPos=LuaMgr.World2Local(self.transform.position,SawPuzzleMgr.tfRect)
    if  self.data.data.isInit then
        self.data.data.isInit=false;
    end
    self.transform.parent=SawPuzzleMgr.tfRect;
    self.transform.anchoredPosition=selfPos;
    self.vector=self.transform.anchoredPosition-locPos;
    self:SetAreaOff();
end



function SawPuzzle_PuzzleItem:OnDragHandler(dragPosition)
    local dragPos=LuaMgr.Screen2Local(dragPosition, SawPuzzleMgr.tfRect);
    self.transform.anchoredPosition=dragPos+self.vector;
    self:CheckEdge();
end


function SawPuzzle_PuzzleItem:OnPointerUpHandler(nearPos,isFix,isRotate)
    local selfPos=self.transform.anchoredPosition;
    local area_X=selfPos.x;
    local area_y=selfPos.y;
    if not isRotate then
        if selfPos.x-self.left<0 then
            area_X=self.left;
        end
        if selfPos.x>SawPuzzleMgr.tfArea.sizeDelta.x-SawPuzzleMgr.itemSizeX-self.right then
            area_X=SawPuzzleMgr.tfArea.sizeDelta.x-SawPuzzleMgr.itemSizeX-self.right;
        end
        if selfPos.y+self.up>0 then
            area_y=-self.up;
        end
        if selfPos.y<-SawPuzzleMgr.tfArea.sizeDelta.y+SawPuzzleMgr.itemSizeY+self.down then
            area_y=-SawPuzzleMgr.tfArea.sizeDelta.y+SawPuzzleMgr.itemSizeY+self.down;
        end
    end
    local areaPos=Vector2(area_X,area_y);
    if nearPos~=nil then
        areaPos=nearPos;
    end
    if isFix then
        self.transform:SetAsFirstSibling();
    end
    if UnityEngine.Vector2.Distance(selfPos,areaPos)>0.1 then
        if self.doTween~=nil then
            self.doTween:Kill();
        end
        self.doTween=self.transform:DOLocalMove(Vector3(areaPos.x,areaPos.y,0),0.2);
        self.doTween:SetEase(Ease.OutSine);
        self.doTween.onComplete=function()
            SawPuzzleMgr.CheckPuzzleWin(self);
        end
    else
        SawPuzzleMgr.CheckPuzzleWin(self);
    end
end



function SawPuzzle_PuzzleItem:SetAreaOff()
    self.left=0;
    self.right=0;
    self.up=0;
    self.down=0;
    if IsNullOrEmpty(self.data.data.groupId) then
        return;
    end
    local groupList={}
    for i,v in ipairs(SawPuzzleMgr.puzzleUIList.itemList) do
        if v.data.data.groupId==self.data.data.groupId then
            table.insert(groupList,v);
        end
    end
    if #groupList==1 then
        return;
    end
    self.left=self.transform.anchoredPosition.x;
    self.right=self.transform.anchoredPosition.x;
    self.up=self.transform.anchoredPosition.y;
    self.down=self.transform.anchoredPosition.y;
    if #groupList>1 then
        for i,v in ipairs(groupList) do
            local vRectPos=v.transform.anchoredPosition
            if v.transform.parent~=SawPuzzleMgr.tfRect then
                local selfPos=LuaMgr.World2Local(v.transform.position,SawPuzzleMgr.tfRect)
                vRectPos=selfPos;
            end
            if self.left>vRectPos.x then
                self.left=vRectPos.x;
            end
            if self.right<vRectPos.x then
                self.right=vRectPos.x;
            end
            if self.up<vRectPos.y then
                self.up=vRectPos.y
            end
            if self.down>vRectPos.y then
                self.down=vRectPos.y
            end
        end
    end
    self.left=(self.transform.anchoredPosition.x-self.left)
    self.right=(self.right-self.transform.anchoredPosition.x)
    self.up=(self.up-self.transform.anchoredPosition.y)
    self.down=(self.transform.anchoredPosition.y-self.down)
end

function SawPuzzle_PuzzleItem:CheckEdge()
    if self.transform.anchoredPosition.x-self.left<0 then
        self.transform.anchoredPosition=Vector2(self.left,self.transform.anchoredPosition.y);
    end
    if self.transform.anchoredPosition.x+self.right>SawPuzzleMgr.tfRect.sizeDelta.x-SawPuzzleMgr.itemSizeX then
        self.transform.anchoredPosition=Vector2(SawPuzzleMgr.tfRect.sizeDelta.x-SawPuzzleMgr.itemSizeX-self.right,self.transform.anchoredPosition.y);
    end
    if self.transform.anchoredPosition.y+self.up>0 then
        self.transform.anchoredPosition=Vector2(self.transform.anchoredPosition.x,-self.up);
    end
    if self.transform.anchoredPosition.y-self.down<-SawPuzzleMgr.tfRect.sizeDelta.y+SawPuzzleMgr.itemSizeY then
        self.transform.anchoredPosition=Vector2(self.transform.anchoredPosition.x,-SawPuzzleMgr.tfRect.sizeDelta.y+SawPuzzleMgr.itemSizeY+self.down);
    end
end


function SawPuzzle_PuzzleItem:Clear()
    self.data=nil
    self.doTween=nil
    self.doTween2=nil;
end


function SawPuzzle_PuzzleItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.offSet=nil;
    self.raw=nil;
    self.animator=nil;
    self.rawMask=nil;
end

