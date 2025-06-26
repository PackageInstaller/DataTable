module("decorate.DecorateBaseItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.m_goBg = self:getChildGO("ImgBg")
    self.m_goCur = self:getChildGO("ImgCur")

    self.m_goUse = self:getChildGO("ImgUse")
    self.m_texUse = self:getChildGO("TextUse"):GetComponent(ty.Text)
    self.m_texUse.text = _TT(25197)

    self.m_showNode = self:getChildTrans("ShowNode")
    self.m_imgShow = self:getChildTrans("ImgShow"):GetComponent(ty.AutoRefImage)

    self.m_goSelect = self:getChildGO("ImgSelect")
    self.m_goMask = self:getChildGO("ImgMask")
    self.m_goNew = self:getChildGO("ImgNew")

    self.m_goToucher = self:getChildGO("ImgToucher")
end

function setData(self, param)
    super.setData(self, param)
    self:addOnClick(self.m_goToucher, self.__onClickHandler)
end

-- 设置普通选中状态
function setSelect(self, isSelect)
    if (isSelect) then
        self.m_goSelect:SetActive(true)
    else
        self.m_goSelect:SetActive(false)
    end
end

-- 设置遮罩状态
function setMask(self, isMask)
    if (isMask) then
        self.m_goMask:SetActive(true)
    else
        self.m_goMask:SetActive(false)
    end
end

-- 设置新获得状态
function setNew(self, isNew)
    if (isNew) then
        self.m_goNew:SetActive(true)
    else
        self.m_goNew:SetActive(false)
    end
end

-- 设置使用中状态
function setUse(self, isUse)
    if (isUse) then
        self.m_goCur:SetActive(true)
        self.m_goUse:SetActive(true)
    else
        self.m_goCur:SetActive(false)
        self.m_goUse:SetActive(false)
    end
end

function __onClickHandler(self, args)
    local tabType = self.data:getDataVo().tabType
    local dataRo = self.data:getDataVo().configVo
    GameDispatcher:dispatchEvent(EventName.DECORATE_ITEM_SELECT, {tabType = tabType, id = dataRo:getRefID()})
end

function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.m_goToucher)
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(25197):	"使用中"
]]
