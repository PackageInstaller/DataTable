SawPuzzle_RawItem = {};

SawPuzzle_RawItem.__index = SawPuzzle_RawItem;

local objs = {
    btnIcon={path="group/btn",type="Button"},
    iconSprite={path="group/icon",type="Image"},
    goNew={path="group/new",type="GameObject"},
    goLock={path="group/lock",type="GameObject"},
    goDone={path="group/done",type="GameObject"},
    goPro={path="group/pro",type="GameObject"},
    proText={path="group/pro/proText",type="Text"},
    goTimer={path="group/time",type="GameObject"},
}



function SawPuzzle_RawItem.New()
    local self = {};
    setmetatable(self, SawPuzzle_RawItem);
    return self;
end


function SawPuzzle_RawItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnIcon,function()
        if self.data.callback~=nil then
            self.data.callback(self.data.index);
        end
    end);
end





function SawPuzzle_RawItem:SetData(pdata)
    self.data=pdata.data
    self.iconSprite.sprite=self.data.unlock and LuaMgr.GetSprite("SawPuzzle",self.data.picName)
                           or LuaMgr.GetSprite("SawPuzzle",self.data.picName.."suo")
    SetActive(self.goNew,self.data.unlock and not self.data.isPass and not self.data.isRecord)
    SetActive(self.goDone, self.data.isPass);
    SetActive(self.goTimer,self.data.isTime)
    if IsNullOrEmpty(self.data.fixedPro) then
        SetActive(self.goPro,false)
    else
        SetActive(self.goPro,true)
        self.proText.text=self.data.fixedPro;
    end
end


function SawPuzzle_RawItem:SetScale(isOn)
    self.transform.localScale=isOn and Vector3.one or Vector3.one*0.76;
end

function SawPuzzle_RawItem:Clear()
    self.data=nil
    
end


function SawPuzzle_RawItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.iconSprite=nil;
    self.goNew=nil;
    self.goLock=nil;
    self.goDone=nil;
    self.goPro=nil;
    self.proText=nil;
    self.goTimer=nil;
end

