QianLiJiangShan_CheckInItem = {};

QianLiJiangShan_CheckInItem.__index = QianLiJiangShan_CheckInItem;

local objs = {
    iconSprite={path="Icon",type="Image"},
    goCur={path="cur",type="GameObject"},
    goPass={path="pass",type="GameObject"},
    btnIcon={path="Icon",type="Button"},
    goFx={path="fx",type="GameObject"},
   
}
function QianLiJiangShan_CheckInItem.New()
    local self = {};
    setmetatable(self, QianLiJiangShan_CheckInItem);
    return self;
end

function QianLiJiangShan_CheckInItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnIcon,function()
        if self.data~=nil and self.data.callBack~=nil  then
            self.data.callBack(self.data.index);
        end
    end)
end





function QianLiJiangShan_CheckInItem:SetData(pdata)
    self.data=pdata.data
    self.transform.anchoredPosition=self.data.pos;
    local iconName=""
    if self.data.checkInState==1 then
        iconName=string.format("ui_hd_zcql_tb%s",self.data.index)
    else
        iconName=string.format("ui_hd_zcql_tb%s_2",self.data.index)
    end
    self.iconSprite.sprite=LuaMgr.GetSprite("QianLiJiangShan",iconName)
    SetActive(self.goCur,self.data.checkInState==2)
    SetActive(self.goPass,self.data.checkInState==3)
    SetActive(self.goFx,self.data.checkInState==2)
   
end

function QianLiJiangShan_CheckInItem:Clear()
    self.data=nil
end
function QianLiJiangShan_CheckInItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.iconSprite=nil
    self.btnIcon=nil
    self.goCur=nil
    self.goPass=nil
end

