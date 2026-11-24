
Block_RawItem = {};

Block_RawItem.__index = Block_RawItem;
local objs = {
    rawDecorate = { path = "", type = "RawImage" },
    goBlockName = { path = "goBlockName", type = "GameObject" },
    blockName = { path = "goBlockName/Text", type = "Text" },
    goFX={ path = "Eff_flash", type = "GameObject" },
};

function Block_RawItem.New()
    local self = {};
    setmetatable(self, Block_RawItem);
    return self;
end

function Block_RawItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function Block_RawItem:SetData(data)
    self.data=data.data;







    self.bindGridLocalPosition=SeasonSLGMapMgr.GetBlockPositionByIndex(self.data.bindGridIndex, true)
    local path=Path.Image.."SeasonSLGDecorate/"..self.data.rawName..".png";
    local tex=LuaMgr.GetTexture(path);
    if tex==nil then
        LuaDebug.error(path);
    end
    SetActive(self.goFX,self.data.isFX);
    self.rawDecorate.texture=tex;
    if tex~=nil then
        self.rawDecorate.transform.sizeDelta=Vector2(tex.width,tex.height)
    end
    self.vector=self.data.pos-self.bindGridLocalPosition


    SetActive(self.goBlockName,false)
    local config = SeasonSLGMapMgr.gridMap[tostring(self.data.bindGridIndex)]
    if config ~= nil then
        if (#config.EventList > 0 and config.EventList[1][1] == "9") or (#config.Function > 0 and config.Function[1] == "9") then
            SetActive(self.goBlockName,true)
            self.blockName.text = SeasonSLGMapMgr.GetGridName(tostring(self.data.bindGridIndex))
        end
    end
end

function Block_RawItem:DOScale()
    local gridNowPosition=SeasonSLGMapMgr.GetBlockPositionByIndex(self.data.bindGridIndex)
    local scale=SeasonSLGMapMgr.gridScale;
    self.transform.localScale=Vector3.one*scale;
    self.transform.anchoredPosition=gridNowPosition+self.vector*scale;
end

function Block_RawItem:Clear()
    self.data=nil;
end

function Block_RawItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end