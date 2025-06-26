--[[ 
-----------------------------------------------------
@filename       : ManualHeroItem
@Description    : 图鉴-战员
@date           : 2023-3-27 16:37:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualHeroItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mNewTans = self:getChildGO("mNewTans")
    self.mImgUnlock = self:getChildGO("mImgUnlock")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mImgHead = self:getChildGO("mImgHead"):GetComponent(ty.AutoRefImage)
end

function setData(self, param)
    super.setData(self, param)
    self.mTxtName.text = self.data.name
    self.mImgHead:SetImg(self.data:getHeroImg(), true)
    self.mImgUnlock:SetActive(self.data:getIsUnlock() == false)
    self.mNewTans:SetActive(self.data:getIsNew())
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.UIObject, self.onClickHandler)
end

function onClickHandler(self)
    --if self.data:getIsUnlock() then
    local heroId = hero.HeroManager:getHeroIdByTid(self.data.tid)
    if self.data:getIsNew() then
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.MANUAL_HERO, id = self.data.tid })
    end
    if not self.data:getIsUnlock() then
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_RECRUITINFOPANEL, { heroTid = self.data.tid })
    else
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DETAILS_PANEL, { heroId = heroId, heroTid = self.data.tid, isShowFashion = false, onClickFun = function(tid)
            if read.ReadManager:isModuleRead(ReadConst.MANUAL_HERO, tid) then
                GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.MANUAL_HERO, id = tid })
            end
        end })
    end
    --else
    --    gs.Message.Show(_TT(80019))--获得战员后解锁
    --end
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