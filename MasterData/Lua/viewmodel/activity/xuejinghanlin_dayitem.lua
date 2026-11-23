XueJingHanLin_DayItem = {};

XueJingHanLin_DayItem.__index = XueJingHanLin_DayItem;

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
    red={path="offSet/red",type="GameObject"},

}
function XueJingHanLin_DayItem.New()
    local self = {};
    setmetatable(self, XueJingHanLin_DayItem);
    return self;
end

function XueJingHanLin_DayItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnIcon,function()
        if self.data~=nil and self.data.callBack~=nil  then
            self.data.callBack(self.data.index);
        end
    end)
end





function XueJingHanLin_DayItem:SetData(pdata)
    self.data=pdata.data
    self.iconSprite.sprite=LuaMgr.GetSprite("XueJingHanLin","ui_hd_xlhy_t_"..self.data.index);
    self.iconMaskSprite.sprite=LuaMgr.GetSprite("XueJingHanLin","ui_hd_xlhy_t_"..self.data.index.."_2");
    self.dayText.text=string.format(ConfigMgr.LangGlobal("15714"),self.data.index);
    SetActive(self.iconMaskSprite.gameObject,self.data.checkInState~=2);
    SetActive(self.goPass,self.data.checkInState==3);
    SetActive(self.goLock,self.data.checkInState==1);
    SetActive(self.red,self.data.checkInState==2);
    if self.item==nil then
        self.item=GoodsDataItem.New(self.rewardTf)
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.showReward.id]
    itemConfig["count0"] = self.data.showReward.count
    self.item:SetData(1,itemConfig,1,false,Vector3.one*0.7,false)
    self:SelectState(false)

end

function XueJingHanLin_DayItem:SelectState(isOn)
    self.offTf.anchoredPosition=isOn and Vector2(0,20) or Vector2(0,0);
    SetActive(self.goCur,isOn);
end



function XueJingHanLin_DayItem:Clear()
    self.data=nil
end
function XueJingHanLin_DayItem:Destroy()
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
    self.red=nil;
end