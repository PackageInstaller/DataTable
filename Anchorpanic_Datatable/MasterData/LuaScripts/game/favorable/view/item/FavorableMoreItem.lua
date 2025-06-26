module("favorable.FavorableMoreItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mLvBgImg = self:getChildGO("LvBg"):GetComponent(ty.Image)
    self.mInfoTxt = self:getChildGO("InfoTxt"):GetComponent(ty.Text)
    self.mLvLockTxt = self:getChildGO("LvLockTxt"):GetComponent(ty.Text)
    self.mIconImg = self:getChildGO("IconImg"):GetComponent(ty.AutoRefImage)
end

function setData(self, data)
    super.setData(self, data)
    self.mInfoTxt.text = _TT(data.des)

    self.mIconImg:SetImg(UrlManager:getPackPath(data.icon),false)
    if data.favorableLevel > data.cusLv then
        self.mLvLockTxt.text = _TT(41719,data.favorableLevel) --"亲密度:" .. data.favorableLevel .. "级解锁"
        self.mLvBgImg.color =  gs.ColorUtil.GetColor("a9a9a9FF")
    else
        self.mLvLockTxt.text = _TT(41712) --"已解锁"
        self.mLvBgImg.color =  gs.ColorUtil.GetColor("0059e1FF")
    end

    LoopManager:addFrame(5,1,self,self.__onUpdateSize)
end

function __onUpdateSize(self)
    gs.GoUtil.UpdateSize(self.mLvBgImg.gameObject)
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
