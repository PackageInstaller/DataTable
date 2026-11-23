Refraction_PointItem = {};

Refraction_PointItem.__index = Refraction_PointItem;

local objs = {
    grayObj={path="root/gray",type="GameObject"},
    activeObj={path="root/active",type="GameObject"},
    imgActive={path="root/active",type="Image"},
    imgActive_under={path="root/active/active_under",type="Image"},
    animator={path="",type="Animator"},
}

function Refraction_PointItem.New()
    local self = {};
    setmetatable(self, Refraction_PointItem);
    return self;
end


function Refraction_PointItem:Init()
    UITool.Parse(self.gameObject, self, objs);
  
end

function Refraction_PointItem:SetData(pdata)
    self.data=pdata.data
    self.imgActive.sprite=LuaMgr.GetSprite("Refraction",self.data.spriteName);
    self.imgActive_under.sprite=LuaMgr.GetSprite("Refraction",self.data.spriteName.."-1");
    self.transform.anchoredPosition=self.data.pos
    self.gameObject.name="point_"..self.data.index
    self:SetActive(false);
end

function Refraction_PointItem:SetActive(isOn)
    if not self.activeObj.activeInHierarchy and isOn then
        self.animator:Play("ani_RefractionGamePanel_pointItem_born",0,0);
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "DH/DH_YP_10.mp3");
    end
    SetActive(self.grayObj,not isOn)
    SetActive(self.activeObj,isOn)
end


function Refraction_PointItem:Clear()
    self.data=nil
    
end


function Refraction_PointItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
   
end

