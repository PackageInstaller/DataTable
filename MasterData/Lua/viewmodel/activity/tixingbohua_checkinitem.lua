TiXingBoHua_CheckInItem = {};

TiXingBoHua_CheckInItem.__index = TiXingBoHua_CheckInItem;

local objs = {
    iconSprite={path="offSet/icon",type="Image"},
    iconMaskSprite={path="offSet/iconMask",type="Image"},
    btnIcon={path="offSet/icon",type="Button"},
    goCur={path="offSet/cur",type="GameObject"},
    goPass={path="offSet/pass",type="GameObject"},
    goLock={path="offSet/lock",type="GameObject"},
    rewardTf={path="offSet/reward",type="Transform"},
    dayText={path="offSet/Text",type="Text"},
    offTf={path="offSet",type="Transform"},
    goNor={path="offSet/reward/nor",type="GameObject"},
    goSpe={path="offSet/reward/spe",type="GameObject"},
   
}
function TiXingBoHua_CheckInItem.New()
    local self = {};
    setmetatable(self, TiXingBoHua_CheckInItem);
    return self;
end

function TiXingBoHua_CheckInItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnIcon,function()
        if self.data~=nil and self.data.callBack~=nil  then
            self.data.callBack(self.data.index);
        end
    end)
end





function TiXingBoHua_CheckInItem:SetData(pdata)
    self.data=pdata.data
    self.iconSprite.sprite=LuaMgr.GetSprite("TiXingBoHua","ui_hd_qd_t_x_"..self.data.index);
    self.iconMaskSprite.sprite=LuaMgr.GetSprite("TiXingBoHua","ui_hd_qd_t_x_"..self.data.index.."_2");
    self.dayText.text=string.format(ConfigMgr.LangGlobal("15714"),self.data.index);
    SetActive(self.iconMaskSprite.gameObject,self.data.checkInState~=2);
    SetActive(self.goPass,self.data.checkInState==3);
    SetActive(self.goLock,self.data.checkInState==1);
    SetActive(self.goNor,self.data.index~=7);
    SetActive(self.goSpe,self.data.index==7)
    if self.item==nil then
        self.item=GoodsDataItem.New(self.rewardTf)
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.showReward.id]
    itemConfig["count0"] = self.data.showReward.count
    self.item:SetData(1,itemConfig,1,false,Vector3.one*0.7,false)
    self:SelectState(false)

end

function TiXingBoHua_CheckInItem:SelectState(isOn)
    self.offTf.anchoredPosition=isOn and Vector2(0,20) or Vector2(0,0);
    SetActive(self.goCur,isOn);
end



function TiXingBoHua_CheckInItem:Clear()
    self.data=nil
end
function TiXingBoHua_CheckInItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.iconSprite=nil;
    self.iconMaskSprite=nil;
    self.btnIcon=nil;
    self.goCur=nil;
    self.goPass=nil;
    self.goLock=nil;
    self.rewardTf=nil;
    self.dayText=nil;
    self.offTf=nil;
    self.goSpe=nil;
    self.goNor=nil;
end

