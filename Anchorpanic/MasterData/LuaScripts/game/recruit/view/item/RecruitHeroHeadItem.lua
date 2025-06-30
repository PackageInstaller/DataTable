--[[ 
-----------------------------------------------------
@Author         : Shenxintian
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('recruit.RecruitHeroHeadItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("recruit/item/RecruitHeroHeadItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
end

function setData(self, cusParent, vo)
    self.heroTid = vo.tid
    self:setParentTrans(cusParent)
    self.mImgIcon:SetImg(UrlManager:getHeroHeadUrl(vo.tid), false)
    self.mTxtName.text = vo.name
    self.mImgBg:SetImg(UrlManager:getHeroColorIconUrl_1(vo.color),false)
end
-- 初始化
function configUI(self)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mGroupClick = self:getChildGO("mGroupClick")
    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mGroupClick, self.onClickHead)
end

function onClickHead(self)
    GameDispatcher:dispatchEvent(EventName.SHOW_SINGLE_HERO_INFO, { heroTid = self.heroTid })
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
