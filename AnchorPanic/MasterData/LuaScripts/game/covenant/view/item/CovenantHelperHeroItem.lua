module('covenant.CovenantHelperHeroItem', Class.impl("lib.component.BaseContainer"))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("covenant/CovenantHelperHeroItem.prefab")

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
    self:addOnClick(self.mGroup, self.__onClickAddGridHandler)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.mGroup, self.__onClickAddGridHandler)
end

function setData(self, cusHeroVo)
    self.heroVo = cusHeroVo
    self.mTxtNum.text = string.format("%02d", self.pos)
    if(self.heroVo)then
        self.mImgEmptyAdd:SetActive(false)
        self.mImgEmptyPreview:SetActive(false)
        
        if (not self.m_heroCard) then
            self.m_heroCard = hero.HeroCard:poolGet()
        end
        self.m_heroCard:setData(self.heroVo)
        self.m_heroCard:setStarLvl(self.heroVo.evolutionLvl)
        self.m_heroCard:setParent(self.mGroupHero)
        self.m_heroCard:setCallBack(self, self.__onClickAddGridHandler)
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

function __onClickAddGridHandler(self)
    if self.callBack then
        self.callBack(self.thisObject, self.callBackParam)
    end
    -- GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_SELECT_HERO_PANEL, {})
end

function resetState(self)
    self.heroVo = nil
    if self.m_heroCard then
        self.m_heroCard:poolRecover()
        self.m_heroCard = nil
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
