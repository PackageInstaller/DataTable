XueJingHanLin_CheckInItem = {};

XueJingHanLin_CheckInItem.__index = XueJingHanLin_CheckInItem;

local objs = {
    iconSprite={path="Icon",type="Image"},
    goCur={path="cur",type="GameObject"},
    goPass={path="pass",type="GameObject"},
    btnIcon={path="Icon",type="Button"},

   
}
function XueJingHanLin_CheckInItem.New()
    local self = {};
    setmetatable(self, XueJingHanLin_CheckInItem);
    return self;
end

function XueJingHanLin_CheckInItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnIcon,function()
        if self.data~=nil and self.data.callBack~=nil  then
            self.data.callBack(self.data.index);
        end
    end)
end





function XueJingHanLin_CheckInItem:SetData(pdata)
    self.data=pdata.data
    self.transform.anchoredPosition=self.data.pos;
    local iconName=""
    if self.data.checkInState==1 then
        iconName=string.format("ui_hd_xlhy_tb%s",self.data.index)
    else
        iconName=string.format("ui_hd_xlhy_tb%s_2",self.data.index)
    end
    self.iconSprite.sprite=LuaMgr.GetSprite("XueJingHanLin",iconName)
    SetActive(self.goCur,self.data.checkInState==2)
    SetActive(self.goPass,self.data.checkInState==3)

   
end

function XueJingHanLin_CheckInItem:Clear()
    self.data=nil
end
function XueJingHanLin_CheckInItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.iconSprite=nil
    self.btnIcon=nil
    self.goCur=nil
    self.goPass=nil
end

