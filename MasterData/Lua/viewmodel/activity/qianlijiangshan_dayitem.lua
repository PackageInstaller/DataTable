QianLiJiangShan_DayItem = {};

QianLiJiangShan_DayItem.__index = QianLiJiangShan_DayItem;

local objs = {
    bg={path="bg",type="Transform"},
    goLastDay={path="bg/forward/lastDay",type="GameObject"},
    goodRoot={path="bg/forward/good",type="Transform"},
    goPass={path="bg/forward/pass",type="GameObject"},
    checkIng={path="bg/forward/curDay",type="GameObject"},
    maskColor={path="bg/forward/Mask",type="Image"},
    tagSprite={path="bg/forward/dayTag",type="Image"},
    textDayUnlock={path="bg/forward/dayTag/dayUnlock",type="Text"},
    textDayLock={path="bg/forward/dayTag/dayLock",type="Text"},
    goFx={path="bg/fx",type="GameObject"},
}
function QianLiJiangShan_DayItem.New()
    local self = {};
    setmetatable(self, QianLiJiangShan_DayItem);
    return self;
end

function QianLiJiangShan_DayItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end





function QianLiJiangShan_DayItem:SetData(pdata)
    self.data=pdata.data
    self.bg.localScale=self.data.isLastDay and Vector3.one or Vector3.one*0.84
    SetActive(self.goLastDay,self.data.isLastDay)
    SetActive(self.checkIng,self.data.checkInState==2)
    SetActive(self.goPass,self.data.checkInState==3)
    SetActive(self.textDayUnlock.gameObject,self.data.checkInState>1)
    SetActive(self.textDayLock.gameObject,self.data.checkInState<2)
    self.textDayLock.text=string.format(ConfigMgr.LangGlobal("15714"),self.data.index)
    self.textDayUnlock.text=string.format(ConfigMgr.LangGlobal("15714"),self.data.index)
    if self.data.checkInState<2 then
        self.maskColor.color=UnityEngine.Color(1.0,1.0,1.0,0.33)
        self.tagSprite.sprite=LuaMgr.GetSprite("QianLiJiangShan","ui_hd_zcql_ts1")
    elseif self.data.checkInState==2 then
        self.maskColor.color=UnityEngine.Color(1.0,1.0,1.0,0.0)
        self.tagSprite.sprite=LuaMgr.GetSprite("QianLiJiangShan","ui_hd_zcql_ts3")
    elseif self.data.checkInState==3 then
        self.maskColor.color=UnityEngine.Color(1.0,1.0,1.0,0.66)
        self.tagSprite.sprite=LuaMgr.GetSprite("QianLiJiangShan","ui_hd_zcql_ts2")
    end
    if self.item==nil then
        self.item=GoodsDataItem.New(self.goodRoot)
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.showReward.id]
    itemConfig["count0"] = self.data.showReward.count
    local scale=self.data.isLastDay and 0.72 or 0.65
    self.item:SetData(1,itemConfig,1,false,Vector3.one*scale,false)
    SetActive(self.goFx,self.data.isLastDay and self.data.checkInState<3)
end


function QianLiJiangShan_DayItem:Clear()
    self.data=nil
end
function QianLiJiangShan_DayItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.goLastDay=nil
    self.goodRoot=nil
    self.goPass=nil
    self.maskColor=nil
    self.tagSprite=nil
    self.textDayLock=nil
    self.textDayUnlock=nil
    self.checkIng=nil
    self.goFx=nil;
    self.gameObject = nil;
end

