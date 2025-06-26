--[[ 
-----------------------------------------------------
@filename       : ManualItem
@Description    : 图鉴
@date           : 2022-2-22 10:25:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mTextTitle = self:getChildGO("mTextTitle"):GetComponent(ty.Text)
    self.mBtnEnter = self:getChildGO("mBtnEnter")

    self:addOnClick(self.mBtnEnter, self.__onClickEnterHandler)
end

function setData(self, param)
    super.setData(self, param)

    local type = self.data
    if (type == manual.ManualType.Hero) then
        self.mImgBg:SetImg(UrlManager:getBgPath("manual/manual_hero_bg.png"))
        self.mTextTitle.text = _TT(70086)
    elseif (type == manual.ManualType.Monster) then
        self.mImgBg:SetImg(UrlManager:getBgPath("manual/manual_monster_bg.png"))
        self.mTextTitle.text = _TT(70087)
    end
end

function __onClickEnterHandler(self, args)
    GameDispatcher:dispatchEvent(EventName.OPEN_MANUAL_PANEL, { type = self.data, subType = 1 })
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(70086):	"战员档案"
	语言包: _TT(70087):	"怪物档案"
]]