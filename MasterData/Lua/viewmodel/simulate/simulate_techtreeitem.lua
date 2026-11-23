Simulate_TechTreeItem = {};

Simulate_TechTreeItem.__index = Simulate_TechTreeItem;

local objs = {
    goType1={path="root/type1",type="GameObject"},
    goType2={path="root/type2",type="GameObject"},
    imgType1Bg={path="root/type1/bgState",type="Image"},
    imgType1Icon={path="root/type1/bgState/icon",type="Image"},
    imgType2Bg={path="root/type2/bgState",type="Image"},
    imgType2Icon={path="root/type2/bgState/icon",type="Image"},
    btnClick = {path="root",type="Button"},
    goType1UnLockFX={path="root/type1/bgState/eff_02",type="GameObject"},
    goType2UnLockFX={path="root/type2/bgState/eff_01",type="GameObject"},
}



function Simulate_TechTreeItem.New()
    local self = {};
    setmetatable(self, Simulate_TechTreeItem);
    return self;
end


function Simulate_TechTreeItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnClick,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end








function Simulate_TechTreeItem:SetData(pdata)
    self.data=pdata.data
    self.transform.anchoredPosition=self.data.pos;
    SetActive(self.goType1,self.data.type==0)
    SetActive(self.goType2,self.data.type~=0);
    SetActive(self.goType1UnLockFX,false);
    SetActive(self.goType2UnLockFX,false);
    if self.data.type==0 then
        self.imgType1Bg.sprite=self.data.state>1 and
                LuaMgr.GetSprite("Simulate","ui_hd_rsrh_kjs_zx_js") or LuaMgr.GetSprite("Simulate","ui_hd_rsrh_kjs_zx_wjs")
        self.imgType1Icon.sprite=self.data.state>1 and
                LuaMgr.GetSprite("Simulate",self.data.iconName) or  LuaMgr.GetSprite("Simulate",self.data.iconName.."_wjs");
        if self.data.state==2 then

            self:DelaySetUnLockFX(0)
        elseif self.data.state==3 then

        end
    else
        self.imgType2Bg.sprite=self.data.state>1 and
                LuaMgr.GetSprite("Simulate","ui_hd_rsrh_kjs_sz_js") or LuaMgr.GetSprite("Simulate","ui_hd_rsrh_kjs_sz_wjs")
        self.imgType2Icon.sprite=self.data.state>1 and
                LuaMgr.GetSprite("Simulate",self.data.iconName) or  LuaMgr.GetSprite("Simulate",self.data.iconName.."_wjs");
        if self.data.state==2 then

            self:DelaySetUnLockFX(1)
        elseif self.data.state==3 then

        end
    end
end
    
function Simulate_TechTreeItem:DelaySetUnLockFX(type)
    NumTool.DelayHandler(function()
        if self~=nil and self.goType1UnLockFX~=nil and self.goType2UnLockFX~=nil then
            if type==0 then
                SetActive(self.goType1UnLockFX,true)
            else
                SetActive(self.goType2UnLockFX,true)
            end
        end
    end,0.8)
end

function Simulate_TechTreeItem:Clear()
    self.data=nil
end


function Simulate_TechTreeItem:Destroy()
    self.goType1UnLockFX=nil; 
    self.goType2UnLockFX=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end

