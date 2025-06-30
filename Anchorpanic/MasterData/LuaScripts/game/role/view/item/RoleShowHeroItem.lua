--[[
-----------------------------------------------------
@filename       : RoleShowHeroItem
@Description    : 个人主页角色展示item
@date           : 2020-10-27 17:10:21
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.role.view.RoleShowHeroItem', Class.impl("lib.component.BaseContainer"))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("role/item/RoleShowHeroItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构
function dtor(self)
end

function initData(self)
    self.pos = nil
    self.thisObject = nil
    self.callBack = nil
    self.callBackParam = nil
    self.isPreview = nil
    self.heroVo = nil
end

-- 初始化
function configUI(self)
    self.mGroup = self:getChildGO("mGroup")
    self.mGroupHero = self:getChildTrans("mGroupHero")
    self.mImgEmptyAdd = self:getChildGO("ImgEmptyAdd")
    self.mImgEmptyPreview = self:getChildGO("ImgEmptyNone")
    self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)
    self:addOnClick(self.mGroup, self.onClickAddGridHandler)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.mGroup, self.onClickAddGridHandler)
end

function setData(self, cusHeroVo)
    self.heroVo = cusHeroVo
    self.mTxtNum.text = string.format("%02d", self.pos)
    if (self.heroVo) then
        self.mImgEmptyAdd:SetActive(false)
        self.mImgEmptyPreview:SetActive(false)
        if (not self.mHeroHeadGrid) then
            self.mHeroHeadGrid = HeroHeadGrid:poolGet()
        end
        self.mHeroHeadGrid:setData(self.heroVo)
        self.mHeroHeadGrid:setType(true)
        self.mHeroHeadGrid:setScale(1)
        self.mHeroHeadGrid:setParent(self.mGroupHero)
        self.mHeroHeadGrid:setCallBack(self, self.onClickAddGridHandler)
        self.mHeroHeadGrid:setRes(true)
    else
        self:resetState()
    end
end

function setBaseData(self, cusPos, cusIsPreview, cusThisObject, cusCallBack, cusCallBackParams)
    self.pos = cusPos
    self.isPreview = cusIsPreview
    self.thisObject = cusThisObject
    self.callBack = cusCallBack
    self.callBackParam = cusCallBackParams
end

function onClickAddGridHandler(self)
    if self.callBack then
        self.callBack(self.thisObject, self.callBackParam)
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_SELECT_HERO_PANEL, {})
end

function resetState(self)
    self.heroVo = nil
    if self.mHeroHeadGrid then
        self.mHeroHeadGrid:poolRecover()
        self.mHeroHeadGrid = nil
    end
    if self.isPreview then
        self.mImgEmptyAdd:SetActive(false)
        self.mImgEmptyPreview:SetActive(true)
    else
        self.mImgEmptyAdd:SetActive(true)
        self.mImgEmptyPreview:SetActive(false)
    end
end

function getPos(self)
    return self.pos
end

function getData(self)
    return self.heroVo
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
